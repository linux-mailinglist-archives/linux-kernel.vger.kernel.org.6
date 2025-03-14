Return-Path: <linux-kernel+bounces-560700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98467A6086B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8F423B7CE9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 05:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD012146013;
	Fri, 14 Mar 2025 05:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Je9Wnab6"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01923BBE5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741931190; cv=none; b=aIqiY+2p/Ps2MiPC5o3z2z+UnZefgLSXqYcq28KHGuRRtZlPJfCcgBbHg6hP/ggWfCp8EfFqJkDqtKHIpByFehb1a08p6CEu4pw6jEPGZ2fIcv6rXiKo87r4IxL7OVmJV+qGx1NfUbf6n1ibcXij1eZFkdsceXSSfmpKv4wWa4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741931190; c=relaxed/simple;
	bh=RFi8o4o94onioqB7wY4x1NdvCuChEdPu0JfNT/4qdCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SopCwtqkVIwF2NmyxLo3zBIM2nWXuqIGwLB7NoBnKDJT8qij1tW7Ea0XiBNaocb3oGokyByotU9LgWLHSs1XrDJoWfKHGaP9XJP44QBjXOUCMrfW0DiwVjuFLARQS3xihsEXaZ6yLnYcTSFi2TmuvHIsVSPyoP0MeL6vQWq6Xxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Je9Wnab6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52E3ktVl020958;
	Fri, 14 Mar 2025 05:46:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=wwlDMZe+xh8sbxfiNCFheDhzaupP3ckAM7W/nWES+
	r0=; b=Je9Wnab6rCUHQPXK9JQl7r0KsgWu4Jii3TWZBFAOtpAfyOHoew7SWfNiU
	oez2GEy9/Nhf36yPe+w/oeV8VMrFYn37QDKTmE75hx7J0VPHa1G0b7hcPZtyBIdf
	ItCIH/u7cnPkiWyEV7NQBfg0zxYuBB+PoPnxuFg36pLWQHGjDZrqhX4qgv7lbjwZ
	80hreVUTEucLtRu0KqegAKgs6H+MJtPES7phaAdW88l7aYLnQwwA1ZTp5g5PFMVM
	6nE6NsGQlCbt/T/VESkYDEoIYwrpkNin+1Xj2WwaKXmhSeXyNJH9GLOEtw7h4i6F
	lIwUeKPpiw8OpUb0Tbu+0/4D7wT3A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ccu98dh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:08 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E5gJeX023702;
	Fri, 14 Mar 2025 05:46:07 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45ccu98dh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E4rWVH026064;
	Fri, 14 Mar 2025 05:46:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspnfe1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 05:46:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E5k3Ir50135350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 05:46:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECE792004B;
	Fri, 14 Mar 2025 05:46:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9648F20043;
	Fri, 14 Mar 2025 05:45:59 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.22.126])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 05:45:59 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mpe@ellerman.id.au, peterz@infradead.org, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, mahesh@linux.ibm.com, oohall@gmail.com,
        hbathini@linux.ibm.com, dhowells@redhat.com, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] powerpc: use lock guards for mutex Set 1
Date: Fri, 14 Mar 2025 11:15:38 +0530
Message-ID: <20250314054544.1998928-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kBUK3w_vUdZu7_3iBtqP0uURKuktgseM
X-Proofpoint-GUID: gwxY4D3Mh18Rkik7560nX4xBncbHnb4o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_01,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxlogscore=891 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140041

This is an effort to make the code simpler by making use of lock
guards which were introduced in [1], which works by using __cleanup 
attributes. 

[1]: https://lkml.kernel.org/r/20230612093537.614161713%40infradead.org

This series aims mainly at simplifying code around mutex with goto
statements. If it makes sense, there are more code simplification which 
can done for preempt, rcu, spinlock as well. Even for mutex, there is
more which could be done. Even there are usecases for kfree which could
use the new __free infra. 

Copying from the cover-letter of [2], summarising the effort as below.
TL;DR:

	void foo()
	{
		mutex_lock(&lock);
		if (!cond)
			goto unlock;
		...
	unlock:
		mutex_unlock(&lock);
	}

can now be written like:

	void foo()
	{
		guard(mutex)(&lock);
		if (!cond)
			return;
		...
	}

[2]: https://lore.kernel.org/all/20230801204121.929256934@infradead.org/


Please review. Code is compile/boot tested except for powernv. 
Have kept the patches separate for easier bisect. Let me if they should
be combined into one. Commit message is same for all. 

Shrikanth Hegde (6):
  powerpc: eeh: use lock guard for mutex
  powerpc: rtas: use lock guard for mutex
  powerpc: fadump: use lock guard for mutex
  powerpc: book3s: vas: use lock guard for mutex
  powerpc: powenv: oxcl: use lock guard for mutex
  powerpc: sysdev: use lock guard for mutex

 arch/powerpc/kernel/eeh.c                   | 20 +++----
 arch/powerpc/kernel/fadump.c                |  6 +-
 arch/powerpc/kernel/rtas_flash.c            | 64 +++++++--------------
 arch/powerpc/platforms/book3s/vas-api.c     | 19 ++----
 arch/powerpc/platforms/powernv/ocxl.c       | 12 +---
 arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c |  8 +--
 6 files changed, 39 insertions(+), 90 deletions(-)

-- 
2.39.3


