Return-Path: <linux-kernel+bounces-323434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AA9B973D3C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECDBB1F25ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C451A071C;
	Tue, 10 Sep 2024 16:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oqvXjnYj"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284BE199FAC
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985776; cv=none; b=h1dlORMTChx50FEHEUurN9KsxePA6+0U5k3uC4ZfPzR+YB499dIhvAUHOKUA+4Hj16Ou8V9YQcnH9UitSNLhl2OH2e/nXXIy3lfEiRQh6awBawfOBySHI+a0RuePY0x2jW72bReUzKEXHIOhjo2IXR90mXyGo8XU+nP2AzDvyUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985776; c=relaxed/simple;
	bh=yAzTCChRWHepAfBTZqZI0q/YC5kCW0kCmMOoLUO8LJ4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ej/KED51vDxXy7o/QfeH0RE7aVcN0n3F4wVI0rFXAJNFjVtrftnShYzfv9Nlt9N4NJcj8nHlRHiiB+1IY/sWBSsVQWMRR5Ia9wRJdPHAeANTT/JThIGlsjUYi9iQU3vHvnbPlKX8uDRUMuV0PVVyFqMwegB2ZOewACfbsZXheRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oqvXjnYj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48ABnmvY001259;
	Tue, 10 Sep 2024 16:29:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	vNAR03jtoduIOqDIPLQT9Mtmn//C/BgvAvQSljCuVDE=; b=oqvXjnYjAZ5Dyq4K
	+xc/ejkl5Qe/f3L8fyyLSSQQPi3WAkW0/zaFwC8el6rO7fgzFGWYALbDyiB5wzgp
	Zdj3deGurnZtkiRhmc4hrogFH4Jgomci8Br1fnOGOxU4p5fVT81yn3Lsxpl7JCX7
	tof9kbaEFxEl3FI1ZaSSQEsdOIstVjgVM/ywAdDa0lvIq65Bjmkdv9PIv2jvgNtY
	CoP1o8e09Fz26bHBI/FkTKKoSxd79KEvn7xKhIzYRwNHih7Ifk33SCDEWP0NbveK
	c0m3x44nr6NgKgC02WmdaODDEN5SiOWU0+I3Eb7EoLktXt7CMAfjsP87VXDj7XfF
	BnYRsw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejagq5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 16:29:24 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 48AGTNei028132;
	Tue, 10 Sep 2024 16:29:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41gejagq5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 16:29:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 48AGA362019853;
	Tue, 10 Sep 2024 16:29:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41h25pvdur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 16:29:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 48AGTI5857278868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Sep 2024 16:29:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95E6C20049;
	Tue, 10 Sep 2024 16:29:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 24B5920040;
	Tue, 10 Sep 2024 16:29:18 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.171.57.10])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 10 Sep 2024 16:29:18 +0000 (GMT)
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
In-Reply-To: <87wmjj971b.fsf@linux.ibm.com>
References: <20240621073225.3600-1-jiangshanlai@gmail.com>
 <20240621073225.3600-2-jiangshanlai@gmail.com>
 <87le1sjd2e.fsf@linux.ibm.com> <87wmjj971b.fsf@linux.ibm.com>
Date: Tue, 10 Sep 2024 18:29:17 +0200
Message-ID: <87tten8obm.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: XoDIUG8Z5zcjTO00GakZPX1TPLg5cbux
X-Proofpoint-GUID: qWiOhg0LsduWZ9t2UjuDnrD3tD3nlEKv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_04,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=941 spamscore=0 impostorscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409100119

On Tue, Sep 10, 2024 at 11:45 AM +0200, "Marc Hartmayer" <mhartmay@linux.ib=
m.com> wrote:
> On Tue, Jul 23, 2024 at 06:19 PM +0200, "Marc Hartmayer" <mhartmay@linux.=
ibm.com> wrote:
>> On Fri, Jun 21, 2024 at 03:32 PM +0800, Lai Jiangshan <jiangshanlai@gmai=
l.com> wrote:
>>> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>>>
>>> The code to kick off the destruction of workers is now in a process
>>> context (idle_cull_fn()), so kthread_stop() can be used in the process
>>> context to replace the work of pool->detach_completion.
>>>
>>> The wakeup in wake_dying_workers() is unneeded after this change, but it
>>> is harmless, jut keep it here until next patch renames wake_dying_worke=
rs()
>>> rather than renaming it again and again.
>>>
>>> Cc: Valentin Schneider <vschneid@redhat.com>
>>> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>>> ---
>>>  kernel/workqueue.c | 35 +++++++++++++++++++----------------
>>>  1 file changed, 19 insertions(+), 16 deletions(-)
>>>
>>

[=E2=80=A6snip=E2=80=A6]

Hi Lai,

I=E2=80=99ve reproduced the issue using the Linux commit bc83b4d1f086. Here=
 is
the =E2=80=9Cbeautified=E2=80=9D stacktrace (output of
`$LINUX/scripts/decode_stacktrace.sh vmlinux auto < dmesg.txt`).

...
[   14.271265] Unable to handle kernel pointer dereference in virtual kerne=
l address space
[   14.271314] Failing address: 0000000000000000 TEID: 0000000000000483
[   14.271317] Fault in home space mode while using kernel ASCE.
[   14.271320] AS:000000001df84007 R3:0000000064888007 S:0000000064887800 P=
:000000000000003d
[   14.271519] Oops: 0004 ilc:2 [#1] SMP
[   14.271570] Modules linked in: essiv authenc dm_crypt encrypted_keys loo=
p vmw_vsock_virtio_transport vmw_vsock_virtio_transport_common pkey vsock z=
crypt s390_trng rng_core ghash_s390 prng chacha_s390 libchacha virtio_conso=
le aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_=
s390 sha1_s390 sha_common vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel =
drm i2c_core drm_panel_orientation_quirks configfs autofs4
[   14.271661] CPU: 0 UID: 0 PID: 324 Comm: kworker/u10:2 Not tainted 6.11.=
0-20240909.rc7.git8.bc83b4d1f086.300.fc40.s390x+git #1
[   14.271667] Hardware name: IBM 8561 T01 701 (KVM/Linux)
[   14.271677] Workqueue: . 0x0 ()
[   14.271702] Krnl PSW : 0404c00180000000 000002d8c205ef28 worker_thread (=
./arch/s390/include/asm/atomic_ops.h:198 ./arch/s390/include/asm/spinlock.h=
:61 ./arch/s390/include/asm/spinlock.h:66 ./include/linux/spinlock.h:187 ./=
include/linux/spinlock_api_smp.h:120 kernel/workqueue.c:3346)
[   14.271728]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:0 PM:=
0 RI:0 EA:3
[   14.271730] Krnl GPRS: 00000000673f0000 0000000000000000 000002d80000000=
1 00000000673f0000
[   14.271732]            0000000000000000 00000000673f0000 0000000067ac5b4=
0 0000000000000002
[   14.271735]            0000000000000000 0000000000000028 000000000000000=
0 0000000067ac5b40
[   14.271736]            00000000673f0000 00000000673f0000 000002d8c205ef1=
8 00000258c22a7d88
[ 14.271752] Krnl Code: 000002d8c205ef1c: acfcf0c8 stnsm 200(%r15),252
objdump: '/tmp/tmp.yRzOQQynJL.o': No such file
objdump: '/tmp/tmp.yRzOQQynJL.o': No such file
All code
=3D=3D=3D=3D=3D=3D=3D=3D

Code starting with the faulting instruction
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
000002d8c205ef20: a7180000            lhi     %r1,0
#000002d8c205ef24: 582083ac            l       %r2,940(%r8)
>000002d8c205ef28: ba12a000            cs      %r1,%r2,0(%r10)
000002d8c205ef2c: a77400cf            brc     7,000002d8c205f0ca
000002d8c205ef30: 5800b078            l       %r0,120(%r11)
000002d8c205ef34: a7010002            tmll    %r0,2
000002d8c205ef38: a77400d4            brc     7,000002d8c205f0e0
[   14.271766] Call Trace:
[   14.271769] worker_thread (./arch/s390/include/asm/atomic_ops.h:198 ./ar=
ch/s390/include/asm/spinlock.h:61 ./arch/s390/include/asm/spinlock.h:66 ./i=
nclude/linux/spinlock.h:187 ./include/linux/spinlock_api_smp.h:120 kernel/w=
orkqueue.c:3346)
[   14.271774] worker_thread (./arch/s390/include/asm/lowcore.h:226 ./arch/=
s390/include/asm/spinlock.h:61 ./arch/s390/include/asm/spinlock.h:66 ./incl=
ude/linux/spinlock.h:187 ./include/linux/spinlock_api_smp.h:120 kernel/work=
queue.c:3346)
[   14.271777] kthread (kernel/kthread.c:389)
[   14.271781] __ret_from_fork (arch/s390/kernel/process.c:62)
[   14.271784] ret_from_fork (arch/s390/kernel/entry.S:309)
[   14.271806] Last Breaking-Event-Address:
[   14.271807] mutex_unlock (kernel/locking/mutex.c:549)

So it seems to me that `worker->pool` is NULL in the
`workqueue.c:worker_thread` function and this leads to the crash.

My next step is to try to bisect the bug.

--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

