Return-Path: <linux-kernel+bounces-303091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A28960746
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE501284CF9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143D719D067;
	Tue, 27 Aug 2024 10:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BJ5K+xLU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F154C92;
	Tue, 27 Aug 2024 10:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724753980; cv=none; b=clc1MhmC08Qz286gP3VuDhwoy+NO469r2n8U9+Inkh9nJdaUEHAhxrdgseeQzToAxBcENodgyrumw7JjjY8sMLmOW6Iyv1v/noL6XDX8/apd8Sg503reemNPdZt/7Q4uOUf3pl/OHJmRW+M87rVMl6CFa0QsMiYh9LrVao/VdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724753980; c=relaxed/simple;
	bh=q9TMQaEJpp+FkfB6K5kFSp3xAd9rcZ/EPxxpitbk9BE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=t/hKK+6sQN+RuiT7FXkIr10VFAVoVxtXDudnfH7FGrjaHSk7VkoGdTQGRq8r3A4xkqxPzlDxuArUeSnMo3eo8PhXQPp4C7iUUq/upIpElrAt2+mJV9GWgg0/K09lGpmRXsTGmhN/Je64X1eg0OdG4DQkFs0A3t9HFcHYUU2A5xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BJ5K+xLU; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724753979; x=1756289979;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=q9TMQaEJpp+FkfB6K5kFSp3xAd9rcZ/EPxxpitbk9BE=;
  b=BJ5K+xLUIonSkSvWYOZc+ATaBR1B8C/GG8xdm1V0Cl3XWAucs4o1Q5xe
   3vvE6pkUj9kiZUzOe/qSnz3GRibCyCpD1uZEHINYpdQV09n9NBR1eSmRA
   Ugee8YgFvda7FnK1QEnudXJ6GrmZd1O6AVJ3NjyZeNOUzFui2apGyoZeZ
   KjclIkIHYuATFUFMfA11xhNYZWa70DctfODrES0XU0+F3CdSwLadg47Eg
   GshzSNGRL5taZ1So4sX0Aug+ila09h6A/qFDg4UjWx//NK704gfl53DJr
   9TrtBw3Z66U0PbtmFVNAci8Wg/Qt3iNguR0rDY4TES8SX7Obf6CsOor9k
   g==;
X-CSE-ConnectionGUID: /UyIxyWvTa2fYQJ5hCbLBw==
X-CSE-MsgGUID: z95NSMukRLSi/Kd2qTjxwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="33882013"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="33882013"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 03:19:38 -0700
X-CSE-ConnectionGUID: XNVcVGGMSB+1507VELwejw==
X-CSE-MsgGUID: 16u96q87RC6eFmut+Q1g/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="66962858"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.17])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 03:19:33 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 27 Aug 2024 13:19:29 +0300 (EEST)
To: Perry Yuan <perry.yuan@amd.com>
cc: Hans de Goede <hdegoede@redhat.com>, Mario.Limonciello@amd.com, 
    Borislav.Petkov@amd.com, kprateek.nayak@amd.com, Alexander.Deucher@amd.com, 
    Xinmei.Huang@amd.com, bharathprabhu.perdoor@amd.com, 
    poonam.aggrwal@amd.com, Li.Meng@amd.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Xiaojian.Du@amd.com
Subject: Re: [PATCH 06/11] platform/x86/: hfi: parse CPU core ranking data
 from shared memory
In-Reply-To: <e2f17f3915f072d283c1f34774b3d069e670ae36.1724748733.git.perry.yuan@amd.com>
Message-ID: <c715c235-d9d9-977b-77c8-75f90ff8ad84@linux.intel.com>
References: <cover.1724748733.git.perry.yuan@amd.com> <e2f17f3915f072d283c1f34774b3d069e670ae36.1724748733.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Aug 2024, Perry Yuan wrote:

> From: Perry Yuan <Perry.Yuan@amd.com>

Drop the second / from platform/x86/.

> When `amd_hfi` driver is loaded, it will use PCCT subspace type 4 table
> to retrieve the shared memory address which contains the CPU core ranking
> table. This table includes a header that specifies the number of ranking data
> entries to be parsed and rank each CPU core with the Performance and Energy
> Efficiency capability as implemented by the CPU power management firmware.
> 
> Once the table has been parsed, each CPU is assigned a ranking score within
> its class. Subsequently, when the scheduler selects cores, it chooses
> from the ranking list based on the assigned scores in each class, thereby
> ensuring the optimal selection of CPU cores according to their predefined
> classifications and priorities.
> 
> Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
> ---
>  drivers/platform/x86/amd/hfi/hfi.c | 267 +++++++++++++++++++++++++++++
>  1 file changed, 267 insertions(+)
> 
> diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
> index 914390682fef..50f6ca9c148a 100644
> --- a/drivers/platform/x86/amd/hfi/hfi.c
> +++ b/drivers/platform/x86/amd/hfi/hfi.c
> @@ -19,23 +19,108 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/mailbox_client.h>
>  #include <linux/mutex.h>
> +#include <linux/percpu-defs.h>
>  #include <linux/platform_device.h>
>  #include <linux/printk.h>
>  #include <linux/smp.h>
>  #include <linux/string.h>
> +#include <linux/topology.h>
> +#include <linux/workqueue.h>
> +
> +#include <asm/cpu_device_id.h>
> +
> +#include <acpi/pcc.h>
> +#include <acpi/cppc_acpi.h>
>  
>  #define AMD_HFI_DRIVER		"amd_hfi"
>  #define AMD_HETERO_CPUID_27	0x80000027
> +#define AMD_HETERO_RANKING_TABLE_VER	2
>  static struct platform_device *device;
>  
> +/**
> + * struct amd_core_rank_table - HFI capabilities for the logical
> + * processors in the memory mappep table.
> + *
> + * @signature:	The PCC signature. The signature of a subspace is computed by
> + *		a bitwise of the value 0x50434300 with the subspace ID.
> + * @flags:	Notify on completion
> + * @length:	Length of payload being transmitted including command field
> + * @command:	Command being sent over the subspace
> + * @version_number:		Version number of the table
> + * @n_logical_processors:	Number of logical processors
> + * @n_capabilities:		Number of ranking dimensions (performance, efficiency, etc)
> + * @table_update_context:	Command being sent over the subspace
> + * @n_bitmaps:			Number of 32-bit bitmaps to enumerate all the APIC IDs
> + *				This is based on the maximum apic ID enumerated in the system
> + * @reserved:			The 24bit spare
> + * @bitmap_of_apic_id0:		Bit Map of enabled logical processors APIC ID for 31:0
> + * @bitmap_of_apic_id1:		Bit Map of enabled logical processors APIC ID for 64:32
> + * @n_classes:			Number of workload class
> + * @dynamic_rank_feature:	Table update mode
> + * @diagnostics:		Reserved space for diagnostics
> + * @timestamp:			Timestamp for last table update
> + * @table_size:			Table length of shared memory
> + * @shmem_info:			The table data read from shared memory
> + * @bitmap_data:		Bitmap data read from table
> + * @max_index:			The max data array in the table
> + *
> + * A memory mapped table is used to express the capabilities of each logical
> + * processor for each thread classification. with dynamic table update feature
> + * supported, the table will be notified to update for all the cores while system
> + * running, each table update can reorder the cores for much better performance and
> + * power efficiency.
> + *
> + */
> +struct amd_hfi_metadata {
> +	u32	signature;
> +	u32	flags:1;
> +	u32	length;
> +	u32	command;
> +	u8	version_number;
> +	u8	n_logical_processors;
> +	u8	n_capabilities;
> +	u8	table_update_context;
> +	u8	n_bitmaps;
> +	u32	reserved:24;
> +	u32	bitmap_of_apic_id0;
> +	u32	bitmap_of_apic_id1;
> +	u8	n_classes;
> +	bool	dynamic_rank_feature;
> +	int	diagnostics;
> +	u64	timestamp;
> +	u64	table_size;
> +	u32	shmem_info[64];
> +	u32	bitmap_data;
> +	u32	max_index;
> +};
> +
>  struct amd_hfi_data {
>  	const char	*name;
>  	struct device	*dev;
>  	struct mutex	lock;
>  	acpi_handle	dhandle;
> +
> +	/* PCCT table related*/
> +	int		plat_irq;
> +	struct pcc_mbox_chan	*pcc_chan;
> +	void __iomem		*pcc_comm_addr;
> +	struct completion	done;
> +	struct mbox_client	cl;
> +	raw_spinlock_t		table_lock;
> +	struct acpi_subtable_header	*pcct_entry;
> +	struct amd_hfi_metadata		*hfi_meta;
>  };
>  
> +/**
> + * struct amd_hfi_classes - HFI class capabilities per CPU
> + * @perf:		Performance capability
> + * @eff:		Power efficiency capability
> + *
> + * Capabilities of a logical processor in the rank table. These capabilities are
> + * unitless and specific to each HFI class.
> + */
>  struct amd_hfi_classes {
>  	u32	perf;
>  	u32	eff;
> @@ -61,6 +146,118 @@ struct amd_hfi_cpuinfo {
>  
>  static DEFINE_PER_CPU(struct amd_hfi_cpuinfo, amd_hfi_cpuinfo) = {.class_index = -1};
>  
> +static int find_cpu_index_by_apicid(unsigned int target_apicid)
> +{
> +	int cpu_index;
> +
> +	for_each_possible_cpu(cpu_index) {
> +		struct cpuinfo_x86 *info = &cpu_data(cpu_index);
> +
> +		if (info->topo.apicid == target_apicid) {
> +			pr_debug(" match apic id %d for cpu index: %d",

APIC

CPU

> +						info->topo.apicid, cpu_index);

Misaligned.

> +			return cpu_index;
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int amd_hfi_fill_metadata(struct amd_hfi_data *amd_hfi_data)
> +{
> +	struct pcc_mbox_chan *pcc_chan = amd_hfi_data->pcc_chan;
> +	struct acpi_subtable_header *pcct_entry = amd_hfi_data->pcct_entry;
> +	struct acpi_pcct_ext_pcc_slave *pcct_ext =
> +		(struct acpi_pcct_ext_pcc_slave *)pcct_entry;
> +	struct amd_hfi_metadata *meta = amd_hfi_data->hfi_meta;
> +	u32 header_index = 0, data_index = 0;
> +	struct amd_hfi_cpuinfo *info;
> +	u32 offset, offset_begin;
> +	void __iomem *pcc_comm_addr;
> +	int idx, ret, length;
> +	u32 *shmem_info;
> +
> +	length = pcct_ext->length;
> +	if (length <= 0) {
> +		pr_err("length is less than min table length required\n");
> +		return -EINVAL;
> +	}
> +
> +	shmem_info = devm_kmalloc_array(amd_hfi_data->dev, length, sizeof(u32), GFP_KERNEL);
> +	if (!shmem_info) {
> +		pr_err("failed to allocate memory %x\n", length);
> +		return -ENOMEM;
> +	}
> +
> +	pcc_chan->shmem_base_addr = pcct_ext->base_address;
> +	pcc_chan->shmem_size = pcct_ext->length;
> +
> +	amd_hfi_data->plat_irq = pcct_ext->platform_interrupt;
> +	if (amd_hfi_data->plat_irq < 0) {
> +		pr_err("invalid irq allocated in pcct table\n");

IRQ

> +		return -EINVAL;
> +	}
> +
> +	pcc_comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr, pcc_chan->shmem_size);
> +	if (!pcc_comm_addr) {
> +		pr_err("failed to ioremap PCC common region mem\n");
> +		return -ENOMEM;
> +	}
> +
> +	raw_spin_lock(&amd_hfi_data->table_lock);

Why is this using a raw spinlock?

> +	memcpy_fromio(shmem_info, (u32 __iomem *)pcc_comm_addr, length);

Unnecessary cast.

> +	/* extended PCC subspace shared memory region */
> +	meta->signature = shmem_info[header_index];
> +	meta->flags = shmem_info[++header_index];

Put ++ as post-increment to the preceeding line instead.

> +	meta->length = shmem_info[++header_index];
> +	meta->command = shmem_info[++header_index];
> +	idx = header_index + 1;

Do the + 1 as post increment on the previous line.

Why you two variables for this (header_index seems unused after this 
point)??

> +	/* shared memory region for cores ranking data */
> +	meta->version_number = shmem_info[idx] & 0xFF;
> +	meta->n_logical_processors = (shmem_info[idx] >> 8) & 0xFF;
> +	meta->n_capabilities = (shmem_info[idx] >> 16) & 0xFF;
> +	meta->table_update_context = (shmem_info[idx] >> 24) & 0xFF;
> +	meta->n_bitmaps = shmem_info[++idx] & 0xFF;
> +	meta->n_classes = (shmem_info[idx] >> 8) & 0xFF;

Use named defines + FIELD_GET() to read bitfields. Make sure you include 
the correct header.

> +	meta->bitmap_data = shmem_info[++idx];
> +	meta->max_index = meta->n_bitmaps * 32;

Magic 32 could likely be named or use sizeof() or BITS_PER_TYPE()?

> +	if (meta->version_number == AMD_HETERO_RANKING_TABLE_VER)
> +		offset_begin = idx + 1;
> +
> +	for (u32 bit_idx = 0; bit_idx < meta->max_index; bit_idx++) {
> +		if (meta->bitmap_data & (1u << bit_idx)) {

Use BIT(bit_idx).

Use reverse logic & continue.


> +			int cpu_index = find_cpu_index_by_apicid(bit_idx);

So variable called "bit_idx" is given to function that takes what is 
called "target_apicid". Are you sure you have the best variable naming 
here ("bit_idx" is very vague)?

> +			if (cpu_index < 0) {
> +				ret = -ENODEV;
> +				goto err_map;
> +			}
> +
> +			info = per_cpu_ptr(&amd_hfi_cpuinfo, cpu_index);
> +
> +			offset = data_index * 6 + offset_begin;
> +			for (int i = 0; i < meta->n_classes; i++) {
> +				info->amd_hfi_classes[i].eff = shmem_info[offset + 2 * i];
> +				info->amd_hfi_classes[i].perf = shmem_info[offset + 2 * i + 1];
> +			}
> +		} else {
> +			continue;
> +		}
> +		data_index++;
> +	}
> +	raw_spin_unlock(&amd_hfi_data->table_lock);
> +	iounmap(pcc_comm_addr);
> +
> +	return 0;
> +
> +err_map:
> +	raw_spin_unlock(&amd_hfi_data->table_lock);

Missing iounmap().

Separate error rollback path seems unnecessary.

> +	return ret;
> +}
> +
>  static int amd_hfi_alloc_class_data(struct platform_device *pdev)
>  {
>  	struct amd_hfi_cpuinfo *hfi_cpuinfo;
> @@ -96,6 +293,56 @@ static void amd_hfi_remove(struct platform_device *pdev)
>  
>  	mutex_destroy(&dev->lock);
>  }
> +static int amd_hfi_metadata_parser(struct platform_device *pdev,
> +		struct amd_hfi_data *amd_hfi_data)
> +{
> +	struct mbox_chan *pcc_mbox_channels;
> +	struct pcc_mbox_chan *pcc_chan;
> +	struct acpi_subtable_header *pcct_entry;
> +	struct acpi_table_header *pcct_tbl;
> +	struct device *dev = &pdev->dev;
> +	acpi_status status;
> +	int ret = 0, count = 1;

Why isn't count a define as it seems constant?

> +
> +	status = acpi_get_table(ACPI_SIG_PCCT, 0, &pcct_tbl);
> +	if (ACPI_FAILURE(status) || !pcct_tbl) {
> +		pr_err("acpi_get_table failed!\n");

Please try to write user-friendly error messages without reference to 
code/function names.

> +		return -ENODEV;
> +	}
> +
> +	pcc_mbox_channels = devm_kcalloc(dev, count,
> +			sizeof(*pcc_mbox_channels), GFP_KERNEL);

misaligned.

> +	if (!pcc_mbox_channels) {
> +		ret = -ENOMEM;
> +		goto exit_err;
> +	}
> +
> +	pcc_chan = devm_kcalloc(dev, count, sizeof(*pcc_chan), GFP_KERNEL);
> +	if (!pcc_chan) {
> +		ret = -ENOMEM;
> +		goto exit_err;
> +	}

You could consider allocing first to make the error handling a bit 
simpler.

> +	/* get pointer to the first PCC subspace entry */
> +	pcct_entry = (struct acpi_subtable_header *) (
> +			(unsigned long) pcct_tbl + sizeof(struct acpi_table_pcct));

Extra space between cast and variable name.

> +
> +	pcc_chan->mchan = &pcc_mbox_channels[0];
> +
> +	amd_hfi_data->pcc_chan = pcc_chan;
> +	amd_hfi_data->pcct_entry = pcct_entry;
> +
> +	/* parse the shared memory info from the pcct table */
> +	ret = amd_hfi_fill_metadata(amd_hfi_data);
> +	if (ret) {
> +		pr_err("failed to parse core ranking table\n");
> +		ret = -ENODATA;
> +	}
> +
> +exit_err:
> +	acpi_put_table(pcct_tbl);
> +	return ret;
> +}
>  
>  static const struct acpi_device_id amd_hfi_platform_match[] = {
>  	{ "AMDI0104", 0},
> @@ -120,6 +367,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  	if (!amd_hfi_data)
>  		return -ENOMEM;
>  
> +	amd_hfi_data->hfi_meta = devm_kzalloc(&pdev->dev,
> +					sizeof(*amd_hfi_data->hfi_meta), GFP_KERNEL);
> +	if (!amd_hfi_data->hfi_meta)
> +		return -ENOMEM;
>  	amd_hfi_data->dev = &pdev->dev;
>  	dhandle = ACPI_HANDLE(&pdev->dev);
>  	if (!dhandle) {
> @@ -132,7 +383,10 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  
>  	amd_hfi_data->dhandle = dhandle;
> +
> +	raw_spin_lock_init(&amd_hfi_data->table_lock);
>  	mutex_init(&amd_hfi_data->lock);
> +
>  	platform_set_drvdata(pdev, amd_hfi_data);
>  
>  	/* alloc data array for hardware feedback class data */
> @@ -140,7 +394,20 @@ static int amd_hfi_probe(struct platform_device *pdev)
>  	if (ret)
>  		return -ENOMEM;
>  
> +	ret = amd_hfi_metadata_parser(pdev, amd_hfi_data);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to parse PCCT table data with %d.\n", ret);
> +		goto err_exit;
> +	}
> +
> +	amd_hfi_data->hfi_meta->dynamic_rank_feature =
> +					cpuid_ebx(AMD_HETERO_CPUID_27) & 0xF;

Magic 0xF should be named with define (and probably use FIELD_GET() too 
even if shift is zero here).

> +	dev_dbg(&pdev->dev, "%s driver registered.\n", pdev->name);

Is this necessary?

> +
>  	return 0;
> +
> +err_exit:
> +	return ret;

Unnecessary error path, any goto here can be replace with direct 
a return.

>  }
>  
>  static struct platform_driver amd_hfi_driver = {
> 

-- 
 i.


