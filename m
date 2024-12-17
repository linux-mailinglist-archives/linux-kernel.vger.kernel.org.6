Return-Path: <linux-kernel+bounces-448883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0269F46C3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:02:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF7D167AD8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156FC1DD872;
	Tue, 17 Dec 2024 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZbQ14THv"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34077335C0
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426154; cv=none; b=BZRU7llRqAYsRQtZGyUhQfwM+goLu6XWARryq4Oj+fdqWbBKmwDciM6r+poR+aIy6j9YyLw6YUOQhJwAfI5HeyvKKMmGamgW9f56tGWPF2vPiZWJ+B7n9hhLqh6fMq2c5iBLZR9vW2phnPJb9/25dIK6AS4sIm1+6u6YGrVBm7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426154; c=relaxed/simple;
	bh=RGrt0xvLQDuitwXdfYDDJzVT8ntOMyUHAiq6BQdhmko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1o59jsnjrxw3HhXpa6++NhKhEW+C2Ne45gbsl9hrSx8brbvRtPq2Hycl+aqyVMdhzxlrDpxpVVvNEtRmM7PhGsj6S4UE7F2bpyrKiTC+nIljEZD3R9w3wZv7Cjd8ituF8AumbBiCKQzc8wTIFtD7Hgj29a456G9UBIzQoGlPOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZbQ14THv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6Jv+ZONtdqzGZ4nmes9OBiDMW0hfpFb7vEE9LvODlo0=; b=ZbQ14THv2aZ3fvyVzP4VRJv8q/
	wIFOlt8ftGbrRfJlt4wNRPquLm0w5eFYabv6rDrSoLmV/veg6VL2BAhMGmKpQwQvwDMKFO7+pS76T
	weGr6CjdCFKTBxqHqSygIc12hM7MMds2Kre/0YUc+dkBKyU22kWHQa9nGJIWl9iDBaJRAssn3hgl/
	EwAqrojDg5ihuWz86FwHFbV4o6twKWImaaqRXezMwINpheLv/PkGmVGZ2NT+5684bW+fE+UWZhz66
	XEEwR0HqhZ36ImvAxZ0prGkdWqF0vgsbo/64S1CRMwTiyTzpL+uKmHCeYuSCul3uZY2VgvZF1lXVG
	4JJCRETg==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNTTC-00000005vsK-2hcd;
	Tue, 17 Dec 2024 09:02:23 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 280ED30015F; Tue, 17 Dec 2024 10:02:22 +0100 (CET)
Date: Tue, 17 Dec 2024 10:02:22 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Vishal Moola <vishal.moola@gmail.com>, tglx@linutronix.de,
	david@redhat.com, jannh@google.com, hughd@google.com,
	yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
	vbabka@kernel.org, lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org, rientjes@google.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] mm: pgtable: introduce generic __tlb_remove_table()
Message-ID: <20241217090222.GJ35539@noisy.programming.kicks-ass.net>
References: <cover.1734164094.git.zhengqi.arch@bytedance.com>
 <271e58cd4ab808c4f402539b76d5916924e2bc6f.1734164094.git.zhengqi.arch@bytedance.com>
 <20241216120043.GA11133@noisy.programming.kicks-ass.net>
 <efc3f9c9-5040-44c1-82dd-59361281336c@bytedance.com>
 <20241216181225.GB11133@noisy.programming.kicks-ass.net>
 <6666f651-2a59-40fb-b984-60669d4fdaa2@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6666f651-2a59-40fb-b984-60669d4fdaa2@bytedance.com>

On Tue, Dec 17, 2024 at 11:42:02AM +0800, Qi Zheng wrote:
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 497035a78849b..11829860ec05e 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3064,6 +3064,14 @@ static inline void pagetable_dtor(struct ptdesc
> *ptdesc)
>         lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>  }
> 
> +static inline void pagetable_dtor_free(void *table)
> +{
> +       struct ptdesc *ptdesc = page_ptdesc((struct page *)table);
> +
> +        pagetable_dtor(ptdesc);
> +        pagetable_dtor(ptdesc);
> +}

Right, that works, except you have whitespace issues and I think you'll
find it'll work better if you don't call _dtor twice but instead replace
that last one with _free() :-)

