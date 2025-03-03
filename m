Return-Path: <linux-kernel+bounces-542839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 949FEA4CE5A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B8FC188C16E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D72237705;
	Mon,  3 Mar 2025 22:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vgvMHXNW"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5F02343AB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 22:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041296; cv=none; b=jVkpYkUUfSbj+bKbAFQoByFVEn1jN1z2ZCUMhrZ70ErLdh2Mr5rwfv9p5IG6bHbjIyGYDgojzr6HcpNTrpx3HndjY1OcfatKavSryJ1SgFX/nu3C/zpg6YZ/Exb7hLCNGVtRLSU59D2vzogLFwL+h/zZjlrDHCQfWEBLMpqmC+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041296; c=relaxed/simple;
	bh=zhieft+nHqE44cRpoGTo7Wgldf9DHgUQm7cs2zZ74M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKzyUjNyl0sJyy+kEDrPhK3agy/4EC6wxJOVnzic8ph3K6RHXYNa6En1Tgb3kVpFu+8bplEuaVCCEmnqRV7J3FFmd7gYMXnrU+kK95l5sbj2TYtSdB7g+7SqGNNTa/c2eRu76gRK39I4Z4mDHAfLneqGMPmCR1Q/JeGz8cSIDjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vgvMHXNW; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 3 Mar 2025 22:34:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741041292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9L92r6X7Eg96asDUmcRcp3aZhjsIld49Y1+1SOSF1iI=;
	b=vgvMHXNWl6+D+INZwx3XRAEmwDjUiLF96Tki7+GGtO+iZdEVhR3zEiGmnJSNK+l4wkyKoL
	zTSIOOqFLAVLmfX2x8xaPjJc33u5yHxfZV3sdXMK0eDE8Uy46pqoHYA995Q0DGH6/M3acb
	MKVG781br9YG2v0vjVEyPDMbq+os+ik=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] page_io: zswap: do not crash the kernel on
 decompression failure
Message-ID: <Z8YuhvMZkE7CoYRN@google.com>
References: <20250303200627.2102890-1-nphamcs@gmail.com>
 <Z8YdV4Vqju2w7hqI@google.com>
 <20250303215524.GD120597@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303215524.GD120597@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 03, 2025 at 04:55:24PM -0500, Johannes Weiner wrote:
> On Mon, Mar 03, 2025 at 09:21:27PM +0000, Yosry Ahmed wrote:
> > On Mon, Mar 03, 2025 at 12:06:27PM -0800, Nhat Pham wrote:
> > > @@ -635,13 +652,11 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
> > >  	}
> > >  	delayacct_swapin_start();
> > >  
> > > -	if (swap_read_folio_zeromap(folio)) {
> > > -		folio_unlock(folio);
> > > +	if (swap_read_folio_zeromap(folio) != -ENOENT)
> > >  		goto finish;
> > 
> > I would split the zeromap change into a separate patch, but it's
> > probably fine either way.
> 
> +1
> 
> > > @@ -1025,12 +1028,31 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> > >  	sg_init_table(&output, 1);
> > >  	sg_set_folio(&output, folio, PAGE_SIZE, 0);
> > >  	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
> > > -	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
> > > -	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
> > > +	decomp_ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
> > > +	dlen = acomp_ctx->req->dlen;
> > >  
> > >  	if (src != acomp_ctx->buffer)
> > >  		zpool_unmap_handle(zpool, entry->handle);
> > >  	acomp_ctx_put_unlock(acomp_ctx);
> > > +
> > > +	if (decomp_ret || dlen != PAGE_SIZE) {
> > > +		zswap_decompress_fail++;
> > > +		pr_alert_ratelimited(
> > > +			"decompression failed with returned value %d on zswap entry with "
> > 
> > nit: Decompression*
> > 
> > I am also wondering how this looks like in dmesg? Is the line too long
> > to be read? Should we add some line breaks (e.g. like
> > warn_sysctl_write()), we could probably also put this in a helper to
> > keep this function visually easy to follow.
> 
> If it were more interwoven, I would agree. But it's only followed by
> the return true, false. Moving it out of line would need another name
> in the zswap namespace and also take an awkward amount of parameters,
> so IMO more taxing on the reader.

My rationale was that no one reading zswap_decompress() will feel the need
to read a function called zswap_warn_decompress_failure() in the error
path, so it will save people parsing this huge thing.

FWIW it would only need to take 3 parameters: decomp_ret, dlen, entry.

> 
> But maybe do if (!decomp_ret && dlen == PAGE_SIZE) return true, and
> then save an indentation for the error part?
> 
> > > +			"swap entry value %08lx, swap type %d, and swap offset %lu. "
> > > +			"compression algorithm is %s. compressed size is %u bytes, and "
> > > +			"decompressed size is %u bytes.\n",
> 
> Any objections to shortening it and avoiding the line length issue?
> Even with \n's, this is still a lot of characters to dump 10x/5s. And
> it's not like the debug info is super useful to anyone but kernel
> developers, who in turn wouldn't have an issue interpreting this:
> 
> pr_alert_ratelimited("Decompression error from zswap (%d:%lu %s %u->%d)\n",
> 		     swptype, swpoffset, name, clen, dlen);

Yeah this looks much more concise. It's a bit harder to parser the dmesg
as you have to cross check the code, but hopefully this is something
that people rarely have to do.

I don't feel strongly about adding a helper in this case, unless we want
to add local variables (like Johannes did above), in which case a helper
would be a good way to hide them.

> 
> > > +			decomp_ret,
> > > +			entry->swpentry.val,
> > > +			swp_type(entry->swpentry),
> > > +			swp_offset(entry->swpentry),
> > > +			entry->pool->tfm_name,
> > > +			entry->length,
> > > +			acomp_ctx->req->dlen);

