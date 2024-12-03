Return-Path: <linux-kernel+bounces-428814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A69EF9E13DE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269F0B22CAA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C34189F36;
	Tue,  3 Dec 2024 07:20:15 +0000 (UTC)
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DEF185B76
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 07:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.183.69.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733210415; cv=none; b=Xs6DKYQpw18U8ll5hr45oox0xrjCIQUF3WyP5fjV3K3Vq5zFEHScT/ddxnPePTHuWf9IBQUH74O+j8B0pIHVQl98OTyp61C6xFOm5M0QuT/X65TAaW9WM9tjOlpSyagrsQoqOQQ+2qUYWFJddGRHIwf3WbKNFtSwaoLHonRAvTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733210415; c=relaxed/simple;
	bh=bStHylu43FbXoC8+cIz28JnD6jgxk+4X3/rXGSLNARk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=PXGMusMrCH05EsBzzClT5ml8wmeuG/ijPvXJ24vr6GMEsuD2Y6STZcdf5tHErJXgPsQIFhwUuxGuK8kbmSmU6NsJsqUnvUTGabYZsHyhmVnv2Ruet1d+qXhEkvaO+PhciS2rHVc/TMa1r0u5cOL7rix3W18KM9liP4n1PRUg49g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de; spf=pass smtp.mailfrom=vosn.de; arc=none smtp.client-ip=85.183.69.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vosn.de
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: from mail.steuer-voss.de (localhost [127.0.0.1])
	by mail.steuer-voss.de (Postfix) with ESMTP id B8F162CF;
	Tue,  3 Dec 2024 08:20:05 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 03 Dec 2024 08:20:05 +0100
From: Nikolaus Voss <nv@vosn.de>
To: Marek Vasut <marex@denx.de>
Cc: Liu Ying <victor.liu@oss.nxp.com>, Alexander Stein
 <alexander.stein@ew.tq-group.com>, Liu Ying <victor.liu@nxp.com>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Fabio Estevam <festevam@denx.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 nikolaus.voss@haag-streit.com, miquel.raynal@bootlin.com
Subject: Re: [PATCH] drm: bridge: fsl-ldb: fixup mode on freq mismatch
In-Reply-To: <12a1b86e-8f25-4875-8503-1de98f125a62@denx.de>
References: <20241126172610.AD8B51622C@mail.steuer-voss.de>
 <1f0a307a-666f-4647-9f73-e9bddd6c7eff@oss.nxp.com>
 <000b34cdd1591c82265ce1f9848828d1@vosn.de>
 <2c950130-84b4-4a81-84a2-b5e08af43616@oss.nxp.com>
 <12a1b86e-8f25-4875-8503-1de98f125a62@denx.de>
User-Agent: Roundcube Webmail/1.5.0
Message-ID: <808d4092a9e97b95480d47c1bd84d930@vosn.de>
X-Sender: nv@vosn.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit

On 03.12.2024 04:12, Marek Vasut wrote:
> On 12/3/24 3:22 AM, Liu Ying wrote:
> 
> [...]
> 
>>>> I doubt that pixel clock tree cannot find appropriate division 
>>>> ratios
>>>> for some pixel clock rates, especially for dual-link LVDS on i.MX8MP
>>>> and i.MX93 platforms, because PLL clock rate should be 7x faster 
>>>> than
>>>> pixel clock rate and 2x faster than "ldb" clock rate so that the 3.5
>>>> folder between "ldb" clock and pixel clock can be met. That means 
>>>> the
>>>> PLL clock rate needs to be explicitly set first for this case.
>>>> 
>>>> Can you assign the PLL clock rate in DT to satisfy the "ldb" and 
>>>> pixel
>>>> clock rates like the below commit does, if you use a LVDS panel?
>>>> 
>>>> 4fbb73416b10 ("arm64: dts: imx8mp-phyboard-pollux: Set Video PLL1
>>>> frequency to 506.8 MHz")
>>> 
>>> I probably could. The point of my patch is you don't have to know in
>>> advance which LVDS panel is connected, and you don't have to 
>>> calculate
>>> the base PLL clock by hand and store it in the device tree.
>>> 
>>> In my test system, I have three different LVDS panels with EDID 
>>> EEPROM,
>>> none of which worked with the stock driver, but all work with this
>>> patch.
>>> With slightly adapted pixel clocks though.
>> 
>> If each of the three LVDS panels has only one display mode, you may
>> assign the PLL clock rates in DT overlays for the panels.
> I temporarily agree.
> 
> I also currently use DTOs for various panels including their PLL
> setting, but in the end, I think/hope the work of Miquel and co. is
> going to make that PLL setting part unnecessary.

That is exactly what my patch is about. I want to use one DT for all
panels and store the panel's timing in EDID EEPROM.

-- 
Nikolaus Voss

