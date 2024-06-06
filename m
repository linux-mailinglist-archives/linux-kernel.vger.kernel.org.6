Return-Path: <linux-kernel+bounces-205124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 776208FF7B7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0F51F25747
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DB113DDA0;
	Thu,  6 Jun 2024 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m8FZmXI2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BB613AD30
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713651; cv=none; b=AW8sMJUIY2CYDbJgjIc8vxacRPV5X7J/bczPuWsedVgOSpPXciNvSofvLk/4P88Xk7VVrj00pKrzrlb1fDmVb7L8P3GutMLIfk9Zg0BsReV1qaMB0yQIPGaiKhkIF80rHbVpRML++NosBCbsJsGjOFm6eu19lUgUicXhh4Kw8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713651; c=relaxed/simple;
	bh=/SIaL3B++/HJR73gXBkcankPIIngPsvJL8/+fDzZ7lc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YzWrtQ3SkkgiPypHYhtR8FxtsnFCsnH0pniQeFB9E9uRDQf7jPZJ50D3dVb6h7HbVWLOg06AWF7mFTghpXgawL8s+UjZvn5iKV+/qdu/c5waOEq0qCWm7QfgLca5LPazHiDOWiEaviDZvkrZVdsDumy6bP+MsrgpT2RfQ6bFkcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m8FZmXI2; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456Hxaeu021749;
	Thu, 6 Jun 2024 22:40:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=corp-2023-11-20;
 bh=nXGGNcr2dE6UFV4afJQdsoWXk+66We/+7H9jhPp/wLw=;
 b=m8FZmXI2zh8QhT4AnIn2oGw6O/2ssUWKmakSCtlpp9efkSmpLMEXoRBz5Gomk3vuPDI7
 ADD/EFgkYbDs4snpTP9udOrpKO8XCLvqIPccbx71Gm68xMhQBjWsnJJgsamVVlgrJIez
 aQb/ZRI1bbyPWC8krEPF0d9dfgX2M4MT8AxPxpG4qa3+zkHZFjgA0qVY7gZRNa8B+uEu
 CIO+VZykD9DCTqumvKjoq4clsvzw5J9C/e23CTCJzv8Lgs2Iw+NQybSlTxTFME/HVTFE
 xwwD2PaMibKXeCMse4L/h6peyuLVQP97aue2h78sIZezzJXE8ZnHIw8nYtVWcloYa3uG ng== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbsycj3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 22:40:40 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456Mcc14005546;
	Thu, 6 Jun 2024 22:40:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmh5aj9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 22:40:39 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456MebVO028229;
	Thu, 6 Jun 2024 22:40:39 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ygrmh5ag4-3;
	Thu, 06 Jun 2024 22:40:39 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: [PATCH v5 2/5] x86/pkeys: Add helper functions to update PKRU on sigframe
Date: Thu,  6 Jun 2024 22:40:32 +0000
Message-Id: <20240606224035.3238985-3-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240606224035.3238985-1-aruna.ramakrishna@oracle.com>
References: <20240606224035.3238985-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_18,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060156
X-Proofpoint-GUID: D9Nuh6_WabTv2hDH8pXEORaKVjS89jBm
X-Proofpoint-ORIG-GUID: D9Nuh6_WabTv2hDH8pXEORaKVjS89jBm

In the case where a user thread sets up an alternate signal stack
protected by the default pkey (i.e. pkey 0), while the thread's stack
is protected by a non-zero pkey, both these pkeys have to be enabled in
the PKRU register for the signal to be delivered to the application
correctly. However, the PKRU value restored after handling the signal
must not enable this extra pkey (i.e. pkey 0), so the PKRU value on the
on the sigframe should be overwritten with the user-defined value.

Add helper functions that will update PKRU value on the sigframe after
XSAVE. These functions will be called in a later patch; this patch does not
change any behavior as yet.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 arch/x86/kernel/fpu/signal.c | 11 +++++++++++
 arch/x86/kernel/fpu/xstate.c | 13 +++++++++++++
 arch/x86/kernel/fpu/xstate.h |  1 +
 arch/x86/kernel/signal.c     | 15 +++++++++++++++
 4 files changed, 40 insertions(+)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 2b3b9e140dd4..b0b254b931fd 100644
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
@@ -160,6 +170,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf, u32 pk
 {
 	if (use_xsave())
 		return xsave_to_user_sigframe(buf);
+
 	if (use_fxsr())
 		return fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
 	else
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 33a214b1a4ce..e257478a0962 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -992,6 +992,19 @@ void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr)
 	return __raw_xsave_addr(xsave, xfeature_nr);
 }
 
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
index 19ca623ffa2a..236742db69fa 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -55,6 +55,7 @@ extern void fpu__init_cpu_xstate(void);
 extern void fpu__init_system_xstate(unsigned int legacy_size);
 
 extern void *get_xsave_addr(struct xregs_state *xsave, int xfeature_nr);
+extern void __user *get_xsave_addr_user(struct xregs_state *xsave, int xfeature_nr);
 
 static inline u64 xfeatures_mask_supervisor(void)
 {
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 94b894437327..3fa66b2fe753 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -224,6 +224,21 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru)
 	}
 }
 
+/*
+ * Enable init_pkru pkey as well as the user-defined pkey to ensure that both
+ * the current stack and the alternate signal stack are writeable.
+ * Note: this function assumes that the alternate signal stack is accessible
+ * with the init_pkru_value. If the sigaltstack is protected by a different,
+ * non-zero pkey, then the application will segfault.
+ */
+static inline u32 sig_prepare_pkru(void)
+{
+	u32 orig_pkru = read_pkru();
+
+	write_pkru(orig_pkru & pkru_get_init_value());
+	return orig_pkru;
+}
+
 static void
 handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
-- 
2.39.3


