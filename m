Return-Path: <linux-kernel+bounces-416447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3928D9D44E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 01:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B8B282403
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 00:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BC0AD21;
	Thu, 21 Nov 2024 00:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9yfbmGU"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173C123098E;
	Thu, 21 Nov 2024 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732148655; cv=none; b=oWw67KHSheyLxoHwoVRSX44L3FO6pW1LFG6cJ+TDPQxyF+iAhL7hai3bRFR/A470sVfsfNG9qxFUdI3X4iVw9ZA8zEZKFYsGepTdXa/4Oa3PW2Mq05d0N/V/0LFcqwA8HGp86jNXNGNngFlq6aUUl0ELpkZuXX15NCMIQZ7Q3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732148655; c=relaxed/simple;
	bh=ZUhAPQ9mKqafxSd2jaoJb6s/NzYlNU+7tksO8IkLd8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hnfeq3kA/scghlddofuAZIdykt0FRhv9bgHahjV+feB6cok53ld6c+etibzU3r82dK323cLmpPDqbWeiUCUmEKz57Srtxqkb3qwQhHwdz0reK8Y9TCeiNdC2G8Xu5UoJSaNucAIdA3v+zhFNNxIv+MM1vW0fn9YMsy6953FXezM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9yfbmGU; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b35b1ca0c2so158400185a.0;
        Wed, 20 Nov 2024 16:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732148653; x=1732753453; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Crp+IcQCRiftgYHXyQw6BFOWQbGOsJ2xVelhVLyogFA=;
        b=a9yfbmGUcghcu+Czlcb4DIuB+EGXM4UBv3trWE7OW7BjfbM7THSeqJA4ikCor5dnGe
         GL51Ja9pK3ppEtAflV+VgzS21WdyGDobk0CySCsZIVqHvj2P0dsxShP9nnuSokULGGyA
         kagQvag47pvpHR3gsy/KiCCtS2Zg50aPlCCUYAEVxE1/M3Zj7Lr21sxNU8MZ7JDeosGK
         JcZTWjYWGFM2nOOQq1dGLOzYlCtGPWwIog9PKRITR7sSRqqCwVWVjPtdeob1Ia93asBz
         j2Y136uR5Q+FcydauMlbdRYiPibd4G/eXEinVkUTMo2fbjePmih9PvuXvAS8HcfC+PM8
         OblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732148653; x=1732753453;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Crp+IcQCRiftgYHXyQw6BFOWQbGOsJ2xVelhVLyogFA=;
        b=babqG+wxBMiGS226Pw9xHM+cQ3j/+95mJgXn4FYbopoYi0dLpNPG2eBAfwuzm2e29A
         +mV/RQ8J9pUDP2SMBUguHXj3DUzU2RtQeKlNr4w7O5KzhzIEVr7DMNhLzSArxCEYnSBC
         Dx2SLhcP3nPD+bW8nlCqGn0m9c5fUPhrRFwTPW3mC41knIO5VEYAauz0D0WBZEF1WAee
         DI7p/M7mQqvZPm0FcDm79VuMEvcrH3wns/YUB+QPrp7+1ovG9rzu9qGlNzjsB+pGFcwu
         f2YX0mpsMHIXZLTLCGcN8bFZdTSK0jCaLEY8fz5s8JsuQXqoVzRhReKMCY5nq7D7oQAc
         4yuw==
X-Forwarded-Encrypted: i=1; AJvYcCWrum4ZJxYKuexGpiewyP9RHdwBJ+ynWE2IcG2ybT+LYU7p6dwwnaApAVAiMj34NLe0wfqTseYK11pU+LnKXLk=@vger.kernel.org, AJvYcCXQr/3GmYW8Gs5vWY2nwAzssXKucbSsawOvz1LCxhaNtqG6Scht/NpNq4xFLGWIMcF0XFHq1/TNzqWx4+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ+9jROCu+l7WX0TPyir6WknXW4fgC1rp4nzhMcMbKWA9SnsF3
	nDZobVZ8Zo+wwyIG8FnFRxPB+kRCKOHI3o1Hec1zpNPEYA2DRpUe
X-Google-Smtp-Source: AGHT+IEBDDj0Raio/gPETKzVbxOw7TpObvjm7y/a3RwxurvYsIKjuFIgxdHo4/kTlZbbvmfHus/ggw==
X-Received: by 2002:ad4:5ce9:0:b0:6c3:6477:16e7 with SMTP id 6a1803df08f44-6d4423b38a8mr23112616d6.11.1732148652822;
        Wed, 20 Nov 2024 16:24:12 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d43814e9bdsm16427066d6.126.2024.11.20.16.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 16:24:12 -0800 (PST)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id B59321200066;
	Wed, 20 Nov 2024 19:24:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 20 Nov 2024 19:24:11 -0500
X-ME-Sender: <xms:q30-Z8ajeb-58lMXo8BPI95MWA-Cg6yG2QrpuL38NsOJc_7QExe35A>
    <xme:q30-Z3a7bMYt4IRG_z8oIqylrFMDAlUWvn6_7Mcy2hqF3XzcH09zq5xFHHPE_LEJZ
    yJCYYGWlyZMcBwh_g>
X-ME-Received: <xmr:q30-Z28t4EiQueBZQEdu9kr9YkzNUJaVm5SCUa_moya1xiBJQf6zW5yJ4dER>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpeevgffhueevkedutefgveduuedujeefledthffg
    heegkeekiefgudekhffggeelfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegrsgguihgvlhdrjhgrnhhulhhguhgvsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdp
    rhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhi
    hnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhn
    vghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpd
    hrtghpthhtohepsggvnhhnohdrlhhoshhsihhnsehprhhothhonhdrmhgv
X-ME-Proxy: <xmx:q30-Z2p-fNn5CyeCy5yADD9IA9Hh2yCAcoPopRNUrmnLDKtmeG1j2Q>
    <xmx:q30-Z3rTkCVYyt9Bdx8nylboB_vrUxw9gORpeeQGEf2W1UzDVYj_WA>
    <xmx:q30-Z0RDCF4nJMFMu9MX4FyWxy0kLeI_ymLeKzIFqAS6XGFOkot4qw>
    <xmx:q30-Z3pNQeMvcQ4KQz1lAfpvAvkmCDoLWvnAMqCktDMkvmND62s7eQ>
    <xmx:q30-Z85lkq8ihNaItOl5ovyCo3Rc1BdQO13y-NifjlJlhfDy0Zy2W3aZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 19:24:11 -0500 (EST)
Date: Wed, 20 Nov 2024 16:24:10 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Alice Ryhl <aliceryhl@google.com>,
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
Message-ID: <Zz59qgqKruqnouTl@tardis.local>
References: <20241119112408.779243-1-abdiel.janulgue@gmail.com>
 <Zz1sHZLruF5sv7JT@casper.infradead.org>
 <CAH5fLgiyHGQJxLxigvZDHPJ84s1fw_OXtdhGTd0pv_X3bCZUgA@mail.gmail.com>
 <Zz4MQO79vVFhgfJZ@tardis.local>
 <Zz4WFnyTWUDPsH4m@casper.infradead.org>
 <Zz4boXyYpdx4q35I@tardis.local>
 <98a46b27-c4bb-4540-8f75-f176c3f2fae1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98a46b27-c4bb-4540-8f75-f176c3f2fae1@gmail.com>

On Thu, Nov 21, 2024 at 12:56:38AM +0200, Abdiel Janulgue wrote:
> On 20/11/2024 19:25, Boqun Feng wrote:
> > On Wed, Nov 20, 2024 at 05:02:14PM +0000, Matthew Wilcox wrote:
> > > On Wed, Nov 20, 2024 at 08:20:16AM -0800, Boqun Feng wrote:
> > > > On Wed, Nov 20, 2024 at 10:10:44AM +0100, Alice Ryhl wrote:
> > > > > On Wed, Nov 20, 2024 at 5:57 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > > > > 
> > > > > > On Tue, Nov 19, 2024 at 01:24:01PM +0200, Abdiel Janulgue wrote:
> > > > > > > This series aims to add support for pages that are not constructed by an
> > > > > > > instance of the rust Page abstraction, for example those returned by
> > > > > > > vmalloc_to_page() or virt_to_page().
> > > > > > > 
> > > > > > > Changes sinve v3:
> > > > > > > - Use the struct page's reference count to decide when to free the
> > > > > > >    allocation (Alice Ryhl, Boqun Feng).
> > > > > > 
> > > > > > Bleh, this is going to be "exciting".  We're in the middle of a multi-year
> > > > > > project to remove refcounts from struct page.  The lifetime of a page
> > > > > > will be controlled by the memdesc that it belongs to.  Some of those
> > > > > > memdescs will have refcounts, but others will not.
> > > > > > 
> > > > 
> > > > One question: will the page that doesn't have refcounts has an exclusive
> > > > owner? I.e. there is one owner that's responsible to free the page and
> > > > make sure other references to the page get properly invalidated (maybe
> > > > via RCU?)
> > > 
> > > It's up to the owner of the page how they want to manage freeing it.
> > > They can use a refcount (folios will still have a refcount, for example),
> > > or they can know when there are no more users of the page (eg slab knows
> > > when all objects in a slab are freed).  RCU is a possibility, but would
> > > be quite unusual I would think.  The model I'm looking for here is that
> > > 'page' is too low-level an object to have its own lifecycle; it's always
> > > defined by a higher level object.
> > > 
> > 
> > Ok, that makes sense. That's actually aligned with the direction we are
> > heading in this patch: make `struct Page` itself independent on how the
> > lifetime is maintained. Conceptually, say we can define folio in pure
> > Rust, it could be:
> > 
> >      struct Folio {
> >          head: Page, /* or a union of page */
> > 	...
> >      }
> > 
> > and we can `impl AlwaysRefcounted for Folio`, which implies there is a
> > refcount inside. And we can also have a `Foo` being:
> > 
> >      struct Foo {
> >          inner: Page,
> >      }
> > 
> > which doesn't implement `AlwaysRefcounted`, and that suggests a
> > different way the page lifetime will be maintained.
> > 
> > > > > > We don't have a fully formed destination yet, so I can't give you a
> > > > > > definite answer to a lot of questions.  Obviously I don't want to hold
> > > > > > up the Rust project in any way, but I need to know that what we're trying
> > > > > > to do will be expressible in Rust.
> > > > > > 
> > > > > > Can we avoid referring to a page's refcount?
> > > > > 
> > > > > I don't think this patch needs the refcount at all, and the previous
> > > > > version did not expose it. This came out of the advice to use put_page
> > > > > over free_page. Does this mean that we should switch to put_page but
> > > > > not use get_page?
> > > 
> > > Did I advise using put_page() over free_page()?  I hope I didn't say
> > 
> > We have some off-list discussion about free_page() doesn't always free
> > the page if you could remember.
> > 
> > > that.  I don't see a reason why binder needs to refcount its pages (nor
> > > use a mapcount on them), but I don't fully understand binder so maybe
> > > it does need a refcount.
> > 
> > I don't think binder needs it either, but I think Abdiel here has a
> > different usage than binder.
> > 
> > > 
> > > > I think the point is finding the exact lifetime model for pages, if it's
> > > > not a simple refcounting, then what it is? Besides, we can still
> > > > represent refcounting pages with `struct Page` and other pages with a
> > > > different type name. So as far as I can see, this patch is OK for now.
> > > 
> > > I don't want Page to have a refcount.  If you need something with a
> > > refcount, it needs to be called something else.
> > 
> > So if I understand correctly, what Abdiel needs here is a way to convert
> > a virtual address to the corresponding page, would it make sense to just
> > use folio in this case? Abdiel, what's the operation you are going to
> > call on the page you get?
> 
> Yes that's basically it. The goal here is represent those existing struct
> page within this rust Page abstraction but at the same time to avoid taking
> over its ownership.
> 
> Boqun, Alice, should we reconsider Ownable and Owned trait again? :)
> 

Could you use folio in your case? If so, we can provide a simple binding
for folio which should be `AlwaysRefcounted`, and re-investigate how
page should be wrapped.

Regards,
Boqun

> Regards,
> Abdiel

