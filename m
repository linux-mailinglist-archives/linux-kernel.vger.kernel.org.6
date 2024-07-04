Return-Path: <linux-kernel+bounces-241006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9639275AE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFAF4B21511
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1863A1AE09B;
	Thu,  4 Jul 2024 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="BAjmcqJi"
Received: from out0-205.mail.aliyun.com (out0-205.mail.aliyun.com [140.205.0.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEFB81A2575
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 12:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720094636; cv=none; b=uP0x5b3pE4nrsOr8om/Dgz/csyOSwHFVi/R5UOHvAsltPWfhDUV6dy+Y/yVjXpCp0UzrWqP/g1dnb94XmGSsEQ1e535SJaPnak5hfJztUYWJpW6FHOSKpkFjIW0WgqUWMZGMziKWJBX/OEtYkqTe7Rsddo1B1sn89ZKRo8jbP5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720094636; c=relaxed/simple;
	bh=JDumeNspSWqlTWbZ6YnvyRprnInAaX726rTS4K1KRUQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSeenHCdqhXmSiBX/InBHo9WdC4QCFJScO8KYLkEQu7f/c76NLvmHGq8C7y8W1xhu1LAF/PXH9J5luprDCMKRliK0orO72CPoRE4USlRMoTxLXOJ4b5rffZqEZiYNWJgHS2JtZjEnkg5KTTI3iYN8WuxtL4pDxMJIcBJmvp8nP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=BAjmcqJi; arc=none smtp.client-ip=140.205.0.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1720094624; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=cbVEhxr2ORWQD6IKAPLNFnpCkoyFxpBMWadoI4o3XEk=;
	b=BAjmcqJiJyq/uKuVMZhxLqWNaioK8tEKdyron0JZ+nRP1ZB7+L0gLXRsejbViBonhNtJt4KCBTHSyYgubydiAxg+RXy+bUeW5iunQOhFFKpVPyF83GPVhW9SNMH6vPwhLD8ms8cyD3PXEIYdC1AdUJA4JYkTFZtUO3rZS/Isnwg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033070021168;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---.YHNnlVT_1720094622;
Received: from 30.230.83.123(mailfrom:libang.li@antgroup.com fp:SMTPD_---.YHNnlVT_1720094622)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 20:03:42 +0800
Message-ID: <6fc49a27-5d82-4690-9722-6cfe5f269f43@antgroup.com>
Date: Thu, 04 Jul 2024 20:03:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: thp: support "THPeligible" semantics for mTHP with
 anonymous shmem
To: Ryan Roberts <ryan.roberts@arm.com>, ughd@google.com,
 akpm@linux-foundation.org
Cc: david@redhat.com, wangkefeng.wang@huawei.com,
 baolin.wang@linux.alibaba.com, ioworker0@gmail.com, ziy@nvidia.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240702023401.41553-1-libang.li@antgroup.com>
 <507da6d0-77c5-46ca-8351-53b405ecb131@arm.com>
 <8c018e06-74f1-46e9-bc32-b3870342cdc1@antgroup.com>
 <8d9e501a-0645-4b78-809a-7c9f49f2106d@arm.com>
 <c1e38d54-400c-4647-9ffb-1bf70f92c0c2@antgroup.com>
 <ccd5a1b8-3b01-4f5a-b9fb-6a5068b08a4a@arm.com>
 <941458a6-9e74-444a-9dfd-726d0a7cf158@antgroup.com>
 <60829312-5011-4fa8-9a56-40c6e2382e2f@arm.com>
Content-Language: en-US
From: "Bang Li" <libang.li@antgroup.com>
In-Reply-To: <60829312-5011-4fa8-9a56-40c6e2382e2f@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 2024/7/4 18:25, Ryan Roberts wrote:
>>>
>>> See [1] for an expanded list of concerns I have about the current state of the
>>> interface and implementation.
>>
>> OK, could you please send me the corresponding link ;)？
> 
> Oops!
> 
> https://lore.kernel.org/linux-mm/65c37315-2741-481f-b433-cec35ef1af35@arm.com/

Thank you for providing the link. I will review the details of your 
concerns.

Best regards,
Bang

