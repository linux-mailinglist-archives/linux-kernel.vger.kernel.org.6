Return-Path: <linux-kernel+bounces-212126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A00905B89
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B47E1C23230
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5541B5026B;
	Wed, 12 Jun 2024 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bY7LK+7x"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7716A47F4B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218327; cv=none; b=UxY+Xcu1Cefkpu327eqIusc86SDTDtwSMTarTdN8GESDVI+9VE9V+Z/aBQsB7PIwAE6K1CT5D0GIpKxMnZNHCHoHJMENmk9rOYgKac8bKEEw9IBXX3SO4dlrUCa3BgmTJh4Ze5xxG0YImGrLBjpA5WHC1PWz4ApzyoFT7lTNrUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218327; c=relaxed/simple;
	bh=PG1bFqeFk5Lc60DN/Lt609hwPugkI+zeivDWNXduiSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxoNW0hyQ92LfLuz22Z0TW+b2zcmYr9Ag3BW5tc9i1uvQt5EwBLhzBXh9H8ZZ/KWaP0w5keENHTLd0D8k7mch15HqgWJRrFwq4nn2nKLJnoSjWWpYOyfA0Vti2nTiCstEVWh0BD7PkReWjeHY7b2B0Qicpk0ZNPN4vQBw+Hq6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bY7LK+7x; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CISZPN007957;
	Wed, 12 Jun 2024 18:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:mime-version; s=pp1; bh=MD67BdAwifPZ1
	dU/JKi5Ip4TNIM/gw85XZ+IPnnJr0Q=; b=bY7LK+7xDJ7mEjtc6Pwmtvl2HEahZ
	CLPc9/erJvy5UEjmPyXAgEn6ipAA8EmVE6tlku93zINn5boco0xK29patnGsWTXR
	6H/r7+1jSF+L7f5AJ86gfn51pl5Dy6VO1iViFkGfYTxtNPl7A04o0IZHip9tVQjS
	ChgyBnVUzKAOYQialOzxG4tqahR5adHi24F12NsaF9mVevPhFnOF4pKA6s9Q+cQL
	Q8c4UtxVuRXpM3eHYeOniapxmsz6o7o0QFUemg/NjKrpPDmmz3NjO7+GouF41uI7
	PGrnsX3Na5v5+9T4jRl932B20VTsxd5fmGqBtIR3gZgYa/c8hzrmMssSQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqgywr1r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 18:51:38 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45CIpcT5008553;
	Wed, 12 Jun 2024 18:51:38 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqgywr1r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 18:51:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45CIYwKH027225;
	Wed, 12 Jun 2024 18:51:36 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yn2110w08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 18:51:36 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45CIpUt845940992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 18:51:32 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91FF82004E;
	Wed, 12 Jun 2024 18:51:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6AC6020040;
	Wed, 12 Jun 2024 18:51:27 +0000 (GMT)
Received: from li-80eaad4c-2afd-11b2-a85c-af8123d033e3.ibm.com (unknown [9.124.218.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Jun 2024 18:51:27 +0000 (GMT)
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>,
        "Nysal Jan K.A" <nysal@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpu/SMT: Enable SMT only if a core is online
Date: Thu, 13 Jun 2024 00:20:37 +0530
Message-ID: <20240612185046.1826891-2-nysal@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240612185046.1826891-1-nysal@linux.ibm.com>
References: <20240612185046.1826891-1-nysal@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _FymjdG9hxQu0ljped2JCYQ1pRpx8xOv
X-Proofpoint-ORIG-GUID: h2VSBv1c2klquPJqT3PB7zSTLNv1gZW4
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_08,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406120131

From: "Nysal Jan K.A" <nysal@linux.ibm.com>

If a core is offline then enabling SMT should not online CPUs of
this core. By enabling SMT, what is intended is either changing the SMT
value from "off" to "on" or setting the SMT level (threads per core) from a
lower to higher value.

On PowerPC the ppc64_cpu utility can be used, among other things, to
perform the following functions:

ppc64_cpu --cores-on                # Get the number of online cores
ppc64_cpu --cores-on=X              # Put exactly X cores online
ppc64_cpu --offline-cores=X[,Y,...] # Put specified cores offline
ppc64_cpu --smt={on|off|value}      # Enable, disable or change SMT level

If the user has decided to offline certain cores, enabling SMT should
not online CPUs in those cores. This patch fixes the issue and changes
the behaviour as described, by introducing an arch specific function
topology_is_core_online(). It is currently implemented only for PowerPC.

Fixes: 73c58e7e1412 ("powerpc: Add HOTPLUG_SMT support")
Reported-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Closes: https://groups.google.com/g/powerpc-utils-devel/c/wrwVzAAnRlI/m/5KJSoqP4BAAJ
Signed-off-by: Nysal Jan K.A <nysal@linux.ibm.com>
---
 kernel/cpu.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 563877d6c28b..73c4a6f98c4a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2676,6 +2676,16 @@ int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval)
 	return ret;
 }
 
+/**
+ * Check if the core a CPU belongs to is online
+ */
+#if !defined(topology_is_core_online)
+static inline bool topology_is_core_online(unsigned int cpu)
+{
+	return true;
+}
+#endif
+
 int cpuhp_smt_enable(void)
 {
 	int cpu, ret = 0;
@@ -2686,7 +2696,7 @@ int cpuhp_smt_enable(void)
 		/* Skip online CPUs and CPUs on offline nodes */
 		if (cpu_online(cpu) || !node_online(cpu_to_node(cpu)))
 			continue;
-		if (!cpu_smt_thread_allowed(cpu))
+		if (!cpu_smt_thread_allowed(cpu) || !topology_is_core_online(cpu))
 			continue;
 		ret = _cpu_up(cpu, 0, CPUHP_ONLINE);
 		if (ret)
-- 
2.35.3


