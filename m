Return-Path: <linux-kernel+bounces-545276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6F4A4EAE7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 19:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E11E17AB905
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240132780E6;
	Tue,  4 Mar 2025 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X4TelxK1"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1685D238D25
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741110957; cv=none; b=BoJwAPbvb0WC4C2xo9+gcbAuS60kRCLaO4/gDYlvihqZHkmX+fLuU5RIw/JbrJ9wk2dPo+snggX+XZr3RagYglfEgEq4vFd+2vQNxawjsm/9muV/pFblHYGKv0x8IymOD5uR3KAtMJ8VzJXYSt2ih9j67TMA8f5+7IowxgvMb9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741110957; c=relaxed/simple;
	bh=AOnNXA8ucEBIu6uITWsiuzd6ARHJGlRmk7W+ByQxQCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppqEOilkR+aCqjCTqyTCOCDwMFFmnfdz9NozwTIs000GoWbJheK4mEsJTkFB04Wl228JjHdt5Tf3hqmimFADqzZrgWML2YniyWteuf7g2IJ0U7q0+hl4bj/iJLwrhLBTtkHRvtxkhcuzzqJ3sV+KTq6Yxtj5zhBuc+BCQ32PwDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X4TelxK1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 524Gh2be018373;
	Tue, 4 Mar 2025 17:55:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=DqUjTyJUEYEwu4jIKmOMGRlsDWYMnR
	w3Bsn5bQVwaMA=; b=X4TelxK1wJZHM3pB+BTopZD5LxfcmInDCOHHeVr9LKyGqW
	vvI1PJJC5gQTKKfjcDaCtZZsVsh29c4H+ix9jinYEaDMsSg7aL5gozu0hJ/HCPdq
	yRuRCNWOuovsafeMPSe0Uta6MSu2vUFQ7T4gXNCleK4nCVQS+Eb/3kGq1samd0vV
	lsoScWX10oxk7PF7Rs0lZyMymnC5cE2giFixBUb26uOqwMRn7e6iaQuLMVUEbkXB
	u9pWAruj0d+9mtTGfIDXWQzbTkyXu2pSLoXP3Wcc+6LuN01aBvCfuxBqG3NtpN3f
	NTKPV4U8EcyR/3k4FhRlrYDcTXch0FL/oalJqU7Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kmynda0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:55:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 524F4MAL008929;
	Tue, 4 Mar 2025 17:55:49 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 454cxyetfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 17:55:49 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 524HtjmF35521024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 17:55:45 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E12520043;
	Tue,  4 Mar 2025 17:55:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CF2720040;
	Tue,  4 Mar 2025 17:55:45 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  4 Mar 2025 17:55:45 +0000 (GMT)
Date: Tue, 4 Mar 2025 18:55:43 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Kieran Bingham <kbingham@kernel.org>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>
Subject: Re: [PATCH] scripts/gdb/symbols: Determine KASLR offset on s390
Message-ID: <Z8c+n43UWxHSn+LE@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250303110437.79070-1-iii@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303110437.79070-1-iii@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Pgu4fgSixzvhFwSjSkHzvGXGKx0u0hRK
X-Proofpoint-GUID: Pgu4fgSixzvhFwSjSkHzvGXGKx0u0hRK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_07,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=634
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1011 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040140

On Mon, Mar 03, 2025 at 12:03:58PM +0100, Ilya Leoshkevich wrote:
> Use QEMU's qemu.PhyMemMode [1] functionality to read vmcore from the
> physical memory the same way the existing dump tooling does this.
> Gracefully handle non-QEMU targets, early boot, and memory corruptions;
> print a warning if such situation is detected.
> 
> [1] https://qemu-project.gitlab.io/qemu/system/gdb.html#examining-physical-memory
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  scripts/gdb/linux/symbols.py | 31 ++++++++++++++++++++++++++++++-
>  scripts/gdb/linux/utils.py   | 35 +++++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+), 1 deletion(-)

Can not tell for the gdb part, but for the s390 bits:

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

