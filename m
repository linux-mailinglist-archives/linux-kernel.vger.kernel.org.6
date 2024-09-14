Return-Path: <linux-kernel+bounces-329055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE45978CB7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 04:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D3F1288780
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 02:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1BFC13D;
	Sat, 14 Sep 2024 02:15:54 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762E010E9
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 02:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726280154; cv=none; b=NmYFP9vu+52rrmEDNdcok4cBpyY/h5TQLEVG36bJhlYJQ/uV2AnfTE65VsotdjIMZR7UANG7Z+HNcbqBrYVSZabWCcBtAYrCYasflD6hVFnino842Zu1xP9TdA1hLXc4nNjr4inCtYRrS5sg7CPvdtxayPUKTs4APBhtv3aKQeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726280154; c=relaxed/simple;
	bh=vuUUoejhfm66HVV/NQ+foywGWQ+O4eWCJYgHgnozVLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LloDVrB5hyfZFLXXSvj/8dLlB08OvmC7S3gx6CXDBByL2pjK5AXD6C5XEMOScyD8Ph2S3+WtqYyAaTlbwaIde/gENoUJCalRh/jEmDxCAGEg0iBP3vTF0QLaUVWWt0j2uWtVl/lrb6XdURgpgDTyjWwMB3ehMKpL+i7l1SV7ybc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4X5F9p58tyz1RCRB;
	Sat, 14 Sep 2024 10:14:38 +0800 (CST)
Received: from kwepemd500019.china.huawei.com (unknown [7.221.188.86])
	by mail.maildlp.com (Postfix) with ESMTPS id C1D5B140137;
	Sat, 14 Sep 2024 10:15:48 +0800 (CST)
Received: from [10.67.109.61] (10.67.109.61) by kwepemd500019.china.huawei.com
 (7.221.188.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 14 Sep
 2024 10:15:48 +0800
Message-ID: <672a45a5-722f-af57-dad4-a285acb0e53a@huawei.com>
Date: Sat, 14 Sep 2024 10:15:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: =?UTF-8?Q?Re=3a_=5bQuestion=5d_sched=ef=bc=9athe_load_is_unbalanced?=
 =?UTF-8?Q?_in_the_VM_overcommitment_scenario?=
To: Waiman Long <longman@redhat.com>, <peterz@infradead.org>,
	<juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <vschneid@redhat.com>, <oleg@redhat.com>, Frederic
 Weisbecker <frederic@kernel.org>, <mingo@kernel.org>, <peterx@redhat.com>,
	<tj@kernel.org>, <tjcao980311@gmail.com>
CC: <linux-kernel@vger.kernel.org>
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
 <3e68ccda-1606-9494-f57a-75be9668b83d@huawei.com>
 <cb3a3f3e-727a-4cbb-b4a8-f9469ed4f08d@redhat.com>
 <9982cb8d-9346-0640-dd9f-f68390f922e9@huawei.com>
 <3fd8aa75-ce1b-4d5a-aada-0b2cfbedb36c@redhat.com>
From: zhengzucheng <zhengzucheng@huawei.com>
In-Reply-To: <3fd8aa75-ce1b-4d5a-aada-0b2cfbedb36c@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd500019.china.huawei.com (7.221.188.86)


在 2024/9/14 1:17, Waiman Long 写道:
> you don't actually need to use 2 different cpusets if they all get the 
> same set of CPUs and memory nodes

Yes, you're right. The purpose of setting two different cpusets is to 
simulate the scenario of two VMs.

each cpuset is a VM.

For example, the VM configuration is as follows:

<domain type='kvm' id='12676'>
   <name>master</name>
   <vcpu placement='static' cpuset='0-3,80-83'>8</vcpu>
   <iothreads>1</iothreads>
   <iothreadids>
     <iothread id='1'/>
   </iothreadids>
   <cputune>
     <vcpupin vcpu='0' cpuset='0-3,80-83'/>
     <vcpupin vcpu='1' cpuset='0-3,80-83'/>
     <vcpupin vcpu='2' cpuset='0-3,80-83'/>
     <vcpupin vcpu='3' cpuset='0-3,80-83'/>
     <vcpupin vcpu='4' cpuset='0-3,80-83'/>
     <vcpupin vcpu='5' cpuset='0-3,80-83'/>
     <vcpupin vcpu='6' cpuset='0-3,80-83'/>
     <vcpupin vcpu='7' cpuset='0-3,80-83'/>
     <emulatorpin cpuset='0-79'/>
   </cputune>
   <numatune>
     <memory mode='strict' nodeset='0'/>
     <memnode cellid='0' mode='strict' nodeset='0'/>
   </numatune>




