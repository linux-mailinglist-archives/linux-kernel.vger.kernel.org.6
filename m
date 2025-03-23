Return-Path: <linux-kernel+bounces-572897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E4AA6D009
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 17:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804063B063B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 16:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F39913D8A3;
	Sun, 23 Mar 2025 16:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hWQnJr1D"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF277083F
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742747791; cv=none; b=NT22kKjzXeDHpFK+ev26sY2a1ExxV4DsfT2M7trLeiQCfJAyT2C+hUnxGxaKPkCaX+Cg5+rfPRs+QQGtyKyhBLfy0uiv1qS4saiqEfQaLJ/qYWGYUIip7ZDv2ebSk4X5i5eEU4qqy/i6GosyDljPiFKDV/lTz1Q73s18eR38GOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742747791; c=relaxed/simple;
	bh=V1AQ3w6/I5Xzq75wMz+363M+nSUKpawpBkKf6zhFbkY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P+MOFyOBcZyx8Uo3IQ0tLL+adVSeD7q72GyDVcP59UgKel6XeFAfpNkKJaejAVTjqjnjgJvyL15xbN59rwF7lodZCrfB9xXocAxTRWbkqKoBs7TotY6Slz6l06JyXoXXj/Fyhehv0Z6L/Z0MC6rjuadxyshYq+eIpX9RlKtCmKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hWQnJr1D; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NEo12C003437;
	Sun, 23 Mar 2025 16:36:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=zYFClfgkO9qdXVkM/ZQpyp/wziIE
	GY38SaM5CX73tds=; b=hWQnJr1D/MfgNFGt7X6s3au/37YVKHxiqHzqRrKV6/zE
	7iMaeQyc3g6B/fOWDiry6yDY5swoUm+XnVLwulcq8FMyzM7fSNOoCb+8xM2DaHtW
	yWd4a44dNgYZTtcljwY+cQjeltiH9IS75v53/QPbMw+sh+0e2jl8wBGnPIYWJIJo
	7R5QgmRwr0vVnmYgUzI6PtiUaeSr/5cLgPUQX+J1ebE8xHB4CY6dTXzp02SrqcPG
	jZXtyZbTmQB+goIEozcxYbiLvb+o+Jncp12AAoQsTMcnk8XM9aTP0EnfhmPJXyY1
	dzLwRDiutkNTZepZTg3e6PNQo/TvDFLKT4xx/z92ZQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45j4dyjth2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 16:36:14 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52NGaDqh004125;
	Sun, 23 Mar 2025 16:36:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45j4dyjth0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 16:36:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52NCUfca012245;
	Sun, 23 Mar 2025 16:36:13 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91ktcym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 23 Mar 2025 16:36:13 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52NGa9S853019014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 23 Mar 2025 16:36:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20B0320043;
	Sun, 23 Mar 2025 16:36:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8EF920040;
	Sun, 23 Mar 2025 16:36:07 +0000 (GMT)
Received: from ltcden6-lp1.aus.stglabs.ibm.com (unknown [9.3.101.155])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 23 Mar 2025 16:36:07 +0000 (GMT)
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, naveen@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] arch/powerpc: Remove redundant typedef for bool
Date: Sun, 23 Mar 2025 11:36:06 -0500
Message-ID: <20250323163607.537270-1-misanjum@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KvBq6swmhGa7brEMdTUFbP8eZo2iR_Q3
X-Proofpoint-ORIG-GUID: K7H55Wf9TYd2tTWZVq_JfCMskNPP7kLA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-23_08,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=701 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 malwarescore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503230115

Hi,

I noticed that a patch addressing the same issue has been proposed by
Michal Suchanek:
https://lore.kernel.org/linuxppc-dev/Z86liwlwP5WvrEkw@kitsune.suse.cz/T/#t

The existing patch addresses the compilation error by modifying the Makefile
to use `gnu11` with `BOOTTARGETFLAGS`. This is a practical approach to avoid
the error in the short term.

This patch builds on that work by providing a long-term solution that ensures
compatibility with C23 while maintaining backward compatibility. Specifically:
    - It uses `__STDC_VERSION__` to conditionally define the `bool` typedef only
    for pre-C23 standards.
    - It ensures that the code is future-proof and ready for upcoming C23 standards,
    where `bool`, `true`, and `false` are reserved keywords.
    - It avoids reliance on compiler-specific flags, making the code more portable
    and standards-compliant.

Changlog:
    - Adding version check via __STDC_VERSION__
    - If  __STDC_VERSION__ < C23, 'typedef int bool' is defined as usual
    - If __STDC_VERSION__ >= C23, the typedef redundancy is removed

The patch has been tested with:
    - gcc (GCC) 15.0.1 20250228 (Red Hat 15.0.1-0)
    - gcc (GCC) 14.2.1 20250110 (Red Hat 14.2.1-7)

Thanks,
Misbah Anjum N


Misbah Anjum N (1):
  arch/powerpc: Remove redundant typedef for bool

 arch/powerpc/boot/types.h | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.49.0


