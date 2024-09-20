Return-Path: <linux-kernel+bounces-334006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E46997D14F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CB9BB22895
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 06:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEC44207A;
	Fri, 20 Sep 2024 06:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HcStvstT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E204F218
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 06:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726814631; cv=none; b=pNso2E7eTNwrC1/9zty4VQFSQ348PtIGoKlfRhopGNibS3JxZSpOevtyEU/Q2kCs2oi6FNfl1cQoElfFANiUTQCvmHUA45tIcsxBUushz+eeaImo+T+JgFuay1JiHKyCvXhHyc0x9J/nesUp76FLnMzE6qdCliFoIPtkECawE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726814631; c=relaxed/simple;
	bh=zoI6NONXQfVCXrNTyLb9AAnapkPi2ON7EwAQf+U9Nus=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O+zOGSEwcOrRuqg1h5429N2Jvw6uCFjA9AiFemiUiPvK5UyHZW2c7xjFpO1CmPmuN+PV4Rm6V4/w6EhNoiManO5r6KpXPN5r9tyxwv8E6/H49BNdHhpVRv5u7yeWFRQaOgMq+m5r9wL1UxGn/vcvnnuSBFGEpAHWeEHSp7h0wPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HcStvstT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726814629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6lIQhi9dLmsll2G2cHgSkPLAoZ5Wd5248GHYInTXW7U=;
	b=HcStvstTp3fs9Pf8uwLNTjFwzVMAnhKQ+NY55/WZVg6bCqvSSYO3CYn2WQ5Ps9Jhgd5BPe
	aaJplmI4hiRd/LlRkVxxX6rgqubMVsGBgSCm32s7eIdv/KSHZ+VXQJ+F8Jbpl/vU2MXV15
	7Dg95VLJPYnxCMqQewkBz9Wkv8I2vbk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-NXtqnH66MXietrhV2vWcwQ-1; Fri,
 20 Sep 2024 02:43:45 -0400
X-MC-Unique: NXtqnH66MXietrhV2vWcwQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EE271944CE7;
	Fri, 20 Sep 2024 06:43:44 +0000 (UTC)
Received: from [10.45.224.224] (unknown [10.45.224.224])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 791A219560AA;
	Fri, 20 Sep 2024 06:43:42 +0000 (UTC)
Message-ID: <7db244ee-91ba-4d45-8c54-dc98a75d8501@redhat.com>
Date: Fri, 20 Sep 2024 02:43:41 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory tier: Remove unused default_dram_perf_ref_source
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Alistair Popple <apopple@nvidia.com>, Dave Jiang <dave.jiang@intel.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240919191357.49976-1-longman@redhat.com>
 <87y13mvo0n.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <87y13mvo0n.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 9/20/24 02:26, Huang, Ying wrote:
> Hi, Waiman,
>
> Waiman Long <longman@redhat.com> writes:
>
>> Commit 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")
>> added a default_dram_perf_ref_source variable that was initialized but
>> never used. This causes kmemleak to report the following memory leak:
>>
>> unreferenced object 0xff11000225a47b60 (size 16):
>>    comm "swapper/0", pid 1, jiffies 4294761654
>>    hex dump (first 16 bytes):
>>      41 43 50 49 20 48 4d 41 54 00 c1 4b 7d b7 75 7c  ACPI HMAT..K}.u|
>>    backtrace (crc e6d0e7b2):
>>      [<ffffffff95d5afdb>] __kmalloc_node_track_caller_noprof+0x36b/0x440
>>      [<ffffffff95c276d6>] kstrdup+0x36/0x60
>>      [<ffffffff95dfabfa>] mt_set_default_dram_perf+0x23a/0x2c0
>>      [<ffffffff9ad64733>] hmat_init+0x2b3/0x660
>>      [<ffffffff95203cec>] do_one_initcall+0x11c/0x5c0
>>      [<ffffffff9ac9cfc4>] do_initcalls+0x1b4/0x1f0
>>      [<ffffffff9ac9d52e>] kernel_init_freeable+0x4ae/0x520
>>      [<ffffffff97c789cc>] kernel_init+0x1c/0x150
>>      [<ffffffff952aecd1>] ret_from_fork+0x31/0x70
>>      [<ffffffff9520b18a>] ret_from_fork_asm+0x1a/0x30
> Good catch!
>
>> Fix this memory leak by removing default_dram_perf_ref_source.
> We should have used that information.  So, I suggest the fix as below.
> Is it OK for you?
>
> ---------------------------8<---------------------------------------
>  From 32e6d70f531718cf99064a43fdffc8639aedcc5c Mon Sep 17 00:00:00 2001
> From: Huang Ying <ying.huang@intel.com>
> Date: Fri, 20 Sep 2024 09:47:40 +0800
> Subject: [PATCH] memory tiers: use default_dram_perf_ref_source in log message
>
> Commit 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")
> added a default_dram_perf_ref_source variable that was initialized but
> never used. This causes kmemleak to report the following memory leak:
>
> unreferenced object 0xff11000225a47b60 (size 16):
>    comm "swapper/0", pid 1, jiffies 4294761654
>    hex dump (first 16 bytes):
>      41 43 50 49 20 48 4d 41 54 00 c1 4b 7d b7 75 7c  ACPI HMAT..K}.u|
>    backtrace (crc e6d0e7b2):
>      [<ffffffff95d5afdb>] __kmalloc_node_track_caller_noprof+0x36b/0x440
>      [<ffffffff95c276d6>] kstrdup+0x36/0x60
>      [<ffffffff95dfabfa>] mt_set_default_dram_perf+0x23a/0x2c0
>      [<ffffffff9ad64733>] hmat_init+0x2b3/0x660
>      [<ffffffff95203cec>] do_one_initcall+0x11c/0x5c0
>      [<ffffffff9ac9cfc4>] do_initcalls+0x1b4/0x1f0
>      [<ffffffff9ac9d52e>] kernel_init_freeable+0x4ae/0x520
>      [<ffffffff97c789cc>] kernel_init+0x1c/0x150
>      [<ffffffff952aecd1>] ret_from_fork+0x31/0x70
>      [<ffffffff9520b18a>] ret_from_fork_asm+0x1a/0x30
>
> This reminds us that we forget to use the performance data source
> information.  So, use the variable in the error log message to help
> identify the root cause of inconsistent performance number.
>
> Fixes: 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Reported-by: Waiman Long <longman@redhat.com>
> ---
>   mm/memory-tiers.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 4775b3a3dabe..0f5ba5c6e0c6 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -749,10 +749,10 @@ int mt_set_default_dram_perf(int nid, struct access_coordinate *perf,
>   		pr_info(
>   "memory-tiers: the performance of DRAM node %d mismatches that of the reference\n"
>   "DRAM node %d.\n", nid, default_dram_perf_ref_nid);
> -		pr_info("  performance of reference DRAM node %d:\n",
> -			default_dram_perf_ref_nid);
> +		pr_info("  performance of reference DRAM node %d from %s:\n",
> +			default_dram_perf_ref_nid, default_dram_perf_ref_source);
>   		dump_hmem_attrs(&default_dram_perf, "    ");
> -		pr_info("  performance of DRAM node %d:\n", nid);
> +		pr_info("  performance of DRAM node %d from %s:\n", nid, source);
>   		dump_hmem_attrs(perf, "    ");
>   		pr_info(
>   "  disable default DRAM node performance based abstract distance algorithm.\n");

That looks good for me. As I am not sure how this variable should be 
used, I just removed it in my patch.

Acked-by: Waiman Long <longman@redhat.com>


