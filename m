Return-Path: <linux-kernel+bounces-561041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8764A60CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 601327A6A85
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 09:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557F71DE8A5;
	Fri, 14 Mar 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OkRKDhvx"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6EC153800
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741943532; cv=none; b=L8CBYjUDyHPBmINUp2U0kUlSFIuuQnFf0YyrUsMI9r0Om2/XPszmDIhBtr4jqMdMlu0kdyN6ncXWDzwOfxso5G478WouuUtJczmsr1Rvhdzp2RP8f2IkG7SMDEqecrmmr4tMIzW3JlreLReQnAkrkGSBznhbI/tWx575AtYCBk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741943532; c=relaxed/simple;
	bh=TsjitWrK3xkdZIZ++k5u4aM4ayNaICEfWcjvMj8mMEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/QFKfIOL5aOugUcrmN3ehRwQ5wXN8utR1CWDEBKLCK1r0rAFk4lBd8M4kgUk5sPIcmcsobcm+/2RHOhvXlD1On99c0i4mJvW/HpaAhHwm9ZqTxOrzmY/qqB3wRnAD1GigSpi89NtC/F8UosBlTGvbrEqRk59YUXR7cvICPzrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OkRKDhvx; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-43cf3192d8bso29005e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741943529; x=1742548329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUPGudLzEqaRzdhkeIOV3PPyAaGCuTB/Qf/w1m67Uvo=;
        b=OkRKDhvxdrFN32AwXkHyepg5Zbzt6Ec9TbpGZYngkBc7GZG1GWlyEMMi1Cikh4jR1e
         YYziLVO8avV95feC4D1ojB+cTZZ3B8+msgE+XzFw5PbGrxGrsAj411/EbOmvk0cZjFLf
         i6+3T+NMYx0at3ZBYMzNQWEv+xtt8pQL/OBk7OC10A/EH/jpkbHkpBsg/nt/lMKMLU7O
         caFPS36ecxhAKV/5LxYI/AWU7w2tlhqfOojAo2SF6e0VnvypNSzbKK0y0yacsry/wGiH
         81vM0nfy1b2znVFOAOlLBHHS/gunzr18Uxb3Ss4+PJkTmuqBr6bMI22wfaDK6YGnO1l+
         +Slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741943529; x=1742548329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUPGudLzEqaRzdhkeIOV3PPyAaGCuTB/Qf/w1m67Uvo=;
        b=XDhZIlVgv0mWhNU/rB/yoXkZHUeuT378CtJq2HQNPbX1HlKUMLeWDS0pgduT8mvEpj
         /RTll3ATpQ4v+zaxNW8h05dszieci2sERg2zc4SbSQ+jFQRxmhHg5EXvgEWjNtFZUau1
         DbuR28uS93vXIatAkTemjI2A2UD+SlArg5v+86GgfVBf9sQn7/bDhzOxJDSN7ccoxqo0
         nHhZI3Z72U+bx8N+lSYKGG42W6FZxx0lbaC20xSLX3WmBezdnlaIiqgK+HO6wHnppRLF
         6xcYT/AAcgro8I5CdN1LTkJ8drI5H1QH2jQtrPrgzwUKf8uUA7a8BLJqHzJDUZnbiTfk
         XPiA==
X-Forwarded-Encrypted: i=1; AJvYcCW04vY3GEIdJ3p8MbqcOXSppfdrn/98BVU/gwiMI1cnrMh6WzUaQxcvobVsGLykPt2vWGftnT0YsQr5/tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YydabWJ6GdYFwWqPVTu0qDUDYvM9xYHaHA3vO5Q9xjB/LsYYWjV
	9tbV36lB3FuI86qr0jYaF9wUmN1jedY+2hNNQSYbPvPXOBPsVgbYeW8IYApoQg==
X-Gm-Gg: ASbGncvh2F7jsuzLHYa2KaTgjEvRKJS98H13WkliuSjGCjiOzmiKkyzQ0gLBa92aUqT
	zTGK2CVkXzwk2micqNvh4uRKtV5p6xtXyLIcA4iK+DZnTQaYY9pG8bBiY7hyKAHF4vE/Mz81jgv
	QUc52bGkPWvnkP4llO3JmsIgnNmiIHGGByFEpd58JaepAjIPrDnqmGnAn3jmvzF3lju00YneqCW
	QLVRhGFCNOOu8ESSVAoOctaaZ7Lm2kJuAnaNh+g2U+aN2qnguDUaO17NEFAHlK8hhpewzSlPiC0
	IvlHnV8d5ditdi/BuHxrJ6SQGXs6oEsXh1kBpAlU5OucrBDKI727ZjJ63mYWKlQx4EP/yai7dbw
	0qX/JlO4=
X-Google-Smtp-Source: AGHT+IGBuVLBueavIMiito5j0RRPZQVYBZUrSxgi2O710uL/BIyQ1BMPGATKnS7423KLLmyr8ewWiQ==
X-Received: by 2002:a05:600c:5584:b0:439:9434:1b66 with SMTP id 5b1f17b1804b1-43d1eba43d2mr776045e9.1.1741943529069;
        Fri, 14 Mar 2025 02:12:09 -0700 (PDT)
Received: from google.com (158.100.79.34.bc.googleusercontent.com. [34.79.100.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3978ef9a23bsm493146f8f.15.2025.03.14.02.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 02:12:08 -0700 (PDT)
Date: Fri, 14 Mar 2025 09:12:04 +0000
From: Brendan Jackman <jackmanb@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Rientjes <rientjes@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Mike Rapoport <rppt@kernel.org>,
	Junaid Shahid <junaids@google.com>,
	Reiji Watanabe <reijiw@google.com>,
	Patrick Bellasi <derkling@google.com>
Subject: Re: [PATCH RFC 03/11] x86/mm: Add lookup_pgtable_in_pgd()
Message-ID: <Z9Py5PX05iKhreqr@google.com>
References: <20250313-asi-page-alloc-v1-0-04972e046cea@google.com>
 <20250313-asi-page-alloc-v1-3-04972e046cea@google.com>
 <Z9NXkZ0_5dtqzaUB@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9NXkZ0_5dtqzaUB@google.com>

On Thu, Mar 13, 2025 at 10:09:21PM +0000, Yosry Ahmed wrote:
> On Thu, Mar 13, 2025 at 06:11:22PM +0000, Brendan Jackman wrote:
> > This is the same thing as lookup_address_in_pgd(), but it returns the
> > pagetable unconditionally instead of returning NULL when the pagetable
> > is none. This will be used for looking up and modifying pages that are
> > *_none() in order to map memory into the ASI restricted address space.
> > 
> > For a [PATCH], if this logic is needed, the surrounding code should
> > probably first be somewhat refactored. It now looks pretty repetitive,
> > and it's confusing that lookup_address_in_pgd() returns NULL when
> > pmd_none() but note when pte_none(). For now here's something that
> > works.
> 
> My first instinct reading this is that lookup_address_in_pgd() should be
> calling lookup_pgtable_in_pgd(), but I didn't look too closely.

Yeah. That outer function would get a "generic" PTE pointer isntead of
a strongly-typed p4d_t/pud_t/etc. So we either need to encode
assumptions that all the page tables have the same structure at
different levels for the bits we care about, or we need to have a
switch(*level) and then be careful about pgtable_l5_enabled(). I
think the former is fine but it needs a bit of care and attention to
ensure we don't miss anything and avoid creating
confusion/antipatterns in the code.

And perhaps more importantly, lookup_adress_in_pgd_attr() sets *nx and
*rw based on the level above the entry it returns.  E.g. when it
returns a pte_t* it sets *nx pased on pmd_flags(). I haven't looked
into why this is.

So yeah overall it needs a bit of research and most likely needs a
couple of prep patches. Hopefully it's possible to do it in a way that
leaves the existing code in a clearer state.

Anyway, I was originally planning not to have asi_map()/asi_unmap() in
asi.c at all, and instead just kinda make set_memory.c natively aware
of ASI somehow. At that point I think this code is probably gonna look
a bit different. That's something I ran out of time for and had to
drop from the scope of this RFC. It's definitely not ideal in this
series that e.g. page_alloc.c, asi.c, and set_memory.c are all
implicitly coupled to one another (i.e. they are all colluding to
ensure asi_[un]map() never has to allocate). Maybe I should've called
this out as a TODO on the cover letter actually.

