Return-Path: <linux-kernel+bounces-369999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16A29A2582
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E319F1C21B54
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 14:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C611DE88D;
	Thu, 17 Oct 2024 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="W0BCE122"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7D41DE2AD
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729176495; cv=none; b=Nzv18pE0H0GP+OAPuKCZ3+DlFMH4FZRcOhXFCblt7uiys4DlpGW0LnW6k0fIqIgGQJlwLmh3n5k3FuWhOGOH4zDvorC2i7Df9CAkeYjsD4AUbp07wx3sKx1bG8HXgiW26/VzpFvo01BXaoK8HKKg4JARUCe9xHXeup7MWay7j7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729176495; c=relaxed/simple;
	bh=jC4MoM7tQYIEeDGc7s0mG+jfcCutFWrOwl3Rzs9m5YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iAx/Ckw/jeX7tYgd9ZVaWi3awzRpBFuHl1W+xKFeUqveKOE8UHgscI08hSmkA/AtZEMztTmxN2x5MboJ3CYGaNqXE9+x/3s2warZQKbScr51xHI9DkJF+VNwuQymwgI505vRhoCEyG2cDecNlXcbC9caZpGGN+SH8or0v8z8zfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=W0BCE122; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <32ad3314-c2bc-4d3c-b4ae-28f96ac965af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729176487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTWVb9RWUjH60M/uyjEmwiRUfPzjPzTlenFxRoK5pGo=;
	b=W0BCE1222ZeobCZh91PXx76cOow0MSyU7XQwDs6N7iAEyACHfcuefgx/vUTteEIR59pAe2
	BcVh1Y/HD6MlIBO4gEMzBrGlJuBQwVitlLybYdrm7wIiKHZ6Mi7baRnQjiMZ15evTVEK1R
	y7DR+ixRjsSHDglqYB2KSEozDkvqJ6k=
Date: Thu, 17 Oct 2024 10:48:00 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [iommu?] kernel BUG in dma_alloc_attrs
To: Christoph Hellwig <hch@lst.de>
Cc: syzbot <syzbot+b4bfacdec173efaa8567@syzkaller.appspotmail.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 m.szyprowski@samsung.com, robin.murphy@arm.com,
 syzkaller-bugs@googlegroups.com
References: <670ebde5.050a0220.d9b66.0154.GAE@google.com>
 <20241016080240.GA30380@lst.de>
 <da9db10e-98fd-405c-9167-a29235f5470b@linux.dev>
 <20241017144020.GA22666@lst.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20241017144020.GA22666@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 10/17/24 10:40, Christoph Hellwig wrote:
> On Thu, Oct 17, 2024 at 10:31:40AM -0400, Sean Anderson wrote:
>> On 10/16/24 04:02, Christoph Hellwig wrote:
>> > The problem is that the dma alloc/free tracing calls virt_to_phys
>> > on the allocated/free memory.  But that memory can be vmalloced as
>> > in this case.  I think we don't have weirdo allocators or pools any
>> > more that are neither in the direct kernel mapping or vmalloc, so
>> > we might be able to do an
>> > 
>> > 		if (is_vmalloc_addr())
>> > 			page_to_phys(vmalloc_to_page()))
>> 
>> Do we need offset_in_page?
> 
> The DMA allocator always returns page aligned memory.
> 
>> Since this function returns a virtual address, I think that would be
>> fine.
> 
> Ok, I'll look into that.  I'll need to check if %p gets obsfucated
> for traces like it does for normal dmesg first, though.
> 

I have a patch written up for this; will send it after testing.

--Sean

