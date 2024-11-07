Return-Path: <linux-kernel+bounces-399154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0470B9BFBAA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 02:35:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE7A02821FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 01:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336E2F9D6;
	Thu,  7 Nov 2024 01:33:35 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343BDFC08
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 01:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730943214; cv=none; b=K9kY+TJHZfRAg1e46bsCJ9z1CtLWiKxMMCZ8NsnNkzoqJyHKL3hI3hIWAY0ep6ADHcsOm6C50BJCPTPgAqx0V/p7mX7MrOmFD2xk3f7bHSda8Hd7lNjMo5PXcMPlzZElbswc7YF19ys0P4cjSmwnveqqOZekERUmg1qW66h3yf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730943214; c=relaxed/simple;
	bh=RS+jERbBykjPMuoLjFBgH2713VKDfh+Zss9op3dVNXY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=qpUQyLvDMlw+4+UnOLemJE8kWSz0BQfep5cZSM9tFZHNzeZNv88u03Rr2INJJ91xbaMwEFK3gMICD3YUksphYM7z6GqZS7ITjXHBd7Roac2X20RxXsb9eGtfqPMW6O1yzWThvpIwtIov8RwCW8vc0iP+HaUJ7nsqsJS9Xyg+xIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XkPfh6Rg7z1T9TQ;
	Thu,  7 Nov 2024 09:31:08 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id A78CC180105;
	Thu,  7 Nov 2024 09:33:29 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 09:33:28 +0800
Message-ID: <534caf1f-626b-252d-b08a-fc5a3cc007e9@huawei.com>
Date: Thu, 7 Nov 2024 09:33:27 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v4] drm/ttm/tests: Fix memory leak in
 ttm_tt_simple_create()
Content-Language: en-US
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <christian.koenig@amd.com>, <ray.huang@amd.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<karolina.stolarek@intel.com>, <Arunpravin.PaneerSelvam@amd.com>,
	<thomas.hellstrom@linux.intel.com>, <asomalap@amd.com>,
	<quic_jjohnson@quicinc.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
References: <20241026020758.3846669-1-ruanjinjie@huawei.com>
 <560d2026-5785-b6b1-eb7d-3afed714d47f@huawei.com>
In-Reply-To: <560d2026-5785-b6b1-eb7d-3afed714d47f@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemg200008.china.huawei.com (7.202.181.35)



On 2024/10/30 10:01, Jinjie Ruan wrote:
> Gentle ping.
> 
> On 2024/10/26 10:07, Jinjie Ruan wrote:
>> modprobe ttm_device_test and then rmmod ttm_device_test, the following
>> memory leaks occurs:
>>
>> The ttm->pages allocated in ttm_tt_init() is not freed after calling
>> ttm_tt_simple_create(), which cause the memory leak:
>>
>> 	unreferenced object 0xffffff80caf27750 (size 8):
>> 	  comm "kunit_try_catch", pid 2242, jiffies 4295055735
>> 	  hex dump (first 8 bytes):
>> 	    c0 1e 3d c3 fe ff ff ff                          ..=.....
>> 	  backtrace (crc 3d11615a):
>> 	    [<000000007f57312a>] kmemleak_alloc+0x34/0x40
>> 	    [<000000008c6c4c7e>] __kmalloc_node_noprof+0x304/0x3e4
>> 	    [<00000000679c1182>] __kvmalloc_node_noprof+0x1c/0x144
>> 	    [<000000006aed0a3d>] ttm_tt_init+0x138/0x28c [ttm]
>> 	    [<000000005c331998>] drm_gem_shmem_free+0x60/0x534 [drm_shmem_helper]
>> 	    [<0000000022b4f375>] kunit_try_run_case+0x13c/0x3ac
>> 	    [<00000000c525d725>] kunit_generic_run_threadfn_adapter+0x80/0xec
>> 	    [<000000002db94a1f>] kthread+0x2e8/0x374
>> 	    [<000000002c457ad7>] ret_from_fork+0x10/0x20
>> 	......
>>
>> Fix it by calling ttm_tt_fini() in the exit function.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: e6f7c641fae3 ("drm/ttm/tests: Add tests for ttm_tt")
>> Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>

Hi, Nirmoy,

could this patch be merged?

>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> v4:
>> - Split out to be alone.
>> v3:
>> - s/fllowing/following/
>> v2:
>> - Add Reviewed-by.
>> ---
>>  drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c b/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
>> index b91c13f46225..9ff216ec58ef 100644
>> --- a/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
>> +++ b/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
>> @@ -54,6 +54,7 @@ static struct ttm_tt *ttm_tt_simple_create(struct ttm_buffer_object *bo, u32 pag
>>  
>>  static void ttm_tt_simple_destroy(struct ttm_device *bdev, struct ttm_tt *ttm)
>>  {
>> +	ttm_tt_fini(ttm);
>>  	kfree(ttm);
>>  }
>>  

