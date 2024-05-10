Return-Path: <linux-kernel+bounces-175319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 485378C1E0C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36384B2138B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D40815EFB6;
	Fri, 10 May 2024 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ORkQ2Z13"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA4115E1E3
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715322391; cv=none; b=P0v4+7VHIb6Hos44hiiYsf3nEc5Z5z5GOMwMD0qredt3UHb24xcvVS00CPIiuS+aeZh8/Q56tl3rBNBfwrL0YHJ0ZuxVUR7yP/AhZjUwiHpphnzbjTHENHbiIStEmaMdflQ9hpGsT6X7w+KadBy4wzI59ss57YcfIaPbeosaUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715322391; c=relaxed/simple;
	bh=DYWA/qV8LbQlZIhNZk0xUT48g2vwl/1OegljWejU81s=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=UeTnwdeqNvpwFcJ+hrMR78p95lsAZSMwXVOh67OCRhdtIXAl4QUtpd4tFeSYCtYLKAZdwrAiFi8+rMMg1T7vCawWkAoidxNPM7nBzdUVK/8IVeZ5nrJ9OYgJzubH7x3P8ul5vc7T4NOtqPGw7mj3Hu2+03vPGMVcmFXs81UP71c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ORkQ2Z13; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44A6MgZa021157;
	Fri, 10 May 2024 06:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=uYiMD0qHJdUOjRJaG7P7OjfghgadXuoVekNIZrG/ehY=;
 b=ORkQ2Z13GmT1vKNE4PuHF03kFWElGVWRMoa7zzqnR7ekE5ae44xMGRpCycRmRrhbb0zP
 GYs5uZy3w1CuEwfgEUDAOplrVcAfoV1YgwuiTCOj797/SOSntPLoFMHX59r3fR1qtBk3
 oPV0xCzCZDIGbDJr/jjfaRDMXHNLnmVnaPdngYtJg49ynfJOE4z6Ma9Vzfl9HmI91Gs8
 mSkkcX2IZUzU0RkA7wwFGtU/8HxgQN0iboiHCnyODe0JornTtWx7fAzdAaEN0cqUKgVv
 xCXgCZtdX3sJWF88BJD6BIZq0cga8pNmfrFdAqSjQwgDp3U+GlhW2O9INjCoWa92tNhE 6A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1e8sr05m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 06:26:12 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44A5vUjF020104;
	Fri, 10 May 2024 06:26:11 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3xysfpghcd-1;
	Fri, 10 May 2024 06:26:11 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Enhance soft hwpoison handling and injection 
Date: Fri, 10 May 2024 00:25:57 -0600
Message-Id: <20240510062602.901510-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_04,2024-05-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100044
X-Proofpoint-ORIG-GUID: 1ijG4LFLFkaIX8gNXlVbx2gGpW9-A3Vd
X-Proofpoint-GUID: 1ijG4LFLFkaIX8gNXlVbx2gGpW9-A3Vd

This series aim at the following enhancement -
- Let one hwpoison injector, that is, madvise(MADV_HWPOISON) to behave
  more like as if a real UE occurred. Because the other two injectors
  such as hwpoison-inject and the 'einj' on x86 can't, and it seems to
  me we need a better simulation to real UE scenario.
- For years, if the kernel is unable to unmap a hwpoisoned page, it send
  a SIGKILL instead of SIGBUS to prevent user process from potentially
  accessing the page again. But in doing so, the user process also lose
  important information: vaddr, for recovery.  Fortunately, the kernel
  already has code to kill process re-accessing a hwpoisoned page, so
  remove the '!unmap_success' check.
- Right now, if a thp page under GUP longterm pin is hwpoisoned, and
  kernel cannot split the thp page, memory-failure simply ignores
  the UE and returns.  That's not ideal, it could deliver a SIGBUS with
  useful information for userspace recovery.

Changes in v2:
  - rebased to mm-stable as of 5/8/2024
  - added RB by Oscar Salvador
  - comments from Oscar on patch 1-of-3: clarify changelog
  - comments from Miahe Lin on patch 3-of-3: remove unnecessary user page
    checking and remove incorrect put_page() in kill_procs_now().
    Invoke kill_procs_now() regardless MF_ACTIN_REQUIRED is set or not,
    moved hwpoison_filter() higher up.
  - added two patches 3-of-5 and 4-of-5 

Jane Chu (5):
  mm/memory-failure: try to send SIGBUS even if unmap failed
  mm/madvise: Add MF_ACTION_REQUIRED to madvise(MADV_HWPOISON)
  mm/memory-failure: improve memory failure action_result messages
  mm/memory-failure: move hwpoison_filter() higher up
  mm/memory-failure: send SIGBUS in the event of thp split fail

 include/linux/mm.h      |  2 +
 include/ras/ras_event.h |  2 +
 mm/madvise.c            |  2 +-
 mm/memory-failure.c     | 89 +++++++++++++++++++++++++++--------------
 4 files changed, 65 insertions(+), 30 deletions(-)

-- 
2.39.3


