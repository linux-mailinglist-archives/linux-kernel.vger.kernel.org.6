Return-Path: <linux-kernel+bounces-414754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5529B9D2CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8001F23496
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E716E1D2718;
	Tue, 19 Nov 2024 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kgHx0piG"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D648A1D1F40
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732038341; cv=none; b=QPojisjVog4IqojprLVZA932dkebNuXj+3TyI7jXHTCS6oD+JEoWzQyOeRUWa+aelk6X/2geFFg3k1ZrSV29cY3fZZYhxYmYVWdAzc69W7aH94XJJM4HsifqT8xv/NjTYdgTuO5HvkDQ8rZLRLGgCYy14+j7lhpB+kQf5zIZVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732038341; c=relaxed/simple;
	bh=hhJE5QhMN0gIeDANzlGhTYwTpKQ9qHPLWSNv21P4cuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZknTDGhhZLdI60nwLQFZbqQb0DgBCCX/l0qc7gdgVizk+auEbIR1xth+hjQehnOK65sbeVH5R6sORdlNmfd+nLv0PHzOi+GJciFqely9kh/GzumbVdcy4BbRTMogtVcsl1H7g8OdS1vXPPOxC2ZY05GTb4K98ajgf1nauZNWFYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kgHx0piG; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJHBet6027679;
	Tue, 19 Nov 2024 17:45:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=ta7/vN7rxteATu2GUCgovxGwBFvW4
	e9+GjarzhHmy7c=; b=kgHx0piGGKwSjP7+AOvUGWnFs/R/xpg1zL49GXFokpElO
	VjuwZKbT/R4T1/CFfexhNoH25PyYkR+wnhrPI5dfAN7r4plJXH3l6nCKO3jTLMpw
	NH5hYx1fNQZ9wJ/rBfKPNwP9RnPkAC6yipF9XYgHAIaqjYi47Bb5+A7d4xWwPjIP
	NlBbDhDzpS+AHkwi+N3dctn5BjcOSKEa+fi2l84nSG3nnaNN7ciAsRkAGYyrmBLh
	X8DVm8JnpmyD5foapHcv/atvr47OKkz3HUpO5GlhDVFDCihlwz+g0Umzq5YXy7V7
	sf+YTM6Nf/ODsmY0LBAhS9lmLUh3xtX0uNL6kWXVA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42xjaa5kqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 17:45:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJHivfb023282;
	Tue, 19 Nov 2024 17:45:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42xhu99dhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 17:45:22 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AJHfRnZ008507;
	Tue, 19 Nov 2024 17:45:21 GMT
Received: from aruramak-dev.osdevelopmeniad.oraclevcn.com (aruramak-dev.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.155])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 42xhu99dh7-1;
	Tue, 19 Nov 2024 17:45:21 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, dave.hansen@linux.intel.com, tglx@linutronix.de,
        mingo@kernel.org, rudi.horn@oracle.com, joe.jin@oracle.com,
        aruna.ramakrishna@oracle.com
Subject: [PATCH v3 0/2] x86/pkeys: Set XSTATE_BV[PKRU] when updating
Date: Tue, 19 Nov 2024 17:45:18 +0000
Message-ID: <20241119174520.3987538-1-aruna.ramakrishna@oracle.com>
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
 definitions=2024-11-19_09,2024-11-18_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=841
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411190132
X-Proofpoint-ORIG-GUID: wbR04oesiPmFG-C8-IB5OHzRc_AwmaTT
X-Proofpoint-GUID: wbR04oesiPmFG-C8-IB5OHzRc_AwmaTT

v3:
- rebased to 6.12.0
- no functional changes from v2

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


