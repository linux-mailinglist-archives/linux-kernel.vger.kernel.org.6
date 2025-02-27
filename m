Return-Path: <linux-kernel+bounces-536905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B15BA485D8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89833179A69
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E751A3178;
	Thu, 27 Feb 2025 16:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YhHMxDun"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99831B2EF2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674853; cv=none; b=IPtpTeYK+DbKCE4zyuaGwmPqlm/6yc5cntYzAPYziXkoDCib9kcOGOfqhkunxrQlVsxw0LXyUY51HQAG/cQzlpDR0PaSAZ1htNHfs+QgAlS1bEqsJ7hFkXXw7rnTqm66/Eto7P5uO9eQ8vjPEPV27oKc6TaZrYGzQj6JCbvEDLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674853; c=relaxed/simple;
	bh=JP0AuB3kw2PEi3GW+6fgAezX1Cf3DmKkSFC+S2+PILM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DSl2MfL0Q+uYKi7ObTUADY/lhLfMhNVnUSL/ZNDnpfsQCCtsRGnBH4KwIFZJ1QVxeYZoZgEWQNvxecmyb+fqSZEwH9XsWd91/zmVTy3Ct8BQumn0VwUn5gcJNdIsagl8h267/eFrAPyoA5HVfA+bd6XU23K4G1WmLThH5QfCOaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YhHMxDun; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-471fa3b19bcso344501cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 08:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740674851; x=1741279651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3mjCIbokKR2si82Xd+QOzbLqWQ/e+owXf6s86/Cdu8=;
        b=YhHMxDunluXZvQaXZxXs5jrmaokKnCFLTHf+JBaFQl5PgjrdnjYXCX6besEN/o+O8c
         tJrRRr+4iY8Hkz8H11oCKgHOt5WOti86tbCYckRGkRUpMsCKnjZU6gmfe7TSAoEV7bdw
         yaR20BEn5IsuIi6tXjvo9DZ1ZQ9OrpfhKLGn8lOwF5tQHC2RCQ3Sm+M6msb6tXwUQVTI
         vJgECm09jQZOHmvaNQMG5kQ1dbStTAzpBTB2gDRl2HsccSqb8Eh/TocnQrCqAVpBf4Il
         hAbkPxbVa6wiH9ckccN8GJia5QxTzY8gKokYDQ26A3jBVBMM8UnWAfUxPZEYCtFnrs21
         8vHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674851; x=1741279651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F3mjCIbokKR2si82Xd+QOzbLqWQ/e+owXf6s86/Cdu8=;
        b=dPJjom+/IXqvFWqPlNv2LGVhPF3GDB54BiMh8paI+AeVa8It203RZPJkc4vkXM7gbw
         jXcvq6UT7ZXmswClLFGcb4+XAEbEvzzfkJ9vCEEkHGM74tSLH1N10srm9eqVGCWXchDA
         y4Wld+B9Gk/1SP8Fi2TR0VtFzXf3YNf3b1dUHevYddZi/3300AyLINUaqqq/U3b/Dvv4
         qIr2iBwQ9BL6HGouWpkqkATdvKcuyWNvpMBCzyZzEQP/s1tIH10M3Y2an8k50no8Fcu0
         SYuKb6NBCs1+nwL48sG0Kqg1hHCZte5/Khfi7ucnZkgDaNiPbV4Z4FXAjzm3+zl9Byld
         frOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXon1MavyBzA7GCPncjfy/Q/HwQEKIWRmI8gk6GydOwlkFHMWQA6CIusIraBg1JXU0UwrBBF1S0E8eP4HM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfdkWWevpeU3YRC2s+PHDwUaH1rhWg49PrZtjUmdFr8i+lCpid
	+TPm3FkPyayU3f9CYJy5eJhGqv+rq0iGlhzh8N8lYTo741eR5VBOS+HA7Ac14kkmn5E3RCBcEOE
	4IhFQO83A4zjlnKasmnPBgsRE5HYe09L+Hyy6
X-Gm-Gg: ASbGncvuO6f4+2twAYLDNXkwC6ufswrEchSyNZs3HEpM6jipEUlRWq5VA3bEuQBmdua
	rzwrHeeYNlQ5XzmuaPk4b9ILWFj15vX0K4DXNtuHUDW2xJz3bJiWPXM+UP4NxCyCnDv+mAt8HpE
	PAetvc
X-Google-Smtp-Source: AGHT+IEg4PcLdbPR2re8NB1pY3Girc/Jo/BSDCGC2xaMrI1YsccVev++KKt3DEL4KRUJ2CNAhqwrxeA4tHDLG2o46vw=
X-Received: by 2002:a05:622a:4d2:b0:472:478:b124 with SMTP id
 d75a77b69052e-4742e0f550fmr4387451cf.4.1740674850553; Thu, 27 Feb 2025
 08:47:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218181656.207178-1-fvdl@google.com> <20250218181656.207178-11-fvdl@google.com>
 <20250226180900.GA1042@cmpxchg.org>
In-Reply-To: <20250226180900.GA1042@cmpxchg.org>
From: Frank van der Linden <fvdl@google.com>
Date: Thu, 27 Feb 2025 08:47:18 -0800
X-Gm-Features: AQ5f1Jq4MYeH7gOFJQGJ71-iV_kaHKELQA_gD8gPyEFnkP_235vGg7zbJImj8JA
Message-ID: <CAPTztWaXZE=y4HBd7ZYW-1pTDrwxO3OBbwNJyu9vpuy22xx16A@mail.gmail.com>
Subject: Re: [PATCH v4 10/27] mm/sparse: allow for alternate vmemmap section
 init at boot
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: akpm@linux-foundation.org, muchun.song@linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, yuzhao@google.com, usamaarif642@gmail.com, 
	joao.m.martins@oracle.com, roman.gushchin@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 10:09=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Tue, Feb 18, 2025 at 06:16:38PM +0000, Frank van der Linden wrote:
> > @@ -489,6 +489,14 @@ config SPARSEMEM_VMEMMAP
> >         SPARSEMEM_VMEMMAP uses a virtually mapped memmap to optimise
> >         pfn_to_page and page_to_pfn operations.  This is the most
> >         efficient option when sufficient kernel resources are available=
.
> > +
> > +config ARCH_WANT_SPARSEMEM_VMEMMAP_PREINIT
> > +     bool
> > +
> > +config SPARSEMEM_VMEMMAP_PREINIT
> > +     bool "Early init of sparse memory virtual memmap"
> > +     depends on SPARSEMEM_VMEMMAP && ARCH_WANT_SPARSEMEM_VMEMMAP_PREIN=
IT
> > +     default y
>
> oldconfig just prompted me on this, but it's not clear to me what it
> does. Not even after skimming the changelog of the patch to be honest.
>
> Can you please add a help text that explains the user-visible effects
> of the toggle, as well as guidance as to who might care to change it?

Hi Johannes,

Thanks for your comment. How's this:

=3D=3D
Enables subsystems to pre-initialize memmap in their own way,
allowing for memory savings during boot. The HugeTLB code uses
this to initialize memmap for bootmem allocated gigantic hugepages
in a way that is done by HUGETLB_PAGE_OPTIMIZE_VMEMMAP. This
means saving this memory right away, instead of allocating it
first and then freeing it later. Not allocating these pages
at all during boot allows for specifying a bigger number of
hugepages on the kernel commandline on larger systems.
=3D=3D

- Frank

