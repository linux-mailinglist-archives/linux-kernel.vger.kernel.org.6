Return-Path: <linux-kernel+bounces-386145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE9B9B3F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8E31F23142
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98142207A;
	Tue, 29 Oct 2024 01:17:13 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFE428E7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730164633; cv=none; b=AapaOUKdSpRRUw3VFxt54mBsWTuMyBJreVMAlEVCgIquPyijuPpRLjSmuKIIVHXW5GIzYsBj5Zx49d3I45w4P9rSQ90IZg6JtxK2coi0l5h13/Qmi0H2JCI+dlx4zQfJBv6deKv5idbAyORq5ao97dEvEAGsMwwIXGmQKlCTGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730164633; c=relaxed/simple;
	bh=apKzHOfApEyzOmorlhfvtchhTqO0/LK6HzGzGKRQ9IE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YUgkqhmCTcINWcuSX10gzjDCkPoc1pzDMOZdgZyG0em0UC2X7EiiPXw2wjhCY41SVoYDp9d1s0Ax76jDetEI+DfqBhe5GDQd3xPt2V6OL8zxhVwbcZd8hsxLXI3CzgJxyaa9HP18rGNUT3Tvxz4/8nnr8NSgCcgeTyYpXfAKRG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Xcskw4JBbz1SDSl;
	Tue, 29 Oct 2024 09:15:36 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F7821402D0;
	Tue, 29 Oct 2024 09:17:07 +0800 (CST)
Received: from [10.67.110.237] (10.67.110.237) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Oct 2024 09:17:06 +0800
Subject: Re: [PATCH] drm/amdgpu: Fix possible NULL pointer dereference
To: "Lazar, Lijo" <lijo.lazar@amd.com>, <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <Hawking.Zhang@amd.com>, <yifan1.zhang@amd.com>,
	<Likun.Gao@amd.com>, <Tim.Huang@amd.com>, <pratap.nirujogi@amd.com>,
	<victorchengchi.lu@amd.com>, <Jun.Ma2@amd.com>, <le.ma@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
References: <20241028215933.2599271-1-lihuafei1@huawei.com>
 <de0e660b-395f-4a26-8bbc-199df83a90b4@amd.com>
From: Li Huafei <lihuafei1@huawei.com>
Message-ID: <1d35a7d8-5fef-6e8d-b0c7-a3ad5e7fb469@huawei.com>
Date: Tue, 29 Oct 2024 09:17:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <de0e660b-395f-4a26-8bbc-199df83a90b4@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500004.china.huawei.com (7.202.181.242)



On 2024/10/28 22:33, Lazar, Lijo wrote:
> 
> 
> On 10/29/2024 3:29 AM, Li Huafei wrote:
>> Fix the potential NULL pointer dereference on mem_ranges in
>> amdgpu_discovery_get_nps_info(). Additionally, assign the output
>> parameters nps_type and range_cnt after the kvzalloc() call to prevent
>> modifying the output parameters in case of an error return.
>>
>> Fixes: b194d21b9bcc ("drm/amdgpu: Use NPS ranges from discovery table")
>> Signed-off-by: Li Huafei <lihuafei1@huawei.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> index 4bd61c169ca8..1b1aedebb3c2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>> @@ -1757,11 +1757,13 @@ int amdgpu_discovery_get_nps_info(struct amdgpu_device *adev,
>>  
>>  	switch (le16_to_cpu(nps_info->v1.header.version_major)) {
>>  	case 1:
>> -		*nps_type = nps_info->v1.nps_type;
>> -		*range_cnt = nps_info->v1.count;
> 
> This one is used in the allocation call below. If you prefer to not
> assign any of the out params before memory allocation is successful,
> then use nps_info->v1.count in the alloc call.
> 

too bad! I missed it. I will send v2 to fix it.

Thanks,
Huafei

> Thanks for adding the alloc fail check.
> 
> Thanks,
> Lijo
>>  		mem_ranges = kvzalloc(
>>  			*range_cnt * sizeof(struct amdgpu_gmc_memrange),
>>  			GFP_KERNEL);
>> +		if (!mem_ranges)
>> +			return -ENOMEM;
>> +		*nps_type = nps_info->v1.nps_type;
>> +		*range_cnt = nps_info->v1.count;
>>  		for (i = 0; i < *range_cnt; i++) {
>>  			mem_ranges[i].base_address =
>>  				nps_info->v1.instance_info[i].base_address;
> .
> 

