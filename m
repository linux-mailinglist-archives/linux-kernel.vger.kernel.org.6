Return-Path: <linux-kernel+bounces-407766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6989C7484
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59D92B2B9B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4941E0492;
	Wed, 13 Nov 2024 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XWdTXwub"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B14452F76
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507786; cv=none; b=gioQXAUD7+i6BXoPxn454tEn0ob6NN7fzEvKqhKBRSts8nkUYzOBh1a2t/A3t+bTJQffCJRZxEMtQlh+RmqcoRnWCP0g40Tr3WI1L/OEkvRTIXc1EdBe2v2vJB7c6PkcwyAgtBlZ8A/D87r+KKIw2yOMxUqpM260b6vO2ilBiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507786; c=relaxed/simple;
	bh=WrZwjhdVnww+hI36AZAbV67r/b27tTYjnWnWXIeigps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R6Dtbhveev3j43oLdlXgxJC7xvggi0/LhmkRZM8p8HUY1RTYz4EEzFbwU72UiwvalkpTUhTTXDdDQrU220nftyI6ZYJv8Fs1Sm45eQFK1ALlxzNsC3ieLg4m9ocIMi19gEhyp0hiPV0uegD3DWCYrmXPOfuztPt+PzpqWmXmC68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XWdTXwub; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a273e421fso35301966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 06:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731507782; x=1732112582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Egn5fEpckGR7euiSFSUPlqzHLdxGGw1Hgc2j7hHRnkA=;
        b=XWdTXwubzkzkKeTUwOjm+WWUAFxGj7xknVzBYpjy4jgr+P6fbopyzcI5sNDdISL3EW
         t5fN6z80ZIeHHJpFZCBtyDhuiJ8aozQBf6WFKC7qfJH3IKY2xBse2sgLl0dVG8dVZkyR
         whfd+XrPwM6qd00Jf8J1AbFdr6G/8/GU/xkLeeQFuwOl14yr8ZKqcd5w4pqp7UGHTAUB
         qrzf9JkIDjcNund03ICGw3i60Bm7qhO+g2OKKx70WjfLCDHYBZhElIMBSqyTWkas4AGh
         jvzdkK9UZn09PaKNQHpA8MfgR1mSzL+3PEwMY/MS1W+gUB/Sf0p99/yMrKFx/lL+WfBN
         5/6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731507782; x=1732112582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Egn5fEpckGR7euiSFSUPlqzHLdxGGw1Hgc2j7hHRnkA=;
        b=DidlkS4VKC4ysFv5Z7Uov79KI5TkoHDQwu+7fcHCRlgzY5NjaDqhmC9u+Bl5fne1Ai
         JODrW5pghPMp237zOEqZ6PSR+GsgdiGY7l+q4uBs3Pkf3BkdnKzp5XfiKV8tAW8WI07b
         OFf6JEq9PPUF4zIQk6qPQotKihKJ3qR19gKdWff80hsCRD7wl06oHkWGE/ztK8RhKkwH
         J9IvGFNWE7paiHqX3QL/GkY4DRbjjc/lMzAXZfRz+M/nGHSpKdlIi7PmwyITricQcieU
         WXYT6ZEAa69usWZa3HHkbZy1+T7NYbCP0m2FP+oqcKONR+xlyVSw6SHLub6qbYMXuxV6
         QmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2m3fJD6Xy4mN9uq1zc1TmRmIok//WqMgrEj7Dv7iWmmwIwiCCY2DVZAXlU+BwpBspcWLcvv3UFwSA8ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlbxvYsJn/L6lQk7ujeU9+Rov7vXBl/t3eaD24jgSdn40BEQRW
	CgxIyG2Sf7dbmix9EsGSsEF2ksyTKZePdvP3Ya+Ngq31Cj5I8TQD6o9utU1ds0U=
X-Google-Smtp-Source: AGHT+IE7qbFVHpgXUGHmdtQQ68GGSvuT61CnUcYwM27PSmisc3v4hDGM+TCD1/jQDY5GkVFC7sCumA==
X-Received: by 2002:a17:906:794d:b0:a9a:a55:1e6 with SMTP id a640c23a62f3a-a9eefe9bae8mr803687466b.3.1731507782300;
        Wed, 13 Nov 2024 06:23:02 -0800 (PST)
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa1dda672easm240519366b.40.2024.11.13.06.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 06:23:02 -0800 (PST)
Date: Wed, 13 Nov 2024 15:22:59 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Message-ID: <20241113152259.57983855@mordecai.tesarici.cz>
In-Reply-To: <ed43da27-30bf-4f9d-a952-3d1fe80c5302@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
	<20241017142752.17f2c816@mordecai.tesarici.cz>
	<aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
	<20241111131442.51738a30@mordecai.tesarici.cz>
	<046ce0ae-b4d5-4dbd-ad9d-eb8de1bba1b8@arm.com>
	<20241112104544.574dd733@mordecai.tesarici.cz>
	<5a041e51-a43b-4878-ab68-4757d3141889@arm.com>
	<20241112115039.41993e4b@mordecai.tesarici.cz>
	<20241113134038.5843ab73@mordecai.tesarici.cz>
	<ed43da27-30bf-4f9d-a952-3d1fe80c5302@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 12:56:24 +0000
Ryan Roberts <ryan.roberts@arm.com> wrote:

> On 13/11/2024 12:40, Petr Tesarik wrote:
> > On Tue, 12 Nov 2024 11:50:39 +0100
> > Petr Tesarik <ptesarik@suse.com> wrote:
> >   
> >> On Tue, 12 Nov 2024 10:19:34 +0000
> >> Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>  
> >>> On 12/11/2024 09:45, Petr Tesarik wrote:    
> >>>> On Mon, 11 Nov 2024 12:25:35 +0000
> >>>> Ryan Roberts <ryan.roberts@arm.com> wrote:
> >>>>       
> >>>>> Hi Petr,
> >>>>>
> >>>>> On 11/11/2024 12:14, Petr Tesarik wrote:      
> >>>>>> Hi Ryan,
> >>>>>>
> >>>>>> On Thu, 17 Oct 2024 13:32:43 +0100
> >>>>>> Ryan Roberts <ryan.roberts@arm.com> wrote:      
> >>>>> [...]      
> >>>>>> Third, a few micro-benchmarks saw a significant regression.
> >>>>>>
> >>>>>> Most notably, getenv and getenvT2 tests from libMicro were 18% and 20%
> >>>>>> slower with variable page size. I don't know why, but I'm looking into
> >>>>>> it. The system() library call was also about 18% slower, but that might
> >>>>>> be related.        
> >>>>>
> >>>>> OK, ouch. I think there are some things we can try to optimize the
> >>>>> implementation further. But I'll wait for your analysis before digging myself.      
> >>>>
> >>>> This turned out to be a false positive. The way this microbenchmark was
> >>>> invoked did not get enough samples, so it was mostly dependent on
> >>>> whether caches were hot or cold, and the timing on this specific system
> >>>> with the specific sequence of bencnmarks in the suite happens to favour
> >>>> my baseline kernel.
> >>>>
> >>>> After increasing the batch count, I'm getting pretty much the same
> >>>> performance for 6.11 vanilla and patched kernels:
> >>>>
> >>>>                         prc thr   usecs/call      samples   errors cnt/samp 
> >>>> getenv (baseline)         1   1      0.14975           99        0   100000 
> >>>> getenv (patched)          1   1      0.14981           92        0   100000       
> >>>
> >>> Oh that's good news! Does this account for all 3 of the above tests (getenv,
> >>> getenvT2 and system())?    
> >>
> >> It does for getenvT2 (a variant of the test with 2 threads), but not
> >> for system. Thanks for asking, I forgot about that one.
> >>
> >> I'm getting substantial difference there (+29% on average over 100 runs):
> >>
> >>                         prc thr   usecs/call      samples   errors cnt/samp  command
> >> system (baseline)         1   1   6937.18016          102        0      100     A=$$
> >> system (patched)          1   1   8959.48032          102        0      100     A=$$
> >>
> >> So, yeah, this should in fact be my priority #1.  
> > 
> > Further testing reveals the workload is bimodal, that is to say the
> > distribution of results has two peaks. The first peak around 3.2 ms
> > covers 30% runs, the second peak around 15.7 ms covers 11%. Two per
> > cent are faster than the fast peak, 5% are slower than slow peak, the
> > rest is distributed almost evenly between them.  
> 
> FWIW, One source of bimodality I've seen on Ampere systems with 2 NUMA nodes is
> placement of the kernel image vs placement of the running thread. If they are
> remote from eachother, you'll see a slowdown. I've hacked this source away in
> the past by effectively using only a single NUMA node (with the help of
> 'maxcpus' and 'mem' kernel cmdline options).

This system has only one NUMA node. But your comment leads in the right
direction. CPU placement does play a role here.

I can consistently get the fast results if I pin the benchmark process
to a single CPU core, or more generally to a CPU set which shares the
L2 cache (as found on eMAG). But the scheduler only considers LLC,
which (with CONFIG_SCHED_CLUSTER=y) follows the complex affinity of the
SLC.

Long story short, without explicit affinity, the scheduler may place a
forked child onto a CPU with a cold L2 cache, which harms short-lived
processes (like the ones created by this benchmark).

Now it all makes sense and it is totally unrelated to dynamic page size
selection. :-)

Petr T

