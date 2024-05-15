Return-Path: <linux-kernel+bounces-179529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9548C60F6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 08:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE1411C20C05
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A08B4438F;
	Wed, 15 May 2024 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="AnV1AyPa"
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5922945943;
	Wed, 15 May 2024 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755352; cv=none; b=HLDEqAQ1BS7Sr04PqJv0PuQvhfmXcMedZJSNRYmeJ9m2kA/VH9nVDBBWaHR5QHobCsl4IWL5OEgwHovJwQITPgC8Q2XpV/Cmp8eX7sd043r7I6rNR8LR+M3Y/uDLSP18OuA8dXssNPd6ZfK4xGrgjryVeFIadV8LUlcOE+MPbLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755352; c=relaxed/simple;
	bh=iMlYr0Ewm77pHtY7jXSiKck36oYwConGZ1b9AGzBtP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VZ6GiBq+o3KmhjF23ki9h/p+oixOXd42/3/oT7dpXfznsx6L3EPnAnhuNTJy8n4ApL3MjPHVRfriCHMPKbxzpg28jo0xDOTiU1Taqx3ARS6iB9V40/AeoXW2AIpqMcQAg868UP0UOFG2LdvTrbxoFa9cCAqNdnMqEMqjk1ZLw7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=AnV1AyPa; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44F05PSM029365;
	Wed, 15 May 2024 08:42:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=/JIVYxvq9mCRglxSh2kdGVPT8AdWYNNp6KoGXjOv+kA=; b=An
	V1AyPaWYFcTG7Q/oR5JcWofslVX6rydGTYF6mdkKpO+SzGiG0VDRj5MOUbry5yHL
	y0ECkguVqBLqFqMeCxZhxgM75T4D5B/ioU81qZ9SILcNEX03dm3SK6sFIJ+ERDyd
	XcK4PslZ8kg08z5l8/AYpS7sJ7e8pxd5CRIUq2wsrZXNJoKP/FgS2hGvFksGefNZ
	g0hDlgY4M8xdZY4fNcHZvDkQw6fvgGLd6wUVMK2CtXEJ6XJBlcbqQwKvY4CG2V7U
	EGls+Wnlu+vO0aCj9E8BYn+Ox2hMf1TsA+Rxlh2GXz2UvcJNqaykrOlcFBimDpL3
	enZUVxQ808WhW+DLUSCA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3y2kmhv6ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 08:42:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AD9214002D;
	Wed, 15 May 2024 08:42:08 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5DC2A20DD93;
	Wed, 15 May 2024 08:41:19 +0200 (CEST)
Received: from [10.48.87.209] (10.48.87.209) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 08:41:18 +0200
Message-ID: <73a9d56c-9e8d-4859-b3a2-dba1531b57e5@foss.st.com>
Date: Wed, 15 May 2024 08:41:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] clk: stm32mp2: use of STM32 access controller
To: Stephen Boyd <sboyd@kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
CC: <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240419152723.570159-1-gabriel.fernandez@foss.st.com>
 <20240419152723.570159-3-gabriel.fernandez@foss.st.com>
 <332c845c17e24e2eb660e18680f2626f.sboyd@kernel.org>
Content-Language: en-US
From: Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <332c845c17e24e2eb660e18680f2626f.sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_02,2024-05-14_01,2023-05-22_02


On 5/8/24 00:02, Stephen Boyd wrote:
> Quoting gabriel.fernandez@foss.st.com (2024-04-19 08:27:21)
>> diff --git a/drivers/clk/stm32/clk-stm32mp25.c b/drivers/clk/stm32/clk-stm32mp25.c
>> index 210b75b39e50..a37ee9f707e3 100644
>> --- a/drivers/clk/stm32/clk-stm32mp25.c
>> +++ b/drivers/clk/stm32/clk-stm32mp25.c
>> @@ -4,7 +4,9 @@
>>    * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com> for STMicroelectronics.
>>    */
>>   
>> +#include <linux/bus/stm32_firewall_device.h>
> I don't have this include. I either need a signed tag or this needs to
> wait until next merge window.

Sorry for the delay, i was off.

I was based on tag next-20240419

>>   #include <linux/clk-provider.h>
>> +#include <linux/of_address.h>
> What is this include for?

yes #include <linux/io.h> is more appropriate.


