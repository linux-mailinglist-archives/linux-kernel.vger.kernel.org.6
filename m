Return-Path: <linux-kernel+bounces-367954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F939A08C1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1C1288030
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB4D207A0E;
	Wed, 16 Oct 2024 11:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t7wL5x4f"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016672076CB
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 11:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079490; cv=none; b=G2i/CRtPZswPQxAkzMiZcs68tvzbXRH9lpgk4BhvotKYXfces/ALhu80lh6S2zviAikS8lStIBLqh0Jz5B2i6RzrrChHMDSnzhk81tK/MpVw+vWy8zwyuSQWBSf0wHX31QPEx0UwnOGggmIhuS8/eIuSiJhl5XWAjRM3wYTT43U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079490; c=relaxed/simple;
	bh=3PJYCI+8zdcdjWZWfS5+yLHtznsYKyDpRE5ez8d7z8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUx1VVwHSAC/XE0NScKS4XRvAenaIZx2y+Pclm8cqKi5Q9Xci2Edx2wxm4vkjSZ4ntpBpynd34SM/o4SzObL0obZkO+0IP+3Pht0b7NQgW+6YTgaK3G+pJyZu4XlvW/uuGuNue55fx0nlNQM9rctSZkD1eo2PaLrnafhdMXR6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t7wL5x4f; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vJbHF611f+rsleNizBfRWTR12kTRBzvZGfsubIoLkAY=; b=t7wL5x4fQ3hNY3NbXVHQ50e2YN
	x47SD4V+aHq4421lrMso04v5luHUCkNnWR+Nq+Um8f6LzkS8An294bVmNQMOgPQCI2FqNNUZm+X8P
	4pNzvWfnNMVy6DDDURikUF13101C5GxigM6wcCiflyBT4RIKXQ82CcU3NuqSF3PEtGYSNURCKVLmw
	J2mPY07UYXaq4WF11x8E7GFEWFo8M2zPKahkyzGzJ3osATL7ASYHVyTOva99TU1d358f7X4DIGuf9
	S4l+3LcxlXGiXejkqH+27mpeSGDd53WkFFQI8Jo966Qg+IHx/IFyyntJqkMJWx7O0IiDy0vjDO06n
	sOd1pelw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t12Ym-00000007pBy-0A88;
	Wed, 16 Oct 2024 11:51:24 +0000
Date: Wed, 16 Oct 2024 12:51:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: lizhe.67@bytedance.com, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC 1/2] rwsem: introduce upgrade_read interface
Message-ID: <Zw-ou7gsqTMGQDdl@casper.infradead.org>
References: <20241016043600.35139-1-lizhe.67@bytedance.com>
 <20241016043600.35139-2-lizhe.67@bytedance.com>
 <Zw9Hk_9OO-Aqsshc@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zw9Hk_9OO-Aqsshc@infradead.org>

On Tue, Oct 15, 2024 at 09:56:51PM -0700, Christoph Hellwig wrote:
> On Wed, Oct 16, 2024 at 12:35:59PM +0800, lizhe.67@bytedance.com wrote:
> > From: Li Zhe <lizhe.67@bytedance.com>
> > 
> > Introduce a new rwsem interface upgrade_read(). We can call it
> 
> It's obviously a try_upgrade_read, right?

Well, that's confusing.  "try" usually means "don't sleep", and this
sleeps.  Maybe it shouldn't sleep; ie we make this fail if there's any
other reader?  It'll succeed less often, but it'll be easier to
understand.


