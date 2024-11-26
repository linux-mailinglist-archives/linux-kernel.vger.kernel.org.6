Return-Path: <linux-kernel+bounces-422626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC809D9C1F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE624164BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210471DA0F1;
	Tue, 26 Nov 2024 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rnQh5BR4"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93EA1D9320
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732641037; cv=none; b=TIZtK9jEdKLI0Nj5gPacXlfudduML4g06AAwiYZVL/j7lZItyiImxaDktQka30SqEn4fkAiTHbfERgl8615JA91CM7SUnPMLb4uDrgY/ebRy8QdyuEMT9pzBXSqEAKZ7MX+61VInPZCtB2qhDvjTon/WkyAsbZGXXp9VzG3y6dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732641037; c=relaxed/simple;
	bh=ZadRCC8tqLysiaMrkETTX6zNuqvKdYsEzZ/9YqDrh/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=czZ+5Wa2diTbe02G9l//PXnw8N0X2mthTxYgltaoFubd1Sf+fVj0k5PBQ/qlkf54RS0qKfdfjrfcKUrpUkzjk4Oi23AktNZV8jIc6ncQp9KE+3jhoYNzcnhkrCHOsmcxuBDb+Kq0iuEXOpydIYS4mK6q3mc6ITbJ9CQYnpFlO/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rnQh5BR4; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-466ab386254so207791cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 09:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732641034; x=1733245834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8U/hFBjG8qULz+0EjdB4XUzx545IeyejaR/l6dTWKk=;
        b=rnQh5BR4NH5fysrE7H9T39yXjgOsl9tnF82bfBECgoibFoTfHYjuB4HFp5v5wXaL9I
         tiHUaya+QCMI7t0P6qjzh6bMLK/QXtvIOaVs3Cisp5VZXkYMbUAwBJ6FxeqDa38RKNVT
         HEM3IfWy54UMk/iAzuT97BsEelDrhu5RRKYhrAVDwIrxuAQMjR27FX/JY9TK/OnG4wat
         WoBKre2kdwYv0ZpSnxKoIvYoBBHWVyNMi6NhtnejkvBQpFV5OMj+aLxCB3cYMvPKz9Q0
         ukLJ9QmRaUPquY/v/h23gy0hwk7k8AEEG84Qda8yhJKEd6SC70Hll+6XwDSt+qwwk1Wl
         l8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732641034; x=1733245834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E8U/hFBjG8qULz+0EjdB4XUzx545IeyejaR/l6dTWKk=;
        b=XHPxrcgEnZwi2voImmBvsEEjkjpd9v+3vvwl4Cf+O9J+rf/LW+m+2WU2MNPOUcD4sq
         fQGUdIGGAn0G/oy/wlxfEhqyOl+PH4aOPVoH6qkm8PKw1rWvjfcX+jB9/Bc7CSTv26+g
         ltRXopEutog8SY0A9tx6653II7mDn/q/WlyIhii/ck399mzwajFA1r8bgQyG96Dn2WKV
         nTaVXsNkvxFasxd2FBEbaNC8/pluUfxLz3+KtkV+8jaZEfFFLHBctjkrUR0DdJ4eVlYl
         cNWqJna0U8z7R6TI4mvWU9/DLKnY9xnm/lbSpyKxYGifSv8MwJDzHEgprqHdfqngsx6w
         Dyew==
X-Forwarded-Encrypted: i=1; AJvYcCXQ+s0blTx8rOjBeU4PNUKnSNlZphjN8j9dLH2QS9ni5V0Yu18RmGYfiOkebiwwe6BPYIxAiUM+XUeTobs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyneKFXm2GoboWSByI7DqJ4CApFnusMHE7Fyu146tih6RZIPNw1
	jgHRqXLKUoyS8iAj7aHcGQRr2/2I1cRgVhg4VrpsN10ppQ8IhBZfgz7DNqu391A5ps8vVBTPjuq
	JA9et2y6Tyjkq/ksMxJe4UJwPIx+DGVFKGVou6Z6UCL/6KA1ndFblL8c=
X-Gm-Gg: ASbGncvYbTzsGfRnaZMm8dTDhnAVVIdbRJmgqHjPolbfwzfX9W2YLyUj+pP2w+YNScS
	RPHhTItR5a5Ld9hieHOFkQZHqiitpe6vCfZsHCWCZ4I0uEiNwL5zfFJrgCDaH4A==
X-Google-Smtp-Source: AGHT+IE7Qo5YquEhKeActaNEVW8aKR/6pVLZrbUpuoLWfXQZ4aMCF5bLyja5g54P+1GZYvfvqhOLAcQHtLZAOLXx5Jc=
X-Received: by 2002:a05:622a:2996:b0:466:91fd:74c4 with SMTP id
 d75a77b69052e-466a46b99edmr3849211cf.0.1732641034218; Tue, 26 Nov 2024
 09:10:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241124074318.399027-1-00107082@163.com> <CAJuCfpHviS-pw=2=BNTxp1TnphjuiqWGgZnq84EHvbz08iQ6eg@mail.gmail.com>
 <70bad55f.b656.19362cca6ee.Coremail.00107082@163.com> <CAJuCfpHho8se-f4cnvk0g1YLNzhvG3q8QTYmvMmweUnGAhtA=g@mail.gmail.com>
 <CAJuCfpEP-xMzHonsE3uV1uYahXehR007B5QX9KjdZdHBWyrXwQ@mail.gmail.com>
 <51c19b31.eaf.193660912f7.Coremail.00107082@163.com> <337c721a.70d1.1936753c377.Coremail.00107082@163.com>
In-Reply-To: <337c721a.70d1.1936753c377.Coremail.00107082@163.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Nov 2024 09:10:23 -0800
Message-ID: <CAJuCfpHZhMwK8jOz_evvvD8CaNxxaaRQEx0Qv_yPp4ZA_DkXeg@mail.gmail.com>
Subject: Re: Abnormal values show up in /proc/allocinfo
To: David Wang <00107082@163.com>
Cc: kent.overstreet@linux.dev, linux-kernel@vger.kernel.org, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 11:17=E2=80=AFPM David Wang <00107082@163.com> wrot=
e:
>
> Hi,
>
>
> At 2024-11-26 09:14:50, "David Wang" <00107082@163.com> wrote:
> >
> >Hi,
> >
> >
> >
> >At 2024-11-26 04:31:39, "Suren Baghdasaryan" <surenb@google.com> wrote:
> >>
> >>Hi David,
> >>Could you please check if you have this fix:
> >>
> >>ed265529d39a "mm/codetag: fix arg in pgalloc_tag_copy alloc_tag_sub"
> >>
> >>It was merged after v6.12-rc6 and it fixes an accounting bug inside
> >>pgalloc_tag_copy(), which is used during compaction.
> >>Thanks,
> >>Suren.
> >>
> >>
> >>https://lore.kernel.org/all/20240906042108.1150526-3-yuzhao@google.com/
> >>https://lore.kernel.org/all/20241022232440.334820-1-souravpanda@google.=
com/
> >
> >
> >No, ed265529d39a is not in 6.12.0; It is now in Linus' tree.
> >I will pull the code and make some tests.
> >
> >Will update later.
>
>
> I build a kernel based on a tree with top commit 9f16d5e6f220,
> no abnormal value observed for compaction_alloc:
>
> $ sudo cat /proc/allocinfo  | grep compaction_alloc
>            0        0 mm/compaction.c:1880 func:compaction_alloc 250098
> (The last column is accumulative call counters I patched with my system, =
meaning compaction_alloc do happen)
>
>
> But,  still got underflowed values:
>
>        -4096 18446744073709551615 mm/filemap.c:3788 func:do_read_cache_fo=
lio 18
>    -86241280 18446744073709530561 mm/filemap.c:1951 func:__filemap_get_fo=
lio 8691015
>
> Finally a procedure to reproduce it:  (thanks for the tip about compact_m=
emory)
> 1. populate file caches, e.g. grep something in kernel source.
> 2. echo 1 >/proc/sys/vm/compact_memory
> 3. echo 3 > /proc/sys/vm/drop_caches
>
> There would be negative values show up.
> A simple python script to check abnormal values:
>
> with open("/proc/allocinfo") as f:
>     for l in f:
>         try:
>             vs  =3D l.split()
>             v1, v2 =3D int(vs[0]), int(vs[1])
>             if v1<0 or v2<0 or (v1=3D=3D0 and v2!=3D0) or (v1!=3D0 and v2=
=3D=3D0): print l,
>         except: pass
>
>
> Most likely, memory release is accounted *twice* for those memory.
> Reading through the code, I feel the most suspected code would be:
>     clear_page_tag_ref(&old->page);
> This line of code may not work as expected.
>
> The code in pgalloc_tag_copy involves too many low level plumbing details=
, I think it
> is simpler to just implement a *swap* logic: just swap the tags.
>
> I made following changes and it works, no abnormal values detected, so fa=
r.
> (pgalloc_tag_copy should be renamed to pgalloc_tag_swap)
>
>
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 2414a7ee7ec7..7d6d1015f4b1 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -191,24 +192,30 @@ void pgalloc_tag_split(struct folio *folio, int old=
_order, int new_order)
>
>  void pgalloc_tag_copy(struct folio *new, struct folio *old)
>  {
> -       union pgtag_ref_handle handle;
> -       union codetag_ref ref;
> -       struct alloc_tag *tag;
> +       union pgtag_ref_handle handle_new, handle_old;
> +       union codetag_ref ref_new, ref_old;
> +       struct alloc_tag *tag_new, *tag_old;
>
> -       tag =3D pgalloc_tag_get(&old->page);
> -       if (!tag)
> +       tag_old =3D pgalloc_tag_get(&old->page);
> +       if (!tag_old)
> +               return;
> +       tag_new =3D pgalloc_tag_get(&new->page);
> +       if (!tag_new)
>                 return;
>
> -       if (!get_page_tag_ref(&new->page, &ref, &handle))
> +       if (!get_page_tag_ref(&old->page, &ref_old, &handle_old))
> +               return;
> +       if (!get_page_tag_ref(&new->page, &ref_new, &handle_new))
>                 return;
>
> -       /* Clear the old ref to the original allocation tag. */
> -       clear_page_tag_ref(&old->page);
> -       /* Decrement the counters of the tag on get_new_folio. */
> -       alloc_tag_sub(&ref, folio_size(new));
> -       __alloc_tag_ref_set(&ref, tag);
> -       update_page_tag_ref(handle, &ref);
> -       put_page_tag_ref(handle);
> +       /* swap tag */
> +       __alloc_tag_ref_set(&ref_new, tag_old);
> +       update_page_tag_ref(handle_new, &ref_new);
> +       put_page_tag_ref(handle_new);
> +
> +       __alloc_tag_ref_set(&ref_old, tag_new);
> +       update_page_tag_ref(handle_old, &ref_old);
> +       put_page_tag_ref(handle_old);
>  }

Hi David,
Thanks for the investigation. I think your suggestion should work fine
and it's simpler than what we do now. It will swap not only counters
but allocation locations as well, however I think we already do that
when we call __alloc_tag_ref_set(). So, instead of clearing the
original tag, decrementing the new tag's counter (to compensate for
its own allocation) and reassigning the old tag to the new counter,
you simply swap the tags. That seems fine to me.
However I think there is still a bug where some get_new_folio()
callback does not increment the new folio's counters and that's why we
get an underflow when calling alloc_tag_sub(). I'll try to reproduce
on my side and see what's going on there.
Thanks,
Suren.

>
>  static void shutdown_mem_profiling(bool remove_file)
>
>
>
> FYI
> David
>
>
> >
> >Thanks~
> >David
> >
> >>
> >>> > >Thanks,
> >>> > >Suren.
> >>> > >
> >>> > >>
> >>> > >>
> >>> > >> Thanks
> >>> > >> David
> >>> > >>
> >>> > >>
> >>> > >>
> >>> > >>

