Return-Path: <linux-kernel+bounces-563769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F638A647F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4563B29FD
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73126748D;
	Mon, 17 Mar 2025 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c0r/QLuv"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E60FC13D
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 09:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742204778; cv=none; b=V/L2nq9ylNEeixrfq5GJU9TAUBp3SB9kQzqjjNkD7FOxF0D0cWe2hZzQWtvwJNSHZGfoidJSCgb60wuZnr9ha36oVMhboRcXOTU82pHfYWTWltPrBu2vcUREc+zyaWrCHQzqRrKRdMTvQkbOMVQw1gQjk5jGFyvZ4+k+p0pv//M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742204778; c=relaxed/simple;
	bh=EPxA9EQ6VYpGidDDePvXdm3CBg9nRfEMDCHwnamJ+ug=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=k+rlo5AaIbVMdjjpu5U+45M8SAZV5OfjkmBPZpvfG+4Q06pugANbwkHeLSCZmxOHuP8SVG6yGEyYj8I5tfovWaGRkYLXJYwgqeTIRziYYiiJTHIRR2xhyBq3y7u5m67YVddx/T1jUt1+9TWTkOSaP1IXILIp1yyrzv4v4sWe4Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c0r/QLuv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52H8mi8r003235;
	Mon, 17 Mar 2025 09:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=a3Z920sjslTYtQWbVmfCMmUEmBhe
	PId9iuSjdY0LKVQ=; b=c0r/QLuvm6OAK48K0hOwnrOyrjxyHinC4s1zzFa74uzt
	dBB2N8URq112ioubkIkBzUlN8hOsc5ZjHR3WjdvsaIQ6cIzg4hC1+WJ2JENNjOHq
	o4ileiaQ1IYpMTctfjpgoPTtBmvoEGsJmMGPUEpvrG3DKl9aLIcrMik7932JDLnP
	yQc4dMga41maWnYYSybz1rtSqSbOfO18cKuJN0W4eZayhGv8ssRtVNJyIGmU0bZo
	vbhLCbcYTbuJgxgLVWtTsgmP/nxRmfrTmkAwVTBjMdExX6vwnKUKKcLWD6VUAM4r
	6EvPnf1KxpYeNA0AnWevFLvcyiVBIbjQfk7RZKMdWQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45e5v02h4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 09:46:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52H88lAN032356;
	Mon, 17 Mar 2025 09:46:05 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dkvt5p14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 09:46:05 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52H9k2Ys29295176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 09:46:03 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 350B45805D;
	Mon, 17 Mar 2025 09:46:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72C9C58057;
	Mon, 17 Mar 2025 09:46:02 +0000 (GMT)
Received: from [9.61.253.6] (unknown [9.61.253.6])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Mar 2025 09:46:02 +0000 (GMT)
Message-ID: <5f88a95b-1c8d-4a74-9753-9cdb2e64daf4@linux.ibm.com>
Date: Mon, 17 Mar 2025 15:16:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [main-line][PowerPC]selftests/powerpc/signal: sigfuz fails
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: yB8YfxfjreZhljaWCgqy_Ulnka7mvHf6
X-Proofpoint-GUID: yB8YfxfjreZhljaWCgqy_Ulnka7mvHf6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-17_03,2025-03-17_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503170069

Greetings!!

I am observing selftests/powerpc/signal:sigfuz test fails on linux 
mainline repo on IBM Power10 systems.

The test passes on the kernel with commit head: 
619f0b6fad524f08d493a98d55bac9ab8895e3a6 and fails on the kernel with 
commit head: ce69b4019001407f9cd738dd2ba217b3a8ab831b on the main line.


Repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

I tried to do git bisect and the bisect tool pointed first bad commit 
to: 16ebb6f5b6295c9688749862a39a4889c56227f8.

But upon reverting the first bad commit issue is still seen. So please 
ignore, if the bisection dosent help.


Error:

# selftests: powerpc/signal: sigfuz
# test: signal_fuzzer
# tags: git_version:v6.14-rc7-1-g49c747976afa
# !! killing signal_fuzzer
# !! child died by signal 15
# failure: signal_fuzzer
not ok 3 selftests: powerpc/signal: sigfuz # exit=1


Bisect log:

git bisect start
# status: waiting for both good and bad commits
# good: [619f0b6fad524f08d493a98d55bac9ab8895e3a6] Merge tag 
'seccomp-v6.13-rc8' of 
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux
git bisect good 619f0b6fad524f08d493a98d55bac9ab8895e3a6
# status: waiting for bad commit, 1 good commit known
# bad: [ce69b4019001407f9cd738dd2ba217b3a8ab831b] Merge tag 
'net-6.13-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
git bisect bad ce69b4019001407f9cd738dd2ba217b3a8ab831b
# good: [f62bb88782ffc2d8b619ac781ca26582b00c4db6] Merge branch '100GbE' 
of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue
git bisect good f62bb88782ffc2d8b619ac781ca26582b00c4db6
# bad: [2c3688090f8a1f085230aa839cc63e4a7b977df0] net/mlx5e: Fix 
inversion dependency warning while enabling IPsec tunnel
git bisect bad 2c3688090f8a1f085230aa839cc63e4a7b977df0
# bad: [d6e3316a1680305da291a5b5deaf424559aaf06c] net: pcs: xpcs: 
actively unset DW_VR_MII_DIG_CTRL1_2G5_EN for 1G SGMII
git bisect bad d6e3316a1680305da291a5b5deaf424559aaf06c
# bad: [f0d0277796db613c124206544b6dbe95b520ab6c] net: netpoll: ensure 
skb_pool list is always initialized
git bisect bad f0d0277796db613c124206544b6dbe95b520ab6c
# bad: [c17ff476f53afb30f90bb3c2af77de069c81a622] net: xilinx: axienet: 
Fix IRQ coalescing packet count overflow
git bisect bad c17ff476f53afb30f90bb3c2af77de069c81a622
# bad: [16ebb6f5b6295c9688749862a39a4889c56227f8] nfp: bpf: prevent 
integer overflow in nfp_bpf_event_output()
git bisect bad 16ebb6f5b6295c9688749862a39a4889c56227f8
# first bad commit: [16ebb6f5b6295c9688749862a39a4889c56227f8] nfp: bpf: 
prevent integer overflow in nfp_bpf_event_output()


If you happen to fix the issue, please add below tag.


Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>


Regards,

Venkat.


