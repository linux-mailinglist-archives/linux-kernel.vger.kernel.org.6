Return-Path: <linux-kernel+bounces-237068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAA191EA92
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B424E1F22390
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152BC171E52;
	Mon,  1 Jul 2024 21:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YaWBLar9"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D20171E47
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719871138; cv=none; b=qLPX4Sdt042sI/S4as3RPz7j8jXjnfw0imQTDmK0kgGR+W50xYAJx4WQQJxYxrr2bGzGpXMv9N0iElPK7sfte/xVi8SKeK1h4FC61Hv6XbIZocjfwCOzichU/H/m5BNV8vYckKXHWF7q0HkLB3Jl+pIDiX/9Q5k1QPeWLRBBOsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719871138; c=relaxed/simple;
	bh=4BBEDjsPwvqouQu3l7yqObvSuH+KJ2qqOtYRjKIVBB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bHz6EzEvwpyfAsi7pyDNAm+ks47o8AXDdhSdFWnIcZxJ5a+J96YrF7E3XRqTgRdKGpvVyRk/lAqaLdQXztcGDOvoyHfa9dWotdfF54NOX24pdnKFvJFdnNr65+nEtrySrrhu8EKiupxcvRxkPfKRT2123iIRKGhdquw/RdWhYeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YaWBLar9; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: 00107082@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1719871133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LnFCsgUaKKXvH5ORPNnwb9Q6wEy8p49JrmdtgH5yIpA=;
	b=YaWBLar9gcx49pEQfluf2MAdrXWbogXTLOTROe5NvKPNtu5JcUIkwUygmsuN2kQsgfJFbr
	8XxSdkA6nrDc41knJhiubveyAnYYx9Lsvlk+8eLdXbXOS9Y/6eKkTwIw0p+Azs+Ckq5P1U
	Y7xqf+0fm6vf3t1iZFCeV1KeQd+6ueg=
X-Envelope-To: surenb@google.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-mm@kvack.org
X-Envelope-To: linux-kernel@vger.kernel.org
Date: Mon, 1 Jul 2024 17:58:50 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: David Wang <00107082@163.com>
Cc: Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add accumulated call counter for memory allocation
 profiling
Message-ID: <koa5yyc2opu23giistqjaw3eo47gjcxpx56ekrbsbhltk74wzz@pvym4ollouzu>
References: <20240617153250.9079-1-00107082@163.com>
 <CAJuCfpGaEJLaWYPidiAG1vtayugQY5vJoFv9Opauh1TrofOv7Q@mail.gmail.com>
 <13c19bd1.2c49.1906c1ac5bf.Coremail.00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13c19bd1.2c49.1906c1ac5bf.Coremail.00107082@163.com>
X-Migadu-Flow: FLOW_OUT

On Mon, Jul 01, 2024 at 10:23:32AM GMT, David Wang wrote:
> HI Suren, 
> 
> At 2024-07-01 03:33:14, "Suren Baghdasaryan" <surenb@google.com> wrote:
> >On Mon, Jun 17, 2024 at 8:33 AM David Wang <00107082@163.com> wrote:
> >>
> >> Accumulated call counter can be used to evaluate rate
> >> of memory allocation via delta(counters)/delta(time).
> >> This metrics can help analysis performance behaviours,
> >> e.g. tuning cache size, etc.
> >
> >Sorry for the delay, David.
> >IIUC with this counter you can identify the number of allocations ever
> >made from a specific code location. Could you please clarify the usage
> >a bit more? Is the goal to see which locations are the most active and
> >the rate at which allocations are made there? How will that
> >information be used?
>  
> Cumulative counters can be sampled with timestamp,  say at T1, a monitoring tool got a sample value V1,
> then after sampling interval, at T2,  got a sample value V2. Then the average rate of allocation can be evaluated
> via (V2-V1)/(T2-T1). (The accuracy depends on sampling interval)
> 
> This information "may" help identify where the memory allocation is unnecessary frequent,  
> and  gain some  better performance by making less memory allocation .
> The performance "gain" is just a guess, I do not have a valid example.

Easier to just run perf...

