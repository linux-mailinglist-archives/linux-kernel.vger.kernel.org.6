Return-Path: <linux-kernel+bounces-259607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5008E939953
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 790D5B2103F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 05:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA3B28370;
	Tue, 23 Jul 2024 05:50:59 +0000 (UTC)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE71634
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 05:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721713859; cv=none; b=IOe8VYz0YhQVfWEFGwwxMrHvxczuj7fe94UZqhSUl2to6wM6cZDt7VYaxyjDk7ZVwLreub0m/4Lth26FPkrpHdHiD5UHa8k6q3mPZd68nC5HaSe4S9rKRrjJ9p3PaRC0wOv3+PbrauxlOnMpIKzwsse2HUtCRm4kCE9E3P5Z5XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721713859; c=relaxed/simple;
	bh=6tYYKQYNkRScY15H5x6zL1HtxOURu19MpuubO+4vKM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F2VD4VR4Cu1QUN4Vi23/vohmj2CZgh2knWGabN2rRpn+JXShgVCwBqLHD+DSvWytg4rUgkRq8LDzlqRsfT6HnbSCxP1s/Z0z/lSoUK9XaausdB2TzGaubo6WDtf3MiambXR2bDiY0vOBuA/JxBkWFHYuIG1Q1Q8AB8vxownVVzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc6a017abdso23320945ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:50:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721713857; x=1722318657;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAi76Fbb14aLD72KSDP4ZLSN99eyDyIsZtCeNe0d2u8=;
        b=RbQx/Bg7y3WLZ0rrOzCLGnTchJuSDVYRZ/4JyuBPtVIOM3AtksG47Lddh9Du0Ph+Ti
         KtlZnIEks9/Agkj7gp6xyuh9tVrj44m5HJV5kLUUY1kCb7tsYZeYkbYI9V3dWyU0GpgL
         mFqsxJPliwzwrT5PXQpG+CkJnPalMi9vTw4VSYi4v6SpFDcKezpQf1ObRmHENDlXK5HM
         44iY/urBSMnx+dIWZ1wVOinEnWPCeglHdCR/1fF8w5v1Jf3tAJF1J+Ho7tJKj2ateV4L
         zc/eTvVSxbH/Fy1lHVa8iJq34PjBviBhs0yAofmFTaC+sWOPL+AXOqWvVOVfyJpjlmo8
         yzaA==
X-Forwarded-Encrypted: i=1; AJvYcCWjCCUNTDOxHpBTlo8UG/olZBaqRdafCPxPTGNTckGcpjD3Wigbg3YmxjV2U7LHz273O19N0Kef2Q03B2+q/Y7q9nt14Lc7Fq+c9Xwr
X-Gm-Message-State: AOJu0YxTcPrN4hmkul7uI4IMhPLrwlO4wHuem862LxYHFKQHy8qJhO2l
	+2584Czq2yWnBjn8gtWKlWLfHPliVPvCyTzrLQGvcJQustMk5Fnv
X-Google-Smtp-Source: AGHT+IGI5WT7ey25jg4G2dYdrX/Y37jBH63oL83DdgNLhILixfslqS9am3ee4OUjXlB4bSi2bGXT2Q==
X-Received: by 2002:a17:903:2448:b0:1fd:6677:69b4 with SMTP id d9443c01a7336-1fd74660a7dmr64169625ad.49.1721713857175;
        Mon, 22 Jul 2024 22:50:57 -0700 (PDT)
Received: from snowbird ([136.25.84.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f48ca81sm65316435ad.299.2024.07.22.22.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 22:50:56 -0700 (PDT)
Date: Mon, 22 Jul 2024 22:50:53 -0700
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
Message-ID: <Zp9EvUTqni5wMDlC@snowbird>
References: <202407191651.f24e499d-oliver.sang@intel.com>
 <Zp6bMoDnUMxNrKos@boqun-archlinux>
 <Zp6cVgXJlzF4VOwl@slm.duckdns.org>
 <Zp6e1PWZbz4pkh9Z@boqun-archlinux>
 <Zp6kpCcQRPTGk1LK@V92F7Y9K0C.lan>
 <Zp7G4EfISRwlmmIT@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zp7G4EfISRwlmmIT@boqun-archlinux>

On Mon, Jul 22, 2024 at 01:53:52PM -0700, Boqun Feng wrote:
> On Mon, Jul 22, 2024 at 11:27:48AM -0700, Dennis Zhou wrote:
> > Hello,
> > 
> > On Mon, Jul 22, 2024 at 11:03:00AM -0700, Boqun Feng wrote:
> > > On Mon, Jul 22, 2024 at 07:52:22AM -1000, Tejun Heo wrote:
> > > > On Mon, Jul 22, 2024 at 10:47:30AM -0700, Boqun Feng wrote:
> > > > > This looks like a data race because we read pcpu_nr_empty_pop_pages out
> > > > > of the lock for a best effort checking, @Tejun, maybe you could confirm
> > > > > on this?
> > > > 
> > > > That does sound plausible.
> > > > 
> > > > > -       if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
> > > > > +       /*
> > > > > +        * Checks pcpu_nr_empty_pop_pages out of the pcpu_lock, data races may
> > > > > +        * occur but this is just a best-effort checking, everything is synced
> > > > > +        * in pcpu_balance_work.
> > > > > +        */
> > > > > +       if (data_race(pcpu_nr_empty_pop_pages) < PCPU_EMPTY_POP_PAGES_LOW)
> > > > >                 pcpu_schedule_balance_work();
> > > > 
> > > > Would it be better to use READ/WRITE_ONCE() for the variable?
> > > > 
> > > 
> > > For READ/WRITE_ONCE(), we will need to replace all write accesses and
> > > all out-of-lock read accesses to pcpu_nr_empty_pop_pages, like below.
> > > It's better in the sense that it doesn't rely on compiler behaviors on
> > > data races, not sure about the performance impact though.
> > > 
> > 
> > I think a better alternative is we can move it up into the lock under
> > area_found. The value gets updated as part of pcpu_alloc_area() as the
> > code above populates percpu memory that is already allocated.
> > 
> 
> Not sure I followed what exactly you suggested here because I'm not
> familiar with the logic, but a simpler version would be:
> 
> 

I believe that's the only naked access of pcpu_nr_empty_pop_pages. So
I was thinking this'll fix this problem.

I also don't know how to rerun this CI tho..

---
diff --git a/mm/percpu.c b/mm/percpu.c
index 20d91af8c033..325fb8412e90 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1864,6 +1864,10 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 
 area_found:
 	pcpu_stats_area_alloc(chunk, size);
+
+	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
+		pcpu_schedule_balance_work();
+
 	spin_unlock_irqrestore(&pcpu_lock, flags);
 
 	/* populate if not all pages are already there */
@@ -1891,9 +1895,6 @@ void __percpu *pcpu_alloc_noprof(size_t size, size_t align, bool reserved,
 		mutex_unlock(&pcpu_alloc_mutex);
 	}
 
-	if (pcpu_nr_empty_pop_pages < PCPU_EMPTY_POP_PAGES_LOW)
-		pcpu_schedule_balance_work();
-
 	/* clear the areas and return address relative to base address */
 	for_each_possible_cpu(cpu)
 		memset((void *)pcpu_chunk_addr(chunk, cpu, 0) + off, 0, size);

