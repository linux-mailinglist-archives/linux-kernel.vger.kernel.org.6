Return-Path: <linux-kernel+bounces-541888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F247A4C2F0
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 15:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6FB13A5753
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 14:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6111F4183;
	Mon,  3 Mar 2025 14:11:56 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0B320E03C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741011116; cv=none; b=E2VZaoOWwmt83AOpieqBR2H+nWaHX9nVswWDFCF/7xrnTKEttSTpbFZ3qko1bRJ0XF280lfIsh9nWNif7JNQbl/kWmdOTUFXZ3Yd0/s9QaKQv4Avr/NRiLn/LYmoIoL3ocWp95ckK5ap6uC4F/vv6h1TvqwBgcWyWszNMarzdLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741011116; c=relaxed/simple;
	bh=TwF2pTLqqEsz20krfTZy/53qq9E4RvgxcRYYsxlGEws=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=m8hNq7/9DlqmsN6G0cdI3Pijcp/c9g5oaO3rUfZuCuQTSaJYMzOWPkdQdVdvKqEA87QFP4IIyTMpbd1PHvrMxBqPGn7f84HqYOfoCzE9DKFzPImnSAaD9ZIc0QvrNtKTj9LOUjOpbu5aHhYW2HjSd0VeL/DO1JmAOXSwvfFJuEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Z60zH45dbz9wFB;
	Mon,  3 Mar 2025 22:08:43 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id AEBEC1800E5;
	Mon,  3 Mar 2025 22:11:50 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Mar 2025 22:11:49 +0800
CC: <yangyicong@hisilicon.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<tglx@linutronix.de>, <peterz@infradead.org>, <mpe@ellerman.id.au>,
	<linux-arm-kernel@lists.infradead.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <pierre.gondois@arm.com>,
	<dietmar.eggemann@arm.com>, <linuxppc-dev@lists.ozlabs.org>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <xuwei5@huawei.com>, <guohanjun@huawei.com>,
	<sshegde@linux.ibm.com>
Subject: Re: [PATCH v11 2/4] arch_topology: Support SMT control for OF based
 system
To: Sudeep Holla <sudeep.holla@arm.com>
References: <20250218141018.18082-1-yangyicong@huawei.com>
 <20250218141018.18082-3-yangyicong@huawei.com> <Z8HAFftf7rAdc_MC@bogus>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <e6942ad5-e6dd-362a-a27e-ef722b8d30a7@huawei.com>
Date: Mon, 3 Mar 2025 22:11:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z8HAFftf7rAdc_MC@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2025/2/28 21:54, Sudeep Holla wrote:
> On Tue, Feb 18, 2025 at 10:10:16PM +0800, Yicong Yang wrote:
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> On building the topology from the devicetree, we've already
>> gotten the SMT thread number of each core. Update the largest
>> SMT thread number and enable the SMT control by the end of
>> topology parsing.
>>
>> The core's SMT control provides two interface to the users [1]:
>> 1) enable/disable SMT by writing on/off
>> 2) enable/disable SMT by writing thread number 1/max_thread_number
>>
>> If a system have more than one SMT thread number the 2) may
>> not handle it well, since there're multiple thread numbers in the
>> system and 2) only accept 1/max_thread_number. So issue a warning
>> to notify the users if such system detected.
>>
>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/ABI/testing/sysfs-devices-system-cpu#n542
>>
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
>> ---
>>  drivers/base/arch_topology.c | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
>> index 3ebe77566788..23f425a9d77a 100644
>> --- a/drivers/base/arch_topology.c
>> +++ b/drivers/base/arch_topology.c
>> @@ -11,6 +11,7 @@
>>  #include <linux/cleanup.h>
>>  #include <linux/cpu.h>
>>  #include <linux/cpufreq.h>
>> +#include <linux/cpu_smt.h>
>>  #include <linux/device.h>
>>  #include <linux/of.h>
>>  #include <linux/slab.h>
>> @@ -506,6 +507,10 @@ core_initcall(free_raw_capacity);
>>  #endif
>>  
>>  #if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
>> +
>> +/* Maximum SMT thread number detected used to enable the SMT control */
>> +static unsigned int max_smt_thread_num;
>> +
>>  /*
>>   * This function returns the logic cpu number of the node.
>>   * There are basically three kinds of return values:
>> @@ -565,6 +570,16 @@ static int __init parse_core(struct device_node *core, int package_id,
>>  		i++;
>>  	} while (1);
>>  
>> +	/*
>> +	 * If max_smt_thread_num has been initialized and doesn't match
>> +	 * the thread number of this entry, then the system has
>> +	 * heterogeneous SMT topology.
>> +	 */
>> +	if (max_smt_thread_num && max_smt_thread_num != i)
>> +		pr_warn_once("Heterogeneous SMT topology is partly supported by SMT control\n");
>> +
> 
> May be we need to make it more conditional as we may have to support
> systems with few cores that are single threaded ? I think Dietmar's
> comment is about that.
> 

it thought of ignoring the cores with single thread in one previous discussion
as replied in Dietmar's thread.

>> +	max_smt_thread_num = max_t(unsigned int, max_smt_thread_num, i);
>> +
>>  	cpu = get_cpu_for_node(core);
>>  	if (cpu >= 0) {
>>  		if (!leaf) {
>> @@ -677,6 +692,18 @@ static int __init parse_socket(struct device_node *socket)
>>  	if (!has_socket)
>>  		ret = parse_cluster(socket, 0, -1, 0);
>>  
>> +	/*
>> +	 * Notify the CPU framework of the SMT support. Initialize the
>> +	 * max_smt_thread_num to 1 if no SMT support detected or failed
>> +	 * to parse the topology. A thread number of 1 can be handled by
>> +	 * the framework so we don't need to check max_smt_thread_num to
>> +	 * see we support SMT or not.
>> +	 */
>> +	if (!max_smt_thread_num || ret)
>> +		max_smt_thread_num = 1;
>> +
> 
> For the failed parsing of topology, reset_cpu_topology() gets called.
> I suggest resetting max_smt_thread_num to 1 belongs there.

this is only used by ARM64 || RISCV for using arch_topology to parse
the CPU topology, but the reset_cpu_topology() is also shared by arm/parisc.
Should we move it there and add some ARM64 || RISCV protection macro?

> 
> And if you start with max_smt_thread_num, we don't need to update it to
> 1 explicitly here. So I would like to get rid of above check completely.
> 
> --
> Regards,
> Sudeep
> 
> .
> 

