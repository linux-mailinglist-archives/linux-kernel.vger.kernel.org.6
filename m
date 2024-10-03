Return-Path: <linux-kernel+bounces-348945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2025398EE50
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3D82833A8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D36D155A21;
	Thu,  3 Oct 2024 11:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="MDerJOB7"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BFE1547EB
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727955529; cv=pass; b=nfBEMkEPWTJXPGZ+JUEGL/ppiw9Wu0j9G6TrC0Mm4DJZUlaGwFGIc5DxqCLsiNh1ZzNEQZpvtJC8MYNeF/ovjpWyMjZRWZKHgJaj5IQ74i3SWuVHWMLH+rXPsxqJdVCxaSFdRW143p2mYdhvoOgHY0l/cVVA0DoM+ZmpnOhOfHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727955529; c=relaxed/simple;
	bh=Ge9YlZbtUNycTKKoSSRzBHYRd/F27ZfHw3kVf+J/Cac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEo1oukGIedaVNSv+GJC2qv12Kj2kL9JMG39Q3vs4ZCNRTsJsNCf9a//uYvVhN6cEeE4k2XvxU63PapipyK1CQHXeKMsrp3gXCbIX6skctfk9PXxMsrdgFhqEHMBXInB0LZVzgtz2T1SFEMHQqRAhf3WmE1T2NbyiLmru3IfJZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b=MDerJOB7; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1727955512; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=kneEU5WkWJ7M8qSDSiSyfuvvlEnk6I5+NeOQJbbZSIjzYtYBFepORoBKMbBpB8Oa5p0oOYcbpHRCt+ZYbQkBiAT9pfdigv6DewuPdZMIyvR8DDuzAdLkp/Log7ZLSfBs/kdh1JccfDV2XujAsMuTkywTED3BJsgfiz9b7qPIGyY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1727955512; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=80oOBJ90RZjsAjivwL50rHDRZPA468mLSAz/lMSF0Rs=; 
	b=CO/vbSd5YvHie9iMRknSfx3+LYYMPmOqR8kvT3FbKZcQU5EAUXXvcWdedfLgvdw/U3eQT0wquD3Q/4gP9qA6KjnVfgK8huRi/B10OAC1okNdAlbTsUt3IvDKDMSHZ81E1eYQVxEDkxhl1Gc8V0RArUP+k8aVguuJCuLlwTpjXWg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
	dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1727955512;
	s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:Message-Id:Reply-To;
	bh=80oOBJ90RZjsAjivwL50rHDRZPA468mLSAz/lMSF0Rs=;
	b=MDerJOB7jlGsqYe7k5TAPFCf1QdTLjWWYp1Zzc/T3rJWM4O5eyKT2GLg1QwxLGJr
	9o6rG/Wkrk8wo+HB1gjRyiKnwfg+aTz8gfrKQM6KW+gJQaTIk1xIJPR5SxB/cSJJkhP
	JDYfEjxROI/2DnSpPp3o/ZcN8Gzpmpm5uUM1hqdA=
Received: by mx.zohomail.com with SMTPS id 1727955510313671.7731952775321;
	Thu, 3 Oct 2024 04:38:30 -0700 (PDT)
Date: Thu, 3 Oct 2024 12:38:26 +0100
From: =?utf-8?Q?Adri=C3=A1n?= Larumbe <adrian.larumbe@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/panfrost: Add missing OPP table refcnt decremental
Message-ID: <e33rx3l52arkfgno64l5dctibo647kx3cpjlwcm3lil6cvszrt@abhg2mbu7ec4>
References: <20241003002603.3177741-1-adrian.larumbe@collabora.com>
 <20241003091740.4e610f21@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241003091740.4e610f21@collabora.com>

On 03.10.2024 09:17, Boris Brezillon wrote:
> On Thu,  3 Oct 2024 01:25:37 +0100
> Adrián Larumbe <adrian.larumbe@collabora.com> wrote:
> 
> > Commit f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")
> > retrieves the OPP for the maximum device clock frequency, but forgets to
> > keep the reference count balanced by putting the returned OPP object. This
> > eventually leads to an OPP core warning when removing the device.
> > 
> > Fix it by putting OPP objects as many times as they're retrieved.
> > Also remove an unnecessary whitespace.
> > 
> > Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> > Fixes: f11b0417eec2 ("drm/panfrost: Add fdinfo support GPU load metrics")
> 
> Reviewed-by: 
> 
> > ---
> >  drivers/gpu/drm/panfrost/panfrost_devfreq.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/panfrost/panfrost_devfreq.c b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > index 2d30da38c2c3..c7d3f980f1e5 100644
> > --- a/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > +++ b/drivers/gpu/drm/panfrost/panfrost_devfreq.c
> > @@ -38,7 +38,7 @@ static int panfrost_devfreq_target(struct device *dev, unsigned long *freq,
> >  		return PTR_ERR(opp);
> >  	dev_pm_opp_put(opp);
> >  
> > -	err =  dev_pm_opp_set_rate(dev, *freq);
> > +	err = dev_pm_opp_set_rate(dev, *freq);
> >  	if (!err)
> >  		ptdev->pfdevfreq.current_frequency = *freq;
> >  
> > @@ -177,6 +177,8 @@ int panfrost_devfreq_init(struct panfrost_device *pfdev)
> >  	 */
> >  	pfdevfreq->current_frequency = cur_freq;
> >  
> > +	dev_pm_opp_put(opp);
> > +
> 
> Shouldn't this be moved after the dev_pm_opp_set_opp() that's
> following?

Yes, right now it's in the wrong place, thanks for catching this.

> >  	/*
> >  	 * Set the recommend OPP this will enable and configure the regulator
> >  	 * if any and will avoid a switch off by regulator_late_cleanup()


Adrian Larumbe

