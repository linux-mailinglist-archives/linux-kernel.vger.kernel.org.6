Return-Path: <linux-kernel+bounces-557741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBFEA5DD18
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45B157A1C9B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FA7242906;
	Wed, 12 Mar 2025 12:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwrz0mPb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000EA7083C;
	Wed, 12 Mar 2025 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783946; cv=none; b=iGHrASsjcgzrzj0drvq7AgAbAJD+BYP5/B5CankCqL28yUvKSYDjM6+AUWEDZKFZxPauVGBV1glJg3QUu3P4Plt/TbwjS7NWeObXfuPHFUowBVr6M7COT5S2sl5ClR4Sl9Eu3+gnDjaApdSjeBJEcvIwjAg3Q7FuL+1QAKkvwxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783946; c=relaxed/simple;
	bh=QaTNbFgJ262CA817FyLcBE3QKWWHliMzcePUpnpEzbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxHnJFw2Xf3E0fih+g2r92agFwBYHw8Z8GoCqZSPHblMDI5NSA4qolkhhDvs8lNWDb/5yENiJC5Gb0IXZmlGN+ZdbE8d+o8fyAodWc1y/S4VXS7/CKasjXyCfoswzmf3eLrT73xfp3bicX9rlO1qmMuuIAvoQptJvKfSE/3sxps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwrz0mPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77AAC4CEE3;
	Wed, 12 Mar 2025 12:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741783945;
	bh=QaTNbFgJ262CA817FyLcBE3QKWWHliMzcePUpnpEzbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jwrz0mPbD5Dlkk6Vpem8hxU/UhiShqlfxPo2YYqkGFkOaxjuuYtPvBtjkJBChgDy1
	 PvL8VmK9pChvuLMDQ1dbVvUEEvvDrDkubbIoT6NyRAqoBNUI6W7asWuyJRhuB8uv0k
	 L5lqle8NJtjJHWC9XaCXuyvxhdDOwf23Ghc8LtTbK9EUrVV+wIeonpNyAATQ4+jBpb
	 gN9bct4HjLFwt5SB/J0aPuGdTJrSHk7SEMl+0JsiTRff+QMkE4rjoMdgRbT2+xpDeg
	 TN9J36NP0zMXh1ouIfyfP8OM/ejt2nW/j+BlBB9MyNnHVCV/XpnzPvfQX667UDaBrN
	 q1As4JZgVZRkw==
Date: Wed, 12 Mar 2025 14:52:17 +0200
From: Dmitry Baryshkov <lumag@kernel.org>
To: Harikrishna Shenoy <a0512644@ti.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Harikrishna Shenoy <h-shenoy@ti.com>, andrzej.hajda@intel.com, 
	neil.armstrong@linaro.org, rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, simona@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, jani.nikula@intel.com, j-choudhary@ti.com, 
	sui.jingfeng@linux.dev, viro@zeniv.linux.org.uk, r-ravikumar@ti.com, 
	sjakhade@cadence.com, yamonkar@cadence.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: drm/bridge: Add no-hpd property
Message-ID: <vfg6hlkzmqahbswgyctzuuzcdm2aend6wmo3uci4qs74jasjtc@3hlox276hazj>
References: <20250205115025.3133487-1-h-shenoy@ti.com>
 <20250205115025.3133487-2-h-shenoy@ti.com>
 <efd89cf8-2f83-44fd-8bdf-aa348d4d9659@kernel.org>
 <h24gpx6cxm4s6gzcunjnswubtvqask5dewi3udulmntsuieklm@w3pw4ig3t7gm>
 <de0cb22d-d251-4b0b-8fc7-e8b5a891a527@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de0cb22d-d251-4b0b-8fc7-e8b5a891a527@ti.com>

On Wed, Mar 12, 2025 at 11:56:41AM +0530, Harikrishna Shenoy wrote:
> 
> 
> On 05/02/25 19:03, Dmitry Baryshkov wrote:
> > On Wed, Feb 05, 2025 at 12:52:52PM +0100, Krzysztof Kozlowski wrote:
> > > On 05/02/2025 12:50, Harikrishna Shenoy wrote:
> > > > From: Rahul T R <r-ravikumar@ti.com>
> > > > 
> > > > The mhdp bridge can work without its HPD pin hooked up to the connector,
> > > > but the current bridge driver throws an error when hpd line is not
> > > > connected to the connector. For such cases, we need an indication for
> > > > no-hpd, using which we can bypass the hpd detection and instead use the
> > > > auxiliary channels connected to the DP connector to confirm the
> > > > connection.
> > > > So add no-hpd property to the bindings, to disable hpd when not
> > > > connected or unusable due to DP0-HPD not connected to correct HPD
> > > > pin on SOC like in case of J721S2.
> > > > 
> > > > Signed-off-by: Rahul T R <r-ravikumar@ti.com>
> > > 
> > > Why are you sending over and over the same? You already got feedback.
> > > Then you send v2. You got the same feedback.
> > > 
> > > Now you send v3?
> > > 
> > > So the same feedback, but this time: NAK
> > 
> > Krzysztof's email forced me to take a look at the actual boards that you
> > are trying to enable. I couldn't stop by notice that the HPD signal
> > _is_ connected to a GPIO pin. Please stop hacking the bridge driver and
> > use the tools that are already provided to you: add the HPD pin to the
> > dp-controller device node. And then fix any possible issues coming from
> > the bridge driver not being able to handle HPD signals being delivered
> > by the DRM framework via the .hpd_notify() callback.
> > 
> > TL;DR: also a NAK from my side, add HPD gpio to dp-controller.
> > 
> We tried implementing a interrupt based HPD functionality as HPD signal is
> connected to GPIO0_18 pin, we were able to get interrupt based HPD working
> however to route this signal to SoC we are loosing audio capability due to
> MUX conflict. Due to board level limitations to
> route the signal to SoC, we will not be able to support interrupt
> based HPD and polling seems a possible way without loosing on audio
> capability.

Still NAK for the no-hpd property. HPD pin is a requirement for
DisplayPort to work, as it is used e.g. for the 'attention' IRQs being
sent by the DP sink. I'm not sure what kind of idea you HW engineers had
in mind.

> Link to schematics zip:
> https://www.ti.com/tool/J721S2XSOMXEVM#design-files
> File:sprr439b/PROC118E4_RP/PROC118E4(001)_SCH.pdf, Page 17, MUX1

-- 
With best wishes
Dmitry

