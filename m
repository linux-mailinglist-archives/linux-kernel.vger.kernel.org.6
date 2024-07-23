Return-Path: <linux-kernel+bounces-260182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE5593A438
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 18:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5462841CB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 16:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C704157485;
	Tue, 23 Jul 2024 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vsa8u4XJ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476C14D2B8
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 16:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721751604; cv=none; b=u6H9NBbAIjaINJ2YhkJG9czWE9otvOA56ayoVTTiKRUnXTHsaGehS8iKGExP6M1XSB/lpXY9Ins28/xUjzWtA+e4F6EoUORhsK28OsfjbvxhvU7b9BxHMnHWQSvZ6r3xFh3B52OiaJM0QQc1Fk11FOws4wxlWZsMmk6l31pL+bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721751604; c=relaxed/simple;
	bh=j0Om7Iwyr0jtBUoGsG2ZJ5lhUOG0vlu6UA0/nMqqMS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s8KPReZ90ynNwp3UbwAOCXYOF3RqG1UWFpPqzoeo/yCDAPo466JodvAZlg1JUTTykSU4qcxPUySYtkwoMW6JwcrGhrWiCSAO8nlpyhOF5NKk2HVKFXLNUDgcMuxSDSRc6OrZUJ+mJSVrKsjaYYgwVuw8+KI+pAx8boiN2Phx5H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vsa8u4XJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NEebqj024230;
	Tue, 23 Jul 2024 16:19:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:in-reply-to:references:date:message-id
	:mime-version:content-type:content-transfer-encoding; s=pp1; bh=
	ERWbV7ZI9gnr9gpoNZpVV82sbV1YXHif1uE3Pm1Dk/o=; b=Vsa8u4XJ6rOq1Yws
	dZJ4gYXDgyYQnSMgE2KqOZSGS7T2lQrjB9Gz4l2gbXW7T+M1q0sNm7IxI10M04UQ
	T5gkwXZIXqnWMjpg6BM9f/koctSTneLhYxsfqgZXaiM0ss19yy4J9JXyAZ1uPTMf
	caCXaHaLLC3f39uO/sytXj6eGgvalB+tTYVQF/+NMrffdA1cObUNvsnOlEzT52Vi
	+xeCqS4zghBHMy+en70oHhcNSNkYE6sFYVBKlpfL3DnnmpsBLqQyKtlIoGq7e8fX
	pH5bYjEH+4IwHN6v5m1o/4nfg1ZQZJG7hDN/Aer5D1lObdMBkm1kV1dY72H82Kqr
	MLrljg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40jb7xrs2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 16:19:46 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46NGJjo9031898;
	Tue, 23 Jul 2024 16:19:45 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40jb7xrs2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 16:19:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46NDf1hM009144;
	Tue, 23 Jul 2024 16:19:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40gt93c42p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 16:19:44 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46NGJdNF38928872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 16:19:41 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 487042004B;
	Tue, 23 Jul 2024 16:19:39 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2DB120040;
	Tue, 23 Jul 2024 16:19:38 +0000 (GMT)
Received: from li-1de7cd4c-3205-11b2-a85c-d27f97db1fe1.ibm.com (unknown [9.171.91.49])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 23 Jul 2024 16:19:38 +0000 (GMT)
From: "Marc Hartmayer" <mhartmay@linux.ibm.com>
To: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Valentin Schneider
 <vschneid@redhat.com>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan
 <jiangshanlai@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sven
 Schnelle <svens@linux.ibm.com>, Mete Durlu <meted@linux.ibm.com>
Subject: Re: [PATCH 1/4] workqueue: Reap workers via kthread_stop() and
 remove detach_completion
In-Reply-To: <20240621073225.3600-2-jiangshanlai@gmail.com>
References: <20240621073225.3600-1-jiangshanlai@gmail.com>
 <20240621073225.3600-2-jiangshanlai@gmail.com>
Date: Tue, 23 Jul 2024 18:19:37 +0200
Message-ID: <87le1sjd2e.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CGEEuQDQ8ijtMOSJ4ktUqUj_LsET6IT-
X-Proofpoint-ORIG-GUID: XQb55aRPfUE0VUVLUsCjmyOc_Eunkl99
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_05,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1011 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407230111

On Fri, Jun 21, 2024 at 03:32 PM +0800, Lai Jiangshan <jiangshanlai@gmail.c=
om> wrote:
> From: Lai Jiangshan <jiangshan.ljs@antgroup.com>
>
> The code to kick off the destruction of workers is now in a process
> context (idle_cull_fn()), so kthread_stop() can be used in the process
> context to replace the work of pool->detach_completion.
>
> The wakeup in wake_dying_workers() is unneeded after this change, but it
> is harmless, jut keep it here until next patch renames wake_dying_workers=
()
> rather than renaming it again and again.
>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
> ---
>  kernel/workqueue.c | 35 +++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
>

Hi Lai,

a bisect of a regression in our CI on s390x led to this patch. The bug
is pretty easy to reproduce (currently, I only tested it on s390x - will
try to test it on x86 as well):

1. Start a Linux QEMU/KVM guest with 2 cores using this patch and enable
   `panic_on_warn=3D1` for the guest kernel.
2. Run the following command in the KVM guest:

  $  dd if=3D/dev/zero of=3D/dev/null & while : ; do chcpu -d 1; chcpu -e 1=
; done

3. Wait for the crash. e.g.:

2024/07/23 18:01:21 [M83LP63]: [  157.267727] ------------[ cut here ]-----=
-------
2024/07/23 18:01:21 [M83LP63]: [  157.267735] WARNING: CPU: 21 PID: 725 at =
kernel/workqueue.c:3340 worker_thread+0x54e/0x558
2024/07/23 18:01:21 [M83LP63]: [  157.267746] Modules linked in: binfmt_mis=
c nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_=
ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_=
defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables sunrpc dm_service_time s390_trn=
g vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel
2024/07/23 18:01:21 [M83LP63]: loop dm_multipath configfs nfnetlink lcs ctc=
m fsm zfcp scsi_transport_fc ghash_s390 prng chacha_s390 libchacha aes_s390=
 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s=
390 sha_common scm_block eadm_sch scsi_dh_rdac scsi_dh_emc scsi_dh_alua pke=
y zcrypt rng_core autofs4
2024/07/23 18:01:21 [M83LP63]: [  157.267792] CPU: 21 PID: 725 Comm: kworke=
r/dying Not tainted 6.10.0-rc2-00239-g68f83057b913 #95
2024/07/23 18:01:21 [M83LP63]: [  157.267796] Hardware name: IBM 3906 M04 7=
04 (LPAR)
2024/07/23 18:01:21 [M83LP63]: [  157.267802]            R:0 T:1 IO:1 EX:1 =
Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
2024/07/23 18:01:21 [M83LP63]: [  157.267797] Krnl PSW : 0704d00180000000 0=
00003d600fcd9fa (worker_thread+0x552/0x558)
2024/07/23 18:01:21 [M83LP63]: [  157.267806] Krnl GPRS: 6479696e6700776f 0=
00002c901b62780 000003d602493ec8 000002c914954600
2024/07/23 18:01:21 [M83LP63]: [  157.267809]            0000000000000000 0=
000000000000008 000002c901a85400 000002c90719e840
2024/07/23 18:01:21 [M83LP63]: [  157.267811]            000002c90719e880 0=
00002c901a85420 000002c91127adf0 000002c901a85400
2024/07/23 18:01:21 [M83LP63]: [  157.267813]            000002c914954600 0=
000000000000000 000003d600fcd772 000003560452bd98
2024/07/23 18:01:21 [M83LP63]: [  157.267822] Krnl Code: 000003d600fcd9ec: =
c0e500674262        brasl   %r14,000003d601cb5eb0
2024/07/23 18:01:21 [M83LP63]: [  157.267822]            000003d600fcd9f2: =
a7f4ffc8            brc     15,000003d600fcd982
2024/07/23 18:01:21 [M83LP63]: [  157.267822]           #000003d600fcd9f6: =
af000000            mc      0,0
2024/07/23 18:01:21 [M83LP63]: [  157.267822]           >000003d600fcd9fa: =
a7f4fec2            brc     15,000003d600fcd77e
2024/07/23 18:01:21 [M83LP63]: [  157.267822]            000003d600fcd9fe: =
0707                bcr     0,%r7
2024/07/23 18:01:21 [M83LP63]: [  157.267822]            000003d600fcda00: =
c00400682e10        brcl    0,000003d601cd3620
2024/07/23 18:01:21 [M83LP63]: [  157.267822]            000003d600fcda06: =
eb7ff0500024        stmg    %r7,%r15,80(%r15)
2024/07/23 18:01:21 [M83LP63]: [  157.267822]            000003d600fcda0c: =
b90400ef            lgr     %r14,%r15
2024/07/23 18:01:21 [M83LP63]: [  157.267853] Call Trace:
2024/07/23 18:01:21 [M83LP63]: [  157.267855]  [<000003d600fcd9fa>] worker_=
thread+0x552/0x558
2024/07/23 18:01:21 [M83LP63]: [  157.267859] ([<000003d600fcd772>] worker_=
thread+0x2ca/0x558)
2024/07/23 18:01:21 [M83LP63]: [  157.267862]  [<000003d600fd6c80>] kthread=
+0x120/0x128
2024/07/23 18:01:21 [M83LP63]: [  157.267865]  [<000003d600f5305c>] __ret_f=
rom_fork+0x3c/0x58
2024/07/23 18:01:21 [M83LP63]: [  157.267868]  [<000003d601cc746a>] ret_fro=
m_fork+0xa/0x30
2024/07/23 18:01:21 [M83LP63]: [  157.267873] Last Breaking-Event-Address:
2024/07/23 18:01:21 [M83LP63]: [  157.267874]  [<000003d600fcd778>] worker_=
thread+0x2d0/0x558
2024/07/23 18:01:21 [M83LP63]: [  157.267879] Kernel panic - not syncing: k=
ernel: panic_on_warn set ...
2024/07/23 18:01:22 [M83LP63]: [  157.267881] CPU: 21 PID: 725 Comm: kworke=
r/dying Not tainted 6.10.0-rc2-00239-g68f83057b913 #95
2024/07/23 18:01:22 [M83LP63]: [  157.267884] Hardware name: IBM 3906 M04 7=
04 (LPAR)
2024/07/23 18:01:22 [M83LP63]: [  157.267885] Call Trace:
2024/07/23 18:01:22 [M83LP63]: [  157.267886]  [<000003d600fa7f8c>] panic+0=
x1ec/0x308
2024/07/23 18:01:22 [M83LP63]: [  157.267892]  [<000003d600fa822c>] check_p=
anic_on_warn+0x84/0x88
2024/07/23 18:01:22 [M83LP63]: [  157.267896]  [<000003d600fa846e>] __warn+=
0xa6/0x160
2024/07/23 18:01:22 [M83LP63]: [  157.267899]  [<000003d601c8ac7e>] report_=
bug+0x146/0x1c0
2024/07/23 18:01:22 [M83LP63]: [  157.267903]  [<000003d600f50e64>] monitor=
_event_exception+0x44/0x80
2024/07/23 18:01:22 [M83LP63]: [  157.267905]  [<000003d601cb67e0>] __do_pg=
m_check+0xf0/0x1b0
2024/07/23 18:01:22 [M83LP63]: [  157.267911]  [<000003d601cc75a8>] pgm_che=
ck_handler+0x118/0x168
2024/07/23 18:01:22 [M83LP63]: [  157.267914]  [<000003d600fcd9fa>] worker_=
thread+0x552/0x558
2024/07/23 18:01:22 [M83LP63]: [  157.267917] ([<000003d600fcd772>] worker_=
thread+0x2ca/0x558)
2024/07/23 18:01:22 [M83LP63]: [  157.267920]  [<000003d600fd6c80>] kthread=
+0x120/0x128
2024/07/23 18:01:22 [M83LP63]: [  157.267923]  [<000003d600f5305c>] __ret_f=
rom_fork+0x3c/0x58
2024/07/23 18:01:22 [M83LP63]: [  157.267926]  [<000003d601cc746a>] ret_fro=
m_fork+0xa/0x30

--=20
Kind regards / Beste Gr=C3=BC=C3=9Fe
   Marc Hartmayer

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294

