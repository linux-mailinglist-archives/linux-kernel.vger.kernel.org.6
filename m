Return-Path: <linux-kernel+bounces-219683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CC390D679
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC37284836
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241FF1C6B5;
	Tue, 18 Jun 2024 15:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="2OfyujLT"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F3A1367;
	Tue, 18 Jun 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718723024; cv=none; b=dAPhBinvW61hZJQo4EUBg+MK0hr0i0IQ96A0pQvL9Pgnhqlc3VQeOaXnjeEJ5lSdcAvMobqfT8e/xuszUimKTYLBdbJo+gRmhKsYTus1FEo3/inO/WgtU/myfhFIXFg/s3gp8tp6dl0vNEQtmCCrJDlDdoE/gdGP8Kh/0CmvXxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718723024; c=relaxed/simple;
	bh=bs7iNpgVUW5Chv5+nq8B2RJJ4Ksk5joWXZdYM6a+9II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WudOH/nwXDKvFrcfJOv0+ewWAd8kRIkYWaXH3inUeXpgBbrOshbI8KqCWAoEjd+6ZIVTCl3e5oE6IqHEWRKGMBxkDhMzNuZnFj373E1c/cFMYT1PeZHcY2QjfL/MZJ2Nb2BRHghN6kC3o1vmR7l+RgUUVMDZVW055K9zFxqSigI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=2OfyujLT; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355090.ppops.net [127.0.0.1])
	by m0355090.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 45IEew5e009691;
	Tue, 18 Jun 2024 15:03:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=DKIM202306; bh=LsDqHofp7K+2f2J0vx8uTn8
	2tMHjx9v5dUOBs6FATk0=; b=2OfyujLTu3HMNZ/1kzSJ7E1hMLjFWJzgZiOaS3K
	oRs1TGdAoCy1YW6xeop2sf/8y1LFz8HGoX5igUdv5lCr5PEm7MsN7azev4rIkkTG
	mO6Vzt+Y5ef1nlT/APQIsXsaI6u9ChRY9JurZ+0SvYKIq8eOFiii6fQFEg68RhgG
	oYaSMdFpo8C4zTzIIO2CZO3GptHawdoNaUGWva06xhWCmEF3zRJvLCWa+EbrQyiX
	C4Svw4UQT4bVcuAq71bXyzFYnR1W6+SoyAuzj+B2hLOc9tiau9O+ouvEr7OJBoy0
	8y21NM+a5F/la2x3fRmN4OPtzoAj89tsUByfesGdwNYrn+g==
Received: from va32lpfpp03.lenovo.com ([104.232.228.23])
	by m0355090.ppops.net (PPS) with ESMTPS id 3ysp9ry9k0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 15:03:24 +0000 (GMT)
Received: from va32lmmrp01.lenovo.com (va32lmmrp01.mot.com [10.62.177.113])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp03.lenovo.com (Postfix) with ESMTPS id 4W3VPS1FQLz51Q9v;
	Tue, 18 Jun 2024 15:03:24 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp01.lenovo.com (Postfix) with ESMTPSA id 4W3VPR6DTRz2VZRs;
	Tue, 18 Jun 2024 15:03:23 +0000 (UTC)
Date: Tue, 18 Jun 2024 10:03:22 -0500
From: Maxwell Bland <mbland@motorola.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-mm@kvack.org, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ptdump: add intermediate directory support
Message-ID: <z6tpx36aipbbklsjfvllmcjurmsz7gdxoaazv7qgdvy3rdtn4i@cbapiyxw5hpz>
References: <fik5ys53dbkpkl22o4s7sw7cxi6dqjcpm2f3kno5tyms73jm5y@buo4jsktsnrt>
 <ZjtgCfhQDJus3dqI@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjtgCfhQDJus3dqI@arm.com>
X-Proofpoint-GUID: 36Dl4qhOa9MmtRZLkP33Gicrqq9UYwHt
X-Proofpoint-ORIG-GUID: 36Dl4qhOa9MmtRZLkP33Gicrqq9UYwHt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 malwarescore=0 suspectscore=0
 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406180112

On Wed, May 08, 2024 at 12:20:41PM GMT, Catalin Marinas wrote:
> On Tue, Apr 30, 2024 at 11:05:01AM -0500, Maxwell Bland wrote:
> > -ptdump is a debugfs interface that provides a detailed dump of the

Hi Catalin! Apologies for the delayed response to this review, life got
in the way. A version 4 that addresses your comments is available here:

https://lore.kernel.org/all/aw675dhrbplkitj3szjut2vyidsxokogkjj3vi76wl2x4wybtg@5rhk5ca5zpmv/

> > +Assessing these attributes can assist in understanding the memory layout,
> > +access patterns and security characteristics of the kernel pages.
> 
> I presume there's some new text here.

Yes. Though after having a bit of time to think on it, I just reworked
the presentation altogether for version 4.

> 
> >  	}, {
> >  		.mask	= PTE_UXN,
> >  		.val	= PTE_UXN,
> 
> Since you are adding a separate pmd_bits[] array, I think we could get
> rid of the PTE_TABLE_BIT entry. It doesn't make sense for ptes anyway.

Done! Sweet.

> > +static const struct prot_bits pud_bits[] = {
> [...]
> > +};
> 
> Do we need pud_bits[] as well? Can we not just use pmd_bits[]? Call it
> pxd_bits if you want, the format is the same for all p*d entries.

Thanks, done!

> 
> Please separate the alignment changes into a different patch

Done! 

> > +			delta = (addr - st->start_address);
> 
> What's this supposed to show? In your example, it's strange that the PGD
> is shown as 128 bytes:

This was a bug due to my misunderstanding of what we were going for
here. Thank you for pointing it out, as it made it easy to notice and
patch.

> >  	if (pgd_leaf(val)) {
> >  		st->note_page(st, addr, 0, pgd_val(val));
> >  		walk->action = ACTION_CONTINUE;
> 
> Is the difference between leaf and non-leaf calls only the walk->action?
> We could have a single call to st->note_page() and keep the walk->action
> setting separately. Do we also need to set ACTION_SUBTREE in case the
> entry is a table entry? Or is it done in the caller somewhere? I could
> not figure out.

ACTION_SUBTREE is the default walk action, so it is implicitly set for
table descriptors.

> 
> An alternative would be to have an ARCH_WANT_NON_LEAF_PTDUMP Kconfig
> option instead of a bool note_non_leaf in struct ptdump_state. This
> option seems to be entirely static, not sure it's worth a struct member
> for it. You'd use IS_ENABLED() above instead of st->note_non_leaf.

This was an excellent idea, thank you. Incorporated.

BRs and thanks again for your help on this,
Maxwell Bland

