Return-Path: <linux-kernel+bounces-193228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 498558D28AF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 01:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0553F287D61
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 23:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C0C13EFFB;
	Tue, 28 May 2024 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aZn4kx/S"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FF053802
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716938544; cv=none; b=PjWMim+fVn8uCx6eUTCXIwwQp3bWNJUYRjoFMdU7S9e29GAWEZSq/HlRLoWlKNUIe5yLXRR/Nk++7NpQvjBSorXOHvUgrUsImfqbwuYMR59Z+QEGaJQ2Euqi1Ze7fWHB/fUF9JOesfxQxDmTlQRr8PQpAcp6+cIq/FHh1GlrcEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716938544; c=relaxed/simple;
	bh=bfi4+LMwCHwMea1ovFOy2O6UVoaZsvFQiHCHFQXFrk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lb7DivrZ7HvN7kLDmdHaFiXIS/AVRHiOiSOigKDnHk4a39M1wxeVKZztIhg9t5eoSNEwnwx5TNJw5QUQHHSkQohG0+LmSZYLY0Rni92eB+H5XOhd8T6K/nMP2kdIhYlrrO/HycJdYr+RssjGcOeo/IvQ81A/e+nyWmh6fM5LskA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aZn4kx/S; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57883b25b50so1596287a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716938540; x=1717543340; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JiDK4ZNWMQz5BoArs3vVBPa3TrnNYFfX0vRjhOrW4Y4=;
        b=aZn4kx/S5QqSEutnDM7+GLvmrId50NKz+iE4ooI2vSzLcyn/+heznwIww4sPPjbI+e
         K97tIxaACViiuhbaiZZko+aqDkYn4iD6fxHcgn+wFoG1k6z4pxFQ8mHPWXyUMjHtMBOw
         jifzUiVe2FtE45iDTN+eaSIAFh94eSpXjkeLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716938540; x=1717543340;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JiDK4ZNWMQz5BoArs3vVBPa3TrnNYFfX0vRjhOrW4Y4=;
        b=i3ya8Js9B7kwUM+grL3WqNpvwXFFNKCnmKW3/97IfcE6yjvCu1rBh22BL13i2MA2Ct
         9x0pBOKT+LWwIVAXdxmVIB7bNp6fbEHbkDHbcmyveWqjNhNNG60QHPS3d7IfabZTG4kW
         UvoE7wJc4SqbHx/rLiKftYdELDphH3h3hTv2AJy80ZNKMDPjKv84sm+7wDkKZqOQhRU8
         rxGO3UculLGiTEIVEeS6TSi6VR9o9VQBWb1Y2XVk8UceRCo7E4t7Rpvs2f+QCel/Km97
         xiYxy3v1meHC3I4aGmgrinpOaY7I9b1ebqQhBLQ+GHtEJm94sVIYZ7yNBTmcfVqVuyCe
         m1CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOacT2aV95idSCGJ50RcDcrqlvPxrxwz6osPkjsu0FVJltl7rcU0y/pVPUQ8jAUwvQMHLipYzGPAGCHDKvlo6jGkUxy1xICEoMgHsl
X-Gm-Message-State: AOJu0YxwhTR1rry/Tg9+bKxKx7bmxJoRPEWMSCdHRjecpES6CU40CkiS
	7o/DDoqIkX6saMxMx9a8ceh5+DshyrDdkVsG86+cnSDUesx+VD6pvnPlxQjAtNTFDy8L0XSm4AK
	gMnqfZw==
X-Google-Smtp-Source: AGHT+IHlFMrzhMVbrxUEmoGposd38YLC+yy1Fd2wxKAd675pwfBHdJVQhCoy4qhjpcqkHR4t4+pQQA==
X-Received: by 2002:a50:9ea4:0:b0:572:9a52:6696 with SMTP id 4fb4d7f45d1cf-578519506c8mr8728435a12.12.1716938540159;
        Tue, 28 May 2024 16:22:20 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579c7959f73sm4476681a12.33.2024.05.28.16.22.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 16:22:19 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5a7d28555bso155707666b.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 16:22:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU40CZVMU/wsKxSRWi8j97sMJc4jlKTyapH5ZTgwzWqikMX82zCPzd+F669BUICt9AaHV3fflpBe4C/wOiPkkpJn33VFJ12M+BCxWBG
X-Received: by 2002:a17:906:339b:b0:a62:28ce:4e98 with SMTP id
 a640c23a62f3a-a62642e96camr856809166b.23.1716938538230; Tue, 28 May 2024
 16:22:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
 <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com> <87wmnda8mc.ffs@tglx>
In-Reply-To: <87wmnda8mc.ffs@tglx>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 28 May 2024 16:22:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgMoeOTL1V3wTO=o=U1OXn7xF8OWv2hB9NF9Z=G4KotfQ@mail.gmail.com>
Message-ID: <CAHk-=wgMoeOTL1V3wTO=o=U1OXn7xF8OWv2hB9NF9Z=G4KotfQ@mail.gmail.com>
Subject: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@intel.com>, Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com, 
	mat.jonczyk@o2.pl, rdunlap@infradead.org, alexandre.belloni@bootlin.com, 
	mario.limonciello@amd.com, yaolu@kylinos.cn, bhelgaas@google.com, 
	justinstitt@google.com, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, 
	LeoLiu-oc@zhaoxin.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 15:12, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> I principle it applies to any clocksource which needs a spinlock to
> serialize access. HPET is not the only insanity here.

HPET may be the main / only one we care about.

Because:

> Think about i8253 :)

I see the smiley, but yeah, I don't think we really care about it.

>   1) Should we provide a panic mode read callback for clocksources which
>      are affected by this?

The current patch under discussion may be ugly, but looks workable.
Local ugliness isn't necessarily a show-stopper.

So if the HPET is the *only* case which has this situation, I vote for
just doing the ugly thing.

Now, if *other* cases exist, and can't be worked around in similar
ways, then that argues for a more "proper" fix.

And no, I don't think i8253 is a strong enough argument. I don't
actually believe you can realistically find a machine that doesn't
have HPET or the TSC and really falls back on the i8253 any more. And
if you *do* find hw like that, is it SMP-capable? And can you find
somebody who cares?

>   2) Is it correct to claim that a MCE which hits user space and ends up in
>      mce_panic() is still just a regular exception or should we upgrade to
>      NMI class context when we enter mce_panic() or even go as far to
>      upgrade to NMI class context for any panic() invocation?

I do think that an NMI in user space should be considered mostly just
a normal exception. From a kernel perspective, the NMI'ness just
doesn't matter.

That said, I find your suggestion of making 'panic()' just basically
act as an NMI context intriguing. And cleaner than the
atomic_read(&panic_cpu) thing.

Are there any other situations than this odd HPET thing where that
would change semantics?

               Linus

