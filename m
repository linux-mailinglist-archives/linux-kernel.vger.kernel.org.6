Return-Path: <linux-kernel+bounces-426028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A209DEDF3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04E0BB20E6C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA563F9C5;
	Sat, 30 Nov 2024 01:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PaLTwrbv"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B1AD31
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732929045; cv=none; b=TVfjkzGXzutyHADjG7DX1D1+zdMl9YWI8fI7nUy+iZ0liFRQppfAuMiEGQKrxHl8oSvU7sQsrYSe/ZvkHRoaAHXaCBP9j6kLjhxx6s2JCwVn2+rYlaek7LyJBtfqQCMJST1xWZ53ddBGRo3M3XpMAdPPjD+CyOLe8RgsKjlMHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732929045; c=relaxed/simple;
	bh=3ogUuzqBfv2t8KEZVUG9iUXXlQQw++xe/SdgmtXeQSs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=hT1ZQpk8TqHn6bla3ppNU/FpEd4xZ7B1RCu0+xrOAcFhK5Jmee/yquCoNsXFhAxqD7HARY953ILL30xBNKZz3Ko2faXkoXI6o26u8kL976oajIp7R30XgjMuTowZyrIeJiP3VZYxIauisjDjQ4QdJxuyUiT5OeJ28ufbk98n/lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PaLTwrbv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATHAETv018789;
	Sat, 30 Nov 2024 01:10:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=EbquJb4lm7WVJePb06HMNEZhNJ+F
	HhuTpWXriSFWdtU=; b=PaLTwrbv5wl/GkCNmZIIgZGhunNWsrbI5Ka5p2CBIM3s
	ms/az1q6eVRzzAGd0OH+FtuPE3eYtHkJcvPMhcDs2trIH4qCGp1Bp1eFwF4P/aGn
	iDW7xuzM4vTKNG9Gh0UT9QABKDAEN6iPC/SvYh54iaJU6UKBNhT/9ZnOwVpAfqyF
	N4qGtU0GQFbKvCLnwLwf/SY+M8ZvGvv/ZePn5hiYX+b289bKlIXEdHfxh4sjRP/I
	ZasZ5H9QCiz8eqWmDwOcIpvXQa8PmkF5QxX9XFMMdHy5Tnsx6Bd/xUXFs55kwF0i
	BYxztePHug0Pr7aSd49xckrfxv6i/REN2D77UlgYuw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4366ywwed7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Nov 2024 01:10:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4AU1ARdk026796;
	Sat, 30 Nov 2024 01:10:27 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4366ywwed6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Nov 2024 01:10:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATJCOOQ020409;
	Sat, 30 Nov 2024 01:10:26 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43672gctu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 30 Nov 2024 01:10:26 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AU1APhn43581912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 30 Nov 2024 01:10:26 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9EF715805D;
	Sat, 30 Nov 2024 01:10:25 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D29D058056;
	Sat, 30 Nov 2024 01:10:20 +0000 (GMT)
Received: from [9.43.79.125] (unknown [9.43.79.125])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 30 Nov 2024 01:10:20 +0000 (GMT)
Message-ID: <47937a7e-5303-4372-9975-df4ab545a3d3@linux.ibm.com>
Date: Sat, 30 Nov 2024 06:40:18 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        yang.lee@linux.alibaba.com, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu, npiggin@gmail.com, naveen@kernel.org
From: Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [GIT PULL] Please pull powerpc/linux.git powerpc-6.13-2 tag
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yL896XNF6Hn38xnBm5qgBmduLxf59dzh
X-Proofpoint-ORIG-GUID: ULE0XBYubXUH-E5SyTJ7nXDOAbnfC7Eu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=891 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411300007

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Linus,

Please pull a few powerpc fixes for 6.13:

The following changes since commit 42d9e8b7ccddee75989283cf7477305cfe3776ff:

  Merge tag 'powerpc-6.13-1' of git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux (2024-11-23 10:44:31 -0800)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git tags/powerpc-6.13-2

for you to fetch changes up to cf89c9434af122f28a3552e6f9cc5158c33ce50a:

  powerpc/prom_init: Fixup missing powermac #size-cells (2024-11-27 10:41:10 +0530)

- ------------------------------------------------------------------
powerpc fixes for 6.13 #2

 - Fix htmldocs errors in sysfs-bus-event_source-devices-vpa-pmu

 - Fix warning due to missing #size-cells on powermac

Thanks to: Michael Ellerman, Yang Li, Rob Herring, Stephen Rothwell.

- ------------------------------------------------------------------
Michael Ellerman (2):
      docs: ABI: sysfs-bus-event_source-devices-vpa-pmu: Fix htmldocs errors
      powerpc/prom_init: Fixup missing powermac #size-cells

Yang Li (1):
      powerpc/machdep: Remove duplicated include in svm.c


 Documentation/ABI/testing/sysfs-bus-event_source-devices-vpa-pmu | 15 +++++-----
 arch/powerpc/kernel/prom_init.c                                  | 29 ++++++++++++++++++--
 arch/powerpc/platforms/pseries/svm.c                             |  1 -
 3 files changed, 35 insertions(+), 10 deletions(-)
-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEqX2DNAOgU8sBX3pRpnEsdPSHZJQFAmdJTEkACgkQpnEsdPSH
ZJRfIBAAsuQzeIAeyngam7jOFUvT2RGdqICsNx7PyJBboue+8H2nkb8+I4biGH+9
KYOHxM4yzUM+NmBzWShy/PRVVkQkjdadFaX0LHOF0PYcy3ZSLHQ41z+zxcpMPGJm
0UySlg3IaJC1szuJ/wMf7FXtk9vPETsHa+jgcBSVtJNBoPY4hyFYdzqbDPoLBCX1
TH8ssvEzjRVpWOlKlHb1vCwvVDgWRcCf8oxaa9C5djdMVrr+ko5VNnOvQa5+GRwe
HRlhFQ4B64r2K1pKXiJdDLgdyjsxcde2iZXeSUC7UwVQDe//5sgP/9Y32FA7aumR
cxaJgtrp6SegYHmcd3jFk0LuidLOzMc9M64FRS6m33/DtbHoCgbrY8CZMmKatvKi
mMB7Ql3sEVUPe2ITU41yqLNZcqpTCD70jq1H4scpj8m7INYY7cEhZ2SuH/lTWvPr
/SPNZHQ4VMJVvVJWaJPCeSyDVBJ5CzU7GmBMINjq629hK8xrwAZEnDDA2emmc3JM
H6ihPP2qeN0YtY5+h90AbrCmmz5vQ06kYQWgIWPeFHTVvDk1VsntG6Wro3Vz6Yg9
kjz2U8QYOE3YeXH0URs0XgK1Fb4vhoX8aayM0RR7XCsuu1r7lKuae6J2i+8VuoUG
VsGdd9KurNPdyBUoNrE88nsT9xWvSIQxEikpMop3M5Y2zCgDtyM=
=QyNf
-----END PGP SIGNATURE-----


