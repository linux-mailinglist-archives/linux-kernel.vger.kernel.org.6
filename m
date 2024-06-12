Return-Path: <linux-kernel+bounces-212124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C154F905B83
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48EB2B22BBA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 18:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D41D4F8A0;
	Wed, 12 Jun 2024 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AL1cUtHJ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5C047A6C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 18:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718218307; cv=none; b=e74WGoInlcskj4j8xnARYuaQ3qjd6R+ESPj46mvMfIHnfphGi7uuNKhTKOkGiR06QWuzHz1M0RBbUNN1S4aTnbczuBv4r6uP/O4kH/ConLeKrh+nxZUubOeqrnSaRN4j1CKPiwPReyyXX9t0Xb3M9Zd+Os20YKf6zRoVDzbp/7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718218307; c=relaxed/simple;
	bh=frJxwcAjiFNOhQWeHaNFArt3zlqd0jqK4+vYuhq52Do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3S9KDaiV9Sz1ViVN/RpXCsk4qh9dTSFJmRp0RU1Ct6ihlug02jda1PiWj/YsjT2YY0Mw5a42je2DYMZlyYymdGFSxFnbViJj0sW0VaHDCJD5eGs5ymEFzX5FjtK849PuYjAGEt6dxLUQ4aBFBeAbSVUR8u7neapblcslt9EqHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AL1cUtHJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CI6I8i021160;
	Wed, 12 Jun 2024 18:51:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=9Ob/qXrjqJAceSoyxB449ZMXx3laWo8V/LAGxnO
	iFvY=; b=AL1cUtHJFTKXNwbaBrGQdFBW6szx73qKo6wnarT3H7z7KT/Z47JxY0F
	hzN5f7ECicPi2FuidPTsJ7t6S5TRVQugAxomrw+Rr6gG7zt633H1g7gQ3FjH9bx3
	HjJKxTGx2DjvkCzok1ah5jSTu4z8j1KXsh/49HI6VofUmrVm5xNF7N1+Oe4+jiQT
	oAAYrbQCaVI4hJ7+Uvh9plmoXO04vDSt4N4dTffWb8d61M7XCJOTkcqW3svHM8Wk
	cQmNQ/hR0mqOf2t31MhXUOP6D3ueFBbm5Hs3m+3axeJBb7Dltv2J7N+7u3aAzPpq
	2iKEqhkCer76jXI1s7SWttXmEfs8Akw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqg490761-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 18:51:15 +0000 (GMT)
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45CIpFXU020173;
	Wed, 12 Jun 2024 18:51:15 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yqg49075y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 18:51:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45CHfX85023575;
	Wed, 12 Jun 2024 18:51:14 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3yn3umreek-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 18:51:14 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45CIp8js49283424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 18:51:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8E1E020040;
	Wed, 12 Jun 2024 18:51:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62B3E2004E;
	Wed, 12 Jun 2024 18:51:05 +0000 (GMT)
Received: from li-80eaad4c-2afd-11b2-a85c-af8123d033e3.ibm.com (unknown [9.124.218.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Jun 2024 18:51:05 +0000 (GMT)
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
Subject: [PATCH 0/2] Skip offline cores when enabling SMT on PowerPC
Date: Thu, 13 Jun 2024 00:20:36 +0530
Message-ID: <20240612185046.1826891-1-nysal@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A8EvnlEsFP_fq-jmA-CGzT_5k9TZM_oG
X-Proofpoint-ORIG-GUID: 2qjCPoA-xRvzEyff9YZjmR_nt2ylZ3Ry
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
 definitions=2024-06-12_09,2024-06-12_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=901
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406120131

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
Another approach is to check the topology_sibling_cpumask() for any
online siblings. This avoids the need for an arch specific function
but is less efficient and more importantly this introduces a change
in existing behaviour on other architectures.

What is the expected behaviour on x86 when enabling SMT and certain cores
are offline? 

[1] https://lore.kernel.org/lkml/20230705145143.40545-1-ldufour@linux.ibm.com/
[2] https://groups.google.com/g/powerpc-utils-devel/c/wrwVzAAnRlI/m/5KJSoqP4BAAJ

Nysal Jan K.A (2):
  cpu/SMT: Enable SMT only if a core is online
  powerpc/topology: Check if a core is online

 arch/powerpc/include/asm/topology.h | 13 +++++++++++++
 kernel/cpu.c                        | 12 +++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)


base-commit: c760b3725e52403dc1b28644fb09c47a83cacea6
-- 
2.35.3


