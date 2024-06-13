Return-Path: <linux-kernel+bounces-213658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2124890786F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 980841F236EA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0FB11487DF;
	Thu, 13 Jun 2024 16:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iSYJRjgH"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C212D757
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718296741; cv=none; b=POykN/35/eaSxtwLelsZn95Fy9Ztu4UJkVTa3OdZR6GfeafuwQ/3+PMAo3r2dcFnZD3p9Jo+jyGYYyQlnJFUr0M0luKz3NYhptklcaSv3jmHxUPC+8fQllAoipj6ucJOnkvZ+0CfDqsELTpZgmeZV6KnwtQXfhOlkqbz78OcDjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718296741; c=relaxed/simple;
	bh=92t4P2j0X0NUI7+L37aNZ9vtNckVXpfJBPANovmwbBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6bwhzLm/2IhD14SjvskAnkRe+A4cgFX1XlSs3Ws/igEt93WhXYacDspRnkBHiFuS3T3xRQq8/uGls4QRmm1WIYToeGPPSI5tIpapXyaSc5D/U9JJHhM2ET5Ml1zvG+uw5OeYOMiJon8G2+GWYE64tKunpaniUDlmsD3t+Trxyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iSYJRjgH; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6ef793f4b8so144807666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718296738; x=1718901538; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f0+hUYfcg/6wCMFIjwJOq9go/0av2eejFWyVyZxl9Js=;
        b=iSYJRjgHWSwdy9nEaJoZZffA3jzlVt3TrVsk5wKUc488a/4eSqqBXLzl/EVHhW9DAW
         wsZ4c+Hy2WYXcECLWEaTGeNRnd286S+OjMHuBtm1guMrkp6kerVdjHE/v8NO4dWCMlVS
         6AvKzlNQzEdQhaIgmfKcBOKU9cgM4pqczzpWsfsbsYT8LXoDzAbkKeMc5UiTpbRcM0Vq
         SlY3xMlURjPeMv4XFIC0NTihB/4sKDihMfVJDHl2ALA0li9SKE8FN9qqf1DG3SMSYsPR
         /eMu8Kq/h991jzus+2YAC0ZomSsjdrOAmD9oeNuA190moIjyMu19Sd5rS0qRz+RgJxTv
         VlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718296738; x=1718901538;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0+hUYfcg/6wCMFIjwJOq9go/0av2eejFWyVyZxl9Js=;
        b=IaqNMRjPacINm5NU/MiupvFXiPBwsqec3y5WBoEY22a1FKtMy4BpKn5yBpJsJRkNs8
         J3MAWkuvkaQFmoRzxju+P3/cNUwrTRebkSaNDKSIDU4voWNMk9wNqj7jVJUTdxQ73OiT
         P1T5EcJIzgtQVyLZeZbtRU0EwZUfXYbSW8w1u/UQbHO5NnBXvDlMRH8PMfKoOsBgWswC
         jT9tfOaSyX9i6rRl4b7iP5oAUwYLGO/hHqI87l6/urMcjDAm8x7XVEVqtf8m5KQMKOC6
         pWqTEn8bsx1rzjtt2EzMrXeQbHijwhs4b/4x/hFG0BXMCUVnx43EoJvCBIm8Np03d72b
         eLUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwz07rKyTOnGCJmvwHbe51ILqH9QPw0EIqP89c+8W3vXPnWN9IRfckC4T1JvVfh/JTVKrqhliS5AGAxCQRDh8WgTvZIefFwGt7UtCN
X-Gm-Message-State: AOJu0YyghU/hqOe2pNtwIYam1n7ywgS1ii0VbZTTZwy5MuTkdugqlDDj
	1GTKN1qR1w8JC2vY/i/LeSeq2kRSI5ZB0xZJLYMv8EtDW802YanL7JjAb2nbT+uUI8HjjG/bbCz
	uL6XxdwIDmL/tosgIxSfcJjqQsLdborla5IsL
X-Google-Smtp-Source: AGHT+IEvGD4fSm3ydygWLoTfbaCnK79SffQTu/wBgZUu6TR1D/t/B12H5lg4vCBg6YG63Pn4824qOynOJfGllokJ1aE=
X-Received: by 2002:a17:906:3ec4:b0:a6f:48b2:aac5 with SMTP id
 a640c23a62f3a-a6f60cf44efmr19942566b.15.1718296737931; Thu, 13 Jun 2024
 09:38:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-1-usamaarif642@gmail.com>
 <20240612124750.2220726-2-usamaarif642@gmail.com> <ZmoBf6RPJzC2RaqM@google.com>
 <85804484-9973-41a1-a05d-000833285f39@gmail.com>
In-Reply-To: <85804484-9973-41a1-a05d-000833285f39@gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 13 Jun 2024 09:38:19 -0700
Message-ID: <CAJD7tkYBxN4uAHLacAx=m2+B9zPidz0V5pGP030yvNYLTnk=VQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, shakeel.butt@linux.dev, 
	david@redhat.com, ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

[..]
>
> >
> >> +    for (i = 0; i < SWAPFILE_CLUSTER; i++)
> >> +            clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
> > Could you explain why we need to clear the zeromap here?
> >
> > swap_cluster_schedule_discard() is called from:
> > - swap_free_cluster() -> free_cluster()
> >
> > This is already covered below.
> >
> > - swap_entry_free() -> dec_cluster_info_page() -> free_cluster()
> >
> > Each entry in the cluster should have its zeromap bit cleared in
> > swap_entry_free() before the entire cluster is free and we call
> > free_cluster().
> >
> > Am I missing something?
>
> Yes, it looks like this one is not needed as swap_entry_free and
> swap_free_cluster would already have cleared the bit. Will remove it.
>
> I had initially started checking what codepaths zeromap would need to be
> cleared. But then thought I could do it wherever si->swap_map is cleared
> or set to SWAP_MAP_BAD, which is why I added it here.
>
> >>
> >>      cluster_list_add_tail(&si->discard_clusters, si->cluster_info, idx);
> >>
> >> @@ -482,7 +491,7 @@ static void __free_cluster(struct swap_info_struct *si, unsigned long idx)
> >>   static void swap_do_scheduled_discard(struct swap_info_struct *si)
> >>   {
> >>      struct swap_cluster_info *info, *ci;
> >> -    unsigned int idx;
> >> +    unsigned int idx, i;
> >>
> >>      info = si->cluster_info;
> >>
> >> @@ -498,6 +507,8 @@ static void swap_do_scheduled_discard(struct swap_info_struct *si)
> >>              __free_cluster(si, idx);
> >>              memset(si->swap_map + idx * SWAPFILE_CLUSTER,
> >>                              0, SWAPFILE_CLUSTER);
> >> +            for (i = 0; i < SWAPFILE_CLUSTER; i++)
> >> +                    clear_bit(idx * SWAPFILE_CLUSTER + i, si->zeromap);
> > Same here. I didn't look into the specific code paths, but shouldn't the
> > cluster be unused (and hence its zeromap bits already cleared?).
> >
> I think this one is needed (or atleast very good to have). There are 2
> paths:
>
> 1) swap_cluster_schedule_discard (clears zeromap) -> swap_discard_work
> -> swap_do_scheduled_discard (clears zeromap)
>
> Path 1 doesnt need it as swap_cluster_schedule_discard already clears it.
>
> 2) scan_swap_map_slots -> scan_swap_map_try_ssd_cluster ->
> swap_do_scheduled_discard (clears zeromap)
>
> Path 2 might need it as zeromap isnt cleared earlier I believe
> (eventhough I think it might already be 0).

Aren't the clusters in the discard list free by definition? It seems
like we add a cluster there from swap_cluster_schedule_discard(),
which we establish above that it gets called on a free cluster, right?

>
> Even if its cleared in path 2, I think its good to keep this one, as the
> function is swap_do_scheduled_discard, i.e. incase it gets directly
> called or si->discard_work gets scheduled anywhere else in the future,
> it should do as the function name suggests, i.e. swap discard(clear
> zeromap).

I think we just set the swap map to SWAP_MAP_BAD in
swap_cluster_schedule_discard() and then clear it in
swap_do_scheduled_discard(), and the clusters are already freed at
that point. Ying could set me straight if I am wrong here.

It is confusing to me to keep an unnecessary call tbh, it makes sense
to clear zeromap bits once, when the swap entry/cluster is not being
used anymore and before it's reallocated.

>
> >>              unlock_cluster(ci);
> >>      }
> >>   }
> >> @@ -1059,9 +1070,12 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
> >>   {
> >>      unsigned long offset = idx * SWAPFILE_CLUSTER;
> >>      struct swap_cluster_info *ci;
> >> +    unsigned int i;
> >>
> >>      ci = lock_cluster(si, offset);
> >>      memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
> >> +    for (i = 0; i < SWAPFILE_CLUSTER; i++)
> >> +            clear_bit(offset + i, si->zeromap);
> >>      cluster_set_count_flag(ci, 0, 0);
> >>      free_cluster(si, idx);
> >>      unlock_cluster(ci);
> >> @@ -1336,6 +1350,7 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
> >>      count = p->swap_map[offset];
> >>      VM_BUG_ON(count != SWAP_HAS_CACHE);
> >>      p->swap_map[offset] = 0;
> >> +    clear_bit(offset, p->zeromap);
> > I think instead of clearing the zeromap in swap_free_cluster() and here
> > separately, we can just do it in swap_range_free(). I suspect this may
> > be the only place we really need to clear the zero in the swapfile code.
>
> Sure, we could move it to swap_range_free, but then also move the
> clearing of swap_map.
>
> When it comes to clearing zeromap, I think its just generally a good
> idea to clear it wherever swap_map is cleared.

I am not convinced about this argument. The swap_map is used for
multiple reasons beyond just keeping track of whether a swap entry is
in-use. The zeromap on the other hand is simpler and just needs to be
cleared once when an entry is being freed.

Unless others disagree, I prefer to only clear the zeromap once in
swap_range_free() and keep the swap_map code as-is for now. If we
think there is value in moving clearing the swap_map to
swap_range_free(), it should at least be in a separate patch to be
evaluated separately.

Just my 2c.

