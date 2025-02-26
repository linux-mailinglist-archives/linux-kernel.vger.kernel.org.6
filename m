Return-Path: <linux-kernel+bounces-532965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D90EA45439
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94010188BF21
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 03:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E88825D54D;
	Wed, 26 Feb 2025 03:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ITac/vdw"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B0445979
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740542378; cv=none; b=IWwiqM/Z4vrd0vvltbjVpznnd7DeoPtovMXcO/Qsakhoh1ShSIiq0VsodRmhu5Nvy1LRmKzbNlCLUfYfwDpZBi5SlKaBe2RYbLYxF8LfNaS0rDLz4PG18gBqmPhFvYa8PdR2VuoHqzSRx6/QKAV0Fwz0En4eE9o/4OCfYYi41NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740542378; c=relaxed/simple;
	bh=JFem/7WPlM/rLN7r5J/ez/NiGMaJxDxukWm2SZ0acVw=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=QxNCa+W8NkZ6zewc29O1u3+ojaGJ5yeNau9f1TpsQag/l3/3QhQpUCmgamaC4IH3L3GHlpiHg5mBBH4GzrJtpd3EVS0FMJ5Vj+Sz9T5vDVeQRdzbn/b9ZQ2RqIPA6mImtWS1GOrqnUfrxUVyR1015kGNkWfDdoTxNLEWAouCHvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ITac/vdw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q1kqMD028572;
	Wed, 26 Feb 2025 03:59:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=lbb2EYaTqrYLW/hbRhQ7MvoeKzpm
	8rT2BSNrqeTkGZc=; b=ITac/vdweHEqKLHUFprLC0DoifcdK2JatGG02ZwLT6B2
	7YsNXlvQqQgCQAQgJ6Z/gEMOKyo9ojkHylfHmijgXYNAxKKfMHej3oSP+4YpsV6l
	D2i1jDxAUWne+OG0uRqvW1bpOIvUGkBKt9VqcjxZACZV0tPA8g3vcYX15sxnU+xi
	sB/eZVfxWN+Tw5jysFUm+r6RXuWdBPSUIA+pP9k7SQRRN1TMaFhBObY9a+gT/rop
	FGMoYXh5O3plMJMgmHZpJl1POhKNkGn6gD2tcM62DN8TfN9UYJjh0C4iKmRtLPjw
	+u26Qjwl9K1IROSy3tHiAPURgw8JwvYGdSHV5JzsGw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451q5m8xug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 03:59:18 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51Q3xIQ2023050;
	Wed, 26 Feb 2025 03:59:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451q5m8xtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 03:59:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q08TD6026354;
	Wed, 26 Feb 2025 03:59:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44yswngma6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 03:59:02 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51Q3x2CD21234144
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 03:59:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A0245805F;
	Wed, 26 Feb 2025 03:59:02 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9D4658043;
	Wed, 26 Feb 2025 03:58:55 +0000 (GMT)
Received: from [9.43.65.188] (unknown [9.43.65.188])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 03:58:55 +0000 (GMT)
Message-ID: <8ce77d4d-cd19-472b-a526-0c80feb2b028@linux.ibm.com>
Date: Wed, 26 Feb 2025 09:28:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Donnellan <ajd@linux.ibm.com>,
        Bagas Sanjaya
 <bagasdotme@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, Naveen N Rao <naveen@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.14-4 tag
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0y8MZNw5xkoeLVax816qcmv3mZpeSElb
X-Proofpoint-ORIG-GUID: SZz9kxXELDzWkYv7JjrGO4rsdSsu0lR-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=679 mlxscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260029

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull powerpc fix for 6.14:

The following changes since commit d262a192d38e527faa5984629aabda2e0d1c4f54:

  powerpc/code-patching: Fix KASAN hit by not flagging text patching area as VM_ALLOC (2025-02-12 14:38:13 +0530)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.14-4

for you to fetch changes up to eff2eb592efd73f00590d578c3d6021f604df62c:

  cxl: Fix cross-reference in documentation and add deprecation warning (2025-02-19 13:33:58 +0530)

- ------------------------------------------------------------------
powerpc fix for 6.14 #4

 - Fix for cross-reference in documentation and deprecation warning

Thanks to: Andrew Donnellan, Bagas Sanjaya

- ------------------------------------------------------------------
Andrew Donnellan (1):
      cxl: Fix cross-reference in documentation and add deprecation warning


 Documentation/arch/powerpc/cxl.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAme+kI4ACgkQpnEsdPSH
ZJTRHg//cAiqHzzrYX9jErT/3QGrvjRLIUUSlZxXKnS1pObH1IjryIR+KXVh6Jsh
IKuKRFtWGIiffX829hd7kwfVQ15T5iK0dIR4q2kFxWf4x6Znd1AUyVjrUTiGzs/R
iP3JMItipD/q3uFfdJR/Dy0H4oV8/F+53g++m9EteZErBLvYjutq53mq9d40Teiw
K+n21GVToZ5sHafILA9wRrj1MzkWhzFqZl84s9SV2ReBCTYSx2KixWXWFNLf4dvJ
ynFPJIka1x3IZB4Lv6GlwxgRkUT3YMSrcMEKd4s2kWrPRxTBKd4Rvo6OjoGWleV8
C7IunJtSABJDXuSAKq6S0cF0cvDbs6E8nMJEXjYwFKgNL0OWVBa38YEsSuVXndcy
YdROZtHEjx9vNK+APpLZSaDD6TcShqCICgSccWSLFKssdsL0//ZRn7M1VKsqJ2La
3RvXl5I1Uf7hxGAE/O4nfATW0SrYNUrXU4b4uSAnEBGzDI6Ot73XE+UXEao4y2bH
c97IthhClqW3WD+mV/+3jFArK6QatEls4lsK6TqKYLdTjfaLTHdzs/SYkt9SYT1u
XMfhDy5eg5WjjyxAQGbhuF+yu/Ljws+uRuALIalGpLCL/KFI8wsaaOYBKRLtt4Yl
gSdsNDRFP4AJFZVwEM1ypC/xQ0uSU76LSsdcareljrzkrgiDi/8=
=7YO9
-----END PGP SIGNATURE-----

