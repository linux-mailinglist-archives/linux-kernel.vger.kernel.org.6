Return-Path: <linux-kernel+bounces-364566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6386D99D633
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 20:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03D95B20E19
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED34E1C82F4;
	Mon, 14 Oct 2024 18:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bvp1p2//"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A511C82E2
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 18:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929648; cv=none; b=Crrvzw8LzYFrzEnx4CP1ceDEoEoi0TiPyu95ebhXxGzgDsDLbN2MWdb3q/yxInruVgcc84jCszxGFaA20/+qvmuxCc5CK5klyQR7RcSpkenWGYEAhWOAB9ptYntDWH61xfYkO8xtT0bdHSx/8K4fIl9FO7yShaa74Q3gD/BFqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929648; c=relaxed/simple;
	bh=JVEevRHg7jROvFiWyNYmSBG80g3xEtUHD6zmo82d5wA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PGFafIb6J4DRGY4rdQO2qREuLoOS+mOJtTGdjhGVXxYslnW7j7875WZ2Nk9ByRvHRMnTJYK4mmoAHsrL7Sx+DvqMSdoP7Lh945Kb4aRAghMESw55mRV6sy8CmJ8j4yj82g5ROOjmaepgRCu38dvi9Bln8GU4RnTBTpIDeCvvDrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bvp1p2//; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49EIDZKh129076;
	Mon, 14 Oct 2024 13:13:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1728929615;
	bh=wpbIaxYim+IbIS6Col4NYLeorX2DPDL/x3PXTs/v44g=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bvp1p2//JJqADugTPrwxA3ksqYOXcLhhNKjnHtjZ58vFzss96fZV/tQvVqw40/61E
	 Z/WCDPYN/AFveGM7IzcA6K1L/bMaqemjO5LCHyqhjs8TE75tmWO2eN0XVwBkHWHkLv
	 O80PzSH/RbKpnCvVE22uI4oDmsC4uBeYRVMCH580=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49EIDZJD023764
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 13:13:35 -0500
Received: from flwvowa01.ent.ti.com (10.64.41.90) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Oct 2024 13:13:35 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by flwvowa01.ent.ti.com
 (10.64.41.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Mon, 14 Oct
 2024 13:13:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Oct 2024 13:13:34 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49EIDY2I032080;
	Mon, 14 Oct 2024 13:13:34 -0500
Message-ID: <7a09bb95-fa22-4c60-af4a-16720fa8633d@ti.com>
Date: Mon, 14 Oct 2024 13:13:33 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Switch more ARM plats to sys-off handler API
To: Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andre Przywara
	<andre.przywara@arm.com>,
        Russell King <linux@armlinux.org.uk>, Shawn Guo
	<shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix
 Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>,
        Daniel Mack <daniel@zonque.org>,
        "Haojian
 Zhuang" <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <imx@lists.linux.dev>
References: <20241011201645.797394-1-afd@ti.com>
 <87cyk3c8ui.fsf@BLaptop.bootlin.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <87cyk3c8ui.fsf@BLaptop.bootlin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10/14/24 4:49 AM, Gregory CLEMENT wrote:
> Hello Andrew,
> 
>> Hello all,
>>
>> Continuing the quest to remove the legacy pm_power_off() global
>> function handler. Remove uses from arch/arm/ using the helper
>> register_platform_power_off().
> 
> I am in CC of this series, however, I am not the maintainer of any of
> these platforms, and I don't remember making any changes related to your
> series recently. Could you tell me what you expect from me?
> 

I had CC'd you for v1/v2 of this series as it had a patch for Orion5x, but
since you have already taken that patch I should have removed you from CC,
my bad. Nothing needed from you here.

Thanks,
Andrew

> Thanks,
> 
> Gregory
> 
>>
>> Thanks,
>> Andrew
>>
>> Changes for v3:
>>   - Rebase on v6.12-rc1
>>
>> Changes for v2:
>>   - Collect Reviewed/Acked-bys
>>   - Rebase on v6.11-rc1
>>
>> Andrew Davis (6):
>>    ARM: highbank: Switch to new sys-off handler API
>>    ARM: imx: Switch to new sys-off handler API
>>    ARM: pxa: Switch to new sys-off handler API
>>    ARM: sa1100: Switch to new sys-off handler API
>>    ARM: vt8500: Switch to new sys-off handler API
>>    arm/xen: Switch to new sys-off handler API
>>
>>   arch/arm/mach-highbank/highbank.c | 2 +-
>>   arch/arm/mach-imx/pm-imx6.c       | 6 ++----
>>   arch/arm/mach-pxa/spitz.c         | 2 +-
>>   arch/arm/mach-sa1100/generic.c    | 2 +-
>>   arch/arm/mach-vt8500/vt8500.c     | 2 +-
>>   arch/arm/xen/enlighten.c          | 2 +-
>>   6 files changed, 7 insertions(+), 9 deletions(-)
>>
>> -- 
>> 2.39.2

