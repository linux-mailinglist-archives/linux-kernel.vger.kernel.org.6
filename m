Return-Path: <linux-kernel+bounces-549660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B93A55526
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 19:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D9316B2C5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7852139CD;
	Thu,  6 Mar 2025 18:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BJuGMSDY"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF1719D08F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741286242; cv=none; b=GGS5dbTLNAqUuLP4ArKU5aJCeCW2Y8gmRunlBhgsZ53CbYOg4O/RzVcsvWw/YO2EN76pWBstxDifU9/qyTrm/VrUY+Ipmiyo+wPX0cMwz+N0BWPKFbVmGlXjAFnrZ2k0o8WIp78ao5bG/X5nCQcDyurvikGdmGGYd0SJUZtboyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741286242; c=relaxed/simple;
	bh=yZH7yvWDi0qFTwXaHZjda0RczBMCiBFm+8kTDwbIJ58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5AmyzuJSn9NlFWLIFsZBe1tXmo8KxDqy0/5GXKXEfV1M93fsKW/AOtV4ey+TcnGQ5N3MnxLfId0FJQdlWtc4yjrqxAWWS1wMq+nKEFXjEadTkjB+6JEujGifsDliATL3l8XaN8kRuRrVXQPKcN3v2sTYpAEHegTLf3TuW+XaP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BJuGMSDY; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 6 Mar 2025 10:37:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741286236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MYbX2tNBav/XM/w5nhbjhJvtojZvyi104f/Lg7w9OQo=;
	b=BJuGMSDYb7Ay9bmFN4UrM2+NdUVccfqv9zqY3VmIiabQR3Yvm3w9OiflT2HshWsysYmm8y
	qaBGHjvy2rkRsPGnnnwR/xOVp2cTAK7B79DGLzq4xCAp5iavGHP/DIN0JxrAzIPom02xL5
	YPtbH1RN+3bmwPm74PV31a1UTQtmhnA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: SeongJae Park <sj@kernel.org>
Cc: "Liam R. Howlett" <howlett@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 15/16] mm/madvise: remove !tlb support from
 madvise_dontneed_single_vma()
Message-ID: <eyuppr2hzuiexyb4t353emicxb5i3igbisapvvlw73nytywhbl@66bracvzsqcb>
References: <20250305181611.54484-1-sj@kernel.org>
 <20250305181611.54484-16-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305181611.54484-16-sj@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Mar 05, 2025 at 10:16:10AM -0800, SeongJae Park wrote:
> madvise_dontneed_single_vma() supports both batched tlb flushes and
> unbatched tlb flushes use cases depending on received tlb parameter's
> value.  Both were supported for safe and fine transition of the usages
> from the unbatched flushed to the batched ones.  Now the transition is
> done, and therefore there is no real unbatched tlb flushes use case.
> Remove the code for supporting the no more being used input case.
> 
> Signed-off-by: SeongJae Park <sj@kernel.org>

Please squash 15 and 16.

