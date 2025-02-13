Return-Path: <linux-kernel+bounces-514040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26713A351B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4BC87A31E3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF7122D785;
	Thu, 13 Feb 2025 22:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d/ufoCGq"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A6722D781
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487030; cv=none; b=XWjXoHAXvzTvnw9anZ+Pi05HTArTXWdIsWiB8C80ln9v6zzbuFAdwvuTpYqxDIEyN6/D65eBsyvtIpVOj4dxq3syxhCO5lSTRf/ZH6l9qk/qb0jfGbJ19poyhvg8j13d0U5INTmttdqmO3oXuLu14QggNpemweHqRcZbi6uYApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487030; c=relaxed/simple;
	bh=ZJfe2246QdyJtJQ/S4uykIUc7n5oBU0T5TxonN5+Kw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DvyZqFjbl2Nl8ThPN0lfkYLnhQuY5XNI977Lpoaf1RjB2LWi1rAYQAtrsK4D5ovK3zYASInzRJJktiqJRhKu+M5Y1isDywWFZmHP3nhP3igTWB6YbsezJL24ldmvIcA7FYVDVFm+98PJDM5ZNA0pLrN0tJ3/QuVi/f5glfJE3Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d/ufoCGq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51DEoAbT032241;
	Thu, 13 Feb 2025 22:50:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=p202ICwOUaPv/AFFu+CG6pEb9R3OHOlCE4EDdrJTi
	T8=; b=d/ufoCGqKmQRbxM3AaGr9ZWkBlLZt0M6Wxsh3JZZ+TFiiAHJ8FOaerdg1
	Wh8cpIHSPcOo7MV79Q4A8EESja05CaMG/frtCBWz2rekAMAAffh3+DEitcCwgdTs
	adeJ1sKwcqNsAoWbuiJKWhyCxn6PCcd8eADi9JgcZI8BXdegRg+FMYkdxCjjsTe7
	EaNyK+8ljk+ilfD6sFngw/wjY/URdO1tkMjvN8JMN2YMTHa9WnGIVTsjhp6uK8dT
	E0qms2ydsgho6L8nxnrtoSDNPHxtaTbMaHPArbc6MPqNNjXqyhtp7lNMwQhpefB7
	5RPNCwGF8MnmAtQZYsdRSHBwSz5QA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44saj8n0ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 22:50:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51DMgCOc000924;
	Thu, 13 Feb 2025 22:50:06 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjkngpte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Feb 2025 22:50:06 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51DMo51h17891906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 22:50:05 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 260F658064;
	Thu, 13 Feb 2025 22:50:05 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E664F58062;
	Thu, 13 Feb 2025 22:50:04 +0000 (GMT)
Received: from slate16.aus.stglabs.ibm.com (unknown [9.61.104.210])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Feb 2025 22:50:04 +0000 (GMT)
From: Eddie James <eajames@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, eajames@linux.ibm.com, jk@ozlabs.org,
        joel@jms.id.au, alistair@popple.id.au, linux-fsi@lists.ozlabs.org,
        ninad@linux.ibm.com
Subject: [PATCH v2] MAINTAINERS: change maintainer for FSI
Date: Thu, 13 Feb 2025 16:50:00 -0600
Message-ID: <20250213225000.2153643-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MBHUSSPxrnD_9vsLmmDKmjFJKIBXmjGp
X-Proofpoint-ORIG-GUID: MBHUSSPxrnD_9vsLmmDKmjFJKIBXmjGp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_08,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 mlxlogscore=999 impostorscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2501170000 definitions=main-2502130158

Due to job transitions, both Joel and Jeremy can no longer maintain
the FSI subsystem. I will take over.
I also replaced Alistair with Ninad as a reviewer, as Alistair doesn't
have access to hardware and hasn't been active.
I also removed the link to Joel's FSI tree as he won't be maintaining
it.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
Changes since v1:
 - Remove Alistair as reviewer
 - Add Ninad as reviewer
 - Don't add Joel and Jeremy as reviewers.

 MAINTAINERS | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f65a2a1cde5b..59a6b47e9c278 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9441,14 +9441,11 @@ F:	include/linux/fscrypt.h
 F:	include/uapi/linux/fscrypt.h
 
 FSI SUBSYSTEM
-M:	Jeremy Kerr <jk@ozlabs.org>
-M:	Joel Stanley <joel@jms.id.au>
-R:	Alistar Popple <alistair@popple.id.au>
-R:	Eddie James <eajames@linux.ibm.com>
+M:	Eddie James <eajames@linux.ibm.com>
+R:	Ninad Palsule <ninad@linux.ibm.com>
 L:	linux-fsi@lists.ozlabs.org
 S:	Supported
 Q:	http://patchwork.ozlabs.org/project/linux-fsi/list/
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joel/fsi.git
 F:	drivers/fsi/
 F:	include/linux/fsi*.h
 F:	include/trace/events/fsi*.h
-- 
2.43.5


