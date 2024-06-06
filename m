Return-Path: <linux-kernel+bounces-205127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C3F8FF7BB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20B35285BAE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C849B14036D;
	Thu,  6 Jun 2024 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ve+QadEL"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326B413F42E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713661; cv=none; b=f9XowpwpZVpetUuPsk3kwZKw5psABtxs72oMJQlIpsXvHmlv/ueTMKW0yTITYVyLDV3VrmnxFMJVEoyO8Dv1EiI+j5089aaTDTbXtGPxrEBgcVU86FphLaq9B+UVl3ubEN//aGvZWEN/eknBe9JwLUJhwXFwIr6dvT7UXg5kQoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713661; c=relaxed/simple;
	bh=byLEVOEAyGF2WqnaDcyJv5bVHKJ/dSgrdufHxeMItgY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PAAADrwHDIe2Myd4JUKe0VrqeBYfnTpnus2Y+NuLwkUKx46TsmtCnCerYzecGHCsM6U1dLR+syaraf6ZygWfw2un+tZQk9soHdMJ24rFamZg71rwyR4KOAFah9PzK+zpNnSXsCdp4MIJGX/y7AiUx8KTojZn9dYzfLGtTMkDb74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ve+QadEL; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456HwlFF026840;
	Thu, 6 Jun 2024 22:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=corp-2023-11-20;
 bh=nqR21MDKuxMT1J9GlTYAm6s4qP6FtJSxTQTSf2k0Uf8=;
 b=Ve+QadEL1tNRse7af8D/ALXO98axnFy9K4DMDYvEdD+744pXZhRNv+abEbwVIpXZ3+lT
 Wj2V5YlSy5fWJ5NdKz88aoaK95jnGalKa49vQnMnSA9pudCNyMdg4k7QoeWQg+XVuFBA
 3wh5PoqPG7GQOTlJV0EssiH8aXM0ZqWp+TFB23HVWzu82e6aLNRUUkk0Q/Mdn//TTTK8
 nGzszUwAT/LwR8Ekr2p1U4SceJ/l/V0ILWfhjQyBwKWQbkfVk5PVg08DBZEdeiBHXMAQ
 OOsJe3Sjg7u/ZA29eXsjfjfi3gzdavD459IGB41lGOHSxQjxnECqYVy/y8dRiGbBFnd7 qw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ykct314t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 22:40:41 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456LwcYS005496;
	Thu, 6 Jun 2024 22:40:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmh5aka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 22:40:40 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456MebVQ028229;
	Thu, 6 Jun 2024 22:40:40 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ygrmh5ag4-4;
	Thu, 06 Jun 2024 22:40:40 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: [PATCH v5 3/5] x86/pkeys: Update PKRU to enable minimally required pkeys before XSAVE
Date: Thu,  6 Jun 2024 22:40:33 +0000
Message-Id: <20240606224035.3238985-4-aruna.ramakrishna@oracle.com>
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
 suspectscore=0 spamscore=0 mlxlogscore=798 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060156
X-Proofpoint-GUID: UUgZ2Fn-qTh67K-zJHyYlesiT_7htbcy
X-Proofpoint-ORIG-GUID: UUgZ2Fn-qTh67K-zJHyYlesiT_7htbcy

If the alternate signal stack is protected by a different pkey than the
current execution stack, copying xsave data to the sigaltstack will fail
if its pkey is not enabled. Enable the extra pkey needed, before xsave,
so that the signal handler accessibility is not dictated by the PKRU
value that the thread sets up. But this updated PKRU value is also
pushed onto the sigframe, so overwrite that with the original, user-defined
PKRU value so that the value restored from sigcontext does not have the extra
pkey enabled.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 arch/x86/kernel/fpu/signal.c | 10 ++++++++--
 arch/x86/kernel/signal.c     | 10 +++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index b0b254b931fd..1065ab995305 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -168,8 +168,14 @@ static inline bool save_xstate_epilog(void __user *buf, int ia32_frame,
 
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
 
 	if (use_fxsr())
 		return fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 3fa66b2fe753..659faf076b48 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -243,8 +243,8 @@ static void
 handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 {
 	struct fpu *fpu = &current->thread.fpu;
-	u32 pkru = read_pkru();
 	bool stepping, failed;
+	u32 pkru;
 
 	if (v8086_mode(regs))
 		save_v86_state((struct kernel_vm86_regs *) regs, VM86_SIGNAL);
@@ -280,6 +280,8 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
 	if (stepping)
 		user_disable_single_step(current);
 
+	/* Update PKRU to enable access to the alternate signal stack. */
+	pkru = sig_prepare_pkru();
 	failed = (setup_rt_frame(ksig, regs, pkru) < 0);
 	if (!failed) {
 		/*
@@ -297,6 +299,12 @@ handle_signal(struct ksignal *ksig, struct pt_regs *regs)
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


