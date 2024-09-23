Return-Path: <linux-kernel+bounces-335982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA8297ED80
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E6F21F21C5E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A4419922E;
	Mon, 23 Sep 2024 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lvrq3og6"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7136EB64
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727103404; cv=none; b=lLCmqi6WVnNZ6HZ2yrtfGAmfb9FmQ3/5Kk/HXopPa5gclFVfXTv2hdHscVEWJgNBjPkOL8w2zCBmdoRuCdIH63le4kRPiEvO8vVTUpenE56nxIrZnibWcmBKj1yRziVhxxK1gWxpdya8XHLmW9goq77iQ1O0ZZ9Ue9QZ8ajn7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727103404; c=relaxed/simple;
	bh=e22mNRillFBW32mztpvK1diPoQjV90XAmUjZurDugUk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C+OwP5FQQ5+0vzr1G0RahivCRhXsskB8jFznJFdvo+qWMzgYUQ84HckT3c24Qh0CbvFy6d49ZY3ByRflvMDTBvQSP9aq8Hg63+lJFswdPwTn5kTXzX+i/mJ7iGnWH7V1byDfnn2bXXo5dg8E3rNsFYB2Q6t0tGQqY0sFlUO1WQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lvrq3og6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N0sTZS001815;
	Mon, 23 Sep 2024 14:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	V1tf7BgoiLGC62QzBmmrzaJMJOmh0Dy4BIG91+gmD34=; b=Lvrq3og6znaOR7HB
	l/1ouu73YvbpltXIOPYd1IKgFaJGQwWk3UGEAb0odvyiSJL0TYI9KfRENAksWUJR
	ewXpkQ3T56/9jg24h9056wsN5Z+xG/+gI8/JMyL4QF2bbWWcgVRJAXG1THF5TVS8
	nVy0uhCzPeSnTXMLkGxBouy8QDxZ8Qp2jeHedOiHBycL3HU/Vwq8D0KLpbK1O5UL
	dC77TVcDrPaezDPtkcXHyvIO5Gcivohvez/jl/T6Xw6bJd1alBQmUPhLzJZ9Ft/p
	8+wTt1L3jfwfF+M81b/NOzAsJ3B3s9MKLji+lrdCBg7flk+UVzBk7EaldSeiEt3+
	BAkGng==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41snvavnt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 14:56:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48NCba18020844;
	Mon, 23 Sep 2024 14:56:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41tb62xrj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 14:56:36 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48NEuZkX46268872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Sep 2024 14:56:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EC5158043;
	Mon, 23 Sep 2024 14:56:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1828558063;
	Mon, 23 Sep 2024 14:56:34 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.179.21.109])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 23 Sep 2024 14:56:33 +0000 (GMT)
Message-ID: <516106abdf5c922ee19dffd9eb69ea3f9e20e54a.camel@linux.ibm.com>
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU
 Hotplug
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Date: Mon, 23 Sep 2024 20:26:32 +0530
In-Reply-To: <Zul6l-S_JulEnDQw@mtj.duckdns.org>
References: <Zo3PgETt43iFersn@slm.duckdns.org>
	 <dde4b09001da2641f9679b9409727e2147c5e9a6.camel@linux.ibm.com>
	 <daf2370f5456cbf1660bbdc13621559fb3f2f6cc.camel@linux.ibm.com>
	 <Zq1NksrG9blyN-KR@slm.duckdns.org>
	 <e3069da05fb1676f8faad88b9a4dfc4a6cef4175.camel@linux.ibm.com>
	 <Zru5_UmEmWhNaPyo@slm.duckdns.org>
	 <fa56b39990dd0b90f971018f5abb7352c60af3b1.camel@linux.ibm.com>
	 <ZsTwoWJQcnsJhYbe@slm.duckdns.org>
	 <3da12c96daecaa055c478816f5e86c7b44a04d53.camel@linux.ibm.com>
	 <ZszKI2GA-8yparh_@slm.duckdns.org> <Zul6l-S_JulEnDQw@mtj.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-26.el8_10) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: O20UId6MD7qWEPQZXoc26Mr_u2ufIlIl
X-Proofpoint-GUID: O20UId6MD7qWEPQZXoc26Mr_u2ufIlIl
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-23_11,2024-09-23_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 clxscore=1011 spamscore=0 mlxscore=0
 adultscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230109

On Tue, 2024-09-17 at 14:48 +0200, Tejun Heo wrote:
> Hello, Aboorva.
> 
> On Mon, Aug 26, 2024 at 08:32:03AM -1000, Tejun Heo wrote:
> > On Fri, Aug 23, 2024 at 02:50:01PM +0530, Aboorva Devarajan wrote:
> > ...
> > > I applied this patch to the almost latest sched-ext (for-6.12) branch upto
> > > commit 89909296a51e792 ("sched_ext: Don't use double locking to migrate
> > > tasks across CPUs") and let the test run for over 20 hours, and it completed
> > > without any hangs on both x86 and PowerPC.
> > > 
> > > So, indeed, making sure that both scx_fork_rwsem and cpu_hotplug_lock (read)
> > > are only held together simulataneously when they can both be acquired seems
> > > to be resolving the deadlock.
> > 
> > Thanks a lot for confirming. Let me think it over a bit re. what should be
> > applied.
> 
> Sorry about the delay. It ended up a bit invasive and took longer. Can you
> please verify the following branch fixes the problem?
> 
>  https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-enable-locking-fix
> 
> Thanks.
> 

Hi Tejun,

I've run CPU hotplug tests and verified that with the above specified branch on both
Power10 and x86 the originally reported hang is no longer seen.

------------------------------------------------------------------------------------------
On x86: 

https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-enable-locking-fix

Upto - a3b4678ca086 ("sched_ext: Decouple locks in scx_ops_enable()")

I kept the tests running for over 48 hours, and I didn't encounter any hangs or lockups.
------------------------------------------------------------------------------------------

On Power10:

https://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git scx-enable-locking-fix

Upto - a3b4678ca086 ("sched_ext: Decouple locks in scx_ops_enable()") +
Patches to support struct_ops on PowerPC

After running the tests for over 4 hours, I didn’t observe the original issue, but I hit
another crash, which seems specific to PowerPC which is related to instruction patching.
However, the originally reported hang appears to be resolved.
------------------------------------------------------------------------------------------

Sharing the crash logs observed in PowerPC here for general reference, FYI:


[ 8638.891964] Kernel attempted to read user page (a8) - exploit attempt? (uid: 0)
[ 8638.892002] BUG: Kernel NULL pointer dereference on read at 0x000000a8
[ 8638.892019] Faulting instruction address: 0xc0000000004e7cc0
[ 8638.892038] Oops: Kernel access of bad area, sig: 11 [#1]
[ 8638.892060] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
[ 8638.892080] Modules linked in: nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype
br_netfilter xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp
 ip6table_mangle ip6table_nat iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 ebtable_filter ebtables vhost_vsock vmw_vsock_virtio_transport_common ip6tabl
e_filter ip6_tables vhost vhost_iotlb iptable_filter vsock bridge stp llc kvm_hv kvm joydev
input_leds mac_hid at24 ofpart cmdlinepart uio_pdrv_genirq ibmpowernv opal_prd ipmi_powernv 
powernv_flash uio binfmt_misc sch_fq_codel nfsd mtd ipmi_devintf ipmi_msghandler auth_rpcgss
jc42 ramoops reed_solomon ip_tables x_tables autofs4 raid10 raid456 async_raid6_recov async
_memcpy async_pq async_xor async_tx raid1 raid0 dm_mirror dm_region_hash dm_log mlx5_ib ib_uverbs
ib_core mlx5_core hid_generic usbhid hid ast i2c_algo_bit drm_shmem_helper drm_kms_hel
per vmx_crypto drm mlxfw crct10dif_vpmsum crc32c_vpmsum psample tls tg3 ahci libahci
drm_panel_orientation_quirks
[ 8638.892621] CPU: 62 UID: 0 PID: 5591 Comm: kworker/62:2 Not tainted 6.11.0-rc4+ #2
[ 8638.892663] Hardware name: 8335-GTW POWER9 0x4e1203 opal:skiboot-v6.5.3-35-g1851b2a06 PowerNV
[ 8638.892693] Workqueue: events bpf_prog_free_deferred
[ 8638.892735] NIP:  c0000000004e7cc0 LR: c0000000004e7bbc CTR: c0000000003a9b30
[ 8638.892798] REGS: c000000ea4cbf7f0 TRAP: 0300   Not tainted  (6.11.0-rc4+)
[ 8638.892862] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 42a00284  XER: 00000000
[ 8638.892915] CFAR: c0000000004e7bb8 DAR: 00000000000000a8 DSISR: 40000000 IRQMASK: 1 
[ 8638.892915] GPR00: c0000000004e7bbc c000000ea4cbfa90 c000000002837f00 0000000000000005 
[ 8638.892915] GPR04: 0000000000000015 0000000000000009 0000000000000009 c000000004840b00 
[ 8638.892915] GPR08: ffffffffffffffff 00000000ffffe000 ffffffffffffffff 000001937b55db50 
[ 8638.892915] GPR12: 0000000000200000 c000007ffdfac300 c0000000031b1fc8 0000000000010000 
[ 8638.892915] GPR16: c00000000000018e 000000007fffffff 0000000000000000 000000000000e1c0 
[ 8638.892915] GPR20: 61c8864680b583eb 0000000000000000 0000000000000000 00000000000de1d5 
[ 8638.892915] GPR24: 0000000000000000 c000000003da4408 c000000003da4400 c000000003da43f8 
[ 8638.892915] GPR24: 0000000000000000 c000000003da4408 c000000003da4400 c000000003da43f8 
[ 8638.892915] GPR28: 0000000000000000 0000000000000000 0000000000000000 c000000ea4cbfa90 
[ 8638.893350] NIP [c0000000004e7cc0] walk_to_pmd+0x80/0x240
[ 8638.893380] LR [c0000000004e7bbc] __get_locked_pte+0x4c/0xd0
[ 8638.893398] Call Trace:
[ 8638.893407] [c000000ea4cbfa90] [c000000ea4cbfb20] 0xc000000ea4cbfb20 (unreliable)
[ 8638.893429] [c000000ea4cbfaf0] [c0000000004e7bbc] __get_locked_pte+0x4c/0xd0
[ 8638.893457] [c000000ea4cbfb40] [c0000000000b1dd0] patch_instructions+0x130/0x630
[ 8638.893500] [c000000ea4cbfc10] [c000000000123180] bpf_arch_text_invalidate+0x80/0xd0
[ 8638.893552] [c000000ea4cbfc60] [c0000000003a7508] bpf_prog_pack_free+0x138/0x2f0
[ 8638.893584] [c000000ea4cbfd10] [c0000000003a7e38] bpf_jit_binary_pack_free+0x48/0xa0
[ 8638.893617] [c000000ea4cbfd50] [c000000000123258] bpf_jit_free+0x88/0x100
[ 8638.893667] [c000000ea4cbfd90] [c0000000003a9d70] bpf_prog_free_deferred+0x240/0x280
[ 8638.893725] [c000000ea4cbfde0] [c0000000001a6828] process_scheduled_works+0x268/0x520
[ 8638.893767] [c000000ea4cbfee0] [c0000000001a9ed0] worker_thread+0x3f0/0x590
[ 8638.893809] [c000000ea4cbff80] [c0000000001b37b0] kthread+0x1a0/0x1c0
[ 8638.893862] [c000000ea4cbffe0] [c00000000000d030] start_kernel_thread+0x14/0x18
[ 8638.893913] Code: 3cc20157 3b63c4f8 3b45c500 3929c510 3b26c508 3940ffff e87b0000 e8ba0000
81290000 e8d90000 38830010 7d494830 <e87d00a8> 7ce42a14 7d2948f8 7d073214 
[ 8638.894003] ---[ end trace 0000000000000000 ]---
[ 8639.098185] pstore: backend (nvram) writing error (-1)
[ 8639.098205] 
[ 8639.098215] note: kworker/62:2[5591] exited with irqs disabled
[ 8798.806603] ------------[ cut here ]------------
[ 8798.806631] WARNING: CPU: 62 PID: 3769 at kernel/kthread.c:76 kthread_set_per_cpu+0x40/0xd0
[ 8798.806653] Modules linked in: nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype
br_netfilter xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp ip6table_mangle
ip6table_nat iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv
------------------------------------------------------------------------------------------

We will look at this issue as it is specific to PowerPC.

But I can confirm that the originally reported hang (deadlock) is no longer present.

Thanks much,
Aboorva


