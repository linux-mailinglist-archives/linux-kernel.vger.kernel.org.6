Return-Path: <linux-kernel+bounces-414756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 159D59D2DBF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6AC5CB2E08F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D93C1D26F6;
	Tue, 19 Nov 2024 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ARrTl3S2"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64FD1D1F44
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038341; cv=none; b=Ic/AaYAzrElvffwdDxA7/qPp/dp0kZon0Y+NyOJg5Ao4w0Bo+IdBG1ymtPTVoh8gR21FkMJa+fe09s7OJ+UogSl7EdbgJ55iWTHlLTa/brpzkM5incnsTpmvTQq4VnZ4sVdAPjETmOx+IOoalDPdH+wX0LdDZdexC5YG+fIlWMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038341; c=relaxed/simple;
	bh=ARZC07e2VA7V52AR6e6Yzy7xH9dv/4TYd1Swx9rjPDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlsW6fhV0rNIQAHUlQlzqeDW1TgQo+kA/s+MQD7PsiWhWNjsCMqQ79Qfxo/+FOXd3K70QQryoAUDds8gmm2JxMuAPdHi9alhkjuXLRhb7wOtEcImohwwlY7I4QkC7ky1WE+WW3UxQkpzn/e21efHLXWng/PvCn2gb4Tar+J6sMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ARrTl3S2; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJHBjU7011388;
	Tue, 19 Nov 2024 17:45:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=oCfH9
	2pQ9Va7b0K62RUYg0DlgYPYNRosAahDiewCId8=; b=ARrTl3S2y6tzqAjsc7kzi
	mSrS9+SsatXH2u2pUc8kPbEljzMYZQpGW6PLyvOdg9avikFFFlLtyq9SBJ6YStdI
	9guMIHkx8vbyTf2BJnMxrjShv7YZeLWnNGoKhmODj+1lDa443c9O2p9YW78P7L9f
	HwrH/4VwHKZYGyllwkJ4lrgCjERbCa8FLwmHM/U6v893K6+olWnjYG2xPmyflDa0
	Pi/NZY/+/qSdr3cWOachUc8wUXeIVK07qhwcfKTdaKi5zMgwULo2ZayZQbS7paZB
	oOE6ZwMWj/HLJTFlb8d92ykOI8eTD7Jw3S8trBipCow1M1haKVwv6y3crF5BquPe
	Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xhyydk46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 17:45:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJHIDkP023119;
	Tue, 19 Nov 2024 17:45:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu99djn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 17:45:22 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AJHfRnd008507;
	Tue, 19 Nov 2024 17:45:22 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42xhu99dh7-3;
	Tue, 19 Nov 2024 17:45:22 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, rudi.horn@oracle.com, joe.jin@oracle.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH v3 2/2] x86/pkeys: Set XSTATE_BV[PKRU] to 1 so that PKRU is XRSTOR'd correctly
Date: Tue, 19 Nov 2024 17:45:20 +0000
Message-ID: <20241119174520.3987538-3-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241119174520.3987538-1-aruna.ramakrishna@oracle.com>
References: <20241119174520.3987538-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-19_09,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190132
X-Proofpoint-ORIG-GUID: efD9yKEYH-nh7erbRnLOah8AIbK0k4xD
X-Proofpoint-GUID: efD9yKEYH-nh7erbRnLOah8AIbK0k4xD

PKRU value is not XRSTOR'd from the XSAVE area if the corresponding
XSTATE_BV[i] bit is 0. A wrpkru(0) sets XSTATE_BV[PKRU] to 0 on AMD
systems, which means the PKRU value updated on the sigframe later on,
in update_pkru_in_sigframe(), is ignored.

To make this behavior consistent across Intel and AMD systems, and to
ensure that the PKRU value updated on the sigframe is always restored
correctly, explicitly set XSTATE_BV[PKRU] to 1.

Fixes: 70044df250d0 ("x86/pkeys: Update PKRU to enable all pkeys before XSAVE")

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Suggested-by: Rudi Horn <rudi.horn@oracle.com>
---
 arch/x86/kernel/fpu/xstate.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 6b2924fbe5b8..aa16f1a1bbcf 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -72,10 +72,22 @@ static inline u64 xfeatures_mask_independent(void)
 /*
  * Update the value of PKRU register that was already pushed onto the signal frame.
  */
-static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u32 pkru)
+static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 mask, u32 pkru)
 {
+	u64 xstate_bv;
+	int err;
+
 	if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
 		return 0;
+
+	/* Mark PKRU as in-use so that it is restored correctly. */
+	xstate_bv = (mask & xfeatures_in_use()) | XFEATURE_MASK_PKRU;
+
+	err =  __put_user(xstate_bv, &buf->header.xfeatures);
+	if (err)
+		return err;
+
+	/* Update PKRU value in the userspace xsave buffer. */
 	return __put_user(pkru, (unsigned int __user *)get_xsave_addr_user(buf, XFEATURE_PKRU));
 }
 
@@ -292,7 +304,7 @@ static inline int xsave_to_user_sigframe(struct xregs_state __user *buf, u32 pkr
 	clac();
 
 	if (!err)
-		err = update_pkru_in_sigframe(buf, pkru);
+		err = update_pkru_in_sigframe(buf, mask, pkru);
 
 	return err;
 }
-- 
2.43.5


