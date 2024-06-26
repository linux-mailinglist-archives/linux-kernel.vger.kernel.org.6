Return-Path: <linux-kernel+bounces-231526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B03B919984
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C8E2862FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A143C193072;
	Wed, 26 Jun 2024 20:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R1qoofyc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5677193060
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719435537; cv=none; b=pPAlXcmov+Ln+zzGzDy51MiKQl0Y7VR3Xe1CvF6MevncOVSSZLp7JXRuS4xuICQ4/UMOZaSYh5mgxg+8zfDqdvNAQr4qBgqGQQgHKD463fDmTzfC86gwJsy8LRftsaA0Kxx3bxgi9rn/q+ZIxbz8SlwKqa9e0kYL0+K7UMCVhNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719435537; c=relaxed/simple;
	bh=WtbKjk3R7z4e5JwmA06Vt+cPpUkYMZRE9XM6J8l6qcI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=P9RmIg+JiABukqks3AwuuKD4xOwbqZapHAYNtPXEdV/TqwNgx9qVfAgtnLV685Xh+awk267j8o64SQfONun1mOtYa5tB2+rxutzMMFOtgnZXHWvKktsX5zdhp1IndnCoJzbbRopfZh6MBk2rXuIhFdT4poPmBNaW39VpDGVUJaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R1qoofyc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E59EC116B1;
	Wed, 26 Jun 2024 20:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1719435536;
	bh=WtbKjk3R7z4e5JwmA06Vt+cPpUkYMZRE9XM6J8l6qcI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R1qoofycZoOjfkalACSkfu0mINYE8YVRnqCp58EYQJLskJZPSB0B3PfcmsNFH+huM
	 xsZFwOMdJB4egAmZXQC/sQS41d/9KtBIjy//phRlqNGxmwUiCLQlhEscWSdDLZr8qY
	 uvkD1MGA0taqDu+0kHZ85gqAB7ejNYuMo6iA5Tlo=
Date: Wed, 26 Jun 2024 13:58:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>, Vlastimil
 Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, Matthew
 Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
 "Paul E . McKenney" <paulmck@kernel.org>, Bert Karwatzki
 <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
 linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 00/15] Avoid MAP_FIXED gap exposure
Message-Id: <20240626135855.a4b64612a9104ff163e30bd7@linux-foundation.org>
In-Reply-To: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
References: <20240625191145.3382793-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 15:11:30 -0400 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> It is now possible to walk the vma tree using the rcu read locks and is
> beneficial to do so to reduce lock contention.  Doing so while a
> MAP_FIXED mapping is executing means that a reader may see a gap in the
> vma tree that should never logically exist - and does not when using the
> mmap lock in read mode.  The temporal gap exists because mmap_region()
> calls munmap() prior to installing the new mapping.

What are the consequences when this race hits?  IOW, why do we need to
change anything?

