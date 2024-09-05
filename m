Return-Path: <linux-kernel+bounces-316881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A7496D67A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9DBF282529
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05027198E9B;
	Thu,  5 Sep 2024 10:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="P9+RLqna"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D296189B8A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533757; cv=none; b=Cr13Kz75QqU7Hkv93iVKAPGnYf3F91mJEyFgc0E0vCtZM5f4SSu8NFtHSqZfTzIkf+b4tmguSKcY0+jeY3Bl9Bao7OKr95lGFXEK4Jx7xkVJ0C66ijRFAc5iM0CFmlsdMDBXJXVYMSqzBqVtf/IVMbF0qbMNanAtQXWVnCf0SBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533757; c=relaxed/simple;
	bh=oHV6y73TvzwqyZElNUm5S31B5DeYJphKm/Kvp0Ys7j4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oL7mQQ6U+214CUbX5jLMX00AJHjafc5cugA3HJeK5huhXcU3m+uSlEOFA2adntfZ/gFrhqayA+VPwt6Uwdwj2AED1jk/TAfYnrLH4HMyYnmI52vWWCampLcF6Iy6BrUhs318IGLSdu26WsfTMk5za0i2IWcQAOahWO+2oyaJjak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=P9+RLqna; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oHV6y73TvzwqyZElNUm5S31B5DeYJphKm/Kvp0Ys7j4=; b=P9+RLqnaNEdmxGecO2XEsO4fa0
	ycPxoJJVTujT9+Qm0tEyH3gPiL1Dekwe7T8Iq0rYwxdhUmPnegux5CG3DFb/t+wtUXcNtQhX2wSMn
	WAns/hre8mn1LKZF4cLKf8GF08FYyl+c6+mlBYUjTVDf8zB3RbBIew9RVXwM1gdWG45g68IhuQekc
	zjr/OFAQcqA/0UxSZsemw1uoGDUC7kxjm7oNAzVxo9YKoaJX4cMfglgocj/WJQ9pYOz3YOGM67NO+
	UdAiMX7YBipJJIdiXvOV6i/D40WzMbRrrca6Zuwkss3Q2b2/cnUWbukSdRmXk+22LTaAEuLEG/kU9
	wtxTZaLw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1smA9Z-00000000T67-0oS4;
	Thu, 05 Sep 2024 10:55:53 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4C7693004AF; Thu,  5 Sep 2024 12:55:52 +0200 (CEST)
Date: Thu, 5 Sep 2024 12:55:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de
Subject: Re: [PATCH 4/4] sched/core: split iowait state into two states
Message-ID: <20240905105552.GE15400@noisy.programming.kicks-ass.net>
References: <20240819154259.215504-1-axboe@kernel.dk>
 <20240819154259.215504-5-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240819154259.215504-5-axboe@kernel.dk>

On Mon, Aug 19, 2024 at 09:39:49AM -0600, Jens Axboe wrote:

> iowait is a bogus metric, but it's helpful in the sense that it allows
> short waits to not enter sleep states that have a higher exit latency
> than would've otherwise have been picked for iowait'ing tasks. However,
> it's harmless in that lots of applications and monitoring assumes that
> iowait is busy time, or otherwise use it as a health metric.
> Particularly for async IO it's entirely nonsensical.

Holdup... I should've remembered this. You're using ->in_iowait for
io_uring. And that is what started all this.

Now, having in_iowait set when you're waiting on a futex is utterly
insane, but looking at commit 7b72d661f1f2 ("io_uring: gate iowait
schedule on having pending requests") you're now only actually setting
in_iowait when you have pending IO.

And I don't think that is nonsensical as you write above.

You are after all still actually waiting while there is pending IO, no?


