Return-Path: <linux-kernel+bounces-210461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5529043F1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31D1F1C24536
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DE16BFD5;
	Tue, 11 Jun 2024 18:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ewdcFDLv"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E55340856
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131659; cv=none; b=DpuXvEWW0WfpW9bCmxgPsXLjg3W31bVCApbJnW0AKH4IKUGDvYTIR3qnw9eGq8BCY5hPoDKsqJbLPbVtUconNMR+0xlxF/WDxing1oLSJ4MqHqOR6hSMacrrcwPNrTYBr58W0RRk4DgoAEwz32m6rzc4/zUB2aXHk/QhD3OycJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131659; c=relaxed/simple;
	bh=CuJAwLG9LD8w9aYyFBwyEggR06cYlNMKlS01h950GC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVDEmftKe4DIA5HGx7cXBhZPVWoA9fs6ncuA5gGrFVNrKuQPrKspkzYmvpeZ7PkW+0t0upgNMGObbjTmf0mt9VVxmMCFjoVoDThFUfEf/r0vrnLZzgldoUsBVbI0aQuAaj1AASk+64MddFnX9jWznLeyW6XrlqaJU3NUstL8lSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ewdcFDLv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6f13dddf7eso371460666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718131656; x=1718736456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JNeYgHGOcCIEUgcCulHv8MogYMF1pawsllmpPlBDkvY=;
        b=ewdcFDLv38Ii9fsRVigY5jYc3LoHzchxhuPUuyyWBpA4M4Vb6jXW2WwMZ7ACgdwNom
         0Gvsagc5Rg6k2ovzBTCiO7+vYj1bF27mabH/rW8vH+RZwtCMJVa7hp7wu/T9AZG026QR
         TtZm1Bd/4Hn/0a6yxULMiFnMAGuNhrGCcoKWrV4NC+JSXXZQZ3ngjo8BAGkCKAuYgjTF
         +KZXWWR4RhMN/VlEKvdoRyd+Nf2dRroPJUTYkiqwBGAkYqgArUAHBQeaDyBlYN2VOGWs
         9oeKSjoysjUBN1cm1xtiqph3ASR+DL3JBMYAwpgF+fYqdXx+Dx4kVZ39Fsu6FO1GiAVT
         CQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718131656; x=1718736456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JNeYgHGOcCIEUgcCulHv8MogYMF1pawsllmpPlBDkvY=;
        b=s4B9eN1FeSsRPhCuJQL31VuzR8iheSBaBgLhyXw82QGkxzuOHIWoUHZ+hyXpE6LLKi
         ATb7YDrB0KDAMJX+pi0Z140SDeTLy6v0pjuDiabmV9D1mm7Vj2muUjDaULZ+LdqEV9//
         Zs22lE8flDW77P90TpTB/pOYJe8vAuNUafvgHhjI7AdVag66wRJ5OXJn+21NYtqcZQtO
         HcI3eludd7Bnwyi/PM85hGrDmolqyiV0ZJW4kiUl2OZ2Nw0CY7FRSk//RsO3RxE1anSO
         GjbR3JxnNbycCwZDQ8kQ3P7AIDo1+u31YJcTzT1C3FxJEphxr20mCRQLInRozerQWH8/
         iz+w==
X-Forwarded-Encrypted: i=1; AJvYcCVrNiQmke/obFfcZPHy580TOkB5MGeAr+1IdtSfAp8Xl20JPowPKYZmOJR8meavM9F6BSj2L2Cev/1SLMdd5f/rDRRdDQZ2pPEB7GBj
X-Gm-Message-State: AOJu0YxfHhrvkDJRlXnVfdeGILvUF86spxSuiReqzKiTNHyNL6iRcz2s
	y7z922VKH/KHInB+k7MrzURR2yey/IUNmetgPXs4FFcnWGAGmf1zQq3EV5zCCuudp2zxmaxkhev
	+yfZeubDU8IyagQg+ystCb7hVJgraj8d4EMrH
X-Google-Smtp-Source: AGHT+IHNoz6xrivvG2mtwG02p42fYi6bLD6cDom6BDtt8rlcH6ypU0fOpoYNCG82KwChYvI000hS+u624px6T+v4VyM=
X-Received: by 2002:a17:906:a082:b0:a59:dd90:baeb with SMTP id
 a640c23a62f3a-a6cdb6d16demr818238766b.48.1718131655412; Tue, 11 Jun 2024
 11:47:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com> <CAKEwX=PnwjmZKPLX2=ubD6+-+ZAqpXnczkHe4=1QY1hizOE8WQ@mail.gmail.com>
In-Reply-To: <CAKEwX=PnwjmZKPLX2=ubD6+-+ZAqpXnczkHe4=1QY1hizOE8WQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 11 Jun 2024 11:46:56 -0700
Message-ID: <CAJD7tkZdtK3CB_0bt_+EMNCc8+7FF3jPv4VwA2u8PntrC=1jrA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
To: Nhat Pham <nphamcs@gmail.com>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	david@redhat.com, ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

[..]
> > @@ -1336,6 +1347,7 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
> >         count = p->swap_map[offset];
> >         VM_BUG_ON(count != SWAP_HAS_CACHE);
> >         p->swap_map[offset] = 0;
> > +       clear_bit(offset, p->zeromap);
>
> Hmm so clear_bit() is done at the swap_entry_free() point. I wonder if
> we can have a problem, where:
>
> 1. The swap entry has its zeromap bit set, and is freed to the swap
> slot cache (free_swap_slot() in mm/swap_slots.c). For instance, it is
> reclaimed from the swap cache, and all the processes referring to it
> are terminated, which decrements the swap count to 0 (swap_free() ->
> __swap_entry_free() -> free_swap_slots())
>
> 2. The swap slot is then re-used in swap space allocation
> (add_to_swap()) - its zeromap bit is never cleared.

I do not think this can happen before swap_entry_free() is called.
Note that when a swap entry is freed to the swap slot cache in
free_swap_slot(), it is added to cache->slots_ret, not cache->slots.
The former are swap entries cached to be later freed using
swap_entry_free().

>
> 3. swap_writepage() writes that non-zero page to swap
>
> 4. swap_read_folio() checks the bitmap, sees that the zeromap bit for
> the entry is set, so populates a zero page for it.
>
> zswap in the past has to carefully invalidate these leftover entries
> quite carefully. Chengming then move the invalidation point to
> free_swap_slot(), massively simplifying the logic.

I think the main benefit of moving the invalidation point was avoiding
leaving the compressed page in zswap until swap_entry_free() is
called, which will happen only when the swap slot caches are drained.

>
> I wonder if we need to do the same here?

