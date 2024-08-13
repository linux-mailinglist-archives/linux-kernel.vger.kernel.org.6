Return-Path: <linux-kernel+bounces-285501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8CB950E40
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46732B21B6B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E901A7067;
	Tue, 13 Aug 2024 21:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KoggFrXt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C423D1A3BAE
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582808; cv=none; b=BYKO0IVKyRTClVzxOFAgQ7rEy3dwDxAnTKq5QtE6Z8/CFEofeHbQgN1NgerE6YWo+7KvVstQwxJktWDkvAA5uqQPKBk66skgnfKdXDQoi1CLNbDb/OLeSnOEIgZDPFbh3cVa8edCMfpvquHu6BmS28FTEGbFiPe1q9mZ/ywHGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582808; c=relaxed/simple;
	bh=kU+znfqeVEksTYIiIxtnRUbHcy/Atds8PysiNQcnEAU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r6UZ+4N4XKQ0WsqGvmFuMbZ5QrtQ/agUi7I9SjobQloekSPlhhotSBSOSQu8MymeDyfeqHG4UAxSjEs82Pya5M0iiCpZ5G+0qKkr2c32ITP+jrHsdS/ByVUaJu4zuWBrIBrBnATLGx7tTh6hgI/uN6tlLz+yK6iJhMZgwcjqasA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KoggFrXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F53FC32782;
	Tue, 13 Aug 2024 21:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1723582808;
	bh=kU+znfqeVEksTYIiIxtnRUbHcy/Atds8PysiNQcnEAU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KoggFrXtE+A9z2S7PNXRBnDwGytcKreECanzlrSvmX2VSnJ1UAHx8MALjzBO8dY6t
	 c2wPZiuBM1q2adOP5QODYUkPyavxze2tzX6+ZBwN8eJTng9X/BtTk6DrOtF5+gqZr8
	 BWdgfjIYBqXzagN//hC+0OzTK1V9nRLQYL9bJwcc=
Date: Tue, 13 Aug 2024 14:00:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yu Zhao <yuzhao@google.com>
Cc: Muchun Song <muchun.song@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v2] mm/hugetlb_vmemmap: batch HVO work when
 demoting
Message-Id: <20240813140007.2459882ce674b45ecf1403f7@linux-foundation.org>
In-Reply-To: <20240812224823.3914837-1-yuzhao@google.com>
References: <20240812224823.3914837-1-yuzhao@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 16:48:23 -0600 Yu Zhao <yuzhao@google.com> wrote:

> Batch the HVO work, including de-HVO of the source and HVO of the
> destination hugeTLB folios, to speed up demotion.
> 
> After commit bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with
> speculative PFN walkers"), each request of HVO or de-HVO, batched or
> not, invokes synchronize_rcu() once. For example, when not batched,
> demoting one 1GB hugeTLB folio to 512 2MB hugeTLB folios invokes
> synchronize_rcu() 513 times (1 de-HVO plus 512 HVO requests), whereas
> when batched, only twice (1 de-HVO plus 1 HVO request). And the
> performance difference between the two cases is significant, e.g.,
>   echo 2048kB >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote_size
>   time echo 100 >/sys/kernel/mm/hugepages/hugepages-1048576kB/demote
> 
> Before this patch:
>   real     8m58.158s
>   user     0m0.009s
>   sys      0m5.900s
> 
> After this patch:
>   real     0m0.900s
>   user     0m0.000s
>   sys      0m0.851s

That's a large change.  I assume the now-fixed regression was of
similar magnitude?

> Note that this patch changes the behavior of the `demote` interface
> when de-HVO fails. Before, the interface aborts immediately upon
> failure; now, it tries to finish an entire batch, meaning it can make
> extra progress if the rest of the batch contains folios that do not
> need to de-HVO.
> 
> Fixes: bd225530a4c7 ("mm/hugetlb_vmemmap: fix race with speculative PFN walkers")

Do we think we should add this to 6.10.x?  I do.

