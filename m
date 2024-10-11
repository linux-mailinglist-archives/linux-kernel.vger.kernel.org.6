Return-Path: <linux-kernel+bounces-360438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6DD999AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A8841C222CA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 03:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05941F4FA0;
	Fri, 11 Oct 2024 03:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zz4t+a0v"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912CD1F12FE
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728616191; cv=none; b=F0h2+yzOGKemw3Six81TFbYWPDwZIlHcDmGIPSZ8SXR8JS2wnAHUGUP/Nq2fJJ9JfjiTk0SZu909Jzea17fwAIb+b9TKKaqR6/dN211eCc7RkvryDQ4MENbxFLSVv06a5OUIM7m/k7PS8TgUssoC1ASXxSbnsJSCYOfrvhtbVIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728616191; c=relaxed/simple;
	bh=alcmVUgoUxdu8OY7jYdhL5KVlAPkwbib6fnQhPPkYwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RrUhlCneen1J0PlN5ZStvowDbum5L6PBI1zMxhzhGpxZPMOoV2MoOYT6F4BJxPgd1l4gzwlDwM2MgaKLQsZyMGZrjm27tX8kOKvFmSf4C9g3Bkz2GrVYFoHpbnHVLgu+gfHJUFUdfFkWNIWw6ckJki6Q0Ojk21chLMS5goZyGKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zz4t+a0v; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4a28a1ae1adso576892137.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 20:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728616188; x=1729220988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udnYCGSNeKADzrq1R1SEMPbR8YcRKbRdLO95ou+kYxY=;
        b=Zz4t+a0vTYila1b4i0/H/rIgyBaG0+kO1oEOAE7evbTfkh6seEIlbZoClyb0PIg0hj
         ryhxZ2a/P+/3tASptYN5SLN5oE5cm/amBVC7/Vv6OM4rgj6rY/s7oRir/gT3puP0SD4q
         JvZ7kWPeqtNV7QEBrQM+xo84QxK7OAU0AO0LaD9DW5NnJ6lyBIaxYA46oND5b2NS00EK
         Fehgm5S6kRWH8s74J/Typ7LOFNdSi2QwgyeJIgfVex1KdNsuOHlCc44ZhE6YdeZGzCBa
         UHMbx4k2xdFHydVzPxlJJHO3BOP8gDTBKVOVcLMQeJHsFRx2Jk4D9UMKedebFoQ7rLfR
         VCgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728616188; x=1729220988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udnYCGSNeKADzrq1R1SEMPbR8YcRKbRdLO95ou+kYxY=;
        b=S08StiUrwrlPAKgA/iO4GmEDwwA1qfVcmEDTLOfeH5XfPWCQlNF+NsO9vqdOZviE2k
         643k1gWc7/3yo8h+ojrhghjh6/H80u8zB1Jcb47GOFo1NIwIo+brtnSeK1R3C9lxTCbp
         0Accf3ipbaZes0WXTrcCfth6R4v1YrSPxQ4aodxDjYgHCEPvNrgw5IPw3ptUH3yMe9Gq
         AxoWZVi5XdhuAKuNRq4yEMuGXKY6Sv+hblQORsUZRX0f8TGV+L3QHSE4m5AqseJ9CtJu
         iQF5PFRZEwqRT5HLybEh8uHgaDWH3RjkWW6CkfI+l7aaulOSMSnJ94bt1io3XOJcc1/O
         Y+RA==
X-Forwarded-Encrypted: i=1; AJvYcCX93HBKJ1ea6B3YX0QjPP2HCuZaDF5giLbZejJ5eop/WBt53DFoOTJuS/zmAS2g64yOXTfo7uH2eaE0ltA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUr4mJs41ZgWv6ROHbOntfsS/Zv7X8+oy2++2/OCIkkAY1kcby
	7Xsq41e0tn9qpmruj0D908oOUun0m+Mj+Ckjo9o8t8aYnTDLaH/xnnZK2YvErd+RFezIKq1reA7
	ctqDLrNQEgZCc6zmsLMfhloFzLeejGYOurWIn
X-Google-Smtp-Source: AGHT+IFzSuvjXE/pB0ZdVAl2P9GCoblSOO0DQVW0NM0BU4qyEwd2xx639gJZXnoibouFQrFlCeKxEvhvyh6Bz6ZYhlw=
X-Received: by 2002:a05:6102:50a6:b0:4a3:be26:b1be with SMTP id
 ada2fe7eead31-4a465a709ccmr1281993137.18.1728616188151; Thu, 10 Oct 2024
 20:09:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930063912.196526-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240930063912.196526-1-zhaoyang.huang@unisoc.com>
From: Yu Zhao <yuzhao@google.com>
Date: Thu, 10 Oct 2024 21:09:09 -0600
Message-ID: <CAOUHufaDPcw7Dc95kgCXM04OhnSWKkZMhMCBAMXToj-=5dt3Gg@mail.gmail.com>
Subject: Re: [PATCH] mm: deal with active/inactive inversion in lru_gen_is_active
To: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Zhaoyang Huang <huangzhaoyang@gmail.com>, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 12:39=E2=80=AFAM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> All gens will be deemed as active by lru_gen_is_active when there are
> only two generations within the node, which could have the folios
> to be active in the belowing scenarios. This commit would like to
> solve this by judging if numbers of file type gens greater than two
> since anon gens could be remains as 3

> when swap is constrained

Technically, yes. But this patch doesn't detect whether swap is
constrained or not. Even if it did, I don't think it would matter
because no one should care about active/inactive anon when swap is
permanently disabled. One could argue the temporary case, but then why
would/should we care about a transient condition if that's the problem
you are trying to solve?

Most importantly, this breaks the proactive aging via the debugfs
interface, which can override swappiness (swap being disabled).

> and file
> type seq advanced by 1.
>
> 1. New folios after migration done.
> 2. Dropped folios from none-reclaiming context(drop_cache, madvise)
>    when they are failed of being reclaimed and go back to lru.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  include/linux/mm_inline.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 6f801c7b36e2..5e4017dbec96 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -165,11 +165,16 @@ static inline int folio_lru_gen(struct folio *folio=
)
>  static inline bool lru_gen_is_active(struct lruvec *lruvec, int gen)
>  {
>         unsigned long max_seq =3D lruvec->lrugen.max_seq;
> +       unsigned long min_seq =3D lruvec->lrugen.min_seq[LRU_GEN_FILE];
>
>         VM_WARN_ON_ONCE(gen >=3D MAX_NR_GENS);
>
> -       /* see the comment on MIN_NR_GENS */
> -       return gen =3D=3D lru_gen_from_seq(max_seq) || gen =3D=3D lru_gen=
_from_seq(max_seq - 1);
> +       /* see the comment on MIN_NR_GENS
> +        * judge if there is active/inactive inversion by the number of f=
ile
> +        * type gens.
> +        */
> +       return gen =3D=3D lru_gen_from_seq(max_seq) ||
> +               max_seq - min_seq >=3D 2 ? gen =3D=3D lru_gen_from_seq(ma=
x_seq - 1) : 0;
>  }
>
>  static inline void lru_gen_update_size(struct lruvec *lruvec, struct fol=
io *folio,
> --
> 2.25.1
>
>

