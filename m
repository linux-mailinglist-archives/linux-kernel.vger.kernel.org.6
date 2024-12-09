Return-Path: <linux-kernel+bounces-437416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0F99E92F9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C765B28694D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8273A221DA3;
	Mon,  9 Dec 2024 11:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="pPMT6acz"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAE1221D87;
	Mon,  9 Dec 2024 11:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745274; cv=none; b=dkZDKTDufeaLheK18E9eYcD3Y8m10gg512cF4KGpgvPaNq0/iy5Cfz/1gVvC/m3eZwoi9QdPhVLm3EpIqkHlS+LnhJb811mvWV+mPXVH0xuYVslCmXC/ibiukzkF7EHlVUBGZz8YmuTE8MYHBrpEMN7hCTdMRu0iq4QtaADZDfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745274; c=relaxed/simple;
	bh=JATDnXxIw4ps6VbfWy9O0/mdWb8P5+bessEHfg+7AXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ng3QVg2O/ZuVq5d4bbH4ISi9mmzvE3Illu80//D9XK5BatR4XcdyXimMBTgNa5jU508a52dsm/Opg9iS1hVGZuA5Rl9bQ8dwtW6lDgkfLMvLpsPKSN2/gl4csJHhiOzCNsNl7CGHSv3tNcrE1dyQU+ampDfxIMpNRWQv4K3RT5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=pPMT6acz; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=9YFBKvdle0l8WYYtUgX7JaCFYCO3nh7exjS+lwB+V18=;
	b=pPMT6aczMRxqEoN5iIcFKQZ2Rcche8mg9BHFtGM2py0ENvhf5/YI66MtzJWYhL
	hST/2Fz5B56swjXNtVHCH7Vf85j4ppB2zopIucpRaUrnM54v9ytADTRz07YKNPmt
	rqiIVl1h/WdqYgeDDw6kQdKRmghczxih3miBe8rZU8lV0=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDHbODn2VZnjriPBA--.47417S3;
	Mon, 09 Dec 2024 19:52:10 +0800 (CST)
Date: Mon, 9 Dec 2024 19:52:07 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: Liu Ying <victor.liu@nxp.com>
Cc: imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
	abelvesa@kernel.org, peng.fan@nxp.com, mturquette@baylibre.com,
	sboyd@kernel.org, andrzej.hajda@intel.com,
	neil.armstrong@linaro.org, rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
	jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
	simona@ffwll.ch, quic_bjorande@quicinc.com, geert+renesas@glider.be,
	dmitry.baryshkov@linaro.org, arnd@arndb.de, nfraprado@collabora.com,
	marex@denx.de
Subject: Re: [PATCH v6 7/7] arm64: defconfig: Enable ITE IT6263 driver
Message-ID: <Z1bZ57fn/upwHWQ5@dragon>
References: <20241112100547.2908497-1-victor.liu@nxp.com>
 <20241112100547.2908497-8-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112100547.2908497-8-victor.liu@nxp.com>
X-CM-TRANSID:Ms8vCgDHbODn2VZnjriPBA--.47417S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUr2NtUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBAGwZWdWx209gQABs2

On Tue, Nov 12, 2024 at 06:05:47PM +0800, Liu Ying wrote:
> ITE IT6263 LVDS to HDMI converter is populated on NXP IMX-LVDS-HDMI
> and IMX-DLVDS-HDMI adapter cards.  The adapter cards can connect to
> i.MX8MP EVK base board to support video output through HDMI connectors.
> Build the ITE IT6263 driver as a module.
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Applied, thanks!


