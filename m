Return-Path: <linux-kernel+bounces-567277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8227A6840D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FD6519C19C6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 04:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2A11B4156;
	Wed, 19 Mar 2025 04:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hcqTaf+a"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D61621364
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742356856; cv=none; b=Rc29Dhuq8Mr2MKPRMcXw0khSFjQV1SOeHR+x2IvCcbfY5s5uTeWxAGk3phtI29aCWUsizZb36EHRzlK1ZMYN1HwO832LiTF11pSNnT4w5LzINu2O/uGvIyn13+zQGKRKi/qGH7qsoXyYBsbca9DUY23TNGu8UxLRLwpDlBvq8KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742356856; c=relaxed/simple;
	bh=6KUdji6LAWRLbl5mSvI3LLC1ki16mv+bJ5mSFswe6yI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TCJNF57TTVi7IRt9UTD9M9p7Nr39Hh4evPNUJsZsCbWh0QO9c3FSh5kiant3EKPDdafNpTZ1ijU8QfAlZZTP9wCZfbz9BrqRxrCtWxpkMvo43QhDoXjV03TdzXKYYB7crhLBEVfDG9sOQcmCDH1ymK9vXmJCdI6bSy6PUbS6cvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hcqTaf+a; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IKa7Hw014684;
	Wed, 19 Mar 2025 04:00:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=srljMD
	XR/b3PlOTBTheVB7qDBh1nRazbG4VMwqXj+wI=; b=hcqTaf+aWYkEAE3KOPr1X0
	05ZZWBXWDk3a94XU7mnyJcOnAPOSOcZ/7UkvzYsZA+dTOdMGyRUzGD75Yp1/cTPq
	IhgUqtERV5XYQk0PYIDnkhhrO38bImdOJEw+Rnayv3ypllbHUvCAWBrDavSS/ucO
	2vTr/hg75E90scjeD6SL2mS0QZx9zWtVstMMqmr7d2M7tF53BU6NU+MCO3IJL1JK
	akd3SW2Rah+24SN8G1XwAkhsG1EK/owOvaT/cHSeyk/6CQS3HzOkEd28sxb8kyuA
	/81XIg27hs+6t+isCApDvsDkAiByqs4uUlbrNNBFn25tQBC4lekWg0HmSIOEm8fQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg0psd0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 04:00:38 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52J3wu5J024274;
	Wed, 19 Mar 2025 04:00:38 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg0psd08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 04:00:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52J1oEvL024440;
	Wed, 19 Mar 2025 04:00:37 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45dncm7ewr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 04:00:37 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52J40ZK220119866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 04:00:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0B8620040;
	Wed, 19 Mar 2025 04:00:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E50120043;
	Wed, 19 Mar 2025 04:00:35 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.63.197.14])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 04:00:35 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.63.198.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A623C602D4;
	Wed, 19 Mar 2025 15:00:32 +1100 (AEDT)
Message-ID: <a1e92d89e9ec99a4b20b0f15bede1254b87b95b9.camel@linux.ibm.com>
Subject: Re: [PATCH v2 5/6] powerpc: powernv: ocxl: use lock guard for mutex
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
        peterz@infradead.org, fbarrat@linux.ibm.com, mahesh@linux.ibm.com,
        oohall@gmail.com, hbathini@linux.ibm.com, dhowells@redhat.com,
        haren@linux.ibm.com, linux-kernel@vger.kernel.org
Date: Wed, 19 Mar 2025 15:00:32 +1100
In-Reply-To: <20250314114502.2083434-6-sshegde@linux.ibm.com>
References: <20250314114502.2083434-1-sshegde@linux.ibm.com>
	 <20250314114502.2083434-6-sshegde@linux.ibm.com>
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
X-Proofpoint-GUID: R0N88cqJTSOAuCXgV-U1Tw4Mx2qc5_18
X-Proofpoint-ORIG-GUID: fdXd4xl0T6Ln_vzDPSiPLDnrnX94LhQ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_01,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=537 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190024

On Fri, 2025-03-14 at 17:15 +0530, Shrikanth Hegde wrote:
> use guard(mutex) for scope based resource management of mutex.
> This would make the code simpler and easier to maintain.
>=20
> More details on lock guards can be found at
> https://lore.kernel.org/all/20230612093537.614161713@infradead.org/T/#u
>=20
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Acked-by: Andrew Donnellan <ajd@linux.ibm.com>

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

