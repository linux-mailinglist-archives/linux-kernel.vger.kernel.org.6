Return-Path: <linux-kernel+bounces-349255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FFC98F33C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 17:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA842282839
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 15:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3B91A4F3B;
	Thu,  3 Oct 2024 15:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Am9ZW23H"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122DA1A265E
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 15:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727970729; cv=none; b=GXC5fQkbA5kFz3SxzLDPorhq/k+Ys3t4DlXWh9zT0OZqxwKUwuXyuIPHSKefHJUewnZvj8he8hE6e4qQbHP1RpK4wcEQ1zCKGuabSmarE75K0mIvYTWZ6P4VV9Q3CVFSA2hBkRxkPRKaByJqmPBe3yRt0t7sl9//5SJV95h7bGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727970729; c=relaxed/simple;
	bh=R5rdrwIK8Uzh/sQ+IM2Lv+MemaBwurDAhyD5kocYkJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZnnitJWt4XsN1hr7a0VyyPMd8BXzA3X13ZKvyoWncrVBqJKB5WUdtEtf0FeN9daPceZVUnA7IQFUio+Ff644Hks4CJh/uhbUuP5YIADs/6OJy4yWZuTIzJJ09lNGje0Z4r82KegvAb35cbIT89xlaNU3YIkyRIOdutfF7Bt/Pmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Am9ZW23H; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-37cc4e718ecso875231f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727970726; x=1728575526; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBzNppjoku0r7wseF+PbhPszUDrB/uxiwrRiITy3hfY=;
        b=Am9ZW23HkBdVYjxGfFylBtYCQvG8UjM6gcyb/rL24FjDGxFIaMqSMwLmG6iIEsNpBs
         zZGw+pb/StzUq6CDM2xPym9zAwwFv4mDBjom9t024O8vAQ/uC9k4cqipyb1c8Br7bdaO
         k09sdfe4TXzhiV5RUDbktkEoTVwuBh70W14wdtfQfkC7a1jgqXdvFWkpeGi3am6nrbQf
         NI+paVSiatVeXy6eXXbEZVmQb+K8HVA49wbL1yzRMyfvKjK5xYNdEWxmHS5b4bbFkBAb
         JCdkCuyuctew8zlMaisS+u10paiRekD5pFlpsHea+91pr19SI/WcfFFcRvfScKGZUslW
         1DnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727970726; x=1728575526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBzNppjoku0r7wseF+PbhPszUDrB/uxiwrRiITy3hfY=;
        b=mVZiOXKED2NUpKORFuQ1hZ1Im7G6/Chz4cqEUXiYtT2djLFiJDXyIVz1G522G+jSHF
         F2FuT8Q/a/oaoJ6ojkOOZ8YD5HUfuWvaHGwAtfF26pFN4O3iPJaZnxewNPUo4pmUn1r1
         llhrOvRwhspz0yiJQ5PRcjIx2nB6MfLQ0PEyyH8w/gmQfiOjMQ+IgNeuSZ3gi9A3+W7Y
         KEOoxbv61FvVKIuRM0JhC8/8upCDzeCDVMHMPwjXhlf7WHZ7eQ3YNPnK8h9yd7GFlK8K
         dj5x3x1YYzdlVUnxFuriIeM4+ZpoJMxF6S9g+vUFn3RbjfaNbbAPpnwhOGu1cWERuczg
         b4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXaUi3KW8nOTthOySh+fNHgY0mPT9VCTOkDnxdjqBdyCk/Um+Y0kyd169HXpqYV7gam9QtKyhYXLLGV+lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC/pK5UXuQjnmTndjZAB6SKZncH/OnyYdg/V5+AQfXT7A1M5PY
	lPqO78NnDK3yqGb5w/Aj86pxtJPN/JC5rvdc8ghgYRhfaNWBu96fUtrrIaKs5HvRdWmkEOoR69H
	o6ppflWQLca2C0PCGLmgXZt6CMxsdRharDqYy
X-Google-Smtp-Source: AGHT+IGPEhCP23/1eAR/xoiZesp8muQ06ZiL+lHkT4wcjYh5BmgAWPboo+L38mnUbZhHPjyv0/bIj8PqGVc9tATpGig=
X-Received: by 2002:adf:a2d4:0:b0:37c:ca21:bc53 with SMTP id
 ffacd0b85a97d-37cfb9c54a8mr4724671f8f.26.1727970726177; Thu, 03 Oct 2024
 08:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002233409.2857999-1-xur@google.com> <20241002233409.2857999-2-xur@google.com>
 <20241003154143.GW5594@noisy.programming.kicks-ass.net>
In-Reply-To: <20241003154143.GW5594@noisy.programming.kicks-ass.net>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 3 Oct 2024 08:51:51 -0700
Message-ID: <CAKwvOdnS-vyTXHaGm4XiLMtg4rsTuUTJ6ao7Ji-fUobZjdBVLw@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] Add AutoFDO support for Clang build
To: Peter Zijlstra <peterz@infradead.org>
Cc: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>, 
	Sriraman Tallam <tmsriram@google.com>, David Li <davidxl@google.com>, 
	Krzysztof Pszeniczny <kpszeniczny@google.com>, Alice Ryhl <aliceryhl@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
	Bill Wendling <morbo@google.com>, Borislav Petkov <bp@alien8.de>, Breno Leitao <leitao@debian.org>, 
	Brian Gerst <brgerst@gmail.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Heiko Carstens <hca@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, 
	Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Juergen Gross <jgross@suse.com>, Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Masahiro Yamada <masahiroy@kernel.org>, 
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Samuel Holland <samuel.holland@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Wei Yang <richard.weiyang@gmail.com>, 
	workflows@vger.kernel.org, x86@kernel.org, "Xin Li (Intel)" <xin@zytor.com>, 
	Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 8:42=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Wed, Oct 02, 2024 at 04:34:00PM -0700, Rong Xu wrote:
> > +6) Rebuild the kernel using the AutoFDO profile file with the same con=
fig as step 1,
> > +    (Note CONFIG_AUTOFDO_CLANG needs to be enabled):
> > +
> > +      .. code-block:: sh
> > +
> > +         $ make LLVM=3D1 CLANG_AUTOFDO_PROFILE=3D<profile_file
> > +
>
>
> Can this be done without the endless ... code-block nonsense?

Dunno, I think it looks pretty nice once rendered. Makes it
straightforward for a user to copy+paste. I asked Rong explicitly to
make sure the documentation made it so that non-googler or folks not
working on autofdo or propellor could reproduce (since we'll probably
end up standing up CI for these newer configs, and BOLT).
--=20
Thanks,
~Nick Desaulniers

