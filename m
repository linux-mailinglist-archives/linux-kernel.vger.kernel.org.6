Return-Path: <linux-kernel+bounces-408854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D15BF9C8453
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90D4128338C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 07:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBCA1F5845;
	Thu, 14 Nov 2024 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FsTHNaS0"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49581EF09F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731570771; cv=none; b=st4q+im5JLiZEZMcfpgvMcMoEYnE/ZpY68/l22ythLRepbpMGBUUuf0jL7rVSSb7EaBm6XIfO1Y8zvteqaFvuPbu2xuLJNrqHvPUM2E1sr02dMO+N/RuBWg2OKQhX0oNgaAErwmOAP9CEblzOlugvfqcaOb5kRSF1SfwZNF3Ipk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731570771; c=relaxed/simple;
	bh=eU/qyfu9SYbhbKY0LDgYJfXweCqyIQQ30wNZkpEqKZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SbUbFDSSu4MGn/sCwERhswQCRH0DzZsp6BVabA4XZzuOoKHe4t0lqeuVfn5AIAErDJBbu89dS9ZYS5VhLO9lqr6Bq1ShgCgv42ShlS93kLPP/EAezk3aADpoZEUlxqnV/+q/skkEl7vdypqHzuJxZRycJdxFoHfwUEwXg4yCX7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FsTHNaS0; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE1fcjr018612;
	Thu, 14 Nov 2024 07:52:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=qVFSsYtpSN+8HQMiFEXULeflm09g1
	nM0CNxUcxumWoM=; b=FsTHNaS0G0+murDEzZF57POSu7pOyXuUnbKpvirsABrpN
	2VRrXUDt8Iu6pTRixq8y6L1wO+jATcEh8dMKKG6Ca5srxYDO7gNcuuVihl1I7AkE
	G3gvJ8rrN2dsotCPYTZrNwBSw8UZrAMpIXyroUnpCnTFksbIkCIa5p2nGHqL2K8Z
	iOvCKvrVcZ5J/CMVHwQXK/5elC2aFizJPn3v1TsJKHiSG8aPftawE1HH4tc7t79x
	kvOOJQBM5kt1Vo3KmdA7YV/GvxE9brFtH5bKeUYv3TEKYNxHNhbECYZ89KubFx7+
	WB8xIrJJJ8oLN2QVXDBhsGEaNa/hBqIP+6TkEthLg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc0qpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 07:52:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE5vPFF005652;
	Thu, 14 Nov 2024 07:52:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6asv1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 07:52:42 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AE7qgnN025857;
	Thu, 14 Nov 2024 07:52:42 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42sx6asv16-1;
	Thu, 14 Nov 2024 07:52:42 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, rudi.horn@oracle.com, joe.jin@oracle.com
Subject: [PATCH 1/2] x86/pkeys: Change caller of update_pkru_in_sigframe()
Date: Thu, 14 Nov 2024 07:52:40 +0000
Message-ID: <20241114075241.3550166-1-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_03,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411140058
X-Proofpoint-GUID: gjKGkTuyepfvMP2U2RStl3YxK9MelBlr
X-Proofpoint-ORIG-GUID: gjKGkTuyepfvMP2U2RStl3YxK9MelBlr

The commit 70044df250d0 ("x86/pkeys: Update PKRU to enable all pkeys
before XSAVE") enables all pkeys before XSAVE to allow writing data
to the sigaltstack (i.e. it does a wrpkru(0)).

However, when PKRU is set to 0, it has the side effect of setting
XINUSE[PKRU] to 0 on AMD systems, but not on Intel - this in turn
sets XSTATE_BV[PKRU] to 0. XRSTOR will not restore the component i
from the XSAVE area if XSTATE_BV[i] is 0 - effectively ignoring the
value of PKRU updated on the sigframe by update_pkru_in_sigframe().
This means that PKRU stays at 0 when control is returned back to the
user after signal handling, which is unexpected.

To fix this, and to ensure that PKRU is always restored correctly
from the XSAVE data on both Intel and AMD systems, explicitly set
XSTATE_BV[PKRU] to 1.

This change is split into 2 patches - the first one merely changes
the caller of update_pkru_in_sigframe(), but the behavior remains
the same. The next patch will update the XSTATE_BV bit for PKRU.

No functional changes.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 arch/x86/kernel/fpu/signal.c | 20 ++------------------
 arch/x86/kernel/fpu/xstate.h | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 1065ab995305..8f62e0666dea 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -63,16 +63,6 @@ static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	return true;
 }
 
-/*
- * Update the value of PKRU register that was already pushed onto the signal frame.
- */
-static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u32 pkru)
-{
-	if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
-		return 0;
-	return __put_user(pkru, (unsigned int __user *)get_xsave_addr_user(buf, XFEATURE_PKRU));
-}
-
 /*
  * Signal frame handlers.
  */
@@ -168,14 +158,8 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 
 static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf, u32 pkru)
 {
-	int err = 0;
-
-	if (use_xsave()) {
-		err = xsave_to_user_sigframe(buf);
-		if (!err)
-			err = update_pkru_in_sigframe(buf, pkru);
-		return err;
-	}
+	if (use_xsave())
+		return xsave_to_user_sigframe(buf, pkru);
 
 	if (use_fxsr())
 		return fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 0b86a5002c84..6b2924fbe5b8 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -69,6 +69,16 @@ static inline u64 xfeatures_mask_independent(void)
 	return fpu_kernel_cfg.independent_features;
 }
 
+/*
+ * Update the value of PKRU register that was already pushed onto the signal frame.
+ */
+static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u32 pkru)
+{
+	if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
+		return 0;
+	return __put_user(pkru, (unsigned int __user *)get_xsave_addr_user(buf, XFEATURE_PKRU));
+}
+
 /* XSAVE/XRSTOR wrapper functions */
 
 #ifdef CONFIG_X86_64
@@ -256,7 +266,7 @@ static inline u64 xfeatures_need_sigframe_write(void)
  * The caller has to zero buf::header before calling this because XSAVE*
  * does not touch the reserved fields in the header.
  */
-static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
+static inline int xsave_to_user_sigframe(struct xregs_state __user *buf, u32 pkru)
 {
 	/*
 	 * Include the features which are not xsaved/rstored by the kernel
@@ -281,6 +291,9 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf)
 	XSTATE_OP(XSAVE, buf, lmask, hmask, err);
 	clac();
 
+	if (!err)
+		err = update_pkru_in_sigframe(buf, pkru);
+
 	return err;
 }
 
-- 
2.43.5


