Return-Path: <linux-kernel+bounces-544078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF683A4DD1C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA7C27A4655
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C18D203707;
	Tue,  4 Mar 2025 11:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="B6WyAz0g"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F292036FE
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741089250; cv=none; b=czr8Qpn3+n9j+WGIE75UBqBkvX12RBAcfQM+J4zf0UR9JhusZRAwLkCRUINrt9WFQw5dOc2kHQ4ZIJLdGb7F0GZM9ZTlKicNS0WSLfltFM+ga8PKPMfDs79ckAfz+bkrb5IE/l0joRZCjiEjvHXkt9tnPfpHTnzteWYGX3M2ycA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741089250; c=relaxed/simple;
	bh=bNS41mNHHi7BXNLXQtonV4XeSMbhOnsgKPrJtmKYSHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXJ+deUQKCs649bP4rKhiik6WPEloeOXJeRCCbUwPUSXllqC3nZiyiT5d0pBOWv+NKYFz3wXMTP9ZH4oNItTnduQq4uM4HY+C4fcDkuGwqeiDFZSMn1LlmEZQlQWRmCth1dobWseV6Uqnj9nAASxovW2fW86gwmA9Zq7Gpmj7oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=B6WyAz0g; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 088B440E0202;
	Tue,  4 Mar 2025 11:54:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 5eVmiwsvjl6y; Tue,  4 Mar 2025 11:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741089242; bh=8GHG5SrZxrbiSvIE9KJ7OpGdZd2qAT9K/MHNn8uHvMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6WyAz0gzR98rv/PHGB5eUpm8blzgQE1qfpqqd+ZRj721zz1LKmQ0jL+6CrW3ies1
	 T1pZyPdhgjObE+tC4sw0nDViNtOzAlvgA1/MaNCa7Y4WPgJLoVarl8nqa0fAmUrv/r
	 GPmq2elRiXvilpNp6OTx4G+5ImYI4G+vEP0hvZExDLsK0/3jSdbgR9cRf97U2c7iUp
	 VXWAWvQxfi4REUalFPlgNtPL+iKR7l1wraRNQJT09LE/3MGQBZT3lCwuppnwKJMw9G
	 xd6TtL7h6XEmScV1m1nQEDrP8Y04r6Hb/T6LF14tdwTVLlQdPq05GGoArr7XTOLbvB
	 tbKX283180w+wWI892XKcLiBw/8546LPsI+4J1cTuFel84Ab0JHT4c5IHo0+RPqWza
	 QLl8Fq04dLKrZO8p1bg6deBlN+Xn07aF3MX7VHzR1l4GTJBBH/wjvvCo0ys1XXNUih
	 rQflzTRiRJU3ZtXFfoM1cVJcgtrFNc02Qdq1okmv6NQn6FZWj5HM/EI2ML00317v3V
	 Tfh11f/+OvRa9lxDt9sN3XXvhLRGZyGFdofNRXRd/tZ18RH/ol8exaDgme7OZMoX0c
	 JINDDrIiRIKz/GvNJHHn0YLvhe6HNct3ob7EE4NpphdyW8cu2wZI8nQb87yHtNmdF8
	 mM97U4fGrQSsF5wVyMiQcmLk=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 25AB240E0176;
	Tue,  4 Mar 2025 11:53:44 +0000 (UTC)
Date: Tue, 4 Mar 2025 12:53:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
	jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
	Manali.Shukla@amd.com, mingo@kernel.org
Subject: Re: [PATCH v14 13/13] x86/mm: only invalidate final translations
 with INVLPGB
Message-ID: <20250304115343.GGZ8bpxwAZo9tksg17@fat_crate.local>
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-14-riel@surriel.com>
 <ffff0bdc-ddf9-4f70-980a-f66eb2a00b18@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ffff0bdc-ddf9-4f70-980a-f66eb2a00b18@intel.com>

On Mon, Mar 03, 2025 at 02:40:49PM -0800, Dave Hansen wrote:
> On 2/25/25 19:00, Rik van Riel wrote:
> >  static inline void __invlpgb_flush_user_nr_nosync(unsigned long pcid,
> >  						  unsigned long addr,
> >  						  u16 nr,
> > -						  bool pmd_stride)
> > +						  bool pmd_stride,
> > +						  bool freed_tables)
> >  {
> > -	__invlpgb(0, pcid, addr, nr, pmd_stride, INVLPGB_PCID | INVLPGB_VA);
> > +	u8 flags = INVLPGB_PCID | INVLPGB_VA;
> > +
> > +	if (!freed_tables)
> > +		flags |= INVLPGB_FINAL_ONLY;
> > +
> > +	__invlpgb(0, pcid, addr, nr, pmd_stride, flags);
> >  }
> 
> I'm not sure this is OK.
> 
> Think of a hugetlbfs mapping with shared page tables. Say you had a
> 1GB-sized and 1GB-aligned mapping. It might zap the one PUD that it
> needs, set tlb->cleared_puds=1 but it never sets ->freed_tables because
> it didn't actually free the shared page table page.
> 
> I'd honestly just throw this patch out of the series for now. All of the
> other TLB invalidation that the kernel does implicitly toss out the
> mid-level paging structure caches.

Right, I guess we can revisit this later, once the dust settles.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

