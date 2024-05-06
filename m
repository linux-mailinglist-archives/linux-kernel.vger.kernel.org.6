Return-Path: <linux-kernel+bounces-170104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDB38BD1E9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 17:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3C22855F2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB3515574E;
	Mon,  6 May 2024 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KliXI5h5"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF1A15535B
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715010919; cv=none; b=iDOFMl1kisq4HT2wlq2IJb1ZvYDbN1Ez2bbgwzubbLkrDX02Mxu753deisBwsdZaw9A6OAjDW//9E1aScXLfyWrnXUBktregO9v6bbq271ZAjxo0gA0R30EfnPtUzWz/FszNbPI2p9O4LupsbpNYAfk4J/MwiKiARvEKNhfcrc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715010919; c=relaxed/simple;
	bh=mhB76qyQxLKd3s9N2TOb05fLYTaH6mHLfMwreADvEZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jJKmQ23zAxyXuj37Ghf+k85gnDR91Q4hJL/M/bA4r0wimDQSvzV5oIP3BauuLAUTogzFyBqe+X3H5MEmEqbglXCaHft05LmrPXuc4yC2lhonhltjAXXlQG9N9s3NMsgNcwckT28pSZ23TCV9k7R/akjjKgeBUAW+u15c4Y7nD8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KliXI5h5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-34e0d47bd98so2519951f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715010914; x=1715615714; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cqpJmoKMepVysa+KX/TPqKbmak55AUDGnB80MXEx2Dg=;
        b=KliXI5h5IQP38Vy4kEvXY8mh2z08VyGjY1vqqDLHqL5hd5p6F0rWOFIVlXJ2sknWdl
         7NIblyM946ZyndhuaLKJAEPNZr4fDSKdCJU7eWJ7BNFDlbgjspQnqQ/0F5HtdwuzNkYx
         V15w1zfDVE0qlUcWiSMEiD4Jo/NovikeVPCIWFoujmjF5Dvog//rHI5mN73RIahWvHfH
         uR9Img0IN91RC1pVHMveFh8W3kCX5LMnhiLU1XaoJ8AvcmKN56OE542Wy2tKlP9pcaEC
         trFD3W+moXYud6M2rNvs1dnFEbzlhxl9vfsnknbGu0Rx69mfzye7Vu9cjcE/kLTty8fa
         i8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715010914; x=1715615714;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cqpJmoKMepVysa+KX/TPqKbmak55AUDGnB80MXEx2Dg=;
        b=DLjQou+4O/hCO7ub+up12BxaGnjvlfEb6Cpu4CrMYSPL3uDk0AhpgPy4iOQH31pl2B
         xRu5PdHpFix836XVCxle+ul8MbqGVQHItwtDMM2Jblx8pFCqCbfdug6cSrP+1KOy2nQO
         HvFzM0jDx3AcAZaDwu01qM/9tbB3xWKPFmIDh5uJFIx/+ua0P3rUcE9pYWPlAKI1pdMq
         02EHNPigbb95tTLNCw3M/h2RCP5AGiUk/mu9OTmk+Tn+/9DxqgkGsbHeexwcvZINd+Vd
         OOVPP5JH2PXhatc3eaKoA5yjUoJKzjL+YRgX6SbmzPb/b8fBn2vHubegdgQrIUd9zWcf
         7PUA==
X-Forwarded-Encrypted: i=1; AJvYcCWosRXjLVhSy/GGiWhJjt/s3nFFyZn0sCr3wwtUTVr4KLEfLuIISVtiPjcECLHgeYdhwMkDl7JAusz2Ry3b+PQTCqlUWZTm6UKUHqLL
X-Gm-Message-State: AOJu0YypDW8FRpkxCy12+DBqyqVu0RW3j1pLYs9o+Bcei1SuyA13OhCD
	UE4dq17cePgB0EzZQLAFSVdjUZzvdY2YGik5PQbOOBllMPsqkRojhSnklLfBzRRXpE8wljBIAGD
	L
X-Google-Smtp-Source: AGHT+IE3rpkySv/D8vupwQ+buCohBwxGikLHxlO+dli6LS665VTdC2iaTysgzA92IUpGii6S29roPA==
X-Received: by 2002:a5d:4fc7:0:b0:34d:8f48:67d5 with SMTP id ffacd0b85a97d-34f8194e912mr78335f8f.10.1715010914236;
        Mon, 06 May 2024 08:55:14 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id g1-20020a5d6981000000b0034d8b0b5329sm10966870wru.87.2024.05.06.08.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 08:55:14 -0700 (PDT)
Date: Mon, 6 May 2024 17:55:12 +0200
From: Petr Mladek <pmladek@suse.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Matthew Wilcox <willy@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Printing numbers in SI units
Message-ID: <Zjj9YAdbxElsnAOi@pathway.suse.cz>
References: <ZbFd5TZ_pi7q3hso@casper.infradead.org>
 <94713e86-30a8-4828-959d-bd95800149e4@rasmusvillemoes.dk>
 <CAMuHMdUp3fOkAttk2FKJTh5svaiMwgu4JZ8utPeHghU4TQLE-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUp3fOkAttk2FKJTh5svaiMwgu4JZ8utPeHghU4TQLE-w@mail.gmail.com>

On Fri 2024-04-26 17:27:08, Geert Uytterhoeven wrote:
> Hi Rasmus,
> 
> On Wed, Jan 24, 2024 at 11:43 PM Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
> > On 24/01/2024 19.58, Matthew Wilcox wrote:
> > > I was looking at hugetlbfs and it has several snippets of code like
> > > this:
> > >
> > >         string_get_size(huge_page_size(h), 1, STRING_UNITS_2, buf, 32);
> > >         pr_warn("HugeTLB: allocating %u of page size %s failed node%d.  Only allocated %lu hugepages.\n",
> > >                 h->max_huge_pages_node[nid], buf, nid, i);
> > >
> > > That's not terribly ergonomic, so I wondered if I could do better.
> > > Unfortunately, I decided to do it using the SPECIAL flag which GCC
> > > warns about.  But I've written the code now, so I'm sending it out in
> > > case anybody has a better idea for how to incorporate it.
> >
> > Well, something that gcc will warn about with Wformat isn't gonna fly,
> > obviously. But my man page also mentions ' as a possible flag for d
> > conversions:
> >
> >        '      For decimal conversion (i, d, u, f, F, g, G) the output is
> > to be grouped with thousands'
> >               grouping characters if the locale information indicates any.
> 
> > Obviously, our printf wouldn't implement that, [...]
> 
> Why not? ;-)
> 
> Old Gmail-white-space-damaged patch below, which I wrote when I got
> fed up with meticulously counting zeros in GHz-range clock
> frequencies...

:-)


> Author: Geert Uytterhoeven <geert+renesas@glider.be>
> Date:   Thu Aug 11 13:52:46 2016 +0200
> 
>     lib/vsprintf.c: Add support for thousands' grouping
> 
>     Use an underscore as the grouping character.
> 
>     TODO:
>       - Documentation
>       - Self test
>       - Do we want to use this in /sys/kernel/debug/clk/clk_summary ?
>         RFC patch, compatibility was already broken by commit
>         e55a839a7a1c561b ("clk: add clock protection mechanism to clk
>         core")

Yeah, it should have some users if we want to maintain it.

Best Regards,
Petr

