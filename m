Return-Path: <linux-kernel+bounces-535637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73347A4755F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 06:48:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E9F16F106
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF04209F3E;
	Thu, 27 Feb 2025 05:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NnfxxYai"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3182A1E8325
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740635295; cv=none; b=HVT6AwVI9kX7iuVXpZG5yeq3NxccGqPZSqmN5z4IH44meAuVPyocDLsPUJiVZzM6dnvTfkLJCzaIM7201kz0Q7tDLqVZFEycmvIP52GKv1CzuCab7ChugeY8M80Q+oMR1HyEjAqpay2i3uQrH2xEHkSUYJBb4vV8PtxpoNesWzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740635295; c=relaxed/simple;
	bh=MTqdsDl/80NWEf3qEyWS1bUvUc1sPKhrHxJ7ySe0neU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fqzkQpC+A3ZdbqLoVEeb4elkRJORV6CwuWXyrgSoUNJ27SwqKKU3KTSBM2zqDYKv7cDdJ46qntfZZ+/G5FumVmt7IuNO5UdC9POM5TEtD52zKd/0TU590hKd5sfP4WxgV6FZuCAmIA3SzIqMgGQjXAYAyJrFyHzHtqEA6TdVBlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NnfxxYai; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 27 Feb 2025 05:48:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740635286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K4TkQ8UrhrrQr19zoNVeArPkdnwKAuEj5fc35ftPO8E=;
	b=NnfxxYaiQFZIfNf1wYPc3S8quk/CqgB+eHNUeSTKeAtdm+oZA5COBTyleDiadlulaa3MGC
	5nLn7EOi7zJpsD5MrNRD+xCnVtZVzppDCcXt6fx2II7N3DaW92/jshuqNErGni5gzqabrj
	aIKZstGxkNUsp5Hp7/2xGF6lHskPSeY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yosry Ahmed <yosry.ahmed@linux.dev>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hillf Danton <hdanton@sina.com>, Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 14/19] zsmalloc: introduce new object mapping API
Message-ID: <Z7_8koiBRTfQ81bb@google.com>
References: <20250227043618.88380-1-senozhatsky@chromium.org>
 <20250227043618.88380-15-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227043618.88380-15-senozhatsky@chromium.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Feb 27, 2025 at 01:35:32PM +0900, Sergey Senozhatsky wrote:
> Current object mapping API is a little cumbersome.  First, it's
> inconsistent, sometimes it returns with page-faults disabled and
> sometimes with page-faults enabled.  Second, and most importantly,
> it enforces atomicity restrictions on its users.  zs_map_object()
> has to return a liner object address which is not always possible
> because some objects span multiple physical (non-contiguous)
> pages.  For such objects zsmalloc uses a per-CPU buffer to which
> object's data is copied before a pointer to that per-CPU buffer
> is returned back to the caller.  This leads to another, final,
> issue - extra memcpy().  Since the caller gets a pointer to
> per-CPU buffer it can memcpy() data only to that buffer, and
> during zs_unmap_object() zsmalloc will memcpy() from that per-CPU
> buffer to physical pages that object in question spans across.
> 
> New API splits functions by access mode:
> - zs_obj_read_begin(handle, local_copy)
>   Returns a pointer to handle memory.  For objects that span two
>   physical pages a local_copy buffer is used to store object's
>   data before the address is returned to the caller.  Otherwise
>   the object's page is kmap_local mapped directly.
> 
> - zs_obj_read_end(handle, buf)
>   Unmaps the page if it was kmap_local mapped by zs_obj_read_begin().
> 
> - zs_obj_write(handle, buf, len)
>   Copies len-bytes from compression buffer to handle memory
>   (takes care of objects that span two pages).  This does not
>   need any additional (e.g. per-CPU) buffers and writes the data
>   directly to zsmalloc pool pages.
> 
> In terms of performance, on a synthetic and completely reproducible
> test that allocates fixed number of objects of fixed sizes and
> iterates over those objects, first mapping in RO then in RW mode:
> 
> OLD API
> =======
> 
> 3 first results out of 10
> 
>   369,205,778      instructions        #    0.80  insn per cycle
>    40,467,926      branches            #  113.732 M/sec
> 
>   369,002,122      instructions        #    0.62  insn per cycle
>    40,426,145      branches            #  189.361 M/sec
> 
>   369,036,706      instructions        #    0.63  insn per cycle
>    40,430,860      branches            #  204.105 M/sec
> 
> [..]
> 
> NEW API
> =======
> 
> 3 first results out of 10
> 
>   265,799,293      instructions        #    0.51  insn per cycle
>    29,834,567      branches            #  170.281 M/sec
> 
>   265,765,970      instructions        #    0.55  insn per cycle
>    29,829,019      branches            #  161.602 M/sec
> 
>   265,764,702      instructions        #    0.51  insn per cycle
>    29,828,015      branches            #  189.677 M/sec
> 
> [..]
> 
> T-test on all 10 runs
> =====================
> 
> Difference at 95.0% confidence
>    -1.03219e+08 +/- 55308.7
>    -27.9705% +/- 0.0149878%
>    (Student's t, pooled s = 58864.4)
> 
> The old API will stay around until the remaining users switch
> to the new one.  After that we'll also remove zsmalloc per-CPU
> buffer and CPU hotplug handling.
> 
> The split of map(RO) and map(WO) into read_{begin/end}/write is
> suggested by Yosry Ahmed.
> 
> Suggested-by: Yosry Ahmed <yosry.ahmed@linux.dev>
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

I see my Reviewed-by was removed at some point. Did something change in
this patch (do I need to review it again) or was it just lost?

