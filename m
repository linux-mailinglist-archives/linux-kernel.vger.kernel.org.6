Return-Path: <linux-kernel+bounces-264843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B3493E91D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 21:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4232B1C20FDE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 19:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDBA6F2F7;
	Sun, 28 Jul 2024 19:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="zvDWUXZo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E4A957
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 19:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722196207; cv=none; b=UPTTfWGZS2Ab3xH/B2iNCqXXtVGY4r2iVrYRwJVGHCFqbdgUGzP/3XXBLL7W4Ez72Xw4EVNpG7PrdtgGr2Y4S3r7S9gN9T1ZAcXdRahLyyQOzaCha9v0s/F+3xJqZkyII+t5y5B/3nrIn5jzOqCyx1tSIvttcI/bANPFIc7HAhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722196207; c=relaxed/simple;
	bh=3zYYk2gZpRrTYvS8E7E1kX6+mmTOOnlrqkv4ofQ+hmY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a8H8sn+ndPdS4G8EE2C94HdpkJMYE1dHIvKUYe1f2Ls8K1KOxpOQ5vNMR1iXmLCU/J9Z2CkI72kz5M0Alb6TgstVNt2Wqn281HQUNffVUpBigZDNd7vo/FYgzyUyC0VED/Qm5z2YsVwYZFrWAhaf3yb9G+1uy0/SwKIk2jBz3II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=zvDWUXZo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F893C116B1;
	Sun, 28 Jul 2024 19:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1722196206;
	bh=3zYYk2gZpRrTYvS8E7E1kX6+mmTOOnlrqkv4ofQ+hmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=zvDWUXZo9JIljZUWqLj1FDg0RthuRBkQDLcGSeF+2b+tOBCclBdQ4vepOFB4hUGVp
	 pMUxkO//FpK+gZtK12U6VhsiIdBl23vM92k2aQHKtwf2a/MJ3+3hlksAZL5pMOF89j
	 14U90GfH/22azoE+tMpT72wU6DaWUjYWgEoeDSEw=
Date: Sun, 28 Jul 2024 12:50:05 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: fix deadlock in migrate_pages_batch() on
 large folios
Message-Id: <20240728125005.c1171fa2d1beb6c1fe867d48@linux-foundation.org>
In-Reply-To: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>
References: <20240728154913.4023977-1-hsiangkao@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 28 Jul 2024 23:49:13 +0800 Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Currently, migrate_pages_batch() can lock multiple locked folios
> with an arbitrary order.  Although folio_trylock() is used to avoid
> deadlock as commit 2ef7dbb26990 ("migrate_pages: try migrate in batch
> asynchronously firstly") mentioned, it seems try_split_folio() is
> still missing.

Am I correct in believing that folio_lock() doesn't have lockdep coverage?

> It was found by compaction stress test when I explicitly enable EROFS
> compressed files to use large folios, which case I cannot reproduce with
> the same workload if large folio support is off (current mainline).
> Typically, filesystem reads (with locked file-backed folios) could use
> another bdev/meta inode to load some other I/Os (e.g. inode extent
> metadata or caching compressed data), so the locking order will be:

Which kernels need fixing.  Do we expect that any code paths in 6.10 or
earlier are vulnerable to this?


