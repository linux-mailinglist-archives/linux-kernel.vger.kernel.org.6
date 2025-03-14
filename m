Return-Path: <linux-kernel+bounces-560868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B33A60A55
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C9A77A975E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5101624D9;
	Fri, 14 Mar 2025 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsGKZZp2"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A7AEAD7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938486; cv=none; b=aeEtBN2uIfoPlRt/qcOhBQdaBGcLeT0ON573Fw332DvXRvsq94gF6i44YtxNUvacwNgbzMODIzj4M3lcw3KMbCaQ8abBqTgzsNd8WeaoPe2qq5hmqAVZlpBclPyl0YGKKp2W51MfMB4Up8X9VFOuV6ybJJWrgxvYwkAwp7fNtmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938486; c=relaxed/simple;
	bh=xMiOnoLBcKG2r0Ek+9cCvmTyt9w7gKHVu7yfjUwcoCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P83CpMWRC9oUKVBPUNhs/aeD9I+wniozi2hDH3Q3c/bxs1G6Tit11xrCcHcnxwsri8CHoY/n7dNz1dhH6j7ARX0im/q8h7w8IWZPEY4acvsinE3grMvhfG+MSUaQRrdqdIV28QJYe7gwDXKau/ZOWPrkgLHGf3J1iz7H9S1/B48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsGKZZp2; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30bf3f3539dso18158661fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741938482; x=1742543282; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JE4K030Ix2YY1jJzgtn8D5f5ys9pdEOThXvdyC2otH8=;
        b=nsGKZZp2NSCoaJ5lL+Hsgyt75lFAeVtlqDNs6sd4DsNC5xSFPpuhGVL2cX3VredKMY
         tMdXnxedRpIYka4F0ZGsVkRT2iLl+ij91kPIqEIcHHx48K5fk6U9f8J8gnHQiPU49Iza
         MG3wQ6ioOhORkbkUCCuDbS0WlTehx+fnLM9K9Rmzo3bWMOfx1u2017T9P4NLY5V6dRY3
         HuxhYsXSPm9WqPC8C5LN/HTf1LbIurhzHRT937hPkYSJDpWQwG1JMvztsuMlB8QCvl6t
         Xk6vO6AtmBTodzvXiO0MBqq0Y554+Op1SApgKrFjjODZAIpHw7j9KYjJfSLcYxkPQhIk
         DAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741938482; x=1742543282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JE4K030Ix2YY1jJzgtn8D5f5ys9pdEOThXvdyC2otH8=;
        b=OD3BZ/zXS3XRWTqMRL2fYTOLkAdvXHkp+ahGPvAk7l1nuWS86+Bbo0ZlRECzKBJ0yL
         aDieXlYVR+/NMO6PQrHwhbVodJg3BNh0je7KaT7DdNEz4YeeJ+FNaIrrJBd1TogQ9fv9
         EQOXj7VBVUUizcqEWkG4Mc3UlXRg4q+c/Jn9WWJkYuAqDC9lQEMgvRbL5Mhv15mebLvi
         k7/cDYSH/lC6QyPiqRpbRaC2pVpwVBmzheXYdGM6V7VYKnDwD3ueHAxhXnaq1M9EDtzp
         8zsPDwUW5gRk7UUJ5u95otOEN73MHotCMNMy82LDVm6ZIoDWn2cute8nBOJ45k0ed7dG
         8Lbw==
X-Forwarded-Encrypted: i=1; AJvYcCUoYWAhukBlBgzLImxA3IJ7kBkC5Gf0U477mdk6VQF0lGqdiRR5ggW9gAPFgcScX9hx5lUt/ot8LR6kU1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrDj6/8xUmE+sNXLl+Yp6qGiDZie6oxHJiXm9hJKTvxMTwcKT5
	9YzzGMPQHhOoyC/OT4JuMayXxR/oU1GNQPeT7oEnxmo0Y2kpmSUYgsNC1F9SXwdhAa1aYjaTvND
	d/1xQc2CMFGycRywbJMHdhxX2PnA6IlWfXn4=
X-Gm-Gg: ASbGncuIY32MaiXR0Db6GP8CzUHVZ5h0fQPwqaMA77FLtNjXsPxjPJP0SnCZO6bQDDQ
	kEGBDO9m7r4RWxe8Ex/cBJUHTUEjvRiV5GGkIaf91O9ThDnTFWaiVRU/lAheFUjqIaHS9kyHJ8m
	SIKExbR7F7vGGe34zGT10+b/6/1exmqZS/LT/6
X-Google-Smtp-Source: AGHT+IGlde6dxe5RcixnCSr2LQ5am9MX2vuU6zDqJt+NTPBtmpmgML4SVElH9EIwe0/SVQedf+nYS95p3nhUDOcZ4t8=
X-Received: by 2002:a2e:a9a0:0:b0:30b:c328:3cdc with SMTP id
 38308e7fff4ca-30c4aa76f67mr4627861fa.2.1741938481940; Fri, 14 Mar 2025
 00:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313210515.9920-1-shikemeng@huaweicloud.com>
 <20250313210515.9920-3-shikemeng@huaweicloud.com> <CAMgjq7Ct8b25zuCEqJ4byU8gmrvz50pUqvyjYN=_RjTk_5U8cA@mail.gmail.com>
 <a04c8908-a12a-dab8-f4e4-61f7b85443bf@huaweicloud.com>
In-Reply-To: <a04c8908-a12a-dab8-f4e4-61f7b85443bf@huaweicloud.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 14 Mar 2025 15:47:45 +0800
X-Gm-Features: AQ5f1Jr0E6RKhid4P4IuEx4hmjE99QBOaGj6jSepzog0gB1psaJes3aj3iaTP3E
Message-ID: <CAMgjq7Cq30Kb-Wysq+GkV4ZAj-PKQQaEg_YQzwJ=6COtS6k_Yw@mail.gmail.com>
Subject: Re: [PATCH 2/9] mm: swap: factor out the actual swap entry freeing
 logic to new helper
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 3:32=E2=80=AFPM Kemeng Shi <shikemeng@huaweicloud.c=
om> wrote:
>
> on 3/14/2025 1:42 AM, Kairui Song wrote:
> > On Thu, Mar 13, 2025 at 8:09=E2=80=AFPM Kemeng Shi <shikemeng@huaweiclo=
ud.com> wrote:
> >>
> >> Factor out the actual swap entry freeing logic to new helper
> >> __swap_entries_free().
> >> This allow us to futher simplify other swap entry freeing code by
> >> leveraging __swap_entries_free() helper function.
> >>
> >> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> >> ---
> >>  mm/swapfile.c | 30 ++++++++++++++++++++----------
> >>  1 file changed, 20 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> index 5a775456e26c..7c886f9dd6f9 100644
> >> --- a/mm/swapfile.c
> >> +++ b/mm/swapfile.c
> >> @@ -1347,6 +1347,25 @@ static struct swap_info_struct *_swap_info_get(=
swp_entry_t entry)
> >>         return NULL;
> >>  }
> >>
> >> +static inline void __swap_entries_free(struct swap_info_struct *si,
> >> +                                      struct swap_cluster_info *ci,
> >> +                                      swp_entry_t entry, unsigned int=
 nr_pages)
> >> +{
> >> +       unsigned long offset =3D swp_offset(entry);
> >> +
> >> +       VM_BUG_ON(cluster_is_empty(ci));
> >> +       VM_BUG_ON(ci->count < nr_pages);
> >> +
> >> +       ci->count -=3D nr_pages;
> >> +       mem_cgroup_uncharge_swap(entry, nr_pages);
> >> +       swap_range_free(si, offset, nr_pages);
> >> +
> >> +       if (!ci->count)
> >> +               free_cluster(si, ci);
> >> +       else
> >> +               partial_free_cluster(si, ci);
> >> +}
> >> +
> >>  static unsigned char swap_entry_put_locked(struct swap_info_struct *s=
i,
> >>                                            unsigned long offset,
> >>                                            unsigned char usage)
> >> @@ -1525,22 +1544,13 @@ static void swap_entry_range_free(struct swap_=
info_struct *si,
> >>
> >>         /* It should never free entries across different clusters */
> >>         VM_BUG_ON(ci !=3D offset_to_cluster(si, offset + nr_pages - 1)=
);
> >> -       VM_BUG_ON(cluster_is_empty(ci));
> >> -       VM_BUG_ON(ci->count < nr_pages);
> >>
> >> -       ci->count -=3D nr_pages;
> >>         do {
> >>                 VM_BUG_ON(*map !=3D SWAP_HAS_CACHE);
> >>                 *map =3D 0;
> >>         } while (++map < map_end);
> >>
> >> -       mem_cgroup_uncharge_swap(entry, nr_pages);
> >> -       swap_range_free(si, offset, nr_pages);
> >> -
> >> -       if (!ci->count)
> >> -               free_cluster(si, ci);
> >> -       else
> >> -               partial_free_cluster(si, ci);
> >> +       __swap_entries_free(si, ci, entry, nr_pages);
> >>  }
> >>
> >>  static void cluster_swap_free_nr(struct swap_info_struct *si,
> >> --
> >> 2.30.0
> >>
> >>
> >
> > Hi Kemeng,
> Hello Kairui,
>
> Thanks for feedback.
> >
> > This patch is a bit too trivial to be a standalone one, you can fold
> > it with the later one easily. Also you may want to carry the
> > VM_BUG_ON(ci !=3D offset_to_cluster(si, offset + nr_pages - 1)); check
> > as well.
> Sure, I will do this in next version.
> >
> > But, that is basically just renaming swap_entry_range_free, you may
> > just remove the HAS_CACHE check as you rename it, that way the changes
> > should be cleaner.
> >
> Sorry, I don't quite follow. Are you suggesting that should fold this
> patch to later one which removes the HAS_CACHE check and renmae the
> swap_entry_range_free.

Hi,

Just some of my nitpicks :)

After you move these parts out of swap_entry_put_locked, there is
almost nothing left in swap_entry_put_locked except an "open coded
memset". And in your next patch (also after the whole series), all
callers of __swap_entries_free will have to call an "open coded
memset" anyway, so these changes seem redundant and could be improved.

BTW your next patch has a typo in the commit message:
s/__swap_entriy_free/__swap_entries_free/g.

>
> Thanks,
> Kemeng
>

