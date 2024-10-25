Return-Path: <linux-kernel+bounces-381148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6379AFB24
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B6991F2356A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 07:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177CB1925B0;
	Fri, 25 Oct 2024 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fD9UXOrW"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5FD1BC5C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 07:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841557; cv=none; b=IRP6Ve6OI1ETPdDX52Jm9lqw5mno3J0SeARW/tIuVf0BvSNUmw0gQpS76c+5EyZeEPXkDn4wjL+Ie2lnZjQ0T3uT6uYmORbetvKo9dfhdNtSi41vJZdAQNxJD0Dpynpew/zkGfQh/nZ7w6EIQwS6bpQaOYaeNkfTbNCy4DjMQ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841557; c=relaxed/simple;
	bh=6lbmk3Ja7AF21qzc4qMsQjg6M5luu4wNGU150qR0lak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cN88lMgn/woh4Au+xmJmWge26z0zw52wdWAkqIUY4rc3fxyB4KU4VNhhyPQVaSK62NC1gartueTqWdmsdgsYZWoFfK93639MRJGAE3b0lI/CreymCqvQ1e+2wcts2vZhfhZv1qmHagfDTrS5a+wQWBWvf1xMjvUcj1BM/oVCIK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fD9UXOrW; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wMmOJHGDGcVJxSfQ0438UxPZXUdWZaXqCqcr9oFy4Lc=; b=fD9UXOrW/RXuwx03N1Cw0/cckh
	80m1teRHcpzQFwZ/AFsNIuuw3y/slvvUGk4ueuL8UNQplmCBYpoMI09EW7EEJR54oJ5juHNECj+Sd
	esyYIDTevlKg5XzA7AJG+ZNmdDdO3DMhEPeWqk6O2viNbpxJy/agNrHrP6X2UksHOAzWjas1j2Tfm
	CPV+gOrzlLSCiDDnW8rW2q0THdLhDvW75ia8bhfx1rs6uVNd8+dhsEfaEbxycgxtd7G+bt2RuXhIA
	9TmsZuIRA1caHB3RyxubgY5VAULTSIivxihWL5/1LoZsPiYSiKqXH+4Zm5lsIh0WgJVK2E3CheunT
	uIXovWRA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Enu-00000008qu4-2WNL;
	Fri, 25 Oct 2024 07:32:15 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B027A30083E; Fri, 25 Oct 2024 09:32:13 +0200 (CEST)
Date: Fri, 25 Oct 2024 09:32:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Qi Xi <xiqi2@huawei.com>
Cc: kernel@openeuler.org, bobo.shaobowang@huawei.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, patrick.bellasi@arm.com,
	mkoutny@suse.com, tj@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Fix compile warning about variable 'uclamp_mutex'
Message-ID: <20241025073213.GE36494@noisy.programming.kicks-ass.net>
References: <20241025034740.546570-1-xiqi2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025034740.546570-1-xiqi2@huawei.com>

On Fri, Oct 25, 2024 at 11:47:40AM +0800, Qi Xi wrote:
> When build with CONFIG_UCLAMP_TASK && !CONFIG_UCLAMP_TASK_GROUP,
> the variable 'uclamp_mutex' is defined but not used:
> 
> kernel/sched/core.c:1361:21: warning: 'uclamp_mutex' defined but not used [-Wunused-variable]
>     1361 | static DEFINE_MUTEX(uclamp_mutex);
> 
> Fix this by only defining the variable uclamp_mutex when the
> CONFIG_UCLAMP_TASK_GROUP is enabled.

sigh.. I hate our CONFIG space :/

Perhaps add __maybe_unused like the other variables it sits right next
to instead of adding yet more #ifdef crud?

