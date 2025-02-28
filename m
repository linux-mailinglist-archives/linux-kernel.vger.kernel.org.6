Return-Path: <linux-kernel+bounces-539305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F06FA4A319
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 20:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DA567A5266
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 19:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F81230BE1;
	Fri, 28 Feb 2025 19:53:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E1B1B87FB
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 19:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740772410; cv=none; b=DaLqM0Qhlnog1c3wYs35dN07ilRdiw2Niwzad43DQDN7TX0xfURyQtP64lEM/5tDKcYkEuR8nxUALFMardig3pVfJSWuwEZEzPSqSJ4ND5qFW0hTItmze7X4hErzA2+4vFi1jQ8q/Md56K0butDziIcaPD2M8R/btxfeywSCMfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740772410; c=relaxed/simple;
	bh=fyt/vM3R1WlG9ff8ewRqq4NU1IS8I5Nhkpls25IgjG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+E5qXm3Qsoi+ES3keF2Ua9HbENyJp/MqUj8iaQ7hDpJ8vNdueq+fEjcrtz71tCFks2cJgUWTIQUCz3eqNYlr5prRqfJANbCDzWUJvax+zncVu88eE1I5qfv8Sao//JBUJrPjMrAgO1/IXdH45AQuuKb/8QRqNOefx6+khOGuNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9CCC150C;
	Fri, 28 Feb 2025 11:53:42 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 919223F5A1;
	Fri, 28 Feb 2025 11:53:23 -0800 (PST)
Message-ID: <0aff0325-e410-4b14-aa69-adfabd0ac0b0@arm.com>
Date: Fri, 28 Feb 2025 19:53:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 37/42] x86/restrl: Expand the width of dom_id by
 replacing mon_data_bits
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
 Shanker Donthineni <sdonthineni@nvidia.com>
References: <20250207181823.6378-1-james.morse@arm.com>
 <20250207181823.6378-38-james.morse@arm.com>
 <bf7e9acd-01f0-4011-80e3-c11c0298fd73@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <bf7e9acd-01f0-4011-80e3-c11c0298fd73@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 20/02/2025 05:40, Reinette Chatre wrote:
> On 2/7/25 10:18 AM, James Morse wrote:
>> MPAM platforms retrieve the cache-id property from the ACPI PPTT table.
>> The cache-id field is 32 bits wide. Under resctrl, the cache-id becomes
>> the domain-id, and is packed into the mon_data_bits union bitfield.
>> The width of cache-id in this field is 14 bits.
>>
>> Expanding the union would break 32bit x86 platforms as this union is
>> stored as the kernfs kn->priv pointer. This saved allocating memory
>> for the priv data storage.
>>
>> The firmware on MPAM platforms have used the PPTT cache-id field to
>> expose the interconnect's id for the cache, which is sparse and uses
>> more than 14 bits. Use of this id is to enable PCIe direct cache
>> injection hints. Using this feature with VFIO means the value provided
>> by the ACPI table should be exposed to user-space.
>>
>> To support cache-id values greater than 14 bits, convert the
>> mon_data_bits union to a structure. This is allocated when the kernfs
>> file is created, and free'd when the monitor directory is rmdir'd.

>> Readers and writers must hold the rdtgroup_mutex, and readers should
>> check for a NULL pointer to protect against an open file preventing
>> the kernfs file from being free'd immediately after the rmdir call.

> The last sentence is difficult to parse and took me many reads. I see
> two major parts to this statement and if I understand correctly the current
> implementation combined with this patch does not support either.
> (a) "checking for a NULL pointer from readers"
>     The reader is rdtgroup_mondata_show() and it starts by calling:
> 		rdtgrp = rdtgroup_kn_lock_live(of->kn);
>     As I understand, on return of rdtgroup_kn_lock_live() the kernfs node
>     "of->kn" may no longer exist. This seems to be an issue with current code
>     also.
>     Considering this, it seems to me that checking if of->kn->priv is NULL
>     may be futile if of->kn may no longer exist.

Certainly true.
Because the lifetime is different to the existing pointer-abuse version, I just added the
checks to be on the safe side.

I'll rip this out.


>     I think this also needs a reference to the data needed by the file or
>     the data needs to be stashed away before the call to
>     kernfs_break_active_protection().

I've tried to hit this problem, and been unable. I'm happy to write it off as theoretical.

In particular:
* rmdir a control group while holding the mbm_local_bytes file open for reading. Any read
after the parent control group has been destroyed gets -ENODEV, even though though
/proc/<pid>/fd shows the fd as open for reading. The kernel in question had lockdep and
kasan enabled)
* take all the CPUs in a domain offline while holding the mbm_local_bytes file open for
reading. Again, read attempts get -ENODEV.


> (b) "...being free'd immediately after the rmdir call"
>     I believe this refers to expectation that one task may have the file open
>     while another removes the resource group directory ("rmdir") with the
>     assumption that the associated struct mon_data is removed during handling
>     of rmdir.

This is what I was worried about - and it seemed worth chucking in a NULL check just in
case. Trying a bit harder to hit it - it now seems theoretical.


>     In this implementation the monitoring data file's struct mon_data
>     is only removed when a monitoring domain goes offline.

>     That is, when the
>     resource group remains intact while the monitoring data files associated with
>     one domain is removed (for example when all CPUs associated with that domain
>     goes offline). The "rmdir" to remove a resource group does not call this code
>     (mon_rmdir_one_subdir()), nor does the cleanup of the default resource group's
>     "kn_mondata".  

Huh, its the path via user-space calling rmdir() that I was worried about. I hadn't
spotted that there are two of these and they aren't joined up!

This would leak the priv pointer when the user-space path via rmdir() just leaves the
cleanup to kernfs.

Fixing this produces even more spaghetti as domain-offline manipulates one domain in all
rdtgroup, whereas rmdir manipulates all domains in on rdtgroup. Its going to be noisy to
merge these two paths.


A simpler approach is to use the event kn->priv pointers in the default control group as
the canonical copy, which also saves memory. For mbm_total in a domain, every control and
monitor group has the same values in struct mon_data_bits - the RMID is found by walking
up the tree to find the struct rdtgroup.
As user-space can't rmdir the default control group, we only need to free it for
domain-offline, when we know all the files for that domain are going to be removed - which
we can rely on to avoid doing it in a particular order.


> I am trying to get a handle on the different lifetimes and if I understand
> correctly this implementation does not attempt to keep the struct mon_data
> accessible as long as the file is open.

No, but I think that concern is theoretical...

> I do not think I've discovered all the implications of this yet.


Thanks,

James

