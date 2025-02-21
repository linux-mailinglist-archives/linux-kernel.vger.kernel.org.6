Return-Path: <linux-kernel+bounces-526546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49071A4000D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D030F3BB303
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 19:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A42253349;
	Fri, 21 Feb 2025 19:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Dkb0pvA1"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E1A1FF1D2
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 19:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740167557; cv=none; b=KXBfvd0GzvDNPk/FBWd93B/Dj/l2qXUy1EmbrHurbzLpgNdJV0kJAMF6q5b2PqSbRKeC74vBe/W56t1+9UvWtpOm8WgphTILmvql0NS67sTTSVpg7HTGo6sCfx1tGcLwTM2AgS4uiDMm1xjouZpRho1T5t7Cj/4+q2N8+ivboFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740167557; c=relaxed/simple;
	bh=RM4oXZaXP5woaT4a3zuHOOiHpAFq/ILgsopxpMEarS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8UMy012QaTOm9MKTy0zyX+VibsQBROUF24b7L134xyKHYHyMQPvZY9ua1zTgc2SyctgUte9rwMVRGvLMKiOFygI6MEMnTJSnjcTLims3kfN6enTOCKwCdzJ6rUVBif4HiRNjWNpH9XYZ1QYJfdRKBaMZJX25HcklJWJOSQD6D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Dkb0pvA1; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 21 Feb 2025 19:52:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740167553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=S957pXycpJ39KxIXEb5eELZXdE7hG6Zr8xuEPgZ7kJE=;
	b=Dkb0pvA1HYJEtGlUuiyHswTgEnm84xZybKjzq6GPezBsnLtfYeW6fWJeixOlXx7h09FUIu
	xxbu9B2T+J3vLHGxkaYMcFK7gV7KsQ9VGHJUqtDcz141sckJ83CX9ZqKlhrHPnNH/Zmd5E
	KkaPNOsRNstRwBxhcpiw+lGqWoeEMrY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 11/17] zsmalloc: make zspage lock preemptible
Message-ID: <Z7jZfIaqMRTLYp23@google.com>
References: <20250221093832.1949691-1-senozhatsky@chromium.org>
 <20250221093832.1949691-12-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221093832.1949691-12-senozhatsky@chromium.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 21, 2025 at 06:38:04PM +0900, Sergey Senozhatsky wrote:
> In order to implement preemptible object mapping we need a zspage lock
> that satisfies several preconditions:
> - it should be reader-write type of a lock
> - it should be possible to hold it from any context, but also being
>   preemptible if the context allows it
> - we never sleep while acquiring but can sleep while holding in read
>   mode
> 
> An rwsemaphore doesn't suffice, due to atomicity requirements, rwlock
> doesn't satisfy due to reader-preemptability requirement.  It's also
> worth to mention, that per-zspage rwsem is a little too memory heavy
> (we can easily have double digits megabytes used only on rwsemaphores).
> 
> Switch over from rwlock_t to a atomic_t-based implementation of a
> reader-writer semaphore that satisfies all of the preconditions.
> 
> The spin-lock based zspage_lock is suggested by Hillf Danton.
> 
> Suggested-by: Hillf Danton <hdanton@sina.com>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

FWIW the code looks correct to me, but I don't trust my locking
knowledge enough to give a Reviewed-by :)

