Return-Path: <linux-kernel+bounces-411875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 327359D00AA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 20:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE196B221C1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 19:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E48F1990A8;
	Sat, 16 Nov 2024 19:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QCuFjyqD"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2A3191F7A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 19:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731785095; cv=none; b=ijKy2H74Umipt5NIe64IZSBVk4UuyuOLRf/eVpysSL4fL2ovIw2VsKcfj939LDHdoGTVOBzqkCN2imCHkiDD58BQMfwMgS3LSAGwercreTwCNshmMUBlneEAKD5RMXz69J6NzfWCuHey251eOkL/cl+4KnJoNN7hCCTIDBBFnf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731785095; c=relaxed/simple;
	bh=GJlmTT6GyiADI6KBNV1Ur7EasTZjDgutyczRV7Dh5Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TV/gbCOwjtxtzmG2zHqabuT4nWTZgNl0Wx5tSOhC7DekxESWtr4GQPfipq7kpGeDPdbtgrFTMe54nQc6TmR6xZdIC6JzezCvL0XWpVR9O/CeYWM2EV93J2bXvLaBfzfrKl6pznb2AJ4KMG4SpNFi9+izZ5UCNpeF7YbEWgHyU6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QCuFjyqD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AGBEpWc021707;
	Sat, 16 Nov 2024 19:24:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=h0IjdvkGudWwLmIFMN1Q+N9e5ImIB2ZBhoc2dI1xk
	Wk=; b=QCuFjyqDDnDpgk1hretvgTg44uS1Uw2c0+Oy6DklMbYCsOjKuhP15Vr8g
	RWNeWG2F94SyDU1CcYhPNjoAQPt4bt3crMDF5/QFMNxVT9Wvc+bAXxki1ZmjqK5Q
	wkDIXw3cJ2/JocAIJ4HVGVS68311zee083fY0dHxerq7UMhqmAYuCKvHsHpM8Gfl
	hxoS1Ech7WBwqOoGc7YwBEQrUcMpzWDEOzHoXNuhkYPfDG3anUvWiGYSjpIgxFx2
	agjeq9rkb7k2qZE+szSNogT22Hvi27/oxeiter9FH3LSsBCg9Grf5cGnCwqpATpl
	1RP6D73kKXSnv4polmrdjNQDs5p3A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xgtstv35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 19:24:26 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AGJOQHx016608;
	Sat, 16 Nov 2024 19:24:26 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42xgtstv33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 19:24:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4AG9HEbG002784;
	Sat, 16 Nov 2024 19:24:25 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42tms1chfu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 16 Nov 2024 19:24:25 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AGJOLBV52494642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Nov 2024 19:24:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3DA62004D;
	Sat, 16 Nov 2024 19:24:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CB782004B;
	Sat, 16 Nov 2024 19:24:19 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.124.220.93])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 16 Nov 2024 19:24:19 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        maddy@linux.ibm.com, bigeasy@linutronix.de, ankur.a.arora@oracle.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] powerpc: Enable lazy preemption
Date: Sun, 17 Nov 2024 00:53:04 +0530
Message-ID: <20241116192306.88217-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hyeRfXY9rOGUTA5HTY3yFtEZdbbKeB6q
X-Proofpoint-ORIG-GUID: XrQIH_H1HhIVinAJbhnWr0I8ujvSlgEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=531 adultscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411160165

preempt=lazy has been merged into tip[1]. Lets Enable it for PowerPC.

This has been very lightly tested and as michael suggested could go
through a test cycle. If needed, patches can be merged. I have kept it 
separate for easier bisect.

Lazy preemption support for kvm on powerpc is still to be done.

Refs:
[1]: https://lore.kernel.org/lkml/20241007074609.447006177@infradead.org/
v1: https://lore.kernel.org/all/20241108101853.277808-1-sshegde@linux.ibm.com/

Changes since v1:
- Change for vmx copy as suggested by Sebastian. 
- Add rwb tags 

Shrikanth Hegde (2):
  powerpc: Add preempt lazy support
  powerpc: Large user copy aware of full:rt:lazy preemption

 arch/powerpc/Kconfig                   | 1 +
 arch/powerpc/include/asm/thread_info.h | 9 ++++++---
 arch/powerpc/kernel/interrupt.c        | 4 ++--
 arch/powerpc/lib/vmx-helper.c          | 2 +-
 4 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.43.5


