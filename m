Return-Path: <linux-kernel+bounces-542896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F83A4CF2F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 00:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0020C171ECF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 23:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0484023A9AE;
	Mon,  3 Mar 2025 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cx/tAsj9"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A832B22E405
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 23:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741044189; cv=none; b=priVebQsidoAcMBHskWFumbKqVS8tA/RwX+mZQCX1cfevJV2ikhCPKVQVk0wqQXCg8CBDZKRAnplvnr8YycgxVDid9wGDZe0oVT5uKlGijGUZwozwA1DNyGld4ZdazOPahOyQ0WeIm3HlXCG3m6JNJTxMNWQmFsBakFPAZe399A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741044189; c=relaxed/simple;
	bh=N4bpPRWhC/Vhz6OImkDBWaob/JRBtQoqX3wUs8OG2iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MeRjOizQ3VxM9QdJbr3dWsGfsIecN75FyoplTp+bmAD1+nqeeKFZGlT9AsXk6mRT/olyc+zJNVP+jDicWtmDzxMt9lzNsohxQfr88+gWDghDG2iq1jWTxshBeDnmYYQgEYLcFEOKGAUC3KJW/XqOpV5crw5iDAIBFtRaQfL4BKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cx/tAsj9; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7be8f28172dso343515885a.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 15:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741044186; x=1741648986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPygKGNxAmOTggvaqE/qBsWIYIR+kpzzJ1Nu/3DQXzQ=;
        b=Cx/tAsj9NJRm/LzMW6KOtszD1GNsJBCd0/A+S8gmo9FeCstUVfjuvQnzHdN0rr5GrT
         vMlurP6+ApmPQOnOVMWRHGU/Sfh24Z0iQujgkTYasR8cvAJ53wg6uT1Osrp7qjNMyFDR
         a6T10z+yrT3OXjDkKeNFoug98kEDN7buJaHDdF34pnMDOgclQjBjUO3CA4RBS7fQdbNw
         PlBF4tShryVXmlSkBYr5+75e0oG84QhO2lxIMRlfuuM8qTLqCr05AOg7KU9WHtrh1/6m
         xgkveqe2czwazbhocdHU2FWZWEQEGA8Oh71lyls/J5UthgDRUKJGXKJxE0nWema2prZK
         RmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741044186; x=1741648986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPygKGNxAmOTggvaqE/qBsWIYIR+kpzzJ1Nu/3DQXzQ=;
        b=tEcSgBpOyB7p82QyLk6qc0j8K0wJFcYWCq2sume8be6lQQ7crg5y1GPacLakttQ+bF
         eMuhI7I0rtSNywBL6pElFAl15hRTw3hdwXGoGm6i6vA5b2AG/k7Njmb7phdCsvx0yT3P
         J5BSKqPmuvVMPF557qN+EFnduGB8UKOtq2U406fb+GDOmFW/CMMthL06DVlO/rzImFtd
         VSAoRNwAcQuR/ZT36NrJAKB3pByHiy5jLf7mEs/1kFefFOrm0+J9WicU+FBn/1J5+C/H
         gWNQbL0hyqXVg/y+t+Vjkfb1jTGeQbSoIpahkmihVWrMOz7tloC2a14wQ8v+JUPl2nCr
         /Plw==
X-Forwarded-Encrypted: i=1; AJvYcCWOjL2UxLlBYt6ODI1Pwta4BB3B1y4KdiaPeRz6PFz4E6ZxYuYutFrdlPvAmXyealfoJ3LCmw/+QKNOzyA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0m7kSLV2LZFHPEvEvmjjATfdXkMec0KsKEKm1LDv8OC/CThPj
	fTAFyalD0TXYTo25FUYnqOq4L0MqlQD2odgjdrBtgIQ4oXpmtS2u2sSEKv89bL7qC8TvWOEp/53
	91RXh9siK47C5E5ZwzuGpeBfVuFw=
X-Gm-Gg: ASbGnctczTt4cH3lC9mcFcDngUR3n8FDlVuRkeCHD9FPYBzpuLZ5Vmd9eMsq7ktJuS1
	BM/6SsCx6feYOalzPlYuc7ivzz27MeqbOQxgAKFxtJJHf4rm/Dy0UGefL2T5hLSGeiruNa7FfSB
	eJcZ7Jgh6iIMREGh3u/dhah+qpEYE2ZX/DKaTeAeeepg==
X-Google-Smtp-Source: AGHT+IFhxCp0pJhWwbDIpecIyweBSam9v6gQpxT/XC5Zu5zudoXJPcbLPFHoUS5TGiABe8BdwNteCYWMXmXWmwcXPUQ=
X-Received: by 2002:a05:6214:2f03:b0:6e8:af1d:b12 with SMTP id
 6a1803df08f44-6e8af1d0b31mr188946016d6.19.1741044186445; Mon, 03 Mar 2025
 15:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250303200627.2102890-1-nphamcs@gmail.com> <Z8YdV4Vqju2w7hqI@google.com>
 <20250303215524.GD120597@cmpxchg.org> <Z8YuhvMZkE7CoYRN@google.com>
In-Reply-To: <Z8YuhvMZkE7CoYRN@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 3 Mar 2025 15:22:55 -0800
X-Gm-Features: AQ5f1JobsKbYPeqORFAcpnZPJhOZ8B0oIG5208pNtGVbt8tI2jCKDifQVXHhBKY
Message-ID: <CAKEwX=MdZAOkZtE-tWTe_rORwgi7=JU3MAe6vbZqO4D_OtmPkw@mail.gmail.com>
Subject: Re: [PATCH v3] page_io: zswap: do not crash the kernel on
 decompression failure
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 3, 2025 at 2:34=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev> =
wrote:
>
> On Mon, Mar 03, 2025 at 04:55:24PM -0500, Johannes Weiner wrote:
> > On Mon, Mar 03, 2025 at 09:21:27PM +0000, Yosry Ahmed wrote:
> > > On Mon, Mar 03, 2025 at 12:06:27PM -0800, Nhat Pham wrote:
> > > > @@ -635,13 +652,11 @@ void swap_read_folio(struct folio *folio, str=
uct swap_iocb **plug)
> > > >   }
> > > >   delayacct_swapin_start();
> > > >
> > > > - if (swap_read_folio_zeromap(folio)) {
> > > > -         folio_unlock(folio);
> > > > + if (swap_read_folio_zeromap(folio) !=3D -ENOENT)
> > > >           goto finish;
> > >
> > > I would split the zeromap change into a separate patch, but it's
> > > probably fine either way.
> >
> > +1
> >
> > > > @@ -1025,12 +1028,31 @@ static void zswap_decompress(struct zswap_e=
ntry *entry, struct folio *folio)
> > > >   sg_init_table(&output, 1);
> > > >   sg_set_folio(&output, folio, PAGE_SIZE, 0);
> > > >   acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, PAGE_SIZE);
> > > > - BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &=
acomp_ctx->wait));
> > > > - BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> > > > + decomp_ret =3D crypto_wait_req(crypto_acomp_decompress(acomp_ctx-=
>req), &acomp_ctx->wait);
> > > > + dlen =3D acomp_ctx->req->dlen;
> > > >
> > > >   if (src !=3D acomp_ctx->buffer)
> > > >           zpool_unmap_handle(zpool, entry->handle);
> > > >   acomp_ctx_put_unlock(acomp_ctx);
> > > > +
> > > > + if (decomp_ret || dlen !=3D PAGE_SIZE) {
> > > > +         zswap_decompress_fail++;
> > > > +         pr_alert_ratelimited(
> > > > +                 "decompression failed with returned value %d on z=
swap entry with "
> > >
> > > nit: Decompression*
> > >
> > > I am also wondering how this looks like in dmesg? Is the line too lon=
g
> > > to be read? Should we add some line breaks (e.g. like
> > > warn_sysctl_write()), we could probably also put this in a helper to
> > > keep this function visually easy to follow.
> >
> > If it were more interwoven, I would agree. But it's only followed by
> > the return true, false. Moving it out of line would need another name
> > in the zswap namespace and also take an awkward amount of parameters,
> > so IMO more taxing on the reader.
>
> My rationale was that no one reading zswap_decompress() will feel the nee=
d
> to read a function called zswap_warn_decompress_failure() in the error
> path, so it will save people parsing this huge thing.

I think Johannes' suggestion accomplishes a similar effect (see below).

>
> FWIW it would only need to take 3 parameters: decomp_ret, dlen, entry.
>
> >
> > But maybe do if (!decomp_ret && dlen =3D=3D PAGE_SIZE) return true, and
> > then save an indentation for the error part?

I like this. It also moves the (much rarer) failure case to its own
corner, which we can skip (most of the time). :)

> >
> > > > +                 "swap entry value %08lx, swap type %d, and swap o=
ffset %lu. "
> > > > +                 "compression algorithm is %s. compressed size is =
%u bytes, and "
> > > > +                 "decompressed size is %u bytes.\n",
> >
> > Any objections to shortening it and avoiding the line length issue?
> > Even with \n's, this is still a lot of characters to dump 10x/5s. And
> > it's not like the debug info is super useful to anyone but kernel
> > developers, who in turn wouldn't have an issue interpreting this:

No objection from my end.

> >
> > pr_alert_ratelimited("Decompression error from zswap (%d:%lu %s %u->%d)=
\n",
> >                    swptype, swpoffset, name, clen, dlen);
>
> Yeah this looks much more concise. It's a bit harder to parser the dmesg
> as you have to cross check the code, but hopefully this is something
> that people rarely have to do.
>
> I don't feel strongly about adding a helper in this case, unless we want
> to add local variables (like Johannes did above), in which case a helper
> would be a good way to hide them.

That said, I'm not so sure about adding local variables here. We would
be cluttering the code for a bunch of single-use variables, that are
not even the "common" case. I mean, this seems fine to me?

pr_alert_ratelimited("Decompression error from zswap (%d:%lu %s %u->%d)\n",
                                 swp_type(entry->swpentry),
                                 swp_offset(entry->swpentry),
                                 entry->pool->tfm_name, entry->length, dlen=
);

(with proper indentation, but you get the idea).

