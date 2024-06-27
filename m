Return-Path: <linux-kernel+bounces-233029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4291B15F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9B6C283000
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119531A2559;
	Thu, 27 Jun 2024 21:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kqLUXb3/"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890311A01D1
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523081; cv=none; b=louU/sSgkCiaeEpoq0CVjC2UxF30iXEUjP1tHS7QnUw/0aryVlAfkmMgxzwMad0SMY2yRw+FxUy0/829+8XYlcxMnl71m7ZZj4l4i94WJuCawnBXJlZ/eymto/Xk3W0im4/LNCiCDIbqlrRq5KyQw0j0i7N8YioOjoxLeaeT7j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523081; c=relaxed/simple;
	bh=usC0gVWFFeKhkaoGk7YZQ5gknIX9QQpM2gBaqwaFA4A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ssLfj4RhgkGkCg9X8SmKI1TZ9NAwZtg3C29G88/aK3VL/BP9T1IjueLIy9ode7msbRU+1vGux2zTfxObaxahbPWfEiSAUlCaqT/FHhnsxDUooM6MbMmPTVVNcxOfAfiewOtaNTzr48R7IY127Xi62nU3NwEoigvioJ9+eoRvWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kqLUXb3/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RKBYv1020067;
	Thu, 27 Jun 2024 21:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=/
	bpoyyF5uJHD4UYEbSfLk4sRr8XdJCgUA9Ij/0t8DU0=; b=kqLUXb3/848ptWF8V
	0FtBbBroU88pEwdzFhbeSq6VnVhe8ZNhB18UPWXyArDbLVXRnbdYu+lX3RhUJiWn
	posEbs8sG9Y/e1ll5utUm+eqUdnHa8jqYyv9Uj61it6P6vFJj6IgAePGhKFsXDIY
	UpGaCLiTg3nqX2Xk17WoVT7Q6EpyF6y0v9O8C3VwaUfwfeYtfD9V0tL7KExGZeJe
	dAmXPPaPFcYLulQTFDS2NJ9IiNbE8e8MEm5mw21yRzw/d79q5L3hgqXffWcrhv23
	oic3CDGvNockiNNBngyZC9KQ3xZi3i1r56YtKfKIWwlGaqM//ospi2TKtmtl5cj4
	eDAhw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywn1d6s9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 21:17:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RL9ZZu017868;
	Thu, 27 Jun 2024 21:17:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2awm5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 21:17:41 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RLHct6016897;
	Thu, 27 Jun 2024 21:17:40 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2awm35-3;
	Thu, 27 Jun 2024 21:17:40 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, jeffxu@chromium.org, keith.lucas@oracle.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH v6 2/5] x86/pkeys: Add helper functions to update PKRU on the sigframe
Date: Thu, 27 Jun 2024 21:17:34 +0000
Message-Id: <20240627211737.323214-3-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240627211737.323214-1-aruna.ramakrishna@oracle.com>
References: <20240627211737.323214-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270158
X-Proofpoint-GUID: fg02PAaXTSY_aUHghVvWIzM9Gy3xmFfz
X-Proofpoint-ORIG-GUID: fg02PAaXTSY_aUHghVvWIzM9Gy3xmFfz

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
index 05df04f39628..bc2ce703055a 100644
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
index 94b894437327..131eb4ae20fe 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -224,6 +224,24 @@ setup_rt_frame(struct ksignal *ksig, struct pt_regs *regs, u32 pkru)
 	}
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
 static void
 handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
-- 
2.39.3


