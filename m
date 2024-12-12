Return-Path: <linux-kernel+bounces-443684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF4C9EFAAF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E80371891E82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E953223E62;
	Thu, 12 Dec 2024 18:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vAe7ZDXN"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213A62063F8
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026878; cv=none; b=Ye1TQ12o7m2pp5JZ/+V0peFHPwe3jDBn8OtaFDuSl02W+eGTJ1azyycrCXEmri+L+T5k4ZNSzcrMJAmdIP0kyYMTP16aEfShh0yIVUV4MZb70zdbUlLgTz0ayyamIP13TKmuQYtC5p7vtV9liMPSmWF8FnFFg6ic5ryny8vTDKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026878; c=relaxed/simple;
	bh=RzFEgGyTWccVQIfNT+oNWjVK78HvgNJzhyjIXZN43V8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODyWB+lHkmfoIZ6WwDOuCPQcOnIYOkoipjBWVmq13gbC5/rLiPD3HvdxKRfkQdCcym19KJkge5PW99DDqT+oevn1zdMbckYWAmudFmIFamx8974AQ93UfDSRIdnXJKJTObJ7p4ijjH0/KkCkP/QwUHLLFNyD/kaitLwBIJYUrAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vAe7ZDXN; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 12 Dec 2024 18:07:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734026873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKf4zUuhP4zvlej+aDqKww0AXyeQz4qUkRYSAjx7ur8=;
	b=vAe7ZDXN9XT3hwW9UIaNsnFb6BiV50FG7K8Fq77INFf216DE0kftMsmIaJOtOpq7cox2yN
	tUNqgEty5fNtkFbMPp+4KtRvLN6jDTc49eC0mvHDFG8pBvoZARjTQh96x8vc1B4UPV6TOY
	mTY0hLtc6kLwbKCcCjHVD72JWyUWDwc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Usama Arif <usamaarif642@gmail.com>
Cc: david@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
	yuzhao@google.com, npache@redhat.com, baohua@kernel.org,
	ryan.roberts@arm.com, rppt@kernel.org, willy@infradead.org,
	cerasuolodomenico@gmail.com, ryncsn@gmail.com, corbet@lwn.net,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm: convert partially_mapped set/clear operations to be
 atomic
Message-ID: <Z1smclZ7axm4128K@google.com>
References: <20241212135447.3530047-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212135447.3530047-1-usamaarif642@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 12, 2024 at 01:54:47PM +0000, Usama Arif wrote:
> Other page flags in the 2nd page, like PG_hwpoison and
> PG_anon_exclusive can get modified concurrently. Hence,
> partially_mapped flags need to be changed atomically.
> 
> Fixes: 8422acdc97ed ("mm: introduce a pageflag for partially mapped folios")
> Reported-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

