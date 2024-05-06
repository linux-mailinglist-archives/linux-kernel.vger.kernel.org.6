Return-Path: <linux-kernel+bounces-170191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 545998BD328
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 18:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10090284A75
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E6B156C62;
	Mon,  6 May 2024 16:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NlR0WF+d"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECF2156962
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715014267; cv=none; b=Z5X70mTCxRfExso2toLBN3cHsnb5/D4MMbDDRp3Aq7YCcuB3nVBiRD7fwMxm/QpTwCd0WPy7JMsMNxHfYw5HsdNCXpKTdnMRnMh1O239RQ/mdigQ5PRIpqzQDFm9G1sLB59mHXa0OJ761CgT29dx7MBzCjUpkxV6TX91NG2cihw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715014267; c=relaxed/simple;
	bh=8+i50YterCbwSCR8dhufT5e0/xJ1TjQeaFJDpeKsoMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7+ENF90c7bBlFTP58la1GW8W95qze8mPiHFXZjW7nzwbLPabsA4+aGEjCWT6TJWiyG4Jfc2S+mPctnujQWuQ5000NRZKqnUQViD6XaTy+jpqwMPZ/6KIm7TDgGX+dEz7ntlY0n4Qgg5N1ddE/OUyGNwnAHvZrseKW72g1+FeMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NlR0WF+d; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9596E908;
	Mon,  6 May 2024 18:51:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1715014263;
	bh=8+i50YterCbwSCR8dhufT5e0/xJ1TjQeaFJDpeKsoMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NlR0WF+dBNw/IcKF1IrTZLvIQyl/DjBfUtWWr+XCb3BcSrrOHid5t6h28Y8j8jpIR
	 2EGaeJKVMM1b4qBJ3+v99XTjbBDCqzoeAgYE8gk3J62FreHQzTyO9WSWuNQ/s0LyLG
	 72GoE96KsoL+ueCItx8AUaKTFavKV6c8WOnc+NYw=
Date: Mon, 6 May 2024 19:50:57 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Maxime Ripard <mripard@kernel.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] drm: zynqmp_dp: Lockup in zynqmp_dp_bridge_detect when
 device is unbound
Message-ID: <20240506165057.GD29108@pendragon.ideasonboard.com>
References: <4d8f4c9b-2efb-4774-9a37-2f257f79b2c9@linux.dev>
 <20240504122118.GB24548@pendragon.ideasonboard.com>
 <20240506-charcoal-griffin-of-tact-174dde@houat>
 <20240506073531.GA10260@pendragon.ideasonboard.com>
 <97811bfe-a1fb-419c-a148-74e3d84aa0e2@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <97811bfe-a1fb-419c-a148-74e3d84aa0e2@linux.dev>

On Mon, May 06, 2024 at 10:57:17AM -0400, Sean Anderson wrote:
> On 5/6/24 03:35, Laurent Pinchart wrote:
> > On Mon, May 06, 2024 at 09:29:36AM +0200, Maxime Ripard wrote:
> >> Hi Laurent, Sean,
> >> 
> >> On Sat, May 04, 2024 at 03:21:18PM GMT, Laurent Pinchart wrote:
> >> > On Fri, May 03, 2024 at 05:54:32PM -0400, Sean Anderson wrote:
> >> > > I have discovered a bug in the displayport driver on drm-misc-next. To
> >> > > trigger it, run
> >> > > 
> >> > > echo fd4a0000.display > /sys/bus/platform/drivers/zynqmp-dpsub/unbind
> >> > > 
> >> > > The system will become unresponsive and (after a bit) splat with a hard
> >> > > LOCKUP. One core will be unresponsive at the first zynqmp_dp_read in
> >> > > zynqmp_dp_bridge_detect.
> >> > > 
> >> > > I believe the issue is due the registers being unmapped and the block
> >> > > put into reset in zynqmp_dp_remove instead of zynqmp_dpsub_release.
> >> > 
> >> > That is on purpose. Drivers are not allowed to access the device at all
> >> > after .remove() returns.
> >> 
> >> It's not "on purpose" no. Drivers indeed are not allowed to access the
> >> device after remove, but the kernel shouldn't crash. This is exactly
> >> why we have drm_dev_enter / drm_dev_exit.
> > 
> > I didn't mean the crash was on purpose :-) It's the registers being
> > unmapped that is, as nothing should touch those registers after
> > .remove() returns.
> 
> OK, so then we need to have some kind of flag in the driver or in the drm
> subsystem so we know not to access those registers.

To avoid race conditions, the .remove() function should mark the device
as removed, wait for all ongoing access from userspace to be complete,
and then proceed to unmapping registers and doing other cleanups.
Userspace may still have open file descriptors to the device at that
point. Any new userspace access should be disallowed (by checking the
removed flag), with the only userspace-initiated operations that still
need to run being the release-related operations (unmapping memory,
closing file descriptors, ...).

-- 
Regards,

Laurent Pinchart

