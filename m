Return-Path: <linux-kernel+bounces-419282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FA59D6BB8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 23:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF50B220D5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 22:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 983D51A38E3;
	Sat, 23 Nov 2024 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="mrheDw3f"
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF1A2905;
	Sat, 23 Nov 2024 22:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732399766; cv=none; b=qAm4Lhe3NT7GjADFAo06dTHX1s05zbfuvohL7DlSsybHDjS2mTA0jIDlNx+vweTH+DQ54YcSoHOIx1gPIp1CDYR0yFljdyP7xHVF+W6BDU0+kIhNaVIiblqzcU13QfTILZRdH8y4IizZwi9PU01i/7PtnDhtDpa4lcaREInJx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732399766; c=relaxed/simple;
	bh=ly8oeaIOAg6lQzNJz3++JQOR8O7rdaXLBJTqDo2MTiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LOGJcsBn60lZHXDZ0TWaA7XgtZ0ISNQZxkb+TdEbhpzxHcuMswo13yW7DGjSlqKsi3P/kpy1tv+yRW2valpJmIirdOO3oNyih5ZS2ghjC31OaQuW7/T5TobA5xuODoBtYygnvK7KANKpTUhGQHY+G53CX/GgJKyJ0BTtbCZ0EfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=mrheDw3f; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 23AC3A037C;
	Sat, 23 Nov 2024 23:09:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=ggcfDzy4T2wd6OE/Z3K6
	o9nCDGY9SIX9C7Zth5qGkkw=; b=mrheDw3f9/c1M7uWYdSdjXZfspL54nuwPSA9
	kwVUd78i8gy+792IM4dEZ/atzbyV3kg2iMPD5d00RenG5xkdYl8h6xGJq+Wo8m7O
	tT4T34BCbLSC76luZhkGS6feezabh2pVoBdZawsTApjGI7FuWbf6ldS1garKQD7N
	IDEfkrsDNg9UnaM/jjMOoc4Aph7eU93iBLB1nptj+oRrDTDAQZv/j3nGLFrt3zuB
	74jY6EVfjBmm5NSUCgJbgxF9nGjjLKGRnhVlLVjNBOo5tYYz/3BVVkkDnnuo+fJK
	3Cl6dXDOi+LOea+NXBaEBi4bx6pse5vDC1LUfjFvOuIFSn1xh07ul/hBvKmoeAmC
	bfBjuQXB+OZYVT5RrCdIqrlGqC6hFo2IflskErKu2y8Cf/zSutPki9Cz5W84x8Yd
	thpGg1uzT0Rwi+rLA0PyIcDNLOXXLljPowOxLa4ugzyfdgfmtgSKhEYlWRRJlH/J
	8lra0RngSM8VIu1KwSs2U3tROUV+NzLiffS97CHf9k7NC5gQKgBsITbfrHU0NfnY
	geAgpFHg67fBDpvHhOeN8AfCruIBapj8MJRrs5xtitJDYmDyv14QkG3J08YHgtwH
	XHPkS3BYsUo1snyytbl3NHTpI1J04nZZIrJmdJVg2RiH84QU16rmZsqw2yeBAFnO
	D4Sk4Vw=
Message-ID: <f5f4be27-4d8c-4832-998f-8477030a21cb@prolan.hu>
Date: Sat, 23 Nov 2024 23:09:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] dt-bindings: sound: Add Allwinner suniv F1C100s
 Audio Codec
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
	<linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, "Mark
 Brown" <broonie@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>
References: <20241123123900.2656837-1-csokas.bence@prolan.hu>
 <20241123123900.2656837-3-csokas.bence@prolan.hu>
 <juzxtwlr5ayvjrrqem2hr3nbyem6oajwrvveio5brlzazdafov@r2aehknf4shv>
Content-Language: en-US
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <juzxtwlr5ayvjrrqem2hr3nbyem6oajwrvveio5brlzazdafov@r2aehknf4shv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D94855607D61

Hi,

On 2024. 11. 23. 17:22, Krzysztof Kozlowski wrote:
> On Sat, Nov 23, 2024 at 01:39:00PM +0100, Csókás, Bence wrote:
>> Add compatible string for Allwinner suniv F1C100s audio codec.
>>
>> [ csokas.bence: Reimplement Mesih Kilinc's binding in YAML ]
>> Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
>> ---
>>   .../sound/allwinner,sun4i-a10-codec.yaml      | 31 +++++++++++++++++++
>>   1 file changed, 31 insertions(+)
>>
> 
> Missing changelog - what happened here? If no changes, why ignoring
> received tag?

Sorry, I just forgot to collect it, that's all.

> <form letter>
> This is a friendly reminder during the review process.
> 
> It looks like you received a tag and forgot to add it.
> 
> If you do not know the process, here is a short explanation: Please add
> Acked-by/Reviewed-by/Tested-by tags when posting new versions, under
> or above your Signed-off-by tag. Tag is "received", when provided
> in a message replied to you on the mailing list. Tools like b4 can help
> here. However, there's no need to repost patches *only* to add the tags.
> The upstream maintainer will do that for tags received on the version
> they apply.
> 
> https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
> 
> If a tag was not added on purpose, please state why and what changed.
> </form letter>
> 
> Best regards,
> Krzysztof

Bence


