Return-Path: <linux-kernel+bounces-285015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D661895082C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1071F1C23523
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ED719EEC2;
	Tue, 13 Aug 2024 14:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b="hZabVRNG"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8691D68F;
	Tue, 13 Aug 2024 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560613; cv=pass; b=UvJecEVd7rAOHCF/S1lqkpJlRMpn5Y+mH21KSVA1OccCTbb8JZqAzEnPlTJPxMbpwFL7NKnLfMqxWRP6o2+LTgyRiGO/RHXj2vBgZWqWAhia1bWhJavjg2JXjmxYwwOrGqHkJKpP97j+0Wgu36bVWvruE6dA9BPilUR5gZjztT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560613; c=relaxed/simple;
	bh=Fvs1HYZBexbouWaS6ZUlUl311ZjGY+pLddnkICNsEy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HXBQ8lVULkDYDeu432u41zm+oCkwPHomOF998FcgYjyO1ET3pnaG2ZIVdNmyG0CtAuhfRNmDoYv2eBvGdCSskB+L+NPKyAIPkUTEkrDxURId1XUVt8wEQSVNiPHAa9vZJu7949ig6A7ZXAzFfTRETTd0g/5/fT5sCyB5PHo1WQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=cristian.ciocaltea@collabora.com header.b=hZabVRNG; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Delivered-To: kernel@collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723560555; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=T7k15fzR6ZeRas0Yws11RUsu/Wmry+zxDI8dDDUpMt6uIXhI4Dm5BdHluSIP5n9ucncwQrMpEe11BIQ6iamc+2ld0Q+wj6APeZoVS1yMKVLJPvhbEj0oDBHes7BO1qpxgQe+sK7CsqL9Ofpo8jDgSbB7v5URQsbhfsyzb2AbbYQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723560555; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9A8PfA0lD2m3WJCSallRUQuWCv07fL5sTjlZMRnm8cE=; 
	b=acrygEnLK2dju+kCdrgd+KXQpuhTfuWEkzj6AE1WIxltzT2Or4BNuk17I/GeyC4od5LImQ2oSLCE1a+aAIwu548TRJ90ckgHiMu9jyqyJbf0dBbnPAuHsw8RE3UMl6cM/rReV/4NRfFzWIcA72lja6yJ8r6aDmKlZcUEs6Gg1zE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=cristian.ciocaltea@collabora.com;
	dmarc=pass header.from=<cristian.ciocaltea@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723560555;
	s=zohomail; d=collabora.com; i=cristian.ciocaltea@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9A8PfA0lD2m3WJCSallRUQuWCv07fL5sTjlZMRnm8cE=;
	b=hZabVRNGAAs7o4UBRDD+FaffzLp2vM5Om2YbqE0tOUMSwyN7yioHL4IiXmoehtp/
	lv4l5yX3nQSrIsQNmMHeF9dCMTC5hM4gznjBXqSwSt9sVIgYFTXoXMEzzgb9ZQw7yXb
	PWf0MxhjGZSsg/lGzKPTZ8AaOt5Uj+JdQN+HZ0HU=
Received: by mx.zohomail.com with SMTPS id 1723560553528681.1259506022782;
	Tue, 13 Aug 2024 07:49:13 -0700 (PDT)
Message-ID: <05d1af7a-0bea-464f-a551-3fd8bf5ea9d5@collabora.com>
Date: Tue, 13 Aug 2024 17:49:06 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] Add initial support for the Rockchip RK3588 HDMI
 TX Controller
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, kernel@collabora.com,
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>,
 Algea Cao <algea.cao@rock-chips.com>
References: <20240807-b4-rk3588-bridge-upstream-v3-0-60d6bab0dc7c@collabora.com>
 <2006431.fxN4lLDhpz@diego>
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Content-Language: en-US
In-Reply-To: <2006431.fxN4lLDhpz@diego>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 8/13/24 4:17 PM, Heiko Stübner wrote:
> Am Mittwoch, 7. August 2024, 13:07:22 CEST schrieb Cristian Ciocaltea:
>> The Rockchip RK3588 SoC family integrates the Synopsys DesignWare HDMI
>> 2.1 Quad-Pixel (QP) TX controller, which is a new IP block, quite
>> different from those used in the previous generations of Rockchip SoCs.
>>
>> The controller supports the following features, among others:
>>
>> * Fixed Rate Link (FRL)
>> * Display Stream Compression (DSC)
>> * 4K@120Hz and 8K@60Hz video modes
>> * Variable Refresh Rate (VRR) including Quick Media Switching (QMS)
>> * Fast Vactive (FVA)
>> * SCDC I2C DDC access
>> * Multi-stream audio
>> * Enhanced Audio Return Channel (EARC)
>>
>> This is the last component that needs to be supported in order to enable
>> the HDMI output functionality on the RK3588 based SBCs, such as the
>> RADXA Rock 5B.  The other components are the Video Output Processor
>> (VOP2) and the Samsung IP based HDMI/eDP TX Combo PHY, for which basic
>> support has been already made available via [1] and [2], respectively.
>>
>> Please note this is a reworked version of the original series, which
>> relied on a commonized dw-hdmi approach.  Since the general consensus
>> was to handle it as an entirely new IP, I dropped all patches related to
>> the old dw-hdmi and Rockchip glue code - a few of them might still make
>> sense as general improvements and will be submitted separately.
>>
>> It's worth mentioning the HDMI output support is currently limited to
>> RGB output up to 4K@60Hz, without audio, CEC or any of the HDMI 2.1
>> specific features.  Moreover, the VOP2 driver is not able to properly
>> handle all display modes supported by the connected screens, e.g. it
>> doesn't cope with non-integer refresh rates.
>>
>> A possible workaround consists of enabling the display controller to
>> make use of the clock provided by the HDMI PHY PLL.  This is still work
>> in progress and will be submitted later, as well as the required DTS
>> updates.
>>
>> To facilitate testing and experimentation, all HDMI output related
>> patches, including those part of this series, are available at [3].
>>
>> So far I could only verify this on the RADXA Rock 5B board.
> 
> On a rk3588-tiger-haikou (including its DSI hat and my preliminary DSI
> driver) it also works.
> 
> Even with both DSI and HDMI at the same time. Both hdmi plugged in on
> boot and also plugging it in during runtime of the board, generates a
> clean image on my 1080p display.
> 
> So, series
> Tested-by: Heiko Stuebner <heiko@sntech.de>

Thanks for checking this out!

Regards,
Cristian

