Return-Path: <linux-kernel+bounces-439715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FA29EB2FD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064E9188737A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C49C1AE877;
	Tue, 10 Dec 2024 14:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nQSHYhwo"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123731AB523
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733840311; cv=none; b=fdY0Xc33+G4ZHXl/VQfuBDxfSyHHymXKHTnbJqGVqlPgWwf75XgBcik6KcCawpGuqes1tfRpzpodoWShqHtjD9h6YcoS0YnJNkYp/M1tglthAKNNMtTM/3ZkVN+IbJqzF5s5f1W2YrZEiT85u33048LjYmFvr4LCISvfnR/rOK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733840311; c=relaxed/simple;
	bh=H8yPQo4JGnB2nd1FXAwNgQfN1W+rWdoAuSMsWLRf+mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Le0xx9dk+KR/5kcsRKh/VmFikql1s5K38P3LgBy/Otwp2hmxvvOW+3MpoPo0C4OIc6BTo/HBNI/3+I5/5tdH/Hw3EGOwtQvPA5D6f3Dso+UQpQlZ25+NuaOPbzGvDJcPrEPUGw1EMcbnh6lV/BvuLpAxZIJO+CPnMYAbO7KufkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nQSHYhwo; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9ecDL11umLz/3mzUGJV+SCF67OF9NNuAqpPLULsYGKc=; b=nQSHYhwo6/fDo6fgBK9DQlmdHP
	BGB2o/FRCklrBpQdp9CSya4aUZDOHzSJUlw+8rla6L4X19+aSuqDODK+GJah9dx9mWwb9MtTGGPdD
	V2/f4z6ZyFaZhfOnx3JuSgVBgHk9HtXJVx+BgIvkigZm+9BTifpp9aX2YLi3IYaPVszvotWEDIhzZ
	wEP8X83QjeQDwS8kfBXTYr6F+HYntrGwvwcldwHBhf03lObjxg4D5jGVz9hAGbcuaLfh54EUUF0ou
	lsNS5yksF3OyD+2tu60l0H3GOqWd04LizMP5oBFc7dd6Rp2pqR/DMiQlYjOA+z0+OdYnEwJVEaBsx
	8z1ppB9A==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tL14C-00000003h2N-1lV2;
	Tue, 10 Dec 2024 14:18:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F22D0300402; Tue, 10 Dec 2024 15:18:23 +0100 (CET)
Date: Tue, 10 Dec 2024 15:18:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Zhongqiu Han <quic_zhonhan@quicinc.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] sched/core: Enhanced debug logs in do_task_dead()
Message-ID: <20241210141823.GU35539@noisy.programming.kicks-ass.net>
References: <20241210134513.2179786-1-quic_zhonhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210134513.2179786-1-quic_zhonhan@quicinc.com>

On Tue, Dec 10, 2024 at 09:45:13PM +0800, Zhongqiu Han wrote:
> If BUG() is a NOP, dump the problematic stack for debugging purposes.
> 
> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
> ---
> If BUG() is a NOP, it should make sense for debugging purposes. However,
> just arising the patch with RFC, because at least for now, I haven't found
> a definition of BUG() as NOP in various architectures. Thanks~

Yeah, this don't make sense. If you want a stack-trace you shouldn't
have killed BUG.

And yeah, having done a quick peek, I don't see how you can kill BUG
these days other than explicitly modyfing your source, in which case you
get to keep the pieces.

