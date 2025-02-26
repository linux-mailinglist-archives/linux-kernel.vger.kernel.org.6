Return-Path: <linux-kernel+bounces-533003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 382F9A454B5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 05:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8703A8BF2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 04:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D894518FDDC;
	Wed, 26 Feb 2025 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="Ocj0OMAJ"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FDC1632F2
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 04:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740545858; cv=none; b=Gd0Z2KCLBnIGi/hsOX6HDaEUyRQmpeYu/lYW9iyBGF+RcOFnw1fNebzomJ/uWGBa09kMgMKW6DLwO4WGR65pjZXJnKqr8UFetgmRf7WKjqRFVAUa8OzS5oDe69rYTtmmIpfldvKC2TLQbkdlsMlE9VemgNzBgAWBax2dHi+OimU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740545858; c=relaxed/simple;
	bh=xhqbPG4+GMSn8o791ws1Rw0k2EnLcyKrODLOwXQtM8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iRXCK9vMleRVT4hB/HpMRVoosk9+YcVqVXuxSp0gVwDghv7YCr37Q4h/EZk44d5C1QdCu0ncXS0JFQR2o8hwhcoPlmBerR7lErHlF8OxZvsYl+uzxjeZ03LM3o4QHIZ/V25qU9XIjaOHAozLLG7Yob+ykow/qKTnEuLmvKMOPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=Ocj0OMAJ; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7be8f281714so822253385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1740545853; x=1741150653; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx2vdR43aGu8aw7BzqWEnWG1tJkA9ALfWFU1ddi5U7c=;
        b=Ocj0OMAJaodJ9uoQNJAVJYj2Pma6g1T2pARTEF3oMUJeSBv3Pkrr9JHCBVk0p581O6
         4CdUMPudFIsBfR5qugnHgTTOyjK61Qj5gXsAK7b/EsM8HmVaCVKhhxR1fuvsqJx5KNUB
         nJrrKPbMpkwqo9U3czBoICUW8h4aw8SnnjzlVH5JoBYmEN2FQjoblenbR6v1LomfT1Jb
         gWnifH9S1Weyduant1U5nRt4WCEgE5He4nvW2A7h83TZsdIv0cXxoo/WA3GQ14TI/i4z
         9wkV/Lcimh04DGE208J8pR78FReIiiHcwNkUkBiQDok5UPIp5v+NA/nemIU9l2DULq0s
         /bgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740545853; x=1741150653;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rx2vdR43aGu8aw7BzqWEnWG1tJkA9ALfWFU1ddi5U7c=;
        b=hc0eoqQ7CNoOXDq3k3hrNfjH6GMb3Fixfz1sWO41iwa10DySlR7V4HfTB0VmStDjhN
         1wfQ/8MYcnuPrxSyJe114t/9br7eDsGaYRmxrCxnNjOFl+lGpqUGE7iddl35a0FjoBja
         S7bO7vDbtlIdYf7MWRFSFoB1MMi/Aa2ejhfCTYBQ0XL8mMxGHU2yKm87hqXNOvhBJX6e
         ypOY74g8NKEVGF3gaW2H3q/4AQPYsJOYOVZsaWOOqoyHovvJedLENy/HRcMqRmQhKhj0
         bBgVZpFKjKLDVVY7ZGyNORnlLDVAYRC/V6PhcLgbk8U9F0ehRHtCL6u5TRWm0Xvjmw2P
         0EiA==
X-Forwarded-Encrypted: i=1; AJvYcCW5405+ZDYCQyNu39uaiXikpIwAxrnG/mHItX1nkFHiJf4ZvRBs2dOt7y53A/KZxsRjNYHp46UdPB3phYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxViG+SkQmuFbx/E2rzZUDgxE+a0B4gjHrJ2/BQr0q4PPP31LFk
	m+9uki/x4utEsE6a2D+PoFKJMuwzOVUmYz3IWVtkEJ8JksvYwaN81hwblOdwIA4=
X-Gm-Gg: ASbGncuxqrRyjB0yoItCjbCCc32vNqnAy0zbmlQ6K2gXhNw/bVBBl+iwN2DDyCVls1+
	uzmu2gIhwLxi85LHhq+iYRaPKvtYtgUHL5QOokFHjDUmk67AGv+ovjtv+GyeNp+RKOf9B+MBvYg
	5nux2I9JREB17mG7Sj/a5Q9eSJGqSLKBJge0HmH/k+XClcYefD5E19D8iVVIaNQFtalHFZD8L+1
	OcHAryuwoxPForNayxtRneRhbToeXkkzlD+8ki+gTTjIihJy9TLGzO4BncQxd1hoZROG92OOQdo
	CI027uI/fr91M5rubEKWRVKz
X-Google-Smtp-Source: AGHT+IHXpQr2tIK8axL1NoO+YvHxXBFNOZWB+wrlACns9MHvBxqxlaVoPTBvxRIK5eVJNczA7wRl1A==
X-Received: by 2002:a05:620a:1916:b0:7c0:c0f5:29ab with SMTP id af79cd13be357-7c23c049b02mr942050085a.55.1740545853621;
        Tue, 25 Feb 2025 20:57:33 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c23c298f08sm200157185a.5.2025.02.25.20.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 20:57:32 -0800 (PST)
Date: Tue, 25 Feb 2025 23:57:27 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
	chengming.zhou@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: do not crash the kernel on decompression failure
Message-ID: <20250226045727.GB1775487@cmpxchg.org>
References: <20250225213200.729056-1-nphamcs@gmail.com>
 <Z76Go1VGw272joly@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z76Go1VGw272joly@google.com>

On Wed, Feb 26, 2025 at 03:12:35AM +0000, Yosry Ahmed wrote:
> On Tue, Feb 25, 2025 at 01:32:00PM -0800, Nhat Pham wrote:
> > Currently, we crash the kernel when a decompression failure occurs in
> > zswap (either because of memory corruption, or a bug in the compression
> > algorithm). This is overkill. We should only SIGBUS the unfortunate
> > process asking for the zswap entry on zswap load, and skip the corrupted
> > entry in zswap writeback.
> 
> Some relevant observations/questions, but not really actionable for this
> patch, perhaps some future work, or more likely some incoherent
> illogical thoughts :
> 
> (1) It seems like not making the folio uptodate will cause shmem faults
> to mark the swap entry as hwpoisoned, but I don't see similar handling
> for do_swap_page(). So it seems like even if we SIGBUS the process,
> other processes mapping the same page could follow in the same
> footsteps.

It's analogous to what __end_swap_bio_read() does for block backends,
so it's hitchhiking on the standard swap protocol for read failures.

The page sticks around if there are other users. It can get reclaimed,
but since it's not marked dirty, it won't get overwritten. Another
access will either find it in the swapcache and die on !uptodate; if
it was reclaimed, it will attempt another decompression. If all
references have been killed, zswap_invalidate() will finally drop it.

Swapoff actually poisons the page table as well (unuse_pte).

> (2) A hwpoisoned swap entry results in VM_FAULT_SIGBUS in some cases
> (e.g. shmem_fault() -> shmem_get_folio_gfp() -> shmem_swapin_folio()),
> even though we have VM_FAULT_HWPOISON. This patch falls under this
> bucket, but unfortunately we cannot tell for sure if it's a hwpoision or
> a decompression bug.

Are you sure? Actual memory failure should replace the ptes of a
mapped shmem page with TTU_HWPOISON, which turns them into special
swap entries that trigger VM_FAULT_HWPOISON in do_swap_page().

Anon swap distinguishes as long as the swapfile is there. Swapoff
installs poison markers, which are then handled the same in future
faults (VM_FAULT_HWPOISON):

/*
 * "Poisoned" here is meant in the very general sense of "future accesses are
 * invalid", instead of referring very specifically to hardware memory errors.
 * This marker is meant to represent any of various different causes of this.
 *
 * Note that, when encountered by the faulting logic, PTEs with this marker will
 * result in VM_FAULT_HWPOISON and thus regardless trigger hardware memory error
 * logic.
 */
#define  PTE_MARKER_POISONED                    BIT(1)

