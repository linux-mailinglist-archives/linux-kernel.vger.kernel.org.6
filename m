Return-Path: <linux-kernel+bounces-521789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D84A3C252
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B125D172C80
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2691F37D3;
	Wed, 19 Feb 2025 14:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kHTj58Ld"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2811F2C5F
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739975834; cv=none; b=D82r8qiqZugozgQHg1FQXrmxL76Nf1LbSIAhbH+mjuAmkaQB4tgnSGpzisG9YcIwnQzGbwsJ6ioXWXgPJv2rA37Z9gfo2abMBVv7tVLehTVHd9L+s7JmN/g5nJFI8ZtzRBFvSidoy193zD6D2g0BK6EqW9M3oMySJzyOHx0issU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739975834; c=relaxed/simple;
	bh=8gr11tDKjEVx/dKyeycbJMODIvozBHfOOIqW/kjMOj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4u6E+bUbV2EFKGm9NFcPDlWIq9JMylhBLD2PS57rdl7VN8IcITmG+RyjPLrTNVeRLrqS2mYAmGb1w1hQ4nAhOhz2fTNePRJcWPWrX7GvRjklVfmtXMZIDTXe+qw+lyfHvW2MY3yEqujSdXHGR6TiBsEFJL517N049BePd2WcOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kHTj58Ld; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zhjYUsrI6RutAqvLk3T5JloYrzlCo1ILfz3mgUREdnI=; b=kHTj58Ld3fSrlj+ewnPvTgPCfx
	vq0VscVSwxnnMZyydhy7kBMdD5g2sB26Rs4+r2+ygWkMNdMwfL4ZWtQra+qwBaDZzuJRCQKuQSIqi
	zoU8dMiCjLIV/iFwDnFkRi8DtJDO3z5TTJWA5eTKJE8xP63h3pBKxMjcanpHdHAE/xD7he+3hGEa9
	MpoicDNxECnUo5fJ86lEA8xTB/jyYCepZu6gb1e3S47fNyKyNca2kJbgd6B6FFgFz6/Sv5UL5OyMg
	Gd3uJArhTxbrFnoGzoP31zgdlEiny9hI3mBP6QqcDei7yddwMt3+3mRPHzKsAA80RQFEwkkX7O3PR
	RBNSk7MQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tklCD-00000006FNC-3Blx;
	Wed, 19 Feb 2025 14:37:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 89EEB300399; Wed, 19 Feb 2025 15:37:04 +0100 (CET)
Date: Wed, 19 Feb 2025 15:37:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: add unlikey branch hints to several system calls
Message-ID: <20250219143704.GF34567@noisy.programming.kicks-ass.net>
References: <20250219142423.45516-1-colin.i.king@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219142423.45516-1-colin.i.king@gmail.com>

On Wed, Feb 19, 2025 at 02:24:23PM +0000, Colin Ian King wrote:
> Adding an unlikely() hint on early error return paths improves the
> run-time performance of several sched related system calls.
> 
> Benchmarking on an i9-12900 shows the following per system call
> performance improvements:
> 
> 		       before     after     improvement
> sched_getattr          182.4ns    170.6ns      ~6.5%
> sched_setattr          284.3ns    267.6ns      ~5.9%
> sched_getparam         161.6ns    148.1ns      ~8.4%
> sched_setparam        1265.4ns   1227.6ns      ~3.0%
> sched_getscheduler     129.4ns    118.2ns      ~8.7%
> sched_setscheduler    1237.3ns   1216.7ns      ~1.7%
> 
> Results are based on running 20 tests with turbo disabled (to reduce
> clock freq turbo changes), with 10 second run per test based on the
> number of system calls per second. The % standard deviation of the
> measurements for the 20 tests was 0.05% to 0.40%, so the results are
> reliable.
> 
> Tested on kernel build with gcc 14.2.1

Nice, thanks!

