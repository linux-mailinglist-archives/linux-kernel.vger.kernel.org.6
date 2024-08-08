Return-Path: <linux-kernel+bounces-280217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D1394C74A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91AE8B242F6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 23:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0977315F3E6;
	Thu,  8 Aug 2024 23:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dziK+806"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4A31474A5
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723159213; cv=none; b=pCIKFwHWl6Q8lYIDZmJ8lgLuR0r4esURdW7xKkYHdezBUm0yTFb0SygXKgMS05elHTRPrkefw77jkHHdIkDLRqqe+fxNBBvhjt5xN+FG5x+BHLKSlmnYjfvOg02mSRxYHgqC/mpvwnxy+KnXg/a3ggXE+GBb+ZxtCGN62vOPvao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723159213; c=relaxed/simple;
	bh=JXZL7hvQM1c1f0dUDictMu8HCZFmtNQAm6LBqk1/PUA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XQOJjGPMBMW5uP5GCcBFJoV7Sy+Png5s3oq17Bz5S6sBx/XtjqeXPjKri2SIY1kRm/nHsola9C9eezeCapME0ishKap4GRyKN7/CwLcZBqPehOI4bfr2551jct19KKwOApQ2BK/MGJkB0Df9UUJGNL7XZLQ3kiB1Ex4RAqWnZT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dziK+806; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F13DC32782;
	Thu,  8 Aug 2024 23:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723159212;
	bh=JXZL7hvQM1c1f0dUDictMu8HCZFmtNQAm6LBqk1/PUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dziK+806lLO8VOlSVfWwwNC7nX16u6KwSZcl0IA6qeAtr5PUBrbfTqIMgqv2XRIxm
	 AeuhbSVI+w9EmPd6anomHOTrsK3G2n+9JypqKfwnHtlo0g0GbaDVOgxkMUd9kZfdc1
	 StMbQ3RbN1ENgmKKY0C7s4BNV0izatm5eb5CYB+4=
Date: Thu, 8 Aug 2024 16:20:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com,
 ying.huang@intel.com, nphamcs@gmail.com, nehagholkar@meta.com,
 abhishekd@meta.com
Subject: Re: [PATCH 0/3] mm,TPP: Enable promotion of unmapped pagecache
Message-Id: <20240808162011.0492099266ac47e7b84eacd0@linux-foundation.org>
In-Reply-To: <20240803094715.23900-1-gourry@gourry.net>
References: <20240803094715.23900-1-gourry@gourry.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Aug 2024 05:47:12 -0400 Gregory Price <gourry@gourry.net> wrote:

> Unmapped pagecache pages can be demoted to low-tier memory, but 
> they can only be promoted if a process maps the pages into the
> memory space (so that NUMA hint faults can be caught).  This can
> cause significant performance degradation as the pagecache ages
> and unmapped, cached files are accessed.

It would be helpful to share some testing results so the magnitude of
this degradation can be understood.

What is the potential downside to this change?  The local node now gets
stuffed full of pagecache and other things get evicted?

> This patch series enables the pagecache to request a promotion of
> a folio when it is accessed via the pagecache.
> 
> We add a new `numa_hint_page_cache` counter in vmstat to capture
> information on when these migrations occur.

