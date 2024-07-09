Return-Path: <linux-kernel+bounces-245807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B5C92B997
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141041F22BE4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4E5158A30;
	Tue,  9 Jul 2024 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="DAoFH4lN"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1E9155A53
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720528550; cv=none; b=ehR+y3BWx4t5yHolxdMTR900sPej5GWnTvHVT32HdhvfFfVW3xU09dUGEFCtUN9OAbOIx/IB9eKdhNQAw+MN4tTAewa5HooJwjwo/X5qlQNo/Hj4oeGhtLeN7EcMhp1qM/9xrE9iArKTo+3wRhbP9oKpqqh+1U7UEU6Thmpvoco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720528550; c=relaxed/simple;
	bh=f1nEv+DJj0in1CUm6Pc2FM0hhiic6RvLIVFfOSwY6i0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3mH6ppjFtnY5g0Ou0+2El11d01xm1Sehm9yKg8tiD+zPFBp6AXIRr3thV1nuLGD+ccz62LIDg3OkgLw4n/fY5rlv45C+eqsl2zH9XIlhRUfHwQ+IXLv2ylUYo5yddWc+mMZ/YbNkUXwezodwbugnRWBft/n7/87hu0+Dd/p5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=DAoFH4lN; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469BB9X5019019;
	Tue, 9 Jul 2024 14:35:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=selector1; bh=xL7gSE037cQc+udtp5aRXcyP
	CiEsUKe1LlWNxsNYELY=; b=DAoFH4lNp+R9Ryuw8sGmHWe6ApeRTbyoEDN0tEWz
	M7Ygjbf8Z4z0dlq0U6vKWWC0J6njhFQwBJaFbDE51BGfJ1UP0GjdrGJUMo5ORuyw
	E6attc+ka3Qqk8LezXZjwsr8oJMIZHcdRobS/gRDWumo8QnMs6ju3I7ikOUwqEm7
	z6ys0sZH+YkpIAw/iMJAk++1g6v9iY4WcDuvsd7IwQ+5t6jd5Z8zqXldvsAEbOGe
	riUDj8OhydMv7cG2eRHCQwyAyKLtptNDXLxHQrZXQp0eqvqj/ik8zvHkvAFR7W4O
	WjTuKKS8aH8wtmTMflVO48f41tHM9HjjMBBTDKn5KCHdzg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 407fg0hutq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 14:35:32 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3607540044;
	Tue,  9 Jul 2024 14:35:28 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7F9AE226FDF;
	Tue,  9 Jul 2024 14:34:43 +0200 (CEST)
Received: from gnbcxd0016.gnb.st.com (10.129.178.213) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jul
 2024 14:34:42 +0200
Date: Tue, 9 Jul 2024 14:34:34 +0200
From: Alain Volmat <alain.volmat@foss.st.com>
To: Maxime Ripard <mripard@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Vetter
	<daniel.vetter@ffwll.ch>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Philippe CORNU <philippe.cornu@foss.st.com>,
        Yannick FERTRE
	<yannick.fertre@foss.st.com>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>
Subject: Re: [PATCH] MAINTAINERS: drm/sti: mark it as Odd Fixes
Message-ID: <20240709123434.GA58085@gnbcxd0016.gnb.st.com>
References: <20240705100356.16760-1-krzysztof.kozlowski@linaro.org>
 <ZofW1v4uEFo9GscF@phenom.ffwll.local>
 <20240705-hysterical-beluga-of-courtesy-38b2e2@houat>
 <ff8b84c9-5bef-4cb9-a10b-b3bb1a017366@linaro.org>
 <Zof4Bp82iu7hZsSZ@phenom.ffwll.local>
 <20240705151436.GA3949471@gnbcxd0016.gnb.st.com>
 <20240708-industrious-paper-wombat-ef3ff3@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240708-industrious-paper-wombat-ef3ff3@houat>
X-Disclaimer: ce message est personnel / this message is private
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01

Hi Maxime,

On Mon, Jul 08, 2024 at 04:57:49PM +0200, Maxime Ripard wrote:
> On Fri, Jul 05, 2024 at 05:14:36PM GMT, Alain Volmat wrote:
> > Hi Krzysztof, Daniel, and Maxime,
> > 
> > On Fri, Jul 05, 2024 at 03:41:26PM +0200, Daniel Vetter wrote:
> > > On Fri, Jul 05, 2024 at 01:33:38PM +0200, Krzysztof Kozlowski wrote:
> > > > On 05/07/2024 13:22, Maxime Ripard wrote:
> > > > > On Fri, Jul 05, 2024 at 01:19:50PM GMT, Daniel Vetter wrote:
> > > > >> On Fri, Jul 05, 2024 at 12:03:56PM +0200, Krzysztof Kozlowski wrote:
> > > > >>> Patches to STI DRM are not being picked up, so even though there is
> > > > >>> maintainer activity, it seems that these drivers are not being actively
> > > > >>> looked at.  Reflect this in maintainer status.
> > > > >>
> > > > >> Note that since the driver is in drm-misc, other committers can also pick
> > > > >> up patches and push them. Both Neil and Dimtry have commit rights and
> > > > >> should be able to pick up your patches for you, if they get stuck.
> > > > > 
> > > > > I've applied the patches.
> > > > > 
> > > > > I don't think we should merge this one though, a one-off mishap can happen.
> > > > 
> > > > Sure.
> > > > 
> > > > Folks, maybe then pattern in maintainers should be somehow changed or grew?
> > > > 
> > > > The recommendation to all submitters is to use get_maintainers.pl. b4
> > > > also does it. In this particular case, using get_maintainers.pl or b4
> > > > will result in patches not being picked up.
> > > 
> > > I think get_maintainers.pl is correct: You get the driver maintainer, plus
> > > drm-misc maintainers as official fallback, plus Dave&me as fallback of
> > > last resorts. So all correct.
> > > 
> > > What's special with the commit rights model is that other committers that
> > > work all over the subsystem can also pick up the patches for you, so that
> > > the drm-misc mainters don't become a bottleneck. But the ideal person
> > > there are drm-misc committers who work in your team or company, or someone
> > > else where you have some goodwill credits to spend with and ask them for a
> > > favour. And there's just no way to model that and make sure the script
> > > gives you the right suggestions.
> > 
> > Many thanks for all your emails and your support.
> > 
> > In the past, I've never committed patches to drm-misc myself and, to be honest,
> > missed the point that as a drm driver maintainer, I should also do so.
> 
> Are you saying you don't have a drm-misc account, or that you don't want
> to participate?

I don't have (yet) a drm-misc account.  But following recents email exchanges,
expectations are now clear so I will request an account in order to merge as well
patches of drm/sti.

Thanks a lot Maxime for all the explanations.

Alain

> 
> > Thanks to recent discussions, I now fully understand how it should be done.
> > 
> > That said, since the volume of drm/sti patches is rather small, I will
> > from now on request help for commit from drm/stm (Philippe, Yannick,
> > and Raphael) and drm-misc maintainers in a more "pro-active" way :-)
> > 
> > Sorry for the inconvenience, and once again, many thanks for your
> > support.
> 
> Sorry, but the expectation is very much that you merge at least some of
> the patches for the driver you maintain, and not just rely on someone
> eventually picking it up.
> 
> Maxime



