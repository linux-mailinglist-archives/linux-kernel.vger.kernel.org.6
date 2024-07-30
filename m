Return-Path: <linux-kernel+bounces-268235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA9294220D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458081C22BFA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A1E18E04E;
	Tue, 30 Jul 2024 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d3gYzzS3"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CC41AA3EC
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 21:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722373950; cv=none; b=P0A4NsVtd1jQ7eSSNWnDMfX49AzvAtc7T8ShslVXAtumObGKPYs470tL6kB9QTVzJKAAyl+XhE0lc+wzrhWqjBAf8CgU4PWNSz3AS6bk/cdnnrAupS+4xtAToh0zKXfLKwVEVnR9eyjmQQ2S+bklNFQHZ3GpMYcogsL7XStfqN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722373950; c=relaxed/simple;
	bh=0iq5dG02O+Mm4nUh3q9yu6MxAA+I4Dbghy+1bJcXHf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoprVRODpHZXWUU/xg5JXCZgBwN3XX6WtMnK+wjUMVLozNZUHF/LGC2Hha3RMyU0ltgQ2P/0OerXv2XKmfdomf0VXVTAYqJuqx7r49hLfdyECLtUQdnmGrX5UUPUHNhOlfCNhK1ocs9zKfAn4gcFqe0/icos58ZppcoC3f6Uoh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d3gYzzS3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=i/xv7qDDdFW3y8s9XTfYkFRuj4f+KOOdE0ubUpYSK6g=; b=d3gYzzS3uuoXeUqgbnStlCrrGQ
	yRj3goSS6RLZB3BLDSxitF02lqw4s0wIlCyojlXvkZEti2ibguPc1De1wRm9GSwsgakXBnIPmuRcP
	L9/bIXYJaZGIpGfn0YG7q43AQxV7Utapmsz1nbZa1XLAdPL/fe9Gek75O3nLc+e++YUJU49XHJFgV
	82HBqBzK/b9esfTG1n5VQlRNeHfiSXQkc7zYmSO5RwW0cac8dNVck3XRDdwObmkWYl95edl1RwmVE
	kzFC+Czei4Q+HccF3S9AQcWZsNJp0+qzdV+j1X+625I3g+xra4pEa5uFGMovhmORGED2TS1mjKk5U
	Dx/8lVdA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYu8t-0000000FA1K-1wb6;
	Tue, 30 Jul 2024 21:12:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8F8703003EA; Tue, 30 Jul 2024 23:12:22 +0200 (CEST)
Date: Tue, 30 Jul 2024 23:12:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Anvin <hpa@zytor.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>
Subject: Re: Linux 6.11-rc1
Message-ID: <20240730211222.GW12673@noisy.programming.kicks-ass.net>
References: <CAHk-=wiyNokz0d3b=GRORij=mGvwoYHy=+bv6m2Hu_VqNdg66g@mail.gmail.com>
 <f8677c93-a76d-473c-8abc-8dc7b4403691@roeck-us.net>
 <b7ecddb7-4486-4b2d-9179-82250cf830e7@roeck-us.net>
 <CAHk-=wj2BYPvYQAQa-pyT3hERcd2pVw+rL5kw7Y=-8PA3JTDAg@mail.gmail.com>
 <20240730192237.GR33588@noisy.programming.kicks-ass.net>
 <231e7a2e-7e2e-4b82-b084-8943b2236de0@kernel.dk>
 <20240730193841.GS33588@noisy.programming.kicks-ass.net>
 <f395b9d1-9515-434b-8ea5-c3bcaac10fd1@roeck-us.net>
 <20240730200947.GT33588@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730200947.GT33588@noisy.programming.kicks-ass.net>

On Tue, Jul 30, 2024 at 10:09:47PM +0200, Peter Zijlstra wrote:

> Lets see if its something that wants to be bisected.

Complete failure.. something along the way must've changed a critical
CONFIG symbol.  The .config I ended up with at v6.11-rc1 did no longer
reproduce.

I'll try again tomorrow if nobody beats me to it.

