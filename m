Return-Path: <linux-kernel+bounces-408136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF289C7AD7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03BD4281A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D122036E3;
	Wed, 13 Nov 2024 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cvRbvTux"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65F21632CC
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521686; cv=none; b=sfsQYVAtJD/AtomGtdQCy9z1pkevi3cT+T9ckOOTKAsyo03khX7fpUTXcwxLBzilJyImD06Azck4Y0iju6Z/ho9iEjLs+fOXW8OvdiXILGa0X92bpeUieGaEacPila6lCDgWTa8hPn6v4VtI+o1gkUtK8rFGXfyiYOsA2VXsoug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521686; c=relaxed/simple;
	bh=/YmEyntefLYzGe6+Sv86XHjBZDvwwWH9TzKWcbvWHkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAmzJXbsj3m2xI/qHPTeCcQ9ywAzC06rhFz1+ZfIcr+qok1xewbDJas9k7i2rbYsPPzLZmtOWFN9v7VVEGA8ruQQJz4KFZryxS4rpKj9zwT2L+v+13yVyxSyb4eqn5gnfZOtRf3yU7pwLbXM2JRvZkzkcNZoSQ9QjmhVgY/0aPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cvRbvTux; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADIBgK7010043;
	Wed, 13 Nov 2024 18:14:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=0/K9Q
	M+wILxQRceNZJ7EGDLAQg+gnnfi9/2L7ArMYV4=; b=cvRbvTuxnzPxE92ql/gJR
	eh5zJwSLQLLfV7C/QjbFMCnlpoycdoOY5TCw8LCpeMT92oq6py4QtXPRRqfE4Sfh
	ioQh2O0otU6bn25P3emyUq3FvLy1lgVzyOd9IhMHrIEqPYizzS4rbddkPGzNxGex
	edef64K6V44eJxApbI0QXe5DCj5RcMNAZrUdCBqr+5NKK+oo5ytyDFv3A2ko4zEg
	TqD4kZ2msM9dtw3OpeCXj5hXcGQmjZ2RhqMFAMLDBjdnZkG7h5p7qvtNvzKinhJP
	04M/HVJeGmb7JAPyz7GM4bGtlAgiMwuaHePo4h1UK6IlPXZ4x/eKtFCnYgwUjXQp
	Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kbykmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 18:14:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADGuaY8000355;
	Wed, 13 Nov 2024 18:14:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbp91yyr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 18:14:37 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4ADIEaKu022346;
	Wed, 13 Nov 2024 18:14:37 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42tbp91yxm-2;
	Wed, 13 Nov 2024 18:14:37 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, rudi.horn@oracle.com, joe.jin@oracle.com
Subject: [PATCH 2/2] x86/pkeys: Set XINUSE[PKRU] to 1 so that PKRU is XRSTOR'd correctly
Date: Wed, 13 Nov 2024 18:14:36 +0000
Message-ID: <20241113181436.3518359-2-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241113181436.3518359-1-aruna.ramakrishna@oracle.com>
References: <20241113181436.3518359-1-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_10,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130150
X-Proofpoint-GUID: XqLPrSrjBJ1ogtJPxzdSu-sVAV_Tz1nS
X-Proofpoint-ORIG-GUID: XqLPrSrjBJ1ogtJPxzdSu-sVAV_Tz1nS

PKRU value is not XRSTOR'd from the XSAVE area if the corresponding
XINUSE[i] bit is 0. When PKRU value is set to 0, it sets XINUSE[PKRU]
to 0 on AMD systems, which means the value updated on the sigframe
later (after a wrpkru(0)) is ignored.

To make this behavior consistent across Intel and AMD systems, and to
ensure that the PKRU value updated on the sigframe is always restored
correctly, explicitly set XINUSE[PKRU] to 1 in
update_pkru_in_sigframe().

Fixes: 70044df250d0 ("x86/pkeys: Update PKRU to enable all pkeys before XSAVE")

Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Suggested-by: Rudi Horn <rudi.horn@oracle.com>
---
 arch/x86/kernel/fpu/xstate.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.h b/arch/x86/kernel/fpu/xstate.h
index 6b2924fbe5b8..b5056fcdd21e 100644
--- a/arch/x86/kernel/fpu/xstate.h
+++ b/arch/x86/kernel/fpu/xstate.h
@@ -72,10 +72,22 @@ static inline u64 xfeatures_mask_independent(void)
 /*
  * Update the value of PKRU register that was already pushed onto the signal frame.
  */
-static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u32 pkru)
+static inline int update_pkru_in_sigframe(struct xregs_state __user *buf, u64 mask, u32 pkru)
 {
+	u64 xinuse;
+	int err;
+
 	if (unlikely(!cpu_feature_enabled(X86_FEATURE_OSPKE)))
 		return 0;
+
+	/* Mark PKRU as in-use so that it is restored correctly. */
+	xinuse = (mask & xfeatures_in_use()) | XFEATURE_MASK_PKRU;
+
+	err =  __put_user(xinuse, &buf->header.xfeatures);
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


