Return-Path: <linux-kernel+bounces-366770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DB799FA26
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB13F284ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 21:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78211F80D9;
	Tue, 15 Oct 2024 21:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WvwVpx8G"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF341F80CF;
	Tue, 15 Oct 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729028088; cv=none; b=hCMnWXwN/eqPhpiFHZbe7vMVxbPm4z+xyaOWFjzwi45MgdZ2KU/p365sWLj/CgP8d9gSLDna2b5YMlZpWPNj9CaQD8fnmCicgGcn/Wr+azsbr/WzeMhgdileMmAZEilCcfa94hkLEcdLwMX5CVA4X1sYfgIMLqF8rw50Z5tOV+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729028088; c=relaxed/simple;
	bh=99hDOdD3Hoek2h3iWva2tdvABFqP0jl+Gw148X878sA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GoqCwFw3AgLfnVSiy7opXWhxQzZIc49vlUgUAEb6gQ+wGQm2U/ns7rpd4nhFj5gGULcko0TToFRd2rPnN0wtL0DOI+X9l77DyhOHKXLO8FvFvuIE3aNHSDtHuS/mnpjZ7EuqATrL2daJP3i0SbHRM3LTTiSgih/43xLOT8dmMFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WvwVpx8G; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49FLYZ6M011296;
	Tue, 15 Oct 2024 16:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1729028075;
	bh=gnM0sof5+5QgdAmcOQbB4PSeLMOw1mlIXfv+A5bnUms=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WvwVpx8GFMKaGL0qlA6xeMOvK9e4rt6Ps62Bf0NdWSqJamCF8t+QUx+n55NhCSSQ4
	 CxpeWFr5IohPPyBQMoxBOiHC7AunS3/J9hxlVomx9zQI+yghoWALVRHz4eI30ONV+V
	 RWp4RfivXBe3emtoz/uuPp5/xs9FazBkC3VmQFwc=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49FLYZYd039040
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Oct 2024 16:34:35 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 15
 Oct 2024 16:34:35 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 15 Oct 2024 16:34:35 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49FLYYgM115618;
	Tue, 15 Oct 2024 16:34:34 -0500
Message-ID: <b6ddbcfa-91ce-4774-b577-08f41e773781@ti.com>
Date: Tue, 15 Oct 2024 16:34:34 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mailbox: ti-msgmgr: Allow building under COMPILE_TEST
To: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
        Jassi
 Brar <jassisinghbrar@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Martyn Welch
	<martyn.welch@collabora.com>,
        Hari Nagalla <hnagalla@ti.com>
CC: <oe-kbuild-all@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20241014144821.15094-3-afd@ti.com>
 <202410160435.WzzQa1p5-lkp@intel.com>
 <1a88e7b5-582f-4d52-864a-e828f6619bc8@app.fastmail.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <1a88e7b5-582f-4d52-864a-e828f6619bc8@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On 10/15/24 3:54 PM, Arnd Bergmann wrote:
> Hi Andrew,
> 
> On Tue, Oct 15, 2024, at 20:46, kernel test robot wrote:
>>     In file included from drivers/firmware/ti_sci.c:14:
>>     In file included from include/linux/io.h:14:
>>     In file included from arch/hexagon/include/asm/io.h:328:
>>     include/asm-generic/io.h:548:31: warning: performing pointer
>> arithmetic on a null pointer has undefined behavior
>> [-Wnull-pointer-arithmetic]
>>       548 |         val = __raw_readb(PCI_IOBASE + addr);
>>           |                           ~~~~~~~~~~ ^
>>     include/asm-generic/io.h:561:61: warning: performing pointer
>> arithmetic on a null pointer has undefined behavior
>> [-Wnull-pointer-arithmetic]
>>       561 |         val = __le16_to_cpu((__le16
>> __force)__raw_readw(PCI_IOBASE + addr));
>>           |
> 
> 
> Hopefully we will be able to finally address these in 6.13
> for all drivers, it's been a decade. Don't worry about
> the above.
> 
> 
>> platform_device *dev,
>>           |                    ^~~~~~~~~~~~~~~~~~~~~~
>>>> drivers/firmware/ti_sci.c:3285:34: warning: unused variable 'ti_sci_of_match' [-Wunused-const-variable]
>>      3285 | static const struct of_device_id ti_sci_of_match[] = {
>>           |                                  ^~~~~~~~~~~~~~~
>>     8 warnings generated.
>>
> 
> Needs this change, please fold into your patch.

Was going to clean this up in several places in another series,
but will add this one to this series, v2 on the way.

Andrew

> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 160968301b1f..6a6bf7a2d134 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
> @@ -3421,7 +3421,7 @@ static struct platform_driver ti_sci_driver = {
>          .probe = ti_sci_probe,
>          .driver = {
>                     .name = "ti-sci",
> -                  .of_match_table = of_match_ptr(ti_sci_of_match),
> +                  .of_match_table = ti_sci_of_match,
>                     .suppress_bind_attrs = true,
>          },
>   };
> 
> 

