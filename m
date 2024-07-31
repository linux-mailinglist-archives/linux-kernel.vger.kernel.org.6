Return-Path: <linux-kernel+bounces-268444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F9A9424B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 05:03:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E7C285F47
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 03:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223D214F70;
	Wed, 31 Jul 2024 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aOapW2Fb"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1422F22
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722394977; cv=none; b=ISUO1iMe+eh11/cURcRpNrNIjhvSQdIZz9eX0y1O/vgVXvMQvYOk+zT22nqoWUgfqRVmTafzoIAQ+cZMmN31zYY92aCsDAzpfEkyXM7vhi4ymeHXgfwKduf7eFul/oUQD6Tvb1c6lKoYymJTC8ohQnC73CWI9DZ73MSQXYoJP04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722394977; c=relaxed/simple;
	bh=mY6w9/Fs7uT6azY03gNQnsy3dAXvY5A8raCTbZGZD3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LXzigqZYHQ3PWI+dEbSVh8abGIbtycbH2aJZDnXeF07vRXOiajxhN8Chb+gjVx6NIvCoFJmT3EEjxyPnoKgGX7ClbD4I+U8zQgJo3M+IaeGzrVi5sd/cnMV3npefQjpzxLUTSrT1lvQ3YU2B9aZG+lJdzg1DTi5GsFIX+09jdxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aOapW2Fb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V0TV4Z011905;
	Wed, 31 Jul 2024 03:02:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=Cw63VamFp7AmPOSAUxa/qTud2ZXpcxSEr76YQB2
	tW38=; b=aOapW2FbziOEpRepubMdrr6A+vh1BVuaOkUUiH4xb+vBge3clMlpKb3
	AhC+paMDMuIINDawhSbvERBpSnozneoiHVf0Dg1unxOKjynYBW8jfAQDEGnWYxqV
	km1cdsp2dbHruzIb2xing1Ari8xCyrwf2lkPQZAEwuCYCP6+BsbH10vEW2E0Rgvk
	/m/0o/SgC1wR8yJIh5FXInea22BJ+lcYohGH7qW4TvhopISTY8ldZDxnd/JFD5Dg
	5xfE/0DqDN2RsCM+BRE63TxCc0UftQ58vNj4wnWFNfLaaEAvXCn4uxL9+7v7nGpq
	iU0ROnmLfas8EMreibrrPw0nqMd1eaw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q9vh8ahf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 03:02:06 +0000 (GMT)
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46V3266n020717;
	Wed, 31 Jul 2024 03:02:06 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40q9vh8ahb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 03:02:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 46V2rU2A011155;
	Wed, 31 Jul 2024 03:02:05 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40ncqmrufc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jul 2024 03:02:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 46V31xXJ53739994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jul 2024 03:02:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1741620043;
	Wed, 31 Jul 2024 03:01:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CD5B20040;
	Wed, 31 Jul 2024 03:01:53 +0000 (GMT)
Received: from li-80eaad4c-2afd-11b2-a85c-af8123d033e3.ibm.com.com (unknown [9.43.68.49])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jul 2024 03:01:52 +0000 (GMT)
From: "Nysal Jan K.A." <nysal@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
        Thomas Gleixner <tglx@linutronix.de>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>, Michal Suchanek <msuchanek@suse.de>,
        "Nysal Jan K.A" <nysal@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Eric DeVolder <eric.devolder@oracle.com>,
        Laurent Dufour <ldufour@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 0/2] Skip offline cores when enabling SMT on PowerPC
Date: Wed, 31 Jul 2024 08:31:11 +0530
Message-ID: <20240731030126.956210-1-nysal@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1RWiwBguWtvjASUZd3xOLv90iT6QqSpU
X-Proofpoint-GUID: BcFpmrep9d0bPBXfrSFi534L0ryxfdBC
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
 definitions=2024-07-30_21,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1011
 phishscore=0 mlxscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310019

From: "Nysal Jan K.A" <nysal@linux.ibm.com>

After the addition of HOTPLUG_SMT support for PowerPC [1] there was a
regression reported [2] when enabling SMT. On a system with at least
one offline core, when enabling SMT, the expectation is that no CPUs
of offline cores are made online.

On a POWER9 system with 4 cores in SMT4 mode:
$ ppc64_cpu --info
Core   0:    0*    1*    2*    3*
Core   1:    4*    5*    6*    7*
Core   2:    8*    9*   10*   11*
Core   3:   12*   13*   14*   15*

Turn only one core on:
$ ppc64_cpu --cores-on=1
$ ppc64_cpu --info
Core   0:    0*    1*    2*    3*
Core   1:    4     5     6     7
Core   2:    8     9    10    11
Core   3:   12    13    14    15

Change the SMT level to 2:
$ ppc64_cpu --smt=2
$ ppc64_cpu --info
Core   0:    0*    1*    2     3
Core   1:    4     5     6     7
Core   2:    8     9    10    11
Core   3:   12    13    14    15

As expected we see only two CPUs of core 0 are online

Change the SMT level to 4:
$ ppc64_cpu --smt=4
$ ppc64_cpu --info
Core   0:    0*    1*    2*    3*
Core   1:    4*    5*    6*    7*
Core   2:    8*    9*   10*   11*
Core   3:   12*   13*   14*   15*

The CPUs of offline cores are made online. If a core is offline then
enabling SMT should not online CPUs of this core. An arch specific
function topology_is_core_online() is proposed to address this.

topology_sibling_cpumask() might not be available yet for the to be
brought up CPU, so it cannot be relied upon to detect an offline core.

v2:
 * Document PowerPC specific behaviour when enabling SMT

v1:
 https://lore.kernel.org/all/20240612185046.1826891-1-nysal@linux.ibm.com/

[1] https://lore.kernel.org/lkml/20230705145143.40545-1-ldufour@linux.ibm.com/
[2] https://groups.google.com/g/powerpc-utils-devel/c/wrwVzAAnRlI/m/5KJSoqP4BAAJ

Nysal Jan K.A (2):
  cpu/SMT: Enable SMT only if a core is online
  powerpc/topology: Check if a core is online

 Documentation/ABI/testing/sysfs-devices-system-cpu |  3 ++-
 arch/powerpc/include/asm/topology.h                | 13 +++++++++++++
 kernel/cpu.c                                       | 12 +++++++++++-
 3 files changed, 26 insertions(+), 2 deletions(-)


base-commit: 94ede2a3e9135764736221c080ac7c0ad993dc2d
-- 
2.35.3


