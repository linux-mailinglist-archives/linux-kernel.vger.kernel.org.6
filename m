Return-Path: <linux-kernel+bounces-281294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E4A94D531
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 697B91C20F5D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530B33B1BC;
	Fri,  9 Aug 2024 17:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VofiiuQX"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52FA17C7C
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723223221; cv=none; b=QwoLg/TtryFGx+WBx4JxjaVT6tpnTEMh//IiUmSr29/9SPoPX1nGUuSK3pCmeOQWLZPabCMN0ZLctfX1XP9ZrScG7gj2qNLYkNTTHVS/+CwBaiIoAl9S3RQ0Dz8C0LT6Zm6dAw+cuDfKCkY0rahMBox5G5FQ2QE8gnBJWR5z9/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723223221; c=relaxed/simple;
	bh=l7eARIMGO+uf5UjJKVMnVM4+4lbCKlslOzkuIgSl39c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJ5T+WW/q1IYpwM/V3EAiPCr8uPSB1DtEiyZWLyZweElKqYcX1vTfAIQSk+g2bpr2/OCDrJ3vsuCoWPzvZBWC3ATAuDi+qM8KiP+IPvO7UuvBiUkHQocD9jEoq6+bUQHQirbsnOHDlMxUV3qGZ69NKy2vBjs4jIqtjlfC71bT2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VofiiuQX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7aada2358fso520481966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723223218; x=1723828018; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Bqi0R8E9+yWkIxspBX3nFOrKOj6LKnr9GEzzF8YTptU=;
        b=VofiiuQXYK5SmISEYdu3lGKyS0BUnwgrTvg9tvmVR8Rc6+rYnJlJF6WQCl519yYc4W
         VpTuhMd5dBdq9DkOQqxgs9GvsmGl7fGH1Pbju6s4iWZQxAmTRnGXD9kvYGpoM4kyhIJa
         0ohWBCdEdy2C+fWyztr+sD3kiHuZ4CXUCdNbGUYnXUPyJuZuCZUzX4BpwpUetyuIegVM
         SHAvZXGd2QYCd9PRmoglSPjq461iQdnfs1S1QDIsdGlNpAyhm0jLb0QbU1ZuqkzGKmW0
         zhktBfDuyT+7f9hVhQaXTGJM9i6lPc4TEKFbVK88jVjcPrMtLMYbItNdRjVH1UAtd5+1
         4fFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723223218; x=1723828018;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bqi0R8E9+yWkIxspBX3nFOrKOj6LKnr9GEzzF8YTptU=;
        b=NZ6GaHMUD9h5iDG56f9jOfZrDCLoRBd3qGkLL6pVxFcQup3jMAUU9yMubUgLM916XK
         4/SIfCS4oq2VIBigaeQyWdrnR9LnGufe3Q5sGkAXJuXkq6d/ZH5cYt8C8ap2BIlFBdI8
         S3O4cY3BgyN2SDK1k+twxCrz2ZTpnUvneDL2/6tL+aRBQgl/kglXSMhtQwrPdK5ipI8M
         tJLM7Iitm31FoSI5UfIE01QWkE7LM/RdaxhGxp3qDjOEr99BzCKFtqUAAZAX0Diebr9e
         b1oaE5/M/CSPKLtXRi8SIe5dsNRYn+jZuizw9zVd8bJO6DtiR2dYvA4vhUryPkLBYzY5
         wPwg==
X-Forwarded-Encrypted: i=1; AJvYcCWMunlWfLaDjyrDAI8MZXCfN89R2ykU5fiDiUiC1oOer+BnYWr7Uor0nXzDAJvgivZWqiuKUCWUlc3Tp5xazoEc+OrZnlZrB3G0iKXd
X-Gm-Message-State: AOJu0Yzo46cJ/FHtBxjd3isd2aY40jzRJjNSSiTO5ispP47VCDaLlLWb
	bB1WzZyh5VidY+eWSPfXHN75ZNnuTM6MC16GG0teWBBZ1T4KzpYZomFE1bRz05Q=
X-Google-Smtp-Source: AGHT+IEeCFPLP0xfg9I587Tui8Mvgeq3K/jroE1CYOnUpQ9zZAYa3E+EGGh4PFeyvJx4Oey5IN0PeA==
X-Received: by 2002:a17:907:368c:b0:a7a:8dcd:ffb4 with SMTP id a640c23a62f3a-a8091f1998dmr492925166b.17.1723223218128;
        Fri, 09 Aug 2024 10:06:58 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d89a8esm872794066b.144.2024.08.09.10.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:06:57 -0700 (PDT)
Date: Fri, 9 Aug 2024 20:06:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Dave Airlie <airlied@redhat.com>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] drm/ast: astdp: fix pre-op vs post-op bug
Message-ID: <359e5aa5-5908-44d3-8359-4605aac3f5d5@stanley.mountain>
References: <f7790a38-6b72-44dd-aaeb-550d2de14cf2@stanley.mountain>
 <57cea156-1abc-4860-9a6a-0a5fdb4a2971@suse.de>
 <87h6bt3j6w.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h6bt3j6w.fsf@intel.com>

On Fri, Aug 09, 2024 at 04:43:51PM +0300, Jani Nikula wrote:
> On Fri, 09 Aug 2024, Thomas Zimmermann <tzimmermann@suse.de> wrote:
> > Hi,
> >
> > thanks a lot for the bugfix.
> >
> > Am 09.08.24 um 14:33 schrieb Dan Carpenter:
> >> The test for "Link training failed" expect the loop to exit with "i"
> >> set to zero but it exits when "i" is set to -1.  Change this from a
> >> post-op to a pre-op so that it exits with "i" set to zero.  This
> >> changes the number of iterations from 10 to 9 but probably that's
> >> okay.
> >
> > Yes, that's ok.
> >
> >>
> >> Fixes: 2281475168d2 ("drm/ast: astdp: Perform link training during atomic_enable")
> >> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> >> ---
> >>   drivers/gpu/drm/ast/ast_dp.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/gpu/drm/ast/ast_dp.c b/drivers/gpu/drm/ast/ast_dp.c
> >> index 5d07678b502c..4329ab680f62 100644
> >> --- a/drivers/gpu/drm/ast/ast_dp.c
> >> +++ b/drivers/gpu/drm/ast/ast_dp.c
> >> @@ -148,7 +148,7 @@ void ast_dp_link_training(struct ast_device *ast)
> >>   	struct drm_device *dev = &ast->base;
> >>   	unsigned int i = 10;
> >>   
> >> -	while (i--) {
> >> +	while (--i) {
> >
> > If this loop ever starts with i = 0, it would break again. Can we use
> >
> > while (i) {
> >    --i;
> >     ...
> > }
> >
> > instead?
> 
> FWIW, I personally *always* use for loops when there isn't a compelling
> reason to do otherwise. You know at a glance that
> 
> 	for (i = 0; i < N; i++)
> 
> gets run N times and what i is going to be afterwards.
> 
> Sure, you may have to restructure other things, but I think it's almost
> always worth it.

A for statement works here.  I need to resend the patch anyway because
the if (i) msleep() code doesn't make sense now.

regards,
dan carpenter


