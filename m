Return-Path: <linux-kernel+bounces-242689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F091B928B75
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 17:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F504B27531
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 15:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5210816EBEB;
	Fri,  5 Jul 2024 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="B0IaeYZl"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C95F16DECE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192555; cv=none; b=KxrAR0ggmRQm38uEK/8NLolf/nFqBOd4FzYy/BMvC82iTN0D4opHY6NhiuIctDvC+SY76IR1xvHw+C9sgUa25hpZJuU9Co42p1nViXFW1F53qqUBbBreyQPKE4j3DgVaydAi11fKjaQL1INmXTLyMC81T/oO+arrP4DMHNLav3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192555; c=relaxed/simple;
	bh=t1/HlvCG6Zhx0pjisl7ksXtAM8A3yCQh5GvziDXJ+14=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=asAufZFiwumqxAqUPJVn2Mk4eG0jDuaCMH9iy/VZ/KRblecJfKZU3E+NQV2k2oxi4ZwiQqvDSUI/kfQCVgDt5JcjKaArU6VhaksTaVYG9lfuKmeoIfP+Pj+GsF1HPt27wx3dcGOjE5CkIxtuTGgLzag/rTU4bTQbOvnJQj+f2Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=B0IaeYZl; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465EAPGY011328;
	Fri, 5 Jul 2024 17:15:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=selector1; bh=ESFLb13hceD8qR42UqHwxlvV
	7ImFNkkC7q7BdlvzgaI=; b=B0IaeYZl8RxOfkaoGrz2Zn6G8WOkRg3eE+Q17bTk
	3YlEuKuddPyeuvkH1o2SM6Xi84n6sz2rynKHEhLMmnQYYFDsL4fgj74x7nOQsZEW
	Arck9gmqGr8dHF7WElSWW2RTYT7jIp7rtTqmSLbIQK8v/QMyXvVirGN8Mo7DFCCS
	Qrv0mn7bMR+3cgYhJgSsenL4ulYHjbLnBiWhNry3KNY2KufuRk31NWmqqbZNLNm3
	ov84r0h2wSf+xWEXCJxWccNVh32lhIDdqoSVX9A1zATm0OXzt75KL6gMerIR9aLb
	M97+kL7VQ2eX3RcTH+VGQTqGov2MPdH9we3IZ9STzRHh+w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 402uu184km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jul 2024 17:15:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 483A840046;
	Fri,  5 Jul 2024 17:15:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2AF8622D832;
	Fri,  5 Jul 2024 17:14:43 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 5 Jul
 2024 17:14:42 +0200
Date: Fri, 5 Jul 2024 17:14:36 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Maxime Ripard
	<mripard@kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann
	<tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>
CC: Philippe CORNU <philippe.cornu@foss.st.com>,
        Yannick FERTRE
	<yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>
Subject: Re: [PATCH] MAINTAINERS: drm/sti: mark it as Odd Fixes
Message-ID: <20240705151436.GA3949471@gnbcxd0016.gnb.st.com>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Philippe CORNU <philippe.cornu@foss.st.com>,
	Yannick FERTRE <yannick.fertre@foss.st.com>,
	Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
References: <20240705100356.16760-1-krzysztof.kozlowski@linaro.org>
 <ZofW1v4uEFo9GscF@phenom.ffwll.local>
 <20240705-hysterical-beluga-of-courtesy-38b2e2@houat>
 <ff8b84c9-5bef-4cb9-a10b-b3bb1a017366@linaro.org>
 <Zof4Bp82iu7hZsSZ@phenom.ffwll.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Zof4Bp82iu7hZsSZ@phenom.ffwll.local>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_10,2024-07-05_01,2024-05-17_01

Hi Krzysztof, Daniel, and Maxime,

On Fri, Jul 05, 2024 at 03:41:26PM +0200, Daniel Vetter wrote:
> On Fri, Jul 05, 2024 at 01:33:38PM +0200, Krzysztof Kozlowski wrote:
> > On 05/07/2024 13:22, Maxime Ripard wrote:
> > > On Fri, Jul 05, 2024 at 01:19:50PM GMT, Daniel Vetter wrote:
> > >> On Fri, Jul 05, 2024 at 12:03:56PM +0200, Krzysztof Kozlowski wrote:
> > >>> Patches to STI DRM are not being picked up, so even though there is
> > >>> maintainer activity, it seems that these drivers are not being actively
> > >>> looked at.  Reflect this in maintainer status.
> > >>
> > >> Note that since the driver is in drm-misc, other committers can also pick
> > >> up patches and push them. Both Neil and Dimtry have commit rights and
> > >> should be able to pick up your patches for you, if they get stuck.
> > > 
> > > I've applied the patches.
> > > 
> > > I don't think we should merge this one though, a one-off mishap can happen.
> > 
> > Sure.
> > 
> > Folks, maybe then pattern in maintainers should be somehow changed or grew?
> > 
> > The recommendation to all submitters is to use get_maintainers.pl. b4
> > also does it. In this particular case, using get_maintainers.pl or b4
> > will result in patches not being picked up.
> 
> I think get_maintainers.pl is correct: You get the driver maintainer, plus
> drm-misc maintainers as official fallback, plus Dave&me as fallback of
> last resorts. So all correct.
> 
> What's special with the commit rights model is that other committers that
> work all over the subsystem can also pick up the patches for you, so that
> the drm-misc mainters don't become a bottleneck. But the ideal person
> there are drm-misc committers who work in your team or company, or someone
> else where you have some goodwill credits to spend with and ask them for a
> favour. And there's just no way to model that and make sure the script
> gives you the right suggestions.

Many thanks for all your emails and your support.

In the past, I've never committed patches to drm-misc myself and, to be honest,
missed the point that as a drm driver maintainer, I should also do so.
Thanks to recent discussions, I now fully understand how it should be done.

That said, since the volume of drm/sti patches is rather small,
I will from now on request help for commit from drm/stm (Philippe, Yannick, and Raphael)
and drm-misc maintainers in a more "pro-active" way :-)

Sorry for the inconvenience, and once again, many thanks for your support.

Alain


> -Sima
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

