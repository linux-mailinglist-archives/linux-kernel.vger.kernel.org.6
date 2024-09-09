Return-Path: <linux-kernel+bounces-322185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B272F97256A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 00:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725482826E0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1D018D625;
	Mon,  9 Sep 2024 22:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NykPSQLU"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2054023741
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 22:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725921981; cv=none; b=JBFPv/TmjDO5175Ebs2qFk66vPAhuYCJeILR+RqHIV3gLkccm1H0z4+oNAQeBe2j7xN+WUl2U3HQhmt+sgW5uCOzXcDHvJ05b8WEP7pQ7yZT324ETfYOTW3fyEAWQfrgWctY6gxMV+aiL+D28o5P4zj2vN1hlhoR8ryeEULwiWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725921981; c=relaxed/simple;
	bh=ivV8pT1HPafO5qkP6QSSBMPWoTIZ0Ouk7L0wgC1uFLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UrO3kCxGBnRw4JN+iO19gu7nQWyEpSnaPV2wIWoX10irA12Fbx6MpAQ+QrA4TVEdKGBBO3TO3/RnH6l/Gwuwni82INSw+nff6cClr8mX3zKScgOxSMJ6YgWxLPuaPiDPh3FoxglabjjsiFlVShA5xhxBWYEfWiIPtt5v50RvXTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NykPSQLU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c3c30e6649so81960a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725921977; x=1726526777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+4nk3SFLT9yU/DUYdXVzczQcb969uRly8G5xeotbKQ=;
        b=NykPSQLUiDMWnf5sMrZvBYyeN/mtwQrKhVTZFmei7FQQJj5Sj6dWYvxDO6ikS8NG7P
         SenH8FFoRsbNEkmGW+MXY4BxcCWfAytdB6Z39vg2c22VwS9eTpjpmAkA8ZxecHW+PQqr
         AD6S8pvlvXjSUtPVKW00mEUgsOnsBJqVW9otGGhJjqGqysz5kIQWSNOBHByF1WNCaFaO
         xiJYbMuI2Av2SiiqtIFnD+2F5MVJvuUMQkN2YPVPFMnVP1s8Pp5CMQHKmvMXKtnhC2rg
         ArceGVWJGJXs2xFAyntB/EPiikY1wNXkWzTUD12/DfGw4TZv7KAnBY37VEoWz1Z+plne
         Iz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725921977; x=1726526777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+4nk3SFLT9yU/DUYdXVzczQcb969uRly8G5xeotbKQ=;
        b=CLDthhvDj2Xcm4VlnxaNb7toCUEwxtIztxFSiDekKwlGnJuKrvd84c/24udaNLQazK
         cOH0Wjb5bRNnfb0GvJAdcs7ZTnyDaXz0V6QAcVJLh/ezmS1b5pyIufJgt8Zh0XYmXl1a
         IuY5N8iQyV/pBzVPRHhN8t2KmaT+fFssZhupPr0Uu0FpA6HvdIRaLnF+nvdfPnvsdVrO
         vV0HoW8b0ZYu+7c4I4bpN+XcOXGpu1O3LB5bxrZ3RDWExxH2BpB9CmNcYRUID0d6wBwq
         c/li7/Ga1lZQoIJTC+vztVOknsH5FouA688KnWC+UEVulHmmjm0bvvLeEmfmLirjvJLb
         pcOg==
X-Forwarded-Encrypted: i=1; AJvYcCUVxq52mk13d8CLZvvcayCmWbzSthnsFsFrSt1B+g7ue4yYfq/mFS/P3ADPAGA/FriHCrN5mS7Ao4U+Rfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO0vGbgAK8+pL4nEc46SVDLKQUYDroTFyY5swt2H4gn+ARa396
	/VOCqkglcSis1U4U5XdHTGEIDfvyBncK3CDRA36urS4tTlnXwbao6VlrYZtl1oM/ztnbRY/jssD
	MdhHidyzdSbIqWNCWknSx9xf+p6UQdCNoEbmD
X-Google-Smtp-Source: AGHT+IE8SJIxL8bgKMRqVhb4TImGa7tJCf1vic0Kcz0oVFDND6rhGcAvC4TZk1H/fFVF2PRs4rnKCc4ZpEELaQ+mrDU=
X-Received: by 2002:a17:906:fe4a:b0:a7a:9fe9:99e7 with SMTP id
 a640c23a62f3a-a8a8885da54mr1045293466b.41.1725921976626; Mon, 09 Sep 2024
 15:46:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830082244.156923-1-jingxiangzeng.cas@gmail.com>
In-Reply-To: <20240830082244.156923-1-jingxiangzeng.cas@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 9 Sep 2024 15:45:39 -0700
Message-ID: <CAJD7tkb6320POwiWaSmZFUYRh44_BStwjc2nhL3Wangy1qWYxQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: add per-memcg pgpgin/pswpin counter
To: Jingxiang Zeng <linuszeng@tencent.com>
Cc: linux-mm@kvack.org, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 1:23=E2=80=AFAM Jingxiang Zeng
<jingxiangzeng.cas@gmail.com> wrote:
>
> From: Jingxiang Zeng <linuszeng@tencent.com>
>
> In proactive memory reclamation scenarios, it is necessary to
> estimate the pswpin and pswpout metrics of the cgroup to
> determine whether to continue reclaiming anonymous pages in
> the current batch. This patch will collect these metrics and
> expose them.

Could you add more details about the use case?

By "reclaiming anonymous pages", do you mean using memory.reclaim with
swappiness=3D200?

Why not just use PGPGOUT to figure out how many pages were reclaimed?
Do you find a significant amount of file pages getting reclaimed with
swappiness=3D200?

>
> Signed-off-by: Jingxiang Zeng <linuszeng@tencent.com>
> ---
>  mm/memcontrol-v1.c | 2 ++
>  mm/memcontrol.c    | 2 ++
>  mm/page_io.c       | 4 ++++
>  3 files changed, 8 insertions(+)
>
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index b37c0d870816..44803cbea38a 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -2729,6 +2729,8 @@ static const char *const memcg1_stat_names[] =3D {
>  static const unsigned int memcg1_events[] =3D {
>         PGPGIN,
>         PGPGOUT,
> +       PSWPIN,
> +       PSWPOUT,

memory.reclaim is not exposed in cgroup v1, so assuming these are only
used for such proactive reclaim, we don't need to add them here.

>         PGFAULT,
>         PGMAJFAULT,
>  };
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 087a8cb1a6d8..dde3d026f174 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -418,6 +418,8 @@ static const unsigned int memcg_vm_event_stat[] =3D {
>         PGPGIN,
>         PGPGOUT,
>  #endif
> +       PSWPIN,
> +       PSWPOUT,
>         PGSCAN_KSWAPD,
>         PGSCAN_DIRECT,
>         PGSCAN_KHUGEPAGED,
> diff --git a/mm/page_io.c b/mm/page_io.c
> index b6f1519d63b0..4bc77d1c6bfa 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -310,6 +310,7 @@ static inline void count_swpout_vm_event(struct folio=
 *folio)
>         }
>         count_mthp_stat(folio_order(folio), MTHP_STAT_SWPOUT);
>  #endif
> +       count_memcg_folio_events(folio, PSWPOUT, folio_nr_pages(folio));
>         count_vm_events(PSWPOUT, folio_nr_pages(folio));
>  }
>
> @@ -505,6 +506,7 @@ static void sio_read_complete(struct kiocb *iocb, lon=
g ret)
>                 for (p =3D 0; p < sio->pages; p++) {
>                         struct folio *folio =3D page_folio(sio->bvec[p].b=
v_page);
>
> +                       count_memcg_folio_events(folio, PSWPIN, folio_nr_=
pages(folio));
>                         folio_mark_uptodate(folio);
>                         folio_unlock(folio);
>                 }
> @@ -588,6 +590,7 @@ static void swap_read_folio_bdev_sync(struct folio *f=
olio,
>          * attempt to access it in the page fault retry time check.
>          */
>         get_task_struct(current);
> +       count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
>         count_vm_event(PSWPIN);
>         submit_bio_wait(&bio);
>         __end_swap_bio_read(&bio);
> @@ -603,6 +606,7 @@ static void swap_read_folio_bdev_async(struct folio *=
folio,
>         bio->bi_iter.bi_sector =3D swap_folio_sector(folio);
>         bio->bi_end_io =3D end_swap_bio_read;
>         bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
> +       count_memcg_folio_events(folio, PSWPIN, folio_nr_pages(folio));
>         count_vm_event(PSWPIN);
>         submit_bio(bio);
>  }
> --
> 2.43.5
>
>

