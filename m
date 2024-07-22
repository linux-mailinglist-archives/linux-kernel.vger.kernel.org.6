Return-Path: <linux-kernel+bounces-259377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A99939500
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2166281CDE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F8038DCC;
	Mon, 22 Jul 2024 20:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U03xF/i0"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672FA1C6A8
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681658; cv=none; b=m3JlPxv99kKsue87w8kaXEmtFZIJxXj+ma14ixfMiasCXVfmIMXkG/aTuaTbT1OJXgQ0+7gtE7jEZakB4mnXr670aoGT6z6q2FW6oQFUEnxmDf1zmbL6jlxBXh0QxDjvrR/I74pDiOwG8DM0p+wkBfxIXNmP+9vejKTOLiBE52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681658; c=relaxed/simple;
	bh=Nmg7tipjeMlBLpHRnUsaCDod3yA5set2b/Z/YjE2uUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWS2v/bt2jRwBaGDLREhefCjRY1v0O1BxX/2qR7TgwLJ0NbNBRrDgKQB+2HQ4XlJl1sTsCUC2lA8N+DbJK+IEex6PYr2dutzR74Bl3iAneZ/BNubcQHYzcPaRQRSfl5H3Dc2X+2D6kWaR6YqPj+rjTwOkf01MUEYdweH0Am1b7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U03xF/i0; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7a1a6af940cso200006185a.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721681654; x=1722286454; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6TvImu7lxiWaBHweYLVQLFGqyazvpOghutfGgukQ2U=;
        b=U03xF/i00wJOZaDOubjZHKZ5PzGT75tJtdY8DikN+rYEqL0l/0y0qxJQR1QjRfuTRl
         ACyhQN54c29yuwSvLqf1hEQmNNsI5LSP+WdM+c01VmWgaULQC2TmGFbySVIzO6EWSd43
         Cmcqn9xDpLn7qHRFXGEp/juHTOToLOFrfqU2LU5dxyP0EVD5kPEsx2sDKt7W0B/zEzWg
         2A1S8ne85877aY8MsCZ9TqJwKr66ZyrlUVKG0glXrJ8cR7gauz7+NwVZlmvXp+APor56
         5lh1Za9UaY/IyIXWwCDJrnqrLIG8XRfsp2a8WfaTt4Dc7uMtThr7Gm0r3s/yiwq5MUnr
         v7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721681654; x=1722286454;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q6TvImu7lxiWaBHweYLVQLFGqyazvpOghutfGgukQ2U=;
        b=Ys2vwBoApSkRXbKTciK/cTQdg1ri49gt5TiltExes3fpPk7dvZc/v6/3uspDypfH5n
         iGLQbsCMM1g7ZlGmC/ifOf0KRS7eMJ7W1dAhUIZD4ZC/QCZb0uJGTdOaZ8qTSP8ZmMLJ
         Kibl8ghsi8M8b03zHBCLb82vDnfmmvh4/1cOF+GdxQUjcNvEJbU1LGEe45TR4mv0kM40
         it2crY/W1kZbeRSWUW1HTnP1ecQdvvqCtXwuja+FC8IQig+u3wBs/XMs7asb7z+i+lZa
         tVMsp1pIUR1+EyHaoxyQD6cHt4PFjrs1JsN0dgazCp3bSnEUSP2OjTN/B2aUycbN8X9s
         pVng==
X-Forwarded-Encrypted: i=1; AJvYcCVTZerlSSFD3JOJijMHlA60i7j9ijfoza3J8SITZklg9O0XYzHdTrOz4XeJMd1aKcspcHnSQdJajg28JDjWO+SdJ2gWGwtYcgKM1kkR
X-Gm-Message-State: AOJu0YwsKtKf3TNTlt9+O6n9nmYEbST+byhjJUDxsNUZsaFB5nZXzAc1
	1o8TZ+B0US8uJ5rJeabnJT8ptY/Pk9PqpwXyhjJI4d2h9itSWGxU
X-Google-Smtp-Source: AGHT+IG8mTdIdLQoFIkii7HnHE3YfignHoBS5qpYfDrVTqbFjX9tSgTcfCzDyWhCt6oeodE+3Og+6w==
X-Received: by 2002:a05:620a:290b:b0:79f:17f4:7154 with SMTP id af79cd13be357-7a1c2eb92cbmr16040785a.3.1721681654300;
        Mon, 22 Jul 2024 13:54:14 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198fba3cfsm402155285a.33.2024.07.22.13.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 13:54:13 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfauth.nyi.internal (Postfix) with ESMTP id A744E1200066;
	Mon, 22 Jul 2024 16:54:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 22 Jul 2024 16:54:11 -0400
X-ME-Sender: <xms:88aeZiqK74G7AS0aTwxDU1U26s44ojXELHpKQ7MIT2t2ROcsR6KF3Q>
    <xme:88aeZgqszZuyWb2T7CsK-CeL2ClLpbhvsmdkPI1LJwgXV6O2qcCM2-j778pBW1J5I
    hcQpXDm44A1SiW_SQ>
X-ME-Received: <xmr:88aeZnOUu1veQiasTqp_BpRXaKf6Lz4L7rLWLFwC4LokKeAR8GMVDVgLWqniEg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheejgdduheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:88aeZh7zJG9cNFoh3X5T_Lkkq0zO0X9QVXWAlvWZMz9jCwHIlesEnw>
    <xmx:88aeZh48FOU_QvX3499nkaWwbHiOAaEaFzkWkFq_zLe0hzbDt-a6JQ>
    <xmx:88aeZhgpL6hqh6P_GESimjxVXkYQmLA3qDanh0dECrq3uvqesphZKQ>
    <xmx:88aeZr6gvR9rUP3J6wxFI82ZTNL4aKmtXGywkQXCRUa86kaj4zLRIw>
    <xmx:88aeZsLxAN5Tg2QYEvBzKs_Cg6U_jwiJP1n8Yre6cczV9tBy1Oe8HIIr>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jul 2024 16:54:11 -0400 (EDT)
Date: Mon, 22 Jul 2024 13:53:52 -0700
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
Message-ID: <Zp7G4EfISRwlmmIT@boqun-archlinux>
References: <202407191651.f24e499d-oliver.sang@intel.com>
 <Zp6bMoDnUMxNrKos@boqun-archlinux>
 <Zp6cVgXJlzF4VOwl@slm.duckdns.org>
 <Zp6e1PWZbz4pkh9Z@boqun-archlinux>
 <Zp6kpCcQRPTGk1LK@V92F7Y9K0C.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp6kpCcQRPTGk1LK@V92F7Y9K0C.lan>

On Mon, Jul 22, 2024 at 11:27:48AM -0700, Dennis Zhou wrote:
> Hello,
> 
> On Mon, Jul 22, 2024 at 11:03:00AM -0700, Boqun Feng wrote:
> > On Mon, Jul 22, 2024 at 07:52:22AM -1000, Tejun Heo wrote:
> > > On Mon, Jul 22, 2024 at 10:47:30AM -0700, Boqun Feng wrote:
> > > > This looks like a data race because we read pcpu_nr_empty_pop_pages out
> > > > of the lock for a best effort checking, @Tejun, maybe you could confirm
> > > > on this?
> > > 
> > > That does sound plausible.
> > > 
> > > > -       if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> > > > +       /*
> > > > +        * Checks pcpu_nr_empty_pop_pages out of the pcpu_lock, data races may
> > > > +        * occur but this is just a best-effort checking, everything is synced
> > > > +        * in pcpu_balance_work.
> > > > +        */
> > > > +       if (data_race(pcpu_nr_empty_pop_pages) < PCPU_EMPTY_POP_PAGES_LOW)
> > > >                 pcpu_schedule_balance_work();
> > > 
> > > Would it be better to use READ/WRITE_ONCE() for the variable?
> > > 
> > 
> > For READ/WRITE_ONCE(), we will need to replace all write accesses and
> > all out-of-lock read accesses to pcpu_nr_empty_pop_pages, like below.
> > It's better in the sense that it doesn't rely on compiler behaviors on
> > data races, not sure about the performance impact though.
> > 
> 
> I think a better alternative is we can move it up into the lock under
> area_found. The value gets updated as part of pcpu_alloc_area() as the
> code above populates percpu memory that is already allocated.
> 

Not sure I followed what exactly you suggested here because I'm not
familiar with the logic, but a simpler version would be:


diff --git a/mm/percpu.c b/mm/percpu.c
index 20d91af8c033..fc54d27e5786 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1891,8 +1891,10 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 		mutex_unlock(&pcpu_alloc_mutex);
 	}
 
-	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
-		pcpu_schedule_balance_work();
+	scoped_guard(spinlock_irqsave, &pcpu_lock) {
+		if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
+			pcpu_schedule_balance_work();
+	}
 
 	/* clear the areas and return address relative to base address */
 	for_each_possible_cpu(cpu)

I.e. just locking while checking.

Regards,
Boqun

> We should probably annotate pcpu_update_empty_pages() with:
>     lockdep_assert_held(&pcpu_lock);
> 
> Thanks,
> Dennis
> 
> > Regards,
> > Boqun
> > 
> > ----->8
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 20d91af8c033..729e8188238b 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -570,7 +570,8 @@ static void pcpu_isolate_chunk(struct pcpu_chunk *chunk)
> >  
> >  	if (!chunk->isolated) {
> >  		chunk->isolated = true;
> > -		pcpu_nr_empty_pop_pages -= chunk->nr_empty_pop_pages;
> > +		WRITE_ONCE(pcpu_nr_empty_pop_pages,
> > +			   pcpu_nr_empty_pop_pages - chunk->nr_empty_pop_pages);
> >  	}
> >  	list_move(&chunk->list, &pcpu_chunk_lists[pcpu_to_depopulate_slot]);
> >  }
> > @@ -581,7 +582,8 @@ static void pcpu_reintegrate_chunk(struct pcpu_chunk *chunk)
> >  
> >  	if (chunk->isolated) {
> >  		chunk->isolated = false;
> > -		pcpu_nr_empty_pop_pages += chunk->nr_empty_pop_pages;
> > +		WRITE_ONCE(pcpu_nr_empty_pop_pages,
> > +			   pcpu_nr_empty_pop_pages + chunk->nr_empty_pop_pages);
> >  		pcpu_chunk_relocate(chunk, -1);
> >  	}
> >  }
> > @@ -599,7 +601,8 @@ static inline void pcpu_update_empty_pages(struct pcpu_chunk *chunk, int nr)
> >  {
> >  	chunk->nr_empty_pop_pages += nr;
> >  	if (chunk != pcpu_reserved_chunk && !chunk->isolated)
> > -		pcpu_nr_empty_pop_pages += nr;
> > +		WRITE_ONCE(pcpu_nr_empty_pop_pages,
> > +			   pcpu_nr_empty_pop_pages + nr);
> >  }
> >  
> >  /*
> > @@ -1891,7 +1894,7 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
> >  		mutex_unlock(&pcpu_alloc_mutex);
> >  	}
> >  
> > -	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> > +	if (READ_ONCE(pcpu_nr_empty_pop_pages) < PCPU_EMPTY_POP_PAGES_LOW)
> >  		pcpu_schedule_balance_work();
> >  
> >  	/* clear the areas and return address relative to base address */
> > @@ -2754,7 +2757,7 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
> >  	tmp_addr = (unsigned long)base_addr + static_size + ai->reserved_size;
> >  	pcpu_first_chunk = pcpu_alloc_first_chunk(tmp_addr, dyn_size);
> >  
> > -	pcpu_nr_empty_pop_pages = pcpu_first_chunk->nr_empty_pop_pages;
> > +	WRITE_ONCE(pcpu_nr_empty_pop_pages, pcpu_first_chunk->nr_empty_pop_pages);
> >  	pcpu_chunk_relocate(pcpu_first_chunk, -1);
> >  
> >  	/* include all regions of the first chunk */
> > 

