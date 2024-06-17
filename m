Return-Path: <linux-kernel+bounces-218375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C238990BD82
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4CC6B21CD0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 22:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F12199239;
	Mon, 17 Jun 2024 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sbZ3T7LP"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE36187575
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 22:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718663186; cv=none; b=kC1fZ+VhZMSjdNBQ52cGwnXvI3+RvcOVIDYK/PpjCLONs48PRkbPw4kNXIUBZltLU7N8AULvF0mgDbtjEPPFnXve3nElIkttdEoIXv5rnJ7ah0e5L0uld0qVqYoSOr+yf3VXPpk0IO7D9ScOu0I5+3HImQyhswDbn99RDnr7l80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718663186; c=relaxed/simple;
	bh=cuZadAvedLLL/lhJZycTa+TPPhFfsJWLfBr7DtoXQXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OeadsGm3P7i3yqOXJBkYSOLAYHbkMhDKWC/A84rGJQ51yCLQxr/dXxTn73DFHiz0q8VjCnqP7zuOomgzCEw6gY48Yb+nE1QxcMmT0103ZSjCtDwWGyPkfq23RpW0oiMgfHkmmx9Yq10umATctpSUtiluxDZGPMzSig67zhv32gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sbZ3T7LP; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52c82101407so7968619e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718663182; x=1719267982; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I5gR82bl2Ug4kICksfq0yamduDdpDT78AwxrkSHnNJI=;
        b=sbZ3T7LPCSRHM9JqHG+uuKZJ2X05VFRT+NR03n5c0wTj+vV4x//jNW4K/sxvFqPKrf
         bduUaCTkXh5EnV/fKudvI9MPFpLwbnGUyrTrUqqyOz4LBbdfxJ7FXazqjtb2MKkj1xJQ
         4ZcUOxSHWwVKaGHDqe9Pu/4REfeBXBQqDynUmWpfN0CbM9fqdb5AG9YlYAvVG+59697P
         WQ88BhWChX0zh35KmHDE7g5njm5cUpTOqF1NiaZrio0zYAUz8sFajuE/qONAYQPhzRKa
         xjQKiKyt62oc5zfTDiwCly+TV3EFxX/XoWJ7iZyfwmCis/Xa9ttOaktggS4D4vLq/GUP
         Yvkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718663182; x=1719267982;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5gR82bl2Ug4kICksfq0yamduDdpDT78AwxrkSHnNJI=;
        b=j0Eb6nB+J3hkFB/HYh/7JOoM6G3IK2WGHtzLXepULej6WGQ0NJd+Al4KVQLNviL5j5
         grXh32FmfPALo8pxMby8Qjr+SPn/bOOUqcyBw/vKvaCTaPc6VGMBjhICxM+TzGpAh87I
         CkC/vYKd1bgokZDeYW14abxPPqM7vuDb9yGlLC866K38LaJ9NmtkEUNtRIHg2YZMX4yy
         ZmzTVFA3pQ9BQif3I1Wy1vnnZqfCOuVOIDw0squJyUSLMDzyQpEQI8YYUGaJsQ7RAjLX
         0wo8jAstlwX3SNXwcOvISBKrYqpT04DlLgjvG/GxD65aiBW8f2zRIhyzU9p+IxFINkiS
         DsMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp+RIUh3SBMlr17R5uh8/hckq7TbQfOGecDGP82jSjw4o8kgQow9BAts5fkZC8gpVyyjh9MWXYX9oWuzXcI/eHsZZuzJ7p0ARz86BQ
X-Gm-Message-State: AOJu0Yx8k+57zfMAeJi8E4Ac++ar4fkfq7tyRV2jjVa8VV9dSOdBr3mq
	OyVVNqBD9KxIveP0o9XWIX1Lpz+WZDSRgybva1k1gvDIWvckHsryPvjw8LAQzcs=
X-Google-Smtp-Source: AGHT+IE0S9TzJTmn/4Itff9qKnfgos31gAG8PMEgOkt3+SZrjM0TS4f1ZS5scMO4EJyrMtuajq9LDg==
X-Received: by 2002:a05:6512:b9c:b0:52c:aea5:9e09 with SMTP id 2adb3069b0e04-52caea5a347mr9590015e87.20.1718663182234;
        Mon, 17 Jun 2024 15:26:22 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282de86sm1357045e87.68.2024.06.17.15.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 15:26:21 -0700 (PDT)
Date: Tue, 18 Jun 2024 01:26:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: Douglas Anderson <dianders@chromium.org>, 
	dri-devel@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH RESEND] drm/display: Drop obsolete dependency on
 COMPILE_TEST
Message-ID: <jbqbn6zaqq7j5htxuqxb34tjrf5lnqabkh5ywtnklhd4owyc3h@ztvolr6hjrti>
References: <20240617103018.515f0bf1@endymion.delvare>
 <xd2yybtxvzte7gwqwg2vudzvhoekqao2dle6zsuduzjzi3rsay@xhahwof2prph>
 <20240617132348.5f20bf89@endymion.delvare>
 <vsrsvmrkqnmxs3ncqv5m2gevzefiq55tr2iolxlmoehsvgcfkn@hyx37vax6r5e>
 <20240617201814.73a07702@endymion.delvare>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617201814.73a07702@endymion.delvare>

On Mon, Jun 17, 2024 at 08:18:14PM GMT, Jean Delvare wrote:
> On Mon, 17 Jun 2024 14:55:22 +0300, Dmitry Baryshkov wrote:
> > On Mon, Jun 17, 2024 at 01:23:48PM GMT, Jean Delvare wrote:
> > > Hi Dmitry,
> > > 
> > > Thanks for your feedback.
> > > 
> > > On Mon, 17 Jun 2024 12:57:19 +0300, Dmitry Baryshkov wrote:  
> > > > On Mon, Jun 17, 2024 at 10:30:30AM GMT, Jean Delvare wrote:  
> > > > > Since commit 0166dc11be91 ("of: make CONFIG_OF user selectable"), it
> > > > > is possible to test-build any driver which depends on OF on any
> > > > > architecture by explicitly selecting OF. Therefore depending on
> > > > > COMPILE_TEST as an alternative is no longer needed.    
> > > > 
> > > > The goal of this clause is to allow build-testing the driver with OF
> > > > being disabled (meaning that some of OF functions are stubbed and some
> > > > might disappear). I don't see how user-selectable OF provides the same
> > > > result.  
> > > 
> > > Historically, the goal of this clause *was* to allow build-testing the
> > > driver on architectures which did not support OF, and that did make
> > > sense back then. As I understand it, building the driver without OF
> > > support was never a goal per se (if it was, then the driver wouldn't be
> > > set to depend on OF in the first place).
> > > 
> > > Some of my other submissions include the following explanation which
> > > you might find useful (I ended up stripping it on resubmission after
> > > being told I was being too verbose, but maybe it was needed after all):
> > > 
> > > It is actually better to always build such drivers with OF enabled,
> > > so that the test builds are closer to how each driver will actually be
> > > built on its intended target. Building them without OF may not test
> > > much as the compiler will optimize out potentially large parts of the
> > > code. In the worst case, this could even pop false positive warnings.
> > > Dropping COMPILE_TEST here improves the quality of our testing and
> > > avoids wasting time on non-existent issues.  
> > 
> > This doesn't seem to match the COMPILE_TEST usage that I observe in
> > other places. For example, we frequently use 'depends on ARCH_QCOM ||
> > COMPILE_TEST'. Which means that the driver itself doesn't make sense
> > without ARCH_QCOM, but we want for it to be tested on non-ARCH_QCOM
> > cases. I think the same logic applies to 'depends on OF ||
> > COMPILE_TEST' clauses. The driver (DP AUX bus) depends on OF to be fully
> > functional, but it should be compilable even without OF case.
> 
> The major difference is that one can't possibly enable ARCH_QCOM if
> building on X86 for example. Therefore COMPILE_TEST is the only way to
> let everyone (including randconfig/allmodconfig build farms) test-build
> your code.
> 
> On the other hand, if you want to test-build drm_dp_aux_bus, you can
> simply enable OF, because it is available on all architectures and
> doesn't depend on anything. No need for COMPILE_TEST.

I'd probably let Doug respond, what was his intention. 

> 
> For clarity, I'm not advocating against the use of COMPILE_TEST,
> actually if you check the history of my kernel contributions 10 years
> back, you'll find commits from me adding COMPILE_TEST in addition to
> arch-specific dependencies to many drivers. All I'm saying is that it
> should only be used when it is the only way to enable the build.


-- 
With best wishes
Dmitry

