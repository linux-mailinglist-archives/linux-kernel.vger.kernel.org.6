Return-Path: <linux-kernel+bounces-408868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B70B9C8477
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE2F2850F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 08:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F31A1F7087;
	Thu, 14 Nov 2024 08:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IZZokjnq"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9B61F472D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 08:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731571293; cv=none; b=uaCE/EMJdJ5FRgiRA/M7h7rBmxYT8tEj8p/FiuSMdd+KtNU7FGlBz9MnG932pChcw/Pv9Yr0l5oKQSeNu3X5WB215/vvaM++GcbmpnbqD33aa6zT+Zq3otTp2hgKhFQ023xaVfjMFyoXqKFbsn+9RjHBnscVTSkKjrTKYgEPqWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731571293; c=relaxed/simple;
	bh=skH4v8oVc97jZMCRfoUHsQdlc/C6eBoF+FogBuLmVVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nAZOTrvTjQVxs6/A8LieCRrZlgoGGCR1lCmD05GfT95dq96KCcUG2VJWgvVVW9bekli8XZ1oVT3TfdyBppEogvMP1eAxdwGxD7qxR4/er47t5qNFjTUIiDLWtn6DVIH7GA2wq+s8Fkpfd2BX8kEPwjn5AUjxj6ptSflXxj6J0Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IZZokjnq; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE1fdrn024575;
	Thu, 14 Nov 2024 08:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=PT2dXaI+v7xaD9X4UDHWnsKenOxrc
	yV+h/KkpSzaUqk=; b=IZZokjnqFB6gmhsT0rGnqzKGgSda3ayRrq5OjiFWfjDj2
	sM1hL0Rp6fvGOVao9K3H6nC5ewppKkXn3KAheZGNWZQtqFr04sZkCT1mxWDEli6h
	RNCQcR+/eNlS5dsShwTHlruB4vdcyyIppo0t3PI4k/EUoJ8Z30cN6PyuW7D7oWtB
	lZ1dLI7SwjCpXxUTSQNwyyilvjZ/vHCpbr8FgtWOZ1DClyXwLJiHRAjNXrWVRYJu
	2Ny85mfqemvnUrizxAC4JEv9/OAKpN/XTu6wgm50MHmldNpfaN8GH2S1+0VoR7X6
	Qok9x+PqqWByfSmFCAmobio1n0puqiFU5jLH6haog==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0herja1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 08:01:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AE7BNRV035973;
	Thu, 14 Nov 2024 08:01:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6aevnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 08:01:20 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AE7mvWD014821;
	Thu, 14 Nov 2024 08:01:19 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 42sx6aevkv-1;
	Thu, 14 Nov 2024 08:01:19 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, rudi.horn@oracle.com, joe.jin@oracle.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH v2 0/2] x86/pkeys: Set XSTATE_BV[PKRU] to 1 so that PKRU
Date: Thu, 14 Nov 2024 08:01:16 +0000
Message-ID: <20241114080118.3551117-1-aruna.ramakrishna@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_03,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=888 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140060
X-Proofpoint-ORIG-GUID: 1p7Fr0qc9kqun_coek_Gp2-oDBDD5lah
X-Proofpoint-GUID: 1p7Fr0qc9kqun_coek_Gp2-oDBDD5lah

Resending. I apologize for forgetting to add v2 in the patch subject
in my previous submission (and this cover letter).

v1 -> v2 updates:
- corrected commit description of both patches to reference xstate_bv
where appropriate
- renamed local variable in update_pkru_in_sigframe()
(no functional changes from v1)

Aruna Ramakrishna (2):
  x86/pkeys: Change caller of update_pkru_in_sigframe()
  x86/pkeys: Set XSTATE_BV[PKRU] to 1 so that PKRU is XRSTOR'd correctly

 arch/x86/kernel/fpu/signal.c | 20 ++------------------
 arch/x86/kernel/fpu/xstate.h | 27 ++++++++++++++++++++++++++-
 2 files changed, 28 insertions(+), 19 deletions(-)

-- 
2.43.5


