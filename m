Return-Path: <linux-kernel+bounces-322819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E915A972ED3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 11:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15BD287410
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF740190497;
	Tue, 10 Sep 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JNd+7smx"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B621922DC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961523; cv=none; b=UHNW2n4dmkDvB3kI3EKufrPVnKF/+MkVhRmK1ujldSbXjZBcYshtdT+oU3bFZ08UvA5D8ROs+Z6TEAZdWS7xgxvTVqFMyimeaPJAbj8z04Nt8oOkYWn3mOsbqku6CDwVM68TaudINhbN1Yu8Jp0juPR9lFRG5EMl60cegZVpjek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961523; c=relaxed/simple;
	bh=KQynJSbqcsPzkNsKw6LYHLLBntvFRRqMx6cHPNsiDr0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JWUZcwgcBomYAwKIh3qxpvjk4V9Zzd5zn2e8opoIllXSLV4ybb07BBe/NvMYpJRJ7ObuQqRlNEQYd0i+82+433sDTuMYdY4KMOMCx2aHDDOZLvFKvAU+FTO1heztQKkhGC7GretmShtIv9UGU2BMK4f2+ZAxLFtCG2TtayHgLwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JNd+7smx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 489KexXV013563;
	Tue, 10 Sep 2024 09:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	dDBBgkRCd71SH7CP3lgvVYHuZhmyJIVbZsg3TbJ3nEU=; b=JNd+7smxnG0/Nha3
	V/tmiQ9Gf8odUykn7ubGtuPlfiqB4UAuURc5wVsKO4XH0x18uC45YxT/bjXguzFt
	ssi24jSQgXtHJcD2GGwoCr0qtTBRD3Fwx5LZaC2rpMcPIpA86oY03HeolCa18tPu
	09OeLwHHkLJueihZpYjRvd4dWXjvwo9WEwUe5OmJ+BDfyXNfmhScswIPYsonG0Qh
	M/egErBdZ0zpCC0MI5OR1pWBZ2icLPPM+eJgnxFrgx9KeRd9bzBw3sTdQ18O4pnu
	+F77MOhILu5bps7VDDuDRbG5SQD6FtFm8TVjB0yQ6JppyS/tugnokiG8rMPt0G9r
	VOgQcA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegwpqkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 09:45:12 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48A9bmdW029017;
	Tue, 10 Sep 2024 09:45:11 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gegwpqk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 09:45:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48A5ljQB013458;
	Tue, 10 Sep 2024 09:45:10 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41h3cm2hen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 09:45:10 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48A9j7me52429062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 09:45:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E803620043;
	Tue, 10 Sep 2024 09:45:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D2EA20040;
	Tue, 10 Sep 2024 09:45:06 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.171.57.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Sep 2024 09:45:06 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Valentin Schneider
 <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan
 <jiangshanlai@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven
 Schnelle <svens@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 1/4] workqueue: Reap workers via kthread_stop() and
 remove detach_completion
In-Reply-To: <87le1sjd2e.fsf@linux.ibm.com>
References: <20240621073225.3600-1-jiangshanlai@gmail.com>
 <20240621073225.3600-2-jiangshanlai@gmail.com>
 <87le1sjd2e.fsf@linux.ibm.com>
Date: Tue, 10 Sep 2024 11:45:04 +0200
Message-ID: <87wmjj971b.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bVWr4u4dJ9hMj8hPl1Y9FELw7bjk3aNT
X-Proofpoint-ORIG-GUID: lDYPUzm7aE5FjDYcvPe97YnNIuX6EPnZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_02,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100072

On Tue, Jul 23, 2024 at 06:19 PM +0200, "Marc Hartmayer" <mhartmay@linux.ib=
m.com> wrote:
> On Fri, Jun 21, 2024 at 03:32 PM +0800, Lai Jiangshan <jiangshanlai@gmail=
.com> wrote:
>> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>>
>> The code to kick off the destruction of workers is now in a process
>> context (idle_cull_fn()), so kthread_stop() can be used in the process
>> context to replace the work of pool->detach_completion.
>>
>> The wakeup in wake_dying_workers() is unneeded after this change, but it
>> is harmless, jut keep it here until next patch renames wake_dying_worker=
s()
>> rather than renaming it again and again.
>>
>> Cc: Valentin Schneider <vschneid@redhat.com>
>> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>> ---
>>  kernel/workqueue.c | 35 +++++++++++++++++++----------------
>>  1 file changed, 19 insertions(+), 16 deletions(-)
>>
>

Hi Lai,

I=E2=80=99m not sure if this NULL-pointer crash is related to this patch se=
ries
or not. But it is triggered by the same test that also triggered the
other problem that I reported.

        [   23.133876] Unable to handle kernel pointer dereference in virtu=
al kernel address space
        [   23.133950] Failing address: 0000000000000000 TEID: 000000000000=
0483
        [   23.133954] Fault in home space mode while using kernel ASCE.
        [   23.133957] AS:000000001b8f0007 R3:0000000056cf4007 S:0000000056=
cf3800 P:000000000000003d=20
        [   23.134207] Oops: 0004 ilc:2 [#1] SMP=20
        [   23.134273] Modules linked in: essiv authenc dm_crypt encrypted_=
keys loop pkey zcrypt s390_trng rng_core ghash_s390 prng chacha_s390 libcha=
cha aes_s390 des_s390 virtio_console libdes vmw_vsock_virtio_transport vmw_=
vsock_virtio_transport_common sha3_512_s390 vsock sha3_256_s390 sha512_s390=
 sha256_s390 sha1_s390 sha_common vfio_ccw mdev vfio_iommu_type1 vfio sch_f=
q_codel drm i2c_core drm_panel_orientation_quirks configfs autofs4
        [   23.134386] CPU: 0 UID: 0 PID: 376 Comm: kworker/u10:2 Not taint=
ed 6.11.0-20240902.rc6.git1.67784a74e258.300.fc40.s390x+git #1
        [   23.134394] Hardware name: IBM 8561 T01 703 (KVM/Linux)
        [   23.134406] Workqueue:  0x0 ()
        [   23.134440] Krnl PSW : 0404c00180000000 0000024e326caf28 (worker=
_thread+0x48/0x430)
        [   23.134471]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 =
CC:0 PM:0 RI:0 EA:3
        [   23.134474] Krnl GPRS: 0000000058778000 0000000000000000 0000024=
e00000001 0000000058778000
        [   23.134476]            0000000000000000 0000000058778000 0000000=
057b8e240 0000000000000002
        [   23.134480]            0000000000000000 0000000000000028 0000000=
000000000 0000000057b8e240
        [   23.134481]            0000000058778000 0000000058778000 0000024=
e326caf18 000001ce32953d88
        [   23.134499] Krnl Code: 0000024e326caf1c: acfcf0c8		stnsm	200(%r1=
5),252
        [   23.134499]            0000024e326caf20: a7180000		lhi	%r1,0
        [   23.134499]           #0000024e326caf24: 582083ac		l	%r2,940(%r8)
        [   23.134499]           >0000024e326caf28: ba12a000		cs	%r1,%r2,0(=
%r10)
        [   23.134499]            0000024e326caf2c: a77400cf		brc	7,0000024=
e326cb0ca
        [   23.134499]            0000024e326caf30: 5800b078		l	%r0,120(%r1=
1)
        [   23.134499]            0000024e326caf34: a7010002		tmll	%r0,2
        [   23.134499]            0000024e326caf38: a77400d4		brc	7,0000024=
e326cb0e0
        [   23.134516] Call Trace:
        [   23.134520]  [<0000024e326caf28>] worker_thread+0x48/0x430=20
        [   23.134525] ([<0000024e326caf18>] worker_thread+0x38/0x430)
        [   23.134528]  [<0000024e326d3a3e>] kthread+0x11e/0x130=20
        [   23.134533]  [<0000024e3264b0dc>] __ret_from_fork+0x3c/0x60=20
        [   23.134536]  [<0000024e333fb37a>] ret_from_fork+0xa/0x38=20
        [   23.134552] Last Breaking-Event-Address:
        [   23.134553]  [<0000024e333f4c04>] mutex_unlock+0x24/0x30
        [   23.134562] Kernel panic - not syncing: Fatal exception: panic_o=
n_oops

This happened with Linux
6.11.0-20240902.rc6.git1.67784a74e258.300.fc40.s390x (using defconfig),
but also with an older commit
6.11.0-20240719.rc0.git15.720261cfc732.300.fc40.s390x on s390x (both
kernels contain your patches). I have not bisected/debugged the
problem yet, but you may have an idea already. Will try to reproduce the
problem and give you more debug information.

Thanks!

[=E2=80=A6snip]

--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

