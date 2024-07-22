Return-Path: <linux-kernel+bounces-259290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4C5939395
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9427E28230C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 18:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAA616FF39;
	Mon, 22 Jul 2024 18:27:55 +0000 (UTC)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7821216C6B0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 18:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721672874; cv=none; b=K3RtFbh6HRTD6LYgarWg+3cjgRxvPz3ok0WGo070rEeaTljdoxwd+wLFezJT/zCN9c6QNV9CJNE1+lbsga7iE88xqH45qNSAIp+X0kLNVh+K+YDo1984CJDLNuwSpEeTokfAwWMlhMDly2YClUI0MPjsBR8zJ4Ve/D+QqeEc8Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721672874; c=relaxed/simple;
	bh=F6FMXHBav5ZFf53Zg/+oQQCMht4mrSPcADmH22KDITU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP11hLY0moitGbPbMVe0of3MDevN1k2tvHyrCvshJy0grBuhU/nq+o5LopOCJhwifrbHZG4HWp/BWAZ4K9lgMYdk/fwln8gupGixzq7VMpyWtJnMXcJSpEz53Zf6qko9/+QgNIoyytN6yxOIKKqkzpd4h2ISHla5fQn94155e30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-397ba4f7387so18463455ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 11:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721672872; x=1722277672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqG4DjXdh9BThfz/oPKE46CRC77k0JuZ2H1GZ7xS5y4=;
        b=d9r8sN3nRajiOGs9S9U1cLbCcOCTpCHL1I3/QM5oQ1J9r2r2o1o1EM7o3Znmc6Ez+8
         vKr5Q3qcf+ItaGC8YnC2Gj23xJWpx1GfflJmERRMlJHbDHs9FGZsAvBOLM+OQ3ijk7rF
         w2fuZ5QbtFLHDvqCrRPtHxvhUcOnGJ9Mrv4Va3YRSY7iWhNE5wE89tQCzrL23tS4xN3u
         B4CXPlOwACBTAqLzujjRWBd7oSjrAIj3t3a1LanNqLx1LOmeMZY68/RKz6WiFliMM60D
         DxWX50IITPEM/i69m3exlCYMwoahNWCgO2ibDzDAdetkJDOarfgdN+cF7LPVdr8N19u2
         3P5Q==
X-Forwarded-Encrypted: i=1; AJvYcCViACcTgSgi6bHgGKEUEBxkdX64vUEcEPPVnoaRWS5oXICF5nJYQr4pkAsG+0tEYLUpzxbjrDPMHcLMYlau8Y5rXuCpj1LySqh/O2a8
X-Gm-Message-State: AOJu0YwnmkAFedO+6pg20sEQNpEbko96TTwdzx8hLq4Sw9LFHc+DbXj+
	a4ZVGCqFzmHJjw6HKUYGkQ6KSTd+bjUa0FZPEQgdA2qZr3HTjBS7
X-Google-Smtp-Source: AGHT+IHVX3cSSyhgB58GojLXdK13WAoJHQ6943ZM4PKxyi/C10H5ptjegn1X8lVAliJ9c1/qBW6W/g==
X-Received: by 2002:a05:6e02:18c9:b0:374:ac3a:e32c with SMTP id e9e14a558f8ab-3993ff9ca1fmr104337235ab.16.1721672872550;
        Mon, 22 Jul 2024 11:27:52 -0700 (PDT)
Received: from V92F7Y9K0C.lan ([136.25.84.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a224a1fc70sm2036075a12.58.2024.07.22.11.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 11:27:52 -0700 (PDT)
Date: Mon, 22 Jul 2024 11:27:48 -0700
From: Dennis Zhou <dennis@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>, Tejun Heo <tj@kernel.org>
Cc: kernel test robot <oliver.sang@intel.com>,
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
	Christoph Lameter <cl@linux.com>, Dennis Zhou <dennis@kernel.org>,
	Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Wedson Almeida Filho <wedsonaf@gmail.com>, linux-mm@kvack.org,
	lkmm@lists.linux.dev
Subject: Re: [linus:master] [mm]  24e44cc22a:
 BUG:KCSAN:data-race_in_pcpu_alloc_noprof/pcpu_block_update_hint_alloc
Message-ID: <Zp6kpCcQRPTGk1LK@V92F7Y9K0C.lan>
References: <202407191651.f24e499d-oliver.sang@intel.com>
 <Zp6bMoDnUMxNrKos@boqun-archlinux>
 <Zp6cVgXJlzF4VOwl@slm.duckdns.org>
 <Zp6e1PWZbz4pkh9Z@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp6e1PWZbz4pkh9Z@boqun-archlinux>

Hello,

On Mon, Jul 22, 2024 at 11:03:00AM -0700, Boqun Feng wrote:
> On Mon, Jul 22, 2024 at 07:52:22AM -1000, Tejun Heo wrote:
> > On Mon, Jul 22, 2024 at 10:47:30AM -0700, Boqun Feng wrote:
> > > This looks like a data race because we read pcpu_nr_empty_pop_pages out
> > > of the lock for a best effort checking, @Tejun, maybe you could confirm
> > > on this?
> > 
> > That does sound plausible.
> > 
> > > -       if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> > > +       /*
> > > +        * Checks pcpu_nr_empty_pop_pages out of the pcpu_lock, data races may
> > > +        * occur but this is just a best-effort checking, everything is synced
> > > +        * in pcpu_balance_work.
> > > +        */
> > > +       if (data_race(pcpu_nr_empty_pop_pages) < PCPU_EMPTY_POP_PAGES_LOW)
> > >                 pcpu_schedule_balance_work();
> > 
> > Would it be better to use READ/WRITE_ONCE() for the variable?
> > 
> 
> For READ/WRITE_ONCE(), we will need to replace all write accesses and
> all out-of-lock read accesses to pcpu_nr_empty_pop_pages, like below.
> It's better in the sense that it doesn't rely on compiler behaviors on
> data races, not sure about the performance impact though.
> 

I think a better alternative is we can move it up into the lock under
area_found. The value gets updated as part of pcpu_alloc_area() as the
code above populates percpu memory that is already allocated.

We should probably annotate pcpu_update_empty_pages() with:
    lockdep_assert_held(&pcpu_lock);

Thanks,
Dennis

> Regards,
> Boqun
> 
> ----->8
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 20d91af8c033..729e8188238b 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -570,7 +570,8 @@ static void pcpu_isolate_chunk(struct pcpu_chunk *chunk)
>  
>  	if (!chunk->isolated) {
>  		chunk->isolated = true;
> -		pcpu_nr_empty_pop_pages -= chunk->nr_empty_pop_pages;
> +		WRITE_ONCE(pcpu_nr_empty_pop_pages,
> +			   pcpu_nr_empty_pop_pages - chunk->nr_empty_pop_pages);
>  	}
>  	list_move(&chunk->list, &pcpu_chunk_lists[pcpu_to_depopulate_slot]);
>  }
> @@ -581,7 +582,8 @@ static void pcpu_reintegrate_chunk(struct pcpu_chunk *chunk)
>  
>  	if (chunk->isolated) {
>  		chunk->isolated = false;
> -		pcpu_nr_empty_pop_pages += chunk->nr_empty_pop_pages;
> +		WRITE_ONCE(pcpu_nr_empty_pop_pages,
> +			   pcpu_nr_empty_pop_pages + chunk->nr_empty_pop_pages);
>  		pcpu_chunk_relocate(chunk, -1);
>  	}
>  }
> @@ -599,7 +601,8 @@ static inline void pcpu_update_empty_pages(struct pcpu_chunk *chunk, int nr)
>  {
>  	chunk->nr_empty_pop_pages += nr;
>  	if (chunk != pcpu_reserved_chunk && !chunk->isolated)
> -		pcpu_nr_empty_pop_pages += nr;
> +		WRITE_ONCE(pcpu_nr_empty_pop_pages,
> +			   pcpu_nr_empty_pop_pages + nr);
>  }
>  
>  /*
> @@ -1891,7 +1894,7 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
>  		mutex_unlock(&pcpu_alloc_mutex);
>  	}
>  
> -	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> +	if (READ_ONCE(pcpu_nr_empty_pop_pages) < PCPU_EMPTY_POP_PAGES_LOW)
>  		pcpu_schedule_balance_work();
>  
>  	/* clear the areas and return address relative to base address */
> @@ -2754,7 +2757,7 @@ void __init pcpu_setup_first_chunk(const struct pcpu_alloc_info *ai,
>  	tmp_addr = (unsigned long)base_addr + static_size + ai->reserved_size;
>  	pcpu_first_chunk = pcpu_alloc_first_chunk(tmp_addr, dyn_size);
>  
> -	pcpu_nr_empty_pop_pages = pcpu_first_chunk->nr_empty_pop_pages;
> +	WRITE_ONCE(pcpu_nr_empty_pop_pages, pcpu_first_chunk->nr_empty_pop_pages);
>  	pcpu_chunk_relocate(pcpu_first_chunk, -1);
>  
>  	/* include all regions of the first chunk */
> 

