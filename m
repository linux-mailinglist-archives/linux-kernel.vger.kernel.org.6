Return-Path: <linux-kernel+bounces-437412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5222F9E92EB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBF42857AB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 11:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808EA22256C;
	Mon,  9 Dec 2024 11:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="e8BjV0Gd"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F857221DB7;
	Mon,  9 Dec 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745193; cv=none; b=SzR4Gz/puopZmtC9L1caDd96cSPZ1C8BS/EESVMUjHXHMHZq4h61+S1YzFxvdOtQhZ1Ye4M75Jm1ktW4kmi4KdxY98m4RwIvyq9zoziz8n+V+E1Ej4rZ3AFJUNSZwunvnfCd0tE0ioyZCgXJWU6/v8ZQXhC0IPX3OMtcsUI7kZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745193; c=relaxed/simple;
	bh=asbCCiLuOh7U6iGbLsXWhJlo78FDOpTGTEtz83/J4Kw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qiu8roJFfCV8UjCz/PIr00Y6vmd2au2/YCHFW+Bi5lsyLmmlZygaWbA6LZ0fF/+MfTifW4ZU8f7osm94hm0anEUtavn8K3NVS/TSCL5F/JJ2bFHqpqTkhKyrp3V+uHgtL7mAksWTph0UOIF+nrgXGKcb8iXlw0Wbe+wjK+zvD4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=e8BjV0Gd; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=u0ACcEk1UOUwykRvtHfGsibvZAQHV7WF85gca/fgXtU=;
	b=e8BjV0Gdm8xg1RQT7gFdCEfIB2hmYXk2RxcjvizBiZwTERVncWc3lYh8fh7ESe
	I4ZQ6uzmY2DIi9zRnUCR/Qt4MFonfQuPf5OjgM+0Ema9B1r/ofvoUvE7YtYjnTCP
	dOdwwzXOYsSwA1QrysrBu3zXFFRxzHIA/8jqP6rFtl7yQ=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgBX33HV2VZnbrePBA--.47878S3;
	Mon, 09 Dec 2024 19:51:51 +0800 (CST)
Date: Mon, 9 Dec 2024 19:51:48 +0800
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
Subject: Re: [PATCH v6 6/7] arm64: dts: imx8mp-evk: Add NXP LVDS to HDMI
 adapter cards
Message-ID: <Z1bZ1FvPmjPr3LU5@dragon>
References: <20241112100547.2908497-1-victor.liu@nxp.com>
 <20241112100547.2908497-7-victor.liu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112100547.2908497-7-victor.liu@nxp.com>
X-CM-TRANSID:Ms8vCgBX33HV2VZnbrePBA--.47878S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr45Cr4kuF4UCry7CrWruFg_yoW8JF4DpF
	Wjg3y8Gw10vFZ5Aw1v9w18WwnYvan7Xry8XrnrJw1xGasFkFZ5JrsakF4vv3Wqv3ZxCw1k
	Xwn8X34rGas8Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7xhJUUUUU=
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBAGwZWdWx209gQAAs3

On Tue, Nov 12, 2024 at 06:05:46PM +0800, Liu Ying wrote:
> One ITE IT6263 LVDS to HDMI converter is populated on NXP IMX-LVDS-HDMI
> and IMX-DLVDS-HDMI adapter cards.
> 
> Card IMX-LVDS-HDMI supports single LVDS link(IT6263 link1).
> Card IMX-DLVDS-HDMI supports dual LVDS links(IT6263 link1 and link2).
> 
> Only one card can be enabled with one i.MX8MP EVK.
> 
> Add dedicated overlays to support the below four connections:
> 1) imx8mp-evk-lvds0-imx-lvds-hdmi.dtso:
>    i.MX8MP EVK LVDS0 connector <=> LVDS adapter card J6(IT6263 link1)
> 
> 2) imx8mp-evk-lvds1-imx-lvds-hdmi.dtso:
>    i.MX8MP EVK LVDS1 connector <=> LVDS adapter card J6(IT6263 link1)
> 
> 3) imx8mp-evk-lvds0-imx-dlvds-hdmi-channel0.dtso:
>    i.MX8MP EVK LVDS0 connector <=> DLVDS adapter card channel0(IT6263 link1)
>    i.MX8MP EVK LVDS1 connector <=> DLVDS adapter card channel1(IT6263 link2)
> 
> 4) imx8mp-evk-lvds1-imx-dlvds-hdmi-channel0.dtso:
>    i.MX8MP EVK LVDS1 connector <=> DLVDS adapter card channel0(IT6263 link1)
>    i.MX8MP EVK LVDS0 connector <=> DLVDS adapter card channel1(IT6263 link2)
> 
> Part links:
> https://www.nxp.com/part/IMX-LVDS-HDMI
> https://www.nxp.com/part/IMX-DLVDS-HDMI
> 
> Signed-off-by: Liu Ying <victor.liu@nxp.com>

Applied, thanks!


