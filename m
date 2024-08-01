Return-Path: <linux-kernel+bounces-270752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E00A79444CC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9938E282997
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8692C16CD09;
	Thu,  1 Aug 2024 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Cu3GCaXO"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174A52747B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495116; cv=none; b=F9cjy6Qz9tW+LiwZ+9MESGYtEvkOOkCfspZXZOGClz9FT18cYVw7ATPR0/unp86VxlizsID8/zLvZl1SCJUhKYRPKafin5aes5oFuQoZd6PSAImk4P+DVfOvuqU/Jk1iQolrIJ/PrEhpkKXho9HALKYAuGhi8SdKA5QZm1J7ci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495116; c=relaxed/simple;
	bh=4joHTmgnUgmQV1hVa2Af3aHcK3gBdshhqPOSYacUzRs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=byK/8W9aB0Ue2hqyFoiUgL4ptY1jdNW2cpCUIa1G2xsqyPceQrVWIOyiC52o/6zEagyd3Z/kv80FMp8FI9/BWjygwEUY6WqX+e8pTa8U3pBcSSoNrzpyNLwOd5z82EBNsNEmcdOe8RETe4HZ5VZWRScM4RRljxZEmY0tAwwcggY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Cu3GCaXO; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VLH9AZ010366;
	Thu, 1 Aug 2024 06:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=H
	YlGse7LIrCjPVKcie6J2ImrmiUAqWkLFVxRi2crvAA=; b=Cu3GCaXOr+jr4CGRr
	Q32iY+oGtHHWAVN/7GrkCEMwW4S+KwzMrt81aCWAu/z72zQ0SLw3tpu6c+2JPfoS
	8kM5SpC/xI1mHO2Y3q2I8UXMCq8LJYT/9KCewWEWZTs7zJnBK46VjtN/GzCjtnTm
	NzNXjM3kKG/RUZfquBkUKQLbsvxK04AKdQzBsltnK5eBBuPjMismlXcw9ZSZSjEq
	RRk0UtJMDdSRGf6zImGY/+ReluAX/REqVhvvK4aNTKCUeJ+6oJNxprEyX1+qQvTq
	LyS2xKf/DAacn3nopvczz0MSwZVex/lgNYJBTYmMEAqo3MNIZxvmb4/vjhyktKBL
	91fkw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrgs92em-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 06:51:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4716KPrY030847;
	Thu, 1 Aug 2024 06:51:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nehveh7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 06:51:19 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4716pHNI033596;
	Thu, 1 Aug 2024 06:51:18 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40nehveh6x-4;
	Thu, 01 Aug 2024 06:51:18 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, linux-mm@kvack.org, keith.lucas@oracle.com,
        jeffxu@chromium.org, rick.p.edgecombe@intel.com, jorgelo@chromium.org,
        keescook@chromium.org, sroettger@google.com, jannh@google.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH  v7 3/5] x86/pkeys: Update PKRU to enable all pkeys before XSAVE
Date: Thu,  1 Aug 2024 06:51:14 +0000
Message-Id: <20240801065116.2088582-4-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240801065116.2088582-1-aruna.ramakrishna@oracle.com>
References: <20240801065116.2088582-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_04,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=937 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010038
X-Proofpoint-GUID: y7pqVZIqBkB7gXaqmCtwyn3vc3G3FIM4
X-Proofpoint-ORIG-GUID: y7pqVZIqBkB7gXaqmCtwyn3vc3G3FIM4

If the alternate signal stack is protected by a different pkey than the
current execution stack, copying xsave data to the sigaltstack will fail
if its pkey is not enabled. We do not know which pkey was used by the
application for the sigaltstack, so enable all pkeys before xsave
so that the signal handler accessibility is not dictated by the PKRU
value that the thread sets up. But this updated PKRU value is also
pushed onto the sigframe, so overwrite that with the original,
user-defined PKRU value so that the value restored from sigcontext does
not have the extra pkey enabled.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 arch/x86/kernel/fpu/signal.c | 11 +++++++++--
 arch/x86/kernel/signal.c     | 12 ++++++++++--
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 931c5469d7f3..1065ab995305 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -168,8 +168,15 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 
 static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf, u32 pkru)
 {
-	if (use_xsave())
-		return xsave_to_user_sigframe(buf);
+	int err = 0;
+
+	if (use_xsave()) {
+		err = xsave_to_user_sigframe(buf);
+		if (!err)
+			err = update_pkru_in_sigframe(buf, pkru);
+		return err;
+	}
+
 	if (use_fxsr())
 		return fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
 	else
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 9dc77ad03a0e..5f441039b572 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -102,7 +102,7 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 	unsigned long math_size = 0;
 	unsigned long sp = regs->sp;
 	unsigned long buf_fx = 0;
-	u32 pkru = read_pkru();
+	u32 pkru;
 
 	/* redzone */
 	if (!ia32_frame)
@@ -157,9 +157,17 @@ get_sigframe(struct ksignal *ksig, struct pt_regs *regs, size_t frame_size,
 		return (void __user *)-1L;
 	}
 
+	/* Update PKRU to enable access to the alternate signal stack. */
+	pkru = sig_prepare_pkru();
 	/* save i387 and extended state */
-	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size, pkru))
+	if (!copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size, pkru)) {
+		/*
+		 * Restore PKRU to the original, user-defined value; disable
+		 * extra pkeys enabled for the alternate signal stack, if any.
+		 */
+		write_pkru(pkru);
 		return (void __user *)-1L;
+	}
 
 	return (void __user *)sp;
 }
-- 
2.39.3


