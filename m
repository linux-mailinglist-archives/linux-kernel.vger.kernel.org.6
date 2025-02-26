Return-Path: <linux-kernel+bounces-533000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D463FA454AC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A43E189487E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5602253E9;
	Wed, 26 Feb 2025 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FYNkmJoJ"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA57204F9B
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740545233; cv=none; b=CI6xFEkgjaRghaHbwDGmRlwMF3CuicdakktwPpHoYMR+J81WHgzvgc2tUvvM2U30P5iur6yEHi4T7yZ3i9xianf0JQvG9TD9LTgA3bib0vXehksU8/ugnYZ+DbvYoOoYLWg2L2AYZfNZD3Dy0y7URax5helf9iOZD4wEQCAoBbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740545233; c=relaxed/simple;
	bh=NvsS+j0xfeWtv+MhpdI2UR2te1rZc8FYODIxpvOA3b8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XNfbkGDiZ8Saiamcs1d8FcCzL+6a0adpId1oGklgA2oOl+evGwDlZION5YhnP0EedU+wlGmDXeml4iLa5yd3e6ebPzYMRlIfREMjFpqYZ9bOBmlSVSorKr9WCBi8rRvlTuq2zikTcqT2JuOffClfWo/NpFJCzOgcnrxn2MqnUvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FYNkmJoJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q1kxD8012268;
	Wed, 26 Feb 2025 04:47:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wPFcge
	7BmJqcQZTf9xO13j7qyDoL2Cb3Ljh6aPOkv6k=; b=FYNkmJoJZ07RavuUcrx04k
	wfrcKelogoipabBbQrUtja5M2Zk0hfSn2eDRgQQ2QnIYBEQnT7/QcsPTGB9+kO6o
	jKcZBPYKl7Wu9sA9+r55HcV/Mebab/Re7oti55f8qdFrW9D2RCsy651pwHKjwcGj
	ahMqLr28ip8Q31phAhfy+9bK6QIX6l3b2bIMtHNDlFGJdvd7AbqrgaP83TEqkWcJ
	fz/n36oM3Xw493gilwaMFC4ZXXteoFkIhFmpXBRScoifva3tGEoHW3nDFuT3R+fX
	S9xpfFJVkNMRiqBBRbeEh47Wrpr37KtYNN9eDVoANO0hpxOHfc2YbZRY41UHzzdA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451s198qsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 04:47:00 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51Q4iWAq000711;
	Wed, 26 Feb 2025 04:47:00 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 451s198qsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 04:47:00 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q2LQwp027372;
	Wed, 26 Feb 2025 04:46:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum20d0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Feb 2025 04:46:59 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51Q4kvEO30605778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Feb 2025 04:46:57 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EAFE2004D;
	Wed, 26 Feb 2025 04:46:57 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B80820040;
	Wed, 26 Feb 2025 04:46:53 +0000 (GMT)
Received: from li-c439904c-24ed-11b2-a85c-b284a6847472.ibm.com.com (unknown [9.43.65.188])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Feb 2025 04:46:53 +0000 (GMT)
From: Madhavan Srinivasan <maddy@linux.ibm.com>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        naveen@kernel.org, Gautam Menghani <gautam@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arch/powerpc: Remove unused function icp_native_cause_ipi_rm()
Date: Wed, 26 Feb 2025 10:16:51 +0530
Message-ID: <174054508253.1386382.13670617186309588402.b4-ty@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250101134251.436679-1-gautam@linux.ibm.com>
References: <20250101134251.436679-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: A992Do0naUMn0S2L8IEPJbmpPsvQZMDx
X-Proofpoint-ORIG-GUID: MxAFWEvv6GWAgqCCVLu1uT0w6hF9NLJM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_08,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=479 mlxscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502260033

On Wed, 01 Jan 2025 19:12:49 +0530, Gautam Menghani wrote:
> Remove icp_native_cause_ipi_rm() as it has no callers since
> commit 53af3ba2e819("KVM: PPC: Book3S HV: Allow guest exit path to have
> MMU on")
> 
> 

Applied to powerpc/next.

[1/1] arch/powerpc: Remove unused function icp_native_cause_ipi_rm()
      https://git.kernel.org/powerpc/c/65acbd1285f7fe8c8b82cb90e4db923db5b9fe03

Thanks

