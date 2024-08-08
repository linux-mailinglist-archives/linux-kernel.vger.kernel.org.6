Return-Path: <linux-kernel+bounces-279927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546DE94C380
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11FC12830CB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 17:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C19191F64;
	Thu,  8 Aug 2024 17:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l/nGTzt/"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48BD1917EF
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 17:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137538; cv=none; b=eNVsuTQfgXi2C/q3l3UbVIba2tFYydWML1RitU9eLotBVqMaHf14bu9dCo/EH+qnbXuMjrbECdlOPl7hLXjYNDNHvQ+i1bTyFx0UOcaO7XyyQ/9sbfj9orb8rD/WZCjWXBRuKJn/gMVvYchnzbQcD/TFzI/hvZ+FORXPxmZWp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137538; c=relaxed/simple;
	bh=P/9HN94ixnXlfPjMe4jrLyO0eaY1g2SNxhetAie9Xaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VAKybJe5TCheUBE8uMGHi13LCcGIkSgIpjxbcd5CzWm2pBJslXud3vDwgSNFfyg0AvGQfADTBHmQ5XnhtI820uV/J+CFai7mIcz5Lz8MCr0rsrBNF8M0r1sTnrVXO8GNAkyv9jbjsJLN2qyNYFWWB5V/TP/3p07gVlALDE1ldCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=l/nGTzt/; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so196008066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 10:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723137535; x=1723742335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBBEeQJbH1cIF1o5mQCVKPDzoYI1PKsH70ZVGIjSAII=;
        b=l/nGTzt/LbSBr1rmCr7B1k3ftxKqHWJ/yxtkNr59WeDGCCLg2wiPlpVU0mySn1t7iK
         PcWd1SinvqmupXwk1gCHujjmP+M29AhsqKt2I1bs4FO5Bs/mg02/jxM0GM9N2EwYZH/r
         +yXkxOQOkp0CNWfzvNB4g6DSisoRqvBCj/W9rHAC2Yvre7mzmcx/JkGg5ohdya/RTGac
         c+u2W5D4JQOEV02x/FIEf6y7WMyJFPRMgTHvBXxQGMSJ8aY+UU3/M2xQ0VB51aiedVi/
         2wUxUT0PEaFqkaaCMIcCKCbUQ+nH95GiDX0t1p9nqrtAS0xaVFPLKcl5J4T6ot1YlD/2
         4OOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723137535; x=1723742335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fBBEeQJbH1cIF1o5mQCVKPDzoYI1PKsH70ZVGIjSAII=;
        b=RmZux/Ig+73IfbJrQSzKkomzMApHoa6EMndRjnoi7ELUeV9PqBFVrYRhwh03J2sJWh
         UIvhWquq0aeZuodgdjfBhW+5lTZ86TwJ6rxRTxI2VBWk7hMQ2QKem/YwF90qT/WdLtCB
         r9DK1jQKq8kgvRSuIU9ydwfN5ib3JcE7VYA2pmTtJZ41azhgQ2E4tqde/KpKE8IZ5bZV
         +VDS6IHaGCiIHfeqts1RkaY3JKVerVT/j8iddUN+8eoO/es9Edn9dKKbknzzyIwxe3PI
         MmkzemDxaPHBJepCKUGK5ky/UeKLYd9zlg5d6YjvFCg5fM71EyG3j2irQ0bytkH3RuYY
         mL2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVcIZZ+NbDyDTEVJhrRCq9eaLobbOYX9UxUwGsHLFj7uXsvfqss5BS0ovwdMBtNDaECRcCM6yWoTNsLnvY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkyky5ckwiO61mowGdfDe30+J4zCjieJkEbVAio99Q8HGqNd16
	LAGYJS7C2ohwlVLhIdnwad8VpzJ2r0dAi1bTu9HQdIDiStlSZDJqL2X/6Dq5+lj6cjTKxjdDb6p
	RD1Sf6rgL7V/HpDcY3yShUS/ywFY541Ij0qa8
X-Google-Smtp-Source: AGHT+IGegQKLg0AVysDYuKUyLZQBsNuLTXHWokmFYlpa/UErmQ8lT83l5FIKtGvdtaqJ/+EOTiult52jrbHlbBrsR9c=
X-Received: by 2002:a17:907:3f97:b0:a6f:e7a0:91cf with SMTP id
 a640c23a62f3a-a8092019fe8mr217691566b.24.1723137534485; Thu, 08 Aug 2024
 10:18:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808154237.220029-1-pasha.tatashin@soleen.com> <20240808154237.220029-3-pasha.tatashin@soleen.com>
In-Reply-To: <20240808154237.220029-3-pasha.tatashin@soleen.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 8 Aug 2024 10:18:18 -0700
Message-ID: <CAJD7tkZrYFdn_23nq3A2FzESwVYMv6OmsH1N-MM=bT=k5JWjMQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] mm: don't account memmap on failure
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-cxl@vger.kernel.org, cerasuolodomenico@gmail.com, 
	hannes@cmpxchg.org, j.granados@samsung.com, lizhijian@fujitsu.com, 
	muchun.song@linux.dev, nphamcs@gmail.com, rientjes@google.com, 
	rppt@kernel.org, souravpanda@google.com, vbabka@suse.cz, willy@infradead.org, 
	dan.j.williams@intel.com, yi.zhang@redhat.com, alison.schofield@intel.com, 
	david@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 8, 2024 at 8:42=E2=80=AFAM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> When in alloc_vmemmap_page_list() memmap is failed to allocate, do
> not account, the memory is going to be release at the function exit.
>
> Fixes: 15995a352474 ("mm: report per-page metadata information")
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/hugetlb_vmemmap.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index fa83a7b38199..70027869d844 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -392,13 +392,10 @@ static int alloc_vmemmap_page_list(unsigned long st=
art, unsigned long end,
>
>         for (i =3D 0; i < nr_pages; i++) {
>                 page =3D alloc_pages_node(nid, gfp_mask, 0);
> -               if (!page) {
> -                       mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, i)=
;
> +               if (!page)
>                         goto out;
> -               }
>                 list_add(&page->lru, list);
>         }
> -
>         mod_node_page_state(NODE_DATA(nid), NR_MEMMAP, nr_pages);
>
>         return 0;
> --
> 2.46.0.76.ge559c4bf1a-goog
>

