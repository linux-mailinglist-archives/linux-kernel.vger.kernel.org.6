Return-Path: <linux-kernel+bounces-358361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346A8997DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 08:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414A81C2201C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476A81A3BC0;
	Thu, 10 Oct 2024 06:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="adiiPF0h"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777D418BBB0
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 06:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543159; cv=none; b=F6jClHedm7au4KHB2dgdXgRmi/coa1CUwn4x6rfiXyjg4KDrKoKdv12Kra60P/r5bjNQBbxGbBxKg0RHaYvc9qy09WGLXfwMlDakBTIsW8fDl19gbdeIjXmodT+IiEw9TlnDFOvAE8tbARCAL3/s/c8P147eFof8r3l/ppDWulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543159; c=relaxed/simple;
	bh=/dfysMZNk7ihsP9KTPayANCP3wUJm/wYwVq7TUqQARc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rj5wkmIjVb5o7jjiCjKY7qkLUx6ZW8nuqmftNIc8EqEE464D1oYpS1SJuykAJV0AlaY5dg5o6DJa7kaYhTWtRiK071cAwUyZ8Ei85656BbSxcbjAS7D6FXmTn101qEAULWNZhb8XriOQpjSD89SJzINPVGJzTouhCcZB1iCl9GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=adiiPF0h; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=shNRtsMJTnOWIwlG2F9sLUFbdWZ3drtRFcNVsDgF8h0=; b=adiiPF0hQmdpmzaq2Lp/orjK8G
	6B0Yi7dhMbPzO9j4C/1OQaRkbEtwYjU7gTrltTS95k5IqmwTq2qimH3GvV7CRXA1FqPQRm56Ma2nk
	LFSiHQnJzNE1wu0c1gq37S/B+Ao0dspSEX5hVX+alJLO8Cnm0PyTAPrtu8Dc8J4zzeQFp0KvZ9umu
	ZVZHLezhzfRRHFQhqCjtHSeJLe280fznBlvDJEmsxbGELQIc1REqFTCtkni3cNz8keFdiRK1dNkAL
	30JcSS7SL18bfof1Eqw+uyB7JL386kGz0eTTMKptrL3M/JW3uSVxpwJj2dCpmxiK/f3fbEQd5Nt+7
	0/2kElZA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1syn2K-0000000Bk0o-1cgu;
	Thu, 10 Oct 2024 06:52:36 +0000
Date: Wed, 9 Oct 2024 23:52:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: bigeasy@linutronix.de, tglx@linutronix.de, mingo@kernel.org,
	linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de
Subject: Re: [PATCH 3/5] sched: Enable PREEMPT_DYNAMIC for PREEMPT_RT
Message-ID: <Zwd5tKFBj62Lwdxv@infradead.org>
References: <20241007074609.447006177@infradead.org>
 <20241007075055.441622332@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007075055.441622332@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Oct 07, 2024 at 09:46:12AM +0200, Peter Zijlstra wrote:
> In order to enable PREEMPT_DYNAMIC for PREEMPT_RT, remove PREEMPT_RT
> from the 'Preemption Model' choice. Strictly speaking PREEMPT_RT is
> not a change in how preemption works, but rather it makes a ton more
> code preemptible.
> 
> Notably, take away NONE and VOLATILE options for PREEMPT_RT, they make
> no sense (but are techincally possible).

Should we take away NONE entirely because it is kinda silly?

Just a bystander here, but the explosion of different preemption models
is a bit silly and not really helpful to users.


