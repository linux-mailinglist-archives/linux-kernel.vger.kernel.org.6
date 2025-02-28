Return-Path: <linux-kernel+bounces-539317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34006A4A331
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D04FE7ABC5F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2881D230BE5;
	Fri, 28 Feb 2025 19:54:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3482755F6
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772494; cv=none; b=Ad7N91QGdm7BR1M9wNepzlbjZnAdCDO/ngWJjNm59n7zlMbcajwRHKCiQLq6XzbEBCfThB4/84YLv52oCGLY6fVtUrVw4IZx5/KTBEP54jlNNESYL99qORjC7ZZQfbVW0o5uTHEIiqiCbpPC0dvgFms8dTSiwvOhzkNGpEeoqc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772494; c=relaxed/simple;
	bh=Hglg1Rk3wjepSjBH+v1NlSRpnLWuGrnBt3dezuHufTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZM7BVSc0uzNB9dvskvXASXq8V5dfpQcJSa4ss5LSqArHNn5itQAqCm60PAKuURsHlfdt2SY6m9Qn0ZuvAJHNHQ8ktA/NZLjK32O/e0busD/QKXuqtX5XsDbdcV0LnrOv+pAnOSNNWOFZKIu3Fwt3lNZUW2G7qucx2RzGePuHmOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D50DC176A;
	Fri, 28 Feb 2025 11:55:07 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 715E23F5A1;
	Fri, 28 Feb 2025 11:54:48 -0800 (PST)
Message-ID: <93bd2525-d98d-4fbe-8e98-ff252d17f5e0@arm.com>
Date: Fri, 28 Feb 2025 19:54:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 40/42] fs/resctrl: Add boiler plate for external
 resctrl code
To: Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
 Babu Moger <Babu.Moger@amd.com>, shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-41-james.morse@arm.com>
 <67ef5b80-cafb-4e04-a66a-5f361a3d4f85@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <67ef5b80-cafb-4e04-a66a-5f361a3d4f85@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 20/02/2025 05:54, Reinette Chatre wrote:
> On 2/7/25 10:18 AM, James Morse wrote:
>> Add Makefile and Kconfig for fs/resctrl. Add ARCH_HAS_CPU_RESCTRL
>> for the common parts of the resctrl interface and make X86_CPU_RESCTRL
>> select this.
>>
>> Adding an include of asm/resctrl.h to linux/resctrl.h allows the
>> /fs/resctrl files to switch over to using this header instead.

>> diff --git a/fs/resctrl/Kconfig b/fs/resctrl/Kconfig
>> new file mode 100644
>> index 000000000000..229ca71a8258
>> --- /dev/null
>> +++ b/fs/resctrl/Kconfig
>> @@ -0,0 +1,37 @@
>> +config RESCTRL_FS
>> +	bool "CPU Resource Control Filesystem (resctrl)"
>> +	depends on ARCH_HAS_CPU_RESCTRL
>> +	select KERNFS
>> +	select PROC_CPU_RESCTRL if PROC_FS
>> +	help
>> +	  Some architectures provide hardware facilities to group tasks and
>> +	  monitor and control their usage of memory system resources such as
>> +	  caches and memory bandwidth.  Examples of such facilities include
>> +	  Intel's Resource Director Technology (Intel(R) RDT) and AMD's
>> +	  Platform Quality of Service (AMD QoS).
>> +
>> +	  If your system has the necessary support and you want to be able to
>> +	  assign tasks to groups and manipulate the associated resource
>> +	  monitors and controls from userspace, say Y here to get a mountable
>> +	  'resctrl' filesystem that lets you do just that.
>> +
>> +	  If nothing mounts or prods the 'resctrl' filesystem, resource
>> +	  controls and monitors are left in a quiescent, permissive state.
>> +
>> +	  On architectures where this can be disabled independently, it is
>> +	  safe to say N.
>> +
>> +	  See <file:Documentation/arch/x86/resctrl.rst> for more information.
>> +
>> +config RESCTRL_FS_PSEUDO_LOCK
>> +	bool
>> +	help
>> +	  Software mechanism to pin data in a cache portion using
>> +	  micro-architecture specific knowledge.
>> +
>> +config RESCTRL_RMID_DEPENDS_ON_CLOSID
>> +	bool
>> +	help
>> +	  Enabled by the architecture when the RMID values depend on the CLOSID.
>> +	  This causes the CLOSID allocator to search for CLOSID with clean
>> +	  RMID.
> 
> With RESCTRL_FS_PSEUDO_LOCK and RESCTRL_RMID_DEPENDS_ON_CLOSID appearing at
> same level as RESCTRL_FS all three configs "depends on MISC_FILESYSTEMS".
> Should RESCTRL_FS_PSEUDO_LOCK and RESCTRL_RMID_DEPENDS_ON_CLOSID
> "depends on RESCTRL_FS" instead?

Sure, it can't hurt.


Thanks,

James

