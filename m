Return-Path: <linux-kernel+bounces-527396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E60C7A40AB7
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C05467A8450
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 17:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DF71FF613;
	Sat, 22 Feb 2025 17:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXxgptRq"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC719C542
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 17:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740245587; cv=none; b=Yu9heC7dn/PIiRORh36gijQ2FbD9sK0u/ubtNh/CDXxumKJjrKnLh4OTteYctELMGuBv4JGSp1BqjBl7HL5t/xpsLBS2uhDvkEp3pgh4Oy3VUutC0/tbZysaQj2rMgYxU41y3cjh8PkzZBUARd7bx6Zf0llAAcfWYXIwnzGlz9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740245587; c=relaxed/simple;
	bh=jaLJ/PVcNEcIxKCP9cy/9R7PQuFYifyih/VFbsDP5Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JWhH1VLA7Vp+iV/bD6c6e128JkrRWO6w5CbEfwkKCLMypgIQ2quzo2/yDHXmUOfXeuIzt52XN79bAfOoJAFaCxAUmY6e121xYGpveM8KjvLbJJEolQMHUz9Spu5jpce+s9XP8WrHK+T3e69iXsda9+Z85R4gRBtmT1k0sCVqFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXxgptRq; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so3551569e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 09:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740245583; x=1740850383; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47sGTs/t4bka1RfwAawdwjzt2bTO96camy2ouwRUtfo=;
        b=dXxgptRqQZN1ofL+MmzdDG/1lTsgLXNohoLVrwhgyIVMNqV4w2WsnErULuvUYGWwPY
         yXeFTdV2ZszpOALRGVKKUVTbzNLT4vrUkp7rK9O9zvRTN/q1Mu7ZW7kUGcjy1L269LIv
         kESMRfXn6vxp3oyWNR1rtBmtGREDHL9iWF8DlOLJpnTUfNDJYRIwpZ941VLN+5t0JWXU
         pclxZl6UImzdraXGhXY5cB7AyEmmxu7cKNM/edRaBhAYRwV2aYAEF9ALbEmelZ7946Ul
         8aCwNx1ck7RqxCGWBAcTRjeu32GNqN/1t7et8LxD0LmbVw+j/1kll3ItfH6wNck+sz9b
         Iulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740245583; x=1740850383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47sGTs/t4bka1RfwAawdwjzt2bTO96camy2ouwRUtfo=;
        b=Q6ZPhzOhG1gLTGh7OGi0//b6XocRW84gybNumfTmTRg8esHHeJ3Z39srKmkWnj3Poo
         plSyztloCaJOU+ro0TE5xaAUqC0ro8krrGdqtcsFmKwlPls1MJiCYDCdiIfWcWPeU8mp
         /C0lRSYuZbWzPxBULIUtLDMhBCYd1vg0z9XdKnVBBfcjiz8O5JalWuvmQXYGEaCTOK4f
         cyomT0mfKec8/eezgJGgCKU7dUoZOn9lMK7MdukBVKZugagmHeJ/bUUckVm+JkaoSKnL
         kqbtO/42CNHFTUJAIZJ3it7GS+ljOzGbPndKqlaZWGaM85XtosCtAzSfWuKDTumNL7Iv
         kOXA==
X-Forwarded-Encrypted: i=1; AJvYcCUz+ZVQK23v63KfcMWcfgQWtqVVKL+qQF1Mj/Kb11eEdaXQX9iQ4flxwR7fm4bHOaY2N/UbQPe60swsJ2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL/bjgre1i4XCIg7atKeQHnUeasMZBJce956cuLabMhMcRRzkW
	9yJiyz/KGbsdKPNtsGJ01zETyv/nlu6C0yPFcrug4Do4FKLdd6yQc4NvQoBGmVfVCNaUphMSR/v
	NK2PdZBXNWrIecY/emaaGXJQU8hg=
X-Gm-Gg: ASbGncsgeKKOKwn0LZAJdQhC2O5uE21mQt4GIB+TkXLct5ljoMh7ifX2q+/BPpoWkWg
	sxOAAOjHsc9fLjEzDVlIusD6Sg77U6XxhDqVUDchOgdHlyEsIxBNZUIOul58Sl7c4pEu9o2TiR8
	e2aiDJkOg=
X-Google-Smtp-Source: AGHT+IGunu4NbIYTmpQaMd3AEa3BS15W/ORrQhBUNw7kaT45aRnHC4ZbhGjg+iKPGol3AbAm5XfOZnSMdnMCSfHyCr0=
X-Received: by 2002:a05:6512:3da9:b0:545:2fa7:5a8b with SMTP id
 2adb3069b0e04-54838eff1b6mr3289227e87.27.1740245582939; Sat, 22 Feb 2025
 09:33:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222160850.505274-1-shikemeng@huaweicloud.com> <20250222160850.505274-3-shikemeng@huaweicloud.com>
In-Reply-To: <20250222160850.505274-3-shikemeng@huaweicloud.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 23 Feb 2025 01:32:46 +0800
X-Gm-Features: AWEUYZnr2ss2VVnMyxE1ZlX57zg31x7DY51azRUJ_wGWkB_51PHazY_TXmC3aas
Message-ID: <CAMgjq7ATkczfS5axBwcZaht1SzZ5TtYXg=P7jvn-EKhNKWmoOw@mail.gmail.com>
Subject: Re: [PATCH 2/6] mm: swap: use correct step in loop to wait all
 clusters in wait_for_allocation()
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 3:12=E2=80=AFPM Kemeng Shi <shikemeng@huaweicloud.c=
om> wrote:
>
> Use correct step in loop to wait all clusters in wait_for_allocation().
> If we miss some cluster in wait_for_allocation(), use after free may
> occurs as following:
> shmem_writepage                  swapoff
>  folio_alloc_swap
>   get_swap_pages
>    scan_swap_map_slots
>     cluster_alloc_swap_entry
>      alloc_swap_scan_cluster
>       cluster_alloc_range
>        /* SWP_WRITEOK is valid */
>        if (!(si->flags & SWP_WRITEOK))
>
>                                   ...
>                                   del_from_avail_list(p, true);
>                                   ...
>                                   /* miss the cluster in shmem_writepage =
*/
>                                   wait_for_allocation()
>                                   ...
>                                   try_to_unuse()
>
>        memset(si->swap_map + start, usage, nr_pages);
>        swap_range_alloc(si, nr_pages);
>        ci->count +=3D nr_pages;
>        /* return a valid entry */
>
>                                   ...
>                                   exit_swap_address_space(p->type);
>                                   ...
>
>  ...
>  add_to_swap_cache
>   /* dereference swap_address_space(entry) which is NULL */
>   xas_lock_irq(&xas);
>
> Fixes: e47bd46eab97e ("mm, swap: hold a reference during scan and cleanup=
 flag usage")
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  mm/swapfile.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index e5f58ab86329..425126c0a07d 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -2627,7 +2627,6 @@ static void wait_for_allocation(struct swap_info_st=
ruct *si)
>         for (offset =3D 0; offset < end; offset +=3D SWAPFILE_CLUSTER) {
>                 ci =3D lock_cluster(si, offset);
>                 unlock_cluster(ci);
> -               offset +=3D SWAPFILE_CLUSTER;
>         }
>  }
>

Thanks, good catch.

Reviewed-by: Kairui Song <kasong@tencent.com>

