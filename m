Return-Path: <linux-kernel+bounces-270749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC229444CA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46C17281DC7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D372B157490;
	Thu,  1 Aug 2024 06:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a+LA9C0O"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990315854C
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495115; cv=none; b=aSnUUVDiYUG0MqFS8oZXStmvB4WY2QbPWYvzjJfryk9g7OPoOhJe7OmMq0dpJ27m2QxjlTW/R9rqwm9tl9PdStD3RXWerV45z5wMhjZKxOvz5NFzZuFf0yV+f6ffK5NnFkFNNJoweq/gCN/UAGIyhZfa2D8dmkVQYGx/yavQPO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495115; c=relaxed/simple;
	bh=l3CvLWtw+C+RehL+3mNJ9R9bY95JIIaN6+AzLm62w24=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bXH4j6DyalxvUVhHETCuqznTqyv/zZ74CbegfjreKiNDBBIzpb/Y558d7QjA6Yl0xtJ92l8jfGWTZfLfdR9bDCWl1CqjXcXQx1c3C2HvAsil0+N4rVY5bDUxPEtwTZgxigTnOv0Yl1Xv1XNI5LQqnoKEgsyGQcJrQwkpxaAgkS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a+LA9C0O; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VLHDsl028382;
	Thu, 1 Aug 2024 06:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=G
	5mMnDpkYZkQxM2Urrt/xYeOk6eG4fznj0JjVcnQXi0=; b=a+LA9C0OzpoxyhodA
	zNIjrivRSPsRUxXGWQHrCV1zHsDyYQOVq5u8JMuhIK/i2+vYgsgiIhu8osEdO5Xg
	GXq5+A5Nzoo+bOTtwgkHdW4ytwls4WRC/235TyFuJxv78fzoRTTn3HRuIv6XJZUg
	+bfiIUOeFQoPjAjpD9jattvyDvq0OhSWlbk2aaKlU8NezXdzELTMvqcb0vzJl73J
	DVp7bAz1QQ9+Ilii/6IDxYcit99d4DBayucq+XGyLZThTP9BArE8FNCijUrDCft6
	lgI6io136XS3BwgBvkulF/J6P4kU+qaErd1SHl/vE6TUSR0XFkCGLvy1Pqh48uZ+
	wQqJg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqacs21x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 06:51:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4714uHW4030801;
	Thu, 1 Aug 2024 06:51:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nehveh7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 06:51:18 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4716pHNG033596;
	Thu, 1 Aug 2024 06:51:18 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40nehveh6x-3;
	Thu, 01 Aug 2024 06:51:18 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, linux-mm@kvack.org, keith.lucas@oracle.com,
        jeffxu@chromium.org, rick.p.edgecombe@intel.com, jorgelo@chromium.org,
        keescook@chromium.org, sroettger@google.com, jannh@google.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH  v7 2/5] x86/pkeys: Add helper functions to update PKRU on the sigframe
Date: Thu,  1 Aug 2024 06:51:13 +0000
Message-Id: <20240801065116.2088582-3-aruna.ramakrishna@oracle.com>
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
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010038
X-Proofpoint-ORIG-GUID: LKVdYd-c38gWL3NEsFAaQtglYu2fHkGe
X-Proofpoint-GUID: LKVdYd-c38gWL3NEsFAaQtglYu2fHkGe

In the case where a user thread sets up an alternate signal stack
protected by the default pkey (i.e. pkey 0), while the thread's stack
is protected by a non-zero pkey, both these pkeys have to be enabled in
the PKRU register for the signal to be delivered to the application
correctly. However, the PKRU value restored after handling the signal
must not enable this extra pkey (i.e. pkey 0), so the PKRU value on the
on the sigframe should be overwritten with the user-defined value.

Add helper functions that will update PKRU value on the sigframe after
XSAVE. These functions will be called in a later patch; this patch does
not change any behavior as yet.

Note that sig_prepare_pkru() makes no assumption about what pkey could
be used to protect the altstack (i.e. it may not be part of init_pkru),
and so enables all pkeys.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 arch/x86/kernel/fpu/signal.c | 10 ++++++++++
 arch/x86/kernel/fpu/xstate.c | 13 +++++++++++++
 arch/x86/kernel/fpu/xstate.h |  2 ++
 arch/x86/kernel/signal.c     | 18 ++++++++++++++++++
 4 files changed, 43 insertions(+)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 2b3b9e140dd4..931c5469d7f3 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -63,6 +63,16 @@ static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	return true;
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
 /*
  * Signal frame handlers.
  */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c5a026fee5e0..fa7628bb541b 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -993,6 +993,19 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 }
 EXPORT_SYMBOL_GPL(get_xsave_addr);
 
+/*
+ * Given an xstate feature nr, calculate where in the xsave buffer the state is.
+ * The xsave buffer should be in standard format, not compacted (e.g. user mode
+ * signal frames).
+ */
+void __user *get_xsave_addr_user(struct xregs_state __user *xsave, int xfeature_nr)
+{
+	if (WARN_ON_ONCE(!xfeature_enabled(xfeature_nr)))
+		return NULL;
+
+	return (void __user *)xsave + xstate_offsets[xfeature_nr];
+}
+
 #ifdef CONFIG_ARCH_HAS_PKEYS
 
 /*
diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 2ee0b9c53dcc..d04383793676 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -54,6 +54,8 @@ extern int copy_sigframe_from_user_to_xstate(struct task_struct *tsk, const void
 extern void fpu__init_cpu_xstate(void);
 extern void fpu__init_system_xstate(unsigned int legacy_size);
 
+extern void __user *get_xsave_addr_user(struct xregs_state *xsave, int xfeature_nr);
+
 static inline u64 xfeatures_mask_supervisor(void)
 {
 	return fpu_kernel_cfg.max_features & XFEATURE_MASK_SUPERVISOR_SUPPORTED;
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 1f1e8e0ac5a3..9dc77ad03a0e 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -60,6 +60,24 @@ static inline int is_x32_frame(struct ksignal *ksig)
 		ksig->ka.sa.sa_flags & SA_X32_ABI;
 }
 
+/*
+ * Enable all pkeys temporarily, so as to ensure that both the current
+ * execution stack as well as the alternate signal stack are writeable.
+ * The application can use any of the available pkeys to protect the
+ * alternate signal stack, and we don't know which one it is, so enable
+ * all. The PKRU register will be reset to init_pkru later in the flow,
+ * in fpu__clear_user_states(), and it is the application's responsibility
+ * to enable the appropriate pkey as the first step in the signal handler
+ * so that the handler does not segfault.
+ */
+static inline u32 sig_prepare_pkru(void)
+{
+	u32 orig_pkru = read_pkru();
+
+	write_pkru(0);
+	return orig_pkru;
+}
+
 /*
  * Set up a signal frame.
  */
-- 
2.39.3


