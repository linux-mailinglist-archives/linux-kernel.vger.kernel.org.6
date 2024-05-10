Return-Path: <linux-kernel+bounces-175533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C88B8C20FB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 11:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4691C21664
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4585D161333;
	Fri, 10 May 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZglHCqGD"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB83161320
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715333604; cv=none; b=QTpsGQfAe9FBZ7YJOiKAJ4VFEOyrMcj7TadIkl7Yks79iBksNW/bJxTr7NrNOLZIpz+p1AR55IuIcvIkhzqsb8PEGBOm6RoFK/xzHWFiZYt8Sw7ouCECHX4EohxyvAESjG4nJReJC87uS26bmQQ8WNzNInAbRoANvvIttYE56zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715333604; c=relaxed/simple;
	bh=efzkN/Q2La52OaF3L6FCw9JzyepB+Tla3zYLJlpuFbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OvpXS3L8csUcogQWj/EMi7T2wdp5Ym/zlc8uvrlfsbV1/XGWJ8Lqk8xuBkz/i4eZiI0bSoemZ/wZRvdiOc/8UBk98xtOlBP/FBGRk2CFGntnguU8oZrBl43nHDEjgarIIx95CYOlVn2mRu68dz5McwLgCMC/IMQ5+HpxSQnE/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZglHCqGD; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A7ZIuP018888;
	Fri, 10 May 2024 09:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=Mz+QntpnKV73Xce3+GpAUXu4jGV2SHVfVGWrzWB5ATM=;
 b=ZglHCqGD8u7Yvpkto//htCa/mRF69vAcGv1+HDfPLiCi0gQ+9w5XSYV+KAbv/gnd7ME7
 1mXc/HOI/uLc921aNsOOdel6eBXnqkDrIFwB1xoMWYY8yyULlpVItko6bZsLmCTEjG+7
 148UjbE78CRz+3P0th/guEsujUcGkfvXGZWndOSPiBwZudzNqOMajU+AN7XYBfJ8O0dQ
 i09it2nKhLE1wonEZhxtdeWlVnVgNv0D7VC5LGfOchzxmkump6Jic5H3uFodOKWA4Qkc
 bRz7IEvrF72X8CtVd3yvvoMrqQIw6Do+CZKwIRvF+odojjW9/qnQ/FcligbzXz/n81cD FA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y17x7rrge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 09:33:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44A98Mcw030898;
	Fri, 10 May 2024 09:33:05 GMT
Received: from localhost.uk.oracle.com (dhcp-10-175-179-215.vpn.oracle.com [10.175.179.215])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3xysfpka7v-1;
	Fri, 10 May 2024 09:33:05 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] objtool: builtin-check: Use "action" in opts_valid error message to be consistent with help
Date: Fri, 10 May 2024 15:02:57 +0530
Message-ID: <20240510093257.82634-1-siddh.raman.pant@oracle.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_06,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405100068
X-Proofpoint-GUID: z8I8B-BGM0Ky-o-BL4foi0-3vN8xCN6h
X-Proofpoint-ORIG-GUID: z8I8B-BGM0Ky-o-BL4foi0-3vN8xCN6h

The help message mentions the main options as "actions", which is
different from the optional "options". But the check error messages
outputs "option" or "command" for referring to actions.

Hence, make the error messages consistent with help.

Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
---
 tools/objtool/builtin-check.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 5e21cfb7661d..387d56a7f5fb 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -144,7 +144,7 @@ static bool opts_valid(void)
 	    opts.static_call		||
 	    opts.uaccess) {
 		if (opts.dump_orc) {
-			ERROR("--dump can't be combined with other options");
+			ERROR("--dump can't be combined with other actions");
 			return false;
 		}
 
@@ -159,7 +159,7 @@ static bool opts_valid(void)
 	if (opts.dump_orc)
 		return true;
 
-	ERROR("At least one command required");
+	ERROR("At least one action required");
 	return false;
 }
 
-- 
2.43.0


