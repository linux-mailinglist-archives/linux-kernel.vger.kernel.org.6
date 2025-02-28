Return-Path: <linux-kernel+bounces-539094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D44A4A0C0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 18:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74BF71894EE8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 17:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6AE15ECDF;
	Fri, 28 Feb 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="pdiHPkkE"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6891F4CAE
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764748; cv=none; b=EOCTZrqwZ2rUrldH01ApBvUf7Ancbn0/sj0qTmiFhmB5ZHVdbS8tM5bvGP4eQfkRDUdZV1Qwm+cQ1NyeTBIbPcf4HUXaGkdmKzT4Z4SIXBJ7rpD5yXEm3/5DU7g9bJH4TL3bQRcKaX4l8X09TySvqStV1AW0tXjSlYObvrAXSao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764748; c=relaxed/simple;
	bh=Oexzj45eDDLb7CM0yQXdUWz7owDZR6EzgT2UtAZrmGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Auewbx0jZd6QTY4lPFJ25ZAxRmArgDrV4wZimrdgffYlfYhkbZvWNSSJH9Be/dLUFf1LYMWUSL3C/toj4I+ik+2sueeE/0dAyb7gp7mmrajGi0DcUgrzBFXAstjnw03xmMDpDZzlVBCZlLD91tRrj4qTu7/5ly5dfKrSAc7wOUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=pdiHPkkE; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2sRrVQmgK0R2z5wr+aIoaoWSaXv+nBUPnIdA1TCMyRA=; b=pdiHPkkEaE+yoXVffSrekcrk2V
	UceJy7SUF5Xqf9FVYJVBFcEljZXjL6AzMHraNIeHXyC57VQJr2RbKWuxDhqzlcAWUZM/Hi8/8jClL
	p8hMC5A3Wi0Hny1px+xu7OJlmwfsnmVM7Hr4TUTKeZJP5MEinS2qX5h1v1tRLoR9W+nO4nXTBen0M
	CBq3GRbWZNcikLjc39IpKeN3aB7grOAwCjD+AVg7sylF3V9csGTviacBu6KhOsQ79S0FHpkAl/vvy
	thDh212CzjTRYjY/DLxfNz+itc5hwTtOtqE6+T3cIppLTZCAfGXFWWgezZqs3S3jgg466v8JLXXcB
	UPvwwgSA==;
Received: from i53875b47.versanet.de ([83.135.91.71] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1to4QV-0002Po-0K; Fri, 28 Feb 2025 18:45:31 +0100
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: andy.yan@rock-chips.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH 2/2] drm/rockchip: lvds: Hide scary error messages on probe
 deferral
Date: Fri, 28 Feb 2025 18:45:30 +0100
Message-ID: <3032732.6M6d0yLqnL@diego>
In-Reply-To: <b09e5470-2392-4557-9f13-62b6586e5c7b@cherry.de>
References:
 <20250228165755.405138-1-heiko@sntech.de>
 <20250228165755.405138-3-heiko@sntech.de>
 <b09e5470-2392-4557-9f13-62b6586e5c7b@cherry.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Am Freitag, 28. Februar 2025, 18:42:32 MEZ schrieb Quentin Schulz:
> Hi Heiko,
> 
> On 2/28/25 5:57 PM, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@cherry.de>
> > 
> > Commit 52d11c863ac9 ("drm/rockchip: lvds: do not print scary message when
> > probing defer") already started hiding scary messages that are not relevant
> > if the requested supply just returned EPROBE_DEFER, but there are more
> > possible sources - like the phy.
> > 
> > So modernize the whole logging in the probe path by replacing the
> > remaining deprecated DRM_DEV_ERROR with appropriate dev_err(_probe)
> > and drm_err calls.
> > 
> > The distinction here is that all messages talking about mishaps of the
> > lvds element use dev_err(_probe) while messages caused by interaction
> > with the main Rockchip drm-device use drm_err.
> > 
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>

> > @@ -604,8 +602,8 @@ static int rockchip_lvds_bind(struct device *dev, struct device *master,
> >   
> >   	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_LVDS);
> >   	if (ret < 0) {
> > -		DRM_DEV_ERROR(drm_dev->dev,
> > -			      "failed to initialize encoder: %d\n", ret);
> > +		drm_err(drm_dev,
> > +			"failed to initialize encoder: %d\n", ret);
> 
> All the above are using dev_err, but starting here, it's drm_err, is 
> that on purpose?

The last paragraph of the commit message was supposed to explain that
(which it seemingly did poorly :-) ) :

> > The distinction here is that all messages talking about mishaps of the
> > lvds element use dev_err(_probe) while messages caused by interaction
> > with the main Rockchip drm-device use drm_err.




