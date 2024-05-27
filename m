Return-Path: <linux-kernel+bounces-190148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA8D8CFA3A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16DD81F22716
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E043EA72;
	Mon, 27 May 2024 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="agoQIcox"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B3A3C482
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716795311; cv=none; b=u0fzqLmS5KQyQV3HbdcXZqcwvMHzt1Vtduos8hBxTnIq5goGzTUMbvBu8vGB8WTZYDL/ihv/BjCxOSSI10VHn9NBlg2E8nkQkPjNHBvkC9bYx+16SGlMI4T3XgFyXF4zhbqvHsz3M7UKtOuqz7CGZdQ3SWi9qFUAPEv1XuNZ7GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716795311; c=relaxed/simple;
	bh=u9MklCu797KN1scq2oF2jtMHMhfjD3/Vqkcw9HdKah0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uKhysHqABZsD5pAwJxI02cDwJohkKXK6OlPWw6SUrY181ysF4oRZEEyNzNEUAFvCS4RU3lXzkBAo9LGxYER7H2Hw6vlrLLobO3028XPd/ev+449Ze8A8zmi9u/PuiawHJ5b0rb2OCIsnYI7aSBk/b8cpAJ9uszWpkbwIDoSkc3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=agoQIcox; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=/mJnBW0+/Ff0ADfcSqgqzSrAeQehjCnl6K5RtU81HSE=; b=agoQIcoxqmXGUU9K9jLGY3Pdh5
	0PFaxaLGI7DR/sMEIswKa2Oh7sVqogyh4J/71jYegm6IrSeXn0wTpa4848OnSKR4o4L/PLCTjQO9/
	lgy7KCtJuZ/LMHb9VnkFhRbX+Zbe89ewAiuRn94LRLW7nT9hcUK5+cNXQsOLMUFYObjGUWVWVXLQf
	l+1ZTPW6EdmDnJOkUNCiEg00TCv/GF20GcuUPhC52UF+YA12Spoi8o1nbzc71qvuEW6B0pEFYLF1q
	i4wu49q+04Vec3fB8r76aq5w+E9bgmisBtsAk9xIQklyPMnNQoU6V5kvTg2NCh3ZB3uXb/r7YLk1L
	fhO1FdJQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sBUss-000Nbk-QH; Mon, 27 May 2024 09:35:06 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sBUsr-000JOe-2x;
	Mon, 27 May 2024 09:35:06 +0200
From: Esben Haabendal <esben@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH] memory: fsl_ifc: Make FSL_IFC config visible and
 selectable
In-Reply-To: <c045f1a4-9ddf-4c53-a69b-22ceb68a1ce8@kernel.org> (Krzysztof
	Kozlowski's message of "Mon, 27 May 2024 09:19:55 +0200")
References: <20240523-fsl-ifc-config-v1-1-6eff73bdc7e6@geanix.com>
	<979fd913-050b-445d-9ca8-0ec6906ce3ea@kernel.org>
	<87cypc38gu.fsf@geanix.com>
	<9a7f73f4-f5dc-4342-855b-08df6a839bb5@kernel.org>
	<87le3zoatn.fsf@geanix.com>
	<6c166ad5-8004-4bc4-9107-a47ba9a72161@kernel.org>
	<87ttijaglp.fsf@geanix.com>
	<c045f1a4-9ddf-4c53-a69b-22ceb68a1ce8@kernel.org>
Date: Mon, 27 May 2024 09:35:05 +0200
Message-ID: <87msobaes6.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27287/Sun May 26 10:27:50 2024)

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 27/05/2024 08:55, Esben Haabendal wrote:
>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>> 
>>> On 24/05/2024 10:47, Esben Haabendal wrote:
>>>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>>>>
>>>>> On 23/05/2024 16:32, Esben Haabendal wrote:
>>>>>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>>>>>>
>>>>>>> On 23/05/2024 15:58, Esben Haabendal wrote:
>>>>>>>> While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
>>>>>>>> driver selects FSL_IFC automatically, we need the option to be selectable
>>>>>>>> for platforms using fsl_ifc with NOR flash.
>>>>>>>
>>>>>>> Which driver is that?
>>>>>>
>>>>>> This is drivers/memory/fsl_ifc.o driver. It is for Integrated Flash
>>>>>> Controller (IFC) from NXP. It is used in various Layerscape socs.
>>>>>
>>>>> ? I know that, I mean the NOR flash working here.
>>>>
>>>> Ah, sorry. The NOR flash I am using here is a Spansion S29AL016J.
>>>>
>>>>>>> Which DTS?
>>>>>>
>>>>>> It is for "fsl,ifc" compatible devices.
>>>>>
>>>>> That's not a NOR flash.
>>>>
>>>> Nope.  The binding used for the NOR flash is "cfi-flash".
>>>
>>> And now let's get back to my original question. I asked for driver, not
>>> device, and for DTS not compatible.
>> 
>> You got me really confused now. I am not sure what you are asking me
>> for, and why.
>> 
>> I am sending a patch which changes to Kconfig for a memory controller
>> driver. The change is AFAICS quite similar to commit be34f45f0d4a
>> ("memory: omap-gpmc: Make OMAP_GPMC config visible and selectable").
>> 
>> As for the NOR flash that in this situation is attached to the IFC
>> controller, it is (as mentioned) Spansion S29AL016J. It is handled by
>> the drivers/mtd/maps/physmap.o driver (CONFIG_MTD_PHYSMAP +
>> CONFIG_MTD_PHYSMAP_OF)
>
> Thanks.
>
>> 
>> The DTS used to specify the NOR flash is
>
> Upstream DTS. I don't care about downstream.

Upstream DTS is arch/arm/boot/dts/nxp/ls/ls1021a.dtsi

Which has

                ifc: memory-controller@1530000 {
                        compatible = "fsl,ifc";
                        reg = <0x0 0x1530000 0x0 0x10000>;
                        interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
                        status = "disabled";
                };

The NOR flash is not specified in upstream DTS, as it is board and not
SoC specific.

I assume it is not considered bad practise to keep downstream DTS out of
tree.

>> &ifc {
>>         status = "okay";
>>         #address-cells = <2>;
>>         #size-cells = <1>;
>>         ranges = <0x0 0x0 0x0 0x60000000 0x00200000>;
>> 
>>         nor_flash: nor@0,0 {
>>                 #address-cells = <1>;
>>                 #size-cells = <1>;
>>                 compatible = "cfi-flash";
>>                 reg = <0x0 0x0 0x200000>;
>>                 bank-width = <2>;
>> 
>>                 partition@0 {
>>                         reg = <0x000000 0x0f0000>;
>>                         label = "boot0";
>>                 };
>>         };
>> };
>> 
>> So as mentioned, it is a quite standard "cfi-flash" compatible device
>> declaration.
>> 
>> Do you think there is a way that ti enable CONFIG_FSL_IFC for my
>> situation without the config being visible? Something like automatically
>> selecting CONFIG_FSL_IFC when CONFIG_MTD_PHYSMAP and
>> CONFIG_MTD_PHYSMAP_OF is enabled? Will that not include a risk of
>> pulling in CONFIG_FSL_IFC in some cases where it is not desired?
>> 
>> Something like
>> 
>> config MTD_PHYSMAP
>> 	tristate "Flash device in physical memory map"
>> 	depends on MTD_CFI || MTD_JEDECPROBE || MTD_ROM || MTD_RAM || MTD_LPDDR
>>         select FSL_IFC if SOC_LS1021A
>> 
>> But that looks like a road somewhere not so nice. The generic
>> MTD_PHYSMAP being littered with architecture specific selects.
>> 
>> Or is there something completely obvious (not for me then) that I am
>> missing?
>
> If there is no user for such option, why changing it? To clarify:
> whatever is out of tree, does not really exist...

I don't have anything out of tree other than the DTS. Is the kernel only
supposed to support in-tree DTS? I thought that keeping (dtb)
device-tree in bootloader was very much considered a supported setup.

Or are you saying that I should send patches with all downstream
DTS files, even if it is for hardware that is not generally available?

/Esben

