Return-Path: <linux-kernel+bounces-202924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 053408FD30C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9335AB231E7
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4564815EFDC;
	Wed,  5 Jun 2024 16:40:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73F3155331
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717605622; cv=none; b=LnFZqLGOAkoZxQNW8BKnt+zVLUsctmOcZ1nyT214hYwro+xeU5H9l3oGZ67tipVIjzuNkBHfy104aK4vF7VvvJlM9h+XOvU/DlqkqC03DvKkJHn8Ludo4V0UgDnXV8bmYjI8zst/jxxWsrE8Amzutj7KremfZSAncGsBiRZyKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717605622; c=relaxed/simple;
	bh=lF6GPjQqIbuK25qz+8EoVYNtzln+qgee2OG5YWKSmNw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H/UTb8td9BNjxM1VNn2bmjxpfcSUaL/hj9yQOmOut4XA0JAXv0FDEtpreRNE/sPE8t/g9VC3TsD9kO4HuN5XP3KpFMCbw14K/71V4ulnpYejyunotWtmFTfsbcgH6OsLB+i/QknycoPEyINLCmWbHkGJAFoVKo07z65KItZAHGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E550339;
	Wed,  5 Jun 2024 09:40:44 -0700 (PDT)
Received: from [10.1.196.28] (eglon.cambridge.arm.com [10.1.196.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5ED1C3F64C;
	Wed,  5 Jun 2024 09:40:17 -0700 (PDT)
Message-ID: <935283dc-26b8-4d93-b3ba-4a19aa6246f1@arm.com>
Date: Wed, 5 Jun 2024 17:40:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/31] x86/resctrl: Move monitor init work to a resctrl
 init call
Content-Language: en-GB
To: Shawn Wang <shawnwang@linux.alibaba.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-11-james.morse@arm.com>
 <beee157c-6e7b-466e-93cd-81a9eb033fe7@linux.alibaba.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <beee157c-6e7b-466e-93cd-81a9eb033fe7@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shawn,

On 10/04/2024 03:57, Shawn Wang wrote:
> On 3/22/24 12:50 AM, James Morse wrote:
>> rdt_get_mon_l3_config() is called from the architecture's
>> resctrl_arch_late_init(), and initialises both architecture specific
>> fields, such as hw_res->mon_scale and resctrl filesystem fields
>> by calling dom_data_init().
>>
>> To separate the filesystem and architecture parts of resctrl, this
>> function needs splitting up.
>>
>> Add resctrl_mon_resource_init() to do the filesystem specific work,
>> and call it from resctrl_init(). This runs later, but is still before
>> the filesystem is mounted and the rmid_ptrs[] array can be used.


> Now x86 platform defaults to all monitoring features on the L3 cache, but some monitoring
> features may also be on the L2 cache or memory controller according to the MPAM spec. For
> example, the memory bandwidth monitors could be on the memory controller.
> 
> Will resctrl_mon_resource_init() consider this scenario?

Nope.

The aim here is to get existing user-space software working on machines with MPAM.
You can build an MPAM machine with monitors on the L1, L2 and L5 - but resctrl can't
expose them, and there is no existing software that makes use of them.

The result is the MPAM driver plays fast and loose with some of this stuff to try and slot
the machine into a Xeon shaped hole.

I'd like to support this in the future, but it will need user visible filesystem changes -
its not worth discussing now.
I strongly suspect that declaring all monitors platform-specific, and plumbing them out
via perf is the best thing for everyone...



Thanks,

James

