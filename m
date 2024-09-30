Return-Path: <linux-kernel+bounces-344979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A3F98B0D8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987DD282EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F13187849;
	Mon, 30 Sep 2024 23:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RHDQZ+0p"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8CC3E479
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 23:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727739250; cv=none; b=X89FJCkJ+Oj6YsAJzGE1fTbmfrmwx0mrVYqU6E94sMy8k7cDMcDOp/skCpbz46XdNok1jFFAYpBaBzCzQI7oqCD0jPrTC34p7M4BxUbjwLvuA4dRpaLIxLTlGfWC9CQpYhMpeJC7+2A+4PetA7/Tpu5FversViWlpFT5eAou4Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727739250; c=relaxed/simple;
	bh=prIeTSYiKIvJS+EE6ej8fL51jvYwgStC5lRUrm72WxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aGV6pIXAcLZ0m+hkJrkXCg7VobHfGaF633yp1Fd10o9kMgUz+ifLVj1WJZeC5lYGYfXT2CCa4hpponGSAE72tvbrVHC+q/wuxZArjPUMQA5ECUXkaMPT2037a6/Yz0FWhMm2gTY23s2/10h71I9eYAUNr9aidTX5Irtm+dWcjcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RHDQZ+0p; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c8967dd2c7so2059132a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 16:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727739247; x=1728344047; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prIeTSYiKIvJS+EE6ej8fL51jvYwgStC5lRUrm72WxQ=;
        b=RHDQZ+0p4t/4E1c/+BhTH+1RBZVwTxQ0DGpeGvPs/Htd5JSL7AO9OVtFOE0heIn/oV
         Les5J9B6DRiOS+WoNFuln/ed5vhF/s/MRmAv8TyLwZ+mTAMU9CHrP0Dlu+5f5/CkpdTW
         KFo/M1MrM5PBLXLBwTVfNegWzahEYM6b3OuB5W31DDMc4cU+03MbU9CcNok0yICY0QD1
         dduHPQSBxd1LJQJhV46Kf4GL922pYlbaFU6x2raVdzc5mF8AbykGMKZSTimS/cLt1IJs
         CacQ15eZpx4jTVdGcw2wGHlckB/kCBNmRIBkTnEdZ9/gdqkI8fIGPxROoXN99oW9EgvL
         Mm/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727739247; x=1728344047;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prIeTSYiKIvJS+EE6ej8fL51jvYwgStC5lRUrm72WxQ=;
        b=sj7l00KVM7ytqIfG7196vr/oA8U61NSBXlqyLUfPVjqSYe2wXL2yufxNCzHWJ9j6TI
         4E8lVQ6xD6zsn9RLOV/WMmH2CCWAwzIZg3Tbklq9zkId5lvCyMhGGm0Qa3GDTYh+rTeV
         SodHTivdo0pfhqDFesqBNxLKWrbGfNsg3/RPf7KHuvRAwFLdYuw/VxFKYSXwreBoxT9K
         OVM0IqukRiXGIpeoPBESy4sbCfSMxoNnxtg6DZRHgMXAcV3gPS+Z2bfpTEAe7Q/n/nF2
         Tj9KsDID6m04BYiB4MX5uqND749+VL25iKSbyd9QMxUKBNXmdMLsB2WdpxQZyQE4VFJZ
         GwIA==
X-Forwarded-Encrypted: i=1; AJvYcCUtX6OAPmosq3R8rAjULYOdisk8wATEz7/9+s/JngJGeK8yump6RBWvvK1qP1rtVxyr4Tzb3S/vZIkPAD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvC5IzwnpkEeegYBnUA5QVLzF8GkYlTKWMFAyt/ugcK9nElZz1
	h/2WiE4DTlrbGXO5bW3VOu0QsN7Fm8JRZ9WffJdbsRRWGRiKJ2FDRxsziyKeBbCiwz2XJ2DAF2C
	6ctIAK07TlVwDiEx5efUIpNtUEF0hzl+A1dke
X-Google-Smtp-Source: AGHT+IFTIv/XSXdKGQFoGAvZXtPLinOK3hqnuS5gesnUD4L+bmERC/C7ox4l+yT6DV4FgbShZunzJz7g2V91sJWft0o=
X-Received: by 2002:a17:907:8687:b0:a8d:3998:2d2 with SMTP id
 a640c23a62f3a-a93c4aa6b1amr1523866966b.58.1727739246520; Mon, 30 Sep 2024
 16:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930221221.6981-1-kanchana.p.sridhar@intel.com>
 <20240930221221.6981-7-kanchana.p.sridhar@intel.com> <CAKEwX=Podz0XkX4=sutZk_nRTPy_aQ3JSVUZ9GNxPbX=t7R2kg@mail.gmail.com>
 <CAJD7tkadrmzUHMXRbeScq+ekY1AJhjrSZ_mZtt4H7x1Z=Ad=UQ@mail.gmail.com> <CAKEwX=PBaioXK2iBjzjUHVeCReqCCNG3+qyhLcb6SDixbYbaLw@mail.gmail.com>
In-Reply-To: <CAKEwX=PBaioXK2iBjzjUHVeCReqCCNG3+qyhLcb6SDixbYbaLw@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 30 Sep 2024 16:33:29 -0700
Message-ID: <CAJD7tkaRrMp2APU=hzEos=oGkW6dW+M8GCzc8D=F1sboXZ_BAw@mail.gmail.com>
Subject: Re: [PATCH v9 6/7] mm: zswap: Support large folios in zswap_store().
To: Nhat Pham <nphamcs@gmail.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, chengming.zhou@linux.dev, 
	usamaarif642@gmail.com, shakeel.butt@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	willy@infradead.org, nanhai.zou@intel.com, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 4:29=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Mon, Sep 30, 2024 at 4:20=E2=80=AFPM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > On Mon, Sep 30, 2024 at 4:11=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> w=
rote:
> >
> > I suggested this in a previous version, and Kanchana faced some
> > complexities implementing it:
> > https://lore.kernel.org/lkml/SJ0PR11MB56785027ED6FCF673A84CEE6C96A2@SJ0=
PR11MB5678.namprd11.prod.outlook.com/
>
> Sorry, I missed that conversation.
>
> >
> > Basically, if we batch get the refs after the store I think it's not
> > safe, because once an entry is published to writeback it can be
> > written back and freed, and a ref that we never acquired would be
> > dropped.
>
> Hmmm. I don't think writeback could touch any individual subpage just yet=
, no?
>
> Before doing any work, zswap writeback would attempt to add the
> subpage to the swap cache (via __read_swap_cache_async()). However,
> all subpage will have already been added to swap cache, and point to
> the (large) folio. So zswap_writeback_entry() should short circuit
> here (the if (!page_allocated) case).

If it's safe to take the refs after all calls to zswap_store_page()
are successful, then yeah that should be possible, for both the pool
and objcg. I didn't look closely though.

Just to clarify, you mean grab one ref first, then do the
compressions, then grab the remaining refs, right?

The other thing I would be worried about is code clarity, not sure if
it would be confusing to initialize the entries in zswap_store_page(),
then grab the refs later in zswap_store().

>
> >
> > Getting refs before the store would work, but then if the store fails
> > at an arbitrary page, we need to only drop refs on the pool for pages
> > that were not added to the tree, as the cleanup loop with
> > zswap_entry_free() at the end of zswap_store() will drop the ref for
> > those that were added to the tree.
> >
> > We agreed to (potentially) do the batching for refcounts as a followup.
>
> But yeah no biggie. Not a dealbreaker for me tbh. I thought it was a
> quick change (hence the fixlet suggestion), but if not then let's do
> it as a follow-up.

I don't feel strongly either way.

