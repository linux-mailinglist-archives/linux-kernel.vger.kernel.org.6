Return-Path: <linux-kernel+bounces-237051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB48291EA50
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E9F1C212A1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA08B16EB7E;
	Mon,  1 Jul 2024 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mXJ4N0oD"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05AE383A2
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719869291; cv=none; b=eUL8E/UdkEQxizkCp3RcYeYwdJ11Owc9EstugHP+TugDv4g/H9TNdo8g56PQ7mIzVhDMifB4psLbHH9UM95R8RqvmzeuIjGlfn3CP8JsKe6NrYz4IjEh0vnti3dpR6IFZpbATfiXHzix1grVZOTPH8J3gf/OUs0NlECNXFEZE4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719869291; c=relaxed/simple;
	bh=V1dqL+6P3waceAq/ycFi+AgI17nJMGgEjSNDx8dZVhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oSmyUEwhfZNtBpSDL5f0NYincV0NLGrpxPIipWFymmyeI3UbZgtDYIihd5lsY1D4+qYBVv143JlkZJ+Wli47UyTcevkWfwjnn4m3URqbDWzXLmJdCzzuak5TQ+oP9gdpQuJ/MYrSDyBG3PgGIMIgx9YAlG5kKiu8LH8TUNssffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mXJ4N0oD; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4ef748596d7so1186850e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719869288; x=1720474088; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ou1KHLdWw83FJUJksFOCwGjxghpAWqEzTlvLRzDw3ic=;
        b=mXJ4N0oDgcgPI3uqWx7GRNNoDJotA53IkAUaYInjWLsl5wpmu7EmxHRyXmXbszvdB5
         09bleTqpvHZZ0UCdrZsf1VWieIZ08OV+EnsCjcPONdtewmIpgYqwPIvlC1jqS/wg8V1k
         vbtf8uzth1M6TrzuZvh8S2FgrOR+1VIwX5pywsy5jzVyrmJPTDhOeJq7jAsq/Q1cGQUD
         Eds9/7OlEBQrE0GhtNr3roDQZCYa7Z9+fDsLTidLJbz/a8FM8CExV/ermDSkbCQIzboo
         bbmEIG38cF2bClEPCo+h/+WAGdMWb0ODMq/MI7pAuetZ3szguNEdm8GBUjISSY+rJXxv
         +eBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719869288; x=1720474088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ou1KHLdWw83FJUJksFOCwGjxghpAWqEzTlvLRzDw3ic=;
        b=lXN6rJzmj63Sa2ohKZgDY6Ykan2O4hjKQ3nwjhAPt4V4UCwXwfc/uz6iPDuCr7U0Hd
         KVky7slwmiRHzMkBzBRt9eOsmoZUWizZQrW1s2cnRdKl/1StoXR3luDJOYw8oszX/wWB
         FpHuc7lfpYsfUoMIBPPrl67bPnjbuvVwnOOkkchvyjXbTC4GGpOR0EOCl5BSlr/fxqg5
         05wc1zeTaUhEVRZCecpSlqWLlpyg8boL8X3mmUHzXziAs0v8ILqu4miyOys91AxMlVz0
         BAFwaOXSOJxezgLKxTz5fYxx/LuyRLDRT0hurNBvda5Qu+j6kcPSPSLrS86dHPgJzpxy
         KY8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXzuyO6dRtRSSBDGGxLBg02lVy7PIa2jhOJ4b88obKVVJ8NllEHEtbCVqdyJMAnI86jfh5XnvhSC10okpWljUSSXHniMGfcV+1EsJVM
X-Gm-Message-State: AOJu0YwDGxKQMaykmk3Q0mAVSYgtrAKZs/OuNWfUCDgttvFmOuISu4eX
	ZjMnRPnBwguF315xvR3u6LeYEh7BEF4Jxb3Fww6GgYUavBWinu+ZL4yY+gWmUZLqfAx0ctJYcyK
	kQLaPcizenlkiWhP3mtm7tLNhH10=
X-Google-Smtp-Source: AGHT+IHRKNpdUtDXUbVFR16WEQTMX/Oyl0mZEjn1zvveqOa0IVQ8vXLuwCXweryD3Pz7igwtOV65lxH2rkWSQjF62fw=
X-Received: by 2002:a05:6122:3224:b0:4ef:27dc:7a9 with SMTP id
 71dfb90a1353d-4f2a5318a94mr8154206e0c.0.1719869288585; Mon, 01 Jul 2024
 14:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240629111010.230484-1-21cnbao@gmail.com> <20240629111010.230484-3-21cnbao@gmail.com>
 <CAJD7tkZ4FQr6HZpduOdvmqgg_-whuZYE-Bz5O2t6yzw6Yg+v1A@mail.gmail.com>
In-Reply-To: <CAJD7tkZ4FQr6HZpduOdvmqgg_-whuZYE-Bz5O2t6yzw6Yg+v1A@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 2 Jul 2024 09:27:57 +1200
Message-ID: <CAGsJ_4yjHwjkOyS1qiiLbHvGbk=UpNfA+XsyyYe=SZNs8mvWzg@mail.gmail.com>
Subject: Re: [PATCH RFC v4 2/2] mm: support large folios swapin as a whole for
 zRAM-like swapfile
To: Yosry Ahmed <yosryahmed@google.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org, 
	david@redhat.com, hannes@cmpxchg.org, kasong@tencent.com, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, nphamcs@gmail.com, 
	ryan.roberts@arm.com, shy828301@gmail.com, surenb@google.com, 
	kaleshsingh@google.com, hughd@google.com, v-songbaohua@oppo.com, 
	willy@infradead.org, xiang@kernel.org, ying.huang@intel.com, 
	baolin.wang@linux.alibaba.com, shakeel.butt@linux.dev, 
	senozhatsky@chromium.org, minchan@kernel.org, 
	Chuanhua Han <hanchuanhua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 1:53=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com> =
wrote:
>
> [..]
> > +static struct folio *alloc_swap_folio(struct vm_fault *vmf)
> > +{
> > +       struct vm_area_struct *vma =3D vmf->vma;
> > +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > +       unsigned long orders;
> > +       struct folio *folio;
> > +       unsigned long addr;
> > +       spinlock_t *ptl;
> > +       pte_t *pte;
> > +       gfp_t gfp;
> > +       int order;
> > +
> > +       /*
> > +        * If uffd is active for the vma we need per-page fault fidelit=
y to
> > +        * maintain the uffd semantics.
> > +        */
> > +       if (unlikely(userfaultfd_armed(vma)))
> > +               goto fallback;
> > +
> > +       /*
> > +        * a large folio being swapped-in could be partially in
> > +        * zswap and partially in swap devices, zswap doesn't
> > +        * support large folios yet, we might get corrupted
> > +        * zero-filled data by reading all subpages from swap
> > +        * devices while some of them are actually in zswap
> > +        */
>
> If we read all subpages from swap devices while some of them are
> actually in zswap, the corrupted data won't be zero-filled AFAICT, it
> could be anything (old swapped out data). There are also more ways
> this can go wrong: if the first page is in zswap, we will only fill
> the first page and leave the rest of the folio uninitialized.
>
> How about a more generic comment? Perhaps something like:
>
> A large swapped out folio could be partially or fully in zswap. We
> lack handling for such cases, so fallback to swapping in order-0
> folio.

looks good to me, thanks!

>
> > +       if (!zswap_never_enabled())
> > +               goto fallback;
> > +

