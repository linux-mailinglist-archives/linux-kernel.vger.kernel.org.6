Return-Path: <linux-kernel+bounces-260414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A6893A895
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E0161F2351E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 908DF14430C;
	Tue, 23 Jul 2024 21:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JP9c+fS7"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383ED142631
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 21:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721769247; cv=none; b=TDuOiBBWKToR5yqfpmB/GSWV9oBSLYvOCwCs22ShIciTx3xEXTWfygTCHb3y9G54n4vr4QbU3/VJVSAHHhoC1M2Q3VD2z8JD/nuvWTMQJXnsBQ+vUOKqP3ObKn/OsgVkR9ZMTxNKYBoE/dm11ZE2biWiDVlpEkGZ6V6qrH1jLQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721769247; c=relaxed/simple;
	bh=AdoPjuZDxlWGn1Ik+ckAhLhyJtoOdZ9SFOVUO4jlM8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VD2U2co1cLhVA4jXRNbBX22kC/OMUS14bL7zCre8labcWQfLQYZVanEIRpv9kSOLFuDWKl0VuiHI/Ixw4v/LUPn3UsDY1kybBu5ADgQi25iQKIlVecCcZdt3CG8t20uGuyow0WB6+IDoTJ2FjAoSsySrSF8f5N10fd2Z6n5HkMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JP9c+fS7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b796667348so2554286d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721769245; x=1722374045; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/7hLmssIAAEjIHO1+cGxc/393ZdhjH3wSNqOUr79Ys=;
        b=JP9c+fS7ZMRClzivpxkA0n+wnZBxJWS4JJbfeHTlVjBOX1cIofz69myph5VbQ6KSOt
         EjycgTBQa4U7Vp454rrzKIqOGIJWTMQvzrqXQQPyAOtr73w8EmslniHCHsDwoFmnEX0Z
         BK5JXSLuGHf9m/iqFnPzETuXp0pXv7f5rD1ph+WT8i7cu53pKvf4N5rrjAvXp22mGJ3M
         fEKPoKKMmFqjl1R87tZ1BipDO9d4IBK/KS7lSOts7JI8BBS1t4KVOk2IKaQ74FIHmizc
         qji2rZXqbZU+HJe8I7if5Ajalr0ETb7UPU6fojA5TSF8MR6XNgUYNxrOap+A1vRgLSiJ
         udXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721769245; x=1722374045;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/7hLmssIAAEjIHO1+cGxc/393ZdhjH3wSNqOUr79Ys=;
        b=nVd/UxKzs1pGgJIuVl0rS/wS+rmvx3NYV9f01qyvuo4PufnWgBGy201DAN7kgbXSp5
         Q/eKu53/3XALRInxR1zr0pWT2bUuj7z8RTcsYgM6nya7OqRs8XyVDT9ZncS2vcGJngDE
         gQytBZpH+0WLCKwkPELjHj9bz8AZB14Gb0Yo1iHGBL8hl3T0ucyVhvzajUiRWhs4EkxH
         mSGdvBzNKNpBHgfD+aVgBYNVh4yELk15N9164Pkywy+dozaNwyQ3cMAvjovIsOPL1ZDM
         4Q/egQOt7zEib0lxk/zac8hsiB6MVYvMgILvmejKTfCvbQRt4MB70Az0KYTK2mLiBI69
         MYTA==
X-Forwarded-Encrypted: i=1; AJvYcCVKD4hu7Pp39SPo/XeeIs9VjC4yiwSwpYf6O0xhOz7+3GbQdxkih9/QeLAHRoxi8smXMZCvOTTiOWAkbw3k3vHmY6jtQj1PwGs7iS0F
X-Gm-Message-State: AOJu0YxUY3WAAQlODqKMa2xEWVfLQjErHpW3xmigv6pLWafOmySDGB12
	sfaxEL4/7+27gIDfx0YPQxc79Mgu86JlghpC5mDc8t/9cp3OZfmW
X-Google-Smtp-Source: AGHT+IGTry2e+jrdjK9teV2i9t7dlX6iuJTX6lh/JsjsJBDQe6e5gOfVVeWNHImQUonDn2OKKLE42w==
X-Received: by 2002:a05:6214:5ecf:b0:6b5:2a29:cd08 with SMTP id 6a1803df08f44-6b9843b6a0cmr53240996d6.27.1721769245065;
        Tue, 23 Jul 2024 14:14:05 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b7acb0972csm50981126d6.136.2024.07.23.14.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 14:14:04 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id F29CF1200068;
	Tue, 23 Jul 2024 17:14:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 23 Jul 2024 17:14:02 -0400
X-ME-Sender: <xms:GR2gZsooc2iht3FOiqyTYJPnX8wQB2OhhRPKP0IfJV9LllvA9UatHw>
    <xme:GR2gZir22_1ZtdzuMUXs6IWr5KwmZ3xRBGgWbxmVEZD1ZH7x8zhFCt2WhjUUQNxC8
    uHmExOyFTSzqh20QQ>
X-ME-Received: <xmr:GR2gZhPk6QeyDM9b21x6bsZo4b6IWAo5hXPyjqzkCWelABF2LFHs0efCHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgdduheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvgdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:GR2gZj6a5oEhE8QvhHh8DKbEAehR0cQlje7k3DrqxvM1mojLxXJnNQ>
    <xmx:GR2gZr4kL69YhjWGGtt7NN29JMIG_o_TZ2kCgMT2oA7lXVgGotgBog>
    <xmx:GR2gZjj1IxY_HSWxY4iPjGplQUEXG1XMHWj5bmJUw9UWkttA4cKFuQ>
    <xmx:GR2gZl5K3c3DVOaTn-kl8sr0ndmOTQM6VyLX0KM21Uvm8t-3d5nrGg>
    <xmx:GR2gZuLqYZOTQKCx2_yMl7n8fFwGQjZEGBVOFptJDUy-Vh2XqmkcG5oD>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 17:14:01 -0400 (EDT)
Date: Tue, 23 Jul 2024 14:14:00 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Dennis Zhou <dennis@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, kernel test robot <oliver.sang@intel.com>,
	Suren Baghdasaryan <surenb@google.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Benno Lossin <benno.lossin@proton.me>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Christoph Lameter <cl@linux.com>, Gary Guo <gary@garyguo.net>,
	Miguel Ojeda <ojeda@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Wedson Almeida Filho <wedsonaf@gmail.com>, linux-mm@kvack.org,
	lkmm@lists.linux.dev
Subject: Re: [linus:master] [mm]  24e44cc22a:
 BUG:KCSAN:data-race_in_pcpu_alloc_noprof/pcpu_block_update_hint_alloc
Message-ID: <ZqAdGAD01kZPms2J@Boquns-Mac-mini.home>
References: <202407191651.f24e499d-oliver.sang@intel.com>
 <Zp6bMoDnUMxNrKos@boqun-archlinux>
 <Zp6cVgXJlzF4VOwl@slm.duckdns.org>
 <Zp6e1PWZbz4pkh9Z@boqun-archlinux>
 <Zp6kpCcQRPTGk1LK@V92F7Y9K0C.lan>
 <Zp7G4EfISRwlmmIT@boqun-archlinux>
 <Zp9EvUTqni5wMDlC@snowbird>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp9EvUTqni5wMDlC@snowbird>

On Mon, Jul 22, 2024 at 10:50:53PM -0700, Dennis Zhou wrote:
> On Mon, Jul 22, 2024 at 01:53:52PM -0700, Boqun Feng wrote:
> > On Mon, Jul 22, 2024 at 11:27:48AM -0700, Dennis Zhou wrote:
> > > Hello,
> > > 
> > > On Mon, Jul 22, 2024 at 11:03:00AM -0700, Boqun Feng wrote:
> > > > On Mon, Jul 22, 2024 at 07:52:22AM -1000, Tejun Heo wrote:
> > > > > On Mon, Jul 22, 2024 at 10:47:30AM -0700, Boqun Feng wrote:
> > > > > > This looks like a data race because we read pcpu_nr_empty_pop_pages out
> > > > > > of the lock for a best effort checking, @Tejun, maybe you could confirm
> > > > > > on this?
> > > > > 
> > > > > That does sound plausible.
> > > > > 
> > > > > > -       if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> > > > > > +       /*
> > > > > > +        * Checks pcpu_nr_empty_pop_pages out of the pcpu_lock, data races may
> > > > > > +        * occur but this is just a best-effort checking, everything is synced
> > > > > > +        * in pcpu_balance_work.
> > > > > > +        */
> > > > > > +       if (data_race(pcpu_nr_empty_pop_pages) < PCPU_EMPTY_POP_PAGES_LOW)
> > > > > >                 pcpu_schedule_balance_work();
> > > > > 
> > > > > Would it be better to use READ/WRITE_ONCE() for the variable?
> > > > > 
> > > > 
> > > > For READ/WRITE_ONCE(), we will need to replace all write accesses and
> > > > all out-of-lock read accesses to pcpu_nr_empty_pop_pages, like below.
> > > > It's better in the sense that it doesn't rely on compiler behaviors on
> > > > data races, not sure about the performance impact though.
> > > > 
> > > 
> > > I think a better alternative is we can move it up into the lock under
> > > area_found. The value gets updated as part of pcpu_alloc_area() as the
> > > code above populates percpu memory that is already allocated.
> > > 
> > 
> > Not sure I followed what exactly you suggested here because I'm not
> > familiar with the logic, but a simpler version would be:
> > 
> > 
> 
> I believe that's the only naked access of pcpu_nr_empty_pop_pages. So
> I was thinking this'll fix this problem.
> 
> I also don't know how to rerun this CI tho..
> 
> ---
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 20d91af8c033..325fb8412e90 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -1864,6 +1864,10 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
>  
>  area_found:
>  	pcpu_stats_area_alloc(chunk, size);
> +
> +	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> +		pcpu_schedule_balance_work();
> +

But the pcpu_chunk_populated() afterwards could modify the
pcpu_nr_empty_pop_pages again, wouldn't this be a behavior changing?

Regards,
Boqun

>  	spin_unlock_irqrestore(&pcpu_lock, flags);
>  
>  	/* populate if not all pages are already there */
> @@ -1891,9 +1895,6 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
>  		mutex_unlock(&pcpu_alloc_mutex);
>  	}
>  
> -	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> -		pcpu_schedule_balance_work();
> -
>  	/* clear the areas and return address relative to base address */
>  	for_each_possible_cpu(cpu)
>  		memset((void *)pcpu_chunk_addr(chunk, cpu, 0) + off, 0, size);

