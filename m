Return-Path: <linux-kernel+bounces-219415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 615C190D03B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67361F213A9
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858F616D9C2;
	Tue, 18 Jun 2024 12:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vLiWQFSi"
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE3E16CD33
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718715348; cv=none; b=Ta4Gw+lXGyMKaixlydqI2RS189OY2DcjAezbelAsaILMgV4Tav9KtuNhpINnjVFEnaKWOkibgssVPFXXR1PK+vfJ56K4G1fD1vqMUYqIWHi7TaM8pCQXhPlUF5rUTmg++ISUAs+pvf8gIkSqSCipyZ/wZ6rhQ2xaFmWFH7/t5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718715348; c=relaxed/simple;
	bh=yMVEfzoXOCpAyLju3EoCcLdUb1ktc36jqCsyLwSXbu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=bqeNbM5Vu2JQTVt7t6AlwIiEi1wUjGc+5M6bV/9SFN+ZTAExARz/pdtG3mL7nlYkOB4ujwSB21ZfB1GKTVpzMG2OLfV5/AlUHw8kA62jlodwVRjFHco2M0XhWNa7XvHjl+CPJi6PeoDjSl0E6czsk/eEbx6JNoFlqwOR6FKgNeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vLiWQFSi; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20240618125537euoutp013a8f1a1db9730d2bb7d775f0a4dd177a~aGn4vniOe0294602946euoutp01w
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:55:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20240618125537euoutp013a8f1a1db9730d2bb7d775f0a4dd177a~aGn4vniOe0294602946euoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1718715337;
	bh=RJ/uY03go8jO2TLMM2WkjWIetxt/XXqFix9/JSmlnk0=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=vLiWQFSiSAcH8i+xIYUmRzckzAIQT5lobTPkbWJDRcmlWlEjFflzM3UyHQ7SvBiu1
	 YHHDtzNtqFJExtskllTQiixrONUwgQJTaDJFKd5UklpNVnQBGU9CmdaN8qjt/sLLqE
	 yJMpgxMlzqhxGIaTyxyjzs7tcIJWIJR6a/UOmc7E=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240618125536eucas1p210eb1c096caeb8c52d53aa4f1178c56e~aGn4nhqOG2727127271eucas1p20;
	Tue, 18 Jun 2024 12:55:36 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 69.FA.09620.8C381766; Tue, 18
	Jun 2024 13:55:36 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20240618125536eucas1p1c62068f858a59d23fca29bf98efb9323~aGn4PtK1b1401514015eucas1p1P;
	Tue, 18 Jun 2024 12:55:36 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240618125536eusmtrp20213627ea12c29f1316d8c849de4d25b~aGn4PEXAr1286412864eusmtrp2X;
	Tue, 18 Jun 2024 12:55:36 +0000 (GMT)
X-AuditID: cbfec7f5-d1bff70000002594-e3-667183c8a9ec
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id CA.4E.08810.8C381766; Tue, 18
	Jun 2024 13:55:36 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240618125536eusmtip2bdb65a9018405db44d47ad2ca63af558~aGn32L2ld2400724007eusmtip25;
	Tue, 18 Jun 2024 12:55:36 +0000 (GMT)
Message-ID: <602186b3-5ce3-41b3-90a3-134792cc2a48@samsung.com>
Date: Tue, 18 Jun 2024 14:55:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 -next 3/3] mm/hugetlb_cgroup: switch to the new
 cftypes
To: Xiu Jianfeng <xiujianfeng@huawei.com>, akpm@linux-foundation.org,
	muchun.song@linux.dev
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, osalvador@suse.de
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240612092409.2027592-4-xiujianfeng@huawei.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djPc7onmgvTDNr3GFnMWb+GzeLyrjls
	FvfW/Ge1WLbzIYvFmWlFFttn7WB0YPNoOfKW1WPTp0nsHidm/GbxWNgwldlj8+lqj8+b5ALY
	orhsUlJzMstSi/TtErgyHrVeZCzoiqy4f+8sUwPjfq8uRk4OCQETiavz3zN2MXJxCAmsYJTY
	eOcLC0hCSOALo8S+Tl+IxGdGiUsPfrLCdOzbvIMdIrGcUWLJl5OMEB0fGSXevQCzeQXsJK4c
	PcMEYrMIqEq8mtULFReUODnzCdgGUQF5ifu3ZrCD2MICARK/Lx1j62Lk4BARiJVomcoDYjIL
	uEtM/pUDUsEsIC5x68l8sIlsAoYSXW+72EBsTqBNO5bcYoaokZdo3jqbGeQ0CYEbHBILru1g
	hrjZRWLvmoVsELawxKvjW9ghbBmJ/ztBhoI0tDNKLPh9H8qZwCjR8PwWI0SVtcSdc7/YIC7S
	lFi/Sx8i7Chxes0xFpCwhACfxI23ghBH8ElM2jadGSLMK9HRJgRRrSYx6/g6uLUHL1xinsCo
	NAspUGYheXMWkndmIexdwMiyilE8tbQ4Nz212DgvtVyvODG3uDQvXS85P3cTIzD1nP53/OsO
	xhWvPuodYmTiYDzEKMHBrCTC6zQtL02INyWxsiq1KD++qDQntfgQozQHi5I4r2qKfKqQQHpi
	SWp2ampBahFMlomDU6qBKSG6ySwnc0mZcEvvnRvlMivF7vUk9ZsYW+2zeXR7Vst16wfX5u2a
	bnTn6Dlm09tnpqfdvXGyOOv4f64J0dn/C32Ye27u6XnTuKWmgj+28Fjb68ubD9b19FQ1Vap7
	BE7e6drS1VTUYbhWq/h0j/N0o2J538r5e/jm3/36Z/1h49P1NUs3VE65f3L3QlfXK/YV/9Tc
	hE3PBp1Y9bicbVFm4J8nqc8qddo/tBnrP6xQich1ZXpubZCpKOsQLmRz5Lxj4VVfrp8HPBm+
	lZbatNxLWRo/d1vg0t/+Os2rpnxIVX+TnKe5LTH65Zldm86kNZ9K1Fz1f/UV0+OciRy19ULb
	e0qWPrI6u6X54/TdFRs8lViKMxINtZiLihMBPztnvqwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsVy+t/xe7onmgvTDC5skLaYs34Nm8XlXXPY
	LO6t+c9qsWznQxaLM9OKLLbP2sHowObRcuQtq8emT5PYPU7M+M3isbBhKrPH5tPVHp83yQWw
	RenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlPGq9
	yFjQFVlx/95ZpgbG/V5djJwcEgImEvs272DvYuTiEBJYyijxsGURK0RCRuLktAYoW1jiz7Uu
	Noii94wS3V9+M4IkeAXsJK4cPcMEYrMIqEq8mtULFReUODnzCQuILSogL3H/1gx2EFtYwE9i
	56IHYPUiArESM97uArI5OJgF3CUm/8oBCQsJFEoc3HcXrJVZQFzi1pP5YOVsAoYSXW9BbuDk
	4ARau2PJLWaIGjOJrq1djBC2vETz1tnMExiFZiG5YhaSUbOQtMxC0rKAkWUVo0hqaXFuem6x
	oV5xYm5xaV66XnJ+7iZGYLxtO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMLrNC0vTYg3JbGyKrUo
	P76oNCe1+BCjKTAoJjJLiSbnAyM+ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUg
	tQimj4mDU6qBia33V4jw3ZmqD26/tzNOTAhzMa4yOVPK6iKcKPH81qUcTrmrU940bmFtevde
	7exE47oGCbGj7wqEdyqa39eZ1yusbsyadeNowOlvbd71H0zeaMVErNeZ5f1Y+sKNqQrNdhmS
	eacTw5bym9+ZZpC+/lPzUjWJNx7MXlEcW9yZKzPuTmdncW1ePJX1gn3G3ScHcpZW5IjMXbNa
	oWkz85k4RaPlXBdck/NnvLm/fRHDxit2VWfOLhU96dynG8DaPUk0ZJdywQOFDY+WuXsaKuSL
	aqs4NfTumqWrUljIcEGFy+GT7i8fg6OvzqpHXvsTMm3yju/+ZXf6PnpEbw5/fOMWUwp/0jrn
	lk/TkmMPe1xSYinOSDTUYi4qTgQAK06MokADAAA=
X-CMS-MailID: 20240618125536eucas1p1c62068f858a59d23fca29bf98efb9323
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20240618125536eucas1p1c62068f858a59d23fca29bf98efb9323
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20240618125536eucas1p1c62068f858a59d23fca29bf98efb9323
References: <20240612092409.2027592-1-xiujianfeng@huawei.com>
	<20240612092409.2027592-4-xiujianfeng@huawei.com>
	<CGME20240618125536eucas1p1c62068f858a59d23fca29bf98efb9323@eucas1p1.samsung.com>

Dear All,

On 12.06.2024 11:24, Xiu Jianfeng wrote:
> The previous patch has already reconstructed the cftype attributes
> based on the templates and saved them in dfl_cftypes and legacy_cftypes.
> then remove the old procedure and switch to the new cftypes.
>
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

This patch landed in yesterday's linux-next (next-20240617) as commit 
11308a02a56cc ("mm/hugetlb_cgroup: switch to the new cftypes"). In my 
daily tests I found that it triggers the following lock dependency 
checker warning on most of my ARM64 test machines:

BUG: key ffff000005c080d8 has not been registered!
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: CPU: 1 PID: 1080 at kernel/locking/lockdep.c:4895 
lockdep_init_map_type+0x1cc/0x284
Modules linked in: ipv6
CPU: 1 PID: 1080 Comm: cgmanager Not tainted 6.10.0-rc3+ #1011
Hardware name: linux,dummy-virt (DT)
pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : lockdep_init_map_type+0x1cc/0x284
lr : lockdep_init_map_type+0x1cc/0x284
...
Call trace:
  lockdep_init_map_type+0x1cc/0x284
  __kernfs_create_file+0x7c/0x138
  cgroup_addrm_files+0x170/0x360
  css_populate_dir+0x70/0x174
  cgroup_apply_control_enable+0x128/0x378
  rebind_subsystems+0x384/0x504
  cgroup_setup_root+0x224/0x420
  cgroup1_get_tree+0x248/0x36c
  vfs_get_tree+0x28/0xe8
  path_mount+0x3e8/0xb78
  __arm64_sys_mount+0x1f0/0x2dc
  invoke_syscall+0x48/0x118
  el0_svc_common.constprop.0+0x40/0xe8
  do_el0_svc_compat+0x20/0x3c
  el0_svc_compat+0x44/0xe0
  el0t_32_sync_handler+0x98/0x148
  el0t_32_sync+0x194/0x198
irq event stamp: 8225
hardirqs last  enabled at (8225): [<ffff800080136134>] 
console_unlock+0x164/0x190
hardirqs last disabled at (8224): [<ffff800080136120>] 
console_unlock+0x150/0x190
softirqs last  enabled at (8214): [<ffff8000800ae1f4>] 
handle_softirqs+0x4dc/0x4f4
softirqs last disabled at (8207): [<ffff8000800105d4>] 
__do_softirq+0x14/0x20
---[ end trace 0000000000000000 ]---

It looks that something is not properly intialized. Reverting $subject 
on top of linux-next fixes this issue.

I've used defconfig with some debug options enabled and some drivers 
compiled-in (if this matters):

make ARCH=arm64 defconfig

./scripts/config -e BLK_DEV_RAM --set-val BLK_DEV_RAM_COUNT 4 --set-val 
BLK_DEV_RAM_SIZE 81920 --set-val CMA_SIZE_MBYTES 96 -e PROVE_LOCKING -e 
DEBUG_ATOMIC_SLEEP -e STAGING -e I2C_GPIO -e PM_DEBUG -e 
PM_ADVANCED_DEBUG -e USB_GADGET -e USB_ETH -e CONFIG_DEVFREQ_THERMAL -e 
CONFIG_BRCMFMAC_PCIE -e CONFIG_NFC -d ARCH_SUNXI -d ARCH_ALPINE -d 
DRM_NOUVEAU -d ARCH_BCM_IPROC -d ARCH_BERLIN -d ARCH_BRCMSTB -d 
ARCH_LAYERSCAPE -d ARCH_LG1K -d ARCH_HISI -d ARCH_MEDIATEK -d ARCH_MVEBU 
-d ARCH_SEATTLE -d ARCH_SYNQUACER -d ARCH_RENESAS -d ARCH_STRATIX10 -d 
ARCH_TEGRA -d ARCH_SPRD -d ARCH_THUNDER -d ARCH_THUNDER2 -d 
ARCH_UNIPHIER -d ARCH_XGENE -d ARCH_ZX -d ARCH_ZYNQMP -d HIBERNATION -d 
CLK_SUNXI -d CONFIG_EFI -d CONFIG_TEE -e FW_CFG_SYSFS


> ---
>   include/linux/hugetlb.h |   5 --
>   mm/hugetlb_cgroup.c     | 163 +++++-----------------------------------
>   2 files changed, 17 insertions(+), 151 deletions(-)
>
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 279aca379b95..a951c0d06061 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -686,11 +686,6 @@ struct hstate {
>   	unsigned int nr_huge_pages_node[MAX_NUMNODES];
>   	unsigned int free_huge_pages_node[MAX_NUMNODES];
>   	unsigned int surplus_huge_pages_node[MAX_NUMNODES];
> -#ifdef CONFIG_CGROUP_HUGETLB
> -	/* cgroup control files */
> -	struct cftype cgroup_files_dfl[8];
> -	struct cftype cgroup_files_legacy[10];
> -#endif
>   	char name[HSTATE_NAME_LEN];
>   };
>   
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index 43aae8f88d5f..2b899c4ae968 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -839,164 +839,26 @@ hugetlb_cgroup_cfttypes_init(struct hstate *h, struct cftype *cft,
>   	}
>   }
>   
> -static void __init __hugetlb_cgroup_file_dfl_init(int idx)
> +static void __init __hugetlb_cgroup_file_dfl_init(struct hstate *h)
>   {
> -	char buf[32];
> -	struct cftype *cft;
> -	struct hstate *h = &hstates[idx];
> +	int idx = hstate_index(h);
>   
>   	hugetlb_cgroup_cfttypes_init(h, dfl_files + idx * DFL_TMPL_SIZE,
>   				     hugetlb_dfl_tmpl, DFL_TMPL_SIZE);
> -
> -	/* format the size */
> -	mem_fmt(buf, sizeof(buf), huge_page_size(h));
> -
> -	/* Add the limit file */
> -	cft = &h->cgroup_files_dfl[0];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, RES_LIMIT);
> -	cft->seq_show = hugetlb_cgroup_read_u64_max;
> -	cft->write = hugetlb_cgroup_write_dfl;
> -	cft->flags = CFTYPE_NOT_ON_ROOT;
> -
> -	/* Add the reservation limit file */
> -	cft = &h->cgroup_files_dfl[1];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.max", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_LIMIT);
> -	cft->seq_show = hugetlb_cgroup_read_u64_max;
> -	cft->write = hugetlb_cgroup_write_dfl;
> -	cft->flags = CFTYPE_NOT_ON_ROOT;
> -
> -	/* Add the current usage file */
> -	cft = &h->cgroup_files_dfl[2];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.current", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, RES_USAGE);
> -	cft->seq_show = hugetlb_cgroup_read_u64_max;
> -	cft->flags = CFTYPE_NOT_ON_ROOT;
> -
> -	/* Add the current reservation usage file */
> -	cft = &h->cgroup_files_dfl[3];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.current", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_USAGE);
> -	cft->seq_show = hugetlb_cgroup_read_u64_max;
> -	cft->flags = CFTYPE_NOT_ON_ROOT;
> -
> -	/* Add the events file */
> -	cft = &h->cgroup_files_dfl[4];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, 0);
> -	cft->seq_show = hugetlb_events_show;
> -	cft->file_offset = offsetof(struct hugetlb_cgroup, events_file[idx]);
> -	cft->flags = CFTYPE_NOT_ON_ROOT;
> -
> -	/* Add the events.local file */
> -	cft = &h->cgroup_files_dfl[5];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.events.local", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, 0);
> -	cft->seq_show = hugetlb_events_local_show;
> -	cft->file_offset = offsetof(struct hugetlb_cgroup,
> -				    events_local_file[idx]);
> -	cft->flags = CFTYPE_NOT_ON_ROOT;
> -
> -	/* Add the numa stat file */
> -	cft = &h->cgroup_files_dfl[6];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, 0);
> -	cft->seq_show = hugetlb_cgroup_read_numa_stat;
> -	cft->flags = CFTYPE_NOT_ON_ROOT;
> -
> -	/* NULL terminate the last cft */
> -	cft = &h->cgroup_files_dfl[7];
> -	memset(cft, 0, sizeof(*cft));
> -
> -	WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
> -				       h->cgroup_files_dfl));
>   }
>   
> -static void __init __hugetlb_cgroup_file_legacy_init(int idx)
> +static void __init __hugetlb_cgroup_file_legacy_init(struct hstate *h)
>   {
> -	char buf[32];
> -	struct cftype *cft;
> -	struct hstate *h = &hstates[idx];
> +	int idx = hstate_index(h);
>   
>   	hugetlb_cgroup_cfttypes_init(h, legacy_files + idx * LEGACY_TMPL_SIZE,
>   				     hugetlb_legacy_tmpl, LEGACY_TMPL_SIZE);
> -
> -	/* format the size */
> -	mem_fmt(buf, sizeof(buf), huge_page_size(h));
> -
> -	/* Add the limit file */
> -	cft = &h->cgroup_files_legacy[0];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.limit_in_bytes", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, RES_LIMIT);
> -	cft->read_u64 = hugetlb_cgroup_read_u64;
> -	cft->write = hugetlb_cgroup_write_legacy;
> -
> -	/* Add the reservation limit file */
> -	cft = &h->cgroup_files_legacy[1];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.limit_in_bytes", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_LIMIT);
> -	cft->read_u64 = hugetlb_cgroup_read_u64;
> -	cft->write = hugetlb_cgroup_write_legacy;
> -
> -	/* Add the usage file */
> -	cft = &h->cgroup_files_legacy[2];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.usage_in_bytes", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, RES_USAGE);
> -	cft->read_u64 = hugetlb_cgroup_read_u64;
> -
> -	/* Add the reservation usage file */
> -	cft = &h->cgroup_files_legacy[3];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.usage_in_bytes", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_USAGE);
> -	cft->read_u64 = hugetlb_cgroup_read_u64;
> -
> -	/* Add the MAX usage file */
> -	cft = &h->cgroup_files_legacy[4];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.max_usage_in_bytes", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, RES_MAX_USAGE);
> -	cft->write = hugetlb_cgroup_reset;
> -	cft->read_u64 = hugetlb_cgroup_read_u64;
> -
> -	/* Add the MAX reservation usage file */
> -	cft = &h->cgroup_files_legacy[5];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.max_usage_in_bytes", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_MAX_USAGE);
> -	cft->write = hugetlb_cgroup_reset;
> -	cft->read_u64 = hugetlb_cgroup_read_u64;
> -
> -	/* Add the failcntfile */
> -	cft = &h->cgroup_files_legacy[6];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.failcnt", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, RES_FAILCNT);
> -	cft->write = hugetlb_cgroup_reset;
> -	cft->read_u64 = hugetlb_cgroup_read_u64;
> -
> -	/* Add the reservation failcntfile */
> -	cft = &h->cgroup_files_legacy[7];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.rsvd.failcnt", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, RES_RSVD_FAILCNT);
> -	cft->write = hugetlb_cgroup_reset;
> -	cft->read_u64 = hugetlb_cgroup_read_u64;
> -
> -	/* Add the numa stat file */
> -	cft = &h->cgroup_files_legacy[8];
> -	snprintf(cft->name, MAX_CFTYPE_NAME, "%s.numa_stat", buf);
> -	cft->private = MEMFILE_PRIVATE(idx, 0);
> -	cft->seq_show = hugetlb_cgroup_read_numa_stat;
> -
> -	/* NULL terminate the last cft */
> -	cft = &h->cgroup_files_legacy[9];
> -	memset(cft, 0, sizeof(*cft));
> -
> -	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
> -					  h->cgroup_files_legacy));
>   }
>   
> -static void __init __hugetlb_cgroup_file_init(int idx)
> +static void __init __hugetlb_cgroup_file_init(struct hstate *h)
>   {
> -	__hugetlb_cgroup_file_dfl_init(idx);
> -	__hugetlb_cgroup_file_legacy_init(idx);
> +	__hugetlb_cgroup_file_dfl_init(h);
> +	__hugetlb_cgroup_file_legacy_init(h);
>   }
>   
>   static void __init __hugetlb_cgroup_file_pre_init(void)
> @@ -1011,13 +873,22 @@ static void __init __hugetlb_cgroup_file_pre_init(void)
>   	BUG_ON(!legacy_files);
>   }
>   
> +static void __init __hugetlb_cgroup_file_post_init(void)
> +{
> +	WARN_ON(cgroup_add_dfl_cftypes(&hugetlb_cgrp_subsys,
> +				       dfl_files));
> +	WARN_ON(cgroup_add_legacy_cftypes(&hugetlb_cgrp_subsys,
> +					  legacy_files));
> +}
> +
>   void __init hugetlb_cgroup_file_init(void)
>   {
>   	struct hstate *h;
>   
>   	__hugetlb_cgroup_file_pre_init();
>   	for_each_hstate(h)
> -		__hugetlb_cgroup_file_init(hstate_index(h));
> +		__hugetlb_cgroup_file_init(h);
> +	__hugetlb_cgroup_file_post_init();
>   }
>   
>   /*

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


