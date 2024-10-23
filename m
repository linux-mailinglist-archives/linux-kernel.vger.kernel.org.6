Return-Path: <linux-kernel+bounces-378880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9209AD6A7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F71F285795
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654E51EF925;
	Wed, 23 Oct 2024 21:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MHNiOOwR"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EF4E56A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718652; cv=none; b=QPPWSQytc7L2c3CqmUUxBTQOJ/c+QAklo75X2TpJ8oDXpXMNdWimFkHAoEu3xzKgQl8FO+lO8cJgKnqwsnWqfZ7t3hIbCQPc1DPck+oOdLuQ8ARBUhtGu+38U+/dFmtxSrxiskRH7/BCh8DXDQ6osJCZxDKzDNNS8YKymO34E30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718652; c=relaxed/simple;
	bh=Q5kNViwwQxoEPKN17gUKEtAhO5AOuMh/3+Jxh51MQ0o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qY8Dpo98bgOUKHemsY76fYO7OK6MMJuSDqkUWgyAgRfgDZuY4NtdDBk7lg+E+7dxrBitkM/agnKqXnzWRZNNKZwF4gxANmaLh8msAVzAsNtKmT23GysVytVm+r3hsgBgoewsvGpeyYjgC2jOlWNEuDhlyuH36RdOVq0+ZVPWNLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MHNiOOwR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NF6Nkm018844;
	Wed, 23 Oct 2024 21:23:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=w6/XyakDp8eyHd3VBcLyqRn+Elmw9FFQMqdtyMVrS
	+A=; b=MHNiOOwRTXTNLIcJ8qovp1ULJCHb/32/cnJjAepOj8LMwy7K9z/QjAEYe
	1TpNsqKOsXqp2gi19UEPNJvbSyFq2QGXJdhNefm1dnEdrM7ovrTrEjDbvGyK+tIq
	H0jVLxYp1oubr/qevzqLK2pn34NuS0rw4V0BAlz/FG3JVQ6XGHvW8/a5LOsVS76j
	UH1fZzd+TgX5Aiz95c1n9nKdVzAhfY8YaiZAXcw7CocMUqYmUNkNnDDS8M9ofPxv
	e/fhf51qkAo44Vc/JMrfFf/YApR+GtXxShLAe8Ji6503tlvcTfgXdA2SAXkRJ8Pv
	QpH1wUOq0Nqw3tQl/NDbr4uO9YavQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajn693-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 21:23:48 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49NLNlB2005536;
	Wed, 23 Oct 2024 21:23:47 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42emajn68y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 21:23:47 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49NIuGR8008807;
	Wed, 23 Oct 2024 21:23:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emkan1q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 21:23:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49NLNhRo37159224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 21:23:43 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F08E620043;
	Wed, 23 Oct 2024 21:23:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C512F20040;
	Wed, 23 Oct 2024 21:23:40 +0000 (GMT)
Received: from li-e1dea04c-3555-11b2-a85c-f57333552245.ibm.com.com (unknown [9.43.16.156])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Oct 2024 21:23:40 +0000 (GMT)
From: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
To: mpe@ellerman.id.au
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org,
        maddy@linux.ibm.com, peterx@redhat.com, groug@kaod.org,
        sshegde@linux.ibm.com, mchauras@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/xmon: symbol lookup length fixed
Date: Thu, 24 Oct 2024 02:52:26 +0530
Message-ID: <20241023212225.1306609-2-mchauras@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZIc45Zu_WHg3HGSQcqhevGIeHX6PQS-x
X-Proofpoint-GUID: _Cme4AwGfZ0ENcCz5ImKYShPdhRxUccL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 malwarescore=0
 mlxscore=0 phishscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=785 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410230136

Currently xmon cannot lookup symbol beyond 64 characters in some cases.

Fix this by using KSYM_NAME_LEN instead of fixed 64 characters.

Signed-off-by: Mukesh Kumar Chaurasiya <mchauras@linux.ibm.com>
---
 arch/powerpc/xmon/xmon.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index e6cddbb2305f..22b8b5cc4df0 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3662,7 +3662,7 @@ symbol_lookup(void)
 	int type = inchar();
 	unsigned long addr, cpu;
 	void __percpu *ptr = NULL;
-	static char tmp[64];
+	static char tmp[KSYM_NAME_LEN];
 
 	switch (type) {
 	case 'a':
@@ -3671,7 +3671,7 @@ symbol_lookup(void)
 		termch = 0;
 		break;
 	case 's':
-		getstring(tmp, 64);
+		getstring(tmp, KSYM_NAME_LEN);
 		if (setjmp(bus_error_jmp) == 0) {
 			catch_memory_errors = 1;
 			sync();
@@ -3686,7 +3686,7 @@ symbol_lookup(void)
 		termch = 0;
 		break;
 	case 'p':
-		getstring(tmp, 64);
+		getstring(tmp, KSYM_NAME_LEN);
 		if (setjmp(bus_error_jmp) == 0) {
 			catch_memory_errors = 1;
 			sync();
-- 
2.47.0


