Return-Path: <linux-kernel+bounces-185532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B6E8CB667
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 01:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307AB1C20FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 23:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6350814A0B9;
	Tue, 21 May 2024 23:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Iy6uZIAS"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AF758AB9
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 23:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716335712; cv=none; b=MErwvUq+imsB3wrRA1X0rS0ZPtB+Bjl3FE004SdcowtsCqf3ndAYwmZn+AFtqt5M5a9g2wjdghOd1n13DJ3tzFpETYrm/FhJgbhIKCClt93S2zKEiB4WXkh7DRyhJj/bUjcLFSkJOT9SbPQoAmN4n0YW6J8m5x8VbbWpdN8At6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716335712; c=relaxed/simple;
	bh=+oROR7WPT+u8NzLbsDmwALENll/1z74QLNP4KGqk52g=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ZUHpxDBX3N+giQqJh3r7gXIXMt53f76kSh0JgSnTe9qBGDDhkY9SxvWt13OGdCOFVXCTkh0YRplARJnAztCHjO66HhubEi3RcLK238zB8pEHVkBbcV591ZfYUjTvvsvD4xwDWjLg9N/anQHb26vChmsdXRKDWFOJg5B0PLtkAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Iy6uZIAS; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44LJiCmJ025793;
	Tue, 21 May 2024 23:54:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=Luwg1gXwUUH9kO0fvhX+8WrwbHsLOytbWyLws884IyI=;
 b=Iy6uZIAS0KGzOCKDnRuqi1nxahESWdPDofmOPUzfQztVO0RVbZ3Ttf2GxqAhnnbPvJFY
 wSvpvgxp/FyR/GooIq1ehO/4qvKUHB5ZJFpL1gmEvQ1i82va6fHsC7M6AYry+FlZhwM/
 +Q1FQyJndhSo7rYjDwY3LNprK71bKtOXqF+V/k9ilkWZOfWBwjyksl1yJ2fdj4EyALye
 nl917vQAA4oz3TcfukfyFvPzk+7ydtN3ltfNvzpcCzKWx+Xeo6/dfF8i7dkm8wXj3Ft7
 hwWgpLuBcmvtE6s0h4d6jUwf6FSk4wUa+g/npXThBFL1LkDZslZmcbCBbykeakG0O55s bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k466m1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 May 2024 23:54:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44LMZkKR002667;
	Tue, 21 May 2024 23:54:53 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3y6js8erce-1;
	Tue, 21 May 2024 23:54:53 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] Enhance soft hwpoison handling and injection 
Date: Tue, 21 May 2024 17:54:24 -0600
Message-Id: <20240521235429.2368017-1-jane.chu@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_14,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210181
X-Proofpoint-ORIG-GUID: ICL2FUO5C3Em64Ba8poKST_ZvZxvZq5G
X-Proofpoint-GUID: ICL2FUO5C3Em64Ba8poKST_ZvZxvZq5G

Changes in v3:
  - rebased to mainline as of 5/20/2024
  - added an acked-by from Miaohe Lin
  - picked up a R-B from Oscar Salvador
  - fixed/clarified comments about MF_IGNORED/MF_FAILED definition and
    usage. - Oscar Salvador
  - invoke hwpoison_filter slightly earlier to avoid unnecessary THP split,
    and with refcount held. - Miaohe Lin
  - added comments to try_to_split_thp_page() on when not to release page
    refcount.  - Oscar Salvador
  - added action_result() in a couple cases, but take care not to overwrite
    the intended returns.  - Oscar Salvador

Changes in v2:
  - rebased to mm-stable as of 5/8/2024
  - added RB by Oscar Salvador
  - comments from Oscar on patch 1-of-3: clarify changelog
  - comments from Miahe Lin on patch 3-of-3: remove unnecessary user page
    checking and remove incorrect put_page() in kill_procs_now().
    Invoke kill_procs_now() regardless MF_ACTIN_REQUIRED is set or not,
    moved hwpoison_filter() higher up.
  - added two patches 3-of-5 and 4-of-5 

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


Jane Chu (5):
  mm/memory-failure: try to send SIGBUS even if unmap failed
  mm/madvise: Add MF_ACTION_REQUIRED to madvise(MADV_HWPOISON)
  mm/memory-failure: improve memory failure action_result messages
  mm/memory-failure: move hwpoison_filter() higher up
  mm/memory-failure: send SIGBUS in the event of thp split fail

 include/linux/mm.h      |   2 +
 include/ras/ras_event.h |   2 +
 mm/madvise.c            |   2 +-
 mm/memory-failure.c     | 108 +++++++++++++++++++++++++++++-----------
 4 files changed, 84 insertions(+), 30 deletions(-)

-- 
2.39.3


