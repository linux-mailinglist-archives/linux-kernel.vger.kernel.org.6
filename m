Return-Path: <linux-kernel+bounces-233035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B531191B166
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6940E28319D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFD41A38E3;
	Thu, 27 Jun 2024 21:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aGZii6Xr"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA501A2C32
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523087; cv=none; b=AfLq09/zpxBguJ5wZBuEzliL7MqpSRyy3j0i4IgvXSNIdb7wbFW6IvQeF/hh2OYGPM9Igfui+vPjiqcJBn4rDImh5IQSwkYYeMaRtyH/f4h520CaA0KEQqHeerUXtThx5vTDHYZ6/LFfkDNmwwUbuKyIQEQkVAp0q13ZIncMcsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523087; c=relaxed/simple;
	bh=EQ+m9x/RB4JhTpSSPOnC/ubtsKp4Z1TY6JREJsqsRts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=COGt8lUzoNrZUyXKdlP6MJqjuN4q7rJsctlHqj8ZNkQz59+v7peKL6RH2zUdUaD8baUBsuGiAmH7xcFj3gJRfBqTYgzEOjo04iOcFXusrdx3DSiqg6ELHHhVRm4nC+sZp15iOfZQJDvHppVGVXoMSY1/sfvT4yoMwtKgnWyME3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aGZii6Xr; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RKBZFg019352;
	Thu, 27 Jun 2024 21:17:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=J
	+TDyC8n1wGiozFBM71Y8mumIlo1Loss3Xu4f04WTog=; b=aGZii6XrVqSyOQqNo
	GrVGxN7wRLzZj9aukZ0TLhI73/k5My+igX25Jzi48O8/XacFQl1b75noU+gC5oct
	7s+kJp2GVi+iLt+xZA707YvOT8cAHyWFLW0VDj7a6Nta7CZ8kIuUz4Y4U7qSyPMn
	x/Si9o4Uzr6pbsqb+NTj6aXMJA7Imipy5BZhkHtPYpMSxq7UcE6rRhNX0ujGVWy3
	IpzB8ACK47mUgCOIvUfckA7uA2PHYX330W0CJhqcHW7qGYBDNnqAHhSoCxYfzNs/
	ygpeLVAXpCSVLHbDofCOmyJ4uuiLHJI0kIgBJufKhQh3p6a6xS4u28ssKoJO5qnE
	ACM1w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnhb733y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 21:17:43 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RKbDEA017795;
	Thu, 27 Jun 2024 21:17:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2awm65-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 21:17:42 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RLHct8016897;
	Thu, 27 Jun 2024 21:17:42 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2awm35-4;
	Thu, 27 Jun 2024 21:17:42 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, jeffxu@chromium.org, keith.lucas@oracle.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH v6 3/5] x86/pkeys: Update PKRU to enable all pkeys before XSAVE
Date: Thu, 27 Jun 2024 21:17:35 +0000
Message-Id: <20240627211737.323214-4-aruna.ramakrishna@oracle.com>
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
 phishscore=0 bulkscore=0 mlxlogscore=708 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270158
X-Proofpoint-GUID: 14Hfe2wu_-y3N6oyfjDSRgW-6sji9Hp-
X-Proofpoint-ORIG-GUID: 14Hfe2wu_-y3N6oyfjDSRgW-6sji9Hp-

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
 arch/x86/kernel/signal.c     | 10 +++++++++-
 2 files changed, 18 insertions(+), 3 deletions(-)

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
index 131eb4ae20fe..94147d85b0ee 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -246,8 +246,8 @@ static void
 handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	struct fpu *fpu = &current->thread.fpu;
-	u32 pkru = read_pkru();
 	bool stepping, failed;
+	u32 pkru;
 
 	if (v8086_mode(regs))
 		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
@@ -283,6 +283,8 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	if (stepping)
 		user_disable_single_step(current);
 
+	/* Update PKRU to enable access to the alternate signal stack. */
+	pkru = sig_prepare_pkru();
 	failed = (setup_rt_frame(ksig, regs, pkru) < 0);
 	if (!failed) {
 		/*
@@ -300,6 +302,12 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 		 * Ensure the signal handler starts with the new fpu state.
 		 */
 		fpu__clear_user_states(fpu);
+	} else {
+		/*
+		 * Restore PKRU to the original, user-defined value; disable
+		 * extra pkeys enabled for the alternate signal stack, if any.
+		 */
+		write_pkru(pkru);
 	}
 	signal_setup_done(failed, ksig, stepping);
 }
-- 
2.39.3


