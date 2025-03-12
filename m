Return-Path: <linux-kernel+bounces-557209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A92A5D513
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 05:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A03E3B5FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 04:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194041DA60D;
	Wed, 12 Mar 2025 04:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ctjBo8qI"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27F04431;
	Wed, 12 Mar 2025 04:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741753235; cv=none; b=qDKvBoUQO1siRqRX+xu3txZzIGh69o7TpIJ1Z+CJD2V3+gBWDvE78XH6K2dZZ2XUl7mmY5A2iN2a1zMen1M1bS+mP2oLBFG13PPguXBpFMCtFrqet5+vUs6OMnyfxxX8iOiWUbnDS6YGR0zK1RleFc2/91xekdIJV567fKVJG7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741753235; c=relaxed/simple;
	bh=vXJC59A5KyLVcHzQd6Ze1mTK7fofcWWsEhB/ULpeSUk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hAg6kzknUR2iodTLmwHveYm7C+yF5QeMG3XvmMyGH0saLVwuWhn4G8mP9TdiJyV39h7Y89VbHp19j2uxvB3HwCae9ZaxbPjaAeMyEkZjc7m/z0ShwSpOliMordsTEg443L9X5/F2FXlbYr9CCYEXhaIWJaOQt4FopRA7Ja/clBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ctjBo8qI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BJRJDG004298;
	Wed, 12 Mar 2025 04:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Tqm7wT
	MJ8wTQoziX97vyOXpNEjx2PuQggw3Nur93oXk=; b=ctjBo8qIKVBsqkGwVrucLN
	HO2XNiwye2pwQeGlWVX7xUwaP0b1obfnKBxuUCJGa9hB1e/sEmbQJCIaVgG/9YHb
	t7T3ja8xYZZnMxFeGSoNAC5HzX53wM0lVhVnXEXrC67nD/cxdpCoV2nJ0hahD3w2
	QOiNoUCs0aW/eF7AkxyU7YVNAVONKttjEZlKNp9qca+TFDCShdhmXdqjHGw/GrOa
	uptL40FVc34Vrr0nsyY9vCb9hvLZU7ZzNjYkG4AilzlIDWKvyQsxaLTdRMBYsGBG
	MnN3YE74jLIeL41aLRKeBKyQ3FMotlCPo2QUQwbS3DZw2PlSARi3PA4bo4uIcOXA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45aubn9yv8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 04:20:28 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52C2TROp015411;
	Wed, 12 Mar 2025 04:20:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspa6m0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Mar 2025 04:20:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52C4KQKr52101520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 04:20:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46E4A20043;
	Wed, 12 Mar 2025 04:20:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C02BA20040;
	Wed, 12 Mar 2025 04:20:25 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.63.197.14])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Mar 2025 04:20:25 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (unknown [9.36.8.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 647686043A;
	Wed, 12 Mar 2025 15:20:19 +1100 (AEDT)
Message-ID: <b3df5e8178107b2a133126e1daf111d10f1b0333.camel@linux.ibm.com>
Subject: Re: [PATCH] Documentation: ocxl.rst: Update consortium site
From: Andrew Donnellan <ajd@linux.ibm.com>
To: Fritz Koenig <frkoenig@chromium.org>,
        Frederic Barrat
	 <fbarrat@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Wed, 12 Mar 2025 15:20:06 +1100
In-Reply-To: <20250311-dead_site-v1-1-7ab3cea374f2@chromium.org>
References: <20250311-dead_site-v1-1-7ab3cea374f2@chromium.org>
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
X-Proofpoint-GUID: h3lHmcRVV7jbUEFjBcq77Y0U5n6sdwu-
X-Proofpoint-ORIG-GUID: h3lHmcRVV7jbUEFjBcq77Y0U5n6sdwu-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503120025

On Tue, 2025-03-11 at 11:24 -0700, Fritz Koenig wrote:
> Old site no longer associated with consortium.

Thanks for catching this!

>=20
> Signed-off-by: Fritz Koenig <frkoenig@chromium.org>
> ---
> After mergers the OpenCAPI Consortium does not seem to exist.
> The github page is the only seemingly relevant site, but it
> has not been updated in 4 years.
> ---
> =C2=A0Documentation/userspace-api/accelerators/ocxl.rst | 4 ++--
> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/userspace-api/accelerators/ocxl.rst
> b/Documentation/userspace-api/accelerators/ocxl.rst
> index db7570d5e50d..5fc86ead39f4 100644
> --- a/Documentation/userspace-api/accelerators/ocxl.rst
> +++ b/Documentation/userspace-api/accelerators/ocxl.rst
> @@ -3,8 +3,8 @@ OpenCAPI (Open Coherent Accelerator Processor
> Interface)
> =C2=A0=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0
> =C2=A0OpenCAPI is an interface between processors and accelerators. It
> aims
> -at being low-latency and high-bandwidth. The specification is
> -developed by the `OpenCAPI Consortium <http://opencapi.org/>`_.
> +at being low-latency and high-bandwidth. The specification is
> developed
> +by the `OpenCAPI Consortium
> <https://opencapi.github.io/oc-accel-doc/>`_.

This link is to the OC-Accel framework documentation, which isn't the
core set of OpenCAPI specifications. Those specs are now hosted by CXL,
post-merger.

I think I'd update this to say:

The specification was developed by the OpenCAPI Consortium, and is now
available from the `Compute Express Link Consortium
<https://computeexpresslink.org/resource/opencapi-specification-archive/>_.

Thanks,
Andrew

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

