Return-Path: <linux-kernel+bounces-303992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48712961820
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 21:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B01AB2236E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 19:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7290D1D31AD;
	Tue, 27 Aug 2024 19:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItVeWiRs"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDD1132132;
	Tue, 27 Aug 2024 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724787685; cv=none; b=V8+KG4UZaOG1QzY+pvtgu/uWeEs3CFZ0gmGH0slleFIAx3HkV2Ib/UiGf1SIx6MoIjnvepE+HmU6lzxF6P9ITviEKy5NI3MYwWA/jH/93+VtDw7f8QSG178Epu6Pt6gxUoj0cA4FDt9QKBmAG2TXpfS8ikBbqcaNTcIp0REHBv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724787685; c=relaxed/simple;
	bh=wqslitYbqJSi0KPH7mB4ZICiE8Ld7szan6LtjNILLAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToK+HVYV9UcdDfkUoUb0S0CULOlM+zA0PZP84zb00yWi2IORedi0JVz0hSbyntbdb1ovkzpBxNqDqyYY1StfKZW2f3WYaJSaCptnRB6XThQxAI3yKwcs1fGZa6LOgxPNG5G/tnb2Bd4qR/zd5ySvWgGLOqIXhtdsgzPiKWrRCHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItVeWiRs; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6bf6beda038so33074086d6.2;
        Tue, 27 Aug 2024 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724787683; x=1725392483; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eHjyJb8GPp/6HfUjUQSJWFTlvgIcHY5RFMvohVM8PdQ=;
        b=ItVeWiRsxFqJps0sLTU8WO1emlveL/YMD4JH3L6HloWnBi+VWylUzTPwNR8hh1oHgS
         GO7Ge/uPnhSbXhnqDbqxGGBtXiZ73KnhI5GgKrk+7T7TsaP8SdKsvYMQWlkMjjoY3tpN
         k2m577BS/ZI+gcUeO8/Yu66lWhTHpKH5OGg5RLwAszj6oM6Zry8kuolU63iJFJRCye7q
         DwzgSXQwxUHRBCN7Zxwx7D5STg2c3wt4gLVUMMkxFtCrzuauyrPX5jllV5QaNiXoTqwb
         TB4xniWDzkMIRxkVbGd/gTOtnTQxO9m9oO5/l4Wp+spJmwhUzSvzdvGVO+bdi5aENki9
         a3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724787683; x=1725392483;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHjyJb8GPp/6HfUjUQSJWFTlvgIcHY5RFMvohVM8PdQ=;
        b=PgFxF6xZST+QxYyLddoKZ4BmeyRpnh6QGKVYqlwUiBq8EP6iu6in3QAqJ0sm8pug7C
         uhRALedst4KsrHKqFvyC//+uh4PMiWLYYtDcV99POkABYyZDl4hqXzwjghPEA/v5HXZn
         IKgqgpr4JsCZeiuEUETXjSofZmzXh+wqTkF6fHFKfmqtsI+dR/643nS+i+3Vz4VEDXCG
         B9Qmp26o3177ZLPxFe1nBib9M/SYQ41+XzJngd+PNPNGKClNXKrwKQiPGs3k5+NARAct
         HdMKLE/+M37Xb2lZXuQKfLGvko7JJmP/kIAlU4DcF3CH7i6odnXYJlBtmZpJG460agLh
         DJhA==
X-Forwarded-Encrypted: i=1; AJvYcCVsUaQCcCnQum7IQb41xwDohcMAj2xGpmuebIBbAEcDhbw+5R1Bv++2dKa3v0Cd53KEeRzQ4KgDDNitOUc=@vger.kernel.org, AJvYcCW4Elw1BHzb1ZCNmCd8FGuBFXgzFnVU1YL7PG4AygT9oikb3yJzwcnbqA6EAsIpS2wtkWgQuwCjMD1PCSDEOEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1C1jXc7ImogHjP3sCkIWF7XY+0kl0QkYPi1t37iQ4WRTWEdUR
	eXf3B6KjdynvGqI3tFuizd6QG+guse88veL4bdAzwZErHQXytMqh
X-Google-Smtp-Source: AGHT+IFiH/nKvl+KXqLzz46m2teZMGkmO+BsRECC14GZfUubMw2oaB/F9FKPc+3KOqo9Y26CHuMkcA==
X-Received: by 2002:a05:6214:5a02:b0:6c1:6add:d26e with SMTP id 6a1803df08f44-6c16dc24ec2mr163281156d6.11.1724787682991;
        Tue, 27 Aug 2024 12:41:22 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162db09a7sm59110026d6.95.2024.08.27.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 12:41:22 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 3AB69120006C;
	Tue, 27 Aug 2024 15:21:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 27 Aug 2024 15:21:55 -0400
X-ME-Sender: <xms:UyfOZspMhrQfEasSV4WnsXGLmVopKIn0FJ_PzOmWXCEjJm5FgnD4Bw>
    <xme:UyfOZipKWsQs_UMuHpZW8gqX96vX374LcHNeKmU87ZnGazTCd5uojFQeIzqvahYE2
    7TmdAE8IcT1lI9RTg>
X-ME-Received: <xmr:UyfOZhOoK3twaXbRgHdh14Bs8qsnO8IEWpjQGMtgnjJumRKL7yJhJ0eK84o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeftddgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeejhfeikeekffejgeegueevffdtgeefudet
    leegjeelvdffteeihfelfeehvdegkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopedvhedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhihhhhl
    sehgohhoghhlvgdrtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepfigvughsohhnrghfsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrg
    hrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgr
    ihhlrdgtohhmpdhrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmh
    gvpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehsrghmshhunhhgrdgtohhm
X-ME-Proxy: <xmx:UyfOZj4O_1qg_AwDnKl9q3Vmz39t0EpY7o70O6-0GR0wfIQl0KkCkg>
    <xmx:UyfOZr6I0AbLza2gZfkROY25KtMNiwq_uJs0hr02NclPH5yyiGJzfg>
    <xmx:UyfOZjiJs5UwTdbscLb4y30wLhu2LhP7g9TqPNHskg1m_M2YHpKZSA>
    <xmx:UyfOZl5O94y98_PzcWc-ZKi_h1gD_dRLLiTZBEOSmvuMMfXQScqZIA>
    <xmx:UyfOZuKeDQFinft13_RHdv38erQGsKtDniPj9Ic8m7jxcouqs363a2Sy>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Aug 2024 15:21:54 -0400 (EDT)
Date: Tue, 27 Aug 2024 12:21:31 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, gary@garyguo.net,
	bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, akpm@linux-foundation.org,
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com,
	boris.brezillon@collabora.com, lina@asahilina.net,
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 09/26] rust: alloc: implement kernel `Box`
Message-ID: <Zs4nO1zsOI5eF1vv@boqun-archlinux>
References: <20240816001216.26575-1-dakr@kernel.org>
 <20240816001216.26575-10-dakr@kernel.org>
 <CAH5fLggUzUuiVuKOYmvo1fAcXGpsHUiRKx6DTg2cgkMe2YcF4g@mail.gmail.com>
 <ZsS1njIt0Mp9pWok@pollux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsS1njIt0Mp9pWok@pollux>

On Tue, Aug 20, 2024 at 05:26:22PM +0200, Danilo Krummrich wrote:
> On Tue, Aug 20, 2024 at 11:47:45AM +0200, Alice Ryhl wrote:
> > On Fri, Aug 16, 2024 at 2:13 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > >
> > > `Box` provides the simplest way to allocate memory for a generic type
> > > with one of the kernel's allocators, e.g. `Kmalloc`, `Vmalloc` or
> > > `KVmalloc`.
> > >
> > > In contrast to Rust's `Box` type, the kernel `Box` type considers the
> > > kernel's GFP flags for all appropriate functions, always reports
> > > allocation failures through `Result<_, AllocError>` and remains
> > > independent from unstable features.
> > >
> > > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> > 
> > Overall looks good to me, but I have a question:
> > 
> > > +impl<T: 'static, A> ForeignOwnable for Box<T, A>
> > > +where
> > > +    A: Allocator,
> > > +{
> > > +    type Borrowed<'a> = &'a T;
> > > +    type BorrowedMut<'a> = &'a mut T;
> > > [..]
> > > +    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> &'a mut T {
> > > +        // SAFETY: The safety requirements of this method ensure that the pointer is valid and that
> > > +        // nothing else will access the value for the duration of 'a.
> > > +        unsafe { &mut *ptr.cast_mut().cast() }
> > > +    }
> > 
> > Where does this come from? It looks like you've based the series on
> > top of [1], but I dropped that patch a long time ago, and I don't see
> > it in rust-dev anymore.
> 
> I comes from me rebasing onto rust-dev. When Boqun asked me to resolve the merge
> conflicts a few days ago, this patch was in rust-dev. I think it disappeared two
> days ago or so.
> 
> @Bonqun: Need to me to rebase again?
> 

No need to rebase for this. I've already applied your series on
rust-dev. The background of carrying `borrow_mut` is because it was
simple to do, and so I carried it as the best effort, now with more
`ForeignOwnable` ipmls, I think it's better if we just drop it, and
re-introduce if needed.

Sorry for a bit out-of-sync on this one.

Regards,
Boqun

> - Danilo
> 
> > 
> > Alice
> > 
> > [1]: https://lore.kernel.org/all/20230710074642.683831-1-aliceryhl@google.com/
> > 

