Return-Path: <linux-kernel+bounces-527205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ACCA40869
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 13:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0041A701DF7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D628C20AF7E;
	Sat, 22 Feb 2025 12:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ENxxpIdc"
Received: from mail-m3281.qiye.163.com (mail-m3281.qiye.163.com [220.197.32.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0202066CC;
	Sat, 22 Feb 2025 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740228095; cv=none; b=jcPyKd5YQOCc+NmVgTG7BtysjOttbqWBn2DkB7TQJrAqIOS2dodWN8QRYsLa2Q3DC8KGjkTSlUel1uHKw1vywkjZ8dR+9Jj6LXqYDxeg9GeEAwkHQasDcFvhOD70HpU6z1NyWAhLCPkUSaa0S2/1wGadz5jMTqJoKceLNU4Ot0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740228095; c=relaxed/simple;
	bh=6yispmSF8NEHuiD6p8lfFKKzPSmXUg+uCfdj0up52oo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=bKHW0f7TJBwFFQAtHBHkz0Bs09tmWyxpHCYwtliZevuf/Saz4raps1WIgeEJA83QzicisHOjLYQ7x5/mKYKp7so2LMpN7Gyrwk/ZnTWLT9KcZ4pGu5aairsqm72p5BzpTCPz5td7IDBXbocIvEBJbiyr4+wQfhiyLV+bhDEhMuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ENxxpIdc; arc=none smtp.client-ip=220.197.32.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.26] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id bdb51f7f;
	Sat, 22 Feb 2025 19:25:41 +0800 (GMT+08:00)
Message-ID: <799ccbd2-0c3b-4a55-b47e-1899975c4020@rock-chips.com>
Date: Sat, 22 Feb 2025 19:25:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Damon Ding <damon.ding@rock-chips.com>
Subject: Re: [PATCH v6 08/14] drm/rockchip: analogix_dp: Add support to get
 panel from the DP AUX bus
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 rfoss@kernel.org, vkoul@kernel.org, sebastian.reichel@collabora.com,
 cristian.ciocaltea@collabora.com, l.stach@pengutronix.de,
 dmitry.baryshkov@linaro.org, andy.yan@rock-chips.com, hjc@rock-chips.com,
 algea.cao@rock-chips.com, kever.yang@rock-chips.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
References: <20250123100747.1841357-1-damon.ding@rock-chips.com>
 <20250123100747.1841357-9-damon.ding@rock-chips.com>
 <3340006.44csPzL39Z@diego>
Content-Language: en-US
In-Reply-To: <3340006.44csPzL39Z@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQktJTlZCTR8fSEgaTx5MHh5WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a952d67f14803a3kunmbdb51f7f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NhQ6Agw6HDIKER8cNz4OTxY2
	SFEaFA5VSlVKTE9LSUlITk9ISktIVTMWGhIXVR8aFhQVVR8SFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFKQ0pPNwY+
DKIM-Signature:a=rsa-sha256;
	b=ENxxpIdc+fRY3imBB4Fvef5vOGZG6fA5wJ7ZQJ3/Q4CHHOsDZlC+5/w3k4E3rp5BOTyNBD/acHQvH9bxtM6Ew6mLSBkk31732mwP2INmd+pp5ON4Wv4pZ1/ZSYTKU/EsXsoRaBhyh7otaP6W3DmyJLjc4G1myUF7V4vX7iQqVTg=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=4IlcUWxsBK99tkFDt+EwbEGgFcki2T86lZTSUVVIHWQ=;
	h=date:mime-version:subject:message-id:from;

Hi Heiko,

On 2025/1/31 4:33, Heiko Stübner wrote:
> Hi Damon,
> 
> Am Donnerstag, 23. Januar 2025, 11:07:41 MEZ schrieb Damon Ding:
>> Move drm_of_find_panel_or_bridge() a little later and combine it with
>> component_add() into a new function rockchip_dp_link_panel(). The function
>> will serve as done_probing() callback of devm_of_dp_aux_populate_bus(),
>> aiding to support for obtaining the eDP panel via the DP AUX bus.
>>
>> If failed to get the panel from the DP AUX bus, it will then try the other
>> way to get panel information through the platform bus.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>>
>> ---
> 
>> @@ -450,9 +461,17 @@ static int rockchip_dp_probe(struct platform_device *pdev)
>>   	if (IS_ERR(dp->adp))
>>   		return PTR_ERR(dp->adp);
>>   
>> -	ret = component_add(dev, &rockchip_dp_component_ops);
>> -	if (ret)
>> -		return ret;
>> +	ret = devm_of_dp_aux_populate_bus(analogix_dp_get_aux(dp->adp), rockchip_dp_link_panel);
> 
> This causes an undefined-reference error, so you probably need something like:
> 
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index f9cbbb40b36f..fa946a809858 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -8,6 +8,7 @@ config DRM_ROCKCHIP
>          select DRM_PANEL
>          select VIDEOMODE_HELPERS
>          select DRM_ANALOGIX_DP if ROCKCHIP_ANALOGIX_DP
> +       select DRM_DISPLAY_DP_AUX_BUS if ROCKCHIP_ANALOGIX_DP
>          select DRM_DW_HDMI if ROCKCHIP_DW_HDMI
>          select DRM_DW_HDMI_QP if ROCKCHIP_DW_HDMI_QP
>          select DRM_DW_MIPI_DSI if ROCKCHIP_DW_MIPI_DSI
> 
> 
> 
> 
> 

Yeah, I will add a new separate commit to do it in the next version.

Best regards
Damon


