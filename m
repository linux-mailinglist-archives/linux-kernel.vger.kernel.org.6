Return-Path: <linux-kernel+bounces-229342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CF3916E9A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5EB61C22FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B844176245;
	Tue, 25 Jun 2024 16:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVn4w3up"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9560F16C696
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334657; cv=none; b=BFKmgaMc7SpNua2PjKaLLOjO5IF5dYOvjNNN7gqFn1b3Naqb0y2+IS8xyQlI4RSVfMzUBwTcJUl60AVwKDnU1e4kq9ypxUSlsykKT5+5ffZb4GXrYl9fy1VL5ejzHDTmtG7dJM+vx1qAL9WN8d2awcDrrIu21VRcsOkWesf0YjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334657; c=relaxed/simple;
	bh=4YFciS1vhX1nPzOFmoNl3vPism5IYQFdjdnF6rWULsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DurZRfxCfB3rUUOBxC1LzVSZXvpfSX+gS6+hZNxAXvJBzHwCOPpulrJ4uHJPXrUjQr2DOzP7ZjeTw3AtcoU/5mZw6N0qsDn6egRTfFBepNUx8v7VZw/EbwUjhQjewDXaVUwRb+/gMn1EaJQqN3n/LlB0tr9VabqhVCBIoMoGsEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVn4w3up; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f9e2affc8cso34574885ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719334656; x=1719939456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojvQynWosmy5FpjlQGa6EsSGl2zEf0rZMFFwbHrAUXU=;
        b=kVn4w3upYFki+F2cpFItxNjDfHHJj9s20RhEOWNMxxukeE62Hnl6M7EuisRowzFE/8
         rbn6od5hDicOqkbMptxxAPjk6kEHgB1RijrLBQTZ39B/EGkOONUgg7UT69+lNgN3bCCm
         xb9ciTi2/zWWoAis2Txqt6pjVNQZ3iX/PYAbMtAd97a0rZ0baPU/CyBSe/8FGvAyZgEk
         /FLtkzhJ07i7Ml3k4eHqTOWYJ4qA3QWQdVSAH+rOgom7lD5QY2kLk8sdX7Ot7nSKZMq+
         FCY4vk8jo4lJFG7CsK08X8iU6KBh7uiDgP2f1j32gTFetAJYrW64pmA+28wKMblFkI/W
         h4PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719334656; x=1719939456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojvQynWosmy5FpjlQGa6EsSGl2zEf0rZMFFwbHrAUXU=;
        b=vx3C86NnzWIwN5+sQiY9zBzXnX+8VNPADtnFlpnbMKdeq3phq6BNkFuaOS7heKTcHH
         8LwsuIU74VfR/xohf0+nipZ5j8xd1ZqZPEvl08jcq0OiZHo1tUh3Gx4dPs71DOBbCJ9Q
         6w/CDM4O8pte5N2GlLDLq01XFJmfLVpSVwi1LQEYJQOgA/Va3kYxG5fZd27kR7+v8Gau
         wc/DO8JzCq7CKnhnJYtqk8o/t9C/ZRwrjrn3JA5gVttrDxM5/4lap13zsn5ej3pQdbkq
         AqkU30gEQQcy6JN+f3oHeuAYCY1F44AdXpf++oHjkWfNkt83DZIf1pmCL1J6bkcWYzyu
         YYiA==
X-Forwarded-Encrypted: i=1; AJvYcCXGV3R/oN1CAgngshBKwytbZobdQzMnnxE/74EwEY64UbRDx6UsqxFcHfhoIt6UwF3lz3NslbEqxybfW1qBFStRiASduzPUtvGf34lP
X-Gm-Message-State: AOJu0YwJF9AY4GAPVVnaNuk80eq+wgK+3fgaa6hyfM/xmTr7+8npg7uf
	SPvZEMrdctJD6BaSuzUmc7Vo4iKnvrx6PVvXjtBkh8m5gq0ydtGFq7TCyg==
X-Google-Smtp-Source: AGHT+IGhKg+V6GPwdJx1uvPDIj86v6I30l3fnlyPmMamL5CquUIENGFyz87t4nItPvxKCcMnVhKh1Q==
X-Received: by 2002:a17:902:e810:b0:1fa:ae:f383 with SMTP id d9443c01a7336-1fa23f1d3e2mr94501915ad.48.1719334655706;
        Tue, 25 Jun 2024 09:57:35 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb3d8b7esm83476285ad.207.2024.06.25.09.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 09:57:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 25 Jun 2024 06:57:33 -1000
From: Tejun Heo <tj@kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] workqueue: Improve scalability of workqueue watchdog
 touch
Message-ID: <Znr2_fjb1UY-Rakp@slm.duckdns.org>
References: <20240625114249.289014-1-npiggin@gmail.com>
 <20240625114249.289014-3-npiggin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625114249.289014-3-npiggin@gmail.com>

On Tue, Jun 25, 2024 at 09:42:45PM +1000, Nicholas Piggin wrote:
> On a ~2000 CPU powerpc system, hard lockups have been observed in the
> workqueue code when stop_machine runs (in this case due to CPU hotplug).
> This is due to lots of CPUs spinning in multi_cpu_stop, calling
> touch_nmi_watchdog() which ends up calling wq_watchdog_touch().
> wq_watchdog_touch() writes to the global variable wq_watchdog_touched,
> and that can find itself in the same cacheline as other important
> workqueue data, which slows down operations to the point of lockups.
> 
> In the case of the following abridged trace, worker_pool_idr was in
> the hot line, causing the lockups to always appear at idr_find.
> 
>   watchdog: CPU 1125 self-detected hard LOCKUP @ idr_find
>   Call Trace:
>   get_work_pool
>   __queue_work
>   call_timer_fn
>   run_timer_softirq
>   __do_softirq
>   do_softirq_own_stack
>   irq_exit
>   timer_interrupt
>   decrementer_common_virt
>   * interrupt: 900 (timer) at multi_cpu_stop
>   multi_cpu_stop
>   cpu_stopper_thread
>   smpboot_thread_fn
>   kthread
> 
> Fix this by having wq_watchdog_touch() only write to the line if the
> last time a touch was recorded exceeds 1/4 of the watchdog threshold.
> 
> Reported-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied 1-2 to wq/for-6.11. I think 3 and 4 should probably be routed
through either tip or Andrew?

Thanks.

-- 
tejun

