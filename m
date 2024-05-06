Return-Path: <linux-kernel+bounces-169422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692BE8BC870
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2402B2819BD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377AC13774B;
	Mon,  6 May 2024 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="P93j5mis"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F2C127E3B
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714980943; cv=none; b=eUBMSDHS8LsiXBxTu5BEcSWw/CmoYPxQIv+aLV0w7egQWqDERULD9Bje6Nah5K/cnHcEws8weBQMI551fGFZc5TrzvhFvhawz5GKvx0oyExayrPwq4FOEqACK7gnJMMHdRUw/g/BJLVzKOopLkure04g87W/Zp7kH14ci5PEhKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714980943; c=relaxed/simple;
	bh=n5+hynqpfyw2VkPWlAy7ChrItQVLYJ1f8V2xfUMm5QY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHZ9a6fj+fKLSqhwwIQlXijx93pjvSf8uCMj4PpDO/XXrByA0IX0AZXJDOTiZvr768cnqo6IDJtPns8O5CrjXQJZrnAWX/Y6TtSWhf9FFrQ/vsoTQBiRhbM3TO8WldG3Dzo5jRT9oFujjy3/AspDOHBu8Sjm3dckvMhXUeCms6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=P93j5mis; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E680E836;
	Mon,  6 May 2024 09:35:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1714980938;
	bh=n5+hynqpfyw2VkPWlAy7ChrItQVLYJ1f8V2xfUMm5QY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P93j5missxNkHoWP51IhSnZa8MCPh3t/vBhIXL35U4+LIY1WxMC85iW/7gPR5ag+q
	 Ei6nFmCIqZu+Z18Sz8zHujvK6+mJlOSjVJ26XDeFa14VDvEGXjX+HsL0F699WeViiD
	 j4NGIH+aSGJDDyQcwg1vYoqYqGLAe6Bh7h6hBJIM=
Date: Mon, 6 May 2024 10:35:31 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] drm: zynqmp_dp: Lockup in zynqmp_dp_bridge_detect when
 device is unbound
Message-ID: <20240506073531.GA10260@pendragon.ideasonboard.com>
References: <4d8f4c9b-2efb-4774-9a37-2f257f79b2c9@linux.dev>
 <20240504122118.GB24548@pendragon.ideasonboard.com>
 <20240506-charcoal-griffin-of-tact-174dde@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240506-charcoal-griffin-of-tact-174dde@houat>

On Mon, May 06, 2024 at 09:29:36AM +0200, Maxime Ripard wrote:
> Hi Laurent, Sean,
> 
> On Sat, May 04, 2024 at 03:21:18PM GMT, Laurent Pinchart wrote:
> > On Fri, May 03, 2024 at 05:54:32PM -0400, Sean Anderson wrote:
> > > I have discovered a bug in the displayport driver on drm-misc-next. To
> > > trigger it, run
> > > 
> > > echo fd4a0000.display > /sys/bus/platform/drivers/zynqmp-dpsub/unbind
> > > 
> > > The system will become unresponsive and (after a bit) splat with a hard
> > > LOCKUP. One core will be unresponsive at the first zynqmp_dp_read in
> > > zynqmp_dp_bridge_detect.
> > > 
> > > I believe the issue is due the registers being unmapped and the block
> > > put into reset in zynqmp_dp_remove instead of zynqmp_dpsub_release.
> > 
> > That is on purpose. Drivers are not allowed to access the device at all
> > after .remove() returns.
> 
> It's not "on purpose" no. Drivers indeed are not allowed to access the
> device after remove, but the kernel shouldn't crash. This is exactly
> why we have drm_dev_enter / drm_dev_exit.

I didn't mean the crash was on purpose :-) It's the registers being
unmapped that is, as nothing should touch those registers after
remove() returns.

-- 
Regards,

Laurent Pinchart

