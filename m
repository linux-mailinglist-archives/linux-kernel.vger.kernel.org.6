Return-Path: <linux-kernel+bounces-438547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C189EA285
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 00:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52CAA1888819
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 23:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1E19F40B;
	Mon,  9 Dec 2024 23:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="f8M1mNgQ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB12A19EEA1;
	Mon,  9 Dec 2024 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785965; cv=none; b=JvG2pwE7c0Bq1myMgnOzL+zeVwj29HlYy5SqO271hCL6T//WeeVKxPQZwPAYFP9NsudSqcrThiVvPIbRBtna7Fd82J+GR7vNY6/kIqrnRkHDinlP37p2ynf9/tqB73cXXCJG71PZlqibn0lldkJQ8iyjY540E1YEfpSJpfGRet8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785965; c=relaxed/simple;
	bh=dgzsXhW+dht9rD6bBdaFz41KpF8ixsVN/6bc7mx7N8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eMoP/et4njwZeFjkFTd/64Mm5SxenVtQKe3KIeZFQzcIG8Zoe8DMUhiCpjppCAGu7gwBwSB9jGnRvtrz2zUqp7xKmxQURo8S7ZjIlnjZaOQhrygGbZwbRuzxl12oK7E3NRpC79tiR/2GWpKkaoA55j+zSN3hWSYI9ka6BkDE59g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=f8M1mNgQ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gyJVyur4IyAHn8poAWBypTH6jYDB+Nwxko92c/qdMK4=; b=f8M1mNgQdC5wIM/8vQdHwqvNYz
	UBUAZDSqr1Cx/7P6DJj40JCUWj7hqJcV9If4OpxdSUG+xbTvK67o9NxJk7uPNSpHuZoGU4SDBQNE9
	w9Q5s7iDS7JKUA8T/LBsnfd5TDd9lkJ59Z66FeB36Yb8clf+39Pu6P2Jb/3dS+wcQj9rTvDDhAN91
	pLSAIU8oxDl1HA7oAzSF/op5UCW/DGoOXk3HNtydhi3PK1q4DYpmedSiwqW7rE20MGeguXcVr2K08
	6DO8lty+Naoovses0nzvGjkd/4oW5eHLIUukRjQ7a27FqoJ3OZajanfclUYYBt1iLOlbOc+N919Uv
	7t7yk0Og==;
Received: from i53875bc4.versanet.de ([83.135.91.196] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tKmvT-0005Hj-UT; Tue, 10 Dec 2024 00:12:27 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Daniel Semkowicz <dse@thaumatec.com>,
 Diederik de Haas <didi.debian@cknow.org>, andy.yan@rock-chips.com
Cc: Laurent.pinchart@ideasonboard.com, andrzej.hajda@intel.com,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com, jonas@kwiboo.se,
 krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 neil.armstrong@linaro.org, quentin.schulz@cherry.de, rfoss@kernel.org,
 robh@kernel.org, tzimmermann@suse.de
Subject:
 Re: [PATCH v3 0/3] drm/rockchip: Add driver for the new DSI2 controller
Date: Tue, 10 Dec 2024 00:12:26 +0100
Message-ID: <2203458.KiezcSG77Q@diego>
In-Reply-To: <D67AV178CEBD.3QA9VD4ZPRNQ1@cknow.org>
References:
 <20241203165450.1501219-1-heiko@sntech.de>
 <20241209150619.33998-1-dse@thaumatec.com>
 <D67AV178CEBD.3QA9VD4ZPRNQ1@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 9. Dezember 2024, 17:11:03 CET schrieb Diederik de Haas:
> Hi,
> 
> On Mon Dec 9, 2024 at 4:06 PM CET, Daniel Semkowicz wrote:
> > On 03.12.24 21:54, Heiko Stuebner wrote:
> > > This series adds a bridge and glue driver for the DSI2 controller found
> > > in the rk3588 soc from Rockchip, that is based on a Synopsis IP block.
> > > 
> >
> > I did more tests with different LVDS displays. I tested following
> > configurations with DSI/LVDS bridge:
> > - 1024x600@60.01
> > - 1024x768@60.02
> > - 1280x800@60.07
> > - 1366x768@60.06
> >
> > All of them worked without issues, except 1366x768.
> > With this resolution, video is blurry, and offset incorrectly
> > to the left. There are also repeating errors on the console:
> >
> >   rockchip-drm display-subsystem: [drm] *ERROR* POST_BUF_EMPTY irq err at vp3
> >
> > In correct operation with other resolutions, there is no error.
> > I am not sure if this is a problem in your series or rather in VOP2
> > driver.

This really sounds like something is wrong on the vop side.
The interrupt is part of the vop, the divisable by 4 things likely too.


Heiko


> 
> On my PineTab2 I got similar messages about 2 weeks ago:
> rockchip-drm display-subsystem: [drm] *ERROR* POST_BUF_EMPTY irq err at vp1
> 
> Preceding those, I got several panfrost related errors:
> 
> panfrost fde60000.gpu: get clock failed -517
> panfrost fde60000.gpu: clk init failed -517
> platform fde60000.gpu: deferred probe pending: (reason unknown)
> platform cpufreq-dt: deferred probe pending: (reason unknown)
> vdd_gpu_npu: disabling
> 
> But can also be that the PineTab2 (likely) needs regulator-always-on
> and regulator-boot-on in its vdd_gpu_npu node.
> 
> > I tried to track down the problem, and it seems to be a generic issue
> > when horizontal line width is not divisible by 4.
> > Lowering line width to 1364px fixes the issue, but of course I have two
> > vertical lines of black pixels on the right.
> > I also made some tests with 720x1280 DSI display. Lowering horizontal
> > line to 718px shows the same problem. With 720px and 716px it works
> > correctly.
> 
> I haven't look further into it, but the PT2 has a 1280x800 resolution.
> 
> HTH,
>   Diederik
> 





