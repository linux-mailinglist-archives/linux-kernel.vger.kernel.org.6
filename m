Return-Path: <linux-kernel+bounces-261623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D764A93BA02
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30E06B2336F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 01:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10434A32;
	Thu, 25 Jul 2024 01:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcaHsU/a"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453C1C3E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721869313; cv=none; b=kXuOr8L3QAJde5I9wgeoBZW6iggvy/Rlyyi1QoiQvQmOqihIEK7IECURFDvk3CewPq6mf5Lt+79fZy/IIGRxafGLpff2DwUvGy90yTkYrfh/vDachiuINcpeS4n1/ZzLykeqWyqBxR/ZiyfKV/9XqGtx0Ols08iwjguneu3jgYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721869313; c=relaxed/simple;
	bh=hFS+W8khqHTXO0CMtsMhbtokvf98zGhGiHEnER6UThc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CPFaFFpp9SnjH97V9FydMy54VId6lmzehmnGqBz2AmcvYuH68RMcFbfcvGCJzl93FkgQG9exdCLvmYvasA/Te6kEAWaXHM1/VTPQtMo/h7uEFzXyrI4RaTHdvE8Nt4grSL/CIqraGs+3ADq/ktKvWzjGCYt36FY9mh+SM2WvUVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UcaHsU/a; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fec34f94abso3188765ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 18:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721869310; x=1722474110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E4RjwlCvzoXUDWYNqJm76qtMzZ9IDh4kI0fyUWm82TY=;
        b=UcaHsU/asjesYF2n0vNfqr2Rek9TPPdJRoAlCjKcXsIOfzSZYKVuogKKzsnaZlDO8N
         fuBVXwhC6JdFW/WuMXQKZi9IYEjG+XnxLt8ilApbiTk3r8xJlK72FlFVW+LEopGwg/kn
         dlb5f1vnevycfCqtKyQrGEgLpiTQncEQR4eCd977NYBKYc7ln7zU3WqdpLYGZT7HpwBp
         mfNE5vsMfqT8eOCYnEHi+d+PllBtiadik4J64p3xiuUlbau7xPEmnsZXwOfK6idgnfXi
         d4I4xjlxFHHwY1gMqggyHL48fyI8qHxCVG7jyfF++AoGPni6Kqjo3F8jA8sWVrGoYDKe
         TXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721869310; x=1722474110;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E4RjwlCvzoXUDWYNqJm76qtMzZ9IDh4kI0fyUWm82TY=;
        b=b+yeitxctMEzW071DfDWKl3qUnS1P47zpeKF9s65BrfQq295i4qlfq6wus9fZRBChJ
         3cr98P36/u1MNCGBfmHYTeRe60M3ktsfs0m8PwZFKO15WeHqXE5pftp8VeVDi3v9dglR
         qE6bhGvF19zDi5eYxpYPZHlcs7MonvLLhWtKL/cvfTJ7OoIY6EyFBkzDXSULjX1gMtXe
         LfOeAmsMjiInoP6qzTpLg1qJYJjvCsOG5IuUwjjQHq0o2vcF7G5jBhTkBD7osqlbHRps
         SRckmmmm43sYo8RLmEoAdCNR+VKFBcBWqZeqzGbcNNtSdo3jS499+rH0l+Bm7JJ+92i5
         PD3A==
X-Gm-Message-State: AOJu0Yz/UsOUUsMQQHB8X1w/vzjPncli0398hpyhiVntyhV67rSQ5INM
	SpcsscuugV63UQ8O/fufJleXn+HDenoMnGCNICYSQjPPFs+vWIoTqWF65Q==
X-Google-Smtp-Source: AGHT+IEig7NzUhm62H3DA5nx5pjA1i1dwuAaWJmVpCUACUwmPVTFAZ7omPfKd/ErIMnOAph1LwUzvw==
X-Received: by 2002:a17:902:c40d:b0:1f6:f0fe:6cc9 with SMTP id d9443c01a7336-1fed92ca0b3mr3588085ad.54.1721869310256;
        Wed, 24 Jul 2024 18:01:50 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8cbadsm2097225ad.48.2024.07.24.18.01.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jul 2024 18:01:49 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Marc Hartmayer <mhartmay@linux.ibm.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] workqueue: Remove incorrect "WARN_ON_ONCE(!list_empty(&worker->entry));" from dying worker
Date: Thu, 25 Jul 2024 09:04:37 +0800
Message-Id: <20240725010437.694727-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

The commit 68f83057b913 ("workqueue: Reap workers via kthread_stop()
and remove detach_completion") changes the procedure of destroying
workers; the dying workers are kept in the cull_list in wake_dying_workers()
with the pool lock held and removed from the cull_list by the newly
added reap_dying_workers() without the pool lock.

This can cause a warning if the dying worker is wokenup earlier than
reaped as reported by Marc:

2024/07/23 18:01:21 [M83LP63]: [  157.267727] ------------[ cut here ]------------
2024/07/23 18:01:21 [M83LP63]: [  157.267735] WARNING: CPU: 21 PID: 725 at kernel/workqueue.c:3340 worker_thread+0x54e/0x558
2024/07/23 18:01:21 [M83LP63]: [  157.267746] Modules linked in: binfmt_misc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables sunrpc dm_service_time s390_trng vfio_ccw mdev vfio_iommu_type1 vfio sch_fq_codel
2024/07/23 18:01:21 [M83LP63]: loop dm_multipath configfs nfnetlink lcs ctcm fsm zfcp scsi_transport_fc ghash_s390 prng chacha_s390 libchacha aes_s390 des_s390 libdes sha3_512_s390 sha3_256_s390 sha512_s390 sha256_s390 sha1_s390 sha_common scm_block eadm_sch scsi_dh_rdac scsi_dh_emc scsi_dh_alua pkey zcrypt rng_core autofs4
2024/07/23 18:01:21 [M83LP63]: [  157.267792] CPU: 21 PID: 725 Comm: kworker/dying Not tainted 6.10.0-rc2-00239-g68f83057b913 #95
2024/07/23 18:01:21 [M83LP63]: [  157.267796] Hardware name: IBM 3906 M04 704 (LPAR)
2024/07/23 18:01:21 [M83LP63]: [  157.267802]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
2024/07/23 18:01:21 [M83LP63]: [  157.267797] Krnl PSW : 0704d00180000000 000003d600fcd9fa (worker_thread+0x552/0x558)
2024/07/23 18:01:21 [M83LP63]: [  157.267806] Krnl GPRS: 6479696e6700776f 000002c901b62780 000003d602493ec8 000002c914954600
2024/07/23 18:01:21 [M83LP63]: [  157.267809]            0000000000000000 0000000000000008 000002c901a85400 000002c90719e840
2024/07/23 18:01:21 [M83LP63]: [  157.267811]            000002c90719e880 000002c901a85420 000002c91127adf0 000002c901a85400
2024/07/23 18:01:21 [M83LP63]: [  157.267813]            000002c914954600 0000000000000000 000003d600fcd772 000003560452bd98
2024/07/23 18:01:21 [M83LP63]: [  157.267822] Krnl Code: 000003d600fcd9ec: c0e500674262        brasl   %r14,000003d601cb5eb0
2024/07/23 18:01:21 [M83LP63]: [  157.267822]            000003d600fcd9f2: a7f4ffc8            brc     15,000003d600fcd982
2024/07/23 18:01:21 [M83LP63]: [  157.267822]           #000003d600fcd9f6: af000000            mc      0,0
2024/07/23 18:01:21 [M83LP63]: [  157.267822]           >000003d600fcd9fa: a7f4fec2            brc     15,000003d600fcd77e
2024/07/23 18:01:21 [M83LP63]: [  157.267822]            000003d600fcd9fe: 0707                bcr     0,%r7
2024/07/23 18:01:21 [M83LP63]: [  157.267822]            000003d600fcda00: c00400682e10        brcl    0,000003d601cd3620
2024/07/23 18:01:21 [M83LP63]: [  157.267822]            000003d600fcda06: eb7ff0500024        stmg    %r7,%r15,80(%r15)
2024/07/23 18:01:21 [M83LP63]: [  157.267822]            000003d600fcda0c: b90400ef            lgr     %r14,%r15
2024/07/23 18:01:21 [M83LP63]: [  157.267853] Call Trace:
2024/07/23 18:01:21 [M83LP63]: [  157.267855]  [<000003d600fcd9fa>] worker_thread+0x552/0x558
2024/07/23 18:01:21 [M83LP63]: [  157.267859] ([<000003d600fcd772>] worker_thread+0x2ca/0x558)
2024/07/23 18:01:21 [M83LP63]: [  157.267862]  [<000003d600fd6c80>] kthread+0x120/0x128
2024/07/23 18:01:21 [M83LP63]: [  157.267865]  [<000003d600f5305c>] __ret_from_fork+0x3c/0x58
2024/07/23 18:01:21 [M83LP63]: [  157.267868]  [<000003d601cc746a>] ret_from_fork+0xa/0x30
2024/07/23 18:01:21 [M83LP63]: [  157.267873] Last Breaking-Event-Address:
2024/07/23 18:01:21 [M83LP63]: [  157.267874]  [<000003d600fcd778>] worker_thread+0x2d0/0x558

Since the procedure of destroying workers is changed, the WARN_ON_ONCE()
becomes incorrect and should be removed.

Cc: Marc Hartmayer <mhartmay@linux.ibm.com>
Link: https://lore.kernel.org/lkml/87le1sjd2e.fsf@linux.ibm.com/
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Fixes: 68f83057b913 ("workqueue: Reap workers via kthread_stop() and remove detach_completion")
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 177b09ba61e2..b7efe8966a7d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3335,7 +3335,6 @@ static int worker_thread(void *__worker)
 
 		set_task_comm(worker->task, "kworker/dying");
 		ida_free(&pool->worker_ida, worker->id);
-		WARN_ON_ONCE(!list_empty(&worker->entry));
 		return 0;
 	}
 
-- 
2.19.1.6.gb485710b


