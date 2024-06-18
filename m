Return-Path: <linux-kernel+bounces-219430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4250590D14D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1801F25311
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C3519F48D;
	Tue, 18 Jun 2024 13:08:18 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC5315886D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716098; cv=none; b=BFMhSorsFLWRlsSqvLTjx3V/mLcdXGUVAw43l4Um75hu8Lz+gsEivcljQA662zvfRV604Jaxz68Cxi8WNnNqlsT9p1jgtiTXR4Ski2i3TIR7/PrEwnXXmEsI7rEu/AVqBrqyFYfvrpZY9g5Je29xCaMxGAdVvuJEkIMBRevWo44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716098; c=relaxed/simple;
	bh=mn5FtPRbZyXMPbcviqTthDkzoaS/7AUzAtrMRoqletw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RXk/cUUMpRyRrOvSqUshOVqPWQIj1BDgMgIBz0TUWmp8mz5NNZhkCy2FJs0IamUkxTBbiJ9X8AwIzN4YKhZXczot1QVaHZbPwFuRByrdxBzqKvn9Zn0aQuyGMBhvfJwrFeSVRRr3XmXQWRR7SiRVTYNyoUdJNB1aKx4A2xgmVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4W3Rlx72W2z2Ck8m;
	Tue, 18 Jun 2024 21:04:13 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (unknown [7.185.36.114])
	by mail.maildlp.com (Postfix) with ESMTPS id 022921A016C;
	Tue, 18 Jun 2024 21:08:07 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Jun 2024 21:08:06 +0800
Message-ID: <4ee074b9-72c4-f2b8-42e1-57a895d57462@huawei.com>
Date: Tue, 18 Jun 2024 21:08:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v3 -next 3/3] mm/hugetlb_cgroup: switch to the new cftypes
Content-Language: en-US
To: Marek Szyprowski <m.szyprowski@samsung.com>, <akpm@linux-foundation.org>,
	<muchun.song@linux.dev>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <osalvador@suse.de>
References: <20240612092409.2027592-1-xiujianfeng@huawei.com>
 <20240612092409.2027592-4-xiujianfeng@huawei.com>
 <CGME20240618125536eucas1p1c62068f858a59d23fca29bf98efb9323@eucas1p1.samsung.com>
 <602186b3-5ce3-41b3-90a3-134792cc2a48@samsung.com>
From: xiujianfeng <xiujianfeng@huawei.com>
In-Reply-To: <602186b3-5ce3-41b3-90a3-134792cc2a48@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)

Hi,

On 2024/6/18 20:55, Marek Szyprowski wrote:
> Dear All,
> 
> On 12.06.2024 11:24, Xiu Jianfeng wrote:
>> The previous patch has already reconstructed the cftype attributes
>> based on the templates and saved them in dfl_cftypes and legacy_cftypes.
>> then remove the old procedure and switch to the new cftypes.
>>
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> 
> This patch landed in yesterday's linux-next (next-20240617) as commit 
> 11308a02a56cc ("mm/hugetlb_cgroup: switch to the new cftypes"). In my 
> daily tests I found that it triggers the following lock dependency 
> checker warning on most of my ARM64 test machines:
> 
> BUG: key ffff000005c080d8 has not been registered!
> ------------[ cut here ]------------
> DEBUG_LOCKS_WARN_ON(1)
> WARNING: CPU: 1 PID: 1080 at kernel/locking/lockdep.c:4895 
> lockdep_init_map_type+0x1cc/0x284
> Modules linked in: ipv6
> CPU: 1 PID: 1080 Comm: cgmanager Not tainted 6.10.0-rc3+ #1011
> Hardware name: linux,dummy-virt (DT)
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : lockdep_init_map_type+0x1cc/0x284
> lr : lockdep_init_map_type+0x1cc/0x284
> ...
> Call trace:
>   lockdep_init_map_type+0x1cc/0x284
>   __kernfs_create_file+0x7c/0x138
>   cgroup_addrm_files+0x170/0x360
>   css_populate_dir+0x70/0x174
>   cgroup_apply_control_enable+0x128/0x378
>   rebind_subsystems+0x384/0x504
>   cgroup_setup_root+0x224/0x420
>   cgroup1_get_tree+0x248/0x36c
>   vfs_get_tree+0x28/0xe8
>   path_mount+0x3e8/0xb78
>   __arm64_sys_mount+0x1f0/0x2dc
>   invoke_syscall+0x48/0x118
>   el0_svc_common.constprop.0+0x40/0xe8
>   do_el0_svc_compat+0x20/0x3c
>   el0_svc_compat+0x44/0xe0
>   el0t_32_sync_handler+0x98/0x148
>   el0t_32_sync+0x194/0x198
> irq event stamp: 8225
> hardirqs last  enabled at (8225): [<ffff800080136134>] 
> console_unlock+0x164/0x190
> hardirqs last disabled at (8224): [<ffff800080136120>] 
> console_unlock+0x150/0x190
> softirqs last  enabled at (8214): [<ffff8000800ae1f4>] 
> handle_softirqs+0x4dc/0x4f4
> softirqs last disabled at (8207): [<ffff8000800105d4>] 
> __do_softirq+0x14/0x20
> ---[ end trace 0000000000000000 ]---
> 
> It looks that something is not properly intialized. Reverting $subject 
> on top of linux-next fixes this issue.

Yes, the root cause is that the cft->lockdep_key has not been registered
proactively when the CONFIG_DEBUG_LOCK_ALLOC is enabled.

Would you please try the following patch?

https://lore.kernel.org/all/20240618071922.2127289-1-xiujianfeng@huawei.com/

> 
> I've used defconfig with some debug options enabled and some drivers 
> compiled-in (if this matters):
> 
> make ARCH=arm64 defconfig
> 
> ./scripts/config -e BLK_DEV_RAM --set-val BLK_DEV_RAM_COUNT 4 --set-val 
> BLK_DEV_RAM_SIZE 81920 --set-val CMA_SIZE_MBYTES 96 -e PROVE_LOCKING -e 
> DEBUG_ATOMIC_SLEEP -e STAGING -e I2C_GPIO -e PM_DEBUG -e 
> PM_ADVANCED_DEBUG -e USB_GADGET -e USB_ETH -e CONFIG_DEVFREQ_THERMAL -e 
> CONFIG_BRCMFMAC_PCIE -e CONFIG_NFC -d ARCH_SUNXI -d ARCH_ALPINE -d 
> DRM_NOUVEAU -d ARCH_BCM_IPROC -d ARCH_BERLIN -d ARCH_BRCMSTB -d 
> ARCH_LAYERSCAPE -d ARCH_LG1K -d ARCH_HISI -d ARCH_MEDIATEK -d ARCH_MVEBU 
> -d ARCH_SEATTLE -d ARCH_SYNQUACER -d ARCH_RENESAS -d ARCH_STRATIX10 -d 
> ARCH_TEGRA -d ARCH_SPRD -d ARCH_THUNDER -d ARCH_THUNDER2 -d 
> ARCH_UNIPHIER -d ARCH_XGENE -d ARCH_ZX -d ARCH_ZYNQMP -d HIBERNATION -d 
> CLK_SUNXI -d CONFIG_EFI -d CONFIG_TEE -e FW_CFG_SYSFS
> 
> 
>> ---
>>   include/linux/hugetlb.h |   5 --
>>   mm/hugetlb_cgroup.c     | 163 +++++-----------------------------------
>>   2 files changed, 17 insertions(+), 151 deletions(-)
>>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 279aca379b95..a951c0d06061 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -686,11 +686,6 @@ struct hstate {
>>   	unsigned int nr_huge_pages_node[MAX_NUMNODES];
>>   	unsigned int free_huge_pages_node[MAX_NUMNODES];
>>   	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
>> -#ifdef CONFIG_CGROUP_HUGETLB
>> -	/* cgroup control files */
>> -	struct cftype cgroup_files_dfl[8];
>> -	struct cftype cgroup_files_legacy[10];
>> -#endif
>>   	char name[HSTATE_NAME_LEN];
>>   };
>>   
>> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
>> index 43aae8f88d5f..2b899c4ae968 100644
>> --- a/mm/hugetlb_cgroup.c
>> +++ b/mm/hugetlb_cgroup.c
>> @@ -839,164 +839,26 @@ hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
>>   	}
>>   }
>>   
>> -static void __init __hugetlb_cgroup_file_dfl_init(int idx)
>> +static void __init __hugetlb_cgroup_file_dfl_init(struct hstate *h)
>>   {
>> -	char buf[32];
>> -	struct cftype *cft;
>> -	struct hstate *h = &hstates[idx];
>> +	int idx = hstate_index(h);
>>   
>>   	hugetlb_cgroup_cfttypes_init(h, dfl_files + idx * DFL_TMPL_SIZE,
>>   				     hugetlb_dfl_tmpl, DFL_TMPL_SIZE);
>> -
>> -	/* format the size */
>> -	mem_fmt(buf, sizeof(buf), huge_page_size(h));
>> -
>> -	/* Add the limit file */
>> -	cft = &h->cgroup_files_dfl[0];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, RES_LIMIT);
>> -	cft->seq_show = hugetlb_cgroup_read_u64_max;
>> -	cft->write = hugetlb_cgroup_write_dfl;
>> -	cft->flags = CFTYPE_NOT_ON_ROOT;
>> -
>> -	/* Add the reservation limit file */
>> -	cft = &h->cgroup_files_dfl[1];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.max", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_LIMIT);
>> -	cft->seq_show = hugetlb_cgroup_read_u64_max;
>> -	cft->write = hugetlb_cgroup_write_dfl;
>> -	cft->flags = CFTYPE_NOT_ON_ROOT;
>> -
>> -	/* Add the current usage file */
>> -	cft = &h->cgroup_files_dfl[2];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.current", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, RES_USAGE);
>> -	cft->seq_show = hugetlb_cgroup_read_u64_max;
>> -	cft->flags = CFTYPE_NOT_ON_ROOT;
>> -
>> -	/* Add the current reservation usage file */
>> -	cft = &h->cgroup_files_dfl[3];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.current", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_USAGE);
>> -	cft->seq_show = hugetlb_cgroup_read_u64_max;
>> -	cft->flags = CFTYPE_NOT_ON_ROOT;
>> -
>> -	/* Add the events file */
>> -	cft = &h->cgroup_files_dfl[4];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, 0);
>> -	cft->seq_show = hugetlb_events_show;
>> -	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]);
>> -	cft->flags = CFTYPE_NOT_ON_ROOT;
>> -
>> -	/* Add the events.local file */
>> -	cft = &h->cgroup_files_dfl[5];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events.local", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, 0);
>> -	cft->seq_show = hugetlb_events_local_show;
>> -	cft->file_offset = offsetof(struct hugetlb_cgroup,
>> -				    events_local_file[idx]);
>> -	cft->flags = CFTYPE_NOT_ON_ROOT;
>> -
>> -	/* Add the numa stat file */
>> -	cft = &h->cgroup_files_dfl[6];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, 0);
>> -	cft->seq_show = hugetlb_cgroup_read_numa_stat;
>> -	cft->flags = CFTYPE_NOT_ON_ROOT;
>> -
>> -	/* NULL terminate the last cft */
>> -	cft = &h->cgroup_files_dfl[7];
>> -	memset(cft, 0, sizeof(*cft));
>> -
>> -	WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
>> -				       h->cgroup_files_dfl));
>>   }
>>   
>> -static void __init __hugetlb_cgroup_file_legacy_init(int idx)
>> +static void __init __hugetlb_cgroup_file_legacy_init(struct hstate *h)
>>   {
>> -	char buf[32];
>> -	struct cftype *cft;
>> -	struct hstate *h = &hstates[idx];
>> +	int idx = hstate_index(h);
>>   
>>   	hugetlb_cgroup_cfttypes_init(h, legacy_files + idx * LEGACY_TMPL_SIZE,
>>   				     hugetlb_legacy_tmpl, LEGACY_TMPL_SIZE);
>> -
>> -	/* format the size */
>> -	mem_fmt(buf, sizeof(buf), huge_page_size(h));
>> -
>> -	/* Add the limit file */
>> -	cft = &h->cgroup_files_legacy[0];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.limit_in_bytes", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, RES_LIMIT);
>> -	cft->read_u64 = hugetlb_cgroup_read_u64;
>> -	cft->write = hugetlb_cgroup_write_legacy;
>> -
>> -	/* Add the reservation limit file */
>> -	cft = &h->cgroup_files_legacy[1];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.limit_in_bytes", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_LIMIT);
>> -	cft->read_u64 = hugetlb_cgroup_read_u64;
>> -	cft->write = hugetlb_cgroup_write_legacy;
>> -
>> -	/* Add the usage file */
>> -	cft = &h->cgroup_files_legacy[2];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.usage_in_bytes", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, RES_USAGE);
>> -	cft->read_u64 = hugetlb_cgroup_read_u64;
>> -
>> -	/* Add the reservation usage file */
>> -	cft = &h->cgroup_files_legacy[3];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.usage_in_bytes", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_USAGE);
>> -	cft->read_u64 = hugetlb_cgroup_read_u64;
>> -
>> -	/* Add the MAX usage file */
>> -	cft = &h->cgroup_files_legacy[4];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max_usage_in_bytes", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, RES_MAX_USAGE);
>> -	cft->write = hugetlb_cgroup_reset;
>> -	cft->read_u64 = hugetlb_cgroup_read_u64;
>> -
>> -	/* Add the MAX reservation usage file */
>> -	cft = &h->cgroup_files_legacy[5];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.max_usage_in_bytes", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_MAX_USAGE);
>> -	cft->write = hugetlb_cgroup_reset;
>> -	cft->read_u64 = hugetlb_cgroup_read_u64;
>> -
>> -	/* Add the failcntfile */
>> -	cft = &h->cgroup_files_legacy[6];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.failcnt", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, RES_FAILCNT);
>> -	cft->write = hugetlb_cgroup_reset;
>> -	cft->read_u64 = hugetlb_cgroup_read_u64;
>> -
>> -	/* Add the reservation failcntfile */
>> -	cft = &h->cgroup_files_legacy[7];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.failcnt", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_FAILCNT);
>> -	cft->write = hugetlb_cgroup_reset;
>> -	cft->read_u64 = hugetlb_cgroup_read_u64;
>> -
>> -	/* Add the numa stat file */
>> -	cft = &h->cgroup_files_legacy[8];
>> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
>> -	cft->private = MEMFILE_PRIVATE(idx, 0);
>> -	cft->seq_show = hugetlb_cgroup_read_numa_stat;
>> -
>> -	/* NULL terminate the last cft */
>> -	cft = &h->cgroup_files_legacy[9];
>> -	memset(cft, 0, sizeof(*cft));
>> -
>> -	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
>> -					  h->cgroup_files_legacy));
>>   }
>>   
>> -static void __init __hugetlb_cgroup_file_init(int idx)
>> +static void __init __hugetlb_cgroup_file_init(struct hstate *h)
>>   {
>> -	__hugetlb_cgroup_file_dfl_init(idx);
>> -	__hugetlb_cgroup_file_legacy_init(idx);
>> +	__hugetlb_cgroup_file_dfl_init(h);
>> +	__hugetlb_cgroup_file_legacy_init(h);
>>   }
>>   
>>   static void __init __hugetlb_cgroup_file_pre_init(void)
>> @@ -1011,13 +873,22 @@ static void __init __hugetlb_cgroup_file_pre_init(void)
>>   	BUG_ON(!legacy_files);
>>   }
>>   
>> +static void __init __hugetlb_cgroup_file_post_init(void)
>> +{
>> +	WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
>> +				       dfl_files));
>> +	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
>> +					  legacy_files));
>> +}
>> +
>>   void __init hugetlb_cgroup_file_init(void)
>>   {
>>   	struct hstate *h;
>>   
>>   	__hugetlb_cgroup_file_pre_init();
>>   	for_each_hstate(h)
>> -		__hugetlb_cgroup_file_init(hstate_index(h));
>> +		__hugetlb_cgroup_file_init(h);
>> +	__hugetlb_cgroup_file_post_init();
>>   }
>>   
>>   /*
> 
> Best regards

