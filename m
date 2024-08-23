Return-Path: <linux-kernel+bounces-299118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1FD995D055
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C684286160
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 14:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEC618859A;
	Fri, 23 Aug 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YiJwgQf2"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43EA187FFC;
	Fri, 23 Aug 2024 14:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424452; cv=none; b=WMcqjKKJvBxQHq4pspGj2zr4iaqyo5RLfdlgnAviRPYTHRmU1YfWJxObXkEW2PuFzRL30+cCUSN0T2vb6jlTeimcrplP0/Zv29lcVUPFykzYBb1WeB9ZufIc79tpoX+1kl6X+/Y27pNMM9/DRAIIYi6/sRtMuL4i+vf6QT3HkUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424452; c=relaxed/simple;
	bh=YL/VDv295SPOhXOitCTzd13TM7g0QJYMAfTlI6SFv78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Owu9UAlfXjekPhNSUmG8Td4XshpxgZxN6ZgDCPcDqL6IXE8fbIzQWa40jfVqns1tevOW+GXs9bm+KSK1TiZDs91VNgxN8zCgi1cRDOTAyyhKCEx/RgGUIDw97vpOyl+jrFoYV7Qbg2hAHMu+6qHiNcubhsFMFU+XgH1H9lFmbsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YiJwgQf2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=A6JtJ+roSbECN+POR7GhhHD1vIdACn5juW9yqsSZRLs=; b=YiJwgQf2BBX4aZKtSk/5IZx/5A
	R49JjQqTl7A71auWQpc7jIzi8Vp2eDt28x0H86mb6LvIwzKJvdNgE5pdgAeDJbfVfHJ2dzCd6a819
	o6ngnrTU5ayWb2b4uuLIwZTcqb7ZdTHuA994tBcMRH0ofbPrCorzwAQCIBxgHuTeH42VSnmSTbVml
	BcqtqKRNC+VZucRop0/JK/5+ctFkCskQsPd91RzAx4plDQu/0J0fGvAhTwvskYM4f68m3ApC/6AD8
	ZGO6SV9IAiQK6oBdqLL7dvZERzxi7LA5i/FhXtmqfNcQ50lwdKga49Zqrchee+BiBqqGatK+ZF1yJ
	UamWfcfw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shVZU-0000000BphE-1AHl;
	Fri, 23 Aug 2024 14:47:24 +0000
Date: Fri, 23 Aug 2024 15:47:24 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>,
	Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>, Linux-MM <linux-mm@kvack.org>
Subject: Re: [regression] oops on heavy compilations ("kernel BUG at
 mm/zswap.c:1005!" and "Oops: invalid opcode: 0000")
Message-ID: <Zsig_AZDT5zOO1Wg@casper.infradead.org>
References: <BD22A15A-9216-4FA0-82DF-C7BBF8EE642E@gmail.com>
 <6f65e3a6-5f1a-4fda-b406-17598f4a72d5@leemhuis.info>
 <ZsiLElTykamcYZ6J@casper.infradead.org>
 <CAKEwX=PEye=VcXF=r-A9B47VsNtpLLxz5cJiswzuQXBio8rizA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKEwX=PEye=VcXF=r-A9B47VsNtpLLxz5cJiswzuQXBio8rizA@mail.gmail.com>

On Fri, Aug 23, 2024 at 10:35:19AM -0400, Nhat Pham wrote:
> On Fri, Aug 23, 2024 at 9:13 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> >
> > That said, zswap could handle this better.  There's no need to panic the
> > entire machine over being unable to read a page from swap.  Killing just
> > the process that needed this page is sufficient.
> 
> Agree 100%. It is silly to kill the entire host for a swap read error,
> and extra silly to kill the process because we fail to writeback - for
> all we know that page might never be needed by the process again!!!
> 
> >
> > Suggested patch at end after the oops.
> >
> > @@ -1601,6 +1613,7 @@ bool zswap_load(struct folio *folio)
> >         bool swapcache = folio_test_swapcache(folio);
> >         struct xarray *tree = swap_zswap_tree(swp);
> >         struct zswap_entry *entry;
> > +       int err;
> >
> >         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> >
> > @@ -1638,10 +1651,13 @@ bool zswap_load(struct folio *folio)
> >         if (!entry)
> >                 return false;
> >
> > -       if (entry->length)
> > -               zswap_decompress(entry, folio);
> > -       else
> > +       if (entry->length) {
> > +               err = zswap_decompress(entry, folio);
> > +               if (err)
> > +                       return false;
> 
> Here, if zswap decompression fails and zswap load returns false, the
> page_io logic will proceed as if zswap does not have the page and
> reads garbage from the backing device instead. This could potentially
> lead to silent data/memory corruption right? Or am I missing something
> :) Maybe we could be extra careful here and treat it as if there is a
> bio read error in the case zswap owns the page, but cannot decompress
> it?

Ah; you know more about how zswap works than I do.  So it's not a
write-through cache?  I guess we need to go a bit further then and
return an errno from zswap_load -- EIO/ENOENT/0 and handle that
appropriately.

> The rest seems solid to me :)

