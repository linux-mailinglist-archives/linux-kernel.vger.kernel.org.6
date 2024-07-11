Return-Path: <linux-kernel+bounces-249162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3E692E7EA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B30B29B33
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9959D15B103;
	Thu, 11 Jul 2024 12:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SplcpbIB"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3867156F2D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720699272; cv=none; b=YntB2CS7YTmQG0rBXeI37Iw6EK1fkY0n6bOmke+8J69MKXxKE/KRVs3LCfQCTswjSs+HZgPVIpW9MB9dg8/xiVwZCYZj2fBiWFqNGzRoXwiBf0HngLJUteYi4oLAWoFkVXYKBw3clnGuUux2746H17xiyMwHsL0DEd2ZcTDdDEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720699272; c=relaxed/simple;
	bh=G/wlzZX5bIBO3+E0boXg6kNl7vNqXRvZtNU+QFhWzhM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=ibY3ujH6AhRGky917tOt56rTbj+UuC6cydCWB3nelHo9gFRqrPknrEC7NotDilWkQhgQjRARGYv6yoX5p3zkza3o3P/A8Mfixsz3m1YxfWEgjCyabg45WHukkKkEQQa35+wQbItn013EOvw7cvIpDS8pq+8ddNYc1xyt5Bs4OsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SplcpbIB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46BBveCG016408;
	Thu, 11 Jul 2024 12:01:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:mime-version:content-transfer-encoding; s=pp1; bh=
	HufUV509GrHvLwzmT45gXzKhM9iPINJXRYCQRs3C5yQ=; b=SplcpbIB/M18wkLt
	osT/Xy7gOy23P3DFWNUxif9E2cHdc2k0o7KX/14tBDhd7VmpO3VnSVR9khcKFrtp
	mH/VNOJEIc8HIgfxz0aIOESVWJlD8FcdNzPXRktZ3jekK6SdRDpbBrlNpTif/qiX
	DypHxnPMfroX2F8hTVxttWDNNPjCfqm7MUB7glI5RoZn9FByZkMGLfupgtvqs2X6
	WW4r+8IPqxD15PdRJKe16PZwFuV7vDuuYd8Cq/m5Dt/xm7aGrJt4MBdWi5TlCkIr
	pciakHbxGO2oovy1zdmqsgwKmaprfzzTNlnZSo1SoRD6/gmtRaL6VGn12drQzvWN
	rHJwKw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40ab1s0k8x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 12:01:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46BBMOca024690;
	Thu, 11 Jul 2024 12:01:04 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 407g8ugu5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jul 2024 12:01:04 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46BC11D6590568
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 12:01:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BBF958076;
	Thu, 11 Jul 2024 12:01:01 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B548258065;
	Thu, 11 Jul 2024 12:00:59 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.ibm.com (unknown [9.204.200.131])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jul 2024 12:00:59 +0000 (GMT)
Message-ID: <dde4b09001da2641f9679b9409727e2147c5e9a6.camel@linux.ibm.com>
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU
 Hotplug
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Date: Thu, 11 Jul 2024 17:30:58 +0530
In-Reply-To: <Zo3PgETt43iFersn@slm.duckdns.org>
References: <8cd0ec0c4c7c1bc0119e61fbef0bee9d5e24022d.camel@linux.ibm.com>
	 <Zo3PgETt43iFersn@slm.duckdns.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tC9g06I2zXOQgB7pZc3YKOPEJGqFjF63
X-Proofpoint-ORIG-GUID: tC9g06I2zXOQgB7pZc3YKOPEJGqFjF63
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_08,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407110084

Hi Tejun,

On Tue, 2024-07-09 at 14:02 -1000, Tejun Heo wrote:

> Hello,
> 
> On Tue, Jul 09, 2024 at 01:21:38PM +0530, Aboorva Devarajan wrote:
> ...
> > Steps to reproduce the issue:
> > 
> > - Run the scx_simple scheduler.
> > - Randomly offline and online CPUs from 1 to 127.
> > 
> > During the CPU hotplug, the custom scheduler successfully
> > unregisters and registers itself without issues. However, it
> > occasionally encounters a crash and the system becomes unresponsive.
> 
> How reproducible is the problem?
> 
> 

This is highly transient and occurs approximately once in every 15-20 mins
when continuosly running CPU hotplug online and offline operations while
`scx_simple` scheduler is up and running.

> ...
> > [64650.801834] task:scx_simple      state:D stack:0     pid:11214 tgid:11214 ppid:11013  flags:0x00040080
> > [64650.801949] Sched_ext: simple (prepping)
> > [64650.801978] Call Trace:
> > [64650.802062] [c000000e9bdf35b0] [c0000000016f0c06] scx_dump_state.trunc_marker+0x2078/0x5d2a (unreliable)
> > [64650.802231] [c000000e9bdf3760] [c00000000001dd68] __switch_to+0x238/0x310
> > [64650.802437] [c000000e9bdf37c0] [c0000000013e6170] __schedule+0xa10/0xf80
> > [64650.802599] [c000000e9bdf38c0] [c0000000013e6764] schedule+0x84/0x128
> > [64650.802700] [c000000e9bdf38f0] [c00000000023f4dc] percpu_rwsem_wait+0x13c/0x1a0
> > [64650.802807] [c000000e9bdf3970] [c0000000013ee7ec] __percpu_down_read+0xac/0x21c
> > [64650.802926] [c000000e9bdf39f0] [c0000000001739b8] cpus_read_lock+0x158/0x180
> > [64650.803065] [c000000e9bdf3a30] [c00000000021fd88] bpf_scx_reg+0x5d8/0xb80
> > [64650.803161] [c000000e9bdf3c10] [c00000000049e308] bpf_struct_ops_link_create+0x158/0x200
> > [64650.803259] [c000000e9bdf3c80] [c000000000407628] link_create+0x78/0x3b0
> > [64650.803319] [c000000e9bdf3cd0] [c0000000004026fc] __sys_bpf+0x39c/0x560
> > [64650.803389] [c000000e9bdf3dc0] [c000000000400b00] sys_bpf+0x50/0x80
> > [64650.803449] [c000000e9bdf3e00] [c00000000003218c] system_call_exception+0x10c/0x2b0
> > [64650.803559] [c000000e9bdf3e50] [c00000000000c7d4] system_call_common+0xf4/0x258
> ...
> > [64650.808330] Showing all locks held in the system:
> > [64650.808391] 1 lock held by kthreadd/2:
> > [64650.808431]  #0: c0000000029259c8 (scx_fork_rwsem){++++}-{0:0}, at: sched_fork+0x80/0x240
> ...
> > [64650.810515] 4 locks held by scx_simple/11214:
> > [64650.810606]  #0: c000000002a609b0 (update_mutex){+.+.}-{4:4}, at: bpf_struct_ops_link_create+0x134/0x200
> > [64650.810781]  #1: c000000002927170 (scx_ops_enable_mutex){+.+.}-{4:4}, at: bpf_scx_reg+0x80/0xb80
> > [64650.810886]  #2: c0000000029259c8 (scx_fork_rwsem){++++}-{0:0}, at: bpf_scx_reg+0x5d0/0xb80
> > [64650.811023]  #3: c000000002913278 (cpu_hotplug_lock){++++}-{0:0}, at: bpf_scx_reg+0x5d8/0xb80
> > [64650.811174] 7 locks held by hotplug.sh/11440:
> > [64650.811240]  #0: c000000e9bfe6450 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0xcc/0x370
> > [64650.811362]  #1: c000000e11b31e90 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x10c/0x260
> > [64650.811514]  #2: c000000df2892620 (kn->active#73){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x118/0x260
> > [64650.811675]  #3: c000000002aebc08 (device_hotplug_lock){+.+.}-{4:4}, at: online_store+0x6c/0x1a0
> > [64650.811814]  #4: c000007ff4ce0128 (&dev->mutex){....}-{4:4}, at: online_store+0x94/0x1a0
> > [64650.811929]  #5: c000000002913168 (cpu_add_remove_lock){+.+.}-{4:4}, at: cpu_up+0xa4/0x1b0
> > [64650.812061]  #6: c000000002913278 (cpu_hotplug_lock){++++}-{0:0}, at: _cpu_up+0x78/0x420
> 
> It's difficult to tell from the log but I wonder whether the problem is CPU
> hotplug operation needing to fork to complete (e.g. maybe it needs to
> schedule a work item and flush it?) while sched_ext enable path first blocks
> forks through scx_fork_rwsem and then does cpus_read_lock(). That'd create
> ABBA deadlock. It's a bit tricky as the existing code already makes it
> impossible to flip the nesting order.

Yes, it looks like it could be a ABBA deadlock, but I'm not able to get enough
details with lockdep and lockstat enabled. I'll try to collect more traces and
investigate further.

> 
> It could also be specific to ppc64 (e.g. there's something dependingon fork
> during CPU hotplug), or at least doesn't happen on x86. I'll probe it a bit
> more.

Sure, so far I haven't been able to reproduce the issue on x86, also I'm running
some tests for a longer duration to see if it can be recreated on x86 as well
inorder to rule out the possiblity of it being a ppc64 specific issue, it could
be that the issue occurs much rarer on x86 when compared to ppc64.


Thanks,

Aboorva


