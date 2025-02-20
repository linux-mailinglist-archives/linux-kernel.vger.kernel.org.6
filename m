Return-Path: <linux-kernel+bounces-524706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFC9A3E612
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A1517D69A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA0026388E;
	Thu, 20 Feb 2025 20:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidfrank-ch.20230601.gappssmtp.com header.i=@davidfrank-ch.20230601.gappssmtp.com header.b="B9vaSphN"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2473385C5E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084407; cv=none; b=VoTw9tq8PlOIw0z/nU7WAlZkaFRNfU6ExU322c4gbF89u3kRh4ldePsL2a2AZsUll2+2QieimkVCZAbt5T1XC9X6zqQIaBdpW+rWLZTr58J4Un0b3JXV7ix8b/ZcI9TwJ752TUjmQ074BCFLHqRa2QKFrfr+UJS4PV06/5YVNAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084407; c=relaxed/simple;
	bh=m+FGt3B2sml78Z33NDEWBnEXJ2v72RFFLzbRmIFRHG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdlHE9CExRdcEKv5IrXwRT+OFkQreuCh631SbYO96PZ9IjFXEC4Vqx5mUkpY3x21UJj+QpGHP6hILnjlCv881L4qd+6Ik9c2YLs3sVJ8vMfP1TYtjTCVXvNN5PUMzlX5VGjXB0F+RQGlr352TCUSLGGjzQvnu2TYdfXHCxWqakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidfrank.ch; spf=none smtp.mailfrom=davidfrank.ch; dkim=pass (2048-bit key) header.d=davidfrank-ch.20230601.gappssmtp.com header.i=@davidfrank-ch.20230601.gappssmtp.com header.b=B9vaSphN; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidfrank.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidfrank.ch
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5dd7b439e3so1289804276.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidfrank-ch.20230601.gappssmtp.com; s=20230601; t=1740084405; x=1740689205; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ki4BqDr2jfoSCfBXflnZeD/HvCxdHbHAAIJAh4w+1oM=;
        b=B9vaSphN4rKT6P8chejrc6Xs4h5Od6bX/gHzxSQOmdPzDX5q0fBkWnyGsq0zlhVXZM
         K/7J+htVukqpm03mcKdinf2XhfCJcWlYNettbbYAdZCSfAVJIo/d8sszf2SWpIEcZTu1
         ag11yVeU6fw++kmsbpzFj8DDxMx3HLM+dB/BILX8NVqktMyGxFrxMOvenL55kJdH27gB
         WKxaKxqdfKRlOsa3hBeF9g05g/NRVL1/KmuqvfO4FoatNjhIxQTsuUrKTqEEymb4ctbh
         9z4qF+Z25jwgIpwRbJHM7a1MM6aORQafQ8Ohj+hlEoEPrqPqkUMN2EPOwCqRloXHY2rZ
         zhtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740084405; x=1740689205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ki4BqDr2jfoSCfBXflnZeD/HvCxdHbHAAIJAh4w+1oM=;
        b=XWI9levj3g0OrR8MrgGSVKU52gp5F37BDxZUcbnzE7AxiCVTkXC4ctjKylM6ccsjfr
         QOx5OWWP6SLH+NePp0GSK7i/K7J7dyBHhtv1zEe5AvUstcfCNX+lQLvyAMi+APevOlys
         2DlE/VKgVrS0i4NVifqC6c6Fpm0ERA2fSe+hahkb56PfdZKs8DfOOyLVgS9VnQir7T7e
         Oe0YV4DB6rDVRJsAINiFpK17sVQdEY/l8CTR/OlpqYs8NFVog1QdnNzhSySIj4MuNHM6
         +kpy+jLcMK9NJxZt88TeWpmdZf+GQNL43AsrNwKim1aezwd6Hu5ua8YavG8qym77tej6
         yQQw==
X-Forwarded-Encrypted: i=1; AJvYcCUUJeVpLM1cs+S3bBRJDfaXtIAn53Qw99mVb/+Boy0YsY8LqIbMFWLg+I7ggryER+fblrAQq+Mxs6V+npM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydr0kzjpG6kPZGHnDq+fcRciOf1uZJIMQF49XpZ6vJNHBx07yb
	wxaspwFUBPijMnTvnUIb+Y/5klYOl3yWrvJpHAnFsSwpCCotOA2aawnm+UL4bq2BdWY4o/wQu4I
	nsYIoCju5xLB1fuRaqlxWUafnZp6azNQZ49QYGrkQP23AL7fhTsE=
X-Gm-Gg: ASbGncvmHGX2VHFSb4AHNK2DS+9tE4a+U6gpCBtj0W4XHBSlul3u4QrQL+Esy0K04Zi
	MHrZbiz4Ki7gBtDkJs/hEkTe6tkRPWyYjXtm6CYJIO8GPf9+jpN/DvoXtKgNSiEWmJcmQix7cGi
	2VIIkWIDcAhl0zIOqo4ov5A7lvNA==
X-Google-Smtp-Source: AGHT+IECScJWDOKRG/qBJ8UnxAsKCIAGMu+3ZEUFJrWLypTdYZOvw75h5GMNXvgZAYJhA00gHT0/bZsGQCVHkXM8isA=
X-Received: by 2002:a05:6902:1ac3:b0:e5d:cdc6:7ad2 with SMTP id
 3f1490d57ef6-e5e8b067de6mr99742276.46.1740084405031; Thu, 20 Feb 2025
 12:46:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOR27cSr9yxodkctfp-Yjybh1NsKBeSkhdbZYeK7O5M87PfEYw@mail.gmail.com>
 <Z7cygtpjGDJadgg0@casper.infradead.org>
In-Reply-To: <Z7cygtpjGDJadgg0@casper.infradead.org>
From: David Frank <david@davidfrank.ch>
Date: Thu, 20 Feb 2025 21:46:08 +0100
X-Gm-Features: AWEUYZlkfgrMYlKjcUpCPWBRs8CxAmJiDWQaTfFwzPjscJTOpGasU7i9OgJWXII
Message-ID: <CAOR27cQ8oHmA8fWnmB7Wk5pTL4TRjMPzRuqT=uA1cVROYZH7UA@mail.gmail.com>
Subject: Re: Efficient mapping of sparse file holes to zero-pages
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you, Matthew, for your reply.

What do you think about the complexity of this task? I'd be interested
in taking a look but I don't have kernel development experience so I
would need guidance.

On Thu, 20 Feb 2025 at 14:47, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Feb 20, 2025 at 01:48:18PM +0100, David Frank wrote:
> > I'd like to efficiently mmap a large sparse file (ext4), 95% of which
> > is holes. I was unsatisfied with the performance and after profiling,
> > I found that most of the time is spent in filemap_add_folio and
> > filemap_alloc_folio - much more than in my algorithm:
> >
> >  - 97.87% filemap_fault
> >     - 97.57% do_sync_mmap_readahead
> >        - page_cache_ra_order
> >           - 97.28% page_cache_ra_unbounded
> >              - 40.80% filemap_add_folio
> >                 + 21.93% __filemap_add_folio
> >                 + 8.88% folio_add_lru
> >                 + 7.56% workingset_refault
> >              + 28.73% filemap_alloc_folio
> >              + 22.34% read_pages
> >              + 3.29% xa_load
>
> Yes, this is expected.
>
> The fundamental problem is that we don't have the sparseness information
> at the right point.  So the read request (or pagefault) comes in, the
> VFS allocates a page, puts it in the pagecache, then asks the filesystem
> to fill it.  The filesystem knows, so could theoretically tell the VFS
> "Oh, this is a hole", but by this point the "damage" is done -- the page
> has been allocated and added to the page cache.
>
> Of course, this is a soluble problem.  The VFS could ask the filesystem
> for its sparseness information (as you do in userspace), but unlike your
> particular usecase, the kernel must handle attackers who are trying to
> make it do the wrong thing as well as ill-timed writes.  So the VFS has
> to ensure it does not use stale data from the filesystem.
>
> This is a problem I'm somewhat interested in solving, but I'm a bit
> busy with folios right now.  And once that project is done, improving
> the page cache for reflinked files is next on my list, so I'm not likely
> to get to this problem for a few years.
>

