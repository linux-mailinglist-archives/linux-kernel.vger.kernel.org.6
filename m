Return-Path: <linux-kernel+bounces-408137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E228A9C7B98
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BD2DB38EE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDC3204014;
	Wed, 13 Nov 2024 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c0XUSmgW"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659E70806
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521687; cv=none; b=tHKufMhUz3Jo5+DELHkHxI735EtcwQZK/pgcCc4s8+tLIOWezlObjNwTHfBBMdDPs3jz4dhONxiDovyXs/nN9YfcUKHIwr3fl4H2W0bTC6gJbk8ZtyPLX1JrlKgOo4ROXZAf3fWgdsKor4H0yGGRvrZfNST0E1a4zzVm/YLYHEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521687; c=relaxed/simple;
	bh=sEmY4uYRlAkD8A09Ngb1UKGCh4Qovqiwmrf5dOuof2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RrnyvYaJk3rP/yM6pAza3NUAry/DRojZeo1AnSN/Zj/dK8x269EUTYBEf2niojF0na1evjOTJ7n8TkseujbjAesmpjTYMK2zxGT64ftFkQvOd5CHr7z9ElHLV0ziiTVysXa1F6Y6EnDQHFcb4f4PKqxtaye7wOY2gfJbrnMSMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c0XUSmgW; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIBhTL010047;
	Wed, 13 Nov 2024 18:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=OqMSc70FzBX81lqfC2XRkNJsn4XMm
	Y4XjLfp3gxHKyY=; b=c0XUSmgWR72B+GejN5omQcDR5FC9psOBUWvQJeWDmAK9z
	R2+0rL7dtPSBdR5TLk/umTVJOc1wULVl9JJKMaGHzaTQRzJeMHt990iwh42Ue7Hc
	t6VNlWyTUFfBf/JSErpMXmrqDhcCYaPFQygmq1J29UF2VKfUKPol04ELs2VZQboY
	pw8TOMe1LVgKNEIRmv9wz7yaTkP/KjrQbvck6uVWgEZgap4m96r2ZNqQs/WDHw0S
	WV24+jwOB1UY8/OB0OEtg8hsSb0OWlpfWBj+xHpv9e26xAViuDhhQQ9KfAc9lQJo
	onlMDhn4rE4lrFnkv7NaI8NI1qdhNw3IEqFTVCVSg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kbykmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 18:14:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADH9Tlg000406;
	Wed, 13 Nov 2024 18:14:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbp91yyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 18:14:37 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4ADIEaKs022346;
	Wed, 13 Nov 2024 18:14:36 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42tbp91yxm-1;
	Wed, 13 Nov 2024 18:14:36 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, rudi.horn@oracle.com, joe.jin@oracle.com
Subject: [PATCH 1/2] x86/pkeys: Change caller of update_pkru_in_sigframe()
Date: Wed, 13 Nov 2024 18:14:35 +0000
Message-ID: <20241113181436.3518359-1-aruna.ramakrishna@oracle.com>
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
 definitions=2024-11-13_10,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130150
X-Proofpoint-GUID: EUufvNmCPSgqqxV5o4JNEnqP-I3ciH8N
X-Proofpoint-ORIG-GUID: EUufvNmCPSgqqxV5o4JNEnqP-I3ciH8N

The commit 70044df250d0 ("x86/pkeys: Update PKRU to enable all pkeys
before XSAVE") enables all pkeys before XSAVE to allow writing data
to the sigaltstack (i.e. it does a wrpkru(0)).

However, when PKRU is set to 0, it has the side effect of setting
XINUSE[PKRU] to 0 on AMD systems, but not on Intel. If XINUSE[i]
is set to 0, then XRSTOR will not restore the component i from the
XSAVE area - effectively ignoring the value of PKRU updated on the
sigframe by update_pkru_in_sigframe(). This means that PKRU stays
at 0 when control is returned back to the user after signal
handling, which is unexpected.

To fix this, and to ensure that PKRU is always restored correctly
from the XSAVE data on both Intel and AMD systems, explicitly set
XINUSE[PKRU] to 1.

This change is split into 2 patches - the first one merely changes
the caller of update_pkru_in_sigframe(), but the behavior remains
the same. The next patch will update the XINUSE bit for PKRU.

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


