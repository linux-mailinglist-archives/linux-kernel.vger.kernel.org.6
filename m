Return-Path: <linux-kernel+bounces-272164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 614569457FA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBFE4B24059
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842456CDBA;
	Fri,  2 Aug 2024 06:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RHHJ7Oid"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D55F4C3D0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722579225; cv=none; b=kO/H4wUX4JcbxTS23tnyZkkazOA+7XVb4Xu5xN0cYOYqxrexuv4Y2BTbQjU8inrMVxYY0/Dtr7DoODvyG34debRjNPmmFMaXASqXZScO5546IAnGvJRo0qlkUoqbREZbFuYaM69aLX5dyCsokshw67+ntF7TG+xWQFNZCnUB07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722579225; c=relaxed/simple;
	bh=0KWuq9R4sYSgF5MxfVrEW2UXZCYHXcsjUvvMTyeZXck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u5R1MfReTFWECgIcbrll3ZdPLXH+xn7T+R/OM9zKqaZHLdat6LTVT2NlM5ZbFvoODMBfgZgHlrTnzxdbq5hBCR8YujicmpWFpdZOmJcQOd6wezRvbWONoLP5jbhlh3QOBbHNqs8p5DQtZrtuIGtspGG/NZ7KI0urCcjA7fVb2Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RHHJ7Oid; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4723fZoU014387;
	Fri, 2 Aug 2024 06:13:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=corp-2023-11-20; bh=d
	C6+NWDYa9BScJlqOtDM0/iHsWIj1RHBGXEYsjNKXAk=; b=RHHJ7OidTXyI1i/65
	BhPbtj7PWUXU10aGUkvAXr7hfJ56QdhAd1lIufHG3v/KgcQx/sS4qnP6lQ3qjU2h
	fo63xi+/45LqYLeUOz5wxbCbqon/UuRFSK+lePK/X2DUcZlRopQMcqWVjfXvzD6R
	SDeGgwSljAyv2LFjRGqKyOFfnCoXkDCV3HCit5nBUAHUuAwyrL51q593yn4I+mX0
	WVT3o6EMgs2pc2AhNa3ozZlrQJkmVGikd1VesSmhpdqX49Tx2i4SMRLrwth6wNjb
	W0Mvc1yBseSwFcgTLlQpa9uYx9KU3lMPUJEXE3T0ga4RLOvqFOBJoT2hmaPNfP/M
	95K+g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40rjdy0fvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 06:13:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47263n5e035583;
	Fri, 2 Aug 2024 06:13:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvp16edt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 06:13:32 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4726BM9g012716;
	Fri, 2 Aug 2024 06:13:31 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40nvp16e89-5;
	Fri, 02 Aug 2024 06:13:31 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, linux-mm@kvack.org, keith.lucas@oracle.com,
        jeffxu@chromium.org, rick.p.edgecombe@intel.com, jorgelo@chromium.org,
        keescook@chromium.org, sroettger@google.com, jannh@google.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH v8 4/5] x86/pkeys: Restore altstack access in sigreturn()
Date: Fri,  2 Aug 2024 06:13:17 +0000
Message-Id: <20240802061318.2140081-5-aruna.ramakrishna@oracle.com>
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
X-Proofpoint-ORIG-GUID: KOBn2c5DZ9EALtZZJv3Alwzwb6bZWd_P
X-Proofpoint-GUID: KOBn2c5DZ9EALtZZJv3Alwzwb6bZWd_P

A process can disable access to the alternate signal stack by not
enabling the altstack's pkey in the PKRU register. Nevertheless, the
kernel updates the PKRU temporarily for signal handling. However, in
sigreturn(), restore_sigcontext() will restore the PKRU to the
user-defined PKRU value. This will cause restore_altstack() to fail with
a SIGSEGV as it needs read access to the altstack which is prohibited
by the user-defined PKRU value.

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


