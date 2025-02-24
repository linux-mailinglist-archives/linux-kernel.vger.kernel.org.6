Return-Path: <linux-kernel+bounces-529733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D5EA42A53
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7130163790
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3B6264624;
	Mon, 24 Feb 2025 17:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S8yd2Vvo"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843BA264FB9
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419444; cv=none; b=FuzlIvdHF1FtY10j30h/z9eZzZ+ew2E9SXdSy3X6UgV2jeU5QoNL8UdTskPNj2kyNd4PiaZZMWyEDG/SEm7rzFcUKYN8GA8glh/ZFhs39lvtIt/rkTw2FWA4CdFBbSDfeYn7VKl+vgtSSaQF3umQlN78n+zeUMrrwr/VUjphi8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419444; c=relaxed/simple;
	bh=vqdP06W3wU7p3ohIPmEI8fUUE/tl6qIwJ7tpEbSWuI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdC3blZn1lxQwOqpd+/yxo1pUOaFq4Vr3rUcWnY+vXk7UhA8kdJ8khvqPnBww/KopolgvdAl5iJL3uBstII7ItfaWo03JgT/EGV19sK60QP00nLDJEjsVNl1y2yz1E8srU+wxkGYJHFZ1XQRZ1lJSHm5zK/iyghGiOp4tIhswsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S8yd2Vvo; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30613802a6bso49159071fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740419440; x=1741024240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rI6WhFr7+Sr/oyaZLiBDcEJPWCjSV0G44RZKC0MTEIc=;
        b=S8yd2Vvo+ws/e4I2W3f/i2csJdZ6JTajuWrW42nu6SUmXlB1NF2sJF/0yceg8XeD4b
         cRCEs3Aeo0KsWIDVnoOqPu8+bQGh7Ep8J5eADtkKnkCYf7afDVG4pbeeQROBO7beuGrd
         ipsFLv2u2/drZ5YaxDUgy2uLs0bUUUisdgJz8o1GPCzlxjgXabknr+in+JMCrr/K0ZsJ
         hRyV+gRBnpaVRxLBYZaVUhsh7+PoOyTy/Ke8L13A+M6kLZ47hL2qUSL0bXBRDgUcvcZh
         QHoAqnOBAf1Wsgf9uEyBNO74AHGMqU3V3yUfnmRtTNNyEovkmelwc0XsZ/xDrRtdipkb
         dXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419440; x=1741024240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rI6WhFr7+Sr/oyaZLiBDcEJPWCjSV0G44RZKC0MTEIc=;
        b=Sl3iIOS0y2UrO1MNfbnTdbgaeNKaCyTu5Jk4KKgpd7seABlj3Cn6xvAcijwsLTnHOK
         gVl4hwA8a4d7Br3QZS7H6peqAvNa/S37G5JXmhAgqSLQlVSFgbtqpt91pJgpG6V4W0En
         Mh9K1chWnV1ybiYM4XSrxOsg7B1wKp48rMuO2u62ha/tBdgLuDi/mIUSiDSwAwzdh3Cw
         QAWRCwXJaFRFZUXBUmH9c+4X8vMsCMm6JrsQqFjJYXCy/icWIOPT+oXes/Ceb0M6TZqK
         2M6w8OqlMwhc8OyUl2KWKnzvTo61l0KPStoZpN1tnYo2jG+A1mLTAgxe2vBxzpV4QBvk
         hLXw==
X-Forwarded-Encrypted: i=1; AJvYcCXavX/DkBIxrwNkLq7vs0/g25a/Sqe1DRCwU5+hMoMqOa0iIFCX5ve6/QqB6mZZsFchVO8Vi7IIZoQfAo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgCk4BOuap4eD7TjIWD7MNEUkKohZNgo2c6w/70435heDUzX4i
	CT0aKmQh+4UVVku/dTWyCR7rWZP4ydHaZs4/wjroMptfVXPETYqpx1dbJN0o+OCSKvp6xp0DEhX
	ADaZdIDND3UerElnEvyfSo7oFb0w=
X-Gm-Gg: ASbGncsny8jFE36WubndQMXwI9Fv8vXjup1fA38VdAOg4Fuf8oAqBRs9GJBULSORetL
	Y8VpPRtka0SnhBLwcOB+1xtInc7GOmKkXsYn+8ikpC6YSm8HwEF1nI+zdRttHdRWc0wJmtxY/5P
	byzefQvHA=
X-Google-Smtp-Source: AGHT+IG9gHyzqvxVRLTze/Uh/M1gyHaHekyvx+ue890bzSA787Hd6wvfYp7tdQZsvp6jZQ06O1xW+HUqWr1XmXmlbo4=
X-Received: by 2002:a2e:9049:0:b0:307:5879:e7e6 with SMTP id
 38308e7fff4ca-30a80cb7ab0mr685011fa.32.1740419440224; Mon, 24 Feb 2025
 09:50:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <731904cf-d862-4c0e-ae5b-26444faff253@linux.alibaba.com> <53e610af72302667475821e5b3c84c382da4efbc.1740386576.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <53e610af72302667475821e5b3c84c382da4efbc.1740386576.git.baolin.wang@linux.alibaba.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 25 Feb 2025 01:50:23 +0800
X-Gm-Features: AWEUYZlGRBntVkJKFKFmAMSMB-OFznwWpZ3XAcYLcrkzvZkmTsNWtaDj7TNlkv0
Message-ID: <CAMgjq7D=TKC68PoMhLsJd24_sH5eyJ=o6PsDe6Ne4tAMOi49gw@mail.gmail.com>
Subject: Re: [PATCH] mm: shmem: fix potential data corruption during shmem swapin
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, alex_y_xu@yahoo.ca, baohua@kernel.org, 
	da.gomez@samsung.com, david@redhat.com, hughd@google.com, ioworker0@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ryan.roberts@arm.com, 
	wangkefeng.wang@huawei.com, willy@infradead.org, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 4:47=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> Alex and Kairui reported some issues (system hang or data corruption) whe=
n
> swapping out or swapping in large shmem folios. This is especially easy t=
o
> reproduce when the tmpfs is mount with the 'huge=3Dwithin_size' parameter=
.
> Thanks to Kairui's reproducer, the issue can be easily replicated.
>
> The root cause of the problem is that swap readahead may asynchronously
> swap in order 0 folios into the swap cache, while the shmem mapping can
> still store large swap entries. Then an order 0 folio is inserted into
> the shmem mapping without splitting the large swap entry, which overwrite=
s
> the original large swap entry, leading to data corruption.
>
> When getting a folio from the swap cache, we should split the large swap
> entry stored in the shmem mapping if the orders do not match, to fix this
> issue.
>
> Fixes: 809bc86517cc ("mm: shmem: support large folio swap out")
> Reported-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>
> Reported-by: Kairui Song <ryncsn@gmail.com>

Maybe you can add a Closes:?

> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  mm/shmem.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 4ea6109a8043..cebbac97a221 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2253,7 +2253,7 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>         struct folio *folio =3D NULL;
>         bool skip_swapcache =3D false;
>         swp_entry_t swap;
> -       int error, nr_pages;
> +       int error, nr_pages, order, split_order;
>
>         VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
>         swap =3D radix_to_swp_entry(*foliop);
> @@ -2272,10 +2272,9 @@ static int shmem_swapin_folio(struct inode *inode,=
 pgoff_t index,
>
>         /* Look it up and read it in.. */
>         folio =3D swap_cache_get_folio(swap, NULL, 0);
> +       order =3D xa_get_order(&mapping->i_pages, index);
>         if (!folio) {
> -               int order =3D xa_get_order(&mapping->i_pages, index);
>                 bool fallback_order0 =3D false;
> -               int split_order;
>
>                 /* Or update major stats only when swapin succeeds?? */
>                 if (fault_type) {
> @@ -2339,6 +2338,29 @@ static int shmem_swapin_folio(struct inode *inode,=
 pgoff_t index,
>                         error =3D -ENOMEM;
>                         goto failed;
>                 }
> +       } else if (order !=3D folio_order(folio)) {
> +               /*
> +                * Swap readahead may swap in order 0 folios into swapcac=
he
> +                * asynchronously, while the shmem mapping can still stor=
es
> +                * large swap entries. In such cases, we should split the
> +                * large swap entry to prevent possible data corruption.
> +                */
> +               split_order =3D shmem_split_large_entry(inode, index, swa=
p, gfp);
> +               if (split_order < 0) {
> +                       error =3D split_order;
> +                       goto failed;
> +               }
> +
> +               /*
> +                * If the large swap entry has already been split, it is
> +                * necessary to recalculate the new swap entry based on
> +                * the old order alignment.
> +                */
> +               if (split_order > 0) {
> +                       pgoff_t offset =3D index - round_down(index, 1 <<=
 split_order);
> +
> +                       swap =3D swp_entry(swp_type(swap), swp_offset(swa=
p) + offset);
> +               }
>         }
>
>  alloced:
> @@ -2346,7 +2368,8 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>         folio_lock(folio);
>         if ((!skip_swapcache && !folio_test_swapcache(folio)) ||
>             folio->swap.val !=3D swap.val ||
> -           !shmem_confirm_swap(mapping, index, swap)) {
> +           !shmem_confirm_swap(mapping, index, swap) ||
> +           xa_get_order(&mapping->i_pages, index) !=3D folio_order(folio=
)) {
>                 error =3D -EEXIST;
>                 goto unlock;
>         }
> --
> 2.43.5
>

Thanks for the fix, it works for me.

Tested-by: Kairui Song <kasong@tencent.com>

