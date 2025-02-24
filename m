Return-Path: <linux-kernel+bounces-529144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA31A42067
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB2A01899503
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E950C23BD1A;
	Mon, 24 Feb 2025 13:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bcrf0uNN"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F0C221F12
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 13:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403252; cv=none; b=ZSALk8+wXQQXcoAgCda/0Tsz0f6V1F9Okcj2aYOOHhVkBOQAZDRIfWZSJHVTOs83Xdpidb6QWTxzX3N0YWhjjP/430CbXSEBWzbI0QnENZkp1FxweQPSPppnzm72nzKkkvqU2A0n/6R9CR1OipKV1KzKHS2OOa4X9f+iLNV2B5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403252; c=relaxed/simple;
	bh=O4a3yo3jwpOF6iyY4p/Gl1pFk0Y6yW3oUEoaVeH/4BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JmxgiefU3lc4kgmxwo0PgjNRckBkEsBZux9SCv79ld/kW7mTidom7Eaad7beGmhZkNjAF3mpY6HSy084DRiUxrc6nX70WdZjtVOjqj7g/tWPdyTyPHCnD+JhIQP6HKkLenLKIR84BryiI5oHk+Ha4p1auOvEjECRHOAqTDxhf2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bcrf0uNN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X0pH6Z2P2fVZkgNjHG+/lLCwvS0ZOQQ/DzV+UTigLZA=; b=bcrf0uNN9RsUzrOa++5j9qaWDi
	UxyN+oeB8KnluYMJgXlgT8eFeGb0Dk9DWBcOSuffpVQkDoOGlO4z7kYrrMqoY4a+4sge674oiAVG/
	o22GayXNqLf0fqOCwwL5PgJkc4toRzsw3u21HgiOeyvGHUpoJzpB3axqQlIaValB6+xwdduhbbdRD
	2ueL/lo25aDtVrTyFgbxi+B3ewTgjITvDIbZhSPWVBp2BVJ7ELDIDjfwHtfWFEmnI5xTPf7kBq8ze
	WTISYHrkgs39GIN4+tuMNw08EcD5s0GxsKv5hqJN+1hVstc4KzvLQm8eSmbxUVdkhc5jEqdkE8SRd
	0JCmUUcw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tmYO7-00000003Clv-46pP;
	Mon, 24 Feb 2025 13:20:48 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2EA33300164; Mon, 24 Feb 2025 14:20:47 +0100 (CET)
Date: Mon, 24 Feb 2025 14:20:47 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Subject: Re: [patch 06/11] posix-timers: Make
 signal_struct::next_posix_timer_id an atomic_t
Message-ID: <20250224132047.GA34233@noisy.programming.kicks-ass.net>
References: <20250224095736.145530367@linutronix.de>
 <20250224101343.344168498@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224101343.344168498@linutronix.de>

On Mon, Feb 24, 2025 at 11:15:32AM +0100, Thomas Gleixner wrote:

> +		unsigned int id = (atomic_inc_return(&sig->next_posix_timer_id) - 1) & INT_MAX;

How about:

	unsigned int id = atomic_fetch_inc(&sig->next_posix_timer_id) & INT_MAX;



