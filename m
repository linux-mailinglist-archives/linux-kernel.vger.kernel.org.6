Return-Path: <linux-kernel+bounces-430975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D549E37B4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 373A7285EA2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567631B218A;
	Wed,  4 Dec 2024 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6ds8cdB"
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FC91AA7A5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308649; cv=none; b=Mp3rYDJEmjrCSY0Lb25ksa1c4mOn02abMRaBJxBU88EoFuzmrfvjfFiMrWxFZE3t23mjd9PTylir8wNnO82BLwSKUdtLKcyzzDiWaIM8nbryQ4ja/KK9HrfWdwSVDVLWPsx0TdlTjurTlSj8MJ8vaaCFNx+Vp2WFqJ1GBGesNXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308649; c=relaxed/simple;
	bh=AsUzAlE7CCQ9KxdYCTTq2bSry9kqReBJdSEg7a0Rnfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dx+anBlVL1T2ELSE4H1unFbVSH5Jk4b9TGUTtxGZqbW4A5KMOIQZKLJVtkkKkVpFJapgwZ+qR7sBHQK/4f7ZdTdKMoJd3tlKGFMufmT2YTv73/VJuPEJDvLjlTOltgkf4mEN7Sdo10FYalF+dKjU+jE8lBOlkzvAuP4D1jQSYYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6ds8cdB; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-51532deb867so1485628e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733308646; x=1733913446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZbxezCA1GDh5/tCHGYe+MRSelgs1h7TrsEnWijG4Y0=;
        b=g6ds8cdBQD7JAkKAKbFt2rKfWOtZev9ACf1xCXgAuEb+4pvDmRbRqGYMw9GSv4Mhf8
         uHJoyhbPAmqO7MwEJPtimxc4gV6cIQvgF0smWo98WCW0nOSNF6y4hqk5U4FjjvyuTTX/
         e2nBWIX2rWWJvqj5tMwozrq1QxVWnrTtY3Ay/zQor4wddz15zukqh7L7rM8ViLu4aa0a
         xbDcCXchsplDVmJvQbfI75lXzLw6y9ctiQFAF+Rq6OWryuYq28cqRG3PkZrYxaDR2e3m
         olbZJLWCNlffdSrkm108JBvJaeTChkdfzGWUUaO9WKLxHFb0Kd1SpTpAI1Om7y1autOx
         +2lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733308646; x=1733913446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZbxezCA1GDh5/tCHGYe+MRSelgs1h7TrsEnWijG4Y0=;
        b=pM/uCrZNgzC+vCxoynOThZw564vQpFZSySd9arpMN5KflIa6rV3AWs95awjfDMbFo2
         eo2fV11Y2SaVIv/Ha4jeFR7udkldmD1YtqPor20Y0Fdu89P6MyahQv7TgAOezAJrtAwW
         kGbVRt2ChNUkxFDk1iuVxwXuvem3YSNp040RNocsVY1lazWypw7QxR7nXB6TJU5gkOdm
         FWwERZANvqQGU1e3CTt0iNms8MKUJGLQWvg+HMheFeJjB8jk4hoThxEt8qwa6qJMf7Cj
         L+Lwyd2QAQ3uCYTK8sFnekiu+y2SgWVqSJ2WeAcIIypRFSGwJ5PGRNEYuWnkh6zosn+t
         9dzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWXdclxrFIa4RM7oxtrnxUCoY69C40QRrZtBjMpwgc7te/pWF2JqW4BV/T1M+xws14rhzHboECfKGsico=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0DkN+7zxAeZcWz8S1LRIBraIJhJAyH0L3NMuRFHUw4w5Sp5De
	Mqj54SgcsOClhjzBNCAng5ix6s6QcaUKatq5eGjpfK4kt1WQ0wCKE0MUH4Pqt0GxbhxYlD9qtFI
	7PRLg750tOWwzCF4za5T2XvKHNaU=
X-Gm-Gg: ASbGncumW/QBziMt4CUUIeeLDDjKHHR2byNj2W8ZPYml+VMjqkZFCHqVdogcwx2PmwL
	6115SadmSJVQdyyHI/7XE8i7fdna3YKOyxS2nHBnVZmKLqTOKrAzUlHM7cJBywj3v
X-Google-Smtp-Source: AGHT+IHynhX/MX8+WVPjQua2f8a9Inty5yJv/GwXFtGCCbN7HirfTPNz/j5lLcj3e1kdQQopvdnQpiUTWAIhbC53AWA=
X-Received: by 2002:a05:6122:21a5:b0:515:3bfb:d4d0 with SMTP id
 71dfb90a1353d-515bf29dda6mr7446680e0c.1.1733308645997; Wed, 04 Dec 2024
 02:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241204040158.2768519-1-chenridong@huaweicloud.com> <20241204040158.2768519-2-chenridong@huaweicloud.com>
In-Reply-To: <20241204040158.2768519-2-chenridong@huaweicloud.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 4 Dec 2024 23:37:15 +1300
Message-ID: <CAGsJ_4yBJBLucTP6945VTf9UQ_y6wcPyooevHT+mUu_junkjWQ@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/2] mm: vmascan: add find_folios_written_back() helper
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, hannes@cmpxchg.org, 
	yosryahmed@google.com, yuzhao@google.com, david@redhat.com, 
	willy@infradead.org, ryan.roberts@arm.com, wangkefeng.wang@huawei.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, chenridong@huawei.com, 
	wangweiyang2@huawei.com, xieym_ict@hotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 5:11=E2=80=AFPM Chen Ridong <chenridong@huaweicloud.=
com> wrote:
>
> From: Chen Ridong <chenridong@huawei.com>
>
> Add find_folios_written_back() helper, which will be called in the
> shrink_inactive_list function in subsequent patch.

This is not about adding a helper but rather extracting a function
that can be used
by both lru_gen and the traditional active/inactive LRU. Making it a
separate patch
may not be ideal, as it isn=E2=80=99t an external function that warrants
special attention.
Combining patch 1 and patch 2 into a single patch creates a more cohesive a=
nd
logical flow, making it easier to review.

>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  mm/vmscan.c | 73 +++++++++++++++++++++++++++++++----------------------
>  1 file changed, 43 insertions(+), 30 deletions(-)
>
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 76378bc257e3..af1ff76f83e7 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -283,6 +283,48 @@ static void set_task_reclaim_state(struct task_struc=
t *task,
>         task->reclaim_state =3D rs;
>  }
>
> +/**
> + * find_folios_written_back - Find and move the written back folios to a=
 new list.
> + * @list: filios list
> + * @clean: the written back folios list
> + * @skip: whether skip to move the written back folios to clean list.
> + */
> +static inline void find_folios_written_back(struct list_head *list,
> +               struct list_head *clean, bool skip)
> +{
> +       struct folio *folio;
> +       struct folio *next;
> +
> +       list_for_each_entry_safe_reverse(folio, next, list, lru) {
> +               if (!folio_evictable(folio)) {
> +                       list_del(&folio->lru);
> +                       folio_putback_lru(folio);
> +                       continue;
> +               }
> +
> +               if (folio_test_reclaim(folio) &&
> +                   (folio_test_dirty(folio) || folio_test_writeback(foli=
o))) {
> +                       /* restore LRU_REFS_FLAGS cleared by isolate_foli=
o() */
> +                       if (lru_gen_enabled() && folio_test_workingset(fo=
lio))
> +                               folio_set_referenced(folio);
> +                       continue;
> +               }
> +
> +               if (skip || folio_test_active(folio) || folio_test_refere=
nced(folio) ||
> +                   folio_mapped(folio) || folio_test_locked(folio) ||
> +                   folio_test_dirty(folio) || folio_test_writeback(folio=
)) {
> +                       /* don't add rejected folios to the oldest genera=
tion */
> +                       if (lru_gen_enabled())
> +                               set_mask_bits(&folio->flags, LRU_REFS_MAS=
K | LRU_REFS_FLAGS,
> +                                             BIT(PG_active));
> +                       continue;
> +               }
> +
> +               /* retry folios that may have missed folio_rotate_reclaim=
able() */
> +               list_move(&folio->lru, clean);
> +       }
> +}
> +
>  /*
>   * flush_reclaim_state(): add pages reclaimed outside of LRU-based recla=
im to
>   * scan_control->nr_reclaimed.
> @@ -4567,8 +4609,6 @@ static int evict_folios(struct lruvec *lruvec, stru=
ct scan_control *sc, int swap
>         int reclaimed;
>         LIST_HEAD(list);
>         LIST_HEAD(clean);
> -       struct folio *folio;
> -       struct folio *next;
>         enum vm_event_item item;
>         struct reclaim_stat stat;
>         struct lru_gen_mm_walk *walk;
> @@ -4597,34 +4637,7 @@ static int evict_folios(struct lruvec *lruvec, str=
uct scan_control *sc, int swap
>                         scanned, reclaimed, &stat, sc->priority,
>                         type ? LRU_INACTIVE_FILE : LRU_INACTIVE_ANON);
>
> -       list_for_each_entry_safe_reverse(folio, next, &list, lru) {
> -               if (!folio_evictable(folio)) {
> -                       list_del(&folio->lru);
> -                       folio_putback_lru(folio);
> -                       continue;
> -               }
> -
> -               if (folio_test_reclaim(folio) &&
> -                   (folio_test_dirty(folio) || folio_test_writeback(foli=
o))) {
> -                       /* restore LRU_REFS_FLAGS cleared by isolate_foli=
o() */
> -                       if (folio_test_workingset(folio))
> -                               folio_set_referenced(folio);
> -                       continue;
> -               }
> -
> -               if (skip_retry || folio_test_active(folio) || folio_test_=
referenced(folio) ||
> -                   folio_mapped(folio) || folio_test_locked(folio) ||
> -                   folio_test_dirty(folio) || folio_test_writeback(folio=
)) {
> -                       /* don't add rejected folios to the oldest genera=
tion */
> -                       set_mask_bits(&folio->flags, LRU_REFS_MASK | LRU_=
REFS_FLAGS,
> -                                     BIT(PG_active));
> -                       continue;
> -               }
> -
> -               /* retry folios that may have missed folio_rotate_reclaim=
able() */
> -               list_move(&folio->lru, &clean);
> -       }
> -
> +       find_folios_written_back(&list, &clean, skip_retry);
>         spin_lock_irq(&lruvec->lru_lock);
>
>         move_folios_to_lru(lruvec, &list);
> --
> 2.34.1
>

Thanks
Barry

