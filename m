Return-Path: <linux-kernel+bounces-535146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AA3A46F88
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9246E3AE684
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B4A2620D6;
	Wed, 26 Feb 2025 23:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmNIgpKD"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD782620D5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740613186; cv=none; b=Co8uCi7Iq7spNEHFHE669+MvME0VBNYDV8wPnGalq8WigSdDIwHT25VbgeC4lBuGJ8aRvJsD3/j5sj0InJZiHKM6OpjBHDtwNeuWRC+cca66dZITD3pJYfsOWKRtY/9D4Lxrl4gbNVbtT8h3vOOYuNPEZR3NA+qjSQUYwH9jz7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740613186; c=relaxed/simple;
	bh=AAdMzRItw5u8Z3pq5x6wBuPGuXbIHP7wGRXpr/AiUnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G1rsQSyMfLrQmqlhG0xq6je4lv22kYjskL1W1lAANDgQE300m2S8s2beBRHcJynFB18d9OOIWB0ayHzNo8RGDrImv7R6wXmcFvZY3mAopHTn0Dp8ZyF70IcjqAoh713KgAbrBKVbE1g+V5ah0BbQV76mTNUYDhzR9EMu8Y3mIqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mmNIgpKD; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e891e447dcso4594626d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740613182; x=1741217982; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jO8unIjk6WhFhXXqpZKlfwdKZx7fvG8rKIMB2b/fkqI=;
        b=mmNIgpKDRHc5GWQh21N0zKgtF2DasNtqOUYOp/cVL1L/pwOTge/2jDMhuzcLmnC6Ah
         bqbh1KBzdiVcOqEBuodbEDgrHtrwKPpT5mG9KrITigl9p6+IQhfPBw4K/FXHkBEQV7Gt
         PFpT3B2whkVkv7c67PmdlOWTJw8j8A7huVx8H9I15GO8d3xXmGSI/rDZyk+aZxRrT2Km
         FeSugeTI9Ql88N5SmfrWqayDvr9DpxzLN5KSMjKsAzkMaI/pP/QNhLp8+qboV2eL+vL9
         RGaGdd7RrMMN+l/Y94IHGsjfEbrJRaa0N1oQ3gmuHgRVX7X+aLA63ln4qTKeKDaRxT5n
         WlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740613182; x=1741217982;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jO8unIjk6WhFhXXqpZKlfwdKZx7fvG8rKIMB2b/fkqI=;
        b=Y+C5yYcX8zOn+NAbiK/WTZE3B9QoBK2KOrVSpOmsFh9mFCorRI/t8lvZOSce7Il0Wz
         Kj4B+N0a/amFTKJzmy5jJDjkT8tfXBsu5Ri9sMtEN9jxzU87Ji7XjSOBjTYWZ9adCLl9
         cDE49qjkxgPCljPmNkxnp5jH7Bt9b9tYcYx2oAcIY0pgERFvWNn7RYfxv31rhXELhRw0
         ny2FXxCqu/bV5qfqY2JJboMlDlNC3WByX03fjEnKQ4u/uZHyVYyHeQzhn0nTU84FZU5y
         ifEqoDsKmK/uzSGd49u5cj0UO6cPJ7PFTb6BzarJVUegje408h/ld7WfS9lVOHBPLWj7
         chUQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9SIU0+bbmZG5sB1ldz9BvqhFinS7P2Hv8AZpAp65A4jqtoN1cMwBjfBJ+/JLqxop0MHiHx8C9ENP2AT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNSAG9+DZIRP5Ohc39z5Vkij9+QgTuq3pTVDj2dzOmwOR2Cu2c
	S3eDOTyBPpVKKUg8ro7B7sT9cSenEYAxNs/KE/0++2RlnRjEC8IDxPL5XFrb35fH55xzeq/h9TK
	tPEoitPmhMtrsS/X8No6PXuMhG+s=
X-Gm-Gg: ASbGncv/ygJrsf/HIk9OthIq6GFkk09dchKkRi/bDvcfijwTfNwGOeDgz86ek9kjBYp
	ZiLLqOC7x26fAwH2kwqk7zlqxHlVVpQqLt5U4Czbz5IKPvHxsN5c6TYeuCICPDGsXvywLOLQ4T6
	Ce6LokL+KqJ0iveKxUV0xNgiI=
X-Google-Smtp-Source: AGHT+IEprGxmtQGmRmu8emL/rhRpbJuhtHqqOMlGOnJi4gQe9LbnxKk7r2CKDR6UC1ALFapO9mdvuXGqyqVvy+U9QtI=
X-Received: by 2002:a05:6214:1253:b0:6e4:9b59:d9ce with SMTP id
 6a1803df08f44-6e87ab08f70mr132068366d6.5.1740613182581; Wed, 26 Feb 2025
 15:39:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225213200.729056-1-nphamcs@gmail.com> <20250226005149.GA1500140@cmpxchg.org>
In-Reply-To: <20250226005149.GA1500140@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 26 Feb 2025 15:39:30 -0800
X-Gm-Features: AQ5f1Jpq90G4KonsSQDFYQ3OM0JnJjgykDVZgHkoO8K85t28GIEF2NFohJjyBsI
Message-ID: <CAKEwX=PPFVoXv3BEYMvTUR-_dHCmVXA=CQnnLoNctqnj95Y9iQ@mail.gmail.com>
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, yosryahmed@google.com, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 4:51=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Tue, Feb 25, 2025 at 01:32:00PM -0800, Nhat Pham wrote:
> > Currently, we crash the kernel when a decompression failure occurs in
> > zswap (either because of memory corruption, or a bug in the compression
> > algorithm). This is overkill. We should only SIGBUS the unfortunate
> > process asking for the zswap entry on zswap load, and skip the corrupte=
d
> > entry in zswap writeback.
> >
> > See [1] for a recent upstream discussion about this.
> >
> > [1]: https://lore.kernel.org/all/ZsiLElTykamcYZ6J@casper.infradead.org/
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Suggested-by: Yosry Ahmed <yosryahmed@google.com>
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
> > +static u64 zswap_reject_decompress_fail;
>
> "reject" refers to "rejected store", so the name doesn't quite make
> sense. zswap_decompress_fail?

SGTM :)

>
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
>
> Since this is a pretty dramatic failure scenario, IMO it would be
> useful to dump as much info as possible.
>
> The exact return value of crypto_wait_req() could be useful,
> entry->length and req->dlen too.
>
> entry->pool->tfm_name just to make absolute sure there is no
> confusion, as the compressor can be switched for new stores.
>
> Maybe swp_type() and swp_offset() of entry->swpentry? Those could be
> easy markers to see if the entry was corrupted for example.

I'll include them all :)

>
> > +     }
> >       mutex_unlock(&acomp_ctx->mutex);
> >
> >       if (src !=3D acomp_ctx->buffer)
> >               zpool_unmap_handle(zpool, entry->handle);
> > +     return ret;
> >  }
> >
> >  /*********************************
> > @@ -1018,6 +1028,7 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
> >       struct writeback_control wbc =3D {
> >               .sync_mode =3D WB_SYNC_NONE,
> >       };
> > +     int ret =3D 0;
> >
> >       /* try to allocate swap cache folio */
> >       mpol =3D get_task_policy(current);
> > @@ -1034,8 +1045,8 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
> >        * and freed when invalidated by the concurrent shrinker anyway.
> >        */
> >       if (!folio_was_allocated) {
> > -             folio_put(folio);
> > -             return -EEXIST;
> > +             ret =3D -EEXIST;
> > +             goto put_folio;
> >       }
> >
> >       /*
> > @@ -1048,14 +1059,17 @@ static int zswap_writeback_entry(struct zswap_e=
ntry *entry,
> >        * be dereferenced.
> >        */
> >       tree =3D swap_zswap_tree(swpentry);
> > -     if (entry !=3D xa_cmpxchg(tree, offset, entry, NULL, GFP_KERNEL))=
 {
> > -             delete_from_swap_cache(folio);
> > -             folio_unlock(folio);
> > -             folio_put(folio);
> > -             return -ENOMEM;
> > +     if (entry !=3D xa_load(tree, offset)) {
> > +             ret =3D -ENOMEM;
> > +             goto fail;
> >       }
> >
> > -     zswap_decompress(entry, folio);
> > +     if (!zswap_decompress(entry, folio)) {
> > +             ret =3D -EIO;
> > +             goto fail;
> > +     }
> > +
> > +     xa_erase(tree, offset);
> >
> >       count_vm_event(ZSWPWB);
> >       if (entry->objcg)
> > @@ -1071,9 +1085,14 @@ static int zswap_writeback_entry(struct zswap_en=
try *entry,
> >
> >       /* start writeback */
> >       __swap_writepage(folio, &wbc);
> > -     folio_put(folio);
> > +     goto put_folio;
> >
> > -     return 0;
> > +fail:
> > +     delete_from_swap_cache(folio);
> > +     folio_unlock(folio);
> > +put_folio:
> > +     folio_put(folio);
> > +     return ret;
> >  }
>
> Nice, yeah it's time for factoring out the error unwinding. If you
> write it like this, you can save a jump in the main sequence:
>
>         __swap_writepage(folio, &wbc);
>         ret =3D 0;
> put:
>         folio_put(folio);
>         return ret;
> delete_unlock:
>         delete_from_swap_cache(folio);
>         folio_unlock(folio);
>         goto put;

SGTM :)

>
> >
> >  /*********************************
> > @@ -1600,6 +1619,29 @@ bool zswap_load(struct folio *folio)
> >       if (WARN_ON_ONCE(folio_test_large(folio)))
> >               return true;
> >
> > +     /*
> > +      * We cannot invalidate the zswap entry before decompressing it. =
If
> > +      * decompression fails, we must keep the entry in the tree so tha=
t
> > +      * a future read by another process on the same swap entry will a=
lso
> > +      * have to go through zswap. Otherwise, we risk silently reading
> > +      * corrupted data for the other process.
> > +      */
> > +     entry =3D xa_load(tree, offset);
> > +     if (!entry)
> > +             return false;
>
> The explanation in the comment makes sense in the context of this
> change. But fresh eyes reading this function and having never seen
> that this *used to* open with xa_erase() will be confused. It answers
> questions the reader doesn't have at this point - it's just a function
> called zswap_load() beginning with an xa_load(), so what?
>
> At first I was going to suggest moving it down to the swapcache
> branch. But honestly after reading *that* comment again, in the new
> sequence, I don't think the question will arise there either. It's
> pretty self-evident that the whole "we can invalidate when reading
> into the swapcache" does not apply if the read failed.
>
> > +     /*
> > +      * If decompression fails, we return true to notify the caller th=
at the
> > +      * folio's data were in zswap, but do not mark the folio as up-to=
-date.
> > +      * This will effectively SIGBUS the calling process.
> > +      */
>
> It would be good to put a lampshade on this weirdness that the return
> value has nothing to do with success or not. This wasn't as important
> a distinction, but with actual decompression failures I think it is.
>
> Something like this?
>
>         if (!zswap_decompress(entry, folio)) {
>                 /*
>                  * The zswap_load() return value doesn't indicate success=
 or
>                  * failure, but whether zswap owns the swapped out conten=
ts.
>                  * This MUST return true here, otherwise swap_readpage() =
will
>                  * read garbage from the backend.
>                  *
>                  * Success is signaled by marking the folio uptodate.
>                  */
>                 return true;
>         }

Per Yosry's comment, I'll just move this into zswap_load()'s function
documentation.

>
>         folio_mark_uptodate(folio);
>
> > +     if (!zswap_decompress(entry, folio))
> > +             return true;
> > +
> > +     count_vm_event(ZSWPIN);
> > +     if (entry->objcg)
> > +             count_objcg_events(entry->objcg, ZSWPIN, 1);
> > +
> >       /*
> >        * When reading into the swapcache, invalidate our entry. The
> >        * swapcache can be the authoritative owner of the page and
> > @@ -1612,21 +1654,8 @@ bool zswap_load(struct folio *folio)
> >        * files, which reads into a private page and may free it if
> >        * the fault fails. We remain the primary owner of the entry.)
> >        */
> > -     if (swapcache)
> > -             entry =3D xa_erase(tree, offset);
> > -     else
> > -             entry =3D xa_load(tree, offset);
> > -
> > -     if (!entry)
> > -             return false;
> > -
> > -     zswap_decompress(entry, folio);
> > -
> > -     count_vm_event(ZSWPIN);
> > -     if (entry->objcg)
> > -             count_objcg_events(entry->objcg, ZSWPIN, 1);
> > -
> >       if (swapcache) {
> > +             xa_erase(tree, offset);
> >               zswap_entry_free(entry);
> >               folio_mark_dirty(folio);
> >       }

