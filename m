Return-Path: <linux-kernel+bounces-576198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749D0A70C4A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 22:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4329319A237C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 21:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CBA26981E;
	Tue, 25 Mar 2025 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HrGJ8LD9"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D145A269801
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938867; cv=none; b=qVVYPGf5CHeSt2JUwd340xXig69V7SQ1mPYo6nOsTP/C5SwGLZiOJUY0YWUdfmuedHVLgI9rHJE8vQZzDLBtU0eBp2jC+uGqpiwulvygdZoBeZYRyfBaBmjEQY4x/aPrWoXPl+V+4OveuYuE/4LUWap0duBygkaRhH8t8Pn7fw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938867; c=relaxed/simple;
	bh=Zjlpzy52vtaHSzR5R7++nRwr+yl+p7dd+nNv7dD9+FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PrjJCd7B3XJxz8P8NEpg20gw436uk2o1qbSKCPTtmTv/imYIp0Lsi8tTGWKrVDwqZXP6BoF+XK/gILKQqDaKomms2Y9XoGbTPVloWcjNq5Tzdv2yLmwR1LiY6QWPrj7LjHPqdS3c1rRSR8LTfUDer2s7KdVWV0ckIjlyx8lmSyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HrGJ8LD9; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PKgD3c008480;
	Tue, 25 Mar 2025 21:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=fCMPAO6DlvE1UmC+QwytBxb3VFXhf
	EP3FnZknEw8M2M=; b=HrGJ8LD9bIPKvtGnBZkYp3cLkVLu9PCNsaaJSIxTQg6xO
	VQrBOOPe5PoGORqzXN8JawIW03SHMJA+A3A2pTKjbeZTbUwLktyu1LZkMkfylI46
	k73GvMHiSh8pyAr9ifqGey+wpXmwa/DRhFB0PY6jzAoLvXvlayZu5Syyv05WMosF
	FGm2vZWxkjGidx/dNl5s7OBLDI8atrS+dFFiXuQ/+RcuSFGKzDmuhivlMegUKFa9
	aDk9COiIy2M+xutxjM/lomBvCaLslreN858KpZErZHni2vL3Pv8E8fus/PT/WQC0
	69WU54dMMtSKIOJWyQv93sZKxeD+cnqkyKJjHHO9Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hn8702wr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 21:40:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52PJw4fP029858;
	Tue, 25 Mar 2025 21:40:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45jjc1fvy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 21:40:57 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52PLdhVW019800;
	Tue, 25 Mar 2025 21:40:57 GMT
Received: from sidkumar-mac.us.oracle.com (dhcp-10-43-113-105.usdhcp.oraclecorp.com [10.43.113.105])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 45jjc1fvwp-1;
	Tue, 25 Mar 2025 21:40:57 +0000
From: Sidhartha Kumar <sidhartha.kumar@oracle.com>
To: mingo@kernel.org, peterz@infradead.org, lucas.demarchi@intel.com
Cc: linux-kernel@vger.kernel.org, ravi.bangoria@amd.com,
        lorenzo.stoakes@oracle.com, liam.howlett@oracle.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH] testing/radix-tree: add cleanup.h to shared/linux
Date: Tue, 25 Mar 2025 17:40:49 -0400
Message-ID: <20250325214049.87817-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_09,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503250144
X-Proofpoint-GUID: RtPIaHpBTUiEjwscYTJ_jojV6zBaPMcI
X-Proofpoint-ORIG-GUID: RtPIaHpBTUiEjwscYTJ_jojV6zBaPMcI

Create a cleanup.h implementation in tools/testing/shared/linux to build
the idr code within userspace. This is needed after commit 6c8b0b835f00
added #include <linux/cleanup.h> to include/linux/idr.h to build the
userpsace radix-tree testsuite.

Fixes: 6c8b0b835f00 ("perf/core: Simplify perf_pmu_register()")
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
Once 6.14 is stable after the merge window this will have to be CCed to
the 6.14 stable branch

 tools/testing/shared/linux/cleanup.h | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/testing/shared/linux/cleanup.h

diff --git a/tools/testing/shared/linux/cleanup.h b/tools/testing/shared/linux/cleanup.h
new file mode 100644
index 000000000000..7c811dbb956c
--- /dev/null
+++ b/tools/testing/shared/linux/cleanup.h
@@ -0,0 +1 @@
+#include "../../../../include/linux/cleanup.h"
-- 
2.39.5



