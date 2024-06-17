Return-Path: <linux-kernel+bounces-216735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 998E490A56A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3306D2881F9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4391836F7;
	Mon, 17 Jun 2024 06:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="EnkGWtZ2";
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="haR6HAg1"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39A014AA0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605405; cv=none; b=I3RVcz61mVp6ZEbnkQop47KShSXcC1hFsT6RUwpf0bdLrc4PCNEZ80M+mnhVRr8mDFIEUWgxbgplt4a5oBQ7jsDLo+E323U74+gKfSzqB1jcAzcLeSphT7bgmxV4c9SoPxRgStSWGQzDvsJbik/DYq5wBHWZsZ/6FF94bJSIbM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605405; c=relaxed/simple;
	bh=VWekmmnDCFhOysdFb3773YHoJmKjjDsvt2a9l5bgUHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZ4NJN+FpZxwbe8oo6dAbyePiHs8SpN5qW6WihPUrxy6MkSUBdv0VocH7cDqJtfsWkKKI833hbnluBrCsKT3585lfRMqapfY3h+WO+h8O92F1xgJo6gTje2X9bsdB5A1SCbOCdA0NTlyqb7tFzq69CBWrV+aCKlYQacI7JYFYq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=EnkGWtZ2; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=haR6HAg1; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=atmark-techno.com;
	s=gw2_bookworm; t=1718605020;
	bh=VWekmmnDCFhOysdFb3773YHoJmKjjDsvt2a9l5bgUHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EnkGWtZ2jbLV3qyBdkd8CvZ0lpVZwFLsywA9MXNd3yf2G4HIGW6gD33wZg/UhLohz
	 JDqA1UrBpuxGyZhpAnXjQiWQ7Pnp9/m7nYtrhUpv17o7MvlzdVXOGMLDBLJv+yBRhY
	 K875FUOAJq/8njZMIxXbP1MeKxtUB8/jMQwLDOPUPGyCpakDVepsobiXgbaA82toY+
	 DhW/HacbGL1tFIe/29UyUY4Zze9G0wd+PAnCmpfPPZinfoqIMbrDWlByqdTFFBGr6Y
	 2feQus7fm698K3SFNY5VDkxZU3bQYErRRJIt5E4Ag9gLbM8N/bSpFabvDLwYoJA3Fz
	 QhUdDJCGNKY3Q==
Received: from gw2.atmark-techno.com (localhost [127.0.0.1])
	by gw2.atmark-techno.com (Postfix) with ESMTP id AB91AAA9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:17:00 +0900 (JST)
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=haR6HAg1;
	dkim-atps=neutral
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id BD455A6A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 15:16:57 +0900 (JST)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1f6ea6afba0so37122945ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 23:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1718605017; x=1719209817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=60zeZXWHXHBwDs11QTLBG22SVSiDpOOF7b1DAQhvIYU=;
        b=haR6HAg1ZtKMDLCyFRQgvNavgEJnRN56Q3r/ZslI3J81O4dmozkVEctMrc25rYORrl
         RO2g0mnVD5h6+L+9FRIXg795me8SYsNqOiouJZOISvv0r8ABFQdTSMYgZIrqN235Ms8J
         PEGPLr3ouJCN21Wu/zPIDk8cYkDTiBqrfoQd/xLyDHD86fg4zYA+ZIzyRT7XrLQegdoi
         mjxeNK7s4GtMfT1NbNt5vrwpVQshIwGIv1phVNLp4xwfMRg8Fyt0iD/KBmif4fHfyzht
         IPeGtDJbNzBs3DSujNHQVRPOrf9nohx0kuxtDmKxgUiTIOo0nZZs8kmEiABYbjfdLbUn
         ksKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718605017; x=1719209817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60zeZXWHXHBwDs11QTLBG22SVSiDpOOF7b1DAQhvIYU=;
        b=ivfF9mhSp8OIETlQoqbBNFqc7y7HEqcPROV4jsSk5YZSbINuKipWdKmkvN2QFFAKJj
         I81QTA4ynXGLS6/+icMiZOlcK0sQeaMWLrg9LzdPfyEd9WFVB7QwtGWFoZuNGsy5tIyp
         QiNz1eh4an70tjIEucl2dyDxB+x2dHyjzVCsbwAB074hbJBsmEWlK56PkvjsHieCZdtl
         GbuUNpZxg1OtjvJmwbD95xeoR5CxH/8f3z95P6zqK8toNelseaDJJraEexaQcob+ogvE
         kpWzSBfiRinbzp65tsUJ2vPFYlycakMqJ7dEkHONLdW/G6uzer3B/+zv9Cz3hPFQTkMI
         w8yw==
X-Forwarded-Encrypted: i=1; AJvYcCVwtbet6Kz3Ow6JOdBtbYZFcCUsY+pDv27CYCNPnQnnwxymV+GNDhmeQNRh9ufEhljUKr3Y8dApvpya1fBXXWfv3OCsPFN6Bod4znK6
X-Gm-Message-State: AOJu0YxIc1tc5VzEM+Y5rQuUI8iKmIQjvEPhuQjo7oKRX67SPkrOD9sk
	5hVUP/Ko6AsPQ7e1Q4rIKpYBTusFW6X8JzCUN7WKcoUY80PLFVnArBMjnSERtZTjHiNZrJVfQGV
	7WECCa3PkD2gMrGXTv1KjXLSdyGEAb89GMImW1hpJAl+Vd5O8R4C5Mx0nsnbkVFs=
X-Received: by 2002:a17:903:230c:b0:1f6:f318:71d7 with SMTP id d9443c01a7336-1f84e2ecf4amr202295575ad.19.1718605016623;
        Sun, 16 Jun 2024 23:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGupfMdS0WD6NixTdYr6ZfcWEtMhu5SpstN18VssrHrcsQGhmU5k6sNEo7ckq0TCT9O5Tg9zA==
X-Received: by 2002:a17:903:230c:b0:1f6:f318:71d7 with SMTP id d9443c01a7336-1f84e2ecf4amr202295225ad.19.1718605016152;
        Sun, 16 Jun 2024 23:16:56 -0700 (PDT)
Received: from pc-0182.atmarktech (35.112.198.104.bc.googleusercontent.com. [104.198.112.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f1b146sm73170955ad.244.2024.06.16.23.16.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2024 23:16:55 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1sJ5fi-009Sm5-23;
	Mon, 17 Jun 2024 15:16:54 +0900
Date: Mon, 17 Jun 2024 15:16:44 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Lucas Stach <l.stach@pengutronix.de>, Adam Ford <aford173@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, marex@denx.de,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Liu Ying <victor.liu@nxp.com>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Makoto Sato <makoto.sato@atmark-techno.com>
Subject: drm/bridge/imx8mp-hdmi-tx: Allow inexact pixel clock frequencies
 (Was: [PATCH V8 10/12] drm/bridge: imx: add bridge wrapper driver for
 i.MX8MP DWC HDMI)
Message-ID: <Zm_UzO4Jmm7Aykcm@atmark-techno.com>
References: <20240203165307.7806-1-aford173@gmail.com>
 <20240203165307.7806-11-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240203165307.7806-11-aford173@gmail.com>

Adam Ford wrote on Sat, Feb 03, 2024 at 10:52:50AM -0600:
> From: Lucas Stach <l.stach@pengutronix.de>
> 
> Add a simple wrapper driver for the DWC HDMI bridge driver that
> implements the few bits that are necessary to abstract the i.MX8MP
> SoC integration.

Hi Lucas, Adam,
(trimmed ccs a bit)

First, thank you for the effort of upstreaming all of this!! It's really
appreciated, and with display working I'll really be wanting to upstream
our DTS as well as soon as I have time (which is going to be a while,
but better late than never ?)

Until then, it's been a few months but I've got a question on this bit:

> diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> new file mode 100644
> index 000000000000..89fc432ac611
> --- /dev/null
> +++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
> +static enum drm_mode_status
> +imx8mp_hdmi_mode_valid(struct dw_hdmi *dw_hdmi, void *data,
> +		       const struct drm_display_info *info,
> +		       const struct drm_display_mode *mode)
> +{
> +	struct imx8mp_hdmi *hdmi = (struct imx8mp_hdmi *)data;
> +
> +	if (mode->clock < 13500)
> +		return MODE_CLOCK_LOW;
> +
> +	if (mode->clock > 297000)
> +		return MODE_CLOCK_HIGH;
> +
> +	if (clk_round_rate(hdmi->pixclk, mode->clock * 1000) !=
> +	    mode->clock * 1000)
> +		return MODE_CLOCK_RANGE;

Do you know why such a check is here?

When plugging in a screen with no frequency identically supported in its
EDID this check causes the screen to stay black, and we've been telling
customers to override the EDID but it's a huge pain.

Commit 6ad082bee902 ("phy: freescale: add Samsung HDMI PHY") already
"fixed" the samsung hdmi phy driver to return the next frequency if an
exact match hasn't been found (NXP tree's match frequencies exactly, but
this gets the first clock with pixclk <= rate), so if this check is also
relaxed our displays would work out of the box.

I also don't see any other bridge doing this kind of check.
drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c has a similar check with a
0.5% leeway, and all the other drivers don't check anything.
If you want to add some level of safety, I think we could make this work
with a 5% margin easily... Printing a warning in dmesg could work if
you're worried about artifacts, but litteraly anything is better than a
black screen with no error message in my opinion.


In practice the screen I'm looking at has an EDID which only supports
51.2MHz and the closest frequency supported by the Samsung HDMI phy is
50.4MHz, so that's a ~1.5% difference and it'd be great if it could work
out of the box.

For reference, the output of edid-decode is as follow:
---
edid-decode /sys/devices/platform/display-subsystem/drm/car
d1/card1-HDMI-A-1/edid
edid-decode (hex):

00 ff ff ff ff ff ff 00 3a 49 03 00 01 00 00 00
20 1e 01 03 80 10 09 00 0a 00 00 00 00 00 00 00
00 00 00 00 00 00 01 01 01 01 01 01 01 01 01 01
01 01 01 01 01 01 00 14 00 40 41 58 23 20 a0 20
c8 00 9a 56 00 00 00 18 00 00 00 10 00 00 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 10 00 00
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 10
00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 9a

----------------

Block 0, Base EDID:
  EDID Structure Version & Revision: 1.3
  Vendor & Product Identification:
    Manufacturer: NRI
    Model: 3
    Serial Number: 1
    Made in: week 32 of 2020
  Basic Display Parameters & Features:
    Digital display
    Maximum image size: 16 cm x 9 cm
    Gamma: 1.00
    RGB color display
    First detailed timing is the preferred timing
  Color Characteristics:
    Red  : 0.0000, 0.0000
    Green: 0.0000, 0.0000
    Blue : 0.0000, 0.0000
    White: 0.0000, 0.0000
  Established Timings I & II: none
  Standard Timings: none
  Detailed Timing Descriptors:
    DTD 1:  1024x600    59.993 Hz 128:75   38.095 kHz  51.200 MHz (154 mm x 86 m
m)
                 Hfront  160 Hsync  32 Hback 128 Hpol N
                 Vfront   12 Vsync   8 Vback  15 Vpol N
    Dummy Descriptor:
    Dummy Descriptor:
    Dummy Descriptor:
Checksum: 0x9a
---


Thanks,
-- 
Dominique Martinet



