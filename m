Return-Path: <linux-kernel+bounces-272163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E60D89457FB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6451A1F23329
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD0754907;
	Fri,  2 Aug 2024 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ly9M5/XM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8052D4D5A2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722579225; cv=none; b=U4uN+xe5oGSjIgOPI7YwD9YyWk3OXcJx7eDVcMYeFDmaMBZLk/QzpUJ8WmCwGosu+o9lxMHAxrm5oVAKcVgpYKvyLbq4ydzVZmrwAEjbT21spqasPCu9mQzaAVlITKgWnoVPCFxPvCBgpgOzV0ZQjZEfeE0p3gbyXQMA2yD90tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722579225; c=relaxed/simple;
	bh=/t5z+Y4FkxUszWqBuaS5ho2oIrqDFpJoHKA3VeES+nc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TBMa7y1o+D0uXIr+U/5NiYTD8ObXklCObCQI0QF9R/v+qyDhopncSaUjJRDSo6a6jDscMVTNo7z9+vg1Nt+5sIk0CIjZLkf6r7nbotytCXLGnl8vDCKDY14+d5nqKy3vhdEekxILtWsJ6mLnFspQd/7fkxtRCIZj/hqu0Nm1DmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ly9M5/XM; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4723fWAO014063;
	Fri, 2 Aug 2024 06:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=e
	ZsWPjqt9igVLLfyYoImyfjamrleTEsRR59euvfi/uU=; b=ly9M5/XMN50caH+On
	K4wdxhKIIms2UXPoqXPeJI3i/emdC2KlkAHxEZBLwt6WHFNCEyyKUA2qVQ2bEwdF
	o+Kh9NcFLczwRWdf5zAuXKhq0PkHZcwPsHBLXxwQszLd+4Zbinz60FbyAy6Lpxh1
	0cYNAdfiYZPjNPIMrl1xHaWUPD2bC3b5zvCNtoZP0RBY1tfZBmzqV2DTm9j5VAZg
	Sl5uchU4b7Q3LeD4z0AOinvNWiM+rn7Y2nfMDMEOhe2S6bV+LYvGJyHUQHV4Ursu
	lWTgPf/nUSnb+9py3Wf2YZjpIF8sVew2XSqzySN1CjO+c7X5NGi0FPJnulzMQg1U
	i/nMA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40rje8gfpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 06:13:31 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4725Kkd2035587;
	Fri, 2 Aug 2024 06:13:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvp16ecs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 06:13:30 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4726BM9e012716;
	Fri, 2 Aug 2024 06:13:29 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40nvp16e89-4;
	Fri, 02 Aug 2024 06:13:29 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, linux-mm@kvack.org, keith.lucas@oracle.com,
        jeffxu@chromium.org, rick.p.edgecombe@intel.com, jorgelo@chromium.org,
        keescook@chromium.org, sroettger@google.com, jannh@google.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH v8 3/5] x86/pkeys: Update PKRU to enable all pkeys before XSAVE
Date: Fri,  2 Aug 2024 06:13:16 +0000
Message-Id: <20240802061318.2140081-4-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240802061318.2140081-1-aruna.ramakrishna@oracle.com>
References: <20240802061318.2140081-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_03,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408020042
X-Proofpoint-ORIG-GUID: S97hVEZBG6yFs3QhGhznPAQKNC_Vjpe_
X-Proofpoint-GUID: S97hVEZBG6yFs3QhGhznPAQKNC_Vjpe_

If the alternate signal stack is protected by a different pkey than the
current execution stack, copying xsave data to the sigaltstack will fail
if its pkey is not enabled in the PKRU register.

We do not know which pkey was used by the application for the altstack,
so enable all pkeys before xsave.

But this updated PKRU value is also pushed onto the sigframe, which
means the register value restored from sigcontext will be different from
the user-defined one, which is unexpected. Fix that by overwriting the
PKRU value on the sigframe with the original, user-defined PKRU.

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


