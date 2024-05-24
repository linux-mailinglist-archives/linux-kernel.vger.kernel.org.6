Return-Path: <linux-kernel+bounces-189156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B04E8CEBEC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 23:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2160B217E0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 21:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2057F481;
	Fri, 24 May 2024 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b/sz1kBM"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5EFC50263
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 21:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716587606; cv=none; b=e1D2Cb58v+xjl+68le9Ku6ITQ0SnkJ1cxY/uL2ZoJNdiMlE/ZXkxttTxJVSvP6Hzv3jGK5b12XihrzWzqrK7TKL3XgJoktbam8n8KKQpvouF3oWC0e6xlgy3ZAxQmZlP2S5+ZUIkqH1N3uVd6dIb3Veb5+a0889kTTuk8/wiAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716587606; c=relaxed/simple;
	bh=w9sT+oWQofYT6nsiECM9+Yc+e+bcuz8JMmTEmdB+3mo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=oQS8ioWOMo7oQ1VGwDQ29BOUB7Tdwauwo0AKWUTMf6UuzgvJa2m9MD6azO3CS5rXN7uRFePeBOwel46aK54tDL1WK5dV4pb2yhflLVq8lRieORmMjU6febIrBDMAVRPcHUaFR4Fw2XSu0fenO2sR55ZErEnJYMugmgLzFoA6Mwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b/sz1kBM; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44OHcEG4021717;
	Fri, 24 May 2024 21:53:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=K0BAFTCnT5Qrgec3dEAH5062MqSR75v8S+Sy4UV20rU=;
 b=b/sz1kBMSxzikhjijtJcBAVLPQf6N5k66yqCe9V8nRKh1LLUJrL+ul3EpCZYjSbNpx+G
 ORshuiJWhv6sGIbsxeOJCXVA1Dod14ZkifJ/Xj0n/W2tg/YW3b7oXvBCRvAJmCCYikuW
 cTgMDGtAqV64t9xuBBlt3lCK+023wW9YsLdENbG9wcJwDZIXOaEkgoGMSOuLB9D/C9/k
 6RaTCLW1ROxEdUkdVL5xAglDDsdJssC1Q3KyT5p5ku6i9j+ZVnOwa9cBRy0bdUJEJqHE
 ZygpHWZvTyE1s1XJ0zB3HDGMlsyU4pxamCFbHY+ogBw0hVmlz0WeHppW4Xx0Jte7KF30 rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6k8ddcyy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 21:53:11 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44OLjG17035956;
	Fri, 24 May 2024 21:53:10 GMT
Received: from brm-x62-16.us.oracle.com (brm-x62-16.us.oracle.com [10.80.150.37])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3y6jscbsu0-1;
	Fri, 24 May 2024 21:53:10 +0000
From: Jane Chu <jane.chu@oracle.com>
To: linmiaohe@huawei.com, nao.horiguchi@gmail.com, akpm@linux-foundation.org,
        osalvador@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] Enhance soft hwpoison handling and injection
Date: Fri, 24 May 2024 15:53:01 -0600
Message-Id: <20240524215306.2705454-1-jane.chu@oracle.com>
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
 definitions=2024-05-24_08,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405240157
X-Proofpoint-GUID: D7MZYSpvFUZn71z56Yo4IHeyM_PUvV6g
X-Proofpoint-ORIG-GUID: D7MZYSpvFUZn71z56Yo4IHeyM_PUvV6g

Changes in v4:
  - collected R-B from Oscar Salvador
  - collected Acked-by from Miaohe Lin
  - fixed comment on MF_DELAYED, and comments for better coding. - Miaohe Lin
 
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
 mm/memory-failure.c     | 106 +++++++++++++++++++++++++++++-----------
 4 files changed, 82 insertions(+), 30 deletions(-)

-- 
2.39.3


