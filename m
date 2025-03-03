Return-Path: <linux-kernel+bounces-542790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF96CA4CDB8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 22:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9143B7A23E3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 21:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07561F098A;
	Mon,  3 Mar 2025 21:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="lQJDwyA3"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206991E5213
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741038936; cv=none; b=YJWtahsxI9JWX57WYuMAJi2Zj2TK0ruqNF34iO4VlJ7vR7Aa2OJoxGYSf89g9CBBURpplSdJJc0EzfLjHBrT24F5+bq8GzizFpwFXjr8/EOd10oZfjLsmYBh93xVj4ulY73sVewUNrF+Qtk73MRJjMjN7xjES4qplibTmNNuaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741038936; c=relaxed/simple;
	bh=HBfhnfcVZ88GBi6zpINC0bUiOoRnkF8Wf+QoGuxJLt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFuVC2l1lJKXGJL0qfU8dSY3cZp4uYW+tMK3slBvZG1pv34HG7CMBYEv9rrUCkmEjkd7JZP39prbzFTOuJju205scw+I27UK09AKACQlc3HORkKT0j/zpRophEmd3eSa7fxb0powHX1lb5OuJBGA1XaLrRpI3F0uxeG93bh1ir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=lQJDwyA3; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4720cfc35e9so80206321cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 13:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741038929; x=1741643729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdrIIP96hB4G69vYpanHuRUgE9nuR/b6P/MWHZpJMKU=;
        b=lQJDwyA3x0D8m1oxyZFKGxnz1H7w/gxdwJ0JbMW5q+RDQCqA/jemBtdeKg763QN5cI
         KyeukePZin5+4PST/u2/VJtvcJgsS5+Fsl/b50FKFc8DHz+jlHH4U3tWyS7VFXQ7zzTc
         vh2UkeszpHFxeJWORPcGcRii6xLhnwdpQqqj3pZiQfIVbLrlg08jdU/e3MOiCB/Y13jk
         v9sJWGQz/mEShXpzzEoo4ATh0GfvVDIlQbSEm1R2elEkDLgC6PFCsqLGouqsNthAMm9Y
         RsG5wU4BBeDNhQS5nsOK/JXfAYTtOuNd2wziHfxzE6QplHTBwMmVWIHAaflGtXn2m0lY
         Kp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741038929; x=1741643729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdrIIP96hB4G69vYpanHuRUgE9nuR/b6P/MWHZpJMKU=;
        b=W0+eXEoTcRuyetc5yOiGe9IAPFZZtIId8PVrBJ/FLs5g6K4rYNeneWRE3XLBbCCtus
         gCN5mufjvRHxSTv8HcJQmKqlIjWCBpKZgzv8FZPtzhqr0Wl3QPkNwdaJou3+lqZC026E
         AJo/zp1A6eGE5YMmWTOO6hWqXiRL+0hfqV5hKUFjrClwfc0ZuR/1nx9isqCCcnQx+BIf
         e8XfQREU++qYI8Boq/v2NAXyMyqYLmQBxZuYMUxFrDMnR2Qekz0R3iCyXGXi3ddexFqT
         o0QY2U3WJSZolHyqHjfgXuo3rKegNTCwNFr7nilPuURiuXoycnEQC5sqs/lBB8g8oFod
         Jx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMM6mS69PkmLS1b9zt7w7sxkQzm17J0wGPyExhrnFh1q0Xthzaf3v2cLRqvyQrU85ztEW198cYvH2AkXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Bb8NK1UutsH0WhL22SJn+7kz7KeeTawE42rUrnl4LGx4b4KD
	fCxCMc0/5wRu4IEjB0B1CA+GXZ8jwea+b1u1Vet7sgPnr9CFAWRBLgCW0GpDZ2Q=
X-Gm-Gg: ASbGnctsBxXj1AUnViQcOSI1FOdQeGriUKmcGTv9CDFpx21AJydkuwAXmZPnF52N8CL
	Zni1ox/YIoo+yMj/bK2Kn0AB/UN4rfVUQW6a7rWG1k7eLL68puGWmRtJ2db6tj+u6eIiFpkoZij
	AP1E8Ph1CYQZvid01+qpl/+86qGqujto/zjJIqxcJXzsxy6L0m5p3QkJkVrj2sUX01ubaRyLx+A
	+bzcd4WpyYWQjM0p272Z7UL18LOi2yTeByqCqZ6v0ryoZVnbWvlWClifqpEr1ulcJ+u1czwzOgk
	0ln9yf5MtWvdg7JTbD4lPC9n+u5Tt1UFm1OfVioRCv8=
X-Google-Smtp-Source: AGHT+IFSketQllVNw0jtTxWFYdUDUo0SMM0ON8BTORWBomp0X+4PY2gDNSvSpYktg5pUI0cT5GzZwQ==
X-Received: by 2002:a05:622a:1b87:b0:472:6ac:24a1 with SMTP id d75a77b69052e-474bc0f6cb1mr213334211cf.37.1741038928876;
        Mon, 03 Mar 2025 13:55:28 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-474691a1f78sm63406451cf.14.2025.03.03.13.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 13:55:27 -0800 (PST)
Date: Mon, 3 Mar 2025 16:55:24 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] page_io: zswap: do not crash the kernel on
 decompression failure
Message-ID: <20250303215524.GD120597@cmpxchg.org>
References: <20250303200627.2102890-1-nphamcs@gmail.com>
 <Z8YdV4Vqju2w7hqI@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8YdV4Vqju2w7hqI@google.com>

On Mon, Mar 03, 2025 at 09:21:27PM +0000, Yosry Ahmed wrote:
> On Mon, Mar 03, 2025 at 12:06:27PM -0800, Nhat Pham wrote:
> > @@ -635,13 +652,11 @@ void swap_read_folio(struct folio *folio, struct swap_iocb **plug)
> >  	}
> >  	delayacct_swapin_start();
> >  
> > -	if (swap_read_folio_zeromap(folio)) {
> > -		folio_unlock(folio);
> > +	if (swap_read_folio_zeromap(folio) != -ENOENT)
> >  		goto finish;
> 
> I would split the zeromap change into a separate patch, but it's
> probably fine either way.

+1

> > @@ -1025,12 +1028,31 @@ static void zswap_decompress(struct zswap_entry *entry, struct folio *folio)
> >  	sg_init_table(&output, 1);
> >  	sg_set_folio(&output, folio, PAGE_SIZE, 0);
> >  	acomp_request_set_params(acomp_ctx->req, &input, &output, entry->length, PAGE_SIZE);
> > -	BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait));
> > -	BUG_ON(acomp_ctx->req->dlen != PAGE_SIZE);
> > +	decomp_ret = crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &acomp_ctx->wait);
> > +	dlen = acomp_ctx->req->dlen;
> >  
> >  	if (src != acomp_ctx->buffer)
> >  		zpool_unmap_handle(zpool, entry->handle);
> >  	acomp_ctx_put_unlock(acomp_ctx);
> > +
> > +	if (decomp_ret || dlen != PAGE_SIZE) {
> > +		zswap_decompress_fail++;
> > +		pr_alert_ratelimited(
> > +			"decompression failed with returned value %d on zswap entry with "
> 
> nit: Decompression*
> 
> I am also wondering how this looks like in dmesg? Is the line too long
> to be read? Should we add some line breaks (e.g. like
> warn_sysctl_write()), we could probably also put this in a helper to
> keep this function visually easy to follow.

If it were more interwoven, I would agree. But it's only followed by
the return true, false. Moving it out of line would need another name
in the zswap namespace and also take an awkward amount of parameters,
so IMO more taxing on the reader.

But maybe do if (!decomp_ret && dlen == PAGE_SIZE) return true, and
then save an indentation for the error part?

> > +			"swap entry value %08lx, swap type %d, and swap offset %lu. "
> > +			"compression algorithm is %s. compressed size is %u bytes, and "
> > +			"decompressed size is %u bytes.\n",

Any objections to shortening it and avoiding the line length issue?
Even with \n's, this is still a lot of characters to dump 10x/5s. And
it's not like the debug info is super useful to anyone but kernel
developers, who in turn wouldn't have an issue interpreting this:

pr_alert_ratelimited("Decompression error from zswap (%d:%lu %s %u->%d)\n",
		     swptype, swpoffset, name, clen, dlen);

> > +			decomp_ret,
> > +			entry->swpentry.val,
> > +			swp_type(entry->swpentry),
> > +			swp_offset(entry->swpentry),
> > +			entry->pool->tfm_name,
> > +			entry->length,
> > +			acomp_ctx->req->dlen);

