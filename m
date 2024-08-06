Return-Path: <linux-kernel+bounces-275895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C70948BA5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 10:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C551C22858
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B07313A884;
	Tue,  6 Aug 2024 08:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRk+8V+Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1A81BD01C;
	Tue,  6 Aug 2024 08:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722934238; cv=none; b=b9p8Q8EmSkf5ffn0BczTmNlWECVrAbGMLgfYAxkBdAm4fRHqgRBjN+RuHim27LcEA/JoOOirlzlghnR4aPKZPR+0rA0o3PXNUjyzVU54zHZdhsJCPRIs1s10K+Ag7gyUJMZykyMyzF52tQirY7iOZppMBEpi7SCNdul2MBNsBrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722934238; c=relaxed/simple;
	bh=KGoHY7fO0zJTaqHWcxv+uY4blbQ1qPR4UIk5hy+qUt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9IiOzyarATRltemjoOx0/0mfZnhavyLnWZ+mm7wH2BX5xQLQ2viM+svV9uCespXAtcZpx6sDtm8bm3mOesyrXyf3rPGfy0L2pxrN4guwnE3XQNfd0vX91yi5QNonOwn0sci/SPu7WYrigIkXClDLf8wq90KUt41aJ2CDsYBlMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRk+8V+Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A5CC32786;
	Tue,  6 Aug 2024 08:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722934238;
	bh=KGoHY7fO0zJTaqHWcxv+uY4blbQ1qPR4UIk5hy+qUt8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iRk+8V+YHVP3f82aYl60EL16Y55IBi8tpdMeb7WlSxzpeu2PE2CcBMxrRF5C5iJGm
	 gU7YZYSYbrhH575Qja2qGALBEx0If8gFaLopYLUDBm6UBm+9N/SVrWhvS7QXpdZFEL
	 t5vM3FQb/kRS6KoQvhJdppVBY7rdJI2V5seiPO1BaVYG2XL+r/IOfekRtctDHx2uIG
	 Z5xqJdQVrXzyp90SjmhQH2FowPd0WafF5xzzw1w65/Z030lAbbfjBGXrGtCXXSM98D
	 Rks23dmODYB0JRsNGr8jV7r9y3ocgLNTrvfLhqAU1BFHYrk1lLsjCMGVnxIJjJZ/55
	 un6eZg0SaQBWw==
Message-ID: <d091adbd-7e8a-4c74-939d-e0d776a58fec@kernel.org>
Date: Tue, 6 Aug 2024 10:50:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] firmware: ti_sci: Partial-IO support
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Vibhore Vardhan <vibhore@ti.com>, Kevin Hilman <khilman@baylibre.com>,
 Dhruva Gole <d-gole@ti.com>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240729080101.3859701-1-msp@baylibre.com>
 <20240729080101.3859701-3-msp@baylibre.com>
 <654f76d5-e4e4-477d-becf-8157792557cc@kernel.org>
 <iswnvyfwxq6xie2elmbzzixpriy74o4plk3adz6nthf2eekrgk@wwlgjhbygj5f>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <iswnvyfwxq6xie2elmbzzixpriy74o4plk3adz6nthf2eekrgk@wwlgjhbygj5f>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/08/2024 09:19, Markus Schneider-Pargmann wrote:
> On Tue, Aug 06, 2024 at 08:26:00AM GMT, Krzysztof Kozlowski wrote:
>> On 29/07/2024 10:00, Markus Schneider-Pargmann wrote:
>>> +static int tisci_sys_off_handler(struct sys_off_data *data)
>>> +{
>>> +	struct ti_sci_info *info = data->cb_data;
>>> +	int i;
>>> +	int ret;
>>> +	bool enter_partial_io = false;
>>> +
>>> +	for (i = 0; i != info->nr_wakeup_sources; ++i) {
>>> +		struct platform_device *pdev =
>>> +			of_find_device_by_node(info->wakeup_source_nodes[i]);
>>> +
>>> +		if (!pdev)
>>> +			continue;
>>> +
>>> +		if (device_may_wakeup(&pdev->dev)) {
>>
>> ...
>>
>>> +			dev_dbg(info->dev, "%pOFp identified as wakeup source\n",
>>> +				info->wakeup_source_nodes[i]);
>>> +			enter_partial_io = true;
>>> +		}
>>> +	}
>>> +
>>> +	if (!enter_partial_io)
>>> +		return NOTIFY_DONE;
>>> +
>>> +	ret = tisci_enter_partial_io(info);
>>> +
>>> +	if (ret) {
>>> +		dev_err(info->dev,
>>> +			"Failed to enter Partial-IO %pe, trying to do an emergency restart\n",
>>> +			ERR_PTR(ret));
>>> +		emergency_restart();
>>> +	}
>>> +
>>> +	while (1);
>>> +
>>> +	return NOTIFY_DONE;
>>> +}
>>> +
>>>  /* Description for K2G */
>>>  static const struct ti_sci_desc ti_sci_pmmc_k2g_desc = {
>>>  	.default_host_id = 2,
>>> @@ -3398,6 +3485,35 @@ static int ti_sci_probe(struct platform_device *pdev)
>>>  		goto out;
>>>  	}
>>>  
>>> +	if (of_property_read_bool(dev->of_node, "ti,partial-io-wakeup-sources")) {
>>> +		info->nr_wakeup_sources =
>>> +			of_count_phandle_with_args(dev->of_node,
>>> +						   "ti,partial-io-wakeup-sources",
>>> +						   NULL);
>>
>> I don't see the point of this. You have quite a static list of devices -
>> just look at your DTS. Then you don't even do anything useful with the
>> phandles you got here.
> 
> I am gathering the list of phandles in probe.

I know what the code is doing.

> 
> Then during shutdown I am resolving the phandles to devices if there
> are associated devices and check if wakeup is enabled for these devices.

I can read the code.

> If wakeup is enabled for one of the devices in the list, I put the
> SoC into Partial-IO instead of a normal poweroff. This way the
> devices which have wakeup enabled can actually wakeup the SoC as
> requested by the user by setting wakeup enable.

I see all this. I said there is no point in doing this. Instead of
repeating the code, you can say what is the point of doing it.

I said once, so repeat one more time - you have *static* list of
devices, therefore any DTS is meaningless. It is just fixed, not flexible.

The code here is still not doing anything useful with the phandles. By
useful I mean - actually enable the wakeup. No, the property is totally
misplaced just to satisfy your code. That's a "no".

Best regards,
Krzysztof


