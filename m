Return-Path: <linux-kernel+bounces-417549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 580429D5583
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB70E1F2474D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7B01DE2B6;
	Thu, 21 Nov 2024 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfplOAE2"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2805695;
	Thu, 21 Nov 2024 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732228364; cv=none; b=HRRQlJWSzobYtnxoXMOsnLwDPyPBsUs52dwsyyzcUyNT9oX2ZPnYrPYlZ7OqJCa6K9in81egXy9UXfnhUQgiwWrnaXedMPk4/gEgDMDlfZN4OLSinRS4IH+N95NZhEvsIl+3zNFSzzm0dZpltieIGpFf+E1gkdD3fedQ+h5YCZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732228364; c=relaxed/simple;
	bh=MWEu9cfHsGXDOOV+9gWbv6oRO8BAoH5LyyrcIXWo1DY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IcKnlhRmrtD9ijj0sd62Vad7QqilBZNs+S+4peLBrcvh2yjgRYvHpieDTzeWs9U8WM3aRP7mgJHBg25LWAN/4B2q9Ase3QyDdC7pZuJdQObHvBH19GoE4+RnJvXXzrm4BDT1UwXetggyLTtQnA6Nd7SJIIOCQ83C42nZnVfT8+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfplOAE2; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-856ec390e30so535001241.0;
        Thu, 21 Nov 2024 14:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732228360; x=1732833160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fecMMpAR9aqzU6pxDcgMObsjfCOyyy7qj+VlEzyRjtk=;
        b=bfplOAE2EUYbEN8MDTAhhWArb2WChQnHqJ92vDTRo3hZz2yn2OyO2csfz7Yo1KckDg
         7hXxBsUXZvryRNNz9xRyYOuX+43OmKOcOKiqbks/QW7sg8YNZb1U97mqKMBtcJqXb4NF
         /HUQYJAuuuXzSsTA9va2JS02SkYpa3eF3Yz4BE9Qv97TdiSNRFh3xT1Zx6ygpve0aYUz
         DKR2zhC58ZaWkKoy7/gdK7LonjmYPAI7Pmr5FdQW60c2MQzfplTOmFrsdNFEfK1sCCme
         EJYoIqPXqfqKQv1nUWseTg7/8RCs41kXwdpXnDikbFgitRp4ohnChtTfbhwRH2kBLwqQ
         YnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732228360; x=1732833160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fecMMpAR9aqzU6pxDcgMObsjfCOyyy7qj+VlEzyRjtk=;
        b=P/2ahm+qXSxWbTfJrmLvIz7Pvh5NhTmXHc9NBca1Eb3EkVKf/vjwT4cFzDD2fn5AKJ
         4NFiG0KcxNHX0A7OHjfoiysXPRrAkOF7ns6PZX2PHViHfFSeOQOq2J0tWyxSSJUyUv6+
         Ztsea2PQzthBQBl8HhtDwBNbh+8iGGjz5p4Nfepu31SU2hLQ05kV467WN8nUTJeGhLwe
         GNgBzGP9pNZ6F1jdNrVhgYl8CkYp4vs5kxWEO2PaXyg6mH4jkSaTGCP8JjDDcTZfXRzN
         PHEJJSjim/zo6BpYu+AIaNhCvPTNimQQWhPXS3FzrBWLzl+y0zK6+phB63mdbAe9VeoA
         +N5A==
X-Forwarded-Encrypted: i=1; AJvYcCU7vbekv5w+Sl8+aJfy8gYMeeEvxGXkRBjht508SrF7uPUe1X7O3NH6KKY8XguxscRWLjwgxCX1gY+BMPCo@vger.kernel.org, AJvYcCXI/uDgA7uhCOnjJdJHKHElUhj4s631iPicEVWBr9U+tOXQ1EazzJSS6Gs/0aYnh5OEQsTIzyL9kKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFYsZYEFZe2dpm71ed+f4U+zeR3Qd+6ATr1iDw3nUBeUyE8DaB
	TozKq0/9ET9na16PmR7FYqWoJ4bxt/JcYi8K2RqDwK0iFXUW3Mbq2lpFSsozII4WSH1mUFlKoGl
	3N/r0Ff1GUwMsfVTkIb4CCl+YI8s=
X-Gm-Gg: ASbGncsvL8Spb+aYDHy2AtAmbRY0Cq2TG4EtdDC/ZMhAy/7UrYGnmweCQfk4HwMo/Hh
	WfAiR21Fr1cjfWYx/gQGr1LHwfAT9NVVpcpjiHXWrpuREMTWDCXiim9KHttmVUWXrOg==
X-Google-Smtp-Source: AGHT+IGgunDBgS+MIXIJS8JIq4LltSSNvVyN5cWRKL8zjPcJ8TkEBGYXARRTDgIkpQoqzFsDekilngXfYGJ4SmNAiPs=
X-Received: by 2002:a05:6122:4b1a:b0:50d:66e1:826c with SMTP id
 71dfb90a1353d-51500ae1095mr632049e0c.11.1732228360131; Thu, 21 Nov 2024
 14:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121162735.9558-1-haowenchao22@gmail.com>
In-Reply-To: <20241121162735.9558-1-haowenchao22@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 22 Nov 2024 11:32:29 +1300
Message-ID: <CAGsJ_4yA-jaeUG-4i7eWwnrv1=P7ujivYq37btOFg8LwnhQAmw@mail.gmail.com>
Subject: Re: [PATCH] mm: add per-order mTHP swap-in fallback counters
To: Wenchao Hao <haowenchao22@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Usama Arif <usamaarif642@gmail.com>, 
	Lance Yang <ioworker0@gmail.com>, Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 22, 2024 at 5:28=E2=80=AFAM Wenchao Hao <haowenchao22@gmail.com=
> wrote:
>
> Now large folio swap-in is supported, but we do not have a method
> to analyze the success ratio of large folio swap-ins. Similar to
> anon_fault_fallback, we add a per-order mTHP swpin_fallback to help
> calculate the success ratio. The new counter is located at:
>
> /sys/kernel/mm/transparent_hugepage/hugepages-<size>/stats/swpin_fallback

Well,  this could be useful for profiling, but why not also add
MTHP_STAT_SWPIN_FALLBACK_CHARGE ?

>
> Signed-off-by: Wenchao Hao <haowenchao22@gmail.com>
> CC: Chuanhua Han <hanchuanhua@oppo.com>
> ---
>  Documentation/admin-guide/mm/transhuge.rst | 5 +++++
>  include/linux/huge_mm.h                    | 1 +
>  mm/huge_memory.c                           | 3 +++
>  mm/memory.c                                | 1 +
>  4 files changed, 10 insertions(+)
>
> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/a=
dmin-guide/mm/transhuge.rst
> index 5034915f4e8e..f5c775457913 100644
> --- a/Documentation/admin-guide/mm/transhuge.rst
> +++ b/Documentation/admin-guide/mm/transhuge.rst
> @@ -561,6 +561,11 @@ swpin
>         is incremented every time a huge page is swapped in from a non-zs=
wap
>         swap device in one piece.
>
> +swpin_fallback
> +       is incremented if a huge page swapin fails to allocate a huge pag=
e
> +       and instead falls back to using huge pages with lower orders or
> +       small pages.
> +
>  swpout
>         is incremented every time a huge page is swapped out to a non-zsw=
ap
>         swap device in one piece without splitting.
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index b94c2e8ee918..dcf08f8fdf52 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -121,6 +121,7 @@ enum mthp_stat_item {
>         MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
>         MTHP_STAT_ZSWPOUT,
>         MTHP_STAT_SWPIN,
> +       MTHP_STAT_SWPIN_FALLBACK,
>         MTHP_STAT_SWPOUT,
>         MTHP_STAT_SWPOUT_FALLBACK,
>         MTHP_STAT_SHMEM_ALLOC,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ee335d96fc39..6b089a41acef 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -617,6 +617,7 @@ DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_=
ANON_FAULT_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_F=
ALLBACK_CHARGE);
>  DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>  DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
> +DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
>  DEFINE_MTHP_STAT_ATTR(swpout, MTHP_STAT_SWPOUT);
>  DEFINE_MTHP_STAT_ATTR(swpout_fallback, MTHP_STAT_SWPOUT_FALLBACK);
>  #ifdef CONFIG_SHMEM
> @@ -637,6 +638,7 @@ static struct attribute *anon_stats_attrs[] =3D {
>  #ifndef CONFIG_SHMEM
>         &zswpout_attr.attr,
>         &swpin_attr.attr,
> +       &swpin_fallback_attr.attr,
>         &swpout_attr.attr,
>         &swpout_fallback_attr.attr,
>  #endif
> @@ -669,6 +671,7 @@ static struct attribute *any_stats_attrs[] =3D {
>  #ifdef CONFIG_SHMEM
>         &zswpout_attr.attr,
>         &swpin_attr.attr,
> +       &swpin_fallback_attr.attr,
>         &swpout_attr.attr,
>         &swpout_fallback_attr.attr,
>  #endif
> diff --git a/mm/memory.c b/mm/memory.c
> index 209885a4134f..7cda8b65e0c9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4191,6 +4191,7 @@ static struct folio *alloc_swap_folio(struct vm_fau=
lt *vmf)
>                                 return folio;
>                         folio_put(folio);
>                 }
> +               count_mthp_stat(order, MTHP_STAT_SWPIN_FALLBACK);
>                 order =3D next_order(&orders, order);
>         }
>
> --
> 2.45.0
>

Thanks
Barry

