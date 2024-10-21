Return-Path: <linux-kernel+bounces-374568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 005049A6C1F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E6911C233F8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D6E1F9A8C;
	Mon, 21 Oct 2024 14:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="S++tiTE4"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD61D175B
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521054; cv=none; b=e6lcu/8myDIwV60G5X8QlyJ+48cHj+1PqtwtDkusG1Y5d6POQuOR1nXQM/2V9rhJyf0VKAA0OBfN4uAh0/MgV84X+TurDaWQ4vtOkkFzAppVuIMjuqai3oBK3U8a0Px79BuoZzVbDutGsu2zMo+9nji06+/IZbiWlK1oe8zEvdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521054; c=relaxed/simple;
	bh=Sc+LN0q5i2NE0szrVmCew0GsCYed27xDCGnWqY8FI94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7ymYrFw5fU6/RIdtRxFHX0LABt1kSgrzJf9UBaveMPsviaaNF3CNGFQhY55ZJBkhVI0O86gnyS7Jf16PLrr6fXUBamZHRe5dsE/OeFcHCfa2dXc1N3c/jIjkFypYZ+VCG0oIpV5cZhyr5ua44hUzWq5ehsBclJ8wKKpO4jyeB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=S++tiTE4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4314c4cb752so48340915e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1729521050; x=1730125850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=01UFQeoMaQXOKGoXP/aAgtirn32Uahy6q9T6LIQy8Dg=;
        b=S++tiTE431Qwy4wN6bQ8bmebX0/CaZz/ZgiAsv4iOiAR2CP27fv81XN6EifJbm05UF
         +ikH+lQpomW8cse52aRP+C++ots0S5MDWvyC1yDnQshtmAklHxYBmzROabCUR1RcSofN
         FzkMTgBVTty7GuSzVDhu/YLc7E5/VAKECWcFglveRA4wSBfiEQzI4fLpq5lBjhhSIZJF
         FSyvQqDq66ghjdjR9moj95RJ4BeHspTvKTGyATUYmnEdTuooCh0JHip9URKaHz+ZJesE
         BHvTPlvh5twtwoopGKWMXiXH2p/9VLoyjWlin2ZSfAQMtA2JDY+DIKVEB440aMC8p8Cu
         Og8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521050; x=1730125850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01UFQeoMaQXOKGoXP/aAgtirn32Uahy6q9T6LIQy8Dg=;
        b=dqtXCm3Xn3hA4YDfRJKOY2t+gOPZZzJq34Cy9FZCrxY95jSEwdD036/gYm7Lt5GMph
         93m+W8uDoevmqqVfk3CRWcw1wBKoeywyj0UixAG4MCzrxq74Kz3TlHRL6LTMtUS6lDZR
         MNI06qdTPfulsZpysvsG9ZCa/GnmMhC7oVSriIOeBQAE5bZw/umx1/uLsicToziAXHkQ
         SxRiTfRabU0B37ly8mJx5wEfiHkVBPY6OuHy9rj6QBw6A98ZK6O4xlZBRmx0Y6csaF3G
         MyZYKtyvFG4CpRl8vIsh11al7A/FWrKErDY6kchHSEwQ2/zBi+qYpKxy9ixzOU7iN5la
         /4bw==
X-Forwarded-Encrypted: i=1; AJvYcCV+/ITtC4UeuZNYlUMPNvXRADWoPg4e8LMUwg1BKHHAEkopTTA/+vCEiUH8hi1R6Z9y0nKPO8s5Ru/CIwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOp72m/+ofasOutSG6j8yB78uOA0z86o0Min0gXxz3c7k4Ja2
	jfzOrd33xL9jfJU4l0n67yEFaWQU73t4+AMSoVlmJ4Wx9xR74VWjbOcbVrYfdXJYdC+VZ8R0CDj
	h
X-Google-Smtp-Source: AGHT+IH5q0AIFqMdR5coKdz2cq1P+rp1fIewB2UgY9rBZlltXHaxuFtusgQqQIeQbHmDdhyYGy2ZbA==
X-Received: by 2002:a05:600c:4e12:b0:430:5887:c238 with SMTP id 5b1f17b1804b1-43161628886mr98311715e9.11.1729521049783;
        Mon, 21 Oct 2024 07:30:49 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5c3046sm59115665e9.35.2024.10.21.07.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:30:49 -0700 (PDT)
Date: Mon, 21 Oct 2024 16:30:47 +0200
From: Petr Mladek <pmladek@suse.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <fan.ni@samsung.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/3] printf: Add print format (%pra) for struct range
Message-ID: <ZxZll3-NZreHlRaI@pathway.suse.cz>
References: <20241018-cxl-pra-v1-0-7f49ba58208b@intel.com>
 <20241018-cxl-pra-v1-2-7f49ba58208b@intel.com>
 <6712bf8240b8d_10a03294a6@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <6715c14e9bbf6_747d6294ed@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6715c14e9bbf6_747d6294ed@iweiny-mobl.notmuch>

On Sun 2024-10-20 21:49:50, Ira Weiny wrote:
> Dan Williams wrote:
> > Ira Weiny wrote:
> 
> [snip]
> 
> > > diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> > > index 14e093da3ccd..e1ebf0376154 100644
> > > --- a/Documentation/core-api/printk-formats.rst
> > > +++ b/Documentation/core-api/printk-formats.rst
> > > @@ -231,6 +231,19 @@ width of the CPU data path.
> > >  
> > >  Passed by reference.
> > >  
> > > +Struct Range
> > > +------------
> > > +
> > > +::
> > > +
> > > +	%pra    [range 0x0000000060000000-0x000000006fffffff]
> > > +	%pra    [range 0x0000000060000000]
> > > +
> > > +For printing struct range.  struct range holds an arbitrary range of u64
> > > +values.  If start is equal to end only print the start value.
> > 
> > I was going to say "why this special case that does not exist for the
> > %pr case?", but then checked the code and found it *does* do this for %pr.
> > So if you're going to document this special case for %pra might as well
> > update the documentation for %pr too.
> > 
> > Alternatively, drop the new %pra documentation for this corner case as
> > accommodating the U64_MAX size range case is arguably a mistake in the
> > caller.
> > 
> > Either way, just make it consistent.
> 
> I've dropped the special case in the documentation.

I would actually prefer the opposite and update the %pr documentation.

The behavior might be surprising and people should beware of it,
for example when writing a parser for the output.

Best Regards,
Petr

