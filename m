Return-Path: <linux-kernel+bounces-528531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2225AA418BE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4F823B5799
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0926624BC13;
	Mon, 24 Feb 2025 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2OWZEL+c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7CZDdR/l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106FF24BC0B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740388240; cv=none; b=M/4hWVJ3yv32/UhartT3lUf3Fun2Bv4n+M7TYSPFassG+IcG9zY/D/Kp4cH5L7fv2Elep8+P/hcUe+sjhYvGxZWJiXq1IfKPZQMpNn6wQ7ja86j5lQ195sjFYWMc8Z5i986fK82TbLWGNC3yrUJf1KwZfS0Xl/BlqBmksILCGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740388240; c=relaxed/simple;
	bh=eerz/6m2SwTKOFXB2OKD0Y5sI2vf/FI/jwlWGslcu8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkYhcFXx1qNbMgAaEeAUeE6I/bxWzZZxv0EauPqPJwKkWQY3TAY5aEbm9Na9JjOdpsSjIssnJvlrcgHjVcSRUjlz4jtdu3Ey74kI2ctJCkwNhgY4M2p/5aoR8yis3KjDbfSoJ0tDLBkG3SHos+a8mietzIGNrcFUZrxs/jihMlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2OWZEL+c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7CZDdR/l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Feb 2025 10:10:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740388237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPqGnpTERnLv/18IQIdDLi4CqLYf720duchwyRqxOZU=;
	b=2OWZEL+c1cj8I0babIp6FhPn+sOh120YWsro0KostGW4iFTBGb2eCyrN/nGOjU1ouAsCMj
	dNZCWINWTuqQyHH/rRgJC1+/YZsmQLrJld75izW57QoN7pSI1EqqvwN+ktm1QjJoN2+b5/
	gc25jJA18EooRjgHEtKzNiI2cRm6Rg+MLKjHRzsOFByD/Oen+mhwyuBQbE2VxRcbxhVZ+C
	1QKpb7ajlQJP5948Atu+2ufiO9v8k5oUWuLrpzgToYa+PvryYN4CfKlCUM3u/OVxC6gBh5
	i/Pp1d7BZYOGSGCa2xPF5dzbYQVV46hrm4al8OCffE0X8jCbjNR3MCR9aNCVWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740388237;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hPqGnpTERnLv/18IQIdDLi4CqLYf720duchwyRqxOZU=;
	b=7CZDdR/lQVFuSZ13nzzqpxmYidYAwyMH2Pq/c34Thj4WqVMfHrgu6Nlyx4ftKbbwqww5z2
	akR4ri2QJ5i2zRDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/17] zram: permit reclaim in zstd custom allocator
Message-ID: <20250224091036.Y9fHrKr-@linutronix.de>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
 <20250221222958.2225035-15-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250221222958.2225035-15-senozhatsky@chromium.org>

On 2025-02-22 07:25:45 [+0900], Sergey Senozhatsky wrote:
>  static void *zstd_custom_alloc(void *opaque, size_t size)
>  {
> -	if (!preemptible())
> +	/* Technically this should not happen */
> +	if (WARN_ON_ONCE(!preemptible()))
>  		return kvzalloc(size, GFP_ATOMIC);

This check works only on preemptible kernels.
If you run this on !PREEMPTIBLE kernels, preemptible() reports always 0
so that WARNING will always trigger there.

> -	return kvzalloc(size, __GFP_KSWAPD_RECLAIM | __GFP_NOWARN);
> +	return kvzalloc(size, GFP_NOIO | __GFP_NOWARN);
>  }
>  
>  static void zstd_custom_free(void *opaque, void *address)
> -- 
> 2.48.1.601.g30ceb7b040-goog
> 

Sebastian

