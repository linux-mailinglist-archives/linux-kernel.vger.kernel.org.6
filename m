Return-Path: <linux-kernel+bounces-433795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 558619E5D27
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84BE18831B0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5B222578C;
	Thu,  5 Dec 2024 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UUh+1U07"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D3D221465
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733419880; cv=none; b=bIPmnsXUKkzdyNi+9/7hjfqk8eDZD6H4r99yVenXH6KN5y3qCCOPraZ5fbHTjMe2MHxKHJ6gHn1+21LiE90R2aIcOMt++B6bNyWio15oZ9Hi4SPBPzC2jnQ4iqRlOCA2kEeIJLkRSjGxiyghZ9aY89pbFH2mNmuTiaaV+x4VPQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733419880; c=relaxed/simple;
	bh=DILMSC318MaffnuHHC5DfCokTzeEKw4jXbmCZwGyZkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jBWd4p2HGVCnv/WX2guT+iIUMbQUp/LvfLg4Us9EpY993j4t6LuA/fl5ZeZCZesYCWIXh0Qx9wJz4n3VSA/EZkTPeNCdh6HS4Q3GsBAOcI0d3tPg4kmJu1nrJ33LSMFxUf39vv8kYjkkaBep2/x/lEoYV2qS1hrALCehCuSjgA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UUh+1U07; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa625782fb1so15426066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 09:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1733419877; x=1734024677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8/7vE5e555OKJe6AuucX4ms/VrPrCkBrD8lqWS8nyE=;
        b=UUh+1U07MMi3/JH4QZx/liKwAVqzDwCnxcIJYpW+2AoHCXvHkcO9p86b5UkxhQjmje
         TClZss28J6XP6PLtVRj2EYsqaW+Ddb3qovvVH5ues8N4U9NlHIeTHow6oy42PDrUD46O
         p3RrFZjxoVVp0M/AQBpLflX2gwgGwhqTEvOeOuDGFzQMKag3+0/tXDFlLDmvS9UajV1/
         Pfb/PgV3F4oV7ZRMKFpVEDTw9/qQuOvqAb8A6Vadfxdv25YMWNnk9WmqwLeiqZAg2adr
         755Iu/dijAa9EtHWnHPbYE5mw7z5JQsO7k53zwB+bajQNO9vcykb+C5tN1pG8F5FCGoG
         ijuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733419877; x=1734024677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8/7vE5e555OKJe6AuucX4ms/VrPrCkBrD8lqWS8nyE=;
        b=CzGGcfpNNCThMFqrFuv8nFpAdq6mtteM2Czxi4xYVaZndsRBN6sO2HQYh3rInOBckO
         UYpmYGlx2e9dATwRYpVaFoG+eCHmchsTJpAPC5/IUG4wI/qYxXfcbY7mqk6TeA4cQ/mf
         TNMRSd62qVSH4E1/fDFS/BOMdyPJrgW8G1h/QSFF+PuYmobIbXDypJBULXEOEzJDNgON
         B6u2Gje/2IedSzOHnlXAvk88S/a3RV7C9owFJwNxC6J7zvw7m1xx7JVP+X2Q20zTvmkZ
         QGmqFYxaFqLEHnuKcMEJzSoeoIf+RvP6dwe6fRlaPPG7jcxjbck0wCnAFfbW9PyzY6cw
         2sgw==
X-Forwarded-Encrypted: i=1; AJvYcCUFmTcwonj5cemJ29QDmCHUx6UP4Or7XsIGpuoD2bvQHG+nZUCY7z0epWnvQeB7Jeb3Z9Y2GmYmDon5BYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/AR7Zlmr3utrux5d+hIhe+MOPcHS+dUanYRnkj0QEFDEVuWEo
	+mXHOHKwBc2k0G6WY5LrOfN7F0mT11N51qiq0EINmugoBbfP4tf9eXlM8C0S47c=
X-Gm-Gg: ASbGncs8sr1TCPJuH1Vmbrz3FFEibSMiZ20/vbUSGsrL2OnS2yrgattUKlPBdTNPJpH
	WGptpfmiaCv2LJPyaPRv/aUhoh5SYIfxT/D7zlmGoW+k60d3kdXbWXLyXD8Iwf/3jHY7e75Hssg
	4EX1cO8CUjGT1VfsY8dlZD+GIOXPX9iN6o3qujNoy1wZbmog9zcjs+0/lZNmKU179i79QvsCIAi
	JN7LsvNxFNGQd8aHjucEZ/zcXkeAQaNuI6zsth1+BONHqRsYwwRSbOGEAh2SbLrbAHXuIFoxD9l
	P/ZwbU4xodlzEuwnPoiYuz4/nBrre5BT2kP6ep5jb+wCBq/LNz/J96U=
X-Google-Smtp-Source: AGHT+IEQzkKEFiKDujFpgpYYDhLmEPZqC0BMq0BFtfN8uz6jk0DSODmsmsMeP94l0aJ80mpV+tmi8g==
X-Received: by 2002:a17:907:72cb:b0:a99:482c:b2c6 with SMTP id a640c23a62f3a-aa5f7dab976mr469405966b.8.1733419876349;
        Thu, 05 Dec 2024 09:31:16 -0800 (PST)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa625e92a13sm120705466b.52.2024.12.05.09.31.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 09:31:16 -0800 (PST)
Date: Thu, 5 Dec 2024 18:31:11 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Dave Hansen <dave.hansen@intel.com>, Valentin Schneider
 <vschneid@redhat.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
 bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Wanpeng Li <wanpengli@tencent.com>, Vitaly Kuznetsov <vkuznets@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, Neeraj
 Upadhyay <quic_neeraju@quicinc.com>, Joel Fernandes
 <joel@joelfernandes.org>, Josh Triplett <josh@joshtriplett.org>, Boqun Feng
 <boqun.feng@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Uladzislau Rezki
 <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Lorenzo Stoakes
 <lstoakes@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron
 <jbaron@akamai.com>, Kees Cook <keescook@chromium.org>, Sami Tolvanen
 <samitolvanen@google.com>, Ard Biesheuvel <ardb@kernel.org>, Nicholas
 Piggin <npiggin@gmail.com>, Juerg Haefliger
 <juerg.haefliger@canonical.com>, Nicolas Saenz Julienne
 <nsaenz@kernel.org>, "Kirill A. Shutemov"
 <kirill.shutemov@linux.intel.com>, Nadav Amit <namit@vmware.com>, Dan
 Carpenter <error27@gmail.com>, Chuang Wang <nashuiliang@gmail.com>, Yang
 Jihong <yangjihong1@huawei.com>, Petr Mladek <pmladek@suse.com>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>, Julian Pidancet
 <julian.pidancet@oracle.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Dionna Glaze <dionnaglaze@google.com>, Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?=
 <linux@weissschuh.net>, Juri Lelli <juri.lelli@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, Yair Podemsky <ypodemsk@redhat.com>, Daniel Wagner
 <dwagner@suse.de>
Subject: Re: [RFC PATCH v3 13/15] context_tracking,x86: Add infrastructure
 to defer kernel TLBI
Message-ID: <20241205183111.12dc16b3@mordecai.tesarici.cz>
In-Reply-To: <20241121153016.GL39245@noisy.programming.kicks-ass.net>
References: <20241119153502.41361-1-vschneid@redhat.com>
	<20241119153502.41361-14-vschneid@redhat.com>
	<20241120152216.GM19989@noisy.programming.kicks-ass.net>
	<20241120153221.GM38972@noisy.programming.kicks-ass.net>
	<xhsmhldxdhl7b.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
	<20241121111221.GE24774@noisy.programming.kicks-ass.net>
	<4b562cd0-7500-4b3a-8f5c-e6acfea2896e@intel.com>
	<20241121153016.GL39245@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 16:30:16 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Nov 21, 2024 at 07:07:44AM -0800, Dave Hansen wrote:
> > On 11/21/24 03:12, Peter Zijlstra wrote:  
> > >> I see e.g. ds_clear_cea() clears PTEs that can have the _PAGE_GLOBAL flag,
> > >> and it correctly uses the non-deferrable flush_tlb_kernel_range().  
> > > 
> > > I always forget what we use global pages for, dhansen might know, but
> > > let me try and have a look.
> > > 
> > > I *think* we only have GLOBAL on kernel text, and that only sometimes.  
> > 
> > I think you're remembering how _PAGE_GLOBAL gets used when KPTI is in play.  
> 
> Yah, I suppose I am. That was the last time I had a good look at this
> stuff :-)
> 
> > Ignoring KPTI for a sec... We use _PAGE_GLOBAL for all kernel mappings.
> > Before PCIDs, global mappings let the kernel TLB entries live across CR3
> > writes. When PCIDs are in play, global mappings let two different ASIDs
> > share TLB entries.  
> 
> Hurmph.. bah. That means we do need that horrible CR4 dance :/

In general, yes.

But I wonder what exactly was the original scenario encountered by
Valentin. I mean, if TLB entry invalidations were necessary to sync
changes to kernel text after flipping a static branch, then it might be
less overhead to make a list of affected pages and call INVLPG on them.

AFAIK there is currently no such IPI function for doing that, but if we
could add one. If the list of invalidated global pages is reasonably
short, of course.

Valentin, do you happen to know?

Petr T

