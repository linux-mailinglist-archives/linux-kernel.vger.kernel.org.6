Return-Path: <linux-kernel+bounces-313138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE9F96A0CA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 16:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F6951C23B55
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 14:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C358E13D281;
	Tue,  3 Sep 2024 14:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QKID1F/Y"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8401D374CC
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374199; cv=none; b=jZDXF63LFL4iIHJcsGBT03/L3+sdhc5xNM/pl4NLxZGeYdGTl+cvz9TjruP9aMOkEilZxSqSFnjjIhyo3pzgJpoLqVFzs027kS1byV3XqWP0zZJEav+tXx9JEBzcau/AYvkkMtsho37fS+qfoU33IRp2C8NKKI9Qr3DIotZbDOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374199; c=relaxed/simple;
	bh=Z4oBj/a2P4O2prd6rN6vg2rQlS8JspJ/SLpRsegS+iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=swcxWMOpzPrTvtHLRovmrIS7PylwuCvlmAnO/PGL+MPXjZAc48+0ROQiTCeJRMMm6yKPOAAyBSWUqjN+5yrzD9JOCZf5kc1IiZwKAPww7iym62xG5OIWnri9DYRJPPuVUMIuAe1938O1A8TnrZOzNn52bZl/XsiYDUjk2OnvjwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QKID1F/Y; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d8936bfc-1ea3-4142-8035-0dfb8e491c31@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725374194;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wpg8hKa7dcfdLPr9XSsJARMtftfJyrs3LidO7ytj5vo=;
	b=QKID1F/Y51wgJTLcD2jci2gl6hWpH8cwvUG2i5tXM1ETmlP1B68O+TmUWWwcwOWRFWlvRM
	G7rRHIcEb4RuEHJIiETVZkQ6+1XTdu+yLELTwqZAKMZZWmGU2l7Nuhf2BXwVZ4FTYzpyNr
	m7IynLNb2XqWq+dkK23WLv4tkpzGE0M=
Date: Tue, 3 Sep 2024 10:36:29 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] dma: Trace API
To: Steven Rostedt <rostedt@goodmis.org>, Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org
References: <20240826203240.2234615-1-sean.anderson@linux.dev>
 <20240829041912.GB4408@lst.de>
 <4c2c6b24-aee1-495f-ab47-662e1e818f4b@linux.dev>
 <20240903072512.GA1521@lst.de> <20240903092154.5f0bfafe@gandalf.local.home>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20240903092154.5f0bfafe@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/3/24 09:21, Steven Rostedt wrote:
> On Tue, 3 Sep 2024 09:25:12 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
>> On Thu, Aug 29, 2024 at 10:24:52AM -0400, Sean Anderson wrote:
>> > >> When debugging drivers, it can often be useful to trace when memory gets
>> > >> (un)mapped for DMA (and can be accessed by the device). Add some
>> > >> tracepoints for this purpose.
>> > >> 
>> > >> We use unsigned long long instead of phys_addr_t and dma_addr_t (and
>> > >> similarly %llx instead of %pa) because libtraceevent can't handle
> 
> I think the issue is that libtraceevent doesn't handle "%pa", which I can
> fix.

With s/unsigned long long/u64/g I get

kworker/2:1H-mm     183 [002]    32.472411:                 dma:dma_unmap_sg: [FAILED TO PARSE] device=ff160000.mmc addrs=ARRAY[00, 50, e2, 06, 08, 00, 00, 00] dir=2 attrs=0x0

>> > >> typedefs.  
>> > > 
>> > > and a __u64 would seem like the better type here.  
>> > 
>> > libtraceevent can't handle typedefs, including u64.  
>> 
>> Weird.  The xfs trace events which were some of the first ever are full
>> of typedefs and no one ever complained.  And looking at other
>> trace event definitions they are full of it.
>> 
>> I've added the tracing maintainers to see if we can shed some light
>> on this issue.
> 
> libtraceevent doesn't even really bother with the types. It gets its
> information from the other fields.
> 
> For example:
> 
>  events/x86_fpu/x86_fpu_after_restore/format:	field:u64 xfeatures;	offset:24;	size:8;	signed:0;
> 
> 
> The "field:u64" is more for humans than the tools. And it can be used for
> hints when the printfmt fails to parse. But the libtraceevent really looks
> at the "offset", "size" and "signed" to know how to use that number.

This doesn't apply for arrays:

	field:__data_loc u64[] addrs;	offset:12;	size:4;	signed:0;

Here the size is not for the data type but for the array. And so the
type is parsed by process_sizeof in src/event-parse.c.

--Sean

