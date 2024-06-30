Return-Path: <linux-kernel+bounces-235157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6F191D0D6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 11:35:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC64E1F215A6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 09:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BFE12DD8A;
	Sun, 30 Jun 2024 09:35:30 +0000 (UTC)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20DC282ED
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719740130; cv=none; b=HjKWsTe2XesxhVTQmaLEuh2zWIqRN2fAm46oBIF82swSiY7UIRSZs+oT17pbaw6ipyqRotdcolSL0HVjGknQQ91r2anJ7TaQJ/iK3Ib5mfiVlvQGDV/9KQFQoh/AtN7rHrNu+qxQ2aaacv/ugX/JWEsByC1yG4BhRnCdJ56c/o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719740130; c=relaxed/simple;
	bh=8+bYA5ZIR5bd70JQo1wZwQP2+i0txmilLygHuNt/rr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VPjQ3A37AWTOPs1YHTF7RXBY66ZcJLkCTn/J60Q8IrP7BdFiKHwKedgNUc+cethaFTD4urK2YznxbCW6oAIYX+jLYKSKASCX571iqeHv63Io7L1qj35Yqw3QgEJvCZaBr3XwVITbse7UNVqblxXJPgGIkble6QpXX9miBXw5Bq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d55e2e0327so1180501b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 02:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719740128; x=1720344928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fa0craKq8Fvm8bkWAnyHT4L9wh19HhtSlODuh8HZXoA=;
        b=phBX/X3YQ8/B4OMQI3USbUlaHdFgZrLSdkDpPPLaRi+0421eTc/EumjZdWcd345ftS
         SXywbEzyVjEdM5c0EYZfOo+MzZ/qs4eKevoPigaVJm7WcOUO4aFt41z5pZ2i36b15tz8
         MYie5yy7LJdUZ4hpdr2FcRV/fFkyZbOOKwiN1uxqkNnoP2feohNAhXvh+7s4bkf7fbUA
         ONSgAH5gADE2JVzQODdDiqS3LtetvLpchNijbNCEJCxfVDNfZbPr/COANmZj4iiJzDAz
         e3CXcdwBi1p3bnNggPQkAlp03uZ/aSxNbyvVfB+MJCMzh0QwzmzZhjIkLtG1ldg+YG8j
         hNzg==
X-Forwarded-Encrypted: i=1; AJvYcCVulvk/UZMUuH2fgH3bRnGUqIzuq09wzDHOZuDjKRh0Z88VlGe1HLina6KfQfHUGl5v0n9nsn6H6N6YHQa3UCd7qnHfQxQ3RahGeA+L
X-Gm-Message-State: AOJu0YzJoe740xl7BiqydIqfwcdp/EckF9DbCg/j7vvHoCJIM3S4DX0b
	XnjBuVYXXqY/jdpa5AuK4JHhRAYu+pLAT4mP3GYlwx2Pi4bsyrEQWsmn9cgU7UrdTjzflgl9ZtF
	XmiQFmDLIeYARmBDnFMGIApdifyY=
X-Google-Smtp-Source: AGHT+IF18VVEZk/QEdbv+aSO5JzRkAfarKSu+RGRYxbbGUZermxNFAEqCR6nhlbym9tOWEXD47u3l4Bcl+dkPN8oAd8=
X-Received: by 2002:a05:6808:1a24:b0:3d6:3450:7fed with SMTP id
 5614622812f47-3d6b4727127mr3626319b6e.39.1719740127555; Sun, 30 Jun 2024
 02:35:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221114904.1849-1-justinjiang@vivo.com>
In-Reply-To: <20240221114904.1849-1-justinjiang@vivo.com>
From: Barry Song <baohua@kernel.org>
Date: Sun, 30 Jun 2024 21:35:15 +1200
Message-ID: <CAGsJ_4ytMMbPo4EuNSQ-A75T+5h3O+nM127xcMg+QpKjf5D8Sg@mail.gmail.com>
Subject: Re: [PATCH] mm: shrink skip folio mapped by an exiting task
To: Zhiguo Jiang <justinjiang@vivo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 12:49=E2=80=AFAM Zhiguo Jiang <justinjiang@vivo.com=
> wrote:
>

This is clearly version 3, as you previously sent version 2, correct?

> If an anon folio reclaimed by shrink_inactive_list is mapped by an
> exiting task, this anon folio will be firstly swaped-out into
> swapspace in shrink flow and then this swap folio is freed in task
> exit flow. But if this folio mapped by an exiting task can skip
> shrink and be freed directly in task exiting flow, which will save
> swap-out time and alleviate the load of the tasks exiting process.
> The file folio is also similar.
>

Could you please describe the specific impact on users, including user
experience and power consumption? How serious is this problem?

> And when system is low memory, it more likely to occur, because more
> backend applidatuions will be killed.

Applications?

>
> This patch can alleviate the load of the tasks exiting process.

I'm not completely convinced this patch is correct, but it appears to be
heading in the right direction. Therefore, I expect to see new versions
rather than it being dead.

>
> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
> ---
>  mm/rmap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>  mode change 100644 =3D> 100755 mm/rmap.c

You changed the file mode to 755, which is incorrect.

>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 3746a5531018..146e5f4ec069
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -840,6 +840,13 @@ static bool folio_referenced_one(struct folio *folio=
,
>         int referenced =3D 0;
>         unsigned long start =3D address, ptes =3D 0;
>
> +       /* Skip this folio if it's mapped by an exiting task */
> +       if (unlikely(!atomic_read(&vma->vm_mm->mm_users)) ||
> +               unlikely(test_bit(MMF_OOM_SKIP, &vma->vm_mm->flags))) {
> +               pra->referenced =3D -1;

Why use -1? Is this meant to simulate lock contention to keep the folio wit=
hout
activating it?

        /* rmap lock contention: rotate */
        if (referenced_ptes =3D=3D -1)
                return FOLIOREF_KEEP;

Please do have some comments to explain why.

I'm not convinced this change is appropriate for shared folios. It seems
more suitable for exclusive folios used solely by the exiting process.


> +               return false;
> +       }
> +
>         while (page_vma_mapped_walk(&pvmw)) {
>                 address =3D pvmw.address;
>
> --
> 2.39.0
>

Thanks
Barry

