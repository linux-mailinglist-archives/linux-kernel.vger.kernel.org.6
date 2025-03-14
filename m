Return-Path: <linux-kernel+bounces-560728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A455A608C5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BFE3B6A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 06:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB6A13B58D;
	Fri, 14 Mar 2025 06:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sHvkkvJp"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4400A2F3B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 06:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741932422; cv=none; b=H+IG7AvLAy4WxaTkryLC/lxDiK3Stew0cjQ4Esf2l9ulZcgBy8FpgTDSdzxaY4Ios3EAPVg1CAQgG0DnCXAgIJ6q7VLrI8p39TseXEphf3kc+mqvZvE/1RsM/QrRLgUoRVCTN1i9LPQxnADAS0XgDLbniXBrMZ9WnfRkMKnf7aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741932422; c=relaxed/simple;
	bh=vqsNJIRyi1hYy0+zPcGN3PSJXtpKRFvdyHHCC0qTiSw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D3Ji1ziKBZNMfoNfdohrRWY/VaTQmubQMi6Kh5GkjMxrxXiBEDnltX2jCnQpUH3Rv2QMPA0/13Es+j5Son7ivV+YX8buhzzyQoz1CuOeWwykVG/zypBRjgra3N/WlVRS70WT8eprlxfJ7D/7eP43g8YCvwUn9wYJCCzJ4VywS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sHvkkvJp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52DNPvMS032088;
	Fri, 14 Mar 2025 06:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3TAfxR
	0+JNQ+AK6DJa4DTZDj6WBkKdLqZCDSRsJoqBs=; b=sHvkkvJp6uTe/srVh5O6SU
	AritX+k4Zr8ANKQwnkKxmyc+7iMZiPQ7PuOH0zFWys/pI5OnCU2eCA9YnO+NGtEO
	VKx5WBaslwJejMuCkK4zM2ggeJ+6YBH8aTV5v+o5K+CR7bFUwnUMeFEMTZwP8sat
	7gEiuJXpvyyaUMw03p7U4I6Sj9St5wixrdlCkBXJlShGaCuFur3j/RqpH7+Izous
	qhsVAl/d4tpyPEiakrBCaA8LWXOL9ToB1xRtjlmm0BcfTZp1SY9YzQ86ok/eLU7E
	RZg3OtohKA6nu0FwH2ArAsfqfTxsfW8PMQLUDF30lFpw2JBCJSKa+94T+2RSE8nw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45byd8vj3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 06:06:42 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52E5vYGC021391;
	Fri, 14 Mar 2025 06:06:41 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45byd8vj3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 06:06:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52E4sd3Y007412;
	Fri, 14 Mar 2025 06:06:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45atsrdfxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 06:06:40 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52E66cTv30540176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Mar 2025 06:06:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7837620043;
	Fri, 14 Mar 2025 06:06:38 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0BE3420040;
	Fri, 14 Mar 2025 06:06:38 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.63.197.14])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Mar 2025 06:06:38 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (unknown [9.150.9.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id D58496015C;
	Fri, 14 Mar 2025 17:06:29 +1100 (AEDT)
Message-ID: <af15fbf507dee3d96249bdfbb1a7419a26985f9b.camel@linux.ibm.com>
Subject: Re: [PATCH 5/6] powerpc: powenv: oxcl: use lock guard for mutex
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
        peterz@infradead.org, fbarrat@linux.ibm.com, mahesh@linux.ibm.com,
        oohall@gmail.com, hbathini@linux.ibm.com, dhowells@redhat.com,
        haren@linux.ibm.com, linux-kernel@vger.kernel.org
Date: Fri, 14 Mar 2025 17:06:27 +1100
In-Reply-To: <20250314054544.1998928-6-sshegde@linux.ibm.com>
References: <20250314054544.1998928-1-sshegde@linux.ibm.com>
	 <20250314054544.1998928-6-sshegde@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IdXWrtzs-qGyOw1hSOlmMCTkWa62cKbu
X-Proofpoint-ORIG-GUID: bwtSkGtVfUUsI5TEb4fLIDr8VP5plEF2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_02,2025-03-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=417 clxscore=1011 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503140045

On Fri, 2025-03-14 at 11:15 +0530, Shrikanth Hegde wrote:
> use guard(mutex) for scope based resource management of mutex.
> This would make the code simpler and easier to maintain.
>=20
> More details on lock guards can be found at
> https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u
>=20
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

The subject line of this patch misspells powernv and ocxl.

Otherwise this looks like a nice cleanup.

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

