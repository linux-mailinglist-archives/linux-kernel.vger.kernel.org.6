Return-Path: <linux-kernel+bounces-536969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72FDA48672
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6311884387
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9251DEFEB;
	Thu, 27 Feb 2025 17:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="v0fFg3pO"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3761DE4DE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740676824; cv=none; b=vCc+V9cPUYal8zPWAVppBGu+mnO4R6GFBqyry71uJ/ugnanQ37AhuEZPURpijUehbAQeGsiR61fyV+T5LYLL+BfwImG4rmB8HsWUpss9eoC9gplUQGwpYYshRFOOdj3/UgUSEd/9P7ATt/BLSj21YKE4efg06NOWNJCBC9xe/s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740676824; c=relaxed/simple;
	bh=DD+L9PFD/s12tWsKeLqsRKNjPUnjAfNbNlHUtjvytHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mB1ABEGLFAJqvnI9h8RlaKlfFE+7EptPV5LtnenloUCJI/+Ru2A+TQAbpUHsp3U8CrYkYPGOGc/jP9T6C0kfA7xDiGojvmUyWkh9QO3+Au8/N1hUwid1s+rzR630OkqwIGNAwe/YyE3ZwhYxfS3YRNmgMB4oP20ICEfvojyleUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=v0fFg3pO; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dd15d03eacso12095526d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740676819; x=1741281619; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xkF+oKOLzsqihO895ZKdKMiAlH7piGTcjUjNfw+BEIg=;
        b=v0fFg3pOHa7yhtDPczXC1iqZBEqD3Bmtdytbuf1kWZsRdTK30lHnZLwB6336ptddLd
         qOWgOWPgMuXOQ6/TTCa1Ee3/XPI2SPJuJ9ym7ME6adsIf3e67HQ0uXn6neBU6ysJ1pT/
         3AhH2plQwCo8vJcI6j57B05b5Q+VAyLNpiY38x4Ol0/DWO7YgrJm7Gfy9znpp51YMXyP
         oZzFP157ddb1wKi0Rs7Rg4Dv8muJ3UxIDLa0npHeht6o5aYqasFI5hC3m4U2SRah6ZJk
         qAJ5NtO5esh8H0VpRfvMVu9MXrqzgNeUle86ELtkHCb/3m4eEgXPYRm4JMqOjnGwlJ4Z
         9mxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740676819; x=1741281619;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkF+oKOLzsqihO895ZKdKMiAlH7piGTcjUjNfw+BEIg=;
        b=nKzOvXJsKNI9mT9WHkEjKmvJBcaSWFe9/vykWsCLcpaeRs3DEUc8G25rXzyPD8JJ0C
         918PwjMCEbvonU3l+FOl6uMvEnyTvFcwOnoOSJg0+jRK/+kCBFg1EC0uuhOQdVxDdzlZ
         RzCeF2qcNbmtlUhC8yOoDMehw6opvowXuwpLny72fUt4qeTXMzSZrl8p76xpj8GTu7Pa
         JPMKs71xvyPc4fAjs15/XB0bjegECfXlHrb0nzqvC5irOdt6Kg3RyowA6ntpxD/WYEku
         uJaQcHk32AclHS+R6KR0P/jXCj7+oDpisjk+XeFvDckjHyF8vzncGD972GTZU5gPwFHx
         2VBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUovPHTzwuEO3G7WxUN/BowUle+4AlsdUhVZwAPZCDh8rZMUQ/zNSwuf2EDHd2d0qLfVVqPz4rn83tdjz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/j+mj0YT2dhY5CQIg+Q79To+8IRZ5EsFrcdxTVaOaKOGocre2
	GvUQCqLc2cgsZ7uPrZO1EbLPe3TGx8OEqpoBeD1sZCiwJnDfI+fx+E5XmNrXMn4=
X-Gm-Gg: ASbGncsHK974I5RIuCU5CpXQGD9/OQo3+E6tjwlANrJheE/FPcvrDiZ+I1daz5ytS2Z
	2BbsP6V4/okIHzxGVUL7V4MMq1yRTHtIePt/GSaXJGUAugsU/bl0h6Gc/lIH9xNbF7GloByDfBg
	ccgk/vqPZpMgJe9g3F2JoeYNfq/3ODMokVZn5iHiX8TLZulcIn3cUUy13V7b1puz1RoncPVYkS4
	2VFboylmC4+OIa/tZHJ4Xyq1n1EBbC09RFtzYRqw0GC5n+G5/NGjlTyrlL8NdG8wgnGGnyBMfMd
	2Gw0k7M0pnxZFalsdy4pMz5F
X-Google-Smtp-Source: AGHT+IHYdFq65bDVHKEvy9PllmIUfIQ1sDzyYzXU29H6mgO9datE1+4OGR7iAKqeSXBKN69623GlPg==
X-Received: by 2002:a05:6214:2462:b0:6e4:2479:d59b with SMTP id 6a1803df08f44-6e8a0d775e9mr3865626d6.16.1740676818915;
        Thu, 27 Feb 2025 09:20:18 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6e8976ccad9sm11798956d6.70.2025.02.27.09.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 09:20:18 -0800 (PST)
Date: Thu, 27 Feb 2025 12:20:14 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Frank van der Linden <fvdl@google.com>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, yuzhao@google.com,
	usamaarif642@gmail.com, joao.m.martins@oracle.com,
	roman.gushchin@linux.dev
Subject: Re: [PATCH v4 10/27] mm/sparse: allow for alternate vmemmap section
 init at boot
Message-ID: <20250227172014.GB115948@cmpxchg.org>
References: <20250218181656.207178-1-fvdl@google.com>
 <20250218181656.207178-11-fvdl@google.com>
 <20250226180900.GA1042@cmpxchg.org>
 <CAPTztWaXZE=y4HBd7ZYW-1pTDrwxO3OBbwNJyu9vpuy22xx16A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTztWaXZE=y4HBd7ZYW-1pTDrwxO3OBbwNJyu9vpuy22xx16A@mail.gmail.com>

On Thu, Feb 27, 2025 at 08:47:18AM -0800, Frank van der Linden wrote:
> On Wed, Feb 26, 2025 at 10:09 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, Feb 18, 2025 at 06:16:38PM +0000, Frank van der Linden wrote:
> > > @@ -489,6 +489,14 @@ config SPARSEMEM_VMEMMAP
> > >         SPARSEMEM_VMEMMAP uses a virtually mapped memmap to optimise
> > >         pfn_to_page and page_to_pfn operations.  This is the most
> > >         efficient option when sufficient kernel resources are available.
> > > +
> > > +config ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
> > > +     bool
> > > +
> > > +config SPARSEMEM_VMEMMAP_PREINIT
> > > +     bool "Early init of sparse memory virtual memmap"
> > > +     depends on SPARSEMEM_VMEMMAP && ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
> > > +     default y
> >
> > oldconfig just prompted me on this, but it's not clear to me what it
> > does. Not even after skimming the changelog of the patch to be honest.
> >
> > Can you please add a help text that explains the user-visible effects
> > of the toggle, as well as guidance as to who might care to change it?
> 
> Hi Johannes,
> 
> Thanks for your comment. How's this:

Thanks for the quick reply!

> Enables subsystems to pre-initialize memmap in their own way,
> allowing for memory savings during boot. The HugeTLB code uses
> this to initialize memmap for bootmem allocated gigantic hugepages
> in a way that is done by HUGETLB_PAGE_OPTIMIZE_VMEMMAP. This
> means saving this memory right away, instead of allocating it
> first and then freeing it later. Not allocating these pages
> at all during boot allows for specifying a bigger number of
> hugepages on the kernel commandline on larger systems.

That makes sense.

But if it's infra code for a hugetlb feature, it should either be
something that HUGETLB_PAGE_OPTIMIZE_VMEMMAP pulls in automatically,
or at least be a hugetlb-specific option that pulls it in.

Keep in mind that not everybody enables HUGETLBFS. In fact, hugetlb is
default N. It's moot to ask users whether they want to enable infra
code for a feature they aren't using, and default to Y no less. You're
regressing innocent bystanders doing this.

