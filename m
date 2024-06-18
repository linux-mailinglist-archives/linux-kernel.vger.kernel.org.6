Return-Path: <linux-kernel+bounces-219917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2AA90DA16
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB4428ACEB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BCE13AA41;
	Tue, 18 Jun 2024 16:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="Y8lPA3U+"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B031304A3;
	Tue, 18 Jun 2024 16:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718729750; cv=none; b=maGHXKVTGOCa3cy6QhFlONJ6ECVGCfNoT0GppohrcTiJ7v23pLAVx+LhRaI8zv/RkILmW3elaAyTDhw4TWke3wrZp4C2nh4N9wBM+fI85UILP4T1DFB5qbQvjZXp+gG+obJKiKYn10ekfoEGXHLyfU9JVEYmhjudkzz6FS4SmI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718729750; c=relaxed/simple;
	bh=pkeYejmVfMmLVTzXH8iwwhryb6AH3j8b4cA211RBA94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXmXhcc4+RBlVevEe60M52mSH4vf1UY9OFbsyeSPpyweXhAAVCw4nwceulEG/9vVI7VBZrnnEQ0ZLDTg0zlOh1T7K95VhUDEiivB0ZgW9MppwnkylqELuW7luhI7wDIiOT5QwiblnoBCVslkGrzcRXz69qfA2Gy9Xb9kIQVuHcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=Y8lPA3U+; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355086.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45IFwjKv024465;
	Tue, 18 Jun 2024 16:55:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=wtvTXtdoSaVdCRUBoRvF2TH
	gNkI2kjk/oPJPs15GGeA=; b=Y8lPA3U+V4MNR1ghU8v73W1zfP9ErFSZZSnQiWE
	PVxEGMY/ej29Aw/SqZESLUErMck+DXelMBLCLOgt3sedkr6lOc6hxSW920llWXFG
	p9kdZPN4fIrF2cSiwUvfsvHgmNuFI/kEUBmw2xqfqx0tV2vVMJmM1mBzh8ZvPsIs
	i7Jr43fN46oihxJwAdzdCJPrBki5wkVicyQeBwP5swpnMhc0y3TrlZvHswU4kNah
	ymTir0UVirFZ7unxUA64g9hyn6/0OPjllUp9V5qvn/CTqE+HGIStn6O37mSt3vAZ
	jSfQZzzW3AB0853tlLuXzVEWoakcYtEdV1JQln6FgDSsDHQ==
Received: from va32lpfpp03.lenovo.com ([104.232.228.23])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3ysrqk71r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 16:55:18 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp03.lenovo.com (Postfix) with ESMTPS id 4W3XtY0Hcjz4yxL1;
	Tue, 18 Jun 2024 16:55:17 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4W3XtX610Zz3p6jp;
	Tue, 18 Jun 2024 16:55:16 +0000 (UTC)
Date: Tue, 18 Jun 2024 11:55:15 -0500
From: Maxwell Bland <mbland@motorola.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-mm@kvack.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] arm64: non leaf ptdump support
Message-ID: <qzel6rrn6wtbnnfwqtsa2tznh2fx6f3gtrwczphvfutv5c2sev@6ywlboai7cvh>
References: <aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv>
 <san7zg5rohy7q2oep2kx6awf6gltpuv2f4xlfljw5ezxqydfkv@zkd4k4udcezz>
 <CAMj1kXEr579hDqV5OuEbBB-O9meCOcmcTe_SZg97UKSLbKj6pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEr579hDqV5OuEbBB-O9meCOcmcTe_SZg97UKSLbKj6pw@mail.gmail.com>
X-Proofpoint-ORIG-GUID: HQJtwJLbNKvpvj8GmEcPPa98F4oAU1UX
X-Proofpoint-GUID: HQJtwJLbNKvpvj8GmEcPPa98F4oAU1UX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=590 bulkscore=0 adultscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180127

On Tue, Jun 18, 2024 at 04:59:22PM GMT, Ard Biesheuvel wrote:
> On Tue, 18 Jun 2024 at 16:40, Maxwell Bland <mbland@motorola.com> wrote:
> > @@ -105,11 +106,6 @@ static const struct prot_bits pte_bits[] = {
> >                 .val    = PTE_CONT,
> >                 .set    = "CON",
> >                 .clear  = "   ",
> > -       }, {
> > -               .mask   = PTE_TABLE_BIT,
> > -               .val    = PTE_TABLE_BIT,
> > -               .set    = "   ",
> > -               .clear  = "BLK",
> >         }, {
> >                 .mask   = PTE_UXN,
> >                 .val    = PTE_UXN,
> This table will need to distinguish between table and block entries.
> 
> I suspect that the distinction pte_bits <-> pxd_bits is not so useful
> here. It would be better to have tbl_bits[], with pointers to it in
> the pg_level array, where the PTE level one is set to NULL.

Nice, thanks! Adding now. I'll slate a v5 release for next monday.

Maxwell

