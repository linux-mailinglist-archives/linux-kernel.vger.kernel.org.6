Return-Path: <linux-kernel+bounces-551708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C6BA56FBB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 18:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B300A188E8E7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 17:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DFE21C180;
	Fri,  7 Mar 2025 17:54:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978A323BD00
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 17:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741370052; cv=none; b=Ijaxj4Z23aKVL6ggLmwajLX0qMCPqqB4OnOSesKSnu7rsNh1zyGxJIoeJPla2+E/Y1c4jX9oSbkPx9ArtrHuTPhIwEx82htu7vyRwgQU999eApvYO/OpMNwPzhBxXQmGd6Cg/fxAzixgWtthqRpXbrbgZ5BfsQDO/rWg+Nf3jDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741370052; c=relaxed/simple;
	bh=KONWYf6Nsq6yHXmgLMUeoay9Ni1APH92E1kaFu8rK18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FuGRoywpDdk3UVxveRyrWrU3be//TM72P5jsrMXTJem7KRbErsVJ7W+nVAAw9jTaz5/A51SfwAoWlT1SP53ny/HFzaIP4EetVdaN2S9QIQhgDXL0BOSA2FxDSxjTlw1SIqIERqsl0A7N88f1xSRx0lP05NRe4kiIuW5fA39IIgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 034871477;
	Fri,  7 Mar 2025 09:54:21 -0800 (PST)
Received: from [10.1.197.49] (eglon.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E942C3F66E;
	Fri,  7 Mar 2025 09:54:03 -0800 (PST)
Message-ID: <0d290ca1-20cf-4165-aa4e-62da582a5461@arm.com>
Date: Fri, 7 Mar 2025 17:54:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 33/49] x86/resctrl: resctrl_exit() teardown resctrl but
 leave the mount point
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
 Shanker Donthineni <sdonthineni@nvidia.com>, fenghuay@nvidia.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, Tony Luck <tony.luck@intel.com>
References: <20250228195913.24895-1-james.morse@arm.com>
 <20250228195913.24895-34-james.morse@arm.com>
 <053d8a62-022b-4bf8-8e47-651e7c3a2d59@intel.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <053d8a62-022b-4bf8-8e47-651e7c3a2d59@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Reinette,

On 07/03/2025 04:45, Reinette Chatre wrote:
> On 2/28/25 11:58 AM, James Morse wrote:
>> resctrl_exit() was intended for use when the 'resctrl' module was unloaded.
>> resctrl can't be built as a module, and the kernfs helpers are not exported
>> so this is unlikely to change. MPAM has an error interrupt which indicates
>> the MPAM driver has gone haywire. Should this occur tasks could run with
>> the wrong control values, leading to bad performance for important tasks.
>> The MPAM driver needs a way to tell resctrl that no further configuration
>> should be attempted.
>>
>> Using resctrl_exit() for this leaves the system in a funny state as
>> resctrl is still mounted, but cannot be un-mounted because the sysfs
>> directory that is typically used has been removed. Dave Martin suggests
>> this may cause systemd trouble in the future as not all filesystems
>> can be unmounted.
>>
>> Add calls to remove all the files and directories in resctrl, and
>> remove the sysfs_remove_mount_point() call that leaves the system
>> in a funny state. When triggered, this causes all the resctrl files
>> to disappear. resctrl can be unmounted, but not mounted again.

> (copying v6 discussion here)

> On 3/6/25 11:28 AM, James Morse wrote:
>> On 01/03/2025 02:35, Reinette Chatre wrote:
>>> On 2/28/25 11:54 AM, James Morse wrote:
>>>> On 20/02/2025 04:42, Reinette Chatre wrote:
> 
>>>>> It is difficult for me to follow the kernfs reference counting required
>>>>> to make this work. Specifically, the root kn is "destroyed" here but it
>>>>> is required to stick around until unmount when the rest of the files
>>>>> are removed.
>>>>
>>>> This drops resctrl's reference to all of the files, which would make the files disappear.
>>>> unmount is what calls kernfs_kill_sb(), which gets rid of the root of the filesystem.
>>>
>>> My concern is mostly with the kernfs_remove() calls in the rdt_kill_sb()->rmdir_all_sub()
>>> flow. For example:
>>> 	kernfs_remove(kn_info);
>>> 	kernfs_remove(kn_mongrp);
>>> 	kernfs_remove(kn_mondata);
>>>
>>> As I understand the above require the destroyed root to still be around.

>> Right - because rdt_get_tree() has these global pointers into the hierarchy, but doesn't
>> take a reference. rmdir_all_sub() relies on always being called before
>> rdtgroup_destroy_root().

> Is this a known issue then?

Its just a subtle thing that resctrl was relying on, and I didn't spot. Thanks for
pointing it out!


> Since I am not able to use your test I created something new
> after thinking there would be no response to my comment and indeed on unmount:
> [  293.707228] BUG: KASAN: slab-use-after-free in kernfs_remove+0x87/0xa0
> [  293.714718] Read of size 8 at addr ff11000309d88f30 by task umount/3793
>> The point hack would be for rdtgroup_destroy_root() to NULL out those global pointers, (I
>> note they are left dangling) - that would make a subsequent call to rmdir_all_sub() harmless.
>>
>> A better fix would be to pull out all the filesystem relevant parts from rdt_kill_sb(),
>> make that safe for multiple calls and get resctrl_exit() to call that.
>> A call to rdt_kill_sb() after resctrl_exit() would just cleanup the super-block.
>> This will leave things in a more predictable state.


> Why just the filesystem relevant parts?

The stated aim is to prevent any further configuration of the hardware.
We can change that to 'unmount as much as possible'. I didn't think of it like that as I
couldn't find an in-kernel way of triggering a umount(). (and the mount may be copied into
numerous namespaces)


> Although, you also state "resctrl_exit() would just
> cleanup the super-block" that sounds like you are thinking about pulling out all reset work.
> This sounds reasonable to me. It really feels more appropriate to do proper cleanup and
> not just wipe the root while leaving everything else underneath it.

After this discussion, my new proposal is to do this:
-------%<-------
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 0d74a6d98dba..cee4604a59c0 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3063,6 +3063,21 @@ static void rmdir_all_sub(void)
        kernfs_remove(kn_mondata);
 }

+static void resctrl_fs_teardown(void)
+{
+       lockdep_assert_held(&rdtgroup_mutex);
+
+       /* Cleared by rdtgroup_destroy_root() */
+       if (!rdtgroup_default.kn)
+               return;
+
+       rmdir_all_sub();
+       rdt_pseudo_lock_release();
+       rdtgroup_default.mode = RDT_MODE_SHAREABLE;
+       schemata_list_destroy();
+       closid_exit();
+       rdtgroup_destroy_root();
+}
+
 static void rdt_kill_sb(struct super_block *sb)
 {
        struct rdt_resource *r;
@@ -3076,11 +3091,8 @@ static void rdt_kill_sb(struct super_block *sb)
        for_each_alloc_capable_rdt_resource(r)
                resctrl_arch_reset_all_ctrls(r);

-       rmdir_all_sub();
-       rdt_pseudo_lock_release();
-       rdtgroup_default.mode = RDT_MODE_SHAREABLE;
-       schemata_list_destroy();
-       rdtgroup_destroy_root();
+       resctrl_fs_teardown();
+
        if (resctrl_arch_alloc_capable())
                resctrl_arch_disable_alloc();
        if (resctrl_arch_mon_capable())
                resctrl_arch_disable_mon();
-       closid_exit();
        resctrl_mounted = false;
        kernfs_kill_sb(sb);
        mutex_unlock(&rdtgroup_mutex);
-------%<-------

and call resctrl_fs_teardown() from resctrl_exit().

This leaves a bunch of resctrl_arch_ calls behind, the reason is its the arch code that
calls resctrl_exit(), so it probably doesn't need to be told to disable things. For MPAM,
the work of resctrl_arch_reset_all_ctrls() will already have been done - and all these
calls will fail because the MPAM driver is blocking further access to the hardware.


Thanks,

James

