Return-Path: <linux-kernel+bounces-345421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2078E98B625
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AE9281449
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23FC01BDA8C;
	Tue,  1 Oct 2024 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a9Y6YVP8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD519992D
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727769099; cv=none; b=q6elwHTMBY1BWNkcp3BbPUlLLBxV2uhvbGuzb7hfuiaif4kYYHaFWnCCj5P0K49Kc63PQulDw1HuK4gCmOxp21N92N5JiPBrvv+07r2bmz7K5wdGh3zkBCOTuakxTbV4VGX8ELr9tUKQs813hmTFPokgbbyT0p3gueB6QTl4yB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727769099; c=relaxed/simple;
	bh=TBwGr7hAFCtcE9EAP5sScKW1xltCT+lyob5l+b6uvXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RmcWws6KDTK9U2M9cqOM97Mawf92smbvk0GI4x/ohlU6bIiI6rMiwL35ygEmO5cCtS6NBzwj4yazgPOBHFq/zDwA1ZRoO4LX3IHuo/rnYpjCVgYfPr5+ovysnWzfudHj3xzuz1ikuAbFk7eEUor2T1S4LbjDY4AxRFxLiJYzwVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a9Y6YVP8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBADC4CECD;
	Tue,  1 Oct 2024 07:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727769099;
	bh=TBwGr7hAFCtcE9EAP5sScKW1xltCT+lyob5l+b6uvXk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a9Y6YVP8BdzEssOIq1RGS4jmrGBAhP2I2AtQ2gj8Ovsmj+h/dlD33kFLANJTzlndI
	 vHPN2uv5im13vPbiUO/0SYNpPGSH9rxKOz4Qui8uqFNpKwbiBIzrDKOtotSoKm/Jii
	 rL0S16kHXitkoG1EQX60ykXn0wlRk+2syRgC0wexZv6mN9EvQzeLLtvZZiWA5gv31+
	 RlmJ1V+ZvQaHlqQ5d4paJLfmPgvgbdsx9y+1wnZ3DivyMsGzw4x/2psMpE5RQglhsa
	 wQWy6A9gQRqflivigKeRp0R1YGoxPMULnIsrIj8GfiiKgJGJ/TYEG2JZNOjqEFMOuQ
	 xOpd1DOUVqPTg==
Message-ID: <59baaefa-4b57-4c76-ad19-3d16eaeb587c@kernel.org>
Date: Tue, 1 Oct 2024 10:51:33 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] phy: ti: phy-j721e-wiz: fix usxgmii configuration
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: vkoul@kernel.org, kishon@kernel.org, thomas.richard@bootlin.com,
 krzysztof.kozlowski@linaro.org, nichen@iscas.ac.cn, c-vankar@ti.com,
 t-patil@ti.com, linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20240930095745.3007057-1-s-vadapalli@ti.com>
 <4b42b8e5-3246-4f58-b494-735930d2424a@kernel.org>
 <c5ef5303-6390-4f2b-b9d2-3d1f3085e15f@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <c5ef5303-6390-4f2b-b9d2-3d1f3085e15f@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 01/10/2024 06:10, Siddharth Vadapalli wrote:
> On Mon, Sep 30, 2024 at 05:06:35PM +0300, Roger Quadros wrote:
> 
> Hello Roger,
> 
>> Hi Siddharth,
>>
>> On 30/09/2024 12:57, Siddharth Vadapalli wrote:
>>> Commit b64a85fb8f53 ("phy: ti: phy-j721e-wiz.c: Add usxgmii support in
>>> wiz driver") added support for USXGMII mode. In doing so, P0_REFCLK_SEL
>>> was set to "pcs_mac_clk_divx1_ln_0" (0x3) and P0_STANDARD_MODE was set to
>>> LANE_MODE_GEN1, which results in a data rate of 5.15625 Gbps. However,
>>> since the USXGMII mode can support up to 10.3125 Gbps data rate, the
>>> aforementioned fields should be set to "pcs_mac_clk_divx0_ln_0" (0x2) and
>>> LANE_MODE_GEN2 respectively. Fix the configuration accordingly to truly
>>> support USXGMII up to 10G.
>>>
>>> Fixes: b64a85fb8f53 ("phy: ti: phy-j721e-wiz.c: Add usxgmii support in wiz driver")
>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> [...]
> 
>>> diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
>>> index a6c0c5607ffd..c6e846d385d2 100644
>>> --- a/drivers/phy/ti/phy-j721e-wiz.c
>>> +++ b/drivers/phy/ti/phy-j721e-wiz.c
>>> @@ -450,8 +450,8 @@ static int wiz_mode_select(struct wiz *wiz)
>>>  		} else if (wiz->lane_phy_type[i] == PHY_TYPE_USXGMII) {
>>>  			ret = regmap_field_write(wiz->p0_mac_src_sel[i], 0x3);
>>>  			ret = regmap_field_write(wiz->p0_rxfclk_sel[i], 0x3);
>>
>> I'm not sure. Don't we have to change rxfclk as well?
> 
> This patch was validated on a custom board with the J7200 SR 2.0 SoC.
> The signal corresponding to the USXGMII lane of the SERDES was measured
> to be 5 Gbps without this patch and 10 Gbps with this patch applied,
> with no other changes required. Apart from measuring the signal, ping
> was also validated.

Thanks. This is useful piece off information that could go in the commit log.

Reviewed-by: Roger Quadros <rogerq@kernel.org>

