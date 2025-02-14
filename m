Return-Path: <linux-kernel+bounces-514952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6979A35DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58B82188F67F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399042627E5;
	Fri, 14 Feb 2025 12:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NCWH8kTn"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC862753E0
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739537603; cv=none; b=QjCTCo8mIZowMzyvj9VvfpmEs73vfDMyYcKdjrCnEQEAJUmT21Qu1JIAX1EF48Mp4vwM307cn4iSOj1IWBcI74F3iwhu3ivSOVE5m42tQP3TnZtnivfQZFfYLRgaEpJKIscP2+kn38UNS7I6aHBq9ZngRzYFC5/fO/Xopx5IeQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739537603; c=relaxed/simple;
	bh=JERis6g+OBD1u0PmG+9ME19wmhp945SmdpqP/r9mt1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pEidJ7qgpnmDW/V/dZjKs38cjETvmv5KbVykTJBFHDEQGQ5+nlQEW29EjIerY8UzJZWly6z5SA2OtL6Ykw8Y17sJnWjMR23U9/s455klohQCpGquKY8dthHuUskLwRT4FDnd2TwI/OKTaWIxgMQqfaP6sarGzuM+GrqR4NeWC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NCWH8kTn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E44kBt015865;
	Fri, 14 Feb 2025 12:53:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=084FZH
	rJeWZnAe524O6+JJ7QWpLJ2qj+2DyhrLodlxg=; b=NCWH8kTnSnWqA07OgpLz/H
	1RsuqI4LCHPvvvbz/s/Tlc4MWJSsMozp2vIkdn1JSAfp8f/hVS5hMztM2cJ5sH5j
	yDgnddPJkVgVNXFzGZFM2PXWZU6tJ0hiJBShvWbPxLX3mNfm9ie8RaRDPmZ844/p
	+dtE6mN4yRu3PwicmVISXO41mb+CcbqGDy7GoEbc9avAkjhdEAmMBXh8bsuJPXbk
	c48G0Mzd4DfcoKRsAAfXpuN9oVMZwHhBoS61j+EbNHNbYEi3gbImR3qyUEuEWo2K
	gh3JFsWm5fFBr+IoB1+Wcw61Aw7+sqFCFTnORm9c47FIS4ypuOchH3HZcQSc/vBg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44skjuwb2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:53:05 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51ECmNuV027128;
	Fri, 14 Feb 2025 12:53:05 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44skjuwb2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:53:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51EB0uJm000978;
	Fri, 14 Feb 2025 12:53:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjknkkxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:53:04 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ECr2B445613420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 12:53:02 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0F1B2004B;
	Fri, 14 Feb 2025 12:53:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8076E20040;
	Fri, 14 Feb 2025 12:52:58 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.125.185])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Feb 2025 12:52:58 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] powerpc/64s: Rewrite __real_pte() and __rpte_to_hidx() as static inline
Date: Fri, 14 Feb 2025 18:22:56 +0530
Message-ID: <173953661683.199877.12879518225554351869.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <e0d340a5b7bd478ecbf245d826e6ab2778b74e06.1736706263.git.christophe.leroy@csgroup.eu>
References: <e0d340a5b7bd478ecbf245d826e6ab2778b74e06.1736706263.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iL5sVaNme84d1rbWYUcduWt_5cc8FnZX
X-Proofpoint-ORIG-GUID: 4CRNCKnYFycAgIasgkQnY_ijxHom_Agv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxlogscore=563 lowpriorityscore=0 mlxscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502140092

On Sun, 12 Jan 2025 19:24:46 +0100, Christophe Leroy wrote:
> Rewrite __real_pte() and __rpte_to_hidx() as static inline in order to
> avoid following warnings/errors when building with 4k page size:
> 
> 	  CC      arch/powerpc/mm/book3s64/hash_tlb.o
> 	arch/powerpc/mm/book3s64/hash_tlb.c: In function 'hpte_need_flush':
> 	arch/powerpc/mm/book3s64/hash_tlb.c:49:16: error: variable 'offset' set but not used [-Werror=unused-but-set-variable]
> 	   49 |         int i, offset;
> 	      |                ^~~~~~
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/64s: Rewrite __real_pte() and __rpte_to_hidx() as static inline
      https://git.kernel.org/powerpc/c/61bcc752d1b81fde3cae454ff20c1d3c359df500

Thanks

