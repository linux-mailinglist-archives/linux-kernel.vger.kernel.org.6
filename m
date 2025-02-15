Return-Path: <linux-kernel+bounces-515909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B4EA36A66
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 02:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921693B2369
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 00:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FCD1EA7D5;
	Sat, 15 Feb 2025 00:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YOvQRakp"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D1A19ABDE
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 00:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739580909; cv=none; b=h8DsVwV24NEc5ymzsmKbuFGFWLKTsiJDl8zjFEocPwY5BsY1vFafdh1ybHN94siB7Fks5Y0wYNn6n9kj5Z9WPehpbsThk/nAVgG4jyC4QYB2YLJSQdNi+GJS1AhubMwmLfS4cXZBKDkkjIAjRzEbZeoIJodNIgA3ldFaBRteBG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739580909; c=relaxed/simple;
	bh=luJZ0ZNi3EZExqMvWMTN7JDt/gHBM+QmUjbSASRBtU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h+WDLYuoO5ZkGkHhbfP1fJgC0w5FN61KGLT6Fd8qS+pzMHuSTZPgs4GAcjh9eYNFNx6K/U9uLNqim5mS2nV5fIl70NRpzVqRlEVGN7zk3Mlko452VbRIF/9yWtDKID3Fl/NazlAOPFxNmkJ3WruvxGIP4l0fQ9KqbEV7q25GnTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YOvQRakp; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ELCK8n002347;
	Sat, 15 Feb 2025 00:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=l0TJLN2yHL0U6FUhN42tDZwypbgmJ
	VT2hfc630JpaS0=; b=YOvQRakpJUK7DL7IrYB+9VJIYc2MFXSwcv99ZCGfA9YWH
	5J4hXy/Vds9oiYQVJYEciRlXn0QShTt4NFL8PqPME3OKqfUWmdQXiAdTdIhYq3Vl
	tj0x4CEMSf9mGnQdnMRYBfuj+m9fwmSKt2BlaZN7q6cW/bBYO+ObLS6AFCtChVkc
	YFJqkpoyVo2qRbO1rtybqhnrXR72/xsgURbszfgZwlixZXUWXWP/Ra5UJCwWz2BO
	F31YyQNp6kNBxToFywao9Mah7P4COhtdcioqAd6JlJNLID1evPqHvvx7aqZlyZRT
	pnLwu8WaUEsOfhz7TrlfpHbgcNhhm3An4boSYmPew==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0qampxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Feb 2025 00:54:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51F0BvaW014101;
	Sat, 15 Feb 2025 00:54:45 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqdx0jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 15 Feb 2025 00:54:45 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 51F0sjUv030902;
	Sat, 15 Feb 2025 00:54:45 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqdx0j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 15 Feb 2025 00:54:45 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        tglx@linutronix.de, prakash.sangappa@oracle.com
Subject: [PATCH 0/2] Scheduler time extension
Date: Sat, 15 Feb 2025 00:54:12 +0000
Message-ID: <20250215005414.224409-1-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_10,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502150006
X-Proofpoint-GUID: nAGTULV3Kz2nXvmWcIWrGWhY3AxoEbOl
X-Proofpoint-ORIG-GUID: nAGTULV3Kz2nXvmWcIWrGWhY3AxoEbOl

Follow up to discussion in [1], posting these patches.
They are based on use of the restartable sequences(rseq) for API.

However, currently the discussion is on thread [2] in response to patch
posted by Steven. Mainly about whether this feature should be applicable
only to normal threads(SCHED_OTHER) under PREEMPT_LAZY preemption model
or keep it independent of the preemption method.

[1] https://lore.kernel.org/all/20241113000126.967713-1-prakash.sangappa@oracle.com/
[2] https://lore.kernel.org/all/20250131225837.972218232@goodmis.org/

Prakash Sangappa (2):
  Sched: Scheduler time slice extension
  Sched: Add scheduler stat for cpu time slice extension

 include/linux/entry-common.h | 11 +++++--
 include/linux/sched.h        | 20 +++++++++++++
 include/uapi/linux/rseq.h    |  5 ++++
 kernel/entry/common.c        | 15 ++++++----
 kernel/rseq.c                | 57 ++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c          | 21 +++++++++++++
 kernel/sched/debug.c         |  1 +
 kernel/sched/syscalls.c      |  5 ++++
 8 files changed, 127 insertions(+), 8 deletions(-)

-- 
2.43.5


