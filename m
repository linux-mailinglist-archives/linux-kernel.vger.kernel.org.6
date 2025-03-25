Return-Path: <linux-kernel+bounces-575627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3562AA704F4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE6DD164769
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E9525C6E2;
	Tue, 25 Mar 2025 15:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qs3qYkkF"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E5281749
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916331; cv=none; b=HLnLlSg/guDQeoo28EjLUyW/BDjaWsuz4W6E89qnv9sQzZ88617PqnE6+0TtDAxkL8aXbIVUo266/IW3wXSfMKawmcbt9Zs23A7sv4SKemzx6qWtGSccPaU79Z90CLphp8BG2yZ6kbn1YXYKwV2tUzmr/aS1/IVbiFWDmnz1UxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916331; c=relaxed/simple;
	bh=h54x8t1PCATR732sZ4qT8sAiJemnhKuMcMI6s4hrTpo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LgUuDo3AzwM64ZpXi0dVFIEK7kfluU0nc+9IDOfju9jLgNHZJILrKsQ8wCHPboaufDziztpyi0c/dNkU2VmwH4xalvUHe8oQHvUnGmVdT7O1yYaIHctLmlh4fADGKFQnG9oVHidN0qTM/sJqhwEV/m22juh+M4mxZk1J7dLVaJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qs3qYkkF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52PE3GTR026302;
	Tue, 25 Mar 2025 15:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=DekOHVItqBqELoUTN744py+oUiPjvzWGJ/Ap1nj5o
	1s=; b=qs3qYkkFhvG+QpRnPQqr7y3mwRNzzJ8sVzCFEcTs3Cc/eC1Pd3uziDPCw
	5/nLDl0KaI0HUq7ifznhfrgIr96ZPvA4HL18IynaKMjFqdXvGFQOlRjIOOoGMGRk
	Qjq8xVPEgMnV+w6dJVqXPW05F6ttNtZJORxF8sRS2QFVZ5IigVzOQLL4LWjmsLZO
	eLqb8ybLYEHy51bO3hrdaPRGmxXc8gjA7HvdGZgFygZVJz1WiO6u255dQ4+OpOaL
	sTZGUfbsO27AmD/KP44mHgeqPq8QNxu7uPh8tmW0bzCb03QroBMNsCN8opq3BRl2
	8eQpLh2clN3/CdmCE2WPMAuvAcg5w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kwwq8ete-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 15:25:16 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52PFOfPq011335;
	Tue, 25 Mar 2025 15:25:16 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kwwq8eta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 15:25:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52PDsvvV009737;
	Tue, 25 Mar 2025 15:25:15 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkksta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 15:25:15 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52PFPBu846596442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 15:25:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6C1F2004B;
	Tue, 25 Mar 2025 15:25:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97B0420043;
	Tue, 25 Mar 2025 15:25:11 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 25 Mar 2025 15:25:11 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 2B6F5E055E; Tue, 25 Mar 2025 16:25:11 +0100 (CET)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/1] powerpc/64s: Do not re-activate batched TLB flush
Date: Tue, 25 Mar 2025 16:25:10 +0100
Message-ID: <cover.1742915600.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ME-RZcMcqTXsd7q_uAVOV5FXHh7koUGO
X-Proofpoint-ORIG-GUID: OELmDwiUVEGhwIwWIOnx7pu9D6zS72mK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_06,2025-03-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 mlxlogscore=478 spamscore=0 lowpriorityscore=0
 malwarescore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250105

Hi All,

I have no means to test the patch, it only passes a compile check.

Thanks!

Alexander Gordeev (1):
  powerpc/64s: Do not re-activate batched TLB flush

 arch/powerpc/include/asm/thread_info.h |  2 --
 arch/powerpc/kernel/process.c          | 25 -------------------------
 2 files changed, 27 deletions(-)

-- 
2.45.2


