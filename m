Return-Path: <linux-kernel+bounces-210473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2543C90440E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7E70281AF3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6477757E8;
	Tue, 11 Jun 2024 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBOBuaCC"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819764D8BB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718132005; cv=none; b=PNxI0dd0byNgWOjM0J9lWUDnruGu2j3ztWQYSlszCLSELIWY459/Q7dji3rhLYXSrg+ZK+DeWuuB09bNoyf+Pji1ANIgmjZWNHW8GHmiw35/8gnyUQQXpoev1f/9fR9BSh5pe3bhRNBI0Dv8HJ4HOj2+P6hHmIHHRRtl6FtSVRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718132005; c=relaxed/simple;
	bh=XqxL1YC0KOCmmYd4riI7thr+cPsWLtizgY/IBdBVUlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kyv6qLzaOxQO1x5Xb+CzApfHSXrtxh6mtjx4acMhpKO9NEx5Uv0gHjALes+d8nvXJh8hjVh+eUkmB77zeqpeUQg+44Ulv0aTvLIedlA08oCMTFAa0nxCqulNkw1MbHb0P47aLHhhjWQKuN2u5IVvNxQGnUZ6TDCgUbRMiqIZg0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBOBuaCC; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b06bdbf9fdso8505676d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718132002; x=1718736802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgNfDPKWx5weTgzZ7sQXsFLCPiSrq5i1++lcPqyQBGw=;
        b=mBOBuaCCzG1QxccEc0dRqslDe3ghA1u1DI5DpAmGopW5oaa83rtfCQ6CF5fRsZ/u/+
         YSsB0X2Pq3A/6ls0cdl9U0E+kluui5gsloxUg71iIGvl7j38k20IDAIlS3eXv/dcMkUa
         al5fNfK9oBRj7F37Bb7/+bseQLyx9vX5J9DGebVu5wG7hisejMkzMomYMGAZ97765HYN
         BNmCQKUPDSE9+GHv4Cz3tZ8mBZOlKUBPvCp7KC+eiCvIk2x8P0QXxCcUFK5MVlxSwfEA
         kvn2xFacYEJB4Uh04ionpr3LY9PUUU31EjzDBzXIjzTfcifbQy2i3mVS09mb57+hGIKY
         De/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718132002; x=1718736802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgNfDPKWx5weTgzZ7sQXsFLCPiSrq5i1++lcPqyQBGw=;
        b=lIF6e6hiGM0iaONnotTT5dQO8P45Hhn2TONBIgopNiN4Z4/LbH+2kgAen+4Mqn5fXi
         Ixwk7uLMZE6ZIUAcvPPq9+a6j5OnoxRYB7vWb9N6AjYeH2oyDmyJsbYgfbxMOAjFmlMJ
         qWTXqEd7hlWCXiszV8Bh5FLgZ7TPeYrWwdFK/TJfiUdNXvVZiHq402hsQLb9/hzS5IOt
         FHmWseL7rUgaCZnyGmKU5BrkGR51BUyGtetAAg8OxCN3V89rt8HDtya7aa6Gh4I5ZipE
         AHUga7MFgkhcAQJVx3MVGShDROXXQGG+JbnBHRnKJfSOt9a4pfLakQupHY0snCX+utJt
         WS7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWUE/Og5dEGhltipH2kLKm5ZOMpFpG81BfWDQB8ZOv+D5zuKL1I37L54l9f0abStDDWJlqu/I0K41RwHrDvj2TBBOPx+IwbK48cZoU0
X-Gm-Message-State: AOJu0YyMpc+MsVuf6/8IR45fFkpLB+NCqsyoYtiLqEecI8yf6142zk8X
	luRJtxL3t9CkA0y55o8i3BuGDsH7W1spAexWV6nry+38GT/w6YR22RUSVcC2FXNRqOI9Q3y3cha
	Ba/deRm42x0ngMLjrcIdiHTtMtwQ=
X-Google-Smtp-Source: AGHT+IFUZEuzSLrNmU7NYyDINsrLctk7Nvg33ipU/SYmAdYZwIr71Ng1tnpFJiC44maTjzmE3Un6zcawgGpLoULGG7M=
X-Received: by 2002:a0c:e7c7:0:b0:6b0:6478:ca8d with SMTP id
 6a1803df08f44-6b06478cc19mr112256506d6.39.1718132002415; Tue, 11 Jun 2024
 11:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610121820.328876-1-usamaarif642@gmail.com>
 <20240610121820.328876-2-usamaarif642@gmail.com> <CAKEwX=PnwjmZKPLX2=ubD6+-+ZAqpXnczkHe4=1QY1hizOE8WQ@mail.gmail.com>
 <CAJD7tkZdtK3CB_0bt_+EMNCc8+7FF3jPv4VwA2u8PntrC=1jrA@mail.gmail.com>
In-Reply-To: <CAJD7tkZdtK3CB_0bt_+EMNCc8+7FF3jPv4VwA2u8PntrC=1jrA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 11 Jun 2024 11:53:11 -0700
Message-ID: <CAKEwX=OMitioEvWoehnaw2cYRrD5VurkahE1bzwRfZeP_Oy45g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm: store zero pages to be swapped out in a bitmap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Usama Arif <usamaarif642@gmail.com>, akpm@linux-foundation.org, hannes@cmpxchg.org, 
	david@redhat.com, ying.huang@intel.com, hughd@google.com, willy@infradead.org, 
	chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 11:47=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> [..]
> > > @@ -1336,6 +1347,7 @@ static void swap_entry_free(struct swap_info_st=
ruct *p, swp_entry_t entry)
> > >         count =3D p->swap_map[offset];
> > >         VM_BUG_ON(count !=3D SWAP_HAS_CACHE);
> > >         p->swap_map[offset] =3D 0;
> > > +       clear_bit(offset, p->zeromap);
> >
> > Hmm so clear_bit() is done at the swap_entry_free() point. I wonder if
> > we can have a problem, where:
> >
> > 1. The swap entry has its zeromap bit set, and is freed to the swap
> > slot cache (free_swap_slot() in mm/swap_slots.c). For instance, it is
> > reclaimed from the swap cache, and all the processes referring to it
> > are terminated, which decrements the swap count to 0 (swap_free() ->
> > __swap_entry_free() -> free_swap_slots())
> >
> > 2. The swap slot is then re-used in swap space allocation
> > (add_to_swap()) - its zeromap bit is never cleared.
>
> I do not think this can happen before swap_entry_free() is called.
> Note that when a swap entry is freed to the swap slot cache in
> free_swap_slot(), it is added to cache->slots_ret, not cache->slots.
> The former are swap entries cached to be later freed using
> swap_entry_free().

Ahhh I see. Good point. Then yeah this should be safe from this POV.

>
> >
> > 3. swap_writepage() writes that non-zero page to swap
> >
> > 4. swap_read_folio() checks the bitmap, sees that the zeromap bit for
> > the entry is set, so populates a zero page for it.
> >
> > zswap in the past has to carefully invalidate these leftover entries
> > quite carefully. Chengming then move the invalidation point to
> > free_swap_slot(), massively simplifying the logic.
>
> I think the main benefit of moving the invalidation point was avoiding
> leaving the compressed page in zswap until swap_entry_free() is
> called, which will happen only when the swap slot caches are drained.
>

This is true. In this case yeah there's probably not much difference
between clearing the bit here vs in swap_entry_free().

> >
> > I wonder if we need to do the same here?

