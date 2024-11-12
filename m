Return-Path: <linux-kernel+bounces-405708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D849C5614
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3835F283302
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 11:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B59221FB2;
	Tue, 12 Nov 2024 10:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VlA+a/UU"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848D9221FA6
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731408645; cv=none; b=k6Ue4RktL4ErWzHqmiC+qbuq2Pznl3CYgDFB2ZuFaL3aIrjCbBXQs2EfcT60wL25ayvKdSBIDsjjH5gZokvJ9tglpB+9nc/efWz8/4Nn4H/G9cJrhbdXKjbDek4VLdOHCno86i67f5qNmxfuq15j0mT7aNucZB7wpUWs2cDh1AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731408645; c=relaxed/simple;
	bh=r8VtiCx6jNxUNbpYC24jOR8BM+MDyHilcp4i8jy2zN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uiXIeGR+Hn4bSDXsPY/7hzmC3HNRfrO65HPRgwtMpTJqAMjz5t1n9KHdLK77caiZ71iI/n0SQ/4GFGglkKQEV7Xr7TqnUilrVstoamlZ2lSU3NbbaAixXlAsSeGvTbEMk9hpL1srydphsAgb9p/uLxEADRns1Bw3hm/ngLAWrw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VlA+a/UU; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d6716e200so424380f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731408642; x=1732013442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTgVYE7JLiGUehWz0eOMkeV9EgMgMxB/RpXPqpnO1eA=;
        b=VlA+a/UUi7yEwF7b5lQuHaJxDxD0LW4OwCCCqh815t5IH2Xcs6wulIJk/qjtAiQS46
         xRfJz1elxtKko8bEYWGO6/0JGFBRG+9qlF0oRU1aS6n3gbb5fP8DjLMz6rV5XN5RfswA
         R6mIEFDEbJeMPLbA5hJMM8ikNEP23tE+KfAy6F+5b1/uHrsWbCG3yZldOjhnCE3kjEwE
         Xb9upLalO9edvVChM4pgDa/UOY8dZP4/hv90TltYIOvngx1qZ4N6xPwEx+edabyfWCU8
         7jGE/QWSaJdcyhU0OtS/Ih+K5fLs1i0t6y2c17JBXyMJTQfnr7eAyQuSE4HQJKyotmB6
         on3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731408642; x=1732013442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yTgVYE7JLiGUehWz0eOMkeV9EgMgMxB/RpXPqpnO1eA=;
        b=JncZyQQC43AFgNQM85U5BjF+Eda67Hmf04ok+/4KJOJvrqgpWTNmTT96I6LFbriIy1
         EhewLW6M6cyDc3+nXkd4YGMHt9mXz9jjuQ9qZ7qhbjOr3o7Aell+y/a6Ez3qaAce7qyD
         jeCdA4sokd8vKdhwLd29MUUhfbEOX6EkPxWivV4ss0o1dVFpxnFRsbklrqjQQ1tIVA/w
         8lwZzpjyIn4H/XBNcr0/BwzKEiQ9/YqQL8etS64hm7Ro6YDBLbriw5K14RxXHAmi+E+V
         44z6cJMvNV4WaJ8DwWv1DPQVtnOTlqPOZoDIp98uNtzpo5Q6w5esAVK75XY0QQY+nBSE
         hh1A==
X-Forwarded-Encrypted: i=1; AJvYcCUCPuLP0SjQVh1M/IaTnV4mc3Vl29uASmIlZiniZQSOhzXb7wlKOjFMddL68hHZ9dh5M+f5SR7VtjuE96Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp3UChk9LsTjAs6KLzf4J3rj0mt0IAbiuHpFArCM6Y0eVzaeIu
	CMSoIt392Ub7vJC8iSmWAEQWnDVUJvluC9H0ADn1+0e7mrcBLV4Z7BLXztNDILE=
X-Google-Smtp-Source: AGHT+IGaLUGeaN6MVuarxyR5MOhRTePhT94Xw+G660FchXt3cxsumD+4PR7WHuF4hFI5P8QlbXHYVA==
X-Received: by 2002:a05:6000:178b:b0:374:cc10:bb42 with SMTP id ffacd0b85a97d-381f1829a57mr5195405f8f.2.1731408641623;
        Tue, 12 Nov 2024 02:50:41 -0800 (PST)
Received: from mordecai.tesarici.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed970d89sm15461714f8f.8.2024.11.12.02.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 02:50:41 -0800 (PST)
Date: Tue, 12 Nov 2024 11:50:39 +0100
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
Message-ID: <20241112115039.41993e4b@mordecai.tesarici.cz>
In-Reply-To: <5a041e51-a43b-4878-ab68-4757d3141889@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
	<20241017142752.17f2c816@mordecai.tesarici.cz>
	<aa9a7118-3067-448e-aa34-bbc148c921a2@arm.com>
	<20241111131442.51738a30@mordecai.tesarici.cz>
	<046ce0ae-b4d5-4dbd-ad9d-eb8de1bba1b8@arm.com>
	<20241112104544.574dd733@mordecai.tesarici.cz>
	<5a041e51-a43b-4878-ab68-4757d3141889@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 10:19:34 +0000
Ryan Roberts <ryan.roberts@arm.com> wrote:

> On 12/11/2024 09:45, Petr Tesarik wrote:
> > On Mon, 11 Nov 2024 12:25:35 +0000
> > Ryan Roberts <ryan.roberts@arm.com> wrote:
> >   
> >> Hi Petr,
> >>
> >> On 11/11/2024 12:14, Petr Tesarik wrote:  
> >>> Hi Ryan,
> >>>
> >>> On Thu, 17 Oct 2024 13:32:43 +0100
> >>> Ryan Roberts <ryan.roberts@arm.com> wrote:  
> >> [...]  
> >>> Third, a few micro-benchmarks saw a significant regression.
> >>>
> >>> Most notably, getenv and getenvT2 tests from libMicro were 18% and 20%
> >>> slower with variable page size. I don't know why, but I'm looking into
> >>> it. The system() library call was also about 18% slower, but that might
> >>> be related.    
> >>
> >> OK, ouch. I think there are some things we can try to optimize the
> >> implementation further. But I'll wait for your analysis before digging myself.  
> > 
> > This turned out to be a false positive. The way this microbenchmark was
> > invoked did not get enough samples, so it was mostly dependent on
> > whether caches were hot or cold, and the timing on this specific system
> > with the specific sequence of bencnmarks in the suite happens to favour
> > my baseline kernel.
> > 
> > After increasing the batch count, I'm getting pretty much the same
> > performance for 6.11 vanilla and patched kernels:
> > 
> >                         prc thr   usecs/call      samples   errors cnt/samp 
> > getenv (baseline)         1   1      0.14975           99        0   100000 
> > getenv (patched)          1   1      0.14981           92        0   100000   
> 
> Oh that's good news! Does this account for all 3 of the above tests (getenv,
> getenvT2 and system())?

It does for getenvT2 (a variant of the test with 2 threads), but not
for system. Thanks for asking, I forgot about that one.

I'm getting substantial difference there (+29% on average over 100 runs):

                        prc thr   usecs/call      samples   errors cnt/samp  command
system (baseline)         1   1   6937.18016          102        0      100     A=$$
system (patched)          1   1   8959.48032          102        0      100     A=$$

So, yeah, this should in fact be my priority #1.

The "system" benchmark measures the duration of system("A=$$"), which
involves starting the system shell (in my case bash-4.4.23), so this is
not really a microbenchmark. I hope perf can help match the difference
to a kernel API.

Petr T

