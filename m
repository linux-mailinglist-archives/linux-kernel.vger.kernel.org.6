Return-Path: <linux-kernel+bounces-270748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B059444C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16132281D8F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 06:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4DE158851;
	Thu,  1 Aug 2024 06:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c3Bq3o0c"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1755C158544
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722495115; cv=none; b=ilBau9ojhqelCtuPBF8B/Mxx9h/6o7ufiD1ehZMSYVODhne4vVWuCtjrNbRtpd19JR64VaA+oU9MGKDPy+YCDggQXi5GhATGIhY8I33CpKgKxp16Y7CYd3v5esDGwWHbvFUCkK3otap960dLXxHP+wgovav84X+H8dn34pDZM14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722495115; c=relaxed/simple;
	bh=VQWB+9DxqrjdbmzXBsYQr1Sedc43sMgtrA4N4Qevdts=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d6gEriWAPMLLCqo3dkwSOl34RM/pLmP3rjYE1WQFmUWAzjgUV6ZO0yoCFNO5ZfG8fnFOTDzjdlFyQw02v1GF+2typfVumKihUR/xuibFUDABvsY8vfDeHQkvsU9Ilk+Awcp6CTolUehWwv1te2bTMNmGHwEapj9LQohv4x4xRmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c3Bq3o0c; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4713nL1R001277;
	Thu, 1 Aug 2024 06:51:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=c5Qa4Pt5RmJwMR
	l6l2qwFzkAHapDsMU6iAQnMGtr1lw=; b=c3Bq3o0cWZr0feUBMQxEWWhs9qRgea
	eQqz7wKIdyWOm4WL0JDsb/SRszO6BT2hSFE/dL+iYgFESFKgvprVGqW3FmRZpVr1
	5q08Fipz2o87jeGvgNo1ynL2PCl/vlwLxW9O5Y4LjmS0f+/vvKHTQZgug9Du+nVw
	OxZSptQFkjfyingLT78GUKwHb22wWlb/Xu9Uncxw80eEjYt7lsuYfbTzoBEdXF62
	1gbweus8Xi1aqibnd6KIcCi09oZpni43gZarYalAIyADjqQnP1RM9gBpwX6idDEG
	X8DZvyV9m5Hsl/WaM3KsIrvpIFAmNMUkTV83K88KFu8OXl6LehfuGvYA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrxc16nf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 06:51:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4715Glmc030804;
	Thu, 1 Aug 2024 06:51:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40nehveh7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 01 Aug 2024 06:51:18 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4716pHNC033596;
	Thu, 1 Aug 2024 06:51:17 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40nehveh6x-1;
	Thu, 01 Aug 2024 06:51:17 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, linux-mm@kvack.org, keith.lucas@oracle.com,
        jeffxu@chromium.org, rick.p.edgecombe@intel.com, jorgelo@chromium.org,
        keescook@chromium.org, sroettger@google.com, jannh@google.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH  v7 0/5] x86/pkeys: update PKRU to enable pkey 0 before
Date: Thu,  1 Aug 2024 06:51:11 +0000
Message-Id: <20240801065116.2088582-1-aruna.ramakrishna@oracle.com>
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
 definitions=2024-08-01_04,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=900 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408010038
X-Proofpoint-GUID: UCDjhJ1qyGjA00qKsIFNSUfm8n7_2w58
X-Proofpoint-ORIG-GUID: UCDjhJ1qyGjA00qKsIFNSUfm8n7_2w58

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


