Return-Path: <linux-kernel+bounces-511677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EDDA32E30
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 612F118869B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0D925D531;
	Wed, 12 Feb 2025 18:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRvm6Zqu"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA06209663
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383999; cv=none; b=aYwEVWOF3AmQUKvMx8qvwvF/jwXJA6LeTigP3TRLeHmHkNjJUPV0mxKjBSBIOph5tlr2L9aF/W3iZdnyxS3kcHAJOO120vIuw1O00AvLJzjtjtnC1l/oGtlrqzRc8xmuEnhAvSIlYlG/0tVdicZoCGmPGNrEbZ++3oJI83Hfi0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383999; c=relaxed/simple;
	bh=4sXJG2YJbM1/CStfpqMsr2s3jCBVhr0rnW7eJJQV6W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mM0hN2BhenqSdiyBV9shdCP7dorL+AEUdkLUvLSeEjfO+7CZwqUSehZWfJa5tY1Y3ri/Em9N0YOSUGoXXS9cI798lzj/deWxtX/oWZIqI3Eilrqw6wBQJdi5ii0v9z4ct+PiNUnjO8f4VjQAMhCbfAbeANBUBYu0w/RkGvz8wBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FRvm6Zqu; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5de5e3729ecso9427086a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739383996; x=1739988796; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T8yCP6ozgYyslEm6VKJ5cng9WS1x0StC3pzg7YSBGx8=;
        b=FRvm6ZquUjYg6PDj3iGEspV2BPLLEeffM27p2I4AtPtcfs0SsA8hAKpxD6nV0v8vqq
         emj5EPET3VajjNLqLHATy4nwOsrwNexSRYSpjKeVDGFNfkprfyqAZxEnqpJaqV5HEIU8
         vjKtcLivK1KU5cqhDcH866foJ0LLb0VaZEAHiO8RACMo26YpDrewpLgapGOxrAnHVzKM
         isoYRN0M7uK1zv/5LXalu99mFBovrciMfXjNTVvFcyCSczzurCNVuE0WZYijl0CSWD7z
         TohuIUo9x0KsNWnjlHBOm0leCKBiUUNmtbM9iUMC1WOcwvwRrHSkTOJduYUKUJVt+94P
         b5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739383996; x=1739988796;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8yCP6ozgYyslEm6VKJ5cng9WS1x0StC3pzg7YSBGx8=;
        b=Sbij1Cu1R3BURkwPomvvBDuKO1J/0fsCPNpGrAQlZQWErlzEm7ybqZYZWqS40v5npM
         VUlBe9XkCS0XT/sM+9cf1UCaux4TpSBD9lM0WR3MomT46S98iJK0kYIfbpTcXakTgnaz
         RZAUem9N4T62OS4R5B53wZ4ib1tYZ+bWNuKitKBWbnTiQNtozZmCMs0VwCoYSYGuyg0N
         nfhs/JMLN/b3JOgs0d1/7dtbI6hdXr44qk4fgfqIuGYLNUv1ZszFlQANMRmbPvvvI6EF
         XgfSBOc5UU3ijxvTl/tDzZ5TgQfqO+RvrRMvbe+cq13taZT7Ikvl9jjk4bh9/DhIyc0u
         fryg==
X-Forwarded-Encrypted: i=1; AJvYcCXkhdbbKBJ2q8jfdP7JLlieqX0BIc7fyrECSNyjYa6NFM2r7pap7qwnHtwYsUqmneatl+QhSRVnaTude84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWy63BJGJRN/S5u6vJ1wmNesx3TmSvDwPLLQyYyBaR2T0wQgM3
	YtgO3jGgeGTegzBUII0rFaJQiniig4S5zcq1ayil1aQNbxX3sbycQKCIZcxiyKI=
X-Gm-Gg: ASbGncvPXQlgtbb6R/TK0nMxE5fFieXFqwHFOB/Y5QbVqbScBiRtHVNojNyleswWGDx
	GlNj01lsuoVnNSKJeWDqHsYAHIbGIj1KeA/1fI/59WbTKEIKgWXeUXuPjXKIyapVjNLqNDuM/I8
	kRtXZd56q20TqQ10gNL6EqQUsQSTQkhYGvZ+gzeVYnaDsM/VYyukSOGyBc56tPTbZJQaUNuWc8H
	ygxbYf+IfItAJeN6yMY8/RALsAF66zLabEoijeBzyWEw/OSoR+aD4lT1Dfs/oJLTxcs0GYdtbgB
	WRa8BaVJyX5Oze3okpmx
X-Google-Smtp-Source: AGHT+IG2HpL+3tuCKjc/LoY0MW1A5tuWfeCaFrma02UBG8ZxcDcj01BZc9tF/YWR/ZTfEC32S+VCzw==
X-Received: by 2002:a17:907:7b86:b0:ab7:e16:aab7 with SMTP id a640c23a62f3a-ab7f3761d0amr410202566b.13.1739383996339;
        Wed, 12 Feb 2025 10:13:16 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ab7b43ee08asm767846966b.88.2025.02.12.10.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 10:13:16 -0800 (PST)
Date: Wed, 12 Feb 2025 21:13:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Frank van der Linden <fvdl@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] x86/mm: Fix uninitialized variable in
 register_page_bootmem_memmap()
Message-ID: <bde447d5-0a2f-4c65-97e3-5439b67ab2f2@stanley.mountain>
References: <1aa70a33-2acd-49fb-8049-a20dae40ecba@stanley.mountain>
 <CAPTztWahPK5MLTxMnGH8woe1emM=QA=3pjy1ZCBBG+D39aLGog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTztWahPK5MLTxMnGH8woe1emM=QA=3pjy1ZCBBG+D39aLGog@mail.gmail.com>

On Wed, Feb 12, 2025 at 09:59:54AM -0800, Frank van der Linden wrote:
> On Wed, Feb 12, 2025 at 7:21 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > Smatch complains that "next" could be uninitialized.  The "next"
> > assignment was accidentally left out when we moved these lines to earlier
> > in the function.
> >
> > Fixes: bdadaec1526d ("x86/mm: make register_page_bootmem_memmap handle PTE mappings")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > This goes through the -mm tree.
> >
> >  arch/x86/mm/init_64.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
> > index e7572af639a4..6e8e4ef5312a 100644
> > --- a/arch/x86/mm/init_64.c
> > +++ b/arch/x86/mm/init_64.c
> > @@ -1600,8 +1600,10 @@ void register_page_bootmem_memmap(unsigned long section_nr,
> >                 get_page_bootmem(section_nr, pud_page(*pud), MIX_SECTION_INFO);
> >
> >                 pmd = pmd_offset(pud, addr);
> > -               if (pmd_none(*pmd))
> > +               if (pmd_none(*pmd)) {
> > +                       next = (addr + PAGE_SIZE) & PAGE_MASK;
> >                         continue;
> > +               }
> >
> >                 if (!boot_cpu_has(X86_FEATURE_PSE) || !pmd_leaf(*pmd)) {
> >                         next = (addr + PAGE_SIZE) & PAGE_MASK;
> > --
> > 2.47.2
> >
> 
> Thanks for catching that Dan. I believe Andrew took the series out of
> mm-unstable because of some conflicts, and asked me to do a v4 for
> mm-unstable. Would you mind if I just folded your change in to the v4
> series?

Yeah, no problem.  -mm patches are always folded.

regards,
dan carpenter


