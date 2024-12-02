Return-Path: <linux-kernel+bounces-427942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5139E088D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B420216CC1C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:56:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D03136352;
	Mon,  2 Dec 2024 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cLRCj81Y"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CB3757EA
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 15:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154965; cv=none; b=fSUJR7NoBBCb8DgftSameCsZODY63dSfvt+0YPzlJjIbDtkUt6ggIDRQUVy7DiS6ayy2hBAe1w/BZBzX9PT9UJz9cKFijZnsoHPi+9OfcJDAYIMuGK7Kegv1HohvngmO4M6VK6gJSYsTe64s5ds7oxneWM7EnNH1L51RIjtk2ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154965; c=relaxed/simple;
	bh=vO/zP/Hg6dRPICelNAVB8r2vgxb3Z2D6cS4un5APP+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DjkCwQVPnsmMkCsuVhFexTWS6Df6/i2NopkXH3NY37tw82FCC5Uc2PJZLX0zEjmcsLeZCeqj7t9DuNtmrFqZUnQaADtTLqkdDOO8AeWxvq8TuHIacOAvVLtmFN9Gc6N35874RqSfasrpgSsw4CPjcCthkgcBcVw5aGMidY+IGg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cLRCj81Y; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2A6f4B030483;
	Mon, 2 Dec 2024 15:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Hk+RngvHGZxzy28PlgmvX+7b46pqIZH4JnqUukvzW
	vI=; b=cLRCj81YZIfbZSKrK+Txjc0cq/rF4Yx+l0e+aTgr4xfHhiYqOQeJvRo7f
	aCauv71ukoeIeNrxHYxhuLuIpRT+GPLV74EPL9FsrGxZOE8Bu/jDW5XmUWJ9Gtyp
	KdHhmFlM63Eu1Sy++Mklov8K//LjoikoURDHuc37S3UkEvNFDeILdcaJ1qF1KS5e
	+LPkwMGWP83FioXBQw1sGyOEf5669JZ2IXNmhQYpYdE/k0IRzikcf6aB7Sikmz3T
	HYJN7VDLS2xjDiNnubx0G8rk87seQ6k7vaqTJDeh8FY7LSNJPYdUJYmemt87jOf/
	5kw3sLTn/BvddBOsfeFXZ42wYpFFg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437tcva63h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 15:55:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B2FfQ3t029494;
	Mon, 2 Dec 2024 15:55:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438ddy750b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 15:55:54 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B2Ftou335390086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Dec 2024 15:55:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E3A520040;
	Mon,  2 Dec 2024 15:55:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9C422004E;
	Mon,  2 Dec 2024 15:55:49 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.171.28.94])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Dec 2024 15:55:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] posix-timers: Fix a race with __exit_signal()
Date: Mon,  2 Dec 2024 16:54:32 +0100
Message-ID: <20241202155547.8214-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PPgu_SFAKJlyiiPiePXbWWZ7W4NOip54
X-Proofpoint-GUID: PPgu_SFAKJlyiiPiePXbWWZ7W4NOip54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2412020133

If a thread exit happens simultaneously with a POSIX timer signal, this
POSIX timer may end up being erroneously stopped. This problem may be
reproduced with a small C program that creates a POSIX timer and
constantly respawns threads, e.g. [1].

When posixtimer_send_sigqueue() races against __exit_signal(), the
latter may clear the selected task's sighand, causing
lock_task_sighand() to fail. This is possible because __exit_signal()
clears the task's sighand under the sighand lock, but
lock_task_sighand() needs to first load it without taking this lock.

The it_sigqueue_seq update needs to happen under the sighand lock;
failure to take this lock means that it is not possible to make that
update. And if it_sigqueue_seq is not updated, then
__posixtimer_deliver_signal() does not rearm the timer, effectively
stopping it.

Fix by choosing another thread if the one chosen by
posixtimer_get_target() is exiting. This requires taking tasklist_lock,
which is ordered before the sighand lock, as can be seen in, e.g.,
release_task(). tasklist_lock may be released immediately after the
sighand lock is successfully taken, which will look nicer, but will
create uncertainty w.r.t. restoring the irq flags, so release it
at the end of posixtimer_send_sigqueue().

There is another user of posixtimer_get_target(), which may potentially
be affected as well: posixtimer_sig_unignore(). But it is called with
the sighand lock taken, so the race with __exit_signal() is fortunately
not possible there.

[1] https://gitlab.com/qemu-project/qemu/-/blob/v9.1.1/tests/tcg/multiarch/signals.c?ref_type=tags

Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 kernel/signal.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 989b1cc9116a..ff1608997301 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1974,10 +1974,11 @@ static inline struct task_struct *posixtimer_get_target(struct k_itimer *tmr)
 
 void posixtimer_send_sigqueue(struct k_itimer *tmr)
 {
+	unsigned long flags, tasklist_flags;
 	struct sigqueue *q = &tmr->sigq;
+	bool tasklist_locked = false;
 	int sig = q->info.si_signo;
 	struct task_struct *t;
-	unsigned long flags;
 	int result;
 
 	guard(rcu)();
@@ -1986,8 +1987,25 @@ void posixtimer_send_sigqueue(struct k_itimer *tmr)
 	if (!t)
 		return;
 
-	if (!likely(lock_task_sighand(t, &flags)))
-		return;
+	if (!likely(lock_task_sighand(t, &flags))) {
+		/*
+		 * The target is exiting, pick another one. This ensures that
+		 * it_sigqueue_seq is updated, otherwise
+		 * posixtimer_deliver_signal() will not rearm the timer.
+		 */
+		bool found = false;
+
+		read_lock_irqsave(&tasklist_lock, tasklist_flags);
+		tasklist_locked = true;
+		do_each_pid_task(tmr->it_pid, tmr->it_pid_type, t) {
+			if (likely(lock_task_sighand(t, &flags))) {
+				found = true;
+				break;
+			}
+		} while_each_pid_task(tmr->it_pid, tmr->it_pid_type, t);
+		if (!likely(found))
+			goto out_tasklist;
+	}
 
 	/*
 	 * Update @tmr::sigqueue_seq for posix timer signals with sighand
@@ -2062,6 +2080,9 @@ void posixtimer_send_sigqueue(struct k_itimer *tmr)
 out:
 	trace_signal_generate(sig, &q->info, t, tmr->it_pid_type != PIDTYPE_PID, result);
 	unlock_task_sighand(t, &flags);
+out_tasklist:
+	if (tasklist_locked)
+		read_unlock_irqrestore(&tasklist_lock, tasklist_flags);
 }
 
 static inline void posixtimer_sig_ignore(struct task_struct *tsk, struct sigqueue *q)
-- 
2.47.0


