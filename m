Return-Path: <linux-kernel+bounces-215693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFFF9095EE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 05:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C3E0B23288
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 03:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514F8DDDC;
	Sat, 15 Jun 2024 03:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UEF442+r"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31123C8FF
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 03:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718423443; cv=none; b=gagC2EvDFi3PoPF3wc3r648pukJc/3wtHrML4DBFE8nWXtOaD8natyQedkxkkfKw1H7mOgLsHMIinNk9pe9NMcqv373yb6no2TBUq6ZCs63kzY6XXW5kbHjl1zYTfyLCTAyVdBLvtAJz/0RZlfRCvy3KdneQlsCFfP57H20tmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718423443; c=relaxed/simple;
	bh=acgHjqs5bw1TUxLqFNvY0kyYBlZkhQ6Ht3dhbaj+8+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UKoHvvs+UmcfidPSvZVkDUbFIaEQSOh8W/HXyzKT0iVXoaa/Dy+4uIJd9Bj8me1iAt3DtGBs9dP+BkoijNXTqB/IXe8zIRUEdiulMZRxUqAp/smr8x1KfuD8T+5DVSDfqdM+3Fb51QIByfBIbejUj3cTTs5C2Yvj9VvXuDjLc8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UEF442+r; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dff2df7de4aso137335276.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 20:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718423441; x=1719028241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMvh4LLu7+iHaH8H77qbd16ndaMtLZL9+Jqv+C5DkQg=;
        b=UEF442+raKNIaURInlBvsbkvUcjsQ8bY0xLklMevg7nlBhQ+PQ2rnQe+yeHT8xFHwx
         lHLDOCYzRemtgYyESGWA05R8CHq92cvxZCC6N1g73FNwegUpD8y8jBDAxkTI0DFzkMUC
         JXxzM/QdLYh+sf2yEtCyUaD2a/OaQG6rFGXdA5JqERW378qAxVG6VP93VPW4uBKEzUGJ
         e2kWdaHbg0ax9Bk7AndF9s0AaYZ0q0f58dvxaHMB/l925jG8CVUbfj8PiH9oxD8igZ3L
         acWY1ntYomw3lGTOY0PuACH4/a6GtO6u1y7tJ27zsCtmN3iLrXTGBxHNKLhihShv8E6O
         A1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718423441; x=1719028241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GMvh4LLu7+iHaH8H77qbd16ndaMtLZL9+Jqv+C5DkQg=;
        b=vSRp1Q2hNk0iLjFw7VJR5mYxYYKzcDFu5k0PG+RALJFwehGrc22ye/UBJcsuOTHGJY
         3K8/I758BtuIHj6HH14qhNuhsgmqfv7qU2J5p7MLaXW1nEZTuS+poXvjAjmsFNQEU8uz
         DAXaa6s61OvX/nySuzuTKEobCqBDxzA9ncUzwGbzRcKsIgQdqMazscZ38qXaca4J7+qG
         SzmapPZwvLE38LqL5MnOCuwo70CO73IEkBRnSr+BpXfxgtWQBrjj1aP/PsXCxgScCQFS
         hrD27RW0fd4BzWJuLq8z/PIizNzG23bLjumNBTy5H8Ilfmx75QOHYWQ1t5RNRb0oP0Gl
         9C0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAorZvbO7+9WmC++jJ6QXnaCcucmkZ0s5D3PWoV7a5lnHjQFAE0nfS11D1xsDqkQmYu6Jaw0ggwIN1LdxopnfYWOUoj3zW1F2AtFR3
X-Gm-Message-State: AOJu0YxUyJf1y4IzfyKLhBiC2Av0zqBR9oZ8qVuPQ0/v9HDqtq8lBTRf
	7fInm9XlF4+pOXMUgBAg+8NI7Hx9G0P63inWf7I/8LglsOZsp8iWSfoGpnn+jhdegpLIawmdnEo
	/8d72IQvVo76rEg3yopU/XcTYph9nZPXR/kk9
X-Google-Smtp-Source: AGHT+IGLnx1xEu9b8B+6aEjKgrUM0EqAS3CIvalcy4j+YTnXsL71vY+LM+uwuGvau9J41l82mCbnLlylllrH3NHGj8Q=
X-Received: by 2002:a25:b206:0:b0:de5:4a92:435f with SMTP id
 3f1490d57ef6-dff1543ff94mr4328265276.46.1718423440846; Fri, 14 Jun 2024
 20:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614230504.3849136-1-surenb@google.com> <20240614181950.d5cd06acba24339401c98d6d@linux-foundation.org>
In-Reply-To: <20240614181950.d5cd06acba24339401c98d6d@linux-foundation.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 14 Jun 2024 20:50:27 -0700
Message-ID: <CAJuCfpEd4Rnd=5hMk4N_Q9Gg4e3mSfioJAsqufvzOeN01aRpbg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: handle profiling for fake memory allocations
 during compaction
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kent.overstreet@linux.dev, vbabka@suse.cz, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 6:19=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 14 Jun 2024 16:05:04 -0700 Suren Baghdasaryan <surenb@google.com>=
 wrote:
>
> > During compaction isolated free pages are marked allocated so that they
> > can be split and/or freed. For that, post_alloc_hook() is used inside
> > split_map_pages() and release_free_list(). split_map_pages() marks free
> > pages allocated, splits the pages and then lets alloc_contig_range_nopr=
of()
> > free those pages. release_free_list() marks free pages and immediately
> > frees them. This usage of post_alloc_hook() affect memory allocation
> > profiling because these functions might not be called from an instrumen=
ted
> > allocator, therefore current->alloc_tag is NULL and when debugging is
> > enabled (CONFIG_MEM_ALLOC_PROFILING_DEBUG=3Dy) that causes warnings.
>
> It would be helpful to quote the warnings for the changelog.  And a
> Reported-by:/Closes: if appropriate.

This was not really reported anywhere but if someone hit this
condition (it requires compaction to be running) then the warning
would be generated.

>
> I'm assuming we want this in 6.10-rcX?

Yes please. Otherwise someone will report that they are getting this
warning when the system is under memory pressure and
CONFIG_MEM_ALLOC_PROFILING_DEBUG is enabled.

>
> Please help in identifying the Fixes:, for anyone who might be
> backporting allocation profiling.

I think we can mark it as

Fixes: b951aaff5035 ("mm: enable page allocation tagging")

but it's really a separate patch which covers a corner case.
Please let me know if you want me to send a v2 with this tag added.
Thanks,
Suren.


>

