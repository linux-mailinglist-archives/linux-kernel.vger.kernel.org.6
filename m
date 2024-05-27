Return-Path: <linux-kernel+bounces-190164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFE18CFA6C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 09:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 901031F218ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 07:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BC32E403;
	Mon, 27 May 2024 07:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="kQsy3pHE"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F402E40E
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 07:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796041; cv=none; b=oy1lcK4TqFFS+R4O0Nifu8NzUYoocINKPNkN0S3p9qINMz5dxIbmz+8PNhV9uiNpMR7w+KW8XxZXbASfHSZsiha31taORZmY3c+hRZw2PUTaWzzH+OoTU/+1YDzedS6cnk1jYW9gN/iYPv9v7f4j2TQRb+/Th9jLlNc0uky1tG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796041; c=relaxed/simple;
	bh=9v6Q8GT8zMIOW7dcrjy4/kj3+hxtMAo2AEzO1ITXXJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H+OlGjGSsg5IiIPvR76/BZ0QVGO06Zgq3Rl5kZEHnmQhHGsyocDR6p7OtHU2vaS9XTjKupxnjtwOb98sU2sRAdZ4jHehjLfBHLqyBJa9OMpjrnFWi9bkEycT2TEfXEqZ9EciDIbd9RmG5IsxNTl40c7U5VeAId4uCXaVdcRaQdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=kQsy3pHE; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=j4aj9tNdSCThBc71zb119bQ/6ie6a20643nUo5sbWSY=; b=kQsy3pHEn/Rbo+0i3xHus7tJSG
	B3+aqvvEIdrZklAyyOXOehVRhenOWNAZ6lPb28oD+6sGgLPU8zwbax0qdtzuGnHe4iP5G79T/7Ofg
	xT6D2Ga7Qx2eISJRHQBiFzTOHepisJYm2EMzdA40dTCB7ypL9FgbgxIGnI66pmkXnTeBiBgiDYInf
	wwzgNa8EdLLSUY0WFYjmGz9pi4hTlU7DqJC6xviyujK2gtPmHr3wAVhA49qDWFHkNgNRWH9a7bYNY
	RmbNMQGdmt+NehhbybWoglS0LhkLMpUZZibGYZ60nmuPWCnrYJ6xQGT41QszsHTlBjjzsZmuz0KQy
	kzMqeP9Q==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sBV4e-0009Gh-VK; Mon, 27 May 2024 09:47:16 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sBV4e-000HiL-2j;
	Mon, 27 May 2024 09:47:16 +0200
From: Esben Haabendal <esben@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH] memory: fsl_ifc: Make FSL_IFC config visible and
 selectable
In-Reply-To: <87msobaes6.fsf@geanix.com> (Esben Haabendal's message of "Mon,
	27 May 2024 09:35:05 +0200")
References: <20240523-fsl-ifc-config-v1-1-6eff73bdc7e6@geanix.com>
	<979fd913-050b-445d-9ca8-0ec6906ce3ea@kernel.org>
	<87cypc38gu.fsf@geanix.com>
	<9a7f73f4-f5dc-4342-855b-08df6a839bb5@kernel.org>
	<87le3zoatn.fsf@geanix.com>
	<6c166ad5-8004-4bc4-9107-a47ba9a72161@kernel.org>
	<87ttijaglp.fsf@geanix.com>
	<c045f1a4-9ddf-4c53-a69b-22ceb68a1ce8@kernel.org>
	<87msobaes6.fsf@geanix.com>
Date: Mon, 27 May 2024 09:47:16 +0200
Message-ID: <87ikyzae7v.fsf@geanix.com>
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

Esben Haabendal <esben@geanix.com> writes:

> Krzysztof Kozlowski <krzk@kernel.org> writes:
>
>> On 27/05/2024 08:55, Esben Haabendal wrote:
>>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>>> 
>>>> On 24/05/2024 10:47, Esben Haabendal wrote:
>>>>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>>>>>
>>>>>> On 23/05/2024 16:32, Esben Haabendal wrote:
>>>>>>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>>>>>>>
>>>>>>>> On 23/05/2024 15:58, Esben Haabendal wrote:
>>>>>>>>> While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
>>>>>>>>> driver selects FSL_IFC automatically, we need the option to be selectable
>>>>>>>>> for platforms using fsl_ifc with NOR flash.
>>>>>>>>
>>>>>>>> Which driver is that?
>>>>>>>
>>>>>>> This is drivers/memory/fsl_ifc.o driver. It is for Integrated Flash
>>>>>>> Controller (IFC) from NXP. It is used in various Layerscape socs.
>>>>>>
>>>>>> ? I know that, I mean the NOR flash working here.
>>>>>
>>>>> Ah, sorry. The NOR flash I am using here is a Spansion S29AL016J.
>>>>>
>>>>>>>> Which DTS?
>>>>>>>
>>>>>>> It is for "fsl,ifc" compatible devices.
>>>>>>
>>>>>> That's not a NOR flash.
>>>>>
>>>>> Nope.  The binding used for the NOR flash is "cfi-flash".
>>>>
>>>> And now let's get back to my original question. I asked for driver, not
>>>> device, and for DTS not compatible.
>>> 
>>> You got me really confused now. I am not sure what you are asking me
>>> for, and why.
>>> 
>>> I am sending a patch which changes to Kconfig for a memory controller
>>> driver. The change is AFAICS quite similar to commit be34f45f0d4a
>>> ("memory: omap-gpmc: Make OMAP_GPMC config visible and selectable").
>>> 
>>> As for the NOR flash that in this situation is attached to the IFC
>>> controller, it is (as mentioned) Spansion S29AL016J. It is handled by
>>> the drivers/mtd/maps/physmap.o driver (CONFIG_MTD_PHYSMAP +
>>> CONFIG_MTD_PHYSMAP_OF)
>>
>> Thanks.
>>
>>> 
>>> The DTS used to specify the NOR flash is
>>
>> Upstream DTS. I don't care about downstream.
>
> Upstream DTS is arch/arm/boot/dts/nxp/ls/ls1021a.dtsi
>
> Which has
>
>                 ifc: memory-controller@1530000 {
>                         compatible = "fsl,ifc";
>                         reg = <0x0 0x1530000 0x0 0x10000>;
>                         interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
>                         status = "disabled";
>                 };
>
> The NOR flash is not specified in upstream DTS, as it is board and not
> SoC specific.
>
> I assume it is not considered bad practise to keep downstream DTS out of
> tree.
>
>>> &ifc {
>>>         status = "okay";
>>>         #address-cells = <2>;
>>>         #size-cells = <1>;
>>>         ranges = <0x0 0x0 0x0 0x60000000 0x00200000>;
>>> 
>>>         nor_flash: nor@0,0 {
>>>                 #address-cells = <1>;
>>>                 #size-cells = <1>;
>>>                 compatible = "cfi-flash";
>>>                 reg = <0x0 0x0 0x200000>;
>>>                 bank-width = <2>;
>>> 
>>>                 partition@0 {
>>>                         reg = <0x000000 0x0f0000>;
>>>                         label = "boot0";
>>>                 };
>>>         };
>>> };

Ok, I seem to still be confused as to what you want from me. If you are
saying that the kernel is not supposed to care about out-of-tree DTS
(and thereby any bootloader provided DTB), I would like to bring your
attention to arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts in upstream:

&ifc {
        #address-cells = <2>;
        #size-cells = <1>;
        /* NOR Flash on board */
        ranges = <0x0 0x0 0x0 0x60000000 0x08000000>;
        status = "okay";

        nor@0,0 {
                #address-cells = <1>;
                #size-cells = <1>;
                compatible = "cfi-flash";
                reg = <0x0 0x0 0x8000000>;
                big-endian;
                bank-width = <2>;
                device-width = <1>;
        };
};

This is basically identical to what I am using, and it will have the
same problem. It requires CONFIG_FSL_IFC enabled, which is not possible
(without enabling CONFIG_MTD_NAND_FSL_IFC). This board does not have
NAND, so I don't think it is reasonable to require keeping support for
it enabled to be able to use NOR flash.

/Esben

