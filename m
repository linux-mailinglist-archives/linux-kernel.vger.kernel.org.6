Return-Path: <linux-kernel+bounces-561343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12681A6104B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B2B173B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE17D1F3BB6;
	Fri, 14 Mar 2025 11:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tlb/aZpm"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92DAD531
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 11:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952740; cv=none; b=WTSKKCAQA7zTteD07MDvcUz/bG1dCK7+KTCR1JxvLQrEs30YisH9lmqIXUVpi7TiBnSK9FyX90kKhrvoMxuizEDSywFMeJDmZ2eeeL5UE1l9o0bCsDkbkAP1GSVUj6F5DSjnBFdTvlEFBWQBAajMYALqdxzbvyp7IJKmHSB08Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952740; c=relaxed/simple;
	bh=ZyGVq0S0EOqM5FKt+DAdSJlYUvdd97L+RpScOrgFW7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tf54/d2Oc8JASdT/ItGPgXS1yubBz1i8xbkftG8jHZElgHfQthGJ9DTXTz3Jcorygbw9FQFH5VqXtEPubssyXQM2DmsAjI86h56PGB3lXSvLrnhBsgEiBxxjj0yZJcxx/V2KmfSt/24h8vChULUFXGFXBxKVks0YE30sUQHmdm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tlb/aZpm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EBWM4E007346;
	Fri, 14 Mar 2025 11:45:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=a4eygYsgH6xm9j1ChXbxlbPu3rkyFVZVTKzeR/0lq
	0s=; b=tlb/aZpmlthnowGS0PNnQfnS9cB+hM04WDklSxCXyYlMkG6c5X6NyxoNm
	D5UJ4Z/WSOTny8sXP9LIzOCiRTjm9ZIBLSioJ6Z5/qnpVGnhJjQ43g15BBIFjgCS
	ka3kwGsBmTpU1rCfRKCGQF6wvS9wxVA6H7YjbBTpdRMWBmzYp/DzLYgkQSTyZMMI
	N66k+TCSr3pmZ+yLYDMuDubFYlZhoQdz6E2wla+2d89abrzUGz1uep2xJtefcMMo
	xrtdiFIKq38IEH4/kH6bmV+dLPClm6qXeUzneUTAnv77Ik0aN2U+cL/VU2Xc8wux
	XrGjvLrJRB/7YLrNMKvVZeHBp2GiA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6s5b9m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:45:21 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52EBh9Q5023801;
	Fri, 14 Mar 2025 11:45:21 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6s5b9m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:45:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E8qbev003127;
	Fri, 14 Mar 2025 11:45:20 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atstxqca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 11:45:20 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52EBjHFV11600278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 11:45:17 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E536A20040;
	Fri, 14 Mar 2025 11:45:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 77FB62004D;
	Fri, 14 Mar 2025 11:45:13 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.22.126])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 11:45:13 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: maddy@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: sshegde@linux.ibm.com, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        mpe@ellerman.id.au, peterz@infradead.org, fbarrat@linux.ibm.com,
        ajd@linux.ibm.com, mahesh@linux.ibm.com, oohall@gmail.com,
        hbathini@linux.ibm.com, dhowells@redhat.com, haren@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] powerpc: use lock guards for mutex Set 1
Date: Fri, 14 Mar 2025 17:14:56 +0530
Message-ID: <20250314114502.2083434-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: lQBN-gJFQBdMZA5nDmDmNRwgD7dTPS11
X-Proofpoint-ORIG-GUID: QTQFsMH0n01PuCdtn-ytwrnZaQI54Aph
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_04,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=997 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503140091

This is an effort to make the code simpler by making use of lock
guards which were introduced in [1], which works by using __cleanup 
attributes. More details in v1 cover letter

This series aims mainly at simplifying code around mutex with goto
statements. If it makes sense, there are more code simplification which 
can done for preempt, rcu, spinlock as well. Even for mutex, there is
more which could be done. Even there are usecases for kfree which could
use the new __free infra. 

Please review. Code is compile/boot tested except for powernv. 
Have kept the patches separate for easier bisect. Let me if they should
be combined into one. Commit message is same for all. 

[1]: https://lkml.kernel.org/r/20230612093537.614161713%40infradead.org
v1: https://lore.kernel.org/all/20250314054544.1998928-1-sshegde@linux.ibm.com/#t

v1->v2:
- Fix changelog of powernv (Andrew Donnellan)
- use scoped_guard in couple of places to avoid holding mutex
  un-necessarily (Peter Zijlstra)

Shrikanth Hegde (6):
  powerpc: eeh: use lock guard for mutex
  powerpc: rtas: use lock guard for mutex
  powerpc: fadump: use lock guard for mutex
  powerpc: book3s: vas: use lock guard for mutex
  powerpc: powernv: ocxl: use lock guard for mutex
  powerpc: sysdev: use lock guard for mutex

 arch/powerpc/kernel/eeh.c                   | 20 +++----
 arch/powerpc/kernel/fadump.c                | 11 ++--
 arch/powerpc/kernel/rtas_flash.c            | 64 +++++++--------------
 arch/powerpc/platforms/book3s/vas-api.c     | 32 +++++------
 arch/powerpc/platforms/powernv/ocxl.c       | 12 +---
 arch/powerpc/sysdev/fsl_mpic_timer_wakeup.c |  8 +--
 6 files changed, 48 insertions(+), 99 deletions(-)

-- 
2.39.3


