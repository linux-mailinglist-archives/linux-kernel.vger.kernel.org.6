Return-Path: <linux-kernel+bounces-567276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E46A6840B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 05:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B0C7AC0CC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 03:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716F920DD66;
	Wed, 19 Mar 2025 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CewSuzC6"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728822AEE2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 04:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742356828; cv=none; b=iXn3anOzbmcBTtYFOgINX2ecOtKxuBFN6OM9bLEcXLCFFRmNlKUx2tOYqxC5/tSBxZYl3bO1AKzt/gbffjzT4p6AiUcxIJRR6nPSWtn5eLMIzZSXJQBzeKv8mNLHeHrmRVDaa3a+HghToRmeOwZU9pdwD9KqsMr0PSKqw+nYsGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742356828; c=relaxed/simple;
	bh=f2e35X4+/8lL2wJCYuQNeZw3YCJ4HS63Wmvsl/KPHWs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t+QpHCdm5BF8uyiOilsnJ+i5KGsyAZw5HP+aBBmKEerR//c4zKUtvJMZVt7lFpJ+ZW7lPF5ThkqjuL+jzqD/mOyaJCVWB2mV/HpWXOaR81iHLzY1jbC0Q10c1rbrAbZNQ0cuL+CZ/1Q2PF3DGFcorkZMMwBCHTGhGBwFct15vE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CewSuzC6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52IKcbZP008032;
	Wed, 19 Mar 2025 04:00:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=U9ggS/
	V2nO1Rhhkzcm5mSRFrtmA3+QyvnI2V2aIpsDk=; b=CewSuzC6OooHncAOQCq/fv
	tyOaUhBUnJ9adCFVAjPjvaB+1X1jonsr0LT7xAlqsymenitM5tIMSZ5tDm+UiIbR
	vTKCudU1KZ6tfnunbXpMFZTBIVGV60MsT8eN1xeFJ8l29TE3pnagIMjByU+FC19I
	HjJj1b7gB63yCCXP+zRwm5R4xo8jLCgev4+IjbUZ7q9taBVmVbvJtUeNkBSyI8Wp
	ro6tcogsNPUH/AEMKRWJgXPF2GKPq7McprOlX80cc82NKJcSNkb7zvIWM6BW2OB4
	8KlhRAfvXrTnXZiFjU3w2Ag9aSpeQIwD3cYEn4CLEAEjUd2O5OCTiXyMi29JLacA
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg1yhchk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 04:00:07 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52J3tbJf029481;
	Wed, 19 Mar 2025 04:00:07 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45fg1yhchf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 04:00:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52J3viBb032373;
	Wed, 19 Mar 2025 04:00:06 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45dkvtfs35-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 04:00:06 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52J405p750200926
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Mar 2025 04:00:05 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E767E20043;
	Wed, 19 Mar 2025 04:00:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 772AB20040;
	Wed, 19 Mar 2025 04:00:04 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.63.197.14])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Mar 2025 04:00:04 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.63.198.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id A0D6B6014F;
	Wed, 19 Mar 2025 15:00:00 +1100 (AEDT)
Message-ID: <324b4b5c6f1f0a777a217fdc05c8d01d4e0302ea.camel@linux.ibm.com>
Subject: Re: [PATCH 5/6] powerpc: powenv: oxcl: use lock guard for mutex
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: npiggin@gmail.com, christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
        peterz@infradead.org, fbarrat@linux.ibm.com, mahesh@linux.ibm.com,
        oohall@gmail.com, hbathini@linux.ibm.com, dhowells@redhat.com,
        haren@linux.ibm.com, linux-kernel@vger.kernel.org, maddy@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org
Date: Wed, 19 Mar 2025 14:59:38 +1100
In-Reply-To: <d6999d74-45f6-413a-8881-90473b322dfa@linux.ibm.com>
References: <20250314054544.1998928-1-sshegde@linux.ibm.com>
	 <20250314054544.1998928-6-sshegde@linux.ibm.com>
	 <d6999d74-45f6-413a-8881-90473b322dfa@linux.ibm.com>
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
X-Proofpoint-GUID: nCc6gFsqSOhvHBf2xFLZlI8uxRrcj7xA
X-Proofpoint-ORIG-GUID: ib4WQQqdA4LcZCIp9-Y4wC4XR44jQnBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-19_01,2025-03-17_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=507
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503190024

On Fri, 2025-03-14 at 15:00 +0530, Shrikanth Hegde wrote:
>=20
> Hi. Andrew,
>=20
> After this change below dev_dbg will be called with mutex held still.
> Is=20
> that a concern? I don't see the mutex being used in that path.
>=20
> Since using scoped_guard cause more code churn here, I would prefer
> not=20
> use it.

I think this is fine.

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

