Return-Path: <linux-kernel+bounces-168645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE28B8BBB30
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 14:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FF592815DD
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 12:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7AB21342;
	Sat,  4 May 2024 12:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OgN+LpJm"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FF5F513
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714825289; cv=none; b=hGaRJzwXbugvXYVAQtq2HksMvhoBpeQie0p5v56wCMgtShYql9/D2vVgGXO5LXWxIBj5/HxtLYGmayX1S+9dtPe+7HPijyfOf253Qgmhpn1NUwFonSSq9R7JK5+JUZ2SUDfkSgh1QMFPP8ojyBCao2Oxt9rtUGVSmty7oVaiXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714825289; c=relaxed/simple;
	bh=Hwf6BwiJa8ZRxoW+TR/H4hruqs8CRpJc1VnyKBbiGLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TCHpO5CwG5olIYeRQifQoVhDXz6mlVWSDCc4DB2ci0N5WiZKxPTjH0+QEkm7FEGIC6DpCE6VUwS7/rNapK4JQwT6nWNfSZlmclexqRWCNkhdiXEV4dDjJE3IYliGlLzM+LdQJBw9LOcTyYU93AJKf8Yw52Buq5YMpL11QLzDAmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=OgN+LpJm; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id E2289B3;
	Sat,  4 May 2024 14:20:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1714825227;
	bh=Hwf6BwiJa8ZRxoW+TR/H4hruqs8CRpJc1VnyKBbiGLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OgN+LpJmEuZCtUZsnj50UvM5nLmbhhPB3Rtk0Z6H0L7WxvSULUZG3FpSsTUk835FC
	 H+Eku077+HaStlFLbIlSevJAv1XmXv4JSRo4Awsr8xElI0VWeI+25QCTgKHSqOFAQ2
	 tvwMbCpMYXlAm44Ad33ocqilgINQ7wPXsQ2Gmb9M=
Date: Sat, 4 May 2024 15:21:18 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Michal Simek <michal.simek@amd.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] drm: zynqmp_dp: Lockup in zynqmp_dp_bridge_detect when
 device is unbound
Message-ID: <20240504122118.GB24548@pendragon.ideasonboard.com>
References: <4d8f4c9b-2efb-4774-9a37-2f257f79b2c9@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d8f4c9b-2efb-4774-9a37-2f257f79b2c9@linux.dev>

Hi Sean,

On Fri, May 03, 2024 at 05:54:32PM -0400, Sean Anderson wrote:
> Hi,
> 
> I have discovered a bug in the displayport driver on drm-misc-next. To
> trigger it, run
> 
> echo fd4a0000.display > /sys/bus/platform/drivers/zynqmp-dpsub/unbind
> 
> The system will become unresponsive and (after a bit) splat with a hard
> LOCKUP. One core will be unresponsive at the first zynqmp_dp_read in
> zynqmp_dp_bridge_detect.
> 
> I believe the issue is due the registers being unmapped and the block
> put into reset in zynqmp_dp_remove instead of zynqmp_dpsub_release.

That is on purpose. Drivers are not allowed to access the device at all
after .remove() returns.

> This
> could be resolved by deferring things until zynqmp_dpsub_release
> (requiring us to skip devm_*), or by adding a flag to struct zynqmp_dp
> and checking it before each callback. A subsystem-level implementation
> might be better for the latter.
> 
> For a better traceback, try applying the below patch and running the
> following commands before triggering the lockup:
> 
> echo 4 > /sys/module/drm/parameters/debug
> echo 8 > /proc/sys/kernel/printk
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_dp.c b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> index 9df068a413f3..17b477b14ab5 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_dp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_dp.c
> @@ -296,6 +296,7 @@ struct zynqmp_dp_config {
>   * @train_set: set of training data
>   */
>  struct zynqmp_dp {
> +       unsigned long long magic;
>         struct device *dev;
>         struct zynqmp_dpsub *dpsub;
>         void __iomem *iomem;
> @@ -1533,6 +1534,8 @@ static enum drm_connector_status zynqmp_dp_bridge_detect(struct drm_bridge *brid
>         u32 state, i;
>         int ret;
>  
> +       WARN_ON(dp->magic != 0x0123456789abcdefULL);
> +
>         /*
>          * This is from heuristic. It takes some delay (ex, 100 ~ 500 msec) to
>          * get the HPD signal with some monitors.
> @@ -1723,6 +1726,7 @@ int zynqmp_dp_probe(struct zynqmp_dpsub *dpsub)
>         if (!dp)
>                 return -ENOMEM;
>  
> +       dp->magic = 0x0123456789abcdefULL;
>         dp->dev = &pdev->dev;
>         dp->dpsub = dpsub;
>         dp->status = connector_status_disconnected;
> @@ -1839,4 +1843,5 @@ void zynqmp_dp_remove(struct zynqmp_dpsub *dpsub)
>  
>         zynqmp_dp_phy_exit(dp);
>         zynqmp_dp_reset(dp, true);
> +       dp->magic = 0xdeadbeefdeadbeefULL;
>  }

-- 
Regards,

Laurent Pinchart

