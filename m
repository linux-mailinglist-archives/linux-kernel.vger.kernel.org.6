Return-Path: <linux-kernel+bounces-268992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 708F1942BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24130283244
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5525C1A8C0F;
	Wed, 31 Jul 2024 10:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RcdHX7kV"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7077161311
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422019; cv=none; b=lTcb0ejSod4VmqrVbMIH9O2amMNnZOywHjx8MYUTDrzDf5Bg43a0//fCbDBbylWV1Anr9EUmTkkwvTCqun3IC+gynqSzdeH7tPffx+v8JQtaqo1ZcxM2/aEJ7wCnXX4F4xcmow8bgB4wus1tCauwDaAULKIQNNNbpHfDJ2JZLO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422019; c=relaxed/simple;
	bh=99VymIsOD12hH9kjWKSrInnoYJo3qd2LVwdE12gwp9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAuDH+lc4TbyLATy5lEdrCB5ATnzlLuldw0il1zNfkiHqZFjd5kF1B9pLSdQOtLYNXl6fcWYz2mRmelkCCO1P80Ay4edUQniuHNf6vEsERtg6aQTAlwPUXf5ZtADR5yWnyfn2kOPg4Or95+INMFUpskuBlU4/zafR8DWzsqwxT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RcdHX7kV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ny25EBy/rKrBs+Y+T9v9eAxFn5pKHTTrpsG8unnB2og=; b=RcdHX7kVomSICF9SGygrx7i20K
	U/vLz+5pYblGpTQCdWZubsyguNIwgAHdEbtmIIJ++HsSBx9OsxvG66Y+iCXswwVsyOwDonPiJvcwH
	SCv4ShzfNIGpG/ZVuJCrfeOgl/8oC7SgQZxTgNC/TAItT0PGVQGoXWyahrPTWfNYDCy7LdVjKQMqI
	NntDiUE2JizSkIBmup8v2C0WB85w4jAVjzk5HC6C5oYqd0CwIyPD+anXwEZm88iNMe/ssyiItrlTr
	Yt4mtRyE1r2VUH0PA4yiXHnu0fGEPrYMuKxFAWWyo8rOemz9Nl+n68R6A99chGullMAAQhq2Gvuvp
	Rme1eXwA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sZ6eE-00000005C7P-01Oi;
	Wed, 31 Jul 2024 10:33:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E0BE8300820; Wed, 31 Jul 2024 12:33:32 +0200 (CEST)
Date: Wed, 31 Jul 2024 12:33:32 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Andy Lutomirski <luto@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240731103332.GX33588@noisy.programming.kicks-ass.net>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>

On Tue, Jul 30, 2024 at 11:53:31AM -0700, Linus Torvalds wrote:

> Definitely something wrong with the page tables. But where that
> wrongness comes from, I have no idea.

[   10.231081] CR0: 80050033 CR2: ffa02ffc CR3: 02bc6000 CR4: 000006f0

See CR3 being a user address.... but yeah, million dollar question is
how the fuck did that happen?

