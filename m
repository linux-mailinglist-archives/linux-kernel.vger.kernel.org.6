Return-Path: <linux-kernel+bounces-233034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF2F91B165
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFC32B25714
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06831A08AB;
	Thu, 27 Jun 2024 21:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BlDeKEOf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0401A2FAB
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 21:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523085; cv=none; b=krb51WKVIea1SpeSwedaTuwMin5lzCTV5CdWKzWV1yM8kWNq12iiBdrYa5SUobdnj58E0RNWbzu0MIH18DyRv4nPOOslK/yQh2gXAnx9ANSwz4vR82PqxMLbcRETghDvNoNoO39FzNgjbh9n78Ydz47hYkmskW8GQbs2pmUpFzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523085; c=relaxed/simple;
	bh=UMqyaDLPn8qyAuBlK5GPRRhciqBeRqd+6Q8p2+QrOGE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ShpZwPZu4rEtssSQnUK3ZQlBZ1ps84WB1vyhPYjqO4TPTu4wPLFWIS47xjnPzt6NrBFhOHBko3CVjmpuusA4MCgsmBxT4/OgiGog3DPb7J+psm5vFcZHMPJzAA0cPtpfCZESUy33YEuMllwn9cGM/dz8Nzs/fP+GZbI4zEQUyqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BlDeKEOf; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RKBZMs016826;
	Thu, 27 Jun 2024 21:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=o
	xEkNOypdOO9MwzY548tCrP7QTtxGB1isXsL/qXNrtQ=; b=BlDeKEOfa64pC50W/
	J+6yVpEozPaSMDIfoVp0KMixHpxFWX1sC3Ozrels2oo/z11Tm4+1/rm1/NT4mXwU
	AQNIEC+qTN7gIVTzOT6UWkJhxeZgOqKsfCkQ9FWaYTT2hi05zsKUPUv4FQ/8X+z3
	takg7NXe4C7Nkw60hX/Xy6tBolmprgBEPRnqVb9/RKYVv5T02nR/E6rd7gTSyLhj
	F34s/M96XUs3OJGJHuyS0kWpjbzM5RMkoYP2QhnNrGbEzREvVSUg6TPG7RCjOIUF
	j1K/aJ/HOJmqcvALwXESy8PpJ/zP1yjIyAJd2uhay8Yqixwg6PEQ47qtA8NkzCv+
	tin2Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg9eqj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 21:17:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RK7HL8017872;
	Thu, 27 Jun 2024 21:17:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2awm6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 21:17:43 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RLHctA016897;
	Thu, 27 Jun 2024 21:17:43 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2awm35-5;
	Thu, 27 Jun 2024 21:17:43 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, jeffxu@chromium.org, keith.lucas@oracle.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH v6 4/5] x86/pkeys: Restore altstack before sigcontext
Date: Thu, 27 Jun 2024 21:17:36 +0000
Message-Id: <20240627211737.323214-5-aruna.ramakrishna@oracle.com>
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
 phishscore=0 bulkscore=0 mlxlogscore=659 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270158
X-Proofpoint-ORIG-GUID: GTYHIgk2PUpN0USsvsy_aHMWSglM7yAF
X-Proofpoint-GUID: GTYHIgk2PUpN0USsvsy_aHMWSglM7yAF

A process can disable access to the alternate signal stack and still
expect signals to be delivered correctly. handle_signal() updates the
PKRU value to enable access to the altstack, and makes sure that the
value on the sigframe is the user-defined PKRU value so that it is
correctly restored. However, in sigreturn(), restore_altstack() needs
read access to the altstack. But the PKRU has already been restored
from the sigframe (in restore_sigcontext()) which will disable access
to the altstack, resulting in a SIGSEGV.

Fix this by restoring altstack before restoring PKRU.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 arch/x86/kernel/signal_32.c | 4 ++--
 arch/x86/kernel/signal_64.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index b437d02ecfd7..348e855cecc6 100644
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
index ccfb7824ab2c..c5cf01898e83 100644
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


