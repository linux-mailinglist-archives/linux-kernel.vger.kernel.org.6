Return-Path: <linux-kernel+bounces-246036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B5292BCF6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875391F2223A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19D71822F2;
	Tue,  9 Jul 2024 14:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EEv4BSxZ"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9328815749F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535586; cv=none; b=V1/ZsabCov5BPYEQkQVNz0LXGq0oW2jR6+WtNwORUWxJ8MHleGWe3JrNkyoM2ayb7qvgs7ydioZg16PXoBU6uez81kz2KUbyNLalgd+/N1GLAi7NEkXq0emMckFyuRGW2uRkG9Q+W0+Riefgvh9OQ18/eqSo6P201c/UPu5OhnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535586; c=relaxed/simple;
	bh=q7HaL6LCzoItRgWZPIc7Gjpy0NRfbZAULjtZvkD+Loo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PnoWHBUzxosMM1DuHtqnoBNKqNU84YZrmNetJUDQAC2fntgF4pqLgR7MDIrRcCexrkBETgOKJLhR7k9+W4PKOmZpLx0Jiq5JHVw1UKuj0U8ZEi/4GZwccBZr8VYIwDtrdsaQdh7Ut3yk+JUWxKEuGC3VY1BvzCuFFoDczLLjT8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EEv4BSxZ; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hOEpXl53j/Y8uQ0/ovA2xWauV1OMvEzVII097Uf47YQ=; b=EEv4BSxZeD8zdBD9KXI3EY+2sZ
	4BWKN1nXntov7f5lZCY7CkEaqakfykmi/kGmJPjePBkfZ73d23zVDnizhwDUh1GBIRPDhmexfem8g
	V5Mcioh6vYtFWipbjPUmSDOFiMnC+bsCW4WckLrLLjTNQPzIZczGcXBRPZL5pSDM+zbxC8iY+MDsQ
	DHh5iSE5BwTbNvmA85yPz+HOoC5QJbPP0RtgoReEDIBedqTzqw+5OeC3QtJQ5bYVgY84EOokiUYJl
	LZYth76d7y74h6RxCBKo1SD8t2n4vThT0uaWTlHvB5OLlxQNDxZ+qoCLnECnDKVY1Bfaoi0afa2mV
	L265+0YQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRBtp-00000000kyc-1ory;
	Tue, 09 Jul 2024 14:32:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 808ED3006B7; Tue,  9 Jul 2024 16:32:56 +0200 (CEST)
Date: Tue, 9 Jul 2024 16:32:56 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org,
	clm@meta.com, paulmck@kernel.org
Subject: Re: [PATCH 05/10] perf/uprobe: SRCU-ify uprobe->consumer list
Message-ID: <20240709143256.GN27299@noisy.programming.kicks-ass.net>
References: <20240708091241.544262971@infradead.org>
 <20240708092415.695619684@infradead.org>
 <20240709120551.GK27299@noisy.programming.kicks-ass.net>
 <20240709133349.GC28495@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709133349.GC28495@redhat.com>

On Tue, Jul 09, 2024 at 03:33:49PM +0200, Oleg Nesterov wrote:
> I guess it should do
> 
> 	WRITE_ONCE(uc->next, uprobe->consumers);
> 	rcu_assign_pointer(uprobe->consumers, uc);

Yes... 

