Return-Path: <linux-kernel+bounces-510962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7710A32424
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 12:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675F83A5F35
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B7820A5DE;
	Wed, 12 Feb 2025 11:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R/UgK33K"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD3209F5D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358004; cv=none; b=roQRJn8Qq+X6WymIKjlO8qLlE2eNgpzMf95fv6guguFky0vN0T+DZM4sVRDQlzo0zZok9beO/53Ci77OitEBAyDASODMogqMpvGYigtoW8EhXzmQJEi7QPo/IHRQpOtOuufkOAoa7Q45QiV/+f5u8dML+Mk9kamfsjIlxZK6MOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358004; c=relaxed/simple;
	bh=QxEyctiD+jx1ThZEhRm2KYh8bXdW+7H8Sil5Jz9kbog=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwTpLv5f4eiVTM0PTo1aH9jpTlTiaIQZuU31lnvC8jekELqXJdKsNTAtG+A3qMBxy5OdCkZKOodt7JwVBKmgbZQ1QNm5JiToTLfV/Z5fxXFbY5DnvRNyOIUWL8I4Tm3VCB9Dp1OJDSXFBP9k+U4BuQOk343casyPJgIZQ+8JhNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R/UgK33K; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QxEyctiD+jx1ThZEhRm2KYh8bXdW+7H8Sil5Jz9kbog=; b=R/UgK33K5Zihhun2dy1pRJQ7Vt
	RmhmlwVl0UXzulM2BYrRhZstuzTTkxWUMSgUc99MX0HolERRxw5Cv/7SPmFyzbt6IkfkcSTKaONu3
	pqx3OjULsH2HskAQ+wPjgnFjv0he3mL2oj6HLpESvne4K/RRD8KOxPL+pDcvgzlSASIqyHdcUJXlT
	uYMCJFpHxO9rg58OTczStH+kvE1nYURufei3ecfJzW9GrC/N+OXkDdj6voUucz05APvP4QqD9aLun
	4X7Kotq+ZfghXlEtco9qeQR+0rDUqya8ns0aykP5io8GYVqA9UK7hAWkq27661obiwNyeyA5wzr8g
	KsMh8VDw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tiAT4-00000004RTZ-3FdK;
	Wed, 12 Feb 2025 10:59:46 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E7FF43003E1; Wed, 12 Feb 2025 11:59:45 +0100 (CET)
Date: Wed, 12 Feb 2025 11:59:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Brendan Jackman <jackmanb@google.com>
Cc: Rik van Riel <riel@surriel.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
	linux-mm@kvack.org, akpm@linux-foundation.org, jannh@google.com,
	mhklinux@outlook.com, andrew.cooper3@citrix.com
Subject: Re: [PATCH v10 00/12] AMD broadcast TLB invalidation
Message-ID: <20250212105945.GG19118@noisy.programming.kicks-ass.net>
References: <20250211210823.242681-1-riel@surriel.com>
 <20250212102349.GE19118@noisy.programming.kicks-ass.net>
 <CA+i-1C0Sbgkyfan=srXL8dRrqaLoT1g1F5tZesC1rrh6v7L68w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+i-1C0Sbgkyfan=srXL8dRrqaLoT1g1F5tZesC1rrh6v7L68w@mail.gmail.com>

On Wed, Feb 12, 2025 at 11:44:01AM +0100, Brendan Jackman wrote:
> They apply to 60675d4ca1ef0 ("Merge branch 'linus' into x86/mm, to
> pick up fixes").

Why some random commit? Shouldn't this be against a sensible branch or
something, like perhaps tip/x86/mm ?

