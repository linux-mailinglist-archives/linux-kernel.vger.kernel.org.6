Return-Path: <linux-kernel+bounces-177614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 495588C4191
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE94CB22724
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 13:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE533152160;
	Mon, 13 May 2024 13:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="apbCsBl0"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC0D15098C
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 13:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605975; cv=none; b=nv9M42D3yCO2IrNRqjmHmAunZ3racqu8rDibB3DChx0y64vSTpnyroJ32WvMUC2SyuJAod4Ja+7tl1cBXLbNDD058s11HfFSv7P5LKmc38l/aafSLPpMvbamI3Gq8FWy3foVFWXyAV5vREz5UAby68R5ZMntBB+ASOWAkU62om8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605975; c=relaxed/simple;
	bh=QIyA9kU3DXYufAzAbyQLvhbsunKTbVggA+xwxPHEB3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=slXWAwMjnvViNhWDDUh0sERcpe+/eslfFDG2V9BPKlPm7B53RXV9xNNMhF6hXww9tDWvQ2aBKHeLpqddfcYNwTMJfJ1yuh60p1o9FC25kPstUuf29pg0a0ZgoLkiT9eYM3d2BoJW/FQDFFWjE81lq33f52zA2V78Mj3lc2SA8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=apbCsBl0; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4VdKfR2Dh3zlgVnf;
	Mon, 13 May 2024 13:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1715605964; x=1718197965; bh=CK/yTD4vsBE25iZLNTjIJQVN
	n6zNelLGLfVBPKfwaCQ=; b=apbCsBl00eKoh96TCJA+4gFfsHjvC2MCRzFnHNjt
	igYlO5msrwPg+wC8vWf1qPY/DOiw9OJ4Ky2aBN6iQ8/DCmz939vm4E0beYyLgbbX
	0qRe61nDogYk5RF/Y9zTLl8X1WwMjAC7z7WaF/Vshag1ytEjhbot0pJ+8/y0qCZ0
	S3/lr4lbr34hCcqJEIJNMv2f6C/or7FAFe9/q8n7JkknryhXufZdPyqFekY1u8CU
	DE+xlyblECb+NRNCPeBAKvAAPI4BbzsAOMBOa84Z7OJhwEuYHkB/llQubhJCys7Q
	ya4MzBzUFU5tdoxJyzCwQNtaAV1bzPN6Fcx3OHmauIuKzA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id oJpwUKMiAjg5; Mon, 13 May 2024 13:12:44 +0000 (UTC)
Received: from [172.20.0.79] (unknown [8.9.45.205])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4VdKfM5rYNzlgVnW;
	Mon, 13 May 2024 13:12:43 +0000 (UTC)
Message-ID: <c75bef55-f3f3-444f-9aa9-d646fd13f73d@acm.org>
Date: Mon, 13 May 2024 07:12:42 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] nvme-pci: allow unmanaged interrupts
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 tglx@linutronix.de, ming.lei@redhat.com, Keith Busch <kbusch@kernel.org>
References: <20240510141459.3207725-1-kbusch@meta.com>
 <20240510141459.3207725-2-kbusch@meta.com> <20240510151047.GA10486@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240510151047.GA10486@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/10/24 08:10, Christoph Hellwig wrote:
> On Fri, May 10, 2024 at 07:14:59AM -0700, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> Some people _really_ want to control their interrupt affinity.
> 
> So let them argue why.  I'd rather have a really, really, really
> good argument for this crap, and I'd like to hear it from the horses
> mouth.

Performance can be increased by modifying the interrupt assignments
carefully, especially in storage appliances that have to process a
large number of network and storage interrupts. By carefully assigning
interrupts the number of completions processed per interrupt can be
increased and hence performance also increases. In 2014 I was working
on a product that benefited from this approach.

Thanks,

Bart.


