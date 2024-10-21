Return-Path: <linux-kernel+bounces-373610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B509A595C
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 05:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE032810CB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 03:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DD6193081;
	Mon, 21 Oct 2024 03:58:01 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289EF155321
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729483081; cv=none; b=qG7jsaPYFTDVjIqKOmH9VWTPsj/ZgPE/CWXuIXtpUviNdNOJMjm+lBZhUJa5UfZkdgPHkiSFJy+pbeRL9DjxY4XIioInoyZhwh4MXev0BtGLE7sFu2nvM0Oh++paYJsKK/QbzuAxZx+nhYxP/5u9rnCs4Lnes80q9yWf/TGZLh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729483081; c=relaxed/simple;
	bh=+FDvEMlffhg+6zqE7ycB1hdExhvrdzf6pxoen9CWu3E=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=b09nMhHUrmRp1TdU0pc7XVCXwFO5HHKpbyZldemgmJ4RPedUL3BzhnH8LBOy/ypQNY5mh9exxnMxVyDZYOR/TITgIUsniKaD3w/qjyz+pAj/hp5dojT61I46xCuASDkWjhmFwnrTb2brqAL5fESJLgoz48bAG0UASsfVDAnl98w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XX1hN521lz1j9h5;
	Mon, 21 Oct 2024 11:56:36 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id C09271A0171;
	Mon, 21 Oct 2024 11:57:56 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 21 Oct 2024 11:57:56 +0800
Subject: Re: [PATCH 1/1] coresight: trbe: Fix return value check in
 arm_trbe_register_coresight_cpu()
To: Anshuman Khandual <anshuman.khandual@arm.com>, Suzuki K Poulose
	<suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>, James Clark
	<james.clark@linaro.org>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, <coresight@lists.linaro.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20241018140858.711-1-thunder.leizhen@huawei.com>
 <431e46b5-24f7-41f4-b321-70a6894c3831@arm.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <361f5e4b-e269-1a07-ccde-017ef713eaa1@huawei.com>
Date: Mon, 21 Oct 2024 11:57:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <431e46b5-24f7-41f4-b321-70a6894c3831@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/21 10:58, Anshuman Khandual wrote:
> 
> 
> On 10/18/24 19:38, Zhen Lei wrote:
>> Function devm_kzalloc() returns NULL instead of ERR_PTR() when it fails.
> 
> Right, devm_kzalloc() calls devm_kmalloc() with additional __GFP_ZERO which
> returns NULL on error.
> 
>> The IS_ERR() test in the return value check should be replaced with NULL
>> test.
>>
>> Fixes: 39744738a67d ("coresight: trbe: Allocate platform data per device")
>> Fixes: 3fbf7f011f24 ("coresight: sink: Add TRBE driver")
> 
> Actually this problem is caused by the following commit which had replaced
> coresight_get_platform_data() with devm_kzalloc() for a dummy 'desc.pdata'
> allocation. Earlier IS_ERR() test for the return value, was correct for
> coresight_get_platform_data() which returns ERR_PTR() on error, but then
> it should have been changed for devm_kzalloc() into a NULL check instead.
> 
> 4277f035d227 ("coresight: trbe: Add a representative coresight_platform_data for TRBE")
> 
> Please add "Fixes:" tag for the above commit instead.

Yes, you're right. In retrospect, I probably found 3fbf7f011f24 just by
searching for IS_ERR(). I will update and post v2. Thanks.

> 
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-trbe.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
>> index 96a32b213669940..93fe9860acf16bd 100644
>> --- a/drivers/hwtracing/coresight/coresight-trbe.c
>> +++ b/drivers/hwtracing/coresight/coresight-trbe.c
>> @@ -1266,7 +1266,7 @@ static void arm_trbe_register_coresight_cpu(struct trbe_drvdata *drvdata, int cp
>>  	 * into the device for that purpose.
>>  	 */
>>  	desc.pdata = devm_kzalloc(dev, sizeof(*desc.pdata), GFP_KERNEL);
>> -	if (IS_ERR(desc.pdata))
>> +	if (!desc.pdata)
>>  		goto cpu_clear;
>>  
>>  	desc.type = CORESIGHT_DEV_TYPE_SINK;
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> .
> 

-- 
Regards,
  Zhen Lei

