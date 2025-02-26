Return-Path: <linux-kernel+bounces-532995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D38FA454A4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C128172152
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D1D1632C8;
	Wed, 26 Feb 2025 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IDVkSo88"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333CC28EB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740545214; cv=none; b=c/5YHXjVW4dpoNHH7ok5zR1CdJ+WhZLgt69HebWyCdpeoPTP875RpFP837NpmHW+d9ywOl3Aao+/6ZOwj9mIHeGxohUsG3CBVBBd2OuqIRt6fyjN3NBhVYrZKZzRecwyCGGq+RNN3rShsjwGROPemDgmsFMsswMAcHXJWKSZzwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740545214; c=relaxed/simple;
	bh=9zOxQOnN8/s6dMCsns/hKkzY14q8g6u9j68sgWgMQPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjhCRcgQr/PlafW5XxGPabK6SSzeqI1mfQd6d2DCchz+gp7oFrmSYlpFZ33TsfM+hiliJ+VTQrtKM1tIne6ISO4YFvPt35zloYLaHymKNf7DhZSUNDjgHtih2YSBmMXCBstatdeoJSwIh9jUP/XhlPHecKtQaaU0+TImQhFGGPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IDVkSo88; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q1kt30027841;
	Wed, 26 Feb 2025 04:46:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2PQG47
	5yC/sNQ5D71AsWdf11Hg9Z+xdWTuGGN/tr9wI=; b=IDVkSo880mGUY86AnMCUGe
	2hHyxr/ng1aSzCZNoQDmupoKBX8Dx44I0TeAuJDXVKXdiYRmLiBpQTQHIzUWuDz8
	Mj5stGJAvCoMSUfBVKV6du8Uy4iAIN4r5P3wGfM/RE+N88cubTL2UM1D4OCETmRX
	lI5eR/1lktV1r5Q3kJJ5FVw5jbCVfEWP5w/8823lzgYOyHSF9ub18s8aLyQbWKJJ
	95sBGQRksyJNqc1Rfx7QtDhbfB3/pE67oS8vNy8zilT7cHE4+nn5VxU6ZrNfY16A
	ZUfDSpcIPuQi6LNR1DjIMBUJh8Ap9/r2Va85tql47OP1Y6LPsweggqgrAile0oJg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451q5j95ds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 04:46:28 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51Q4kSS5024583;
	Wed, 26 Feb 2025 04:46:28 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451q5j95dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 04:46:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q3FPW5012735;
	Wed, 26 Feb 2025 04:46:27 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwss1qv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 04:46:27 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51Q4kPMb47710678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 04:46:25 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D75720040;
	Wed, 26 Feb 2025 04:46:25 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3270220043;
	Wed, 26 Feb 2025 04:46:21 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.65.188])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 04:46:20 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Arvind Sankar <nivedita@alum.mit.edu>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] powerpc/32: Stop printing Kernel virtual memory layout
Date: Wed, 26 Feb 2025 10:16:17 +0530
Message-ID: <174054508252.1386382.4908751676238614813.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <430bc8c1f2ff2eb9224b04450e22db472b0b9fa9.1736361630.git.christophe.leroy@csgroup.eu>
References: <430bc8c1f2ff2eb9224b04450e22db472b0b9fa9.1736361630.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A3dTPOtgoGpxdu-3h4zf3qYjKQjPhVMr
X-Proofpoint-ORIG-GUID: 9ey-h9MHxJXGFQKVRL03BX0DuPwfAAoU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=667 phishscore=0 adultscore=0 clxscore=1011 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260033

On Wed, 08 Jan 2025 19:40:38 +0100, Christophe Leroy wrote:
> Printing of Kernel virtual memory layout was added for debug purpose
> by commit f637a49e507c ("powerpc: Minor cleanups of kernel virt
> address space definitions")
> 
> For security reasons, don't display the kernel's virtual memory layout.
> 
> Other architectures have removed it through following commits.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Stop printing Kernel virtual memory layout
      https://git.kernel.org/powerpc/c/2bf3caa7cc3b725eb671fb7e186daf685089eb86

Thanks

