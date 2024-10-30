Return-Path: <linux-kernel+bounces-388043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0EE9B59B5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 03:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0D41F230D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 02:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163CC5914C;
	Wed, 30 Oct 2024 02:01:35 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BD833CFC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 02:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730253694; cv=none; b=vFRE8u2uYtjFOXKCNE3ntxgHOlzZ+IGyWPnOcJAunmqbefJQaGJv347gH8j3jzx3hgYb1IPmOlYvVomiG4NATE0AFLz99AmFO0P4i60sWDPado1KUIyjUfFqhWpqku54/0jzaFUg4n9Ol+qiGCxuxgWQo1pi7xDiVeQQU5U7obI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730253694; c=relaxed/simple;
	bh=aCpz4UlzW/ElG551a/NoFOk7ru0S7h81BJ0tx8nrhF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sQKGBOZJ0WDz4hT9aCvmTUf34HdxrJlkIeuVbq/OBe6IS/9kGNHYOzvxahK8IHO4vvmTGJcitICKbyCljCGFJGDHEEJZ/PMQr1Xa3ebplFntrrHKQ7EZUC/CzUDiXGDBxpgEfT/DdRVQQxyXL2uySW6rEaSnlQG93ogVBp4gWYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XdVgd1nzKz1jw8D;
	Wed, 30 Oct 2024 09:59:57 +0800 (CST)
Received: from kwepemg200008.china.huawei.com (unknown [7.202.181.35])
	by mail.maildlp.com (Postfix) with ESMTPS id B14381A0188;
	Wed, 30 Oct 2024 10:01:28 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemg200008.china.huawei.com (7.202.181.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 30 Oct 2024 10:01:27 +0800
Message-ID: <560d2026-5785-b6b1-eb7d-3afed714d47f@huawei.com>
Date: Wed, 30 Oct 2024 10:01:27 +0800
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
To: <christian.koenig@amd.com>, <ray.huang@amd.com>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<karolina.stolarek@intel.com>, <Arunpravin.PaneerSelvam@amd.com>,
	<thomas.hellstrom@linux.intel.com>, <asomalap@amd.com>,
	<quic_jjohnson@quicinc.com>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>
References: <20241026020758.3846669-1-ruanjinjie@huawei.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <20241026020758.3846669-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemg200008.china.huawei.com (7.202.181.35)

Gentle ping.

On 2024/10/26 10:07, Jinjie Ruan wrote:
> modprobe ttm_device_test and then rmmod ttm_device_test, the following
> memory leaks occurs:
> 
> The ttm->pages allocated in ttm_tt_init() is not freed after calling
> ttm_tt_simple_create(), which cause the memory leak:
> 
> 	unreferenced object 0xffffff80caf27750 (size 8):
> 	  comm "kunit_try_catch", pid 2242, jiffies 4295055735
> 	  hex dump (first 8 bytes):
> 	    c0 1e 3d c3 fe ff ff ff                          ..=.....
> 	  backtrace (crc 3d11615a):
> 	    [<000000007f57312a>] kmemleak_alloc+0x34/0x40
> 	    [<000000008c6c4c7e>] __kmalloc_node_noprof+0x304/0x3e4
> 	    [<00000000679c1182>] __kvmalloc_node_noprof+0x1c/0x144
> 	    [<000000006aed0a3d>] ttm_tt_init+0x138/0x28c [ttm]
> 	    [<000000005c331998>] drm_gem_shmem_free+0x60/0x534 [drm_shmem_helper]
> 	    [<0000000022b4f375>] kunit_try_run_case+0x13c/0x3ac
> 	    [<00000000c525d725>] kunit_generic_run_threadfn_adapter+0x80/0xec
> 	    [<000000002db94a1f>] kthread+0x2e8/0x374
> 	    [<000000002c457ad7>] ret_from_fork+0x10/0x20
> 	......
> 
> Fix it by calling ttm_tt_fini() in the exit function.
> 
> Cc: stable@vger.kernel.org
> Fixes: e6f7c641fae3 ("drm/ttm/tests: Add tests for ttm_tt")
> Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
> v4:
> - Split out to be alone.
> v3:
> - s/fllowing/following/
> v2:
> - Add Reviewed-by.
> ---
>  drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c b/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
> index b91c13f46225..9ff216ec58ef 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_kunit_helpers.c
> @@ -54,6 +54,7 @@ static struct ttm_tt *ttm_tt_simple_create(struct ttm_buffer_object *bo, u32 pag
>  
>  static void ttm_tt_simple_destroy(struct ttm_device *bdev, struct ttm_tt *ttm)
>  {
> +	ttm_tt_fini(ttm);
>  	kfree(ttm);
>  }
>  

