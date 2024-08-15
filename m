Return-Path: <linux-kernel+bounces-287412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DE9952784
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 03:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033641C21709
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 01:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD8C63D5;
	Thu, 15 Aug 2024 01:27:40 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44EF4A0F;
	Thu, 15 Aug 2024 01:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685260; cv=none; b=Dxc/NUP23pak72sBOne1N+rc/lZDLCthC2uEwFu+YB/HCczRDdYGYBSQHXtbG/IoM8JPgyPNwV8AjlfPKR2Eg0FPIzjXnQyGzPYP8jaVEXG5+ZLf4mPoyQZ8pKMF/oohu46MCBy8BGQ2Lbh+ol/+E1xQFGoiFN592r2hHIYFlNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685260; c=relaxed/simple;
	bh=xbvyqlxEOPPfP1hO1VoRloe42OaDUPv0zFmEIoQySsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aKzB3rPdWSjmmdN5R5D2RJSqM4QZQfAlqZ+vOAvrHrYtq0hdQvbfRj9Q8v4/yL4HzDeQkf6SK3AOdNeCKtQ4ulNMTx4ldcsUwhdfzmLEwvERZglVyjtvr+E7P70MAHKU43mGEOYvDDZcC8rD1uiX0/0QkTQSBqHma9XEzo4KXDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WknRk26FKz1j6SQ;
	Thu, 15 Aug 2024 09:22:42 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id E153B1400DC;
	Thu, 15 Aug 2024 09:27:34 +0800 (CST)
Received: from [10.67.108.52] (10.67.108.52) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 15 Aug
 2024 09:27:34 +0800
Message-ID: <1ac3259a-813c-4c09-a24d-653207288d7c@huawei.com>
Date: Thu, 15 Aug 2024 09:27:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] usb: bdc: fix module autoloading
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<justin.chen@broadcom.com>, <alcooperx@gmail.com>,
	<bcm-kernel-feedback-list@broadcom.com>
References: <20240814030443.3876203-1-liaochen4@huawei.com>
 <2024081423-trapdoor-alabaster-24a7@gregkh>
From: "liaochen (A)" <liaochen4@huawei.com>
In-Reply-To: <2024081423-trapdoor-alabaster-24a7@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500020.china.huawei.com (7.185.36.49)

On 2024/8/14 12:36, Greg KH wrote:
> On Wed, Aug 14, 2024 at 03:04:43AM +0000, Liao Chen wrote:
>> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
>> based on the alias from of_device_id table.
>>
>> Signed-off-by: Liao Chen <liaochen4@huawei.com>
>> ---
>>   drivers/usb/gadget/udc/bdc/bdc_core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/usb/gadget/udc/bdc/bdc_core.c b/drivers/usb/gadget/udc/bdc/bdc_core.c
>> index 35a652807fca..5149e2b7f050 100644
>> --- a/drivers/usb/gadget/udc/bdc/bdc_core.c
>> +++ b/drivers/usb/gadget/udc/bdc/bdc_core.c
>> @@ -639,6 +639,7 @@ static const struct of_device_id bdc_of_match[] = {
>>   	{ .compatible = "brcm,bdc" },
>>   	{ /* sentinel */ }
>>   };
>> +MODULE_DEVICE_TABLE(of, bdc_of_match);
>>   
>>   static struct platform_driver bdc_driver = {
>>   	.driver		= {
>> -- 
>> 2.34.1
>>
>>
> 
> What commit id does this fix?
Hi, this patch fixes commit 8ac1685bf911f70aea6de67b3db5674c3ea112f1 
("usb: bdc: hook a quick Device Tree compatible string"), which allows 
bdc device probing.

Thanks,
Chen

