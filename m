Return-Path: <linux-kernel+bounces-222181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A6090FDF7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 681F51F250DC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 07:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F124D8BA;
	Thu, 20 Jun 2024 07:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IMtFr/mX"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8974D131
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 07:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718869454; cv=none; b=MXhSKJ7Aell7ZLEB7udSaXuKYY2oZkL86QdUrQtxu/uD/pn6fOvoGhl0punOK7ru0jyevWTU67at5ukGSLBrptZS8+qIDu6RU+c0YVG0JJtAYQcyfdg0KqwAx74dUlth0HF9lPNsL3Ks1zZ0LLGfxlXkH622Vtj7PEi1cJUdMo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718869454; c=relaxed/simple;
	bh=3j7e9PJPpJnC7/ySgQZmC2Q4r3+A3/w2hZAUUdju4BM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDHbM4iQ5s7Uj1F0kOMRHh7kc9jK2DwsMK3X/Cg/cBw6LscwvP8grAWaSUmq8BFnKsx8Yknnh/xY2+6bLE8JmCnrbOqTBYk94aKd5R6FeGsNJnBAladYzjY0/vdLcS/V6MTtHyAI/KgOAB8rTDobW1C5fqKGgqmGc0+RY3nM3Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IMtFr/mX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ITCJvqqKSa/x8Jaju7HDhd2cI01OMCbEj0IxKyM+MYo=; b=IMtFr/mXRdtnl2/LY++jO8p1zI
	oKxlk3KF87FC9s68OU0/+1qY4qZYvTXR2OPYjOOYQreVSIUYsgFW4HTfzu/bnitcE8KXCZskJ7wWs
	5s7rpambmt4schH4CnGmF6yDIYZO0uS6PlradecGBfQwhdxJRlRR0pjkiaxylCjIoI5Qi86/R4Ozt
	vVYz6ySW55Yih6bpdJ6SzSFT17T37Jz9TwOzILyCqxcwOD8xBHTwToNDayyfxlhTgpC9G4npgfiQ+
	EbPmRoU4/ppdxl40q+qonfUXRk6VjKeMaHgGENHyphE4DqUH8ss/4Gf4qAFxsol8zP1a3tZTQEPzs
	WmWtcp4Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKCSg-00000005mwj-2l1p;
	Thu, 20 Jun 2024 07:44:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4861A300CB9; Thu, 20 Jun 2024 09:44:02 +0200 (CEST)
Date: Thu, 20 Jun 2024 09:44:02 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: kan.liang@linux.intel.com
Cc: mingo@kernel.org, acme@kernel.org, namhyung@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
	ak@linux.intel.com, eranian@google.com,
	Dapeng Mi <dapeng1.mi@linux.intel.com>
Subject: Re: [RESEND PATCH 05/12] perf/x86: Add config_mask to represent
 EVENTSEL bitmask
Message-ID: <20240620074402.GS31592@noisy.programming.kicks-ass.net>
References: <20240618151044.1318612-1-kan.liang@linux.intel.com>
 <20240618151044.1318612-6-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618151044.1318612-6-kan.liang@linux.intel.com>

On Tue, Jun 18, 2024 at 08:10:37AM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Different vendors may support different fields in EVENTSEL MSR, such as
> Intel would introduce new fields umask2 and eq bits in EVENTSEL MSR
> since Perfmon version 6. However, a fixed mask X86_RAW_EVENT_MASK is
> used to filter the attr.config.
> 

> @@ -1231,6 +1233,11 @@ static inline int x86_pmu_num_counters_fixed(struct pmu *pmu)
>  	return hweight64(hybrid(pmu, fixed_cntr_mask64));
>  }
>  
> +static inline u64 x86_pmu_get_event_config(struct perf_event *event)
> +{
> +	return event->attr.config & hybrid(event->pmu, config_mask);
> +}

Seriously, we're going to be having such major event encoding
differences between cores on a single chip?

