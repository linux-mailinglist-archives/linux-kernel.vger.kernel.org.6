Return-Path: <linux-kernel+bounces-316274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D43096CD62
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 05:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329591F27008
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 03:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6B4154444;
	Thu,  5 Sep 2024 03:34:31 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F1C153838
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 03:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725507271; cv=none; b=fcH+7814Dgs1USts19GsRPx5pkMRdBApi66fmbsizVqQIO7FLKu7sEhdR0KJ5Gv+qo+RgMPJi9IKt4InRWg7r/Si33tMgvDCqAPU7GhJZkVUf+8Xmb/F3jsPxvSvfBGoGZoq6gtt1L0KCzQtcWh+li+2k4ukU78aj1sk3GsbaNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725507271; c=relaxed/simple;
	bh=dXjidnn83ylHHOMKhEoaST7/Gc1CP8t7ZniVbUgNCJo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k0pA8fBGD+Vc2MxByo3JEwlNxJVNYyrctG8i1hrfXFNjpKk0YwPhEWBERHefjpcPsbC2x1+2HNI0h+z/pWhb+LiauX+Vg/8zEL6RkqXrJGbtmSzBKqqwmsuh/1F1JgsaGdHuOkkywIs5bor3StqytCirmVOqcbcDHHPtcXV23Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WzlGH0zkSz69Wt;
	Thu,  5 Sep 2024 11:29:27 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 66C6E18005F;
	Thu,  5 Sep 2024 11:34:25 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 5 Sep 2024 11:34:24 +0800
Message-ID: <50551f21-6e90-3556-7a3d-8b81a042f99c@huawei.com>
Date: Thu, 5 Sep 2024 11:34:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] static_call: Handle module init failure correctly in
 static_call_del_module()
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, Christophe Leroy
	<christophe.leroy@csgroup.eu>, Josh Poimboeuf <jpoimboe@kernel.org>
References: <87cylj7v6x.ffs@tglx>
 <3e158999-c93a-a4e3-85a9-2d6bfc1ccee7@huawei.com> <877cbr7qed.ffs@tglx>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <877cbr7qed.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/4 16:51, Thomas Gleixner wrote:
> On Wed, Sep 04 2024 at 16:03, Jinjie Ruan wrote:
>> On 2024/9/4 15:08, Thomas Gleixner wrote:
>>> So the check must be:
>>>
>>> 	if (!static_call_key_has_mods(key))
>>>         	break;
>>
>> Hi, Thomas,
>>
>> with this patch, the issue not occurs again，
>>
>> but there are some memory leak here same to the following problem:
> 
> That has absolutely nothing to do with static calls and the memory
> allocation failure case there.
> 
> The module passed all preparatory steps, otherwise it would not be able
> to create a kmem_cache from the module init() function:
> 
>      kmem_cache_create+0x11/0x20
>      do_one_initcall+0xdc/0x550
>      do_init_module+0x241/0x630
> 
> amdgpu_init()
> 
> 	r = amdgpu_sync_init();
> 	if (r)
> 		goto error_sync;
> 
> 	r = amdgpu_fence_slab_init();
> 	if (r)
> 		goto error_fence;
> 
>         <SNIP>
>         
> 	return pci_register_driver(&amdgpu_kms_pci_driver);
> 
> error_fence:
> 	amdgpu_sync_fini();
> error_sync:
>         return r;
> 
> Can you spot the problem?

Hi, Thomas,

It seems that it is not the memory leak source,

I test with the following patch, the memory leak also occurs,

but with the Link patch, the problem solved and the memory leak missed.

 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 094498a0964b..3589e4768bd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3032,11 +3032,11 @@ static int __init amdgpu_init(void)

        r = amdgpu_sync_init();
        if (r)
-               goto error_sync;
+               return r;

        r = amdgpu_fence_slab_init();
        if (r)
-               goto error_fence;
+               goto error_sync;

        DRM_INFO("amdgpu kernel modesetting enabled.\n");
        amdgpu_register_atpx_handler();
@@ -3046,12 +3046,18 @@ static int __init amdgpu_init(void)
        amdgpu_amdkfd_init();

        /* let modprobe override vga console setting */
-       return pci_register_driver(&amdgpu_kms_pci_driver);
+       r = pci_register_driver(&amdgpu_kms_pci_driver);
+       if (r)
+               goto error_fence;
+
+       return 0;

 error_fence:
-       amdgpu_sync_fini();
+       amdgpu_fence_slab_fini();

 error_sync:
+       amdgpu_sync_fini();
+
        return r;
 }


> 
> Thanks,
> 
>         tglx

