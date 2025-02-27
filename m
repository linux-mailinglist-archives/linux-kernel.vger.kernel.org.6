Return-Path: <linux-kernel+bounces-537346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66134A48AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E82337A4257
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E878270EA2;
	Thu, 27 Feb 2025 21:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JymN0/xi"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09AD1CEAA3
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692807; cv=none; b=tTWPRVg90duLMKQG+fyu1k6owsgazVKhqAJxQrAJkjLmxsSwgVbyaXM/Snv+VduQVn2vZxH5K4Xb43I8UnFeEUaPA7w3fn9Q4nCmC8P/CyK2QmN0zaG0267zyvhgB1Wcsotnixj+yczIucbibtDlqDXkGVQyQca18HgUZI4MKII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692807; c=relaxed/simple;
	bh=Cd7r9hdvsQyPMrfVmvFUfRk7ZKtKnu9YlL5YztJhdR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfiI+d1IlgZm6G+XloQk+behh+LDtoEdrUSSEqL3NX+3jSh3cNh02O6oLAzm9L838JJDbj54ZQexfMyn+e19xyh2u1T/Gcepi7p0V8OdKC8uVNzX6cdHoRAWxh8b8E28HMjy2zHlFz+atf19YjGiE2Rg7aFDakfSZBx1kDNszNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JymN0/xi; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7be49f6b331so154787785a.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740692802; x=1741297602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZL8zzCb45AFuRkDUPLgML0Rmw+lZQRdAQIOYM3KKBdg=;
        b=JymN0/xiQld54Qp2vShGDAMuncSboxiXIpemkGyJlPnAe6j3zmRG/fWAA21lMpwm/V
         QexE7vA5+vs2S3a6qZ5zFr+mhuRiOW4BpEUUgaUOACZTkHU+im2jxp4GpAU2CHWKaJ8L
         MRvMFGwUdYS+pF/ovmGOhFg6Ua3MPA/iXr6sxMjwYc6Tqe1yLCZ+qJQd41HzYMLk3bnC
         e2LUM1B9l3iEgbtntsBIcfuKtaCruDZh/qlDIHfw32bqldecmreRGOwT+KiCel/auA/x
         KS9IZj4D9B12C5CmbdXPYiHgsW6N4g/DNZE1JkjNs9xWIpJd9djj9lKKyCPqajYaCTE1
         U8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740692802; x=1741297602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZL8zzCb45AFuRkDUPLgML0Rmw+lZQRdAQIOYM3KKBdg=;
        b=mfTi/+//AB7Bp0KhMV5gcZG+4EAgHSkM/0shwQYcX3sqopYz5Zqzb/LjcOhuScZEqd
         M2pAtEEokC4KvG9NYA6JKrjQy5RWoP/YmJbVauR/Lrq5m0NRfgP5Tf3YxVw/0RPXJLIu
         uRW2z5Y3Xu8IVP8ntkZWSNqxhsBLnBA6+1poTlahPqfjlpxfML1dIpq4Ias7ej+9X46N
         ozvBuaI7kV9beBsXr+LKgn9/cFP7+UTjaCPD/f5qGOug+kndNOVrnsLjVKAmvJoBAN3B
         x0tRrKKlduQIaXSWxtiBy5Ly2nugPO6J3w5gbjCQ4rg1ArmEGlJiFovlHLhr9Ljj+uce
         0YAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL+bCKQSl9u1sbt1nCrObLUFOjvys0CCwRYTqMqOP2E4gWdDP5uLOvvHJOW6AODLjnH9/CSIWxH3ARNCc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+RiNO4qAiyDlj5n7OeSDMPsmw6vvt879+gDppI6+iorofVDHU
	wmdED05J6XP3uXjv+8CYM+5/k2ul+bzg43wA+Z4at4me9dH382qM4fmuRazf/qFJR4znQ8XV9FH
	HntfMMTuZEw+t4fkQuBqtjBCxQqEVQbTN
X-Gm-Gg: ASbGncuiozYrQVGQzHbecW3RhpfyvkOomMxQBV8aLtc9/OF1XKiACUuQw7ddF1qg0NA
	sABz1OudnBh7VnqAB54XvKr28ND0bqmfpPFAb5Jza/Lgdi9UwRGrARuLEev0xTfilChk7haQpQB
	hiMRlC8V/i1G29m704YDDrpQA=
X-Google-Smtp-Source: AGHT+IHV1VCVzr58KTYPEJnYKfegFCFU4Fv7QG0TO7EOPnHQdPziAGdaYvachGBiZX1FWmX0w67aKJdxiVhWHOqN0Ys=
X-Received: by 2002:a05:6214:e88:b0:6e4:f090:3634 with SMTP id
 6a1803df08f44-6e8a0d8faf6mr14568916d6.33.1740692802283; Thu, 27 Feb 2025
 13:46:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227001445.1099203-1-nphamcs@gmail.com> <Z7-9o81kBfw4tFSz@google.com>
In-Reply-To: <Z7-9o81kBfw4tFSz@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 27 Feb 2025 13:46:29 -0800
X-Gm-Features: AQ5f1JqIMDgGka-Xqsa3dIsLbDldvDQ8kuWf5o1kbPKDvT6Jex6OrJTRWbzwSI8
Message-ID: <CAKEwX=MR7bhebu+7qnoUrADL0C2Uqi3Ta7Beo=s0Aim28BSDVw@mail.gmail.com>
Subject: Re: [PATCH v2] zswap: do not crash the kernel on decompression failure
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	linux-mm@kvack.org, kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 5:19=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On Wed, Feb 26, 2025 at 04:14:45PM -0800, Nhat Pham wrote:
> > Currently, we crash the kernel when a decompression failure occurs in
> > zswap (either because of memory corruption, or a bug in the compression
> > algorithm). This is overkill. We should only SIGBUS the unfortunate
> > process asking for the zswap entry on zswap load, and skip the corrupte=
d
> > entry in zswap writeback. The former is accomplished by returning true
> > from zswap_load(), indicating that zswap owns the swapped out content,
> > but without flagging the folio as up-to-date. The process trying to swa=
p
> > in the page will check for the uptodate folio flag and SIGBUS (see
> > do_swap_page() in mm/memory.c for more details).
>
> We should call out the extra xarray walks and their perf impact (if
> any).

Lemme throw this in a quick and dirty test. I doubt there's any
impact, but since I'm reworking this patch for a third version anyway
might as well.

>
> >
> > See [1] for a recent upstream discussion about this.
> >
> > [1]: https://lore.kernel.org/all/ZsiLElTykamcYZ6J@casper.infradead.org/
> >
> > Suggested-by: Matthew Wilcox <willy@infradead.org>
> > Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  mm/zswap.c | 94 ++++++++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 67 insertions(+), 27 deletions(-)
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 6dbf31bd2218..e4a2157bbc64 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -62,6 +62,8 @@ static u64 zswap_reject_reclaim_fail;
> >  static u64 zswap_reject_compress_fail;
> >  /* Compressed page was too big for the allocator to (optimally) store =
*/
> >  static u64 zswap_reject_compress_poor;
> > +/* Load or writeback failed due to decompression failure */
> > +static u64 zswap_decompress_fail;
> >  /* Store failed because underlying allocator could not get memory */
> >  static u64 zswap_reject_alloc_fail;
> >  /* Store failed because the entry metadata could not be allocated (rar=
e) */
> > @@ -996,11 +998,13 @@ static bool zswap_compress(struct page *page, str=
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
> > +     int decomp_ret;
> > +     bool ret =3D true;
> >       u8 *src;
> >
> >       acomp_ctx =3D acomp_ctx_get_cpu_lock(entry->pool);
> > @@ -1025,12 +1029,25 @@ static void zswap_decompress(struct zswap_entry=
 *entry, struct folio *folio)
> >       sg_init_table(&output, 1);
> >       sg_set_folio(&output, folio, PAGE_SIZE, 0);
> >       acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, PAGE_SIZE);
> > -     BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &=
acomp_ctx->wait));
> > -     BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> > +     decomp_ret =3D crypto_wait_req(crypto_acomp_decompress(acomp_ctx-=
>req), &acomp_ctx->wait);
> > +     if (decomp_ret || acomp_ctx->req->dlen !=3D PAGE_SIZE) {
> > +             ret =3D false;
> > +             zswap_decompress_fail++;
> > +             pr_alert_ratelimited(
> > +                     "decompression failed with returned value %d on z=
swap entry with swap entry value %08lx, swap type %d, and swap offset %lu. =
compression algorithm is %s. compressed size is %u bytes, and decompressed =
size is %u bytes.\n",
>
> This is a very long line. I think we should break it into multiple
> lines. I know multiline strings are frowned upon by checkpatch, by this
> exist (see the warning in mem_cgroup_oom_control_write() for example),
> and they are definitely better than a very long line imo.

My personal take is I prefer multi line strings, but was not sure what
is the "preferred" or "official" style. Oh well.

>
> > +                     decomp_ret,
> > +                     entry->swpentry.val,
> > +                     swp_type(entry->swpentry),
> > +                     swp_offset(entry->swpentry),
> > +                     entry->pool->tfm_name,
> > +                     entry->length,
> > +                     acomp_ctx->req->dlen);
> > +     }
> >
> >       if (src !=3D acomp_ctx->buffer)
> >               zpool_unmap_handle(zpool, entry->handle);
> >       acomp_ctx_put_unlock(acomp_ctx);
> > +     return ret;
>
> Not a big deal but we could probably store the length in a local
> variable and move the check here, and avoid needing 'ret'.

Ah the suggestion you made in an older version right? But sounds like
we're just trading some one local variable for another?

That said, it *technically* move some work outside of the lock
section. I'll just give it a try :)

>
> >  }
> >
> >  /*********************************
> > @@ -1060,6 +1077,7 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
> >       struct writeback_control wbc =3D {
> >               .sync_mode =3D WB_SYNC_NONE,
> >       };
> > +     int ret =3D 0;
> >
> >       /* try to allocate swap cache folio */
> >       si =3D get_swap_device(swpentry);
> > @@ -1081,8 +1099,8 @@ static int zswap_writeback_entry(struct zswap_ent=
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
> > @@ -1095,14 +1113,17 @@ static int zswap_writeback_entry(struct zswap_e=
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
> > +             goto delete_unlock;
> > +     }
> > +
> > +     if (!zswap_decompress(entry, folio)) {
> > +             ret =3D -EIO;
> > +             goto delete_unlock;
> >       }
> >
> > -     zswap_decompress(entry, folio);
> > +     xa_erase(tree, offset);
> >
> >       count_vm_event(ZSWPWB);
> >       if (entry->objcg)
> > @@ -1118,9 +1139,14 @@ static int zswap_writeback_entry(struct zswap_en=
try *entry,
> >
> >       /* start writeback */
> >       __swap_writepage(folio, &wbc);
> > -     folio_put(folio);
> >
> > -     return 0;
> > +put_folio:
> > +     folio_put(folio);
> > +     return ret;
> > +delete_unlock:
> > +     delete_from_swap_cache(folio);
> > +     folio_unlock(folio);
> > +     goto put_folio;
>
> I think I suggested a way to avoid this goto in v1:
> https://lore.kernel.org/lkml/Z782SPcJI8DFISRa@google.com/.
>
> Did this not work out?

Oh I thought your suggestion was the same as Johannes. Let me take a
closer look...

>
> >  }
> >
> >  /*********************************
> > @@ -1620,6 +1646,20 @@ bool zswap_store(struct folio *folio)
> >       return ret;
> >  }
> >
> > +/**
> > + * zswap_load() - load a page from zswap
> > + * @folio: folio to load
> > + *
> > + * Returns: true if zswap owns the swapped out contents, false otherwi=
se.
> > + *
> > + * Note that the zswap_load() return value doesn't indicate success or=
 failure,
> > + * but whether zswap owns the swapped out contents. This MUST return t=
rue if
> > + * zswap does own the swapped out contents, even if it fails to write =
the
> > + * contents to the folio. Otherwise, the caller will try to read garba=
ge from
> > + * the backend.
> > + *
> > + * Success is signaled by marking the folio uptodate.
> > + */
> >  bool zswap_load(struct folio *folio)
> >  {
> >       swp_entry_t swp =3D folio->swap;
> > @@ -1644,6 +1684,17 @@ bool zswap_load(struct folio *folio)
>
> The comment that exists here (not visible in the diff) should be
> abbreviated now that we already explained the whole uptodate thing
> above, right?

Lemme take a stab at it :)

>
> >       if (WARN_ON_ONCE(folio_test_large(folio)))
> >               return true;
> >
> > +     entry =3D xa_load(tree, offset);
> > +     if (!entry)
> > +             return false;
> > +
>
> A small comment here pointing out that we are deliberatly not setting
> uptodate because of the failure may make things more obvious, or do you
> think that's not needed?

I was thinking the comment above zswap_load() should be necessary, but
a small comment here won't hurt.

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
> > @@ -1656,21 +1707,8 @@ bool zswap_load(struct folio *folio)
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
> > @@ -1771,6 +1809,8 @@ static int zswap_debugfs_init(void)
> >                          zswap_debugfs_root, &zswap_reject_compress_fai=
l);
> >       debugfs_create_u64("reject_compress_poor", 0444,
> >                          zswap_debugfs_root, &zswap_reject_compress_poo=
r);
> > +     debugfs_create_u64("decompress_fail", 0444,
> > +                        zswap_debugfs_root, &zswap_decompress_fail);
> >       debugfs_create_u64("written_back_pages", 0444,
> >                          zswap_debugfs_root, &zswap_written_back_pages)=
;
> >       debugfs_create_file("pool_total_size", 0444,
> >
> > base-commit: 598d34afeca6bb10554846cf157a3ded8729516c
> > --
> > 2.43.5

