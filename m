Return-Path: <linux-kernel+bounces-416163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 112779D411E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 18:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EF5280BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF78E1AA781;
	Wed, 20 Nov 2024 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXr7RqgF"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D521474B8;
	Wed, 20 Nov 2024 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732123559; cv=none; b=F/isPjKEB0190y9rtOJAfGBfqO6gdWl2vBELRzxbvmlY1e5Es9JHp5urJAhF6Z4dALzsJYsAAWxHoApEXlhJxm3WJLZG6d/FE7QL0Sdhf2ktCaK64geRaLe6+KbiSn5u5nMGzBEKQh2rGZTVifMt8cp0LVNC1H1QweC1oHMv7XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732123559; c=relaxed/simple;
	bh=OukxcvuYbAjF2IpRnh6YueDrVeU11+4PREMq2VqaIZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqMvCqRbmLVDiKamWuS9zjF1a6+nxFhkJSWVoJP3Eenc9n+vD/6qmVlglHtB9tBCqWo4N0hWy/iuoCBPmCNLTNLIlq/bTTgv5hT9j+tiYdFRR29pHrAiH/OY45cNstnLMDbRV/kdGlI8rw/xicjR7+AIkoAWKD6eDvjrVMf7rRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXr7RqgF; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d382677c92so216266d6.3;
        Wed, 20 Nov 2024 09:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732123556; x=1732728356; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=z30aspXEoBEHiJnC4JIWQ9/vNVs7+/tW5NTFsJwAKK0=;
        b=gXr7RqgFLuE1Bui8cDXOeaOX+mxukrj5nQ5tt0uQeQ9y+UD5FDtDOfw1/ZSah2VbbR
         +unASeg5E5fYZo7wzfmbUb+Obbufwc441I1AfI168EnlyxGxR1t+tJs7qo2LuNJhZ8gN
         gs6GDWvkG5xJc1BKq7LuBfkX4cAEUqouPhQ/T+GI7nWpnVuI25s1hU5K95Gz8Urc+I5C
         YsVw/aATZQBPmkzAyum9TixYC+883tnCFVWcNvOIjQpQ3I09tzJQCxxF+xrRH+uxQBag
         DrQR2xn1GuInrkpoPjALv0jf6tW7+Er5zUOh76JWAqsh+vLjctBeEeM7ijgUQTRe1c6b
         NOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732123556; x=1732728356;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z30aspXEoBEHiJnC4JIWQ9/vNVs7+/tW5NTFsJwAKK0=;
        b=Ly6eCcVebYJsLRE3N1mNKXUJi2p2gteT1umg8kQNllf1gu1tOcoWZ+7MSTmMbfx5JQ
         mrVdmOtCMJ+iVD6oEIKq/Xcjbw7gKT8myEX4gdm6pVHDknFhyg30Y6L8iRwr+Uc2Hl4g
         3W5cm7dLg+YyMYFFchkMPTZEYU317YmhtKovIaUEnWhc8jg2lc7pQunBKcCocMVXb1Am
         r78/JE1d6czcTg9fs/Ba1A76Lx2VfH6yvqEu8XAYAUF10S0PN7f9gChlw32H4Lcmakya
         HMc0xvzOM+4b+G7B99hlQM5BojxjQiKj7y8jO7pB6n/gBFUmuZ9tOmrY/irqLCXHLvTF
         IzUg==
X-Forwarded-Encrypted: i=1; AJvYcCU8gRlBNIQoMjxBZZlf34P/jFPoF6DLC+kVzo1iplyVWkIPOUMGSqi4bv1MkvpmLqlwZHyYmPaOKlKIf/4=@vger.kernel.org, AJvYcCWMK0kgr1xg5Y79I3F0msRySZxATkD9ETCce+o3bpuXB4OHUosflCmmLNIJ4EonokqWn7QPmV/jk2PTLBv4mPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc8fACKrLLDP8tgUA6rlB1BVFIBYrCA1ZkQl5kIrqZc3A0ly/q
	dbN75cVZFQbMU0Gt4DeztWSugDrSFcn+DpN5J84AOQzrk+w/VHpWaHHq1Q==
X-Google-Smtp-Source: AGHT+IFrAM5ToDIrKi9vP0JNPTFZl8VCdd3BKNDB2f9k89GKzlEJdJbyhQwinKx41aZGEUbxWOxTIg==
X-Received: by 2002:a05:6214:dcf:b0:6d4:2594:631b with SMTP id 6a1803df08f44-6d43783390amr53083496d6.42.1732123556292;
        Wed, 20 Nov 2024 09:25:56 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380d6cc9sm13222666d6.29.2024.11.20.09.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 09:25:55 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4EC87120007A;
	Wed, 20 Nov 2024 12:25:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 20 Nov 2024 12:25:55 -0500
X-ME-Sender: <xms:oxs-Z65C7Jf8zmYT6YdzlkBf2qV_l6ECt7fMKRlZFIWkHHEDp5buyQ>
    <xme:oxs-Zz7U3pfcaJHm_QLR9Bq8YuExvFPRJRQn2n45n-012plIismWY2L-Vj8mUXDo3
    mG8CTaNTBPpY9IS7w>
X-ME-Received: <xmr:oxs-Z5dqGEHmkj1qQ4iCxjpYsYthMsirKMuWAQzAs9aIqGAiMefgs2LF1iES>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeeggddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepvefghfeuveekudetgfevudeuudejfeeltdfh
    gfehgeekkeeigfdukefhgfegleefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghl
    ihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepgh
    hmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduledpmhho
    uggvpehsmhhtphhouhhtpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdroh
    hrghdprhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphht
    thhopegrsgguihgvlhdrjhgrnhhulhhguhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    eprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrg
    ihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrhihghhuohdr
    nhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghilhdrtghomh
    dprhgtphhtthhopegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvg
X-ME-Proxy: <xmx:oxs-Z3J4QCF8zyN_qGi9n2X8Soyq5dEdvIyd56-z5m0Ncoppbona8Q>
    <xmx:oxs-Z-J4BTa6E3q5hIitOh2GybLtGlnO9S5gPYshanrdNubViv4nzw>
    <xmx:oxs-Z4wgLti2EEMj4LS-K9jdVnaY1iiLB3lJeHw7TwRujuA2-x7fPQ>
    <xmx:oxs-ZyI1j1hGWfa4pxtbVLKMmT-9uiqNTXccFSIMKHl15qrbmTohcA>
    <xmx:oxs-Z1b4vt4UHPuMiw0d8ZY5Lqf2Ehjc4bk4xgIEAX4-RxO4RHhZk9Tb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 12:25:54 -0500 (EST)
Date: Wed, 20 Nov 2024 09:25:53 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
	airlied@redhat.com
Subject: Re: [PATCH v3 0/2] rust: page: Add support for existing struct page
 mappings
Message-ID: <Zz4boXyYpdx4q35I@tardis.local>
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <Zz1sHZLruF5sv7JT@casper.infradead.org>
 <CAH5fLgiyHGQJxLxigvZDHPJ84s1fw_OXtdhGTd0pv_X3bCZUgA@mail.gmail.com>
 <Zz4MQO79vVFhgfJZ@tardis.local>
 <Zz4WFnyTWUDPsH4m@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zz4WFnyTWUDPsH4m@casper.infradead.org>

On Wed, Nov 20, 2024 at 05:02:14PM +0000, Matthew Wilcox wrote:
> On Wed, Nov 20, 2024 at 08:20:16AM -0800, Boqun Feng wrote:
> > On Wed, Nov 20, 2024 at 10:10:44AM +0100, Alice Ryhl wrote:
> > > On Wed, Nov 20, 2024 at 5:57 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Tue, Nov 19, 2024 at 01:24:01PM +0200, Abdiel Janulgue wrote:
> > > > > This series aims to add support for pages that are not constructed by an
> > > > > instance of the rust Page abstraction, for example those returned by
> > > > > vmalloc_to_page() or virt_to_page().
> > > > >
> > > > > Changes sinve v3:
> > > > > - Use the struct page's reference count to decide when to free the
> > > > >   allocation (Alice Ryhl, Boqun Feng).
> > > >
> > > > Bleh, this is going to be "exciting".  We're in the middle of a multi-year
> > > > project to remove refcounts from struct page.  The lifetime of a page
> > > > will be controlled by the memdesc that it belongs to.  Some of those
> > > > memdescs will have refcounts, but others will not.
> > > >
> > 
> > One question: will the page that doesn't have refcounts has an exclusive
> > owner? I.e. there is one owner that's responsible to free the page and
> > make sure other references to the page get properly invalidated (maybe
> > via RCU?)
> 
> It's up to the owner of the page how they want to manage freeing it.
> They can use a refcount (folios will still have a refcount, for example),
> or they can know when there are no more users of the page (eg slab knows
> when all objects in a slab are freed).  RCU is a possibility, but would
> be quite unusual I would think.  The model I'm looking for here is that
> 'page' is too low-level an object to have its own lifecycle; it's always
> defined by a higher level object.
> 

Ok, that makes sense. That's actually aligned with the direction we are
heading in this patch: make `struct Page` itself independent on how the
lifetime is maintained. Conceptually, say we can define folio in pure
Rust, it could be:

    struct Folio {
        head: Page, /* or a union of page */
	...
    }

and we can `impl AlwaysRefcounted for Folio`, which implies there is a
refcount inside. And we can also have a `Foo` being:

    struct Foo {
        inner: Page,
    }

which doesn't implement `AlwaysRefcounted`, and that suggests a
different way the page lifetime will be maintained.

> > > > We don't have a fully formed destination yet, so I can't give you a
> > > > definite answer to a lot of questions.  Obviously I don't want to hold
> > > > up the Rust project in any way, but I need to know that what we're trying
> > > > to do will be expressible in Rust.
> > > >
> > > > Can we avoid referring to a page's refcount?
> > > 
> > > I don't think this patch needs the refcount at all, and the previous
> > > version did not expose it. This came out of the advice to use put_page
> > > over free_page. Does this mean that we should switch to put_page but
> > > not use get_page?
> 
> Did I advise using put_page() over free_page()?  I hope I didn't say

We have some off-list discussion about free_page() doesn't always free
the page if you could remember.

> that.  I don't see a reason why binder needs to refcount its pages (nor
> use a mapcount on them), but I don't fully understand binder so maybe
> it does need a refcount.

I don't think binder needs it either, but I think Abdiel here has a
different usage than binder.

> 
> > I think the point is finding the exact lifetime model for pages, if it's
> > not a simple refcounting, then what it is? Besides, we can still
> > represent refcounting pages with `struct Page` and other pages with a
> > different type name. So as far as I can see, this patch is OK for now.
> 
> I don't want Page to have a refcount.  If you need something with a
> refcount, it needs to be called something else.

So if I understand correctly, what Abdiel needs here is a way to convert
a virtual address to the corresponding page, would it make sense to just
use folio in this case? Abdiel, what's the operation you are going to
call on the page you get?

Regards,
Boqun


