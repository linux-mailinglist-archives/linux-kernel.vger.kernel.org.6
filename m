Return-Path: <linux-kernel+bounces-220096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 315B290DCAA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5155281969
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6731D16D328;
	Tue, 18 Jun 2024 19:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="GGdsluB/"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB11F608;
	Tue, 18 Jun 2024 19:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718739700; cv=none; b=V0FmhbGD5+qhaFMPsrPPqshGns6ul3POuLWjUaop4/uUeiTlP/66U3N4v42wCE7SNZ+X0H7K40cvh63Wi/WMvBf6Uv6bTDN5BTvgKiZQOmcEb8S28qqAbLspaRE2S1yqCcn8DNVeHYLBpUY0xRArKFffsTms+4Aj/SQ321IX6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718739700; c=relaxed/simple;
	bh=8jKwVxuVizKD7oORmluXS9yTNnzlCvTtpj9juJwFC34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwtgNF9iLQfOjkQOXh2SB3+6ktkvfhx5cQ6ob8JamBGADXTUzB4f8tB1OKSnSLgLRQj4iLW85HBUyN08lomBlNWbCaKDnZ9nyFTi1/uN64MhDti7nzyKi2bQW94XOHPB8Z/yz0thsAjL/8J3aMo2FM8UBPfRs7fMqvSfJaJ6Now=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=GGdsluB/; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355090.ppops.net [127.0.0.1])
	by m0355090.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 45IFOWUX021235;
	Tue, 18 Jun 2024 19:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM202306;
	 bh=K2LzCxUHDkPXCVFf/G4jubW6rjNozoRRrjjuPfgXwOI=; b=GGdsluB/plLE
	dB1piY2NViiu5gden9CN3nUu+MaoZ4sV0LmhNaGEUujT4GdgeOynNlfHgGJs/Juf
	g1JeRtZjymiHl+PLKsIO9vdN2jnTaHXNADT1V3+TcptYthJEwyhRUbk3IYBYW4PU
	rHzq5s0G2dh5x8iBtzBvDR8w1Ztz4IpXZGOeIuqz9ifcIEfjEDVWdfDrV2bHNsxv
	2Kexk0kFK/1dK8mrkoAxgKxlIkhCwf0n2Wuczv4bV1avpwjovLMFox56EsUqqC2p
	II2k031DJRW+FbjL3pMALWm5FhDXlGDAdD8bo/Q55SDkv/sqZSiPCeej6w73v/ZE
	6BzanxeVTA==
Received: from ilclpfpp02.lenovo.com ([144.188.128.68])
	by m0355090.ppops.net (PPS) with ESMTPS id 3ysp9ryynu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 19:41:13 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ilclpfpp02.lenovo.com (Postfix) with ESMTPS id 4W3cZ0616mzfBb2;
	Tue, 18 Jun 2024 19:41:12 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W3cZ02YlYz2VbbF;
	Tue, 18 Jun 2024 19:41:12 +0000 (UTC)
Date: Tue, 18 Jun 2024 14:41:11 -0500
From: Maxwell Bland <mbland@motorola.com>
To: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/5] mm: add ARCH_SUPPORTS_NON_LEAF_PTDUMP
Message-ID: <5b5bumqhap3v6tjigekm6cdiv5vjzlk5dhpdwu5so5pk4dz7bd@zeka4bsylxzr>
References: <aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv>
 <fgvecau2k64sfzvxbs2yxrhzimseogdt2qk4izboywnrtco4od@ezdoxozrt2yj>
 <194624e9-125e-40aa-b8dc-08895489150e@cs-soprasteria.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <194624e9-125e-40aa-b8dc-08895489150e@cs-soprasteria.com>
X-Proofpoint-GUID: EkHJI2qOCjbYKt3oHrm6EWgMlVIYyWhG
X-Proofpoint-ORIG-GUID: EkHJI2qOCjbYKt3oHrm6EWgMlVIYyWhG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 suspectscore=0
 clxscore=1011 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180144

On Tue, Jun 18, 2024 at 06:38:24PM GMT, LEROY Christophe wrote:
> Le 18/06/2024 à 16:40, Maxwell Bland a écrit :
> > @@ -64,10 +65,11 @@ static int ptdump_p4d_entry(p4d_t *p4d, unsigned long addr,
> >          if (st->effective_prot)
> >                  st->effective_prot(st, 1, p4d_val(val));
> > 
> > -       if (p4d_leaf(val)) {
> > +       if (IS_ENABLED(CONFIG_ARCH_SUPPORTS_NON_LEAF_PTDUMP) || pgd_leaf(val))
> 
> Don't you mean p4d_leaf() here instead of pgd_leaf() ?
> Don't you mean pud_leaf() here instead of pgd_leaf() ?
> Don't you mean pmd_leaf() here instead of pgd_leaf() ?

Oh my, this is embarrassing. )-:

Hence the review process---thank you for catching these, will fix in v5.

Maxwell

