Return-Path: <linux-kernel+bounces-336204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5138197F08F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 646D7B2306F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979BD1A01C6;
	Mon, 23 Sep 2024 18:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJAqAQYX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D5E1A01D8
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115671; cv=none; b=nMGUCo4eaTz2liqs5SNVeRH8SOe4aZvvu+QGXzXwAsL26bqpG/R9Iv7Y7ZbKfigJJWhU3kgZCpW3m9gckejhf+W87aBByFTvNh7wNGkTAniJAWT9De/gNYjkZpzL3hpZ/giS9FTPj10FCm2z4sK3UA2VjZmCLsgixlyjO1h4nTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115671; c=relaxed/simple;
	bh=4W+9+uEw6U1YUmQUoFTtj9ci4w6gAz42P/CEX2pKqX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdn0zRe5LnK5oBTxtlfofu27t+/97AlFOdhueLKXRA3p+/UVUPOYum7Me2AGOPwosZhV8umMD/t2eYd/3plpOIqkpfkp+q+1p1a9qyOZ7qN+Vhw2JWqBgVTDVUf63bKP4xdi6dpG55dgryPq4IWx3YaFSKkCSs1F7+lc1thlWaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJAqAQYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40177C4CECD;
	Mon, 23 Sep 2024 18:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727115670;
	bh=4W+9+uEw6U1YUmQUoFTtj9ci4w6gAz42P/CEX2pKqX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oJAqAQYX2Me9NV5XuqSplePKRPzaLC0axJUlq7n0O7OANu2zP999vFf6yLqsBWH/P
	 GeGzXgXm8yCl13Rmz53xP4wnc4iSxjxn7czAR8Oyf3FS4QMCGlqbI4T0gVYistH5Hi
	 jV0dL/fiFU53yL7t9HJzP+pkA9F1ZRBRADb2nHA4/wLFTIF4FiQmSs8V+6CHke22OI
	 cCN6W4ry0hDVVSPd7zKTQMIbYpNN5NighfsI0v/qv/5hTQFqVDUWCCfnZsCz31kyuC
	 0RcRjnLPVVVb8vlZam7fF0UwcUOdBOgwjKEFwsR3qX2E1nD2Q4h+HSGdMRDRPgTwVS
	 iCC2d5aQ/HRkQ==
Date: Mon, 23 Sep 2024 08:21:09 -1000
From: Tejun Heo <tj@kernel.org>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU Hotplug
Message-ID: <ZvGxlcMwFOmUBfr9@slm.duckdns.org>
References: <daf2370f5456cbf1660bbdc13621559fb3f2f6cc.camel@linux.ibm.com>
 <Zq1NksrG9blyN-KR@slm.duckdns.org>
 <e3069da05fb1676f8faad88b9a4dfc4a6cef4175.camel@linux.ibm.com>
 <Zru5_UmEmWhNaPyo@slm.duckdns.org>
 <fa56b39990dd0b90f971018f5abb7352c60af3b1.camel@linux.ibm.com>
 <ZsTwoWJQcnsJhYbe@slm.duckdns.org>
 <3da12c96daecaa055c478816f5e86c7b44a04d53.camel@linux.ibm.com>
 <ZszKI2GA-8yparh_@slm.duckdns.org>
 <Zul6l-S_JulEnDQw@mtj.duckdns.org>
 <516106abdf5c922ee19dffd9eb69ea3f9e20e54a.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <516106abdf5c922ee19dffd9eb69ea3f9e20e54a.camel@linux.ibm.com>

Hello,

(cc'ing Alexei and Andrii for the BPF part)

On Mon, Sep 23, 2024 at 08:26:32PM +0530, Aboorva Devarajan wrote:
> Sharing the crash logs observed in PowerPC here for general reference, FYI:
> 
> [ 8638.891964] Kernel attempted to read user page (a8) - exploit attempt? (uid: 0)
> [ 8638.892002] BUG: Kernel NULL pointer dereference on read at 0x000000a8
> [ 8638.892019] Faulting instruction address: 0xc0000000004e7cc0
> [ 8638.892038] Oops: Kernel access of bad area, sig: 11 [#1]
> [ 8638.892060] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
> [ 8638.892080] Modules linked in: nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype
> br_netfilter xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp
>  ip6table_mangle ip6table_nat iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
> nf_defrag_ipv4 ebtable_filter ebtables vhost_vsock vmw_vsock_virtio_transport_common ip6tabl
> e_filter ip6_tables vhost vhost_iotlb iptable_filter vsock bridge stp llc kvm_hv kvm joydev
> input_leds mac_hid at24 ofpart cmdlinepart uio_pdrv_genirq ibmpowernv opal_prd ipmi_powernv 
> powernv_flash uio binfmt_misc sch_fq_codel nfsd mtd ipmi_devintf ipmi_msghandler auth_rpcgss
> jc42 ramoops reed_solomon ip_tables x_tables autofs4 raid10 raid456 async_raid6_recov async
> _memcpy async_pq async_xor async_tx raid1 raid0 dm_mirror dm_region_hash dm_log mlx5_ib ib_uverbs
> ib_core mlx5_core hid_generic usbhid hid ast i2c_algo_bit drm_shmem_helper drm_kms_hel
> per vmx_crypto drm mlxfw crct10dif_vpmsum crc32c_vpmsum psample tls tg3 ahci libahci
> drm_panel_orientation_quirks
> [ 8638.892621] CPU: 62 UID: 0 PID: 5591 Comm: kworker/62:2 Not tainted 6.11.0-rc4+ #2
> [ 8638.892663] Hardware name: 8335-GTW POWER9 0x4e1203 opal:skiboot-v6.5.3-35-g1851b2a06 PowerNV
> [ 8638.892693] Workqueue: events bpf_prog_free_deferred
> [ 8638.892735] NIP:  c0000000004e7cc0 LR: c0000000004e7bbc CTR: c0000000003a9b30
> [ 8638.892798] REGS: c000000ea4cbf7f0 TRAP: 0300   Not tainted  (6.11.0-rc4+)
> [ 8638.892862] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 42a00284  XER: 00000000
> [ 8638.892915] CFAR: c0000000004e7bb8 DAR: 00000000000000a8 DSISR: 40000000 IRQMASK: 1 
> [ 8638.892915] GPR00: c0000000004e7bbc c000000ea4cbfa90 c000000002837f00 0000000000000005 
> [ 8638.892915] GPR04: 0000000000000015 0000000000000009 0000000000000009 c000000004840b00 
> [ 8638.892915] GPR08: ffffffffffffffff 00000000ffffe000 ffffffffffffffff 000001937b55db50 
> [ 8638.892915] GPR12: 0000000000200000 c000007ffdfac300 c0000000031b1fc8 0000000000010000 
> [ 8638.892915] GPR16: c00000000000018e 000000007fffffff 0000000000000000 000000000000e1c0 
> [ 8638.892915] GPR20: 61c8864680b583eb 0000000000000000 0000000000000000 00000000000de1d5 
> [ 8638.892915] GPR24: 0000000000000000 c000000003da4408 c000000003da4400 c000000003da43f8 
> [ 8638.892915] GPR24: 0000000000000000 c000000003da4408 c000000003da4400 c000000003da43f8 
> [ 8638.892915] GPR28: 0000000000000000 0000000000000000 0000000000000000 c000000ea4cbfa90 
> [ 8638.893350] NIP [c0000000004e7cc0] walk_to_pmd+0x80/0x240
> [ 8638.893380] LR [c0000000004e7bbc] __get_locked_pte+0x4c/0xd0
> [ 8638.893398] Call Trace:
> [ 8638.893407] [c000000ea4cbfa90] [c000000ea4cbfb20] 0xc000000ea4cbfb20 (unreliable)
> [ 8638.893429] [c000000ea4cbfaf0] [c0000000004e7bbc] __get_locked_pte+0x4c/0xd0
> [ 8638.893457] [c000000ea4cbfb40] [c0000000000b1dd0] patch_instructions+0x130/0x630
> [ 8638.893500] [c000000ea4cbfc10] [c000000000123180] bpf_arch_text_invalidate+0x80/0xd0
> [ 8638.893552] [c000000ea4cbfc60] [c0000000003a7508] bpf_prog_pack_free+0x138/0x2f0
> [ 8638.893584] [c000000ea4cbfd10] [c0000000003a7e38] bpf_jit_binary_pack_free+0x48/0xa0
> [ 8638.893617] [c000000ea4cbfd50] [c000000000123258] bpf_jit_free+0x88/0x100
> [ 8638.893667] [c000000ea4cbfd90] [c0000000003a9d70] bpf_prog_free_deferred+0x240/0x280
> [ 8638.893725] [c000000ea4cbfde0] [c0000000001a6828] process_scheduled_works+0x268/0x520
> [ 8638.893767] [c000000ea4cbfee0] [c0000000001a9ed0] worker_thread+0x3f0/0x590
> [ 8638.893809] [c000000ea4cbff80] [c0000000001b37b0] kthread+0x1a0/0x1c0
> [ 8638.893862] [c000000ea4cbffe0] [c00000000000d030] start_kernel_thread+0x14/0x18
> [ 8638.893913] Code: 3cc20157 3b63c4f8 3b45c500 3929c510 3b26c508 3940ffff e87b0000 e8ba0000
> 81290000 e8d90000 38830010 7d494830 <e87d00a8> 7ce42a14 7d2948f8 7d073214 
> [ 8638.894003] ---[ end trace 0000000000000000 ]---
> [ 8639.098185] pstore: backend (nvram) writing error (-1)
> [ 8639.098205] 
> [ 8639.098215] note: kworker/62:2[5591] exited with irqs disabled
> [ 8798.806603] ------------[ cut here ]------------
> [ 8798.806631] WARNING: CPU: 62 PID: 3769 at kernel/kthread.c:76 kthread_set_per_cpu+0x40/0xd0
> [ 8798.806653] Modules linked in: nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype
> br_netfilter xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle
> ip6table_nat iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv
> ------------------------------------------------------------------------------------------
> 
> We will look at this issue as it is specific to PowerPC.

This does look like a bug in BPF proper.

> But I can confirm that the originally reported hang (deadlock) is no longer present.

Great to hear. I'll post the patchset w/ your Tested-by.

Thanks.

-- 
tejun

