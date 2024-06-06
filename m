Return-Path: <linux-kernel+bounces-205126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A138FF7B9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2E41F26254
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D3313F439;
	Thu,  6 Jun 2024 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lv9R9vtf"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3270613F431
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713659; cv=none; b=eZda6AFt9gfskoacBupNzeQofpVRWBRDnubKHN/pcDFq5rkDCd3AXgbG3/HqQawHj7f9nysqZ38NLaZZ7fNOPakl2G5dtL0NGGo63JddnrmHCbZ3xZ9MD4Ykp5aXn2Wiy77hrRRFinL9TNFMI9HBRVF9f32RmFFf9khDypa1Zh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713659; c=relaxed/simple;
	bh=tlwUG6i2dN04+SFgN9SBdBQln0TBzFDCm4yq8WOlNIQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rAOso2EEkRWsGBPZZJI9O345kMSRQiM3EmIHve5wkMkJcJq1ZCsiZNj+lXQloBM3VPQurv+S+//4ksCCmrdI7KH+BuHIbR1jiKec2VeifXYn7RjqJFiQnLtQGWlngGkWLYvK5b1wVUfqnGBMlkVDF7ynU4LwEbSNPgqSHBCOK0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lv9R9vtf; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456HwrvD029555;
	Thu, 6 Jun 2024 22:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=corp-2023-11-20;
 bh=KPsMX+2z7i40hslxQGSb/YJgYDxUNOarNeZ/dlWFyIc=;
 b=lv9R9vtf4PrVJbv/A/lqDxDFM932jXBknMLYbftFm1vZy0KD2UeENkAh0o42UwxR8+Cn
 CCOueNZStC3PgG0JKn/nuiMQJDfm2U7Uiiu21sckr9AtQUh6n40Da6lDt5tVvRTOFhyX
 In4v1ahl9SCOzeeFDMzYKadARbsJkOj75DVZF+xaNngTKxEwcebHMGMvFtvpO0xSwwaT
 96fdZYKVIzyMNBU28eVVhV85PGF7mN7/me+I2d5P60qrQn6aJd4+KLp8bLLMlS8Dlhq3
 EMIGBkEUaPjxtGDLDBXUJTfv9zLh3IuAN1vwRSNlWsEUdWTNpYBhul57gg3u4V7cHmyI Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrscfm4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 22:40:42 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456LpGRI005543;
	Thu, 6 Jun 2024 22:40:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmh5amc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 22:40:42 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456MebVS028229;
	Thu, 6 Jun 2024 22:40:41 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ygrmh5ag4-5;
	Thu, 06 Jun 2024 22:40:41 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: [PATCH v5 4/5] x86/pkeys: Restore altstack before sigcontext
Date: Thu,  6 Jun 2024 22:40:34 +0000
Message-Id: <20240606224035.3238985-5-aruna.ramakrishna@oracle.com>
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
 suspectscore=0 spamscore=0 mlxlogscore=724 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060156
X-Proofpoint-ORIG-GUID: YRa2sy84gLMLgHKQLd7NICrMSXVH8ooM
X-Proofpoint-GUID: YRa2sy84gLMLgHKQLd7NICrMSXVH8ooM

A process can disable access to the alternate signal stack and still
expect signals to be delivered correctly. handle_signal() updates the
PKRU value to enable access to the atlstack, and makes sure that the
value on the sigframe is the user-defined PKRU value so that it is
correctly restored. However, in sigreturn(), restore_altstack() needs
read access to the alt stack. But the PKRU is already restored from the
sigframe (in restore_sigcontext()) which will disable access to the
alt stack, resulting in a SIGSEGV.

Fix this by restoring altstack before restoring PKRU.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 arch/x86/kernel/signal_32.c | 4 ++--
 arch/x86/kernel/signal_64.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 68f2bfd7d6e7..c7a489f0d943 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -160,10 +160,10 @@ SYSCALL32_DEFINE0(rt_sigreturn)
 
 	set_current_blocked(&set);
 
-	if (!ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
+	if (restore_altstack32(&frame->uc.uc_stack))
 		goto badframe;
 
-	if (restore_altstack32(&frame->uc.uc_stack))
+	if (!ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
 		goto badframe;
 
 	return regs->ax;
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 6b189de005b5..2d053333fcf5 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -260,13 +260,13 @@ SYSCALL_DEFINE0(rt_sigreturn)
 
 	set_current_blocked(&set);
 
-	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
-	if (restore_signal_shadow_stack())
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
-	if (restore_altstack(&frame->uc.uc_stack))
+	if (restore_signal_shadow_stack())
 		goto badframe;
 
 	return regs->ax;
-- 
2.39.3


