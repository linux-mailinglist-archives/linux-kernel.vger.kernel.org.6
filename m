Return-Path: <linux-kernel+bounces-372379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A069A47E2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 22:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896231F21BED
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 20:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783020694A;
	Fri, 18 Oct 2024 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNhdPZku"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BE1185B48
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729283131; cv=none; b=AJxQmstzlZJBuCEH6q4jl4/Bf/FZJoHMC3pJy6ldniE3Ca5M6NeRq9WJgTyEMPBwIXs5weGmV7PEMuxpQ5N/kpIyi0Nrb3gbcfbr3p3O41li9Q9xPl7jbde0A94IgrNUSwGz0DEBATisE9AJ56vdDzA1fKk6tMQ8SJY2slXSafE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729283131; c=relaxed/simple;
	bh=qMBJq9CvpR5SHKYMkY9h76rxxQdXBMU4yDU9mUKzsgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WYXDAH1TA/lc2bt4UB+WbqVJrFgLc9i2VsWifp8/SBWo4h9Wi9UGBXLuZl4tXvPa7YzzgC59j6TInNbee3/2rIty4PtQ1hfyLaboRGA0Oi1D46HS0nHe60Tgta0PzIpThm8KYM6XfjEQrB2EQoHySd6sOIGieuREWgT0XNH48cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNhdPZku; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4fd00574so1757116f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729283126; x=1729887926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QAHVI39XorAJ2sHNdw9fdsNt3NLLkABuKEzRhxqlTh0=;
        b=XNhdPZkurLNMJSnIW7WSB83h7qvZz7Z9YPkGVCaFrTr5OLb68HqjQANtz3LRjOgWVE
         viOHzjLsdxrnM311TgQhCHA/QhJrmo03kE8nXRnkC0t2RrwVKaNiY36povgTr+WeItQL
         tyRPlmzViXr++URqA99HlllR8lJ81cuZevE5lsIqctVDHqqmzAP164ttNBA/Gs8idLjJ
         yWjDFhlALdo3475hQxNkalqooI5Rn27Ek1TQFtfgkAfND6r4SfYskfJzlfJILebzxUiC
         NE1FcZy+pxaDJRq/m7bwAegef/UNERIki4qFfHLOMaf/u4QK5UCLqbApKg0RdlTdsN4S
         Bfnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729283126; x=1729887926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QAHVI39XorAJ2sHNdw9fdsNt3NLLkABuKEzRhxqlTh0=;
        b=HGmYpSXAIrsWnO/BgPy/Kd8HmblVwsZ7G2QH3TeW0Gw0nkuoMRIZP9VZSV91BhBhT0
         zNh4xFzBsidnzhNQY0ZY7wvFhk32fVYaXFOdPrUPiGBSxUy0dJAU9rTz+M5wOJ5+BG+1
         9e3Ord00Lrtvsx5EcFXUTvWMqSO2fCIAd5dUqDwAFqi3HNbUql3hyohTT1MAeghy2D0g
         FrXXllXRGXqUeh5/nYBsYPiQ8eM5VJe/q/LKkhe/+RHIe0stOwnujERX6BZrnaPApHYy
         j9V/5Yjj9DtRmjXmTc7VgUDxPgiaUkCBAlHIVD5sf2l1LfL7EALb4A9EmxKrJS7neadh
         kNSA==
X-Forwarded-Encrypted: i=1; AJvYcCX/iVfPhj7xoMyCBfgA0neFpcrKQ/qSgBupNhlwl0UOYtfTzNyciy1jOYpHiBSzwCcCNvHuYGWT0vaPmtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNtKaKHaMZhBGbLpImMbRsh6A+oyR7LXs4BcQgd9ljgj+BPcb
	yfP2cdW3iWijNWuwYoZgTR2dyyA1tPgOSOB9d4aNIcpfKEoc2dERMN6FNDpXYMBR/FvJ8nX818C
	CzhXOW1C85RF8/SjQj4VJQq9ohRU=
X-Google-Smtp-Source: AGHT+IFOjzl+Qa6CZXcGwmyzvM5vj7qm/r8+GjRD/06KBHjxJ4jGAqT6IQWq6Hp1yTrfNxMZP/DnEc9NNj5/0o9c3yk=
X-Received: by 2002:a05:6000:144:b0:374:cd3c:db6d with SMTP id
 ffacd0b85a97d-37d93d43e12mr5419328f8f.6.1729283126217; Fri, 18 Oct 2024
 13:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014161100.18034-1-will@kernel.org> <172898869113.658437.16326042568646594201.b4-ty@kernel.org>
 <ZxIeVabQQS2aISe5@elver.google.com>
In-Reply-To: <ZxIeVabQQS2aISe5@elver.google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Fri, 18 Oct 2024 22:25:15 +0200
Message-ID: <CA+fCnZc4iNa_bxo8mj52Dm8RCKAW=DQ_KUSKK2+OzjmF3T+tRw@mail.gmail.com>
Subject: Re: [PATCH] kasan: Disable Software Tag-Based KASAN with GCC
To: Marco Elver <elver@google.com>
Cc: Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	catalin.marinas@arm.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, ryabinin.a.a@gmail.com, glider@google.com, 
	kasan-dev@googlegroups.com, Mark Rutland <mark.rutland@arm.com>, 
	syzbot+908886656a02769af987@syzkaller.appspotmail.com, 
	Andrew Pinski <pinskia@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 10:37=E2=80=AFAM Marco Elver <elver@google.com> wro=
te:
>
> > Applied to arm64 (for-next/fixes), thanks!
> >
> > [1/1] kasan: Disable Software Tag-Based KASAN with GCC
> >       https://git.kernel.org/arm64/c/7aed6a2c51ff
>
> I do not think this is the right fix. Please see alternative below.
> Please do double-check that the observed splat above is fixed with that.
>
> Thanks,
> -- Marco
>
> ------ >8 ------
>
> From 23bd83dbff5a9778f34831ed292d5e52b4b0ee18 Mon Sep 17 00:00:00 2001
> From: Marco Elver <elver@google.com>
> Date: Fri, 18 Oct 2024 10:18:24 +0200
> Subject: [PATCH] kasan: Fix Software Tag-Based KASAN with GCC
>
> Per [1], -fsanitize=3Dkernel-hwaddress with GCC currently does not disabl=
e
> instrumentation in functions with __attribute__((no_sanitize_address)).
>
> However, __attribute__((no_sanitize("hwaddress"))) does correctly
> disable instrumentation. Use it instead.
>
> Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D117196 [1]
> Link: https://lore.kernel.org/r/000000000000f362e80620e27859@google.com
> Link: https://lore.kernel.org/r/ZvFGwKfoC4yVjN_X@J2N7QTR9R3
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218854
> Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
> Cc: Andrew Pinski <pinskia@gmail.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>  include/linux/compiler-gcc.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
> index f805adaa316e..cd6f9aae311f 100644
> --- a/include/linux/compiler-gcc.h
> +++ b/include/linux/compiler-gcc.h
> @@ -80,7 +80,11 @@
>  #define __noscs __attribute__((__no_sanitize__("shadow-call-stack")))
>  #endif
>
> +#ifdef __SANITIZE_HWADDRESS__
> +#define __no_sanitize_address __attribute__((__no_sanitize__("hwaddress"=
)))
> +#else
>  #define __no_sanitize_address __attribute__((__no_sanitize_address__))
> +#endif
>
>  #if defined(__SANITIZE_THREAD__)
>  #define __no_sanitize_thread __attribute__((__no_sanitize_thread__))
> --
> 2.47.0.rc1.288.g06298d1525-goog

Tested the change, it does fix the boot-time issue #1 from [1], but #2
and #3 still exist.

However, perhaps, just fixing #1 is already good enough to do a revert
of the Will's patch - at least the kernel will boot without
false-positive reports.

But I would keep a note that SW_TAGS doesn't work well with GCC until
[1] is fully resolved.

Thanks!

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D218854

