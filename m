Return-Path: <linux-kernel+bounces-560664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4470AA607E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8310A460B79
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B4614A4FF;
	Fri, 14 Mar 2025 03:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jyrJ8goX"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37844146A7A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741924037; cv=none; b=Gyqd6ht7RPuUHONWj+ROyZ5f6OZYDpyRoXXCPOntqb1IOYss/DcrxWoKuVimUTn5JAbg4hQaaC5OGBnhFzfpG3doq9XuCYHGJmI7rzVs2oP0Mi5jBh+OhdhAGYY3PkRoXNm4SVT20CbRI1S0tRaIsxzvFyWyK+QrqJ5Eml5Zpds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741924037; c=relaxed/simple;
	bh=rhgYIIst+qqh3p3PM3wlmh+Bs0KycnR9Fqr6cCFFTvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hc57Gv3fFCepW88Z/f+so8z0WBJv8ch8ct5kT7PRFLpG5b9dM3DHp6++cQDlPZaTq+vco2PbA8CoCO0ngta9+LFqnr41G9+JlyrG1sg3eoGOEWSlR65tJw54Kofb2PXE/9wHiI6gTt5rlIQhVdfoBb4hih/7hLGgAs+KapQOwpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jyrJ8goX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNPK1W007584;
	Fri, 14 Mar 2025 03:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rbqld6
	9R34rgENIWGoUFrOQVwaLRsNaSOgh6SwTMhD8=; b=jyrJ8goXBp4h4+9cA91g6u
	JXTTTc8HXPUM9kllvGpB2zhAbcE29cJL6UrWTibkEtJn8uo3cDo7/yuTibZxnAVq
	O0GtYH7zMGcVn0auRCEBkQ2MuR8ScfmVEbU7hJB0Z1tev/K89C2mfPE6pI+ah8kM
	WrTMbfeBIVwTm/y3+lnsESG2SU6lNtXKzMbRytdFPa4SUqP2C8VOHk+HmMUPUWoN
	nyB85DSXcQ2PAuK9Dsd0WErOXVxkwTQb6eWLQTucif00mlDgxbVGpAuvZlK6lzMQ
	b4nab/6ER84D+BPjh8C3fCzUROUWHjBVqn0Gh7FTDQ/nTysDNlXP4U79xzPiLqBg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6s59ak5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 03:47:02 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E3jhBV025695;
	Fri, 14 Mar 2025 03:47:02 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45c6s59ak4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 03:47:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E01DHN027072;
	Fri, 14 Mar 2025 03:47:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsr51mk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 03:47:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E3kxwI34865796
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 03:46:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DB172004B;
	Fri, 14 Mar 2025 03:46:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9A8120043;
	Fri, 14 Mar 2025 03:46:57 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.in.ibm.com (unknown [9.204.206.207])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 03:46:57 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/kexec: fix physical address calculation in clear_utlb_entry()
Date: Fri, 14 Mar 2025 09:16:56 +0530
Message-ID: <174192385438.14370.6065221233235431919.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <dc4f9616fba9c05c5dbf9b4b5480eb1c362adc17.1741256651.git.christophe.leroy@csgroup.eu>
References: <dc4f9616fba9c05c5dbf9b4b5480eb1c362adc17.1741256651.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: chj51oLoDwGWiyO2fapE5MVDQSAK-Zby
X-Proofpoint-ORIG-GUID: QWZwaoJnNhxJM0EPcnXZLKAhgYMgabFH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_01,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502280000 definitions=main-2503140026

On Thu, 06 Mar 2025 11:24:28 +0100, Christophe Leroy wrote:
> In relocate_32.S, function clear_utlb_entry() goes into real mode. To
> do so, it has to calculate the physical address based on the virtual
> address. To get the virtual address it uses 'bl' which is problematic
> (see commit c974809a26a1 ("powerpc/vdso: Avoid link stack corruption
> in __get_datapage()")). In addition, the calculation is done on a
> wrong address because 'bl' loads LR with the address of the following
> instruction, not the address of the target. So when the target is not
> the instruction following the 'bl' instruction, it may lead to
> unexpected behaviour.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/kexec: fix physical address calculation in clear_utlb_entry()
      https://git.kernel.org/powerpc/c/861efb8a48ee8b73ae4e8817509cd4e82fd52bc4

Thanks

