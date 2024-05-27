Return-Path: <linux-kernel+bounces-190109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0590C8CF999
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378E61C20ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 06:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C1417555;
	Mon, 27 May 2024 06:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="mTUlAJnZ"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE47134B0
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716792960; cv=none; b=T1UyDJFz+pCPzrx4ZHW+5yVgr6V8Qv1txP2Uz34YiNm61sGjPfjP90YUU6L9bMHye53I7EqEkqibdBdWyWgNsSfjwVgITsKlAZ2jisY+qFLfe4rq6jt4qxmEKUODNZVHcFORxEBQSlC5L80hdeur0jUW/JxOB8IY47tGBjAmcP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716792960; c=relaxed/simple;
	bh=WbQKM4WfSYJh5YdZLq7S3csT52EbEfLHTP0iS3dvkp0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qB/kW32N83aOpMuW1SdpeNDgcsNWSffWrNOi3zUyMUoa+wc9EG73kjuL9AiWmt/P4SHru/JePKlo6nruUr6oHsD2pWNfgT1k53FlyMS8gKzSMC/b1R2Kmvo1J5jZbOdLpwIvnfrH+hbJ5dp/F7+XpULPN1MchK2XEnr2csoW1Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=mTUlAJnZ; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Qq3+xYe/YAnEavdjtFQxxGGF2ofcopXV/qtuneNfe0A=; b=mTUlAJnZ2zdCm7YVNNcH3ZNJsH
	849hc9R7sHcjnd+vqa5gY8GhB4KCr/EralmAgExTuMm90CBK/BX7+hNKNS97z6JcIuWEFtbUokG4I
	ASCOyhxXXbs9zgACeHzRyhOF2JnXOR7FCMzotlzvkTwm/h4oc7W+1iGGTG0UUHecxPh9iZOmgQE0x
	/YZMflyzsrkmICIoGHzXLNeYbHJ1WiWJdN55BgH9vk3zzo1LJhtwV7w42L/XnviBaNI5J+sisvPtl
	H27oM7ayIIzNRLaGq2NECJ58T0axMrea6lMN+PEAC67McYUXC3KsMziCMiYhNgopYuhOag5m472wQ
	2lSMzSeA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sBUGp-000EIj-BG; Mon, 27 May 2024 08:55:47 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sBUGp-0002o8-0w;
	Mon, 27 May 2024 08:55:46 +0200
From: Esben Haabendal <esben@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org
Subject: Re: [PATCH] memory: fsl_ifc: Make FSL_IFC config visible and
 selectable
In-Reply-To: <6c166ad5-8004-4bc4-9107-a47ba9a72161@kernel.org> (Krzysztof
	Kozlowski's message of "Sat, 25 May 2024 18:41:06 +0200")
References: <20240523-fsl-ifc-config-v1-1-6eff73bdc7e6@geanix.com>
	<979fd913-050b-445d-9ca8-0ec6906ce3ea@kernel.org>
	<87cypc38gu.fsf@geanix.com>
	<9a7f73f4-f5dc-4342-855b-08df6a839bb5@kernel.org>
	<87le3zoatn.fsf@geanix.com>
	<6c166ad5-8004-4bc4-9107-a47ba9a72161@kernel.org>
Date: Mon, 27 May 2024 08:55:46 +0200
Message-ID: <87ttijaglp.fsf@geanix.com>
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

> On 24/05/2024 10:47, Esben Haabendal wrote:
>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>> 
>>> On 23/05/2024 16:32, Esben Haabendal wrote:
>>>> Krzysztof Kozlowski <krzk@kernel.org> writes:
>>>>
>>>>> On 23/05/2024 15:58, Esben Haabendal wrote:
>>>>>> While use of fsl_ifc driver with NAND flash is fine, as the fsl_ifc_nand
>>>>>> driver selects FSL_IFC automatically, we need the option to be selectable
>>>>>> for platforms using fsl_ifc with NOR flash.
>>>>>
>>>>> Which driver is that?
>>>>
>>>> This is drivers/memory/fsl_ifc.o driver. It is for Integrated Flash
>>>> Controller (IFC) from NXP. It is used in various Layerscape socs.
>>>
>>> ? I know that, I mean the NOR flash working here.
>> 
>> Ah, sorry. The NOR flash I am using here is a Spansion S29AL016J.
>> 
>>>>> Which DTS?
>>>>
>>>> It is for "fsl,ifc" compatible devices.
>>>
>>> That's not a NOR flash.
>> 
>> Nope.  The binding used for the NOR flash is "cfi-flash".
>
> And now let's get back to my original question. I asked for driver, not
> device, and for DTS not compatible.

You got me really confused now. I am not sure what you are asking me
for, and why.

I am sending a patch which changes to Kconfig for a memory controller
driver. The change is AFAICS quite similar to commit be34f45f0d4a
("memory: omap-gpmc: Make OMAP_GPMC config visible and selectable").

As for the NOR flash that in this situation is attached to the IFC
controller, it is (as mentioned) Spansion S29AL016J. It is handled by
the drivers/mtd/maps/physmap.o driver (CONFIG_MTD_PHYSMAP +
CONFIG_MTD_PHYSMAP_OF)

The DTS used to specify the NOR flash is

&ifc {
        status = "okay";
        #address-cells = <2>;
        #size-cells = <1>;
        ranges = <0x0 0x0 0x0 0x60000000 0x00200000>;

        nor_flash: nor@0,0 {
                #address-cells = <1>;
                #size-cells = <1>;
                compatible = "cfi-flash";
                reg = <0x0 0x0 0x200000>;
                bank-width = <2>;

                partition@0 {
                        reg = <0x000000 0x0f0000>;
                        label = "boot0";
                };
        };
};

So as mentioned, it is a quite standard "cfi-flash" compatible device
declaration.

Do you think there is a way that ti enable CONFIG_FSL_IFC for my
situation without the config being visible? Something like automatically
selecting CONFIG_FSL_IFC when CONFIG_MTD_PHYSMAP and
CONFIG_MTD_PHYSMAP_OF is enabled? Will that not include a risk of
pulling in CONFIG_FSL_IFC in some cases where it is not desired?

Something like

config MTD_PHYSMAP
	tristate "Flash device in physical memory map"
	depends on MTD_CFI || MTD_JEDECPROBE || MTD_ROM || MTD_RAM || MTD_LPDDR
        select FSL_IFC if SOC_LS1021A

But that looks like a road somewhere not so nice. The generic
MTD_PHYSMAP being littered with architecture specific selects.

Or is there something completely obvious (not for me then) that I am
missing?

/Esben

