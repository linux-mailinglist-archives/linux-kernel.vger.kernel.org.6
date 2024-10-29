Return-Path: <linux-kernel+bounces-386360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00BAA9B426B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:33:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66673B21B74
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279BE20111B;
	Tue, 29 Oct 2024 06:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uq48FAJZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7021E0B93;
	Tue, 29 Oct 2024 06:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730183581; cv=none; b=hGlc9zWEgG/6gEH1GwEIpwo3PQEhPMMDNLTlfKf7lVzk9YBbZg0zlPnOdabWhNNDdIMDFNPZIre5pSg5f4w6Pvm98Ht2zeOag6IPi3flamVb6pj+SgMMTcoRTnhb8LXcS8REilu7ctQGM2FkQ4FhdWttouF/By4ajd180Z1Q8Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730183581; c=relaxed/simple;
	bh=oi8HPczJPQ2s/SYDLMYe92wXwT9sG8C3R0uxFmB4LGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nz3VEQ4YOj1yrKKWOWl8FZOEa40qEuSmHTbx8Zkarlufwe3zq9bIA8vcOvw/2IM+4vspPPeg1x7PrTe6ODfrjDPkhfb87/rdTv8DOvKqsM/pdeYJ4Ejp6JD449AziKAKmnwnlEQ9I7LZwnj0Ax9rj+katOQfPisRRH/amuqkXqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uq48FAJZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57384C4CECD;
	Tue, 29 Oct 2024 06:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730183581;
	bh=oi8HPczJPQ2s/SYDLMYe92wXwT9sG8C3R0uxFmB4LGo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uq48FAJZK+gt71hYrLRMptK9T/tbNaBTeS2ZV2wvv9W8CevFSIx+3x2/HW7wmmYgH
	 7iweC+oDZeDrJm90FQYsgec3rSpPLgTwPxRy7ZwbDNLtYm6QVlC30NQHtb63K95W+0
	 srf7nOenmF/nmnHRmFqK3HMmbnOSXYn8Mzic6JKSH6QmJN/+W9o92VRM1ofhNNB9kl
	 hd/Ks0TLgo5X67os3D7Ct2j2E1jzwdAXZ9oTEYwG5laKSJZ0KNYZP0WycTMmSE47Hy
	 5KtHAPzt20RNjKwRIlD4f0Rn+G04JMcFJ6BuiTUkOF09EweJuCMikvS28rUHFwokdN
	 QIhXq5OYUOiNw==
Message-ID: <dc8c3bb0-e462-4286-9060-c54fcc10c186@kernel.org>
Date: Tue, 29 Oct 2024 07:32:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] memory: mtk-smi: mt8188: Add SMI clamp function
To: =?UTF-8?B?RnJpZGF5IFlhbmcgKOadqOmYsyk=?= <Friday.Yang@mediatek.com>,
 "robh@kernel.org" <robh@kernel.org>,
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 Project_Global_Chrome_Upstream_Group
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20240821082845.11792-1-friday.yang@mediatek.com>
 <20240821082845.11792-4-friday.yang@mediatek.com>
 <25b487b7-63e0-402d-a0a2-ed9d03e82630@kernel.org>
 <cdbac20d7a49ff2fbd3e6d4f24ae441ffbe87f05.camel@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <cdbac20d7a49ff2fbd3e6d4f24ae441ffbe87f05.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/10/2024 03:29, Friday Yang (杨阳) wrote:
> On Wed, 2024-08-21 at 11:00 +0200, Krzysztof Kozlowski wrote:
>>  	 
>> External email : Please do not click links or open attachments until
>> you have verified the sender or the content.
>>  On 21/08/2024 10:26, friday.yang wrote:
>>> In order to avoid handling glitch signal when MTCMOS on/off, SMI
>> need
>>> clamp and reset operation. Parse power reset settings for LARBs
>> which
>>> need to reset. Register genpd callback for SMI LARBs and apply
>> reset
>>> operations in the callback.
>>>
>>> Signed-off-by: friday.yang <friday.yang@mediatek.com>
>>> ---
>>>  drivers/memory/mtk-smi.c | 148
>> ++++++++++++++++++++++++++++++++++++++-
>>>  1 file changed, 146 insertions(+), 2 deletions(-)
>>>
>>
>> ...
>>
>>> +
>>> +static int mtk_smi_larb_parse_reset_info(struct mtk_smi_larb
>> *larb)
>>> +{
>>> +struct device_node *reset_node;
>>> +struct device *dev = larb->dev;
>>> +int ret;
>>> +
>>> +/* only larb with "resets" need to get reset setting */
>>> +reset_node = of_parse_phandle(dev->of_node, "resets", 0);
>>
>> Nope, you do not parse rasets.
> 
> 1.If I need to use the Linux reset control framework, 'resets' is the
> required property.

And you never parse it directly. Find me existing examples of this, if
you disagree.

> 2.'reset-names' give the list of reset signal name strings sorted in
> the same order as the 'resets' property. SMI driver will use 'reset-
> names' to match reset signal names with reset specifiers.

?

> 3.Not all SMI larbs need to apply reset operations, only SMI larbs
> which may have bus glitch issues need this. Just to confirm if this
> larb support reset function.

?

Really, read kernel API about reset framework first.

> 
>>
>>> +if (!reset_node)
>>> +return 0;
>>> +of_node_put(reset_node);
>>> +
>>> +larb->rst_con = devm_reset_control_get(dev, "larb_rst");
>>
>> Where are the bindings? Why do you add undocumented properties? How
>> possible this passes dtbs_check???
>>
> 
> This is not the new added property in SMI larb DT node.
> It is the reset signal name which is inclued in 'reset-names'.
> Just like this:

$ git grep larb_rst
No such property, so how this could be "not the new added"?

If you keep responding with some random or irrelevant responses, this
won't work. This is really poor way to upstream. I suggest first perform
extensive internal review which would point out all such trivial issues.



Best regards,
Krzysztof


