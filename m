Return-Path: <linux-kernel+bounces-186793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F6A8CC93F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 00:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B26671F221A2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 22:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53781494A8;
	Wed, 22 May 2024 22:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="kIbM1Rko"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044A07CF30
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 22:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716418603; cv=none; b=OJfm/h6PB45axOZsCCwYrOxCxq4agT1uGkNBjh1gDLojjmwxt85gt0l6OuD4UFBXolJ49to/9ghrO/I1MLiUrZFvlnzmm3McxuxV82i9EysgtvMD53Q4yUYqzkXQiEl708RuezwJJidkX5zHsNo8+k5OG0QrzZhaZ9crdXgO7tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716418603; c=relaxed/simple;
	bh=5AT5vl3T88JpLt0rz9YSRvOvlMXsZmaBQLa/LMKnRcQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gdgQP5PIH3Yjc4eyATSUUgLhGqdoYpHqTNhGSszKN1CFFbTWLy9QZUSgsgt5DDcIrEStROn2a2yIdXL2g09go2vrvOn8/UWwHFrKptPTc8GgUh1hH2MBhj147iXrhbl1IjSfyTfdPv4dB+UYxGqqCquVFemWvGucAv2kS1glo8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=kIbM1Rko; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0113EC2BBFC;
	Wed, 22 May 2024 22:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1716418602;
	bh=5AT5vl3T88JpLt0rz9YSRvOvlMXsZmaBQLa/LMKnRcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kIbM1RkovF/daLUCUG4Lj5ojXFRKBEbLrYsAdEO0AYnDNiQOPsIuooTetl8mDXbWy
	 DWUbNJyH4fhaF+XiZnVzeyEroIuUf3apLFR64UlpMNAHUUZpatLMc5RD11DIJM4xy9
	 st7Ex5hKhDVytxeZoakQYr7EkqEjFGoBAqp0PbEY=
Date: Wed, 22 May 2024 15:56:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Byungchul Park <byungchul@sk.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, ying.huang@intel.com, vernhao@tencent.com,
 mgorman@techsingularity.net, hughd@google.com, willy@infradead.org,
 david@redhat.com, peterz@infradead.org, luto@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, rjgolo@gmail.com
Subject: Re: [RESEND PATCH v10 00/12] LUF(Lazy Unmap Flush) reducing tlb
 numbers over 90%
Message-Id: <20240522155641.a726c5cd3b25aa23e861045d@linux-foundation.org>
In-Reply-To: <20240520021734.21527-1-byungchul@sk.com>
References: <20240520021734.21527-1-byungchul@sk.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 May 2024 11:17:22 +0900 Byungchul Park <byungchul@sk.com> wrote:

> While I'm working with a tiered memory system e.g. CXL memory, I have
> been facing migration overhead esp. tlb shootdown on promotion or
> demotion between different tiers.  Yeah..  most tlb shootdowns on
> migration through hinting fault can be avoided thanks to Huang Ying's
> work, commit 4d4b6d66db ("mm,unmap: avoid flushing tlb in batch if PTE
> is inaccessible").  See the following link for more information:
> 
> https://lore.kernel.org/lkml/20231115025755.GA29979@system.software.com/
> 
> However, it's only for migration through hinting fault.  I thought it'd
> be much better if we have a general mechanism to reduce all the tlb
> numbers that we can apply to any unmap code, that we normally believe
> tlb flush should be followed.
> 
> I'm suggesting a new mechanism, LUF(Lazy Unmap Flush), defers tlb flush
> until folios that have been unmapped and freed, eventually get allocated
> again.  It's safe for folios that had been mapped read-only and were
> unmapped, since the contents of the folios don't change while staying in
> pcp or buddy so we can still read the data through the stale tlb entries.

Version 10 and no reviewed-by's or acked-by's.  Reviewing the review
history isn't helped by the change in the naming of the patch series.

Seems that you're measuring a ~5% overall speedup in a realistic
workload?  That's nice.

I'll defer this for a week or so to see what reviewers have to say.  If
"nothing", please poke me and I guess I'll merge it up to see what
happens ;)


