Return-Path: <linux-kernel+bounces-444217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D789C9F02FF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37CD165ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32E382866;
	Fri, 13 Dec 2024 03:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cddgnLm+"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763017F9
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060060; cv=none; b=i4nL3Hkk/AHHU+vM4BNOdbV+l/I6A6UlpWKIaOgFqGKWLFgyjv3s4xAzjqFxfCRFs1/y0VRceLDXgWy75AS6DNUGgRLn46vFKrhPF4iJnabQjqpYnywvKd9sEdf8ipKIWS4hj27Thoo/TjzUedQksVS8idQl2XfsUzQYsIAkeMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060060; c=relaxed/simple;
	bh=a54M8yTDArpJr+iY6Iz/lG+dGBkgZwSzZho//Rp98mw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKzwiQnClPJB6JVOViRddPsqbDnkEFWbiJO7RGb92IMvc81d4BzHW2ynUoakGiX+0v6k0dhdK61QzR4h1fcRMt1GAGzR2Ok1FlwyvWU0IpFu+M09HbEV9F+pMMldlCFx+tW97DdcuL8KT+x1sgsjdtb834VyIzzLIrGqRrDpQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cddgnLm+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCNbqv7003761;
	Fri, 13 Dec 2024 03:20:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9+fIzC
	va4GQg1OSuZlC45mBKaO6MZwL8QJAA6yGsi20=; b=cddgnLm+x0+E544b0pObyu
	8FrNIMfZtkUrya86+s2rQjwRPJCo7j4wU8af64xl2EUmMSJKsrSlcJlBbf98ofpO
	hxYAlZVDzonGDFohUbiW4lJd+3xADGK2zUmuQDW07xcSperkUlNPFn0NdKkEw+CU
	+J0rWjMOSA3nTf6R3hCiu84aOJNA7oEyXz87y3mn2tCf2QcWngZgTgeCBwIXHZ5f
	30k9CCL6La5yULCm8pqNVAOB1a7bFB9E9SXN5lIIwJMWW7cDG2K5sMW2MCFJRErO
	sDfdLGOVQj8LiSnEGKq7Tyg/hkdovP45tUt2XNQ3cJxyL6sIyrsMfxkSkZhq8ALQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xxm7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 03:20:40 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BD3JZCM020320;
	Fri, 13 Dec 2024 03:20:40 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xxm7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 03:20:40 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BCNeuTT016911;
	Fri, 13 Dec 2024 03:20:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d12ym1ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 03:20:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BD3KbBg34800168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 03:20:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C35A20043;
	Fri, 13 Dec 2024 03:20:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 014EA20040;
	Fri, 13 Dec 2024 03:20:36 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.in.ibm.com (unknown [9.204.206.207])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 03:20:35 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Naveen N Rao <naveen@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32: Replace mulhdu() by mul_u64_u64_shr()
Date: Fri, 13 Dec 2024 08:50:35 +0530
Message-ID: <173405995386.325393.4617269983686036811.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <f29e473c193c87bdbd36b209dfdee99d2f0c60dc.1733566130.git.christophe.leroy@csgroup.eu>
References: <f29e473c193c87bdbd36b209dfdee99d2f0c60dc.1733566130.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: xQ1LfHSI39Yldf1BlT4AdPtFZ1Au5TgC
X-Proofpoint-ORIG-GUID: pcrq6ffKa0ToSslYcjSmOyXyhLTqB_wW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=788
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130022

On Sat, 07 Dec 2024 11:09:27 +0100, Christophe Leroy wrote:
> Using mul_u64_u64_shr() provides similar calculation as mulhdu()
> assembly function, but enables inlining by the compiler.
> 
> The home-made assembly function had special handling for when one of
> the arguments is not a fully populated u64 but time functions use it
> to multiply timebase by a calculated scale which is constructed to
> have most significant bit set.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/32: Replace mulhdu() by mul_u64_u64_shr()
      https://git.kernel.org/powerpc/c/2a17a5bebc9aa7f59e99676350866adc41577c03

Thanks

