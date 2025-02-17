Return-Path: <linux-kernel+bounces-517352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 585BDA37FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A1E1891EA6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280B521764D;
	Mon, 17 Feb 2025 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MlMZzFG/"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB10A216E2C
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787029; cv=none; b=GsQwepbxgXfxa8deLav8yWR3NI2V7jYr6XiavY++sa0cQd1CxDcvdlhrNhJ96FXtST92qdVBpIKBKMpWHhsq5i2IPG6YZT4ADUg/RAyE3JycpfpQcVLo5s9j+lUFnO1N7vaGH7NDKeGsFwyCHlxVaQeiKFT+awkMH+Fyx+531dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787029; c=relaxed/simple;
	bh=yDJVGT44F9t/5Ibufxl+6muXFLyVNnXza/dJanDbf+A=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=OmikP2o9a1CUidEHe24JzzIDBVW2mXnC2rxaonxyXOteTfB1J6J1s3DOzxP1VxmZFL1aG2rEaRsmUeA1prehWsyWV8Mm5NC/UqVIq0rwZv9u8OrwgRxNDBnyidqlhfNus4lz4kepePAd2qjLYGzyHqMjSpoMOZS9YeXhyH+twM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MlMZzFG/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51GLj4kX022143;
	Mon, 17 Feb 2025 10:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=6jHh/eg/sf7lgfStktsSnH72e62m
	zF8yRmqmIg5gknE=; b=MlMZzFG/+5D1DjTPP/+rafFKNnI8vydVyEIajJAZTDck
	juyeTzZVU2V6FeLMjjd44zAcWKxryyNAhAQWoIQsFKlBVEQ2fsh1PZvwQjyFGdj8
	IXQIRSr4ry1yrKzsTDA6lP1yYjvzbu/6iL7P7IkK3JsQSwHz6URplklr5bZXNBwR
	xWJPllTcO4JSfUE/XmiqH8qKEQvL33bCOynncaqJ4mQADYT1/PHPNOlzt8Rl370S
	kTwd6dPv5Jb7s0PGVAVEd9yUnj39g4gZABlFIrZjM2DFhXAOEiXa5Hn3tHf6cUat
	FHXgT9uBP5vPCca53fccZGfNnkuARloOMPfN3dHR8Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ujutkfj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 10:10:09 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51HA4Vm6007378;
	Mon, 17 Feb 2025 10:10:09 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44ujutkfj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 10:10:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51H684u4024851;
	Mon, 17 Feb 2025 10:10:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u7y1d7r3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 10:10:08 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51HAA8EA27656818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Feb 2025 10:10:08 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E56405805D;
	Mon, 17 Feb 2025 10:10:07 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48A815805A;
	Mon, 17 Feb 2025 10:10:03 +0000 (GMT)
Received: from [9.43.79.72] (unknown [9.43.79.72])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Feb 2025 10:10:02 +0000 (GMT)
Message-ID: <69e279d8-55f1-4196-b208-27487bb70dd4@linux.ibm.com>
Date: Mon, 17 Feb 2025 15:40:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Naveen N Rao <naveen@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.14-3 tag
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GPVrRolAU3OOIHdfuEcsbo7CUaNMf6GT
X-Proofpoint-GUID: ZTnJ_PKjlrpf0bSvmQ-zA2Yerwm3cq_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_04,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=712
 malwarescore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170088

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull couple of powerpc fixes for 6.14:

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.14-3

for you to fetch changes up to d262a192d38e527faa5984629aabda2e0d1c4f54:

  powerpc/code-patching: Fix KASAN hit by not flagging text patching area as VM_ALLOC (2025-02-12 14:38:13 +0530)

- ------------------------------------------------------------------
powerpc fixes for 6.14 #3

 - Couple of patches to fix KASAN fail during boot
 - Fix to avoid warnings/errors when building with 4k page size

Thanks to: Christophe Leroy, Ritesh Harjani (IBM), Erhard Furtner

- ------------------------------------------------------------------
Christophe Leroy (3):
      powerpc/code-patching: Disable KASAN report during patching via temporary mm
      powerpc/64s: Rewrite __real_pte() and __rpte_to_hidx() as static inline
      powerpc/code-patching: Fix KASAN hit by not flagging text patching area as VM_ALLOC


 arch/powerpc/include/asm/book3s/64/hash-4k.h | 12 ++++++++++--
 arch/powerpc/lib/code-patching.c             |  4 +++-
 2 files changed, 13 insertions(+), 3 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmezCewACgkQpnEsdPSH
ZJR/SA//eL0vRKOOGIHZ1g/uvV4D0HbtsJUObG97tpZXoNirTypba1/qMRxyqghu
d4GKKesibMexUPEICxHyy6hJb7V5cfVTWCqOy1CZg2jVs3QVclxVifHJDcW4oW2D
yCoaT23cMjht47QKXSgmQTqUHgKhLzyb575iQfx8EMDUXMT8UEsXF7GekhISGPNq
JySzN2j4/1229gYni22ta24lzxWwfSZX8xNLrDQ8JuAa0+JqCA4Yh6PM2WMohmYj
Y+5GQIMz7UpuPkdfdcsjmg/pyyGI/dC0ZAof/x3nHkn1rZfJ+T/HSeV2Zt2Aq8mq
o/qb+KtA+H+8J97158pxQQ24loJ5AYmYy5qwV20DRJCJrU5VFMxow46ZBzl1c6sw
FZ/TO/Vjc8keAnJQgRaW6cr4a7ojTHxuj25h0etH+c2BjSu0XZhiLJYlqFW5pYIA
rCPiEk7IkAEz37jQpGREaxNxFiolHcKkl4A8+Tr0YC3Nr4lrSqcqsjpWA7pGhYTR
zikZUMPkqYJYJRXPeOrQreLiuZaZwRY9EpwKVMI8TCNhhSkFRSneQNVMcdaKM95T
R4xuOwgDfhVjyv+XMwqMHxuCyk7M8fZxK2ikslB23s2LmYWoB0rePG0MRuIcUk7L
hlboeCTGwmbt1E48APU3PtAoK5NedCoUcbA3Zb/gNRCXioeUFSg=
=cSvh
-----END PGP SIGNATURE-----

