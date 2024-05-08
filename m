Return-Path: <linux-kernel+bounces-173486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0968C00F7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 17:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A0F01F28405
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 15:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31A61272A3;
	Wed,  8 May 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="1EKx5BvI"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E3754FA3;
	Wed,  8 May 2024 15:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182168; cv=none; b=s+hVia35ER6rG0GnG5ID+YJLbSBv8b7uYFDR1sZdsYtCCVyS7zVA+nBukg44PfjphT86+8n+uiVja6oAkeLxb0ovSjVGtC8IaKb9GO29k14E6sSvZWxcgxLpj7b6Rxq+yjSkYW6kLgjKrZzUKUJVHc9fSsL9JqG+l++RIs3shJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182168; c=relaxed/simple;
	bh=1ktqRneI/xmAzA9v760a5rRiagZx2Ep2uk7aSWIn2To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UbZmkm4YgC7IUHWs4zfk1qRmCPuHCzIkUm23ForrzBGtxRyxYcUKVg9bLvWx/NxXH9/qj0PfMIbxhbWXashkoZTB1yuWhv+iDYpdPui+UJvkVV1aGcfsPCU+sVkQInjFryEgNuecflBepRuzGBjVtQPWYWuUhzUj41/emdnlX2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=1EKx5BvI; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355088.ppops.net [127.0.0.1])
	by m0355088.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4489oU6U014952;
	Wed, 8 May 2024 15:29:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=DKIM202306; bh=cGgfm3JhXLARphCYx+vu
	VE/z5SXwoyLJfxNkrGFGD8w=; b=1EKx5BvIv5YJL/+zjBlp/AACoftJ4JIRtMQk
	ZfYAceFaoj1RubYf0/oNui357lH6boZ9NI8YO5ADPjPsJ+WiBN8byD+b6HTDbAA7
	hQ/DeH9vZs0qA1x2wdiKy/51R+TY/3t6mUV9zYBSo4NId/FLkHIWTZzlv40u+b5N
	Vl2CTEU/IjiSKrhJWwj0uV3hvkMBdjVE8GP+rqX5BOIO1RVfalXF//HqkMgVXPus
	a89djP6eliWMjf08nC3aGgYUGQkoXeC8lEi2vasr5hCkNvzc2i2Zf7KGpN9X6fUg
	iT8FUK5OOIi8C2/oZib0MZOELwgTjqO5VDkk/ggo/gtMgYbhZg==
Received: from va32lpfpp01.lenovo.com ([104.232.228.21])
	by m0355088.ppops.net (PPS) with ESMTPS id 3xysg1tbuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 15:29:05 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp01.lenovo.com (Postfix) with ESMTPS id 4VZJw014BFzgQ3p;
	Wed,  8 May 2024 15:29:04 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4VZJvz6l6Jz3p6jp;
	Wed,  8 May 2024 15:29:03 +0000 (UTC)
Date: Wed, 8 May 2024 10:29:02 -0500
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
Message-ID: <h4znjkryp5k6sq4by7lgmctbfyhkyzqmm3f7o74ktfy7k3wfkr@s2mktazkcv3k>
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
X-Proofpoint-GUID: Pe7vE0fxNa4ELU7UpgxPS46DCDq9E_EK
X-Proofpoint-ORIG-GUID: Pe7vE0fxNa4ELU7UpgxPS46DCDq9E_EK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080111

On Wed, May 08, 2024 at 12:20:41PM GMT, Catalin Marinas wrote:
> On Tue, Apr 30, 2024 at 11:05:01AM -0500, Maxwell Bland wrote:

> > +		if (st->start_address != addr) {
> > +			pt_dump_seq_printf(st->seq, "0x%016lx-0x%016lx   ",
> > +					   st->start_address, addr);
> > +			delta = (addr - st->start_address);

> Should it show a PGD_SIZE * number_of_entries instead?

It should show the full range of memory covered by the PGD's table.
Will fix, thanks!

r > +	if (st->note_non_leaf && !pgd_leaf(val))
> > +		st->note_page(st, addr, 0, pgd_val(val));
> > +
> >  	if (pgd_leaf(val)) {
> >  		st->note_page(st, addr, 0, pgd_val(val));
> >  		walk->action = ACTION_CONTINUE;

> Is the difference between leaf and non-leaf calls only the walk->action?
> We could have a single call to st->note_page() and keep the walk->action
> setting separately. Do we also need to set ACTION_SUBTREE in case the
> entry is a table entry? Or is it done in the caller somewhere? I could
> not figure out.
>
> An alternative would be to have an ARCH_WANT_NON_LEAF_PTDUMP Kconfig
> option instead of a bool note_non_leaf in struct ptdump_state. This
> option seems to be entirely static, not sure it's worth a struct member
> for it. You'd use IS_ENABLED() above instead of st->note_non_leaf.


ACTION_SUBTREE seems right, I will look into it. Something like (though
I'll check to see if it is correct and polish):

  walk_action = (!pgd_leaf) ? ACTION_SUBTREE : ACTION_CONTINUE;
  if ((IS_ENABLED(...) && !pgd_leaf()) || pgd_leaf())
  	st->note_page ...

> -- 
> Catalin

Nice! Thank you for your feedback. I will iterate and also fix up the
other minor things, e.g. 72 character wrap in doc files.

