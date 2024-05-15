Return-Path: <linux-kernel+bounces-179711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 058348C63D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F030B22CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5BB5A11F;
	Wed, 15 May 2024 09:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mDI7lWWg"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4646E57C9A
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765823; cv=none; b=WNN4kaHj/a0zj01Ddm/n9ascu+qCvacT7VG8qUFrNhzcNP3g88nFx1KS0DXj/VqqWWPW/zHFwqP2+N+/4/YpVgElKuG0bqREdriNPJ1SOTtdZfrJ+gNWgP6S98dOJ6/3u70yqv65hosUtAK5V0gux5DxNwAuHVZJ8AyZJZlt1e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765823; c=relaxed/simple;
	bh=FjaK1rsFpNKRwzTdBmvxmqBqC9fajMVEyREzJ2HJ1BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPvHOm2IMwd928HZGVWja7jRZbwYbZVJVfas3JR2TBu6JqWnYlEg/9TA1MIRi4oQ//uDTDDwa6wQtqeeqj+ZwJBsby4jsXnHaL9KWbMJglx1C/hxSoEnqacTAQfQY0sse1/evDFUxTzS2mIDBCLdK6AMJEIQip+Np0XWISYQdQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mDI7lWWg; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7aiqKEGQMkJPcMbAtoCRjnVTG9iUs0UrpmMn+emZwVM=; b=mDI7lWWgvfz/0A3fXpfl5R7kOX
	YsiMUysX8LtbdWbe3K4fp9Bu2Tn/wTirSsARZ0XFMc8/VEMN0Oe1nGjTsfxNxiFye8o1tBgj4BLa6
	0g8hxJAnSHF93FckM78QcfFxPZV91+rK9hUPUi2UhRACnzBeYAIP84yLjeqNT97HPKy1IPY28oa7X
	XC+ThcX5iXDyG1k0geWFsBjkeGipOeMQmkCKuaevMVjNjQZ/E5kE8YU1EPeAEaV99tkXxl6nXCtuq
	xAaBEMtBIPice9Rn0cELMg9SgGAZ0calYhbdcbTwmFaNQV5f7uOzJBbM5Cn2wVOs644as9x7Yc+JS
	yD4Gd5Vg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7B45-0000000ABKu-2w8o;
	Wed, 15 May 2024 09:36:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 54E7330068B; Wed, 15 May 2024 11:36:49 +0200 (CEST)
Date: Wed, 15 May 2024 11:36:49 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Luis Machado <luis.machado@arm.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
	wuyun.abel@bytedance.com, tglx@linutronix.de, efault@gmx.de,
	nd <nd@arm.com>, John Stultz <jstultz@google.com>,
	Hongyan.Xia2@arm.com
Subject: Re: [RFC][PATCH 08/10] sched/fair: Implement delayed dequeue
Message-ID: <20240515093649.GF40213@noisy.programming.kicks-ass.net>
References: <20240405102754.435410987@infradead.org>
 <20240405110010.631664251@infradead.org>
 <3888d7c8-660e-479c-8c10-8295204e5f36@arm.com>
 <1461277e-af68-41e7-947c-9178b55810b1@arm.com>
 <20240425104220.GE21980@noisy.programming.kicks-ass.net>
 <20240425114949.GH12673@noisy.programming.kicks-ass.net>
 <20240426093241.GI12673@noisy.programming.kicks-ass.net>
 <c6152855-ef92-4c24-a3f5-64d4256b6789@arm.com>
 <2fba04b0-e55e-41f4-8b7a-723734fe1ad2@arm.com>
 <219b8b49-3767-4010-aa68-9e1cf66c2ccb@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <219b8b49-3767-4010-aa68-9e1cf66c2ccb@arm.com>

On Fri, May 10, 2024 at 03:49:46PM +0100, Luis Machado wrote:
> Just a quick update on this. While investigating this behavior, I
> spotted very high loadavg values on an idle system. For instance:
> 
> load average: 4733.84, 4721.24, 4680.33
> 
> I wonder if someone else also spotted this.

Hadn't spotted it, but now that you mention it, I can definitely see it.

Let me go prod with something sharp. Thanks!

