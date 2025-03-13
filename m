Return-Path: <linux-kernel+bounces-558724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6F6A5EA05
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C41D17A8CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 02:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44C278F37;
	Thu, 13 Mar 2025 02:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="toCLS3F1"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B28D26ACD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 02:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741834507; cv=none; b=rHeG1cmEfbpukzppYrxJaKajmhbay2Rw2uPq79BYlkAurOTPr/wXHM/duTCJsSr6GlSbbdBJTNCn2W9JERKL7miPXiezkIfoPsUqmGaploigoYgfrg6+IdBLarU+OqeHH0bp54Pvj+Wjusgz/N1Cu7kJYgr95fnfTxM7vAHhYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741834507; c=relaxed/simple;
	bh=4FznFI8k15D1xcKHvwftW0/i+17fKEi51o1qd/d1Us8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uHauXRkadZtl8OXJuV1P45mgs/rg0+gTEeg50u1Rl23c98xnSZfe/cYTxJSAeSC+A2lDEYZbTgPpNUxJ0E4Q+Mlg+eX1Ov6B33KclgrHJewIGBVv4HO2RAmkuAYi9hCR+1lY9XHc5m8+hpxpo6PUf1mWINoa3q5WF61O70j4KvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=toCLS3F1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CKdMuS010776;
	Thu, 13 Mar 2025 02:54:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QzUbwZ
	IB4F19T72AKaCGQM/30jhxW1JXzj8DiQnDWoc=; b=toCLS3F1c2VK7uPr8BdLxJ
	F6MTKgHyGbxZJVsVuKazNR8vel0Qlv7RglTPLYYO1nsgEGyAnoa9UpyddJN6/1Vh
	l7Qtw0efh870r8qXauSWW67eXW+vMyW0RQA20ioUX88uatik22Nuurbr93Ayhih0
	jqaSmKJ63brpLkJHuzbC3FgKfc04WZ/EM4xEgHXifXQHjEiQX0dGWeg1Afkq82vL
	jxFHAO7PjhFRvPwhOT67wbprC8FbjphZVIzQ/zU8LBjzO4qLY1LvwU0yaz1z9WvR
	wvWRljR2Jlq6i1f5VCJusy3qbYGcaKv+YnRKSclcox1KmHfjEOZPex/L1Vs/jWeQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45bhg098ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 02:54:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52D0uGkg026021;
	Thu, 13 Mar 2025 02:54:46 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45atspfhd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Mar 2025 02:54:46 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52D2siVG19792278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 02:54:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E99420043;
	Thu, 13 Mar 2025 02:54:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4F4320040;
	Thu, 13 Mar 2025 02:54:43 +0000 (GMT)
Received: from ozlabs.au.ibm.com (unknown [9.63.197.14])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Mar 2025 02:54:43 +0000 (GMT)
Received: from jarvis.ozlabs.ibm.com (haven.au.ibm.com [9.63.198.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ozlabs.au.ibm.com (Postfix) with ESMTPSA id 0DB40602DC;
	Thu, 13 Mar 2025 13:54:40 +1100 (AEDT)
Message-ID: <006ac081cf0e130426bcf0ef777bed346f6df002.camel@linux.ibm.com>
Subject: Re: [PATCH v13 00/11] Support page table check on PowerPC
From: Andrew Donnellan <ajd@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        pasha.tatashin@soleen.com, akpm@linux-foundation.org,
        maddy@linux.ibm.com
Cc: x86@kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sweettea-kernel@dorminy.me
Date: Thu, 13 Mar 2025 13:54:39 +1100
In-Reply-To: <20250211161404.850215-1-ajd@linux.ibm.com>
References: <20250211161404.850215-1-ajd@linux.ibm.com>
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
X-Proofpoint-GUID: jFxsMj_j4znHUDzGj8WLKmOskt7bM7Fc
X-Proofpoint-ORIG-GUID: jFxsMj_j4znHUDzGj8WLKmOskt7bM7Fc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_01,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxlogscore=845 lowpriorityscore=0 spamscore=0 impostorscore=0 bulkscore=0
 clxscore=1011 mlxscore=0 phishscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130018

On Wed, 2025-02-12 at 03:13 +1100, Andrew Donnellan wrote:
> Support page table check on all PowerPC platforms. This works by
> serialising assignments, reassignments and clears of page table
> entries at each level in order to ensure that anonymous mappings
> have at most one writable consumer, and likewise that file-backed
> mappings are not simultaneously also anonymous mappings.
>=20
> In order to support this infrastructure, a number of stubs must be
> defined for all powerpc platforms. Additionally, seperate
> set_pte_at()
> and set_pte_at_unchecked(), to allow for internal, uninstrumented
> mappings.

Talking to Maddy about this off-list - given that this series touches
on generic code and several architectures, would it be best to take it
through the mm tree rather than powerpc?

--=20
Andrew Donnellan    OzLabs, ADL Canberra
ajd@linux.ibm.com   IBM Australia Limited

