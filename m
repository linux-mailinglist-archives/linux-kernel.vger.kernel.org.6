Return-Path: <linux-kernel+bounces-291671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CE795655E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F151B28318E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3894215AADA;
	Mon, 19 Aug 2024 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPPjCLrx"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB18542A8F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055398; cv=none; b=kHsbTF/3WeF8cNwrgQp9blv5/0v+C88upDpXSfbVtlkIpC3VBHvtsXesi9otWGXT+pqd9csf7KbPJVd3U3OieP62cqRuY4ydC5wNcFJgZixnzHKah7W98XsYb+ms8LBdUAryPantv6rQekGQX4Yxv/zhncBaDzpre5vLcQA8OD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055398; c=relaxed/simple;
	bh=+iO4CEC8JR3fCEadD3MXWfnr7OB0rBq7y39UpXwNx0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8oUBkOa8Z2Y3VdB9sae2zdTHOEPkv3AiLRJvp1ps31AUEuX6hgZ63UbzaQ317jAgps8zOZZcDuRS4iHceTdzLXxlNy2J1WMxAL755HB7Adsj1rySiDvGIzes1x9AQEtvkTspx+ShE90/8kAXdT6ZW90SD8b/UDtWDJFzNYYk8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPPjCLrx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-428e3129851so32576225e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724055395; x=1724660195; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHfO228DZNryni5G2SSxgcBG4xZ187dTZqHvUBwI148=;
        b=HPPjCLrxR6++gC9qEkZfQtZZo8AKyrxlzZNK7F8nNk+xUf/U8hWFE+EscGC6Kvlr47
         CnCF2D/apP+abvlsKx1puhY1EzCaFKx3llYCBiz8BMlnxxZu5AGBKaV92FG9rfdzYWkU
         cGehEwFhwiHKxfoMwh6IXmkMH4xohTpyUHom4gSlydxjK3EB7i2eEkAvXe5rCDFd+3ZW
         RU9X9MUyfNFtSZlxyLERBYfhOwJ/c3aGWpNcH72+1QWBrZMReK5FryKiLDIQ5HAPCZdk
         vgEqiD8KDkfZ/T7P4Huki/2Uu5X8XfPpCKTmoxURLt5ZiuWDFCtkrzPm3EZOvxjlDc2I
         bhXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724055395; x=1724660195;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHfO228DZNryni5G2SSxgcBG4xZ187dTZqHvUBwI148=;
        b=GlGMTmydb9N51jz+EbfDNAWaO0mSOsMbUj65mUCAjH71XdXbf2A7lDu/QDv/IEheX4
         rRtA1oz0SHtRxVHm3zhDG+Xl+K8nigy273LPRE9E37fKlgj9tOjO1tUu8KqaIA2fq/XW
         EhvynsUN55gM8dUdgVx2kdz7HinSZe0w7fMgoa/JvpcgYY4T0VVHF65aTAr3EDFZYo5M
         oS83MtmKJtXw0Cy5OhuRpd9/c1/AkSYPaopuvFtJUOwWFW44UXopYCJhY/WqKVQDY3Gj
         pMaIYAY0OL4UysOO/SeplDKmfDRFFfrGMA1wITu5krn9E0pBqmZSDtxP/Teex3sZ3kRU
         KTZw==
X-Forwarded-Encrypted: i=1; AJvYcCXO54TkPMymnn6IBJqsuzi4jbCOtFRv5ESPOiofAWhUtDEZB+RGCjkahCxktc7OonN3KE2FeVwTaooaXUt83q08RECms5bK0KLj38k7
X-Gm-Message-State: AOJu0YwID+PjhrwlVv60GvIgPuM8jwgw/G6Q06UZRrUr3FhyUqSI47/C
	EEjjFJ+8SKpLCfSmvcea8qpNTgoPaf5qOdzaTCM4kkO8LWs7iXDVgRIqAprjcA==
X-Google-Smtp-Source: AGHT+IFBd7V14kDw4QUauT5EDSPMLG3k1dEdle6s90msb/Z3KXxJ4G39D9HkdEp1kMIzWJw0caczAw==
X-Received: by 2002:a05:600c:3143:b0:428:29d:4b59 with SMTP id 5b1f17b1804b1-429ed7c1e5dmr81417025e9.20.1724055394419;
        Mon, 19 Aug 2024 01:16:34 -0700 (PDT)
Received: from google.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718983a57asm9833805f8f.2.2024.08.19.01.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 01:16:34 -0700 (PDT)
Date: Mon, 19 Aug 2024 09:16:30 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Andrew Bresticker <abrestic@rivosinc.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, maz@kernel.org, seanjc@google.com
Subject: Re: [PATCH v2] mm/memory: Don't require head page for do_set_pmd()
Message-ID: <ZsL_XvRL-OgEqmvv@google.com>
References: <20240611153216.2794513-1-abrestic@rivosinc.com>
 <8040793f-e9e9-4a2e-807c-afcb310a48f5@redhat.com>
 <20240611110622.8e9892e92618ddc36bca11b7@linux-foundation.org>
 <ZmiVy8iE93HGkBWv@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmiVy8iE93HGkBWv@casper.infradead.org>

On Tue, Jun 11, 2024 at 07:22:03PM +0100, Matthew Wilcox wrote:
> On Tue, Jun 11, 2024 at 11:06:22AM -0700, Andrew Morton wrote:
> > On Tue, 11 Jun 2024 17:33:17 +0200 David Hildenbrand <david@redhat.com> wrote:
> > 
> > > On 11.06.24 17:32, Andrew Bresticker wrote:
> > > > The requirement that the head page be passed to do_set_pmd() was added
> > > > in commit ef37b2ea08ac ("mm/memory: page_add_file_rmap() ->
> > > > folio_add_file_rmap_[pte|pmd]()") and prevents pmd-mapping in the
> > > > finish_fault() and filemap_map_pages() paths if the page to be inserted
> > > > is anything but the head page for an otherwise suitable vma and pmd-sized
> > > > page.
> > > > 
> > > > Fixes: ef37b2ea08ac ("mm/memory: page_add_file_rmap() -> folio_add_file_rmap_[pte|pmd]()")
> > > > Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
> > > > ---
> > > >   mm/memory.c | 3 ++-
> > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > index 0f47a533014e..a1fce5ddacb3 100644
> > > > --- a/mm/memory.c
> > > > +++ b/mm/memory.c
> > > > @@ -4614,8 +4614,9 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct page *page)
> > > >   	if (!thp_vma_suitable_order(vma, haddr, PMD_ORDER))
> > > >   		return ret;
> > > >   
> > > > -	if (page != &folio->page || folio_order(folio) != HPAGE_PMD_ORDER)
> > > > +	if (folio_order(folio) != HPAGE_PMD_ORDER)
> > > >   		return ret;
> > > > +	page = &folio->page;
> > > >   
> > > >   	/*
> > > >   	 * Just backoff if any subpage of a THP is corrupted otherwise
> > > 
> > > Acked-by: David Hildenbrand <david@redhat.com>
> > 
> > You know what I'm going to ask ;) I'm assuming that the runtime effects
> > are "small performance optimization" and that "should we backport the
> > fix" is "no".
> 
> We're going to stop using PMDs to map large folios unless the fault is
> within the first 4KiB of the PMD.  No idea how many workloads that
> affects, but it only needs to be backported as far as v6.8, so we
> may as well backport it.

Hi, I am reviving this thread after noticing this comment attached
to the fix.

If you intend to install PTE level mappings for faults that happen outside of
the first 4KiB, I believe this will make THP support for KVM ineffective.

