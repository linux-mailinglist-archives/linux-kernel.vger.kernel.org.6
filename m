Return-Path: <linux-kernel+bounces-345017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAE598B129
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF1781F24A80
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148E3193412;
	Mon, 30 Sep 2024 23:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+G8kds+"
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9A6189502
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739819; cv=none; b=pR0Yo013bybKQVVrOcCl/gD1vPLGE3NYdMlN3s3UIhQyJuBrHXzCTbLIjYdahwFr5PLGIHmVoVxbsdyMbd1baqYAxQKaznUkKUIuZdiziTbA1qVSkf9FrcoBgkdufsISW2i4idyFMkmjMo3wA+0hVvKkrSfhUfLmF7IvP0+7AfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739819; c=relaxed/simple;
	bh=QVchMLlAjvoHwS6r9tlnQSB6CEoE+AV5pb8nb8DvKm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iV/uJkmHbWCcXZSFzkn56PEganwN/pTi0g/1ScQdzgxhRUyi1c4xn9K3Kohpa7Px0tCGbnEMRsQD5ronbpsHcwNfDXR5I5Fzw5zcVfJtNpOXTw51loCj8SoXJ7Gm3Yk8B9NtXv0ZQiGxlJbbyBrq6yZQ41ZkzoSfukyaAfRuImM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+G8kds+; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cb35f2aec1so33988856d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727739817; x=1728344617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVchMLlAjvoHwS6r9tlnQSB6CEoE+AV5pb8nb8DvKm4=;
        b=U+G8kds+kEXkcdbMvLuT2djD4t4mVb826H/65qc4pA6JRdtf/b8J8T3TK8PQD2Ov2h
         jQtZ6W8RGKcGlFBOKaz/VB17JsS6Uq7jQyQHs5G4SWELKokkrzzhbHaMgO/dUxO7nDNV
         Dl6lVeWE2ukMNlmFJMbyEoRUDMQFqizzjyaEPQK9sMFl79BfB7xDhSEbsaN11zRoocMP
         7VjF6h9yU+PlbsE0J21IpaYin3Fvn/yTvw9foYfC4/1Ut174t1kNQ9/JICsei2pswzVJ
         mNQc34I3gw+3NVX2xRk00pHAIbhnRRni433cXMkYxyUgQro6l5rEJT4mzAL7SgNcxykc
         QIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727739817; x=1728344617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QVchMLlAjvoHwS6r9tlnQSB6CEoE+AV5pb8nb8DvKm4=;
        b=loEOQ7y83nAm5Tv0PrxTRTZbq5EyumIa4WmosEubBZJHUvntze7/bB3dl9gkfsOrnX
         fRV4Ndmt5X7O8et9E5h/n0ShgkwpoRBalbXaUHfqINe9LPaoeVN+mzdzPWelQFcH+zaa
         Cmty2yaDHR78DjqtvhaY+i673SZg2xRXV/QP62kfvuxs7Zn0rPGr5GXTf+66X4vJ5yTP
         UizT8X7Nj/A6RiNOHmJ3HDEz+bSHfGmk7kkFkxuMDbk0GbyuFq4M+BDPp+tRr0bF3Yqu
         3/2YSBYG65jdCeDGeinqdT5ATQEP8G2CEvwR7PfVqV/QYEI8Xis9Ti8uUgE/igsRBqmD
         l3zw==
X-Forwarded-Encrypted: i=1; AJvYcCV8KRY/AklcRxbh7hl3H2dhefk05tfUMtBpMxDpgzD86hcx/pw5RDWJ0U7zpFmKuflTvSynjsv9RmEKP0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzur0Nqs5Bg0tZqvNQyhGe5m7akbOT9LrXuf+iM2dntDCiqC7So
	gs5MKLYziByHk0UNNfV64liJ8VJpplV+Yi/aK/ED/eRFSJSJW7jDoKto6kajqEUw40uUv8Tm5Mb
	sodz6hcQXadp+YbR9MPKRwULaIyU=
X-Google-Smtp-Source: AGHT+IFfh73+cfDnL0tYJFyVqKBp5XI8q/LB+v8u4kjnALRxPJx7iCL0RfNIeALwI/bV/gLsYOubeLOzHr1cUn5GHW0=
X-Received: by 2002:a05:6214:5987:b0:6cb:21e9:aba8 with SMTP id
 6a1803df08f44-6cb3b5e7827mr279762756d6.3.1727739816804; Mon, 30 Sep 2024
 16:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
 <20240930221221.6981-7-kanchana.p.sridhar@intel.com> <CAKEwX=Podz0XkX4=sutZk_nRTPy_aQ3JSVUZ9GNxPbX=t7R2kg@mail.gmail.com>
 <CAJD7tkadrmzUHMXRbeScq+ekY1AJhjrSZ_mZtt4H7x1Z=Ad=UQ@mail.gmail.com>
 <CAKEwX=PBaioXK2iBjzjUHVeCReqCCNG3+qyhLcb6SDixbYbaLw@mail.gmail.com> <CAJD7tkaRrMp2APU=hzEos=oGkW6dW+M8GCzc8D=F1sboXZ_BAw@mail.gmail.com>
In-Reply-To: <CAJD7tkaRrMp2APU=hzEos=oGkW6dW+M8GCzc8D=F1sboXZ_BAw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 30 Sep 2024 16:43:23 -0700
Message-ID: <CAKEwX=Mt-UEt8jXcLQUq=U1h9uswcteSxgipAv2RYFM4wCar5w@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	willy@infradead.org, nanhai.zou@intel.com, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:34=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Sep 30, 2024 at 4:29=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wro=
te:
> >
> > On Mon, Sep 30, 2024 at 4:20=E2=80=AFPM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Mon, Sep 30, 2024 at 4:11=E2=80=AFPM Nhat Pham <nphamcs@gmail.com>=
 wrote:
> > >
> > > I suggested this in a previous version, and Kanchana faced some
> > > complexities implementing it:
> > > https://lore.kernel.org/lkml/SJ0PR11MB56785027ED6FCF673A84CEE6C96A2@S=
J0PR11MB5678.namprd11.prod.outlook.com/
> >
> > Sorry, I missed that conversation.
> >
> > >
> > > Basically, if we batch get the refs after the store I think it's not
> > > safe, because once an entry is published to writeback it can be
> > > written back and freed, and a ref that we never acquired would be
> > > dropped.
> >
> > Hmmm. I don't think writeback could touch any individual subpage just y=
et, no?
> >
> > Before doing any work, zswap writeback would attempt to add the
> > subpage to the swap cache (via __read_swap_cache_async()). However,
> > all subpage will have already been added to swap cache, and point to
> > the (large) folio. So zswap_writeback_entry() should short circuit
> > here (the if (!page_allocated) case).
>
> If it's safe to take the refs after all calls to zswap_store_page()
> are successful, then yeah that should be possible, for both the pool
> and objcg. I didn't look closely though.
>
> Just to clarify, you mean grab one ref first, then do the
> compressions, then grab the remaining refs, right?

Ah yeah, that's what I meant. We can either perform one of the
following sequences: grab 1 -> grab nr -> drop 1, or grab 1 -> grab nr
- 1 if successful, drop 1 if failed.

Seems straightforward to me, but yeah it seems a bit hair-splitting of
me to die on this hill :) Just thought it was weird seeing the other
parts batchified, and one part wasn't.

The rest LGTM - I'll defer to you and Johannes for further review.

Reviewed-by: Nhat Pham <nphamcs@gmail.com>

