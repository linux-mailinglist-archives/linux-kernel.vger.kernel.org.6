Return-Path: <linux-kernel+bounces-205123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B588FF7B6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 00:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29C4D1F25717
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 22:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452C913DB8C;
	Thu,  6 Jun 2024 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Dlyf+jeJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302177347F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717713651; cv=none; b=KnJT3/jDUkAjlqrz5hCRX8/R/eX66MkZwl6I5RMf5uTiem6wAIdoHNbuQWikFkduaIaLe6Knw97YOYwMshNksSSkbl/XUixRBRODfxLrMQMQtxwIZaVYAkWizknZe/Amj9SWiKKDtwWfXXdKYPlZ80spuoM6/XMjARqnokKxqAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717713651; c=relaxed/simple;
	bh=GbA0cyCjBNHssMdLg2uyzibTQJMbmfAMQ9ghK7aiorI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WUwDfqAbIO3eQAOWABMc2h3LVziUvGLoiNejA8F/D+uiBO2m5J2+isBdoaJ8Tc4MloSswkdlO+RaTFPcjY+fRzri/QA0LFuV/+x2pP514djzOmpM/gNncBMh5uZRQzuHdKV3r56RygYD9+rl7HTpAr+v1zcAj0B1v+sIvNIfUlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Dlyf+jeJ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 456HxbCM021769;
	Thu, 6 Jun 2024 22:40:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version :
 subject : to; s=corp-2023-11-20;
 bh=/SteTQyFWSm7Kqf5FTs4L5TqDm6uxthfBN+xP+dq324=;
 b=Dlyf+jeJfGLrQZ3YytdCVxj1nqUmf6CsZL/bewdk6059zhKZEbuIcElaL4Agxw+aygUD
 Gyqt9qY8n7s/RVLnqLN7Sxq4QeJ2DCQJhz59XyyNRi8RPJ+ECjuybvt3uPhCGWlbKn2V
 /NYdPabRlL1lh0/17AIDNTrdoyb69LHag+FW04o2zBnYwLZmlEfQt9cr9zx3Oynk1San
 z1vkPZeMBZc+7JRdTbcxKzZBi3QTNIhkrCl1FsyhcD2RaPomszs76RzuAnbR+Q6I96Z1
 4LCz9mVBDC5fOeUrcKlxwi9i4AclPw2Sx8TW316Htl9Z7dDNrOZzJk9lwFUwEZH/vwGr QA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbsycj3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 22:40:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456LXeuv005564;
	Thu, 6 Jun 2024 22:40:37 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmh5agv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 22:40:37 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 456MebVK028229;
	Thu, 6 Jun 2024 22:40:37 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ygrmh5ag4-1;
	Thu, 06 Jun 2024 22:40:37 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, keith.lucas@oracle.com, aruna.ramakrishna@oracle.com
Subject: [PATCH v5 0/5] x86/pkeys: update PKRU to enable pkey 0 before XSAVE
Date: Thu,  6 Jun 2024 22:40:30 +0000
Message-Id: <20240606224035.3238985-1-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.39.3
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
 suspectscore=0 spamscore=0 mlxlogscore=832 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060156
X-Proofpoint-GUID: pQiM5FlqGqkCyJtk07FQsII0xCFmwzs_
X-Proofpoint-ORIG-GUID: pQiM5FlqGqkCyJtk07FQsII0xCFmwzs_

v5 updates:
- No major changes, mostly a resend of v4 - except for updating the
  commit description for patch 5/5

v4 updates (based on review feedback from Thomas Gleixner):
- Simplified update_pkru_in_sigframe()
- Changed sigpkru to enable minimally required keys (init_pkru and
  current
  pkru)
- Modified pkey_sighandler_tests.c to use kselfttest framework
- Fixed commit descriptions
- Fixed sigreturn use case (pointed out by Jeff Xu)
- Added a new sigreturn test case

v3 updates (based on review feedback from Ingo Molnar and Dave Hansen):
- Split the original patch into 3:
        - function interface changes
        - helper functions
        - functional change to write pkru on sigframe
- Enabled all pkeys before XSAVE - i.e. wrpkru(0), rather than assuming
that the alt sig stack is always protected by pkey 0.
- Added a few test cases in pkey_sighandler_tests.c.

I had some trouble adding these tests to
tools/testing/selftests/mm/protection_keys.c, so they're in a separate
file.

Aruna Ramakrishna (4):
  x86/pkeys: Add PKRU as a parameter in signal handling functions
  x86/pkeys: Add helper functions to update PKRU on sigframe
  x86/pkeys: Update PKRU to enable minimally required pkeys before XSAVE
  x86/pkeys: Restore altstack before sigcontext

Keith Lucas (1):
  selftests/mm: Add new testcases for pkeys

 arch/x86/include/asm/fpu/signal.h             |   2 +-
 arch/x86/include/asm/sighandling.h            |  10 +-
 arch/x86/kernel/fpu/signal.c                  |  27 +-
 arch/x86/kernel/fpu/xstate.c                  |  13 +
 arch/x86/kernel/fpu/xstate.h                  |   1 +
 arch/x86/kernel/signal.c                      |  42 +-
 arch/x86/kernel/signal_32.c                   |  12 +-
 arch/x86/kernel/signal_64.c                   |  14 +-
 tools/testing/selftests/mm/Makefile           |   5 +-
 tools/testing/selftests/mm/pkey-helpers.h     |  11 +-
 .../selftests/mm/pkey_sighandler_tests.c      | 479 ++++++++++++++++++
 tools/testing/selftests/mm/protection_keys.c  |  10 -
 12 files changed, 581 insertions(+), 45 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey_sighandler_tests.c


base-commit: a38297e3fb012ddfa7ce0321a7e5a8daeb1872b6
prerequisite-patch-id: d84439301b44c03df2555d3722ec512001ae52f2
-- 
2.39.3


