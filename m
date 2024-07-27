Return-Path: <linux-kernel+bounces-263953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A7393DD13
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 05:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0004F285056
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 03:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5F31B86E8;
	Sat, 27 Jul 2024 03:15:14 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D50417E9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 03:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722050113; cv=none; b=DGZtOjUk01d6aXVc/Of/NOYwFHEeTxj4+fdBhfDvfZhYwfyMRyeoMaekAHuLU3lJs63ciC9I7KpM95zfcT8851W5nc5O8OLQdCYL0P4JcAsxhruqkFycr96h4ASlKs7iDbz+kXSpX0VbZaNyZF36i+Jjo5PGCWdfTUNLcNnWOz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722050113; c=relaxed/simple;
	bh=vfWLMUCNQqdCjzCDTMhi+pl6nCwaPxvVUzyCErSQoDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGxoIGfeKM1bs8Lc0V1OapSxOP4htO6oNZTQmmKw5Hj5U6WPIuBqH4KRlm/p54N11wf4uPQV1jhYzz8NZmmvVGmlHkVgBR+rsA4azH9k3hkcVbKTQq0Xq3D8AHcAcetuhUpk/KqDJh7cLac8Ifcnwsd60W/NL9fyizdJ8hHKsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fc5239faebso10010685ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722050111; x=1722654911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLRbFlYw1y7KC9S4hQ5ZFyFBozLVkK+PnMW946p6k3U=;
        b=lF1tzn8oMoN5G0/Eyt8z95fIM1uGeycZiDBR4CD6o9DSwQ1No7KIDBEOUempoW5Ffy
         QR6NKI6xWKuFqGoaNUzO4PNnV+kPdJ8OdsL1u4ZGB7R4DMkjl21icfw68wei32g/0LE+
         sICAIHnkFWL/zRy5jjg9rcS7sCkjHNPye4xBSF4K76iE1TDdwulir3N81T09nQB1aOUS
         qIGn0TGYcpwrNQvZIV03Nuu/eaWjzWtzSNOk5Z0VeiI4HLBDeS+s7l+TdGkITRHLh9wo
         mx1qnhE5FVOx1lEagJph/U0Gzj6u98uv4P6F0MVXbry1OYjuxwDqxuXvQNCanyMk8XWS
         G0pw==
X-Forwarded-Encrypted: i=1; AJvYcCWt17OVdybXjgXZQmeGU49tsHXfGUWcLt83mT20REgTuyocyoWQpYa0aeABNIW0F/hhO5c/mpdj6BjNBoQ811T5g0KtDMbFZQd/GLlC
X-Gm-Message-State: AOJu0YyPOuoUdfMGvhSDLlxok/sU+8U8Azk0mYvW2Y1E7mX7/bAAiWND
	9207isO/oXdNr5O6j/sVk/h13lk7WAlx3k0fM9Qrrpsf35oRqCpa
X-Google-Smtp-Source: AGHT+IEh0vRQcYCjKacpBe+tlN5TG/wqG8G56zuBfhH316hJWOb2texq/hSHkLPuAMlU+eKcHwai8g==
X-Received: by 2002:a17:903:228c:b0:1fd:6766:6848 with SMTP id d9443c01a7336-1ff0481b9d3mr18339475ad.17.1722050111104;
        Fri, 26 Jul 2024 20:15:11 -0700 (PDT)
Received: from snowbird ([136.25.84.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7f62fsm40488975ad.19.2024.07.26.20.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 20:15:10 -0700 (PDT)
Date: Fri, 26 Jul 2024 20:15:07 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
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
Message-ID: <ZqRmO6LNol6S65dm@snowbird>
References: <202407191651.f24e499d-oliver.sang@intel.com>
 <Zp6bMoDnUMxNrKos@boqun-archlinux>
 <Zp6cVgXJlzF4VOwl@slm.duckdns.org>
 <Zp6e1PWZbz4pkh9Z@boqun-archlinux>
 <Zp6kpCcQRPTGk1LK@V92F7Y9K0C.lan>
 <Zp7G4EfISRwlmmIT@boqun-archlinux>
 <Zp9EvUTqni5wMDlC@snowbird>
 <ZqAdGAD01kZPms2J@Boquns-Mac-mini.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqAdGAD01kZPms2J@Boquns-Mac-mini.home>

On Tue, Jul 23, 2024 at 02:14:00PM -0700, Boqun Feng wrote:
> On Mon, Jul 22, 2024 at 10:50:53PM -0700, Dennis Zhou wrote:
> > On Mon, Jul 22, 2024 at 01:53:52PM -0700, Boqun Feng wrote:
> > > On Mon, Jul 22, 2024 at 11:27:48AM -0700, Dennis Zhou wrote:
> > > > Hello,
> > > > 
> > > > On Mon, Jul 22, 2024 at 11:03:00AM -0700, Boqun Feng wrote:
> > > > > On Mon, Jul 22, 2024 at 07:52:22AM -1000, Tejun Heo wrote:
> > > > > > On Mon, Jul 22, 2024 at 10:47:30AM -0700, Boqun Feng wrote:
> > > > > > > This looks like a data race because we read pcpu_nr_empty_pop_pages out
> > > > > > > of the lock for a best effort checking, @Tejun, maybe you could confirm
> > > > > > > on this?
> > > > > > 
> > > > > > That does sound plausible.
> > > > > > 
> > > > > > > -       if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> > > > > > > +       /*
> > > > > > > +        * Checks pcpu_nr_empty_pop_pages out of the pcpu_lock, data races may
> > > > > > > +        * occur but this is just a best-effort checking, everything is synced
> > > > > > > +        * in pcpu_balance_work.
> > > > > > > +        */
> > > > > > > +       if (data_race(pcpu_nr_empty_pop_pages) < PCPU_EMPTY_POP_PAGES_LOW)
> > > > > > >                 pcpu_schedule_balance_work();
> > > > > > 
> > > > > > Would it be better to use READ/WRITE_ONCE() for the variable?
> > > > > > 
> > > > > 
> > > > > For READ/WRITE_ONCE(), we will need to replace all write accesses and
> > > > > all out-of-lock read accesses to pcpu_nr_empty_pop_pages, like below.
> > > > > It's better in the sense that it doesn't rely on compiler behaviors on
> > > > > data races, not sure about the performance impact though.
> > > > > 
> > > > 
> > > > I think a better alternative is we can move it up into the lock under
> > > > area_found. The value gets updated as part of pcpu_alloc_area() as the
> > > > code above populates percpu memory that is already allocated.
> > > > 
> > > 
> > > Not sure I followed what exactly you suggested here because I'm not
> > > familiar with the logic, but a simpler version would be:
> > > 
> > > 
> > 
> > I believe that's the only naked access of pcpu_nr_empty_pop_pages. So
> > I was thinking this'll fix this problem.
> > 
> > I also don't know how to rerun this CI tho..
> > 
> > ---
> > diff --git a/mm/percpu.c b/mm/percpu.c
> > index 20d91af8c033..325fb8412e90 100644
> > --- a/mm/percpu.c
> > +++ b/mm/percpu.c
> > @@ -1864,6 +1864,10 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
> >  
> >  area_found:
> >  	pcpu_stats_area_alloc(chunk, size);
> > +
> > +	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> > +		pcpu_schedule_balance_work();
> > +
> 
> But the pcpu_chunk_populated() afterwards could modify the
> pcpu_nr_empty_pop_pages again, wouldn't this be a behavior changing?
> 

It does, but really at this point it's a mixed bag because the lock
isn't permanently held at all while we do all these operations. The
value is read at best effort.

Ultimately the code below is populating backing pages for non-atomic
allocations. At this point the ideal situation is we're using an already
populated page. There are caveats but I can't say the prior is any
better than this version.

The code you mentioned pairs with the comment on line 916 below.

	/*
	 * If the allocation is not atomic, some blocks may not be
	 * populated with pages, while we account it here.  The number
	 * of pages will be added back with pcpu_chunk_populated()
	 * when populating pages.
	 */

Thanks,
Dennis

> Regards,
> Boqun
> 
> >  	spin_unlock_irqrestore(&pcpu_lock, flags);
> >  
> >  	/* populate if not all pages are already there */
> > @@ -1891,9 +1895,6 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
> >  		mutex_unlock(&pcpu_alloc_mutex);
> >  	}
> >  
> > -	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> > -		pcpu_schedule_balance_work();
> > -
> >  	/* clear the areas and return address relative to base address */
> >  	for_each_possible_cpu(cpu)
> >  		memset((void *)pcpu_chunk_addr(chunk, cpu, 0) + off, 0, size);

