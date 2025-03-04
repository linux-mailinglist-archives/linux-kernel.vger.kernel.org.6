Return-Path: <linux-kernel+bounces-543264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F932A4D395
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 07:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 184A57A3F9C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 06:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAA01F4E37;
	Tue,  4 Mar 2025 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gX6nNpzk"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F416C1F473C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 06:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068849; cv=none; b=LDoPhHPstuusOb90TyqdVx9DeA6rMV6Ciy+3vPob0iNoul/BGCM9ckMXQ5IjqGXpLzy9e0+Bx8vP1Jm5K3IXi97fHA09PzVkky1yxfb+Et7aJhxcMN1u5ybPihQ7c/Z/Cbn2BurHG+CEjnzfEeyBY69mR6bFyfIU7OuqJctkOfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068849; c=relaxed/simple;
	bh=im/716aKdF1FfmPuAkp4HiYlnjxxN1BasODt1lHp0e8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X4kReIQCpnpV/+ooYn4dk6Kt7GsZUUUt5aJ0Rg8UJTMR5EGeHwVP4w0j3wfx8JUhgkUqXwmgKRoc9kk2yE5KP0mVV8+obPPWe2DRYKUQf9r2ktHJEhDma6Sm1LII2M294cwz3VVGHGcalzUkabB9JMePTiEPD+GG9ASjyJzoLCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gX6nNpzk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523KdhZi019982;
	Tue, 4 Mar 2025 06:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a5BV+S
	xL8+Es1imNgFblJNa3ir2+3xn4jrC/hhK3tVY=; b=gX6nNpzkqudh7X+mT7ypfv
	dSx2em3igMxsOC2Mr9DEo2PCVvyb2k9wExRfcKAjGtQ6M3rus2NSik6zGndFkdJo
	S4OQTObJoytSkkW2MvlJnzUF08b5ebp+EINBwt/Z2z7B0uUHS4YC4KOn3UQUl3GT
	udrz2Q6KZNBFUYE1n//eZ/OC8bZ/ZvL9EuZTmw50Dj+kdHuwtW290F4DTIlrj9cm
	AVhpisERwihU9xsfVKlcFIdxdqhBmfwCke3TO9W3OHmd99v7IuOIncgDZoC6EGMS
	qKAZNtq0B2wOJT2LXCTicRdH/7wYE1AfHA9tvOGaFVIANbOYYnOIXk4z4zxeIwpg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 455kmyj2cr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 06:13:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5242uaGH032680;
	Tue, 4 Mar 2025 06:13:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 454cjsv5t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Mar 2025 06:13:50 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5246DoKL25363126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Mar 2025 06:13:50 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 585AE58059;
	Tue,  4 Mar 2025 06:13:50 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D499758055;
	Tue,  4 Mar 2025 06:13:46 +0000 (GMT)
Received: from [9.43.105.169] (unknown [9.43.105.169])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Mar 2025 06:13:46 +0000 (GMT)
Message-ID: <47aa8b75-96b6-4e37-bb62-ad758b414076@linux.ibm.com>
Date: Tue, 4 Mar 2025 11:43:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Build Warnings at arch/powerpc/
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Michael Ellerman <mpe@ellerman.id.au>
References: <8c4c3fc2-2bd7-4148-af68-2f504d6119e0@linux.ibm.com>
Content-Language: en-US
From: Madhavan Srinivasan <maddy@linux.ibm.com>
In-Reply-To: <8c4c3fc2-2bd7-4148-af68-2f504d6119e0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NEfGyNMC3dJmZxbfR_uXgeNFAFsu3hBe
X-Proofpoint-GUID: NEfGyNMC3dJmZxbfR_uXgeNFAFsu3hBe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_03,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=913
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 malwarescore=0 clxscore=1015 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503040049



On 3/4/25 10:42 AM, Venkat Rao Bagalkote wrote:
> Greetings!!
> 
> 
> Observing build warnings with linux-next and powerpc repo's. Issue is currently not seen on mainline yet.
> 
> PPC Repo: https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git merge branch
> 
> PPC Kernel Version: 6.14.0-rc4-g1304f486dbf1
> next Repo: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master branch
> 
> next Kernel Version: 6.14.0-rc5-next-20250303
> 
> 
> On linux-next kernel issue got introduced b/w next-20250227 and next-20250303
> 
> 
> Build Warnings:
> 
> arch/powerpc/kvm/book3s_hv_rmhandlers.o: warning: objtool: .text+0xe84: intra_function_call not a direct call
> arch/powerpc/crypto/ghashp8-ppc.o: warning: objtool: .text+0x22c: unannotated intra-function call
> arch/powerpc/kernel/switch.o: warning: objtool: .text+0x4: intra_function_call not a direct call
> 
> 

Can you please specific the compiler and compiler version you found this issue with

maddy

> If you fix this issue, please add below tag.
> 
> 
> Reported-By: Venkat Rao Bagalkote <venkat88@linux.vnet.ibm.com>
> 
> 
> Regards,
> 
> Venkat.
> 


