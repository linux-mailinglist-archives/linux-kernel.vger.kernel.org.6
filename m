Return-Path: <linux-kernel+bounces-199173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95FF98D836B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C76001C25084
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B187212CD91;
	Mon,  3 Jun 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R5fGs8Ih"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6198382D6C
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717419838; cv=none; b=ioIdEe8l6O2T84m8WPdNAkATVZodzelnNprl4cBsUWE7d2j70OaESOgIXmQwsh+10J3Ic0e2LBMhX3FiOzXInMFtgbq8azPPA4AANlFcHuIQex5V8NtO3IBkROcyojrc7O+ViTw3/s4fk3ejD1llxAi5sZajCNPivnI6hVXcDDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717419838; c=relaxed/simple;
	bh=Gp2MfHdVZEu1en50q5BUnNu2k4eXlpARHLMKRHuQscM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LggGusv+1hfurksrvar6BDWl6ZGxqnFS23MNp8wP3FHhclPcRLAy6p7QL+Z8IiCIALY8cao5aCI2bnE9BzTmCeWOCj3nI7ZwL59FSx/0jsLUMq2N0zllsRkV608kv6EZL5hqlH2tXXbT20gi5t0nkL7SlwP3+fcFlzxZdWAbQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R5fGs8Ih; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UMPvBERLQPjIU5/i9ydiF+mg7YA0ahjPIQIB0SOC99k=; b=R5fGs8IhNsEY+p5V5XpfsaHuM+
	sWR/GRjtMKk0iSHLv0te9NyIn9Vm9vpLgmPD8Q3v1Uiro5kPWEryZwooKyDLtd/O6NkHHUS41mocj
	LWLPc1NfOHYOzJ40COgCBAsXO26ByP2feypflB7maa3U5VPRpLy7OMP9TbQiQBwKS8DUam72Nehx3
	688tOeZJwBMzOqoPBGma+W2B/m1elkUz0sCLHFacP9m0jzCLR7Wkx8sC0fkDlia+WDkEn+sX+u19f
	C+I59OW+ZtB9UO50/xU9wOm4p1Qmrp8Gu9U7lYMgjasKjaKQ/d3wdsl1N8CtgukzqRfAn8xRtTwRV
	RdiXpwNg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE7Lr-0000000E7RL-3aOQ;
	Mon, 03 Jun 2024 13:03:51 +0000
Date: Mon, 3 Jun 2024 14:03:51 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: akpm@linux-foundation.org, rppt@kernel.org, hannes@cmpxchg.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: pass the pfn to set_pageblock_migratetype
Message-ID: <Zl2_N9wHOh9ACQpt@casper.infradead.org>
References: <20240603124100.2834-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603124100.2834-1-yajun.deng@linux.dev>

On Mon, Jun 03, 2024 at 08:41:00PM +0800, Yajun Deng wrote:
> It is necessary to calculate the pfn in the set_pageblock_migratetype(),
> but most of the callers already have the pfn.
> 
> To reduce the calculation, pass the pfn to set_pageblock_migratetype().

It's not exactly a hard computation though.  Have you done any
measurements that show this patch is an improvement?

