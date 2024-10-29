Return-Path: <linux-kernel+bounces-386925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E369B49C8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 13:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24371C222E9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9634BE40;
	Tue, 29 Oct 2024 12:36:26 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93E539A
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 12:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730205386; cv=none; b=Zqn2H+FgemRw3TF58frAv2o+SVGeU2HOkf+S/T1+Ob+dFnyuKy3Z464AhFAix97Om6/j+o8RR+iAN6E8fJaZw8WQ5+5Xf8OkWmXZwgEHtNnC400pf0LYbpBTgF9v5mh2m5YNTwHyaVVYZGkbA3DH4NG/tHUBR5o+pfK4v3n/pj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730205386; c=relaxed/simple;
	bh=KszeXtHea3WQJW4gp6bCastmFE+7WbUDAk52mJb047k=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ToRe1W6g5hKuMOQdHxZJA/rq6MpO4NMfukfnjsuR2PPbk6xB1vTyqmaBsqKZ2tKxfCYmBY6P01vA74SYDgBtNXcgp0+KhqRmDtNkDH0w9ftQ6S2P/zoMtje6UNx1LoYt5acxO5kM1LJid5EkfWWB6EsEuLbs8yAHGFUNPI3JbTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xd8pd18nLz2Df2h;
	Tue, 29 Oct 2024 20:34:49 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 18A091402D0;
	Tue, 29 Oct 2024 20:36:20 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Oct 2024 20:36:16 +0800
Subject: Re: [PATCH v2] drm/amdgpu: Fix possible NULL pointer dereference
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	<alexander.deucher@amd.com>, <lijo.lazar@amd.com>
CC: <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <Hawking.Zhang@amd.com>, <yifan1.zhang@amd.com>,
	<Likun.Gao@amd.com>, <Tim.Huang@amd.com>, <pratap.nirujogi@amd.com>,
	<victorchengchi.lu@amd.com>, <Jun.Ma2@amd.com>, <le.ma@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
References: <20241029101839.2605713-1-lihuafei1@huawei.com>
 <2a070669-aa48-413e-959c-4107d9c2f97c@wanadoo.fr>
From: Li Huafei <lihuafei1@huawei.com>
Message-ID: <44f29433-1fe7-7d6d-616b-3f6755d2f9f3@huawei.com>
Date: Tue, 29 Oct 2024 20:36:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2a070669-aa48-413e-959c-4107d9c2f97c@wanadoo.fr>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500004.china.huawei.com (7.202.181.242)



On 2024/10/29 16:18, Christophe JAILLET wrote:
> Le 29/10/2024 à 11:18, Li Huafei a écrit :
>> Fix the potential NULL pointer dereference on mem_ranges in
>> amdgpu_discovery_get_nps_info(). Additionally, assign the output
>> parameters nps_type and range_cnt after the kvzalloc() call to prevent
>> modifying the output parameters in case of an error return.
>>
>> Fixes: b194d21b9bcc ("drm/amdgpu: Use NPS ranges from discovery table")
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> ---
>> Changes in v2:
>>   - kvzalloc() call uses 'nps_info->v1.count' instead of '*range_cnt'
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index 4bd61c169ca8..9a0b1b208a9d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -1757,11 +1757,13 @@ int amdgpu_discovery_get_nps_info(struct
>> amdgpu_device *adev,
>>         switch (le16_to_cpu(nps_info->v1.header.version_major)) {
>>       case 1:
>> -        *nps_type = nps_info->v1.nps_type;
>> -        *range_cnt = nps_info->v1.count;
>>           mem_ranges = kvzalloc(
> 
> Not strictly related to your fix, but this could also be kvcalloc() to
> avoid potential overflow in the multiplication.
> 

Good suggestion! I added this modification in v3:

v3: https://lore.kernel.org/lkml/20241029202758.2764535-1-lihuafei1@huawei.com/T/#u

Lijo, I've added your Reviewed-by tag in v3. If you have any questions about the kvcalloc() modification, please let me know.

Thanks,
Huafei
> CJ
> 
>> -            *range_cnt * sizeof(struct amdgpu_gmc_memrange),
>> +            nps_info->v1.count * sizeof(struct amdgpu_gmc_memrange),
>>               GFP_KERNEL);
>> +        if (!mem_ranges)
>> +            return -ENOMEM;
>> +        *nps_type = nps_info->v1.nps_type;
>> +        *range_cnt = nps_info->v1.count;
>>           for (i = 0; i < *range_cnt; i++) {
>>               mem_ranges[i].base_address =
>>                   nps_info->v1.instance_info[i].base_address;
> 
> 
> .

