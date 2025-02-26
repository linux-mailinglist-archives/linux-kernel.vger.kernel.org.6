Return-Path: <linux-kernel+bounces-535122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF228A46F43
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA3E1887BFD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D93D2702AC;
	Wed, 26 Feb 2025 23:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDBt0H0O"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2761F2702A1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611813; cv=none; b=eNL8N+t+Eigl6vzOJwripe2nBOYSDOBfhS8Vbz3NKUgPGtMl6avfw9l9rtuVMEiA2QaFp5iQteFo6g33eYXr8NfZtF5ThqfVPMxYT42g287Y9/OM+GrWyUzcdQ6FO1AtMp7EuZBoj8ez8j8got6jytk/WWlbkQbGhM2+dXoDmx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611813; c=relaxed/simple;
	bh=tU5vRJE1b7WGC2L5JUQWscwt2KsE/pIxXYBGtsm9zX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gaAQgwifsRZ8oWUyFMP1XRUQA0PJmfn//YAMGyQ3gwFiDl+nATubzKY/cmpLHK0hLQpnFqhhnDEA9WhLfjwIs5fvQ0jJseoCoD+fM9UfNKU3NbsztLOBlXhd0SKMBJ5dl/BSpb4TUnfYSP9W5UdP7l6Ystx99gNLH4KWBHaCLk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VDBt0H0O; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6e41e17645dso4152636d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740611811; x=1741216611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+wupZjcEefs4tpOMXq9CcK49xcNos1HQVedAtnerkA=;
        b=VDBt0H0OV8T2hKf2/rx6MChKGD0MPajM7VNSSeGwEFv1gLqSvXE4Yk1S5xe45MuIRK
         f9E3hfEs2V5AwmSN5AjiWD3HCBZLZD7LQbBu3W+JVD+bjb0s/WrzsRuBwAVvVSffGB4T
         2JS+BpDG/xB/NJ7rXWFAqOXg9ca6NON/yimx8BLHo0mpzPpOUnXadV0ckBIwkxHQwFjM
         ZEanqr16OJc7a1HCeevr2UxNnmYqtj4PJyzv+HA6ZPxbhOgnsapINY5umRD3rqaijYw9
         uQmj/8apMFRpuvZ72av1EXI1jNCaZdpmFc8m12VyRp8hT5qHTaB07dlvuth4vZ+9NfaH
         XONA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740611811; x=1741216611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+wupZjcEefs4tpOMXq9CcK49xcNos1HQVedAtnerkA=;
        b=AiK5QGaJi+wuXEequuW50+ULdrUsl2MKGZQlahFYUzS+1UFLuiRyzj99l0ofa/xo19
         12eeMd48+asenCAtmhJfIpCeSKY3I+cFBJGtNqj4Jk3L1yJdWyVvBXBkcWgQXX0WrYUL
         QQ8TkpgMS9bukW0UjShkbDUlT+HsbmNn4uQiKMQr2/IVmtXQB7JDSefDg9huicr6BQB8
         vWsBfGO5NsCoILmn1RqVwKa+8KKCELHxRmKmXFU0U0bfMeIWk4xq3tr8+cyd1M/rP0QM
         o7YiO1N2RcAavzkZ6uuoMXbnvur7G3FtFRArdefOwHBZ0WbdF1sVksmJ73Nu8TSMLOJh
         yk9A==
X-Forwarded-Encrypted: i=1; AJvYcCV6s7d9MtVMVfCNJvt55jo6FA9KgIjXsMr0pZYfv99+I653zI22HjjfwFJ5RdSInLQE6FpdmpX/iE/zdzI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKqOvJJtMIKmudyHdwqK5j3ZtB9jtuzrSWQ7kk71e2TSr9y+7s
	WT9nip711FTVgb4z1Yb7qwvlqP8x+7vw6n+9g7hWElhBzJsy0wg2rzlgk03axCEC+P3av+IlGtD
	EH0N0uGbQ0wTjyxzMRjeRIp5YB5CpsSGkwl0=
X-Gm-Gg: ASbGncvom+Y4g+5KOhyuu3gtPKjFolC5mk3tBzOwddS6prB99nINwy4D3nXKv0ZYNZu
	HRvORMBvPlOgoST15MWHURxADMCZ+VvGDI1fZ8mRPXXy53dSjKUGhsqkCey8Hei34EHdzBy8W8z
	hJ8XZGqmK3svlN5CubozMgy+A=
X-Google-Smtp-Source: AGHT+IGsasYny4HX7AkfjmHKLz/AeaS+A2cp7sxldHFFQq9cWhYyGqvPgHsvOo9UeHod2YDTS9m+WG/XuWusAjOAqnk=
X-Received: by 2002:ad4:4eaf:0:b0:6e6:659d:296 with SMTP id
 6a1803df08f44-6e886879664mr71188866d6.5.1740611810949; Wed, 26 Feb 2025
 15:16:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225213200.729056-1-nphamcs@gmail.com> <Z75_I5q7Qm_oPgMA@google.com>
In-Reply-To: <Z75_I5q7Qm_oPgMA@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 26 Feb 2025 15:16:39 -0800
X-Gm-Features: AQ5f1JpO6T6yzjZ0ZX6F4L_ilnBQKvaKjWzz5wbWmUYQJk0UFPUeeOURG640_uw
Message-ID: <CAKEwX=O=zcNBHaxqj34mZ0Q0OENsbdAOVR3ySW3v-mr--AjScw@mail.gmail.com>
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 6:40=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Tue, Feb 25, 2025 at 01:32:00PM -0800, Nhat Pham wrote:
> > Currently, we crash the kernel when a decompression failure occurs in
> > zswap (either because of memory corruption, or a bug in the compression
> > algorithm). This is overkill. We should only SIGBUS the unfortunate
> > process asking for the zswap entry on zswap load, and skip the corrupte=
d
> > entry in zswap writeback.
>
> It's probably worth adding more details here. For example, how the
> SIGBUS is delivered (it's not super clear in the code), and the
> distinction between handling decompression failures for loads and
> writeback.

Will do :)

>
> >
> > See [1] for a recent upstream discussion about this.
> >
> > [1]: https://lore.kernel.org/all/ZsiLElTykamcYZ6J@casper.infradead.org/
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Suggested-by: Yosry Ahmed <yosryahmed@google.com>
>
> It's Yosry Ahmed <yosry.ahmed@linux.dev> now :P

Oops, will fix :P

>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  mm/zswap.c | 85 +++++++++++++++++++++++++++++++++++++-----------------
> >  1 file changed, 58 insertions(+), 27 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index f6316b66fb23..31d4397eed61 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -62,6 +62,8 @@ static u64 zswap_reject_reclaim_fail;
> >  static u64 zswap_reject_compress_fail;
> >  /* Compressed page was too big for the allocator to (optimally) store =
*/
> >  static u64 zswap_reject_compress_poor;
> > +/* Load and writeback failed due to decompression failure */
>
> Nit: Load or writeback?

Consider it done :)

>
> > +static u64 zswap_reject_decompress_fail;
> >  /* Store failed because underlying allocator could not get memory */
> >  static u64 zswap_reject_alloc_fail;
> >  /* Store failed because the entry metadata could not be allocated (rar=
e) */
> > @@ -953,11 +955,12 @@ static bool zswap_compress(struct page *page, str=
uct zswap_entry *entry,
> >       return comp_ret =3D=3D 0 && alloc_ret =3D=3D 0;
> >  }
> >
> > -static void zswap_decompress(struct zswap_entry *entry, struct folio *=
folio)
> > +static bool zswap_decompress(struct zswap_entry *entry, struct folio *=
folio)
> >  {
> >       struct zpool *zpool =3D entry->pool->zpool;
> >       struct scatterlist input, output;
> >       struct crypto_acomp_ctx *acomp_ctx;
> > +     bool ret =3D true;
> >       u8 *src;
> >
> >       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> > @@ -984,12 +987,19 @@ static void zswap_decompress(struct zswap_entry *=
entry, struct folio *folio)
> >       sg_init_table(&output, 1);
> >       sg_set_folio(&output, folio, PAGE_SIZE, 0);
> >       acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, PAGE_SIZE);
> > -     BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &=
acomp_ctx->wait));
> > -     BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> > +     if (crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &aco=
mp_ctx->wait) ||
> > +                     acomp_ctx->req->dlen !=3D PAGE_SIZE) {
> > +             ret =3D false;
> > +             zswap_reject_decompress_fail++;
> > +             pr_alert_ratelimited(
> > +                     "decompression failed on zswap entry with offset =
%08lx\n",
> > +                     entry->swpentry.val);
> > +     }
>
> This can probably be prettier if we save the return value of
> crypto_wait_req() in a variable, and then do the check at the end of the
> function:
>
> zswap_decompress()
> {
>         mutex_lock();
>         ...
>         ret =3D crypto_wait_req(..);
>         ...
>         mutex_unlock();
>         ...
>         if (ret || acomp_ctx->req->dlen !=3D PAGE_SIZE) {

Hmmmm, do we need the mutex to protect acomp_ctx->req->dlen? No strong
opinions here from my end TBH.

>                 /* SHIT */
>                 return false;
>         }
>         return true;
> }
[...]
>
> We are doing load + erase here and in the writeback path now, so two
> xarray walks instead of one. How does this affect performance? We had a
> similar about the possiblity of doing a lockless xas_load() followed by
> a conditional xas_erase() for zswap_invalidate():
>
> https://lore.kernel.org/lkml/20241018192525.95862-1-ryncsn@gmail.com/
>
> Unfortunately it seems like we can't trivially do that unless we keep
> the tree locked, which we probably don't want to do throughout
> decompression.
>
> How crazy would it be to remove the entry from the tree and re-add it if
> compression fails? Does swapcache_prepare() provide sufficient
> protection for us to do this without anyone else looking at this entry
> (seems like it)?

My concern is, what happens if xa_store() in the re-add path fails
because we do not have enough memory?

>
> Anyway, this is all moot if the second walk is not noticeable from a
> perf perspective.

