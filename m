Return-Path: <linux-kernel+bounces-233028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FB391B15E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DEF2832F9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E401A2556;
	Thu, 27 Jun 2024 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AtVvfe78"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FE819A2A3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719523081; cv=none; b=BDRQaBbbYNgxEzZINfKfGYd11Muz4+3k1aiS23Bd1fu1BIiDDphwrqHV2dxsb24lbEG0rEj5dCtIQQY7TaSL0lqdeDsXUABYOpw3A0tDUp8iwquq3l6woVND6guTvCbv1mNFXZYKYWKeOY6hE3q6WXDDXwCCl59Gj2SHDd4IXPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719523081; c=relaxed/simple;
	bh=hJzu2OKyiD/BxE5kdIigdIzAsQ/SbxnemYMumJ5GtZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fiV2pARh5urCk5yVp1C15QX+AHi2KOsVGJbvfIRNZ3Jxt51DBscULrwQ9aMyy4uNFZcBqHa8vWq71c9Vzk7U1ozLnMNT+1rWj53UNnUP+5HC1HjDLcVHXrJqwa5xZhZHxJn1KwqsBoZXw8V6jdpWFvibdOujiNdh5MGA36exspI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AtVvfe78; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45RKBTh5026542;
	Thu, 27 Jun 2024 21:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=7WtqeTWGCwWcoa
	ZZba6TG+pblrj7SJ6BTUhHhkGGLWU=; b=AtVvfe78hHsAfT7lzuMuToUakNXa69
	Q25i+9WlpsieO1Fcv98gljfRWTpPFnB7zY8DVVkvqVaoyfgP+WeRaE1FqxYh2UAy
	HWt0HSfKbP50Lvv8B+kBlmaEeFx80wd466gYtwLMOrnd9ZFKzr1X5stdgACQt/J0
	C4JzMiBTtbvlb3KCgqmZme0mACSugPpgwBhrlTKbACdHuJg6ZVwnVO7TVTOytpuL
	zDIX3dMd+oS5lnndKVZlHejUf672xBe6tGP9H7vQhdP84dfr4SmkPeQEBERkjlq5
	42s9RaasyyefUYESl4s9Ngsy9jtz1DbmpTiEoXtM2Se/tV/homCOHLGQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywnd2q36x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 21:17:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RJtOnq017832;
	Thu, 27 Jun 2024 21:17:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2awm3x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 21:17:38 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45RLHct2016897;
	Thu, 27 Jun 2024 21:17:38 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3ywn2awm35-1;
	Thu, 27 Jun 2024 21:17:38 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, jeffxu@chromium.org, keith.lucas@oracle.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH v6 0/5] x86/pkeys: update PKRU to enable pkey 0 before
Date: Thu, 27 Jun 2024 21:17:32 +0000
Message-Id: <20240627211737.323214-1-aruna.ramakrishna@oracle.com>
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
 definitions=2024-06-27_14,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxlogscore=834 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270158
X-Proofpoint-ORIG-GUID: 7lgl6fz6HIB8SwHARFN58wMF7SiCax4r
X-Proofpoint-GUID: 7lgl6fz6HIB8SwHARFN58wMF7SiCax4r

v6 updates:
- Rebased patchset to v6.10.0-rc5
- Changed sig_prepare_pkru() back to enabling all pkeys, based on
discussion with Jeff Xu

As Jeff mentioned, I'm unsure if we need to retain the changes to the
32-bit functions. Maintainers - please advise.

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
  x86/pkeys: Add helper functions to update PKRU on the sigframe
  x86/pkeys: Update PKRU to enable all pkeys before XSAVE
  x86/pkeys: Restore altstack before sigcontext

Keith Lucas (1):
  selftests/mm: Add new testcases for pkeys

 arch/x86/include/asm/fpu/signal.h             |   2 +-
 arch/x86/include/asm/sighandling.h            |  10 +-
 arch/x86/kernel/fpu/signal.c                  |  27 +-
 arch/x86/kernel/fpu/xstate.c                  |  13 +
 arch/x86/kernel/fpu/xstate.h                  |   2 +
 arch/x86/kernel/signal.c                      |  45 +-
 arch/x86/kernel/signal_32.c                   |  12 +-
 arch/x86/kernel/signal_64.c                   |  14 +-
 tools/testing/selftests/mm/Makefile           |   2 +
 tools/testing/selftests/mm/pkey-helpers.h     |  11 +-
 .../selftests/mm/pkey_sighandler_tests.c      | 479 ++++++++++++++++++
 tools/testing/selftests/mm/protection_keys.c  |  10 -
 12 files changed, 583 insertions(+), 44 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey_sighandler_tests.c


base-commit: f2661062f16b2de5d7b6a5c42a9a5c96326b8454
prerequisite-patch-id: fc7cbe9ff3c554d556e2792f9ffaf29e6ad6ee21
-- 
2.39.3


