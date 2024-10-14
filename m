Return-Path: <linux-kernel+bounces-364582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC9C99D67C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89CFB1C23D5B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE0314F115;
	Mon, 14 Oct 2024 18:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwqNzicX"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D45231C95
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728930633; cv=none; b=QyPnixG0E8FWH+rKNhyx92yT1EIJMAwnMuAKHNYSLdc5pP6IVx1GfCXEufgfPjyEvur8R3ud77Rtv7hpSIxv5q/kbvD+bUoI+dOG4EtWzI8uhFLEKCXLfJ+waxc6CXoHLSPi1gRgQB+80Cfrfa3tCvCftLxYriD0kWnq4SI3zjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728930633; c=relaxed/simple;
	bh=GF8HqlLPWDz75e27RDuv+O+fFrP77VrhanZ5CmhSAjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YEWFanbZ8OgH9/TbwPcXDAGOK7xh26wP0Hga5ZTAWmvFiz1chinwSBm1O6od5HfPoaf9j3pJv1yPAgbwy3z7IwtSrOfUUTEQfpMbrB4zrzR02YBg//TlFKHS7MdYF3+nHl+OPio24j/JYEkq7wq1iXZj11zIgW9626R2lhMXUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwqNzicX; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539fbe22ac0so845504e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728930630; x=1729535430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8p/i+4MpEi91Z7jAUbGFY6UVGM+tdrsPn8RyPX05x+Q=;
        b=BwqNzicXUffcIK9ummCykXrKgx0P4EelBR1sDC5U8HIaAh7LdKW1YBxhrXbXmBYyou
         nZkk4CqsjIjn4HrZt+2gB1UqRmCovkPijI8nTkDpR9IxEgFXzl6B/NkjsilNW9wWK9Ha
         AsyMQHyYmJ3uCxsEbVAjm9yy8XoWhr3sqHUiEEjr1hpD4YV1ZLStXEOj4cBdnE+TUFhH
         vPn88Tb1+qBf98Ztqb2MyVrqQJ+QKJsQXO4AX9I2Po+fRWk6dPMdrTEMRfZWJ76DoSrf
         LMU6B/55sdqa89lhYbVMUEPCCYXRVgbJoXB8wbB3kj5DgyrIywgDKNe+DhFV8JjDLT9+
         FLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728930630; x=1729535430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8p/i+4MpEi91Z7jAUbGFY6UVGM+tdrsPn8RyPX05x+Q=;
        b=SX9A9LfNHXqkn1G4flnu8C1Uh4sQZNV+qB6+s0+IYJ/UQNtaad1Tv0WVN+kdi7eXkw
         G/J8yIcP9CKEkm/7fTyaY4CzDBqwMKvQFrEyu7RYsJzOg/Fv+wq5loKroWugVrcr64G1
         wl/8RgE7ZIdWLIJJG6DNQM0rh/goy/aax+0Os+RX30ApHHZ3g3DE4IzSW/kZTMe14rZJ
         h8a997cwKLHylWsPoAY5ypkT/KFk1oz8zNyVMmF6t0EmFnVFoh4hGVe39WTPW6uyWvZF
         lXdEa291FTfag5kf4A73dySEEn4XgEdHV+sSi/lQjJVuarHUKSO1ZjWfV2ZgHFZJ6kCQ
         jGiA==
X-Forwarded-Encrypted: i=1; AJvYcCX9Qqzj+e9qZokub0yTSL4m3WO3B+2mw0Jmr3IxoGsIStsFn1Vn5FKgORz/jrmlOYzWL+WOEnmq+c9fb1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlCAYLkBWN7Qj5CGTGTi/ghkJJr76xse/qsAvFtpnIAvajEJI/
	QPPnAGBLyDYRLOoSFjwbdRN47valrlVH2n5Cs1ms2l3dv+oxdFVOW/PDxKrfkkMzCwtm6uj9UcO
	4Ty0mrMKfdfw0i96/qTD/jAIqaRs=
X-Google-Smtp-Source: AGHT+IFbnagoqrIl6rkJbNjioSSJlxDIXyyeB7/RfC7547SQ8SsyHQ4iamDvoy3EPQs1m8o9vgCm31we8Fq6IeTirFc=
X-Received: by 2002:a05:6512:1393:b0:539:ebe5:298e with SMTP id
 2adb3069b0e04-539ebe52c0fmr2823532e87.59.1728930629680; Mon, 14 Oct 2024
 11:30:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014161100.18034-1-will@kernel.org>
In-Reply-To: <20241014161100.18034-1-will@kernel.org>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 14 Oct 2024 20:30:18 +0200
Message-ID: <CA+fCnZccUHpgAYZ3prRBg5y+481CeUi4EuDPHMGBBE5dyRzPQA@mail.gmail.com>
Subject: Re: [PATCH] kasan: Disable Software Tag-Based KASAN with GCC
To: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ryabinin.a.a@gmail.com, glider@google.com, kasan-dev@googlegroups.com, 
	Mark Rutland <mark.rutland@arm.com>, 
	syzbot+908886656a02769af987@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 6:11=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> Syzbot reports a KASAN failure early during boot on arm64 when building
> with GCC 12.2.0 and using the Software Tag-Based KASAN mode:
>
>   | BUG: KASAN: invalid-access in smp_build_mpidr_hash arch/arm64/kernel/=
setup.c:133 [inline]
>   | BUG: KASAN: invalid-access in setup_arch+0x984/0xd60 arch/arm64/kerne=
l/setup.c:356
>   | Write of size 4 at addr 03ff800086867e00 by task swapper/0
>   | Pointer tag: [03], memory tag: [fe]
>
> Initial triage indicates that the report is a false positive and a
> thorough investigation of the crash by Mark Rutland revealed the root
> cause to be a bug in GCC:
>
>   > When GCC is passed `-fsanitize=3Dhwaddress` or
>   > `-fsanitize=3Dkernel-hwaddress` it ignores
>   > `__attribute__((no_sanitize_address))`, and instruments functions
>   > we require are not instrumented.
>   >
>   > [...]
>   >
>   > All versions [of GCC] I tried were broken, from 11.3.0 to 14.2.0
>   > inclusive.
>   >
>   > I think we have to disable KASAN_SW_TAGS with GCC until this is
>   > fixed
>
> Disable Software Tag-Based KASAN when building with GCC by making
> CC_HAS_KASAN_SW_TAGS depend on !CC_IS_GCC.
>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Reported-by: syzbot+908886656a02769af987@syzkaller.appspotmail.com
> Link: https://lore.kernel.org/r/000000000000f362e80620e27859@google.com
> Link: https://lore.kernel.org/r/ZvFGwKfoC4yVjN_X@J2N7QTR9R3
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D218854
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  lib/Kconfig.kasan | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> While sweeping up pending fixes and open bug reports, I noticed this one
> had slipped through the cracks...
>
> diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
> index 98016e137b7f..233ab2096924 100644
> --- a/lib/Kconfig.kasan
> +++ b/lib/Kconfig.kasan
> @@ -22,8 +22,11 @@ config ARCH_DISABLE_KASAN_INLINE
>  config CC_HAS_KASAN_GENERIC
>         def_bool $(cc-option, -fsanitize=3Dkernel-address)
>
> +# GCC appears to ignore no_sanitize_address when -fsanitize=3Dkernel-hwa=
ddress
> +# is passed. See https://bugzilla.kernel.org/show_bug.cgi?id=3D218854 (a=
nd
> +# the linked LKML thread) for more details.
>  config CC_HAS_KASAN_SW_TAGS
> -       def_bool $(cc-option, -fsanitize=3Dkernel-hwaddress)
> +       def_bool !CC_IS_GCC && $(cc-option, -fsanitize=3Dkernel-hwaddress=
)
>
>  # This option is only required for software KASAN modes.
>  # Old GCC versions do not have proper support for no_sanitize_address.
> @@ -98,7 +101,7 @@ config KASAN_SW_TAGS
>         help
>           Enables Software Tag-Based KASAN.
>
> -         Requires GCC 11+ or Clang.
> +         Requires Clang.
>
>           Supported only on arm64 CPUs and relies on Top Byte Ignore.
>
> --
> 2.47.0.rc1.288.g06298d1525-goog
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

