Return-Path: <linux-kernel+bounces-307614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD67965062
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 21:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF458B241FB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 19:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD111BAEE2;
	Thu, 29 Aug 2024 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OirfZhhS"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8DB1B5824;
	Thu, 29 Aug 2024 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724961379; cv=none; b=aymfSV4IIOG7yXtdG1ro2mMtrxdL79JavzqEqfUCceOGvDsxoc9R65IGGcZePaQxkO69nd9MEYFKZ+ByVb50CWceEvObHUGcb6Qefwmg9MUuVbBtHW/81NFpl6MwTzsFlBeuXZiQTwnfLnqSDQ09FOK5J5wAYAxRMOkkKUjTSH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724961379; c=relaxed/simple;
	bh=QkC3UofcSUSlZG40WCx2CWamtpvCsKeUqOwSeGLIDxw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B35ytS1NSVhzt34AWhplI9/BMI6CQ+NUUk1+d1vAUQiPXr+h8itM4UKVelkHUHd8EHq1bMEf6rGxikTyV8nlcje4jeNovV4An4PLszA4K+i72/CKJS3ILV0jnYtZjrLxsOKHsyOpaGIpH7DonNjrlibzvHG6mI+oNdfsdb1ckfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OirfZhhS; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 47TJuBs8106544;
	Thu, 29 Aug 2024 14:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1724961371;
	bh=2UsUDj4tsR68w9vopHIC4AppVJtFGoZFsqs9JxFUHb8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OirfZhhSnOLuRMmepKs7vFat/NbYjWKU9Wv9mNUavwAff8yDJNsXRyMpn5bqSAPB7
	 aoFmWp9Nee6L78gHKXeEGlZ1W7Llh186a86zBtjuuZ3nHDOEhcQS02p3qlOiIKMO5U
	 6PHkeEYYbodiZxVgYHLkP7Tx6Fwnqb71MF2hntKI=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 47TJuBHP022558
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Aug 2024 14:56:11 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 29
 Aug 2024 14:56:10 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 29 Aug 2024 14:56:10 -0500
Received: from [128.247.81.191] (uda0499903.dhcp.ti.com [128.247.81.191])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 47TJuAQL075553;
	Thu, 29 Aug 2024 14:56:10 -0500
Message-ID: <0f3764c4-22c5-4839-a541-8c333f5c2c6d@ti.com>
Date: Thu, 29 Aug 2024 14:56:10 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-j7200: Fix register map for main
 domain pmx
To: Nishanth Menon <nm@ti.com>, Aniket Limaye <a-limaye@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mranostay@ti.com>,
        <conor+dt@kernel.org>, <krzk+dt@kernel.org>, <robh@kernel.org>,
        <kristo@kernel.org>, <vigneshr@ti.com>, <u-kumar1@ti.com>
References: <20240829071208.2172825-1-a-limaye@ti.com>
 <20240829183155.dpaia4koseebgmdm@sudoku>
Content-Language: en-US
From: Jared McArthur <j-mcarthur@ti.com>
In-Reply-To: <20240829183155.dpaia4koseebgmdm@sudoku>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 8/29/24 13:31, Nishanth Menon wrote:
> On 12:42-20240829, Aniket Limaye wrote:
>> From: Jared McArthur <j-mcarthur@ti.com>
>>
>> Commit 0d0a0b441346 ("arm64: dts: ti: k3-j7200: fix main pinmux
>> range") split the main_pmx0 into two nodes: main_pmx0 and main_pmx1
>> due to a non-addressable region, but incorrectly represented the
>> ranges. As a result, the memory map for the pinctrl is incorrect. Fix
>> this by introducing the correct ranges.
>>
>> The ranges are taken from the J7200 TRM (Table 5-695. CTRL_MMR0
>> Registers). Padconfig registers stretch from 0x11c000 to 0x11c168
>> with non-addressable portions from 0x11c10c to 0x11c10f, 0x11x114 to
>> 0x11c11b, and 0x11c128 to 0x11c163.
>>
>> Link: https://www.ti.com/lit/ug/spruiu1c/spruiu1c.pdf (TRM)
> Use the canonical link that redirects to the latest document such as https://www.ti.com/lit/pdf/spruiu1
>
> older versions of the TRM may not be retained in ti.com

Thank you, will do.

>> Fixes: 0d0a0b441346 ("arm64: dts: ti: k3-j7200: fix main pinmux range")
>> Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
>> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
>> ---
>>  .../dts/ti/k3-j7200-common-proc-board.dts     |  2 +-
>>  arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 22 +++++++++++++++++--
>>  2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> index 6593c5da82c0..df39f2b1ff6b 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>> @@ -254,7 +254,7 @@ J721E_IOPAD(0x38, PIN_OUTPUT, 0) /* (Y21) MCAN3_TX */
>>  	};
>>  };
>>  
>> -&main_pmx1 {
>> +&main_pmx2 {
>>  	main_usbss0_pins_default: main-usbss0-default-pins {
>>  		pinctrl-single,pins = <
>>  			J721E_IOPAD(0x04, PIN_OUTPUT, 0) /* (T4) USB0_DRVVBUS */
> How is this change correct if you are changing the base from 0x1c to
> 0x10 (previously it was pointing to 0x20, now to 0x14? what is the
> correct offset of USB0_DRVBUS pin?)

The base hasn't changed because it's switched to main_pmx2
instead of main_pmx1. main_pmx2 is the same address range as the
original main_pmx1. I agree that this should be explained in the
commit message/diffstat.

> Did you do an audit of all offsets of main_pmx2 and 3 and resultant
> address split up (including overlays if applicable)?

All current pinmuxing for J7200's dts and dtso files is within the
main_pmx0, except for the USB0_DRVBUS pin. Since the address range for
main_pmx0 has not changed, there are no other changes that need to be
made.

> Explain that in commit message / diffstat as appropriate

I agree that this should be written out in a commit message /
diffstat. Perhaps it should also be a separate patch within the same
series.

>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> index 9386bf3ef9f6..41adfa64418d 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> [...]
>
-- 
Best,
Jared McArthur


