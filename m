Return-Path: <linux-kernel+bounces-226384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A649913D95
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 20:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA02D1C20D2C
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 18:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6FD1836F6;
	Sun, 23 Jun 2024 18:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IorWMYak"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 037A9181322
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 18:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719167136; cv=none; b=tUckFnQgl+J8SLKIZPjNl5+RGofYcmjOeA0p69YM2C0i7VKU3PwJTRDoapLLRWQsSeBWWZT6t1RSxpSuudft/fGch5hrV27Xb8fFAnqL0Gsy2KPD1M5S/deeL9EJfJdGIqluIkoOLqcqc1i8DB80A4xc3uxzfAo8h64vO7SLeNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719167136; c=relaxed/simple;
	bh=as/miy1ciTXoov1k9v10YWH2KHSzwtS8c+tFIFA2eEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZgvQMzQUM6Ap7C63TkDI2P+k7I5Tb2QucIvMk6479uNjRZ1wWu9NlECTKlnnTmOgnhtvUaPF/fGlrhyN5AfRi5gJUbBRP1x5KkVgdj2ANCqKaqq8HoTFxhF/akQew6Nk/bGfvy8Q/z6H8h2Y+C9WJuRk+QaM1Xg/6+Hoh4rnKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IorWMYak; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ec4eefbaf1so23964571fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 11:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1719167133; x=1719771933; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zPcDcr9W0nDXx9L0w2Y+uq4Fc6p+RIUkLyrf+Mc+Mfs=;
        b=IorWMYak8+Y4n5aKwOe7+QwOlBxGxg1rYJJISgUtBfslih7JvuV/19OiECNm9/OHLh
         MQYfePGCWgn59rO2zv1YEV8Kuvwp+WMYq70d0jJDibvD0StVTfjn1PUJXOSZWwjPg/+o
         mcn65x477fcssbNFIT2V0ityAfymi4U0ezCIg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719167133; x=1719771933;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zPcDcr9W0nDXx9L0w2Y+uq4Fc6p+RIUkLyrf+Mc+Mfs=;
        b=VNFN6UZsoUMv/Yva+vauJgANFu9lSfX1ayZravRf4RaOkUYbP6Ef3IruDUWDGJcgPy
         GRLmbpSeT1udp4I14RLOJ1xSYt9m/CGvgxrB4dFpBAXqRLIUvLpvKJl/Kgcku/kG4ftU
         dag68YrRuVdbCWrYciYUK8PxkrkVgD3bCMGKb8zRtVVd9daBbvJ1McFZnxCYehXCRCs+
         74H+tUqeG75BK8xNMWeF6ZbsogMsbEcjZ5hzW5N7RhHT1vie4q6qMpFCw+Q21fnfDj6D
         7AlY7hziK2UqK3yUD3r7E8rCbQYH/3tT29EapGUHVzsU1i1pk/ZxnjEJ7hvDOwi3LcyR
         bjfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPDiR99bz3ySVp5pejNvv1mJUY1NawXjBPZlxYAL/iRNXvVxmSCYFBSFRf1h4eIP6ldo9ZhVNAeUtihQgm95DhJwbzlzTmxtpxJR5t
X-Gm-Message-State: AOJu0YwoB2uD66w9hbL2paLvHjb9TYamfHcjY9TGr2yyQ4f87hhrjDvq
	ALNvNTp7T3Wp/+mlcnvTkEhQ/FhtQlc8cOvPfb9iwV025kVTfVCBme+rqdlzkKrz18dpy5V9a5g
	8h6UBog==
X-Google-Smtp-Source: AGHT+IFYAma+D2QiBq/u/w+Zt9o5zoYMWC9XL6q6smULrqhLzcFTZ4Sc4dkdaGJ70WOh4WvHCWoD5A==
X-Received: by 2002:a2e:9d88:0:b0:2ec:51fc:2f5a with SMTP id 38308e7fff4ca-2ec5b36b1eamr15479221fa.4.1719167133008;
        Sun, 23 Jun 2024 11:25:33 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3042d509sm3873019a12.43.2024.06.23.11.25.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Jun 2024 11:25:32 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a725282b926so35971366b.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 11:25:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBFfjWu/TGCjwPANYu6k9ogovalSJcZjmkn16C+jO71Dxhg1CsksanHjuKn59j0w39Tkrw8wOvY3+FgzJ8yFYmxg+or14Eiwtvk3wY
X-Received: by 2002:a17:906:c0c7:b0:a6f:e3d1:8b2 with SMTP id
 a640c23a62f3a-a7245c85a3emr178260866b.9.1719167131894; Sun, 23 Jun 2024
 11:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202406230912.F6XFIyA6-lkp@intel.com> <CAFULd4YVOwxQ4JDaOdscX_vtJsqJBJ5zhd0RtXXutW=Eqh29Qw@mail.gmail.com>
 <CAHk-=wg1h4w_m=Op1U4JsyDjsvqG0Kw1EOVMQ+=5GX_XytdorQ@mail.gmail.com>
 <CAFULd4YR-VkAOKiS5yxSUYi0YMzY1p=pkYe4dOkgFs+A=9AFFA@mail.gmail.com>
 <CAHk-=wi_KMO_rJ6OCr8mAWBRg-irziM=T9wxGC+J1VVoQb39gw@mail.gmail.com> <CAFULd4b43=pTnAMKusJmGCeF1Bk-f6AyeOR8wGM8EieqhuH5WQ@mail.gmail.com>
In-Reply-To: <CAFULd4b43=pTnAMKusJmGCeF1Bk-f6AyeOR8wGM8EieqhuH5WQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 23 Jun 2024 14:25:15 -0400
X-Gmail-Original-Message-ID: <CAHk-=wgHa_5u71j=Zx4DceTfjaeL2w1RCPPXbpEEL-xCw-J8ew@mail.gmail.com>
Message-ID: <CAHk-=wgHa_5u71j=Zx4DceTfjaeL2w1RCPPXbpEEL-xCw-J8ew@mail.gmail.com>
Subject: Re: arch/x86/include/asm/cmpxchg_32.h:149:9: error: inline assembly
 requires more registers than available
To: Uros Bizjak <ubizjak@gmail.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 23 Jun 2024 at 14:14, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> I disagree with *I tried to shift the blame to others*! I take full
> responsibility for my patch, and I'm perfectly capable of fixing the
> breakage with an alternative approach.

Ah, good. This is something I'm a bit sensitive about, just because
there's been so many arguments over it over the years, so now I go
into "preemptive nuclear mode" when the regression issue comes up.

Sorry.

> I'm OK with the revert, but it won't fix the underlying problem.
> Please see the definition of __arch_cmpxchg64_emu - it forces the
> address to %esi registers in the same way as __arch_try_cmpxchg64_emu.
> Effectively, the compiler allocates 5 input registers just for the
> instruction.

Oh, I entirely agree that this is a "random compiler implementation"
issue, and then the code around it makes all the difference.

> > Now, from having looked a bit at this, I can point you to the
> > differences introduced by having to have the emulation fallback.
>
> Yes, I know this - I also (runtime!) tested the emulation, but with GCC only.

Yeah, crossed emails, I started out just doing the "let's see what the
config difference is", and only after that realized that I had looked
at the wrong code for cmpxchg (ie I had looked at the simpler native
case).

> This can be achieved by implementing atomic64_{and,or,xor} as an
> outline function.

Yes, but then a lot of the whole point of commit 95ece48165c1 goes
away, doesn't it?

Or were you suggesting the out-of-line code only for the emulation
case? That would work.

             Linus

