Return-Path: <linux-kernel+bounces-368831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6BD9A1557
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05C071F25AB3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59961D54D8;
	Wed, 16 Oct 2024 21:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QehjS7be"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495801D5143
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 21:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729115861; cv=none; b=WnDUxFeVfWGGk6ZIF+aTd0+H4VP5kcyuvfea8Cmon2nlQVNV/5VRok7ozzz6lg7kDy1KDgPlgMsKVFzHGv54TBrRLnqjrSI6LvLIkk1yfthH451Df0L8Qxix02evQ7GgGvJzCLYniUls0z+vAZX4lb9orsNaRrHwX6zSTeV7j1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729115861; c=relaxed/simple;
	bh=3joD48iRmd7t3mUBMO2Okg6RSsqTIj3O0U/LxmWFCD4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eoDWJSsqQEFBi33j1iDWV39M/7slja8+L+u/JvbGP152yfiRqnNbLSZB2L0L+Rw+yS4JZt81lQ1AUzkPIMVROoNxNfZeJbB2vdOSeDokpqeDK883Y6rWd3WXaLY+ZXi612t1NJtymGLziOEuxBKzRUFuHsfd9hNLxHUIqxV3qRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QehjS7be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E2AC4CEC5;
	Wed, 16 Oct 2024 21:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1729115860;
	bh=3joD48iRmd7t3mUBMO2Okg6RSsqTIj3O0U/LxmWFCD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QehjS7beWvmWvXAleXKwjdAR5rwA6dUqakkk2BlCoaIzIPwky1Rr/nWU4ffvgtYgC
	 ruFvWf6iKQx9NXk+RBr2TT+LRonjJ0h/VCv5NYHyDsNNuUL3PHYlFapN4zGdz7QZtO
	 XV0Ks3y/QV7XVB/hxLQII5EUzEQXyGvd4n44RzPY=
Date: Wed, 16 Oct 2024 14:57:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: John Hubbard <jhubbard@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org, Alistair Popple
 <apopple@nvidia.com>, Shigeru Yoshida <syoshida@redhat.com>, David
 Hildenbrand <david@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Minchan
 Kim <minchan@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: Re: [PATCH] mm/gup: stop leaking pinned pages in low memory
 conditions
Message-Id: <20241016145739.770543d44313967f611f3810@linux-foundation.org>
In-Reply-To: <20241016202242.456953-1-jhubbard@nvidia.com>
References: <20241016202242.456953-1-jhubbard@nvidia.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 13:22:42 -0700 John Hubbard <jhubbard@nvidia.com> wrote:

> If a driver tries to call any of the pin_user_pages*(FOLL_LONGTERM)
> family of functions, and requests "too many" pages, then the call will
> erroneously leave pages pinned. This is visible in user space as an
> actual memory leak.
> 
> Repro is trivial: just make enough pin_user_pages(FOLL_LONGTERM) calls
> to exhaust memory.
> 
> The root cause of the problem is this sequence, within
> __gup_longterm_locked():
> 
>     __get_user_pages_locked()
>     rc = check_and_migrate_movable_pages()
> 
> ...which gets retried in a loop. The loop error handling is incomplete,
> clearly due to a somewhat unusual and complicated tri-state error API.
> But anyway, if -ENOMEM, or in fact, any unexpected error is returned
> from check_and_migrate_movable_pages(), then __gup_longterm_locked()
> happily returns the error, while leaving the pages pinned.
> 
> In the failed case, which is an app that requests (via a device driver)
> 30720000000 bytes to be pinned, and then exits, I see this:
> 
>     $ grep foll /proc/vmstat
>         nr_foll_pin_acquired 7502048
>         nr_foll_pin_released 2048
> 
> And after applying this patch, it returns to balanced pins:
> 
>     $ grep foll /proc/vmstat
>         nr_foll_pin_acquired 7502048
>         nr_foll_pin_released 7502048
> 
> Fix this by unpinning the pages that __get_user_pages_locked() has
> pinned, in such error cases.

Thanks.

> Fixes: 24a95998e9ba ("mm/gup.c: simplify and fix check_and_migrate_movable_pages() return codes")

I'll add this to the -stable backport pile, although this seems a bit
marginal?

