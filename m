Return-Path: <linux-kernel+bounces-301580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F55F95F2D2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951CB1C21DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F11183CD3;
	Mon, 26 Aug 2024 13:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Idkm4azm"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B77417C98A
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724678636; cv=none; b=WGF3swcmrlkxZH8cH43UNR5tRMj8+eMGfiKCO9pLNy/YMgBexmCc1eD7EUxLaV8THuAB7qTpwYJPYFVrbGnqPeNo0U3ymkZglHim5ICtZhd9tL6vITy6FVMjIWpvL/1Hx39NoYXGbcgRIKbvx21vM3YeltD+C+RqczWfbqSNf6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724678636; c=relaxed/simple;
	bh=jeztrx2wemey1pVY0c62bFmR4t/EoPdY6f0cjjxFm3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHdqFhMxQgLg1YDBoYdYh8TMKa+w9xplzmXRK01aOJmfQuMZYkIJbRqnEeMHiKkFXSrzsrMEKteZvAnyygHJ5mIIJRKvTxnVSX6Os//t4b0vw8hQrH0DPYmVQSx7H0iVouuG8S4Oxciejd9eLv5Vl74OrlWMuQhOOGuMKmxj4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Idkm4azm; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-534366c194fso3618874e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 06:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724678632; x=1725283432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IQCe7McW9E8hf61lrcG6VB7x1ye3Lq6gKShLHGG32KE=;
        b=Idkm4azmAAv0OlQT098UhA2YN2r/QCXeuSiG+8tpEoLTUag1bQzyHOZW9eH9Ndyss1
         M6FfNmt/ldaX+xjNd1V7yfIwr1yzlFp9tbaRBMj/nnZ6jnmofi5tDJz3OOqWZYeyqyA3
         ny2DvMDCFImTRnnT2VCLZCvkjNp8Np/z3spOS9QG45n5a9DBIlmBL5WQCHfEt692Mi6C
         H7bK/MxdCIjEnLt2S6tYTQARhtOH84jlZwmotNzDpkDmzv/M29RXRNpFX+Ile4sEhz0l
         SGKJ7VyBaLuYHP7+I2V9IPxSWgPcT9ZRCwz2QtZ2Ja9hEvN02c6QrxVnOSkXnKnA19qU
         FTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724678632; x=1725283432;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQCe7McW9E8hf61lrcG6VB7x1ye3Lq6gKShLHGG32KE=;
        b=V3R+cUhMfnFc8NveGlr6m1ligWIFTWcb3c+NAuxQAS/5AhQW8l6h9nXfwVWbzxrCXq
         bxbTYT6DdfSvdrt7sKaL5m+0qGtraRxD26kK918hLmDfHjBDPmW7Qj+XZrlhv8Up4Q6X
         PT1XwctQ40m37Ux0TTecf065RGln347azjjxE59VwQBAbxymZGqXGJsJG9en3s/QNb7E
         sAIuTCo3ASAgW73OZX5GGteKKagZPzu+HENcFiPXvLNdq9TfDorWSuHzgYjrLM6r5Iwb
         Er1cPrr9+33CJgrwLcBSd0SVKua3rNGJQv6+8UdQb+nuddHLO/S2fTd697L2nJsnu+9x
         KDyw==
X-Forwarded-Encrypted: i=1; AJvYcCWNlkmBq4mvGp6JhUictGjIxwIlqIuIP9OWOch0gvawZmJedMseUL2AT4F640ir7cJo1Am0qxznoJQBKjA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFhNj+S5JoXH1JaFKxqtUb5TiWm/pgk+Zi76iknPzP9cy/VDYW
	GetoRZlxupzE1mcNlGUOmcw3sCivl0tyg3QTABI2MmXyX1sob6GuL8PpXUKxBbY=
X-Google-Smtp-Source: AGHT+IHb9h8+cB84cqvegDS1MyMJPEFI1QyTGHUhHtl3xRFQzxT2+gqbftjjzsxNnZRT1RRhuK0Sgg==
X-Received: by 2002:a05:6512:3d24:b0:533:44a3:21b9 with SMTP id 2adb3069b0e04-534387681d2mr6366176e87.1.1724678632351;
        Mon, 26 Aug 2024 06:23:52 -0700 (PDT)
Received: from pathway.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f436330sm665305066b.112.2024.08.26.06.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2024 06:23:52 -0700 (PDT)
Date: Mon, 26 Aug 2024 15:23:50 +0200
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	Fan Ni <fan.ni@samsung.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>, Chris Mason <clm@fb.com>,
	Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	linux-btrfs@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 02/25] printk: Add print format (%par) for struct range
Message-ID: <ZsyB5rqhaZ-oRwny@pathway.suse.cz>
References: <20240816-dcd-type2-upstream-v3-0-7c9b96cba6d7@intel.com>
 <20240816-dcd-type2-upstream-v3-2-7c9b96cba6d7@intel.com>
 <ZsSjdjzRSG87alk5@pathway.suse.cz>
 <66c77b1c5c65c_1719d2940@iweiny-mobl.notmuch>
 <Zsd_EctNZ80fuKMu@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zsd_EctNZ80fuKMu@smile.fi.intel.com>

On Thu 2024-08-22 21:10:25, Andy Shevchenko wrote:
> On Thu, Aug 22, 2024 at 12:53:32PM -0500, Ira Weiny wrote:
> > Petr Mladek wrote:
> > > On Fri 2024-08-16 09:44:10, Ira Weiny wrote:
> 
> ...
> 
> > > > +	%par	[range 0x60000000-0x6fffffff] or
> > > 
> > > It seems that it is always 64-bit. It prints:
> > > 
> > > struct range {
> > > 	u64   start;
> > > 	u64   end;
> > > };
> > 
> > Indeed.  Thanks I should not have just copied/pasted.
> 
> With that said, I'm not sure the %pa is a good placeholder for this ('a' stands
> to "address" AFAIU). Perhaps this should go somewhere under %pr/%pR?

The r/R in %pr/%pR actually stands for "resource".

But "%ra" really looks like a better choice than "%par". Both
"resource"  and "range" starts with 'r'. Also the struct resource
is printed as a range of values.

> > > > +		[range 0x0000000060000000-0x000000006fffffff]
> > > > +
> > > > +For printing struct range.  A variation of printing a physical address is to
> > > > +print the value of struct range which are often used to hold a physical address
> > > > +range.
> > > > +
> > > > +Passed by reference.

Best Regards,
Petr

