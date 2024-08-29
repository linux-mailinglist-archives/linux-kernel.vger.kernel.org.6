Return-Path: <linux-kernel+bounces-307107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD89964833
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 16:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119BF1F223DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB2B1AE84C;
	Thu, 29 Aug 2024 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d8lHUvKm"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8751A76C1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941500; cv=none; b=rGvdq+7Pxy11fKLYO7ur7tv+0amveaIcUW3dRwRQ2pRPoZ1hUfBlEvvpesdhFSsXQzKVRZO2uTiA26kzEseQjmoks0AhkLxQ1VaFef4J44IdQwupNWeqJnK3Pf/cI6upJv65JX513rUN0JFYBkDerw/hFe/YBaMIJJ0BHN5EVuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941500; c=relaxed/simple;
	bh=n8olwhAyvGIBu+ixAeLQGoRfqSJdXwVMscwROp79R1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=biVzVCeCdLW/T8pWETFzNbiSPFGrJakjPqNjqY/sCd1rIL8HvV5c/v/vzOKX0E4mxrEhg3wnWiztQ3ePg+TG/ywLkjha/v3zDK5Ds0pNt2ubvCmWHnxlQWVzslSQJ38aAHrQM9C7WccjjBvZXbcj0Kx+Hlyeecd/yrUzWKMSeng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d8lHUvKm; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <4c2c6b24-aee1-495f-ab47-662e1e818f4b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724941496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4bjuMojYk0Mfw4UQTElf/K+iWHCGHyxVpLzKL0LF+2Q=;
	b=d8lHUvKmV+VKcyz1W/qDC/BKHy8AUSznJO9kEtiZ7GQEXB1e6u543nQ3iv4bUTWvAmNtVv
	jiJGT9en4Ato0ZKcOhBQ9dWN1L9IZZrvquYRCzjeMypaz1iVs+l+checkeoJeptrXp0fJD
	VLypxmSZKgyd6YlI9JLmcV6vjR7P3eU=
Date: Thu, 29 Aug 2024 10:24:52 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] dma: Trace API
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240826203240.2234615-1-sean.anderson@linux.dev>
 <20240829041912.GB4408@lst.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240829041912.GB4408@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/29/24 00:19, Christoph Hellwig wrote:
> I'd change the subject to
> 
> dma-mapping: add tracing for dma-mapping API calls

OK

> On Mon, Aug 26, 2024 at 04:32:40PM -0400, Sean Anderson wrote:
>> When debugging drivers, it can often be useful to trace when memory gets
>> (un)mapped for DMA (and can be accessed by the device). Add some
>> tracepoints for this purpose.
>> 
>> We use unsigned long long instead of phys_addr_t and dma_addr_t (and
>> similarly %llx instead of %pa) because libtraceevent can't handle
>> typedefs.
> 
> and a __u64 would seem like the better type here.

libtraceevent can't handle typedefs, including u64.

> otherwise this looks fine to me.  I can do the tweaks as I'll apply
> the patch if needed.
> 

--Sean

