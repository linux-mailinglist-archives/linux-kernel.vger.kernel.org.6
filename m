Return-Path: <linux-kernel+bounces-536984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2AAA486A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 18:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4243B6EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E891D63CF;
	Thu, 27 Feb 2025 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MjYQaf5E"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B5C27002E
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677552; cv=none; b=bnWoBALcIndKN4qD6Dr8OQSRTwONXauXeEHfwfg3E3Zrve56mJ7XcmH24h+HyLqmCgYyU9Y23qfWtRq6WCAlSHaDPNKln2xwvm12Ax1tw+kZQCkcLpBGQMm6/JfwhbdjtGYxWGVEkw8n2MGtpZ/50yKbh7J9uneKX1BIqF9WOBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677552; c=relaxed/simple;
	bh=Z3IuWM/W7lmiP2K3+AFDpFzdEVVcd87uPP0gX7ql2yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K7xeYuNyK18mGn/VoB8+b3oKqwxmZPfDKPkXcZiXV0bSq51RrnhYRi87LbbP8Hd4IReHOZYghpAzqnjW3L44GhQr7HaINu6l6oRRhaUD0GlMFRzkzmKOMkr0vkR9Dv9FolLZYQhe2pd43jBFlEkEz+QFOfvix9EXvXRvkK9ett4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MjYQaf5E; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-471fbfe8b89so1811cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 09:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740677548; x=1741282348; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcbhEh9hMZ5qsc9WvHnTGNUOu6iJ76ldwk6sVXnK2BI=;
        b=MjYQaf5E8T5eBb6YWewYOy4lzCD0RqOk21rMBjEJil27DjgBwTFDLT4kXo+giu9XeU
         gojmc1z7gHrsj8Dr6YSEB3Pz7ODzjLR4ChD/daT695eUdqPwAHT/3R1Ir9UnLB1xWy7Q
         kJaQLtH6+1QL82PPeyVzIXlEQPUS8CUG1A/ysJqXdS4eDPv9IRjuBrurr3NYHSgtinYb
         M3NecGZI2A/vnroEzQAKk8Fh8bErQ+3tfCoWx/4s0o14UPv/4waH9ge4+Kim2jgupn8E
         NZWb4FmsSu1AT5UG1mN38yUO7KikuUZ8KY5EqnJhlv4gL8PFaQBVZNbjYfNM5N+0I77p
         C+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740677548; x=1741282348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcbhEh9hMZ5qsc9WvHnTGNUOu6iJ76ldwk6sVXnK2BI=;
        b=UiEf9P4XCnyCwAV4eMM7eZlAQ2JOfdC3nCsoxZoAnZxcO7CxQoCpewrKlNsnBHQfMq
         nSLS1UPGkzZ7BA1NondYgYXHovbWYzCJ5FZzDzpyAcr940pLmxwC0vn/CNQAOkB80s1C
         cuGYl6/LHB4oidcXiRZ9E+PR8QXEpJmWDxVI2iCCtLeIvON6l0vw3H/Ig/CP7TPcU6Tf
         9GSXygpSG7/nLbFvSmCM8tzd4vbgjBeDuY4bsmdHSIupjyl5keSqXRqHpdn7UjBi4Vjq
         6LtLxdasE2ibH2TE4P95U7fcoM/5J18c3wiMqwiru303Vq86u7Y4/paG60OtVpFR0eGq
         C+uw==
X-Forwarded-Encrypted: i=1; AJvYcCU+yJ0VGbGP1+l1+8b89hYgaBQ7kuF2iSSMEzI3NCWp2XlSMwHP5HcRun88Hy/EeFaq5T1fU3PSV4LBNUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzogHDRplONUQvs2/pixzBw+heoIqiGJ6chPxM6OrGcZV15RdoB
	2fS+5jmPTCM0NtCJVY7+ELhtJWyAq2Pky6qXcYosvY728I5GF4lK7b86xQn4W+vRE6bteSi36CK
	c3oajvidXgbNLfw5Z0v7j/O6VqkGBahm+Vh/C3ZzPucPGz3eS8A==
X-Gm-Gg: ASbGncuLeUUfwjqno1zAZwlLYaL1px3KbgBevEzO/n67yISJeXEe7iQ7q5qvq2ES7Pc
	GbPVysVqnTOYXRmF5GsNgB/ruxPCJeJMX5lJztTdeiWNU5jNHV4W5/No21bqjd66pn8XwfeqpT1
	bkJvcO
X-Google-Smtp-Source: AGHT+IFrYJNNwmBAFlcMxIdAWm4vNnKbsEcLzhZTuS1BHzxgJc44+uCn1lhgkKXCzZY1msiEDzt62MKxw24kvbP6i9A=
X-Received: by 2002:a05:622a:118e:b0:471:f560:27dc with SMTP id
 d75a77b69052e-474a7c7b02fmr3212451cf.27.1740677548198; Thu, 27 Feb 2025
 09:32:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com> <20250218181656.207178-11-fvdl@google.com>
 <20250226180900.GA1042@cmpxchg.org> <CAPTztWaXZE=y4HBd7ZYW-1pTDrwxO3OBbwNJyu9vpuy22xx16A@mail.gmail.com>
 <20250227172014.GB115948@cmpxchg.org>
In-Reply-To: <20250227172014.GB115948@cmpxchg.org>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 27 Feb 2025 09:32:16 -0800
X-Gm-Features: AQ5f1Jo8O8j3DkJCzRv8ZoeklVnTVB7mpsmpsFjcsNjR_kmG4CiBpSSVpujo95c
Message-ID: <CAPTztWYgZ=fwOWv-sKs-wXHCqhPbmJm6qkrDqE+_0c1nUwWM3A@mail.gmail.com>
Subject: Re: [PATCH v4 10/27] mm/sparse: allow for alternate vmemmap section
 init at boot
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yuzhao@google.com, usamaarif642@gmail.com, 
	joao.m.martins@oracle.com, roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 9:20=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Feb 27, 2025 at 08:47:18AM -0800, Frank van der Linden wrote:
> > On Wed, Feb 26, 2025 at 10:09=E2=80=AFAM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> > >
> > > On Tue, Feb 18, 2025 at 06:16:38PM +0000, Frank van der Linden wrote:
> > > > @@ -489,6 +489,14 @@ config SPARSEMEM_VMEMMAP
> > > >         SPARSEMEM_VMEMMAP uses a virtually mapped memmap to optimis=
e
> > > >         pfn_to_page and page_to_pfn operations.  This is the most
> > > >         efficient option when sufficient kernel resources are avail=
able.
> > > > +
> > > > +config ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
> > > > +     bool
> > > > +
> > > > +config SPARSEMEM_VMEMMAP_PREINIT
> > > > +     bool "Early init of sparse memory virtual memmap"
> > > > +     depends on SPARSEMEM_VMEMMAP && ARCH_WANT_SPARSEMEM_VMEMMAP_P=
REINIT
> > > > +     default y
> > >
> > > oldconfig just prompted me on this, but it's not clear to me what it
> > > does. Not even after skimming the changelog of the patch to be honest=
.
> > >
> > > Can you please add a help text that explains the user-visible effects
> > > of the toggle, as well as guidance as to who might care to change it?
> >
> > Hi Johannes,
> >
> > Thanks for your comment. How's this:
>
> Thanks for the quick reply!
>
> > Enables subsystems to pre-initialize memmap in their own way,
> > allowing for memory savings during boot. The HugeTLB code uses
> > this to initialize memmap for bootmem allocated gigantic hugepages
> > in a way that is done by HUGETLB_PAGE_OPTIMIZE_VMEMMAP. This
> > means saving this memory right away, instead of allocating it
> > first and then freeing it later. Not allocating these pages
> > at all during boot allows for specifying a bigger number of
> > hugepages on the kernel commandline on larger systems.
>
> That makes sense.
>
> But if it's infra code for a hugetlb feature, it should either be
> something that HUGETLB_PAGE_OPTIMIZE_VMEMMAP pulls in automatically,
> or at least be a hugetlb-specific option that pulls it in.
>
> Keep in mind that not everybody enables HUGETLBFS. In fact, hugetlb is
> default N. It's moot to ask users whether they want to enable infra
> code for a feature they aren't using, and default to Y no less. You're
> regressing innocent bystanders doing this.

The main reason that I added a separate config was:

1) I could see other subsystems use this.
2) The number of section flags is limited, so I wanted to put the one
I added inside an option instead of always using it.

If especially 2) is not a concern or can be solved differently, I'll
be happy to remove the option. I don't particularly like having it,
but I didn't see a better way.

Let me think of a way to clean this up a little, and suggestions are
welcome, of course.

- Frank

