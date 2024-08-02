Return-Path: <linux-kernel+bounces-272162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D0C9457FD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 08:14:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F038DB23D82
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 06:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BA454724;
	Fri,  2 Aug 2024 06:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IzzimLWM"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEA74C61B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 06:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722579225; cv=none; b=oLB1rzvysYyKmF1aGcUcdNHBjdlUEHfrHklF3LNzAU43GBptnnk3rhuw5V4hnC6K5WdwW4EIizA3aDxdB6G4J7PXNpivotTgupFwwcqBCL32S47wiP3/eQLTk3eiUVCf5uQdISHal2e0sTReJAZMC6NP4QGnBRU7bOgLFhhn5Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722579225; c=relaxed/simple;
	bh=ttxoVE4AZVMYSAY/NzJA7YfegPgZfVrWnSKKWUTftiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qyRvF545KDmY+I8ntMEEcW2YfownmkOYLkPP77Sk/0b/YMdaRFfkm+6+IbaGQfZTCHW9Akonvrwbnxq+dhYeOEjFNeE7xGrqzTtMDytrG8degpAhb0VfkLl8ats4FpsjH0ocoz26XbnhFMsg/HEywqm8wrePlm3KAdj0RjSMqho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IzzimLWM; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4723fWdx014378;
	Fri, 2 Aug 2024 06:13:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=8icyUdj43dziau
	j0xrsmeQuD/aTz/A64NReInB9aZYc=; b=IzzimLWMWvAGf6k3CGsloWcDCYr0RG
	w5rwngE4RulVFnzT80NeKxRx11hK2QlL8uteh8YCAR0dRjy4razzhLdEbEUYFV6w
	Dn0q7w0IZOJpOKtDx0ObwcPOV9hunJeH6U30Pd8vBu8szkrU28tAJZ54ce/6SBem
	YCd6np00C0r3ntp40kGz4QQfB+3Vaq4Q28ifr/XGTDFOLaKdDNZWHkeQDHvBE5do
	Eo5AVOGUHmGctyYbfcsqFF4Gkndp5eCrcMMjRZYjCueyI+4FuUSJFwb4a2ZTbXAz
	WOmmMaFimwbp9jAekUBttyFfIIvWn+zPe7yohnkOC/zPlz6MbJfZ6naw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40rjdy0fv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 06:13:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4724blSM035586;
	Fri, 2 Aug 2024 06:13:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40nvp16e9r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 Aug 2024 06:13:23 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4726BM9Y012716;
	Fri, 2 Aug 2024 06:13:22 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 40nvp16e89-1;
	Fri, 02 Aug 2024 06:13:22 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, linux-mm@kvack.org, keith.lucas@oracle.com,
        jeffxu@chromium.org, rick.p.edgecombe@intel.com, jorgelo@chromium.org,
        keescook@chromium.org, sroettger@google.com, jannh@google.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH v8 0/5] x86/pkeys: update PKRU to enable all pkeys before XSAVE
Date: Fri,  2 Aug 2024 06:13:13 +0000
Message-Id: <20240802061318.2140081-1-aruna.ramakrishna@oracle.com>
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
 definitions=2024-08-02_03,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=990 mlxscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408020042
X-Proofpoint-ORIG-GUID: m0w9hc6MQaIiUVwYaUupFncfHxGs7Xrm
X-Proofpoint-GUID: m0w9hc6MQaIiUVwYaUupFncfHxGs7Xrm

v8 updates:
- Edited changelog for better readability

v7 updates:
- Rebased patchset to v6.11.0-rc1
- Removed ia32 and x32 function interface changes as PKRU is only
  supported in 64-bit mode, as suggested by Jeff Xu

v6 updates:
- Rebased patchset to v6.10.0-rc5
- Changed sig_prepare_pkru() back to enabling all pkeys, based on
  discussion with Jeff Xu

v5 updates:
- No major changes, mostly a resend of v4 - except for updating the
  commit description for patch 5/5

v4 updates (based on review feedback from Thomas Gleixner):
- Simplified update_pkru_in_sigframe()
- Changed sigpkru to enable minimally required keys (init_pkru and
  current pkru)
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
  x86/pkeys: Add helper functions to update PKRU on the sigframe
  x86/pkeys: Update PKRU to enable all pkeys before XSAVE
  x86/pkeys: Restore altstack access in sigreturn()

Keith Lucas (1):
  selftests/mm: Add new testcases for pkeys

 arch/x86/include/asm/fpu/signal.h             |   2 +-
 arch/x86/kernel/fpu/signal.c                  |  27 +-
 arch/x86/kernel/fpu/xstate.c                  |  13 +
 arch/x86/kernel/fpu/xstate.h                  |   2 +
 arch/x86/kernel/signal.c                      |  29 +-
 arch/x86/kernel/signal_64.c                   |   6 +-
 tools/testing/selftests/mm/Makefile           |   2 +
 tools/testing/selftests/mm/pkey-helpers.h     |  11 +-
 .../selftests/mm/pkey_sighandler_tests.c      | 479 ++++++++++++++++++
 tools/testing/selftests/mm/protection_keys.c  |  10 -
 10 files changed, 560 insertions(+), 21 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey_sighandler_tests.c


base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
prerequisite-patch-id: 7b2144970da943b19b53baab525a0fc653fcd7b8
-- 
2.39.3


