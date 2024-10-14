Return-Path: <linux-kernel+bounces-363666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4618599C568
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7725F1C22BFC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEB515C122;
	Mon, 14 Oct 2024 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzA7OxAy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41D14B08E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728897449; cv=none; b=m2h2jmYr07UcAi4VXFF+hfuWSv4tYvVNOc+pTABoBDdBIPwXmqgea9SqJ+akMbRMhhLfxkbzL2TagCkx7nX7rpoi0Zr2c+pnwdgXATKgbm/Ubx0Fn7sKV0hhVQ/CJ8UOP/gdMXm6UMmcvWtFAAaIINYhYbUXd82w6z2U+bOQa6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728897449; c=relaxed/simple;
	bh=u6TaFVZONqi9zP1yGL5nvvE5e03tHzhpbIR4tHpq/k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UVJTKz0rRHqb7ihyoJgUv1L/lmAJ5yTFAhIQRY249emZ4fmP1AibdNuECkOzaO72LYmXtshwrTQZOVwXLRDpze7Ym86PYA8L2Mpj1JBQcOR7U7JCFD+zpeDog96Y9TlqKFzx7+rk2/7yf6o/TirL6mNQXbP1IrrDOJBMbs6k08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzA7OxAy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728897449; x=1760433449;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=u6TaFVZONqi9zP1yGL5nvvE5e03tHzhpbIR4tHpq/k8=;
  b=KzA7OxAy/tq3l4N4lZHmGG0rmuzIkb1cVJq67PvHarUaFNhoTWZzbL4S
   a4unPa/E1vB/oo4B1TWNZJ1EzsPeeIDKGEvSqMN2u5iYWPwlDq/9lr3Dk
   gQNqC17WwOTgXM4UyxPqogy2+UNbxuSVRUjtJ5n3EDUxeLbutZ2ysjFoR
   xwUsLM3XJfTSVXS5ejfZdNitdbM78JKtaA0a4TzPcew/VYlbuPgsHRI3g
   mivD0I7mGrZnKcFciQSkqksPVMquXmcDlkjOX9JaZwcdIIEB2vtUjSbaW
   fsToJIavMCPKtistDGrh1P+aKcJWc3NmNzoHHOYrP9yZamZ+htxV8Ds6a
   g==;
X-CSE-ConnectionGUID: oNVImLLRRFy2XHWJEkTd8w==
X-CSE-MsgGUID: SmNo05OiTHyF9HH1bIrBiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11224"; a="53657005"
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="53657005"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 02:17:28 -0700
X-CSE-ConnectionGUID: JRiJQlePRXOh5zXqsUbWhg==
X-CSE-MsgGUID: obGBvDAPSdmfwoP+isWSkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="77446041"
Received: from nirmoyda-mobl.ger.corp.intel.com (HELO [10.245.177.190]) ([10.245.177.190])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 02:17:22 -0700
Message-ID: <b545ed9c-787e-4840-b91f-3544bda0f2f0@linux.intel.com>
Date: Mon, 14 Oct 2024 11:17:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/ttm/tests: Fix memory leak in
 ttm_tt_simple_create()
To: Jinjie Ruan <ruanjinjie@huawei.com>, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 christian.koenig@amd.com, ray.huang@amd.com, dmitry.baryshkov@linaro.org,
 dave.stevenson@raspberrypi.com, mcanal@igalia.com,
 quic_jjohnson@quicinc.com, karolina.stolarek@intel.com,
 Arunpravin.PaneerSelvam@amd.com, thomas.hellstrom@linux.intel.com,
 asomalap@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20241014071632.989108-1-ruanjinjie@huawei.com>
 <20241014071632.989108-3-ruanjinjie@huawei.com>
Content-Language: en-US
From: Nirmoy Das <nirmoy.das@linux.intel.com>
In-Reply-To: <20241014071632.989108-3-ruanjinjie@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 10/14/2024 9:16 AM, Jinjie Ruan wrote:
> modprobe ttm_device_test and then rmmod ttm_device_test, the fllowing
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
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
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

