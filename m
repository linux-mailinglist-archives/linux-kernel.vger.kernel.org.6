Return-Path: <linux-kernel+bounces-399315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBC79BFD5B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 05:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22ADCB21833
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 04:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187A31885A5;
	Thu,  7 Nov 2024 04:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UjXXwFec"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5ED1B815
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 04:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730953273; cv=none; b=N9wtxFR6DWIeIRYAY85a4Tx3iV97A4PS55yhM56Wc2jDJqm6M7/QkfHDL6nSsG+CqVa3CtPv6Aeqsy/hwRDkhfCrEK6z4TpiAEI99IfBqsKCiZ7sypcDpNSCQ/jEdjbJT5KMZTYdkB6agSTeEply+2RKsg9j5oEP+gENQo3XroM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730953273; c=relaxed/simple;
	bh=kEgZNofGmCHtVgS/myiHMNITxztZaqIdvuTY483cdoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IjhmKQlso8EG4JB148sS18hzkCREELqQNo0p365b1cWw1gTHO+jCT7Jz5KHUbMrXaMga3w8DfIK8oqXJSNOo/t6Ax0LWnK6hJRu/wBbwze71NzSAbATOVyQoQwvBFzWwSRcGYAWRXrpZHKWZvHDFT/zRWIcKwne/BvZsQMDVtOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UjXXwFec; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A73fG4j009789;
	Thu, 7 Nov 2024 04:20:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=G500xfm2jOBkULiRFKYuziqZWRhAOk2Dm8/VcpPcT
	xw=; b=UjXXwFecKD+zQO2Emf58D6m3sQaMc4m/0zw/bXGKDlX2Br8zMjRwt+eNg
	an8H5xOv4tPSMMXRbh8/jebBe6PK+pCfNWNige2WCB5xvfzTB4lNInT3lRBOSbE9
	GuxIAJ1m46idlRCv9yKIjlg9B7yu6SPVTZW1o4+EX1c93NqdWTQZ9Gc9TDqpDOgk
	vc3LDdZxzN9tEAkTeWwPnyUaPBILvbepSPcgbCIfU/bGKwcJOl6yRAunY6cIDNaE
	0gkbs9qLs31N7ZXERw2mOrOap3Wdy/LcDvb1Wd4a8Cq8PdIuQ7+cdekN/CrfrT9J
	yMBl8vUhXGE0JefE3O5pFHw5N+WeA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rnudg56h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 04:20:52 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A74KpLj020832;
	Thu, 7 Nov 2024 04:20:51 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42rnudg56e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 04:20:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A71oVlQ019096;
	Thu, 7 Nov 2024 04:20:50 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj7dtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Nov 2024 04:20:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4A74Klfc57934216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 04:20:47 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 281602004B;
	Thu,  7 Nov 2024 04:20:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2867420043;
	Thu,  7 Nov 2024 04:20:45 +0000 (GMT)
Received: from ltcrain34-lp2.aus.stglabs.ibm.com (unknown [9.3.101.41])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 Nov 2024 04:20:44 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
        linux-kernel@vger.kernel.org
Cc: mahesh@linux.ibm.com, oohall@gmail.com, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, maddy@linux.ibm.com, naveen@kernel.org,
        vaibhav@linux.ibm.com, ganeshgr@linux.ibm.com, sbhat@linux.ibm.com
Subject: [PATCH] powerpc/pseries/eeh: Fix get PE state translation
Date: Wed,  6 Nov 2024 22:20:27 -0600
Message-ID: <20241107042027.338065-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mK7DeQXtkOlVp490AQDdrD9OdMNEByH0
X-Proofpoint-GUID: g2t97kBqqIh4sRjtkjPa6LFTvW37jXDJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=962 phishscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411070030

The PE Reset State "0" obtained from RTAS calls
ibm_read_slot_reset_[state|state2] indicates that
the Reset is deactivated and the PE is not in the MMIO
Stopped or DMA Stopped state.

With PE Reset State "0", the MMIO and DMA is allowed for
the PE. The function pseries_eeh_get_state() is currently
not indicating that to the caller because of  which the
drivers are unable to resume the MMIO and DMA activity.
The patch fixes that by reflecting what is actually allowed.

Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/eeh_pseries.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/eeh_pseries.c b/arch/powerpc/platforms/pseries/eeh_pseries.c
index 1893f66371fa..b12ef382fec7 100644
--- a/arch/powerpc/platforms/pseries/eeh_pseries.c
+++ b/arch/powerpc/platforms/pseries/eeh_pseries.c
@@ -580,8 +580,10 @@ static int pseries_eeh_get_state(struct eeh_pe *pe, int *delay)
 
 	switch(rets[0]) {
 	case 0:
-		result = EEH_STATE_MMIO_ACTIVE |
-			 EEH_STATE_DMA_ACTIVE;
+		result = EEH_STATE_MMIO_ACTIVE	|
+			 EEH_STATE_DMA_ACTIVE	|
+			 EEH_STATE_MMIO_ENABLED	|
+			 EEH_STATE_DMA_ENABLED;
 		break;
 	case 1:
 		result = EEH_STATE_RESET_ACTIVE |
-- 
2.45.2


