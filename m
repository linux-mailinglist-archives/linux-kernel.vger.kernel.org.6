Return-Path: <linux-kernel+bounces-560856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A49EA60A39
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A99917C639
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC3A18A6B2;
	Fri, 14 Mar 2025 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pnalck5E"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485AE1519B0;
	Fri, 14 Mar 2025 07:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938271; cv=none; b=U745TA8c5E/lBM5ps4OZgrlifoLhoxRyPjVAFBA0GOA01CFFvBRgMScVON4jZxqncMGMbYzf9foYmDE+qGDoDbUZZYbvcQ1sNqiFllEhT1+ajVuL2Tl2BSOsPuX9FVKSa1OSa6YHZAk2XWGTAZ2thVOksYuuHIP8uRGRYo4jSLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938271; c=relaxed/simple;
	bh=ooHUoONViwjALhK7TTEzLsHuhdBwS3irxKXBmrs1Suc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BL9fKmZuWIZRLVymNuZPIKBu7WzWwvdEeFirvRrA02FznREgvHV+T18VHukzmTVJ4UAMXXzCRo8j0qJgfQBoxkya8+5b2goQFDnTvUELtVJC+6gloD7ZEqMyJ55KuHaxWgFxVVCQI2PrHllUOiZP5d3X+B1onx4/eyQWp7tVVYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pnalck5E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNOvp9005804;
	Fri, 14 Mar 2025 07:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=VtwWPZ/8cWLpdDiAsOSfE05JgPrDC3BlrS+qQK2vO
	iA=; b=pnalck5E8IE7LGTotDIIbl+bzNhVNZmD8slR6D5BIyeUPpuulLBQQw9OX
	PfXtPl3Q/P/UnwG8KVltGFjAPThR5TERLurshcBweRNJMgIFL/292c1SEN8bje4m
	0GN7fSVRalxJ8zHe9xuUvqUY35vPnRBH6KBnOrRPneT+CSc5FwAIJQV59Jdgn9Kw
	DAhIxhSAY8Qjml1lKH619YqDwOx0KgmLY0w9AZlCpuJGQovRR011BRk6cAKXZufc
	osPg2k2lQbK9W64eNkfPYFzeK3NdSTYP2ldPgU7bcAcxTmK5RijZ0huYfXWNZgW/
	sijbObstOjfqJ2LNcup8v5rfUoJaw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6s5a7ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 07:44:19 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E7gkwA031784;
	Fri, 14 Mar 2025 07:44:19 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6s5a7ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 07:44:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E40Psc026029;
	Fri, 14 Mar 2025 07:44:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspnvsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 07:44:18 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E7iHtm20971814
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 07:44:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06AEF20040;
	Fri, 14 Mar 2025 07:44:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 149992004B;
	Fri, 14 Mar 2025 07:44:13 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.24.194])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 07:44:12 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Fix a BUG_ON crashing the kernel in start_this_handle
Date: Fri, 14 Mar 2025 13:14:08 +0530
Message-ID: <cover.1741938027.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KlivapcQYvv_b0mdJedZY9plCj2600L9
X-Proofpoint-ORIG-GUID: jLeofE6NJsvpRSafjHtPdvQ85MphY4y9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_03,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=902 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503140058

** Changes in v3 [3] **

 * Picked RVBs from Jan and Baokun
 * In patch 2/3 we now do the following:
   set flag -> force commit -> flush wq
 * use sbi->s_mount_flags instead of an
   sbi field for journal destroy flag

[3] https://lore.kernel.org/linux-ext4/Z86b0c_qTURBBkOW@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com/T/#m3a6c2e9205381d86460267e7be37ae0db688b800

** Changes in v2 [1] **

 * Picked up RVBs from Jan and Ritesh
 * In patch 2/3, we now use a flag in sbi instead of SB_ACITVE
   to determine when to journal sb vs when to commit directly.
 * Added a prep patch 1/3

[1] https://lore.kernel.org/linux-ext4/cover.1740212945.git.ojaswin@linux.ibm.com/T/#m5e659425b8c8fe2ac01e7242b77fed315ff89db4

@Baokun, I didn't get a chance to look into the journal_inode
modifications we were discussing in [2]. I'll try to spend some time and
send that as a separate patch. Hope that's okay

[2] https://lore.kernel.org/linux-ext4/cover.1740212945.git.ojaswin@linux.ibm.com/T/#mad8feb44d9b6ddadf87830b92caa7b78d902dc05
 
** Original Cover **

When running LTP stress tests on ext4, after a multiday run we seemed to
have hit the following BUG_ON:

 [NIP  : start_this_handle+268]
 #3 [c000001067c27a40] start_this_handle at c008000004d40f74 [jbd2]  (unreliable)
 #4 [c000001067c27b60] jbd2__journal_start at c008000004d415cc [jbd2]
 #5 [c000001067c27be0] update_super_work at c0080000053f9758 [ext4]
 #6 [c000001067c27c70] process_one_work at c000000000188790
 #7 [c000001067c27d20] worker_thread at c00000000018973c
 #8 [c000001067c27dc0] kthread at c000000000196c84
 #9 [c000001067c27e10] ret_from_kernel_thread at c00000000000cd64

Which comes out to

  382   repeat:
  383           read_lock(&journal->j_state_lock);
* 384           BUG_ON(journal->j_flags & JBD2_UNMOUNT);
  385           if (is_journal_aborted(journal) ||
  386               (journal->j_errno != 0 && !(journal->j_flags & JBD2_ACK_ERR))) {
  387                   read_unlock(&journal->j_state_lock);


Initially this seemed like it should never happen but upon crash
analysis it seems like it could indeed be hit as described in patch 1/2.

I would like to add that through the logs we only knew that:

- ext4_journal_bmap -> ext4_map_blocks is failing with EFSCORRUPTED.
- update_super_work had hit the BUG_ON

I was not able to hit this bug again (without modifying the kernel to
inject errors) but the above backtrace seems to be one possible paths
where this BUG_ON can be hit. Rest of the analysis and fix is in patch
2/3. Patch 3 is just a small tweak that i found helpful while debugging.

That being said, journalling is something I'm not very familiar with and
there might be gaps in my understanding so thoughts and suggestions are
welcome.

Ojaswin Mujoo (3):
  ext4: define ext4_journal_destroy wrapper
  ext4: avoid journaling sb update on error if journal is destroying
  ext4: Make sb update interval tunable

 fs/ext4/ext4.h      | 10 ++++++++++
 fs/ext4/ext4_jbd2.h | 29 +++++++++++++++++++++++++++++
 fs/ext4/super.c     | 43 ++++++++++++++++++++-----------------------
 fs/ext4/sysfs.c     |  4 ++++
 4 files changed, 63 insertions(+), 23 deletions(-)

-- 
2.48.1


