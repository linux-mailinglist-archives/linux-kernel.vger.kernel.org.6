Return-Path: <linux-kernel+bounces-218206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CA490BAC9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 21:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894651F2201C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 19:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193CD1990C9;
	Mon, 17 Jun 2024 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gUWcS4Qc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC92F4EB;
	Mon, 17 Jun 2024 19:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718652322; cv=none; b=a21UskY6h1UF5WGiW6pJy5gLdj6rzOVY2oMsdpA3naOcY7SxvoxbVk/Ee/gpVSQR1bBvyM5KEPzIbVSh15Xl0wxL8Ki8fNBO4pzY70OPu98WaQPXw8Cx9YcWgVQMpknYr3Z93CYuaLo0Ot8nE5F0lhrWCEr++3IwB7q/Sy7FplM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718652322; c=relaxed/simple;
	bh=sneyNZ3rIjja01nckCQOaxoYSOD6aQqqx/eb4T0DPCs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MfPoES4X518bK/nalQ6kZTl/NsIA3w2xz72vTowzIQWMbZU+mTOtVZEMfmz6bOqQRWMPgUvd8M9XD68txOI+L2RO0lUgZgpmPONKn1ibkBH0+2tUSGUFpEzZTWxjJZZTkvtufWE68R3mcJAHuZ0+nCXKmijjMUZjM+LyIOTjsRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gUWcS4Qc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB35C2BD10;
	Mon, 17 Jun 2024 19:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718652321;
	bh=sneyNZ3rIjja01nckCQOaxoYSOD6aQqqx/eb4T0DPCs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gUWcS4Qc23q1OZNn9em+My4IYLYm4ZNGyuCovY+L6JGUhKvnhWBEvEUi0bcdpciJV
	 RSC0d3zZFSoBNIrmeFWtT270HPdYIQnXx+ONeGteWMJj0tarZK4Z8h9Ak0F3wnjs4J
	 vHqUp9JtINePNnfYdii0jxEvJuWgDb2E2BqXi5YQ=
Date: Mon, 17 Jun 2024 12:25:20 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Zi Yan <zi.yan@sent.com>, Hugh Dickins <hughd@google.com>, "Huang, Ying"
 <ying.huang@intel.com>, linux-mm@kvack.org, oe-lkp@lists.linux.dev,
 lkp@intel.com, kernel test robot <oliver.sang@intel.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Yang Shi
 <shy828301@gmail.com>, David Hildenbrand <david@redhat.com>, Yin Fengwei
 <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/migrate: fix BUG_ON in migrate_misplaced_folio() and
 compact_zone()
Message-Id: <20240617122520.6b4ed2cfc6b09d6c739c6c8a@linux-foundation.org>
In-Reply-To: <20240617143926.1511227-1-zi.yan@sent.com>
References: <20240617143926.1511227-1-zi.yan@sent.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 10:39:25 -0400 Zi Yan <zi.yan@sent.com> wrote:

> From: Zi Yan <ziy@nvidia.com>
> 
> Both Hugh Dickins and kernel test bot hit an issue that migrate_pages()
> reports success but still leaves unmigrated pages on from list. It
> triggers BUG_ON in migrate_misplaced_folio() and compact_zone().
> 
> Our convention is that if migrate_pages() reports complete success (0),
> then the migratepages list will be empty; but if it reports an error or
> some pages remaining, then its caller must putback_movable_pages().
> 
> There's a new case in which migrate_pages() has been reporting complete
> success, but returning with pages left on the migratepages list: when
> migrate_pages_batch() successfully split a folio on the deferred list,
> but then the "Failure isn't counted" call does not dispose of them all.
> 
> Since that block is expecting the large folio to have been counted as 1
> failure already, and since the return code is later adjusted to success
> whenever the returned list is found empty, the simple way to fix this
> safely is to count splitting the deferred folio as "a failure".
> 
> This patch is based on Hugh's fix and suggestions from Huang, Ying.
> 

I have just sent Hugh's version in to Linus.  So if/when that is
merged, please send along any needed updates.


