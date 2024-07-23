Return-Path: <linux-kernel+bounces-259615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0973C939993
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 08:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6B31F22469
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 06:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5A013D600;
	Tue, 23 Jul 2024 06:13:18 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF3E632
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721715198; cv=none; b=qg1ktdaKIlPjgwkwXiGTB6A8WYUdAO0oBtH3/9ffq+uwZIdripikWmTBB9FO2e5XQWAvqYfYYU66uBuMhgoI9KjiKVFCFfjAwK42DK2JlauoFEVW/iuQSH74n7eEYlwSwdOhLkZTiiIhoq6DucPoKdjjzjSsBepQqBJ3XAHmzk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721715198; c=relaxed/simple;
	bh=VQJqynMJxzrsZAD1nG5keT3FGlcpHAyjrPHZQw64PEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz3aHBaslJaxn275YuG3E71ul4rpuk6A0IR50maDWeYB7zN9B2B3rMgR1HO4rAoRfEZXuC9s58gBecu0vsc9sfTYCIMKOxHr5A7Dbg/xD2dUA9H4/GjkA0P6M7ktsz1lmJTfvAC4tvlpJgL92g25skihTui783J50utuBipWPpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb3b7d0d56so25845815ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 23:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721715196; x=1722319996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veqI8JpWND9x/vrna5uBQjtmH0anUTbMAymlouU2IIA=;
        b=whQ8YfNeFbBZ7jmstcrRTB1QSI0gZ7oJzMvaeIGsCxHy7iD7MQc88D/t0DmSlo7L8S
         Ma/LCDfibOQlttlbP8OCTbEQMfvPw0aI5xWkSQJoMk+gTpO3SKRx3BusylKrmY3rfCPx
         QGMl/J8/+E3hBeKAuJouzWLYSyFBJFFse5jbS2+cHb1+bzuShxVBDDU5J/30BOGPt2zG
         HLwP2iiyD4l0+f5H7uk0aH6XCDzF7xwJO5u29MwDhDXp/u8VtYHmPNZy6+4T//gIQFQX
         zyQNm+F2TzwAmCDvNq0/cKfzeXxxhuzNjZUROGvdwd0BsvK0UZiVet/L8V9MZk0IkGd7
         QJqA==
X-Forwarded-Encrypted: i=1; AJvYcCV/UoQYST6xTjBOgqff8gPIv2d/eTekBnDM4cjjRm1qMvtGCPnU2i6/TK++9SMceH49sxmmD5J6fxQhI1iE0Jl56oPkur2XH9NaB2YS
X-Gm-Message-State: AOJu0Yy5u43NvhIPeFzc/53H2QUL8uH2Ick7AVelKSKH6eZruaxmDqVz
	nbekteP7ezfEAHCxscqqlg1UkNmVAMoWOnWkQ0lIHXTfq2oVO2Ew
X-Google-Smtp-Source: AGHT+IFokcuiNQpmIx+LeDifSxdr+eQv/RRynQlUmI+tAfEfDwliz2LL7xMK+H5ow8Cc9glZnTEo8w==
X-Received: by 2002:a17:903:190:b0:1fd:93d2:fba4 with SMTP id d9443c01a7336-1fd93d30202mr37575885ad.48.1721715196030;
        Mon, 22 Jul 2024 23:13:16 -0700 (PDT)
Received: from snowbird ([136.25.84.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f44c7b2sm65785955ad.218.2024.07.22.23.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 23:13:15 -0700 (PDT)
Date: Mon, 22 Jul 2024 23:13:10 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Tejun Heo <tj@kernel.org>,
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
Message-ID: <Zp9J9t-KP17P-OFR@snowbird>
References: <202407191651.f24e499d-oliver.sang@intel.com>
 <Zp6bMoDnUMxNrKos@boqun-archlinux>
 <Zp6cVgXJlzF4VOwl@slm.duckdns.org>
 <Zp6e1PWZbz4pkh9Z@boqun-archlinux>
 <Zp6kpCcQRPTGk1LK@V92F7Y9K0C.lan>
 <Zp7G4EfISRwlmmIT@boqun-archlinux>
 <Zp9EvUTqni5wMDlC@snowbird>
 <Zp9JIvoRVaa+w5OT@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp9JIvoRVaa+w5OT@xsang-OptiPlex-9020>

Hi Oliver,

On Tue, Jul 23, 2024 at 02:09:38PM +0800, Oliver Sang wrote:
> hi, Dennis Zhou,
> 
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
> 
> we could test this patch. what's the base? could we apply it directly upon
> 24e44cc22a?
> 
> BTW, our bot is not so clever so far to auto test fix patches, so this is kind
> of manual effort. due to resource constraint, it will be hard for us to test
> each patch (we saw several patches in this thread already) or test very fast.
> 

Ah yeah that makes sense. If you don't mind testing the last one I sent,
the one below, that applies cleanly to 24e44cc22a.

Thanks,
Dennis

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

