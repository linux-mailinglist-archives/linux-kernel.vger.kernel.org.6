Return-Path: <linux-kernel+bounces-270753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2057B9444CE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD0DF1F2395B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F36A16EB55;
	Thu,  1 Aug 2024 06:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QmuxIMEs"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174F7158543
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495116; cv=none; b=HHW9C7283vacjn07UXKa0SUV2dkNz6IrPGzuwzZb39gn2tnXxDxpyrsdkfiKOPoZWzd1Icn1gdMOx+8Y00WCZgWf6ck+TFCifkxd4KqWBJg0LdhnR9sgfNPRoCcepi8nPKtuJx+QJhhM1t5m6IJXOIwK32gTeGlahaqH6IySHEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495116; c=relaxed/simple;
	bh=aSnvT7ai90hpt5T/FM8Lr/LeRdgsdap/YvEgHePpwaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DFm7+N5JnmqlgEpRiiozrUf01vRRAwGjoBI3oedMCLSjAEgXZA02bSUZQtwXQgtUTo3s1b/WMkrzy/BARMMKL/lTkC6KzPGW2pTGHKdEyZFfwrWDEk91BGneRjPDFOZv9LVrXbj/eu9dwCFo4kp2pfhGpchgV8wNNQ8JW0zgOVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QmuxIMEs; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VLGvI7005722;
	Thu, 1 Aug 2024 06:51:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=T
	iPmGpJvBPhD8zSOmWsEhmg/C+5nGFb/MfYfG1gbkVA=; b=QmuxIMEsmOylZZHcp
	3tB7pf/SfuPM5WipqYh3HAoXRqtrnnXPp//shK3e/NIeFTAiweK9nlSdeT5Guj2T
	R003eLscY/xiMw9Oe+l4jvZHxzkjVIbd4P2cpxbhKF1Yyk53r6iSLRYEgZiHQNCD
	vRW0eu3c757IPbM5JyJ+wcHEo1LkBT4ozT+Q6/TZmYCzUa8TzgNnVhiAxjSQw6LV
	pnWnexgkhnvucZNENRymoDrH4hpMz5666W26UY00gVUBC+EvBbER4n+iuOg3ksLG
	o7jJ0H7Ambgda4XobKsSmCzeGJ3xWRCwxd8Y6XqWoDgfLYsdFwOiM7mWXKi92jct
	//lgg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqp214nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 06:51:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4716KoVS030932;
	Thu, 1 Aug 2024 06:51:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nehveh80-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 06:51:19 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4716pHNK033596;
	Thu, 1 Aug 2024 06:51:19 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40nehveh6x-5;
	Thu, 01 Aug 2024 06:51:19 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, linux-mm@kvack.org, keith.lucas@oracle.com,
        jeffxu@chromium.org, rick.p.edgecombe@intel.com, jorgelo@chromium.org,
        keescook@chromium.org, sroettger@google.com, jannh@google.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH  v7 4/5] x86/pkeys: Restore altstack before sigcontext
Date: Thu,  1 Aug 2024 06:51:15 +0000
Message-Id: <20240801065116.2088582-5-aruna.ramakrishna@oracle.com>
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
 mlxlogscore=853 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010038
X-Proofpoint-ORIG-GUID: z5XWOE0O2Xt7mvn-1DCV-HJyBg0uYceS
X-Proofpoint-GUID: z5XWOE0O2Xt7mvn-1DCV-HJyBg0uYceS

A process can disable access to the alternate signal stack and still
expect signals to be delivered correctly. get_sigframe() updates the
PKRU value to enable access to the altstack, and makes sure that the
value on the sigframe is the user-defined PKRU value so that it is
correctly restored. However, in sigreturn(), restore_altstack() needs
read access to the altstack. But the PKRU has already been restored
from the sigframe (in restore_sigcontext()) which will disable access
to the altstack, resulting in a SIGSEGV.

Fix this by restoring altstack before restoring PKRU.

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
---
 arch/x86/kernel/signal_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 8a94053c5444..ee9453891901 100644
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


