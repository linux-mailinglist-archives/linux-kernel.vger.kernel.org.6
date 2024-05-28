Return-Path: <linux-kernel+bounces-192429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50648D1D22
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2E0EB24016
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAE316F298;
	Tue, 28 May 2024 13:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="yp5FCoOt"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B28716F28D
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903197; cv=none; b=smI4H+3r+n7ShAg7Hg4Ap+V+dV+Oi+vxI72bcKSZYWnWrJOh4qGZIpKd/KcSXehmWyyIZCouEUgf4z6IT9ngle1RgT4hmXokr7x5vzQWMjYJ/jNCEmvMEpjozVfJvd8qi29mX2lx/S9eLNugVdQ3+Ni7DEjnpVp38MjFa1y2SHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903197; c=relaxed/simple;
	bh=q/vMae1L4yOc2ytS+jEdq+z0LHJ0eTg/q1QB2cL92f4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y+Wla4K2L/ZerQ1/Idgi5XaEUzqdSIV3p24IP28YcU64B9waXXROY6Tc6rErIFfkydI9WbDzHMqfXS1WtlDlYDPdLFMiqRYBoj7R1RBWyALDV8v3h35PyOmFnAi32/NHr2v7CndYuZrKPu07oUp4Dp7y59rLkL/hDt42DE8Cv78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=yp5FCoOt; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Content-Type:MIME-Version:Message-ID:Date:References:
	In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=+OlDy71KRIzdA+LVGy9z1RewFWm1WDFmdy93yC8byEM=; b=yp5FCoOteuewC8Nl9TYOsbYNyg
	CKaOdc1Zk/5mY7ser3Q/DH6EE2tB+ZAGkLTJZ4iNF3mUA5dfOYk7rEjwAdy+EaIdb1nNrzkOPJrpN
	KBYFEcUqqGiMCRUJmW6EJtHbjh4u7BuDD2JcnNPcjUNaytpc6amsgtDP5HjR8Ed4KjsO8YA+rdmBj
	A4gpEo+CgbIFKcu2Iv0+36JOsJxAFux7tHZ46NiWwgjCGQj6sv6cMaAumX111q+RRnV5xJ3jM7Hod
	f9Ur9+Qba2onRu6KXQqQTiDZ7Wr449FhD9vwCYV7cXRyemOcVuT7WvoX2pSKMd77dWJMnjIbpATGx
	XFzwPG2g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1sBwws-0001Wh-HA; Tue, 28 May 2024 15:33:06 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1sBwwr-00068E-36;
	Tue, 28 May 2024 15:33:05 +0200
From: Esben Haabendal <esben@geanix.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,  Pratyush Yadav
 <pratyush@kernel.org>,  Michael Walle <mwalle@kernel.org>,  Miquel Raynal
 <miquel.raynal@bootlin.com>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Michael Ellerman
 <mpe@ellerman.id.au>,  Nicholas Piggin <npiggin@gmail.com>,  Christophe
 Leroy <christophe.leroy@csgroup.eu>,  "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>,  "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
  linux-kernel@vger.kernel.org,  linux-mtd@lists.infradead.org,
  linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/2] powerpc/configs: Update defconfig with now
 user-visible CONFIG_FSL_IFC
In-Reply-To: <096662e8-03cf-4c13-baa0-11918cab7511@kernel.org> (Krzysztof
	Kozlowski's message of "Tue, 28 May 2024 15:00:57 +0200")
References: <20240528-fsl-ifc-config-v2-0-5fd7be76650d@geanix.com>
	<20240528-fsl-ifc-config-v2-2-5fd7be76650d@geanix.com>
	<096662e8-03cf-4c13-baa0-11918cab7511@kernel.org>
Date: Tue, 28 May 2024 15:33:04 +0200
Message-ID: <87le3ukqnj.fsf@geanix.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27289/Tue May 28 10:30:59 2024)

Krzysztof Kozlowski <krzk@kernel.org> writes:

> On 28/05/2024 14:28, Esben Haabendal wrote:
>> With CONFIG_FSL_IFC now being user-visible, and thus changed from a select
>> to depends in CONFIG_MTD_NAND_FSL_IFC, the dependencies needs to be
>> selected in config snippets.
>> 
>> Signed-off-by: Esben Haabendal <esben@geanix.com>
>> ---
>>  arch/powerpc/configs/85xx-hw.config | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/arch/powerpc/configs/85xx-hw.config b/arch/powerpc/configs/85xx-hw.config
>> index 524db76f47b7..8aff83217397 100644
>> --- a/arch/powerpc/configs/85xx-hw.config
>> +++ b/arch/powerpc/configs/85xx-hw.config
>> @@ -24,6 +24,7 @@ CONFIG_FS_ENET=y
>>  CONFIG_FSL_CORENET_CF=y
>>  CONFIG_FSL_DMA=y
>>  CONFIG_FSL_HV_MANAGER=y
>> +CONFIG_FSL_IFC=y
>
> Does not look like placed according to config order.

Correct.

> This is not alphabetically sorted, but as Kconfig creates it (make
> savedefconfig).

Are you sure about this?

It looks very much alphabetically sorted, with only two "errors"

$ diff -u 85xx-hw.config 85xx-hw.config.sorted 
--- 85xx-hw.config      2024-05-28 15:05:44.665354428 +0200
+++ 85xx-hw.config.sorted       2024-05-28 15:05:56.102019081 +0200
@@ -15,8 +15,8 @@
 CONFIG_DMADEVICES=y
 CONFIG_E1000E=y
 CONFIG_E1000=y
-CONFIG_EDAC=y
 CONFIG_EDAC_MPC85XX=y
+CONFIG_EDAC=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_FB_FSL_DIU=y
@@ -71,10 +71,10 @@
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_NAND_FSL_ELBC=y
 CONFIG_MTD_NAND_FSL_IFC=y
-CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_MTD_PHYSMAP=y
 CONFIG_MTD_PLATRAM=y
+CONFIG_MTD_RAW_NAND=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_NETDEVICES=y
 CONFIG_NVRAM=y

I don't think that this file has ever been Kconfig sorted since it was
created back in ancient times.

And as it is merged with other config snippets using merge_into_defconfig
function. I have no idea how to use savedefconfig to maintain such a snippet.
It would require doing the reverse of the merge_into_defconfig.

>>  CONFIG_FSL_PQ_MDIO=y
>>  CONFIG_FSL_RIO=y
>
> You also missed to update second defconfig - arm64.

Argh. I thought I checked, and it did not need any changes. But it needs
to have CONFIG_FSL_IFC=y added.

I will add that for v3.

/Esben

