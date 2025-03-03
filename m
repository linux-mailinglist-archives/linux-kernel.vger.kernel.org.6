Return-Path: <linux-kernel+bounces-544787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C19A4E5E4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FC53BD1C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44272253B6C;
	Tue,  4 Mar 2025 15:47:17 +0000 (UTC)
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C786237185
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103236; cv=pass; b=RpIzxJmI4+5ko8qEAndPD5Jm7s3/c1+xXpWoEcQcwy5+4oZHDBs/lsCM994PApLCV6psnv0nfs5b4IOxL0HOtEY2oUB8qhhPXvkAThBSok0R89XEg/Ws70ChbdM12ogkq7FZ1+pcjuFFMbm+HHAiAI5grDmXqpeScI1JnvgYnCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103236; c=relaxed/simple;
	bh=wcIcOFvvWo6Y4MEIL4E+cU4GzfeBSRYrLktn6eT9DcY=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DupvATPjDsTu/pXpotYweZduHaT//8Yxkn8O8Iq0pIlgsrd+TUfTtWEQEPZG/fXXtPFhzXFmnBXUBgoxsxzAZU9+CxNu0BnFjurJ5GgwuPNzY8tmkd6DWgD3Ii2WrTR3MLyyhXkS3u07xReqvnyB6W8+UjebIRU1gQXbw20K1Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com; spf=none smtp.mailfrom=cc.itu.edu.tr; arc=none smtp.client-ip=45.249.212.191; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id C0BFB40D570C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:47:12 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g4f0jmvzG17D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:45:38 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 0AD6342740; Tue,  4 Mar 2025 18:45:19 +0300 (+03)
X-Envelope-From: <linux-kernel+bounces-541870-bozkiru=itu.edu.tr@vger.kernel.org>
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 906CD41F7D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 17:04:27 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 45DEF305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 17:04:27 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF1C162B5D
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E0A02135CE;
	Mon,  3 Mar 2025 14:03:15 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9142212FAD
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 14:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010593; cv=none; b=NXbKe2cBCytbfucu6Yn328680fPZyPXjnsIeAcWSM8cXzONeDb9Rm5tuCmcRQ7tH1lQf1iwcWo3LSw2jPQvaTCU322DoUaDD9LIJmoBkdMvg+45mJ/k/JWw+ODqlX06op89czIChfMoMRB4g2uikbMeo7tRlmHJRjIcoOXulCLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010593; c=relaxed/simple;
	bh=wcIcOFvvWo6Y4MEIL4E+cU4GzfeBSRYrLktn6eT9DcY=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=k6xXMKILIxA2Wq94XwtUT321uuLrE0hCmUSTHWuFmyXl1LWGVp6h+06g2jwYSdLQHk6ALAT1o80wyKQBV8QfBvxQhjBZU8poMPx/nTsmwQLur4CCkyPiIoe2byNJiG/i4oHtbSx/Da5UmNf1ckFFY/DEoeusaDP/4kUTu9Ajkno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Z60lz518fz1ltYp;
	Mon,  3 Mar 2025 21:58:55 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id C0B1318001B;
	Mon,  3 Mar 2025 22:03:05 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Mar 2025 22:03:04 +0800
CC: <dave.hansen@linux.intel.com>, <bp@alien8.de>, <mingo@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <mpe@ellerman.id.au>,
	<peterz@infradead.org>, <tglx@linutronix.de>, <will@kernel.org>,
	<catalin.marinas@arm.com>, <yangyicong@hisilicon.com>,
	<linuxppc-dev@lists.ozlabs.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <morten.rasmussen@arm.com>,
	<msuchanek@suse.de>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
	<jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <xuwei5@huawei.com>, <guohanjun@huawei.com>,
	<sshegde@linux.ibm.com>
Subject: Re: [PATCH v11 2/4] arch_topology: Support SMT control for OF based
 system
To: Dietmar Eggemann <dietmar.eggemann@arm.com>, <sudeep.holla@arm.com>,
	<pierre.gondois@arm.com>
References: <20250218141018.18082-1-yangyicong@huawei.com>
 <20250218141018.18082-3-yangyicong@huawei.com>
 <8a9aedef-08d7-445f-9b67-85e74ec6bd50@arm.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <21e74021-fb68-0003-f0f4-7f54dd674b9d@huawei.com>
Date: Mon, 3 Mar 2025 22:03:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8a9aedef-08d7-445f-9b67-85e74ec6bd50@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd200014.china.huawei.com (7.221.188.8)
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g4f0jmvzG17D
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741707942.21092@y3q85ZVJUGg/q/cnOZIH3A
X-ITU-MailScanner-SpamCheck: not spam

On 2025/2/28 19:11, Dietmar Eggemann wrote:
> On 18/02/2025 15:10, Yicong Yang wrote:
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
> 
> 1/max_thread_number stands for '1 or max_thread_number', right ?
> 
> Aren't the two interfaces:
> 
> (a) /sys/devices/system/cpu/smt/active
> (b) /sys/devices/system/cpu/smt/control
> 
> and you write 1) or 2) (or 'forceoff') into (b)?

yes you're correct. "active" is a RO file for status only so not for this interface.
Let me explicitly mention the /sys/devices/system/cpu/smt/control here in the commit.

> 
>> If a system have more than one SMT thread number the 2) may
> 
> s/have/has
> 
>> not handle it well, since there're multiple thread numbers in the
> 
> multiple thread numbers other than 1, right?

according to the pr_warn_once() we implemented below it also includes the case
where the system have one type of SMT cores and non-SMT cores (the thread number is 1):
- 1 thread
- X (!= 1) threads

Discussion made in [1] and I thought we have agreement (hope I understood correctly)
that all the asymmetric cases need to notify. Do you and Sudeep think we should not
warn in such case?

[1] https://lore.kernel.org/linux-arm-kernel/10082e64-b00a-a30b-b9c5-1401a54f6717@huawei.com/

> 
>> system and 2) only accept 1/max_thread_number. So issue a warning
>> to notify the users if such system detected.
> 
> This paragraph seems to be about heterogeneous systems. Maybe mention this?
> 
> Heterogeneous system with SMT only on a subset of cores (like Intel
> Hybrid): This one works (N threads per core with N=1 and N=2) just fine.
> 
> But on Arm64 (default) we would still see:
> 
> [0.075782] Heterogeneous SMT topology is partly supported by SMT control
> 

more clearer, will add it. Thanks.

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
> 
> maybe shorter ?
> 
> /* used to enable SMT control */
> 

sure.

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
> 
> Not sure whether the last sentence is needed here?
> 

We always need to call cpu_smt_set_num_threads() to notify the framework
of the thread number even if SMT is not supported. In which case the
thread number is 1 but the framework can handle this well. I worry readers
may get confused for notifying a thread number of 1 so add this comment this.

Will get rid of this if thought redundant.

Thanks.




