Return-Path: <linux-kernel+bounces-343407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D892989A99
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 08:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB1111F21C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 06:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480B4161313;
	Mon, 30 Sep 2024 06:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PbhyxVnW"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1C615688E
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 06:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727678270; cv=none; b=eI7hLgYENZ0rhDM718KF+0atWE9aQ3RGXmvUbEHRmbFT0mjKBSAwwXQsOgUDywKS9SMIdFFUwmUQD7AvNcKDWGVv9D8QvKipfv7plTMj+8yJezMMjSW8XoM3xZ4PUZ74zj2IkmrLWyLzbd7nPMW2wg4MzvetlB6eFhyMu4Rs4rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727678270; c=relaxed/simple;
	bh=g2JiBfYa3oTTTeoNnOlfQlEORqv4l+lUIxrqbk1Lg34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QiCHsF7a+RJgpwnkrRJjf3MW6+3FPAQwjSNgvQ70cDaLm03xDPUkmOUH0LQuvHhDRP6Vl26QasvS9uhM8R7A2RLkmXtf6IngmfFQDoW9I/aR8NCbJjzZUSa5dT01BfRhbxuiN6wBAa9Tx8INvwj5grlywYS9Twp6lb2ZZ0qJ4VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PbhyxVnW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U5DsWE000760;
	Mon, 30 Sep 2024 06:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=pp1; bh=u
	jtMeu0ZbHII13T4oqbcF5/gP28IDIncYHm5yLknalE=; b=PbhyxVnW6x6Eda+Dl
	46JtGWdMyYZc6eRQGceOQOFaZgTSgerkx0ZMTSecZ2KkL/LiqwYeDbLrWm47PHE1
	CaUgxzLwM+sHnvSM9Dlr5yE1P8VYfQZQNftNZe9h6sv+wsSeCMqL8h9TD3vXQvvo
	sU/LKIjEz2p/tkGzMSnI0hesKOzFxALzN5Gj17xl0sLbcet4GHnzSiMECNHoBL3L
	WVO8l5w/JKnDH/QJj8H2I3ZpPR/PFUBl9UswSKCv+LYz4Ml6Y73iRbERwJ/8j3rG
	KPeTAfDl/ujthuOQszuvShLsv7MO+JLJKDg5GTtEBwS8hHuGLLsD9/UEox02TgKl
	RQcMw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9ap84tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 06:37:43 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48U6bhqY006022;
	Mon, 30 Sep 2024 06:37:43 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41x9ap84tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 06:37:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48U3Zccq017845;
	Mon, 30 Sep 2024 06:37:41 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xw4mn16c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 06:37:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48U6bd7e58327400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 06:37:39 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B499A20043;
	Mon, 30 Sep 2024 06:37:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 34F2320040;
	Mon, 30 Sep 2024 06:37:38 +0000 (GMT)
Received: from [9.203.115.143] (unknown [9.203.115.143])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Sep 2024 06:37:38 +0000 (GMT)
Message-ID: <f637b90c-68c8-4913-bac8-075ba765a97c@linux.ibm.com>
Date: Mon, 30 Sep 2024 12:07:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU Hotplug
To: Song Liu <song@kernel.org>, Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>
References: <daf2370f5456cbf1660bbdc13621559fb3f2f6cc.camel@linux.ibm.com>
 <Zq1NksrG9blyN-KR@slm.duckdns.org>
 <e3069da05fb1676f8faad88b9a4dfc4a6cef4175.camel@linux.ibm.com>
 <Zru5_UmEmWhNaPyo@slm.duckdns.org>
 <fa56b39990dd0b90f971018f5abb7352c60af3b1.camel@linux.ibm.com>
 <ZsTwoWJQcnsJhYbe@slm.duckdns.org>
 <3da12c96daecaa055c478816f5e86c7b44a04d53.camel@linux.ibm.com>
 <ZszKI2GA-8yparh_@slm.duckdns.org> <Zul6l-S_JulEnDQw@mtj.duckdns.org>
 <516106abdf5c922ee19dffd9eb69ea3f9e20e54a.camel@linux.ibm.com>
 <ZvGxlcMwFOmUBfr9@slm.duckdns.org>
 <CAADnVQ+OYuaS9wYa2_aF8XFo7LcaSKbCeLwfC_z9j1Qe-eV3nw@mail.gmail.com>
 <ab72231540149a7dd367cbf30d17b12af14c6387.camel@linux.ibm.com>
 <CAPhsuW4-rkKVwWeOLhkK5gX5zO0FND+bB4vR4dbT7O1G=ZJajg@mail.gmail.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <CAPhsuW4-rkKVwWeOLhkK5gX5zO0FND+bB4vR4dbT7O1G=ZJajg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KDQkfbQlfyhy18q54wXca0m-yk50DtjF
X-Proofpoint-GUID: aqVb05QqhM7ZFSJnZuFyBCpJI-MOyLSU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-30_05,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=914 malwarescore=0 priorityscore=1501
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409300039



On 24/09/24 10:27 pm, Song Liu wrote:
> On Tue, Sep 24, 2024 at 5:00 AM Aboorva Devarajan
> <aboorvad@linux.ibm.com> wrote:
>>
>> On Tue, 2024-09-24 at 10:03 +0200, Alexei Starovoitov wrote:
>>> On Mon, Sep 23, 2024 at 8:21 PM Tejun Heo <tj@kernel.org> wrote:
>>>> Hello,
>>>>
>>>> (cc'ing Alexei and Andrii for the BPF part)
>>>>
>>>> On Mon, Sep 23, 2024 at 08:26:32PM +0530, Aboorva Devarajan wrote:
>>>>> Sharing the crash logs observed in PowerPC here for general reference, FYI:
>>>>>
>>>>> [ 8638.891964] Kernel attempted to read user page (a8) - exploit attempt? (uid: 0)
>>>>> [ 8638.892002] BUG: Kernel NULL pointer dereference on read at 0x000000a8
>>>>> [ 8638.892019] Faulting instruction address: 0xc0000000004e7cc0
>>>>> [ 8638.892038] Oops: Kernel access of bad area, sig: 11 [#1]
>>>>> [ 8638.892060] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA PowerNV
>>>>> [ 8638.892080] Modules linked in: nf_conntrack_netlink nfnetlink xfrm_user xfrm_algo xt_addrtype
>>>>> br_netfilter xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp
>>>>>   ip6table_mangle ip6table_nat iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
>>>>> nf_defrag_ipv4 ebtable_filter ebtables vhost_vsock vmw_vsock_virtio_transport_common ip6tabl
>>>>> e_filter ip6_tables vhost vhost_iotlb iptable_filter vsock bridge stp llc kvm_hv kvm joydev
>>>>> input_leds mac_hid at24 ofpart cmdlinepart uio_pdrv_genirq ibmpowernv opal_prd ipmi_powernv
>>>>> powernv_flash uio binfmt_misc sch_fq_codel nfsd mtd ipmi_devintf ipmi_msghandler auth_rpcgss
>>>>> jc42 ramoops reed_solomon ip_tables x_tables autofs4 raid10 raid456 async_raid6_recov async
>>>>> _memcpy async_pq async_xor async_tx raid1 raid0 dm_mirror dm_region_hash dm_log mlx5_ib ib_uverbs
>>>>> ib_core mlx5_core hid_generic usbhid hid ast i2c_algo_bit drm_shmem_helper drm_kms_hel
>>>>> per vmx_crypto drm mlxfw crct10dif_vpmsum crc32c_vpmsum psample tls tg3 ahci libahci
>>>>> drm_panel_orientation_quirks
>>>>> [ 8638.892621] CPU: 62 UID: 0 PID: 5591 Comm: kworker/62:2 Not tainted 6.11.0-rc4+ #2
>>>>> [ 8638.892663] Hardware name: 8335-GTW POWER9 0x4e1203 opal:skiboot-v6.5.3-35-g1851b2a06 PowerNV
>>>>> [ 8638.892693] Workqueue: events bpf_prog_free_deferred
>>>>> [ 8638.892735] NIP:  c0000000004e7cc0 LR: c0000000004e7bbc CTR: c0000000003a9b30
>>>>> [ 8638.892798] REGS: c000000ea4cbf7f0 TRAP: 0300   Not tainted  (6.11.0-rc4+)
>>>>> [ 8638.892862] MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 42a00284  XER: 00000000
>>>>> [ 8638.892915] CFAR: c0000000004e7bb8 DAR: 00000000000000a8 DSISR: 40000000 IRQMASK: 1
>>>>> [ 8638.892915] GPR00: c0000000004e7bbc c000000ea4cbfa90 c000000002837f00 0000000000000005
>>>>> [ 8638.892915] GPR04: 0000000000000015 0000000000000009 0000000000000009 c000000004840b00
>>>>> [ 8638.892915] GPR08: ffffffffffffffff 00000000ffffe000 ffffffffffffffff 000001937b55db50
>>>>> [ 8638.892915] GPR12: 0000000000200000 c000007ffdfac300 c0000000031b1fc8 0000000000010000
>>>>> [ 8638.892915] GPR16: c00000000000018e 000000007fffffff 0000000000000000 000000000000e1c0
>>>>> [ 8638.892915] GPR20: 61c8864680b583eb 0000000000000000 0000000000000000 00000000000de1d5
>>>>> [ 8638.892915] GPR24: 0000000000000000 c000000003da4408 c000000003da4400 c000000003da43f8
>>>>> [ 8638.892915] GPR24: 0000000000000000 c000000003da4408 c000000003da4400 c000000003da43f8
>>>>> [ 8638.892915] GPR28: 0000000000000000 0000000000000000 0000000000000000 c000000ea4cbfa90
>>>>> [ 8638.893350] NIP [c0000000004e7cc0] walk_to_pmd+0x80/0x240
> 
> With "BUG: Kernel NULL pointer dereference on read at 0x000000a8" (from above),
> it appears bpf_arch_text_invalidate() is racing with
> text_area_cpu_down_mm(), which
> sets cpu_patching_context.mm to NULL?
> 
> Am I going in the right direction?

Hi Song,

Yeah. That is the most plausible explanation for it.
I have just about started looking at this.
Will update if I find anything different..

Thanks
Hari



