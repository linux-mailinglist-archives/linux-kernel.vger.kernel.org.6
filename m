Return-Path: <linux-kernel+bounces-361840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B35CB99ADAD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D55F3B226C4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686D11D0F68;
	Fri, 11 Oct 2024 20:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RJxTtGGC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S+TpWCyh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CB7199231
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679633; cv=none; b=Q8CsU38v4wKMREP1NKF3LJpabJVSMA+vmgLezztJXKSbLUBFcfEYasIsOh7FfGYzIymPDBaBbRRlDCj/Nlun2/14tK2Coy967n1/ncEBeT3olO9q+ok6C1zv4Ti0mJyXv41os/2+199+jhVCnwqRBbPbJagMwKHKaOhmzRRERr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679633; c=relaxed/simple;
	bh=JeK6yk57ORsmphTsRoV0oFgDtl724flp5KVQrkRX8lk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Brbn3hiQPWgm2CJhuOvgnHTyV/2XwYOYXOSR6GAH5rIZVl30sUY/p8LgKs4Ja8CrbMaRF2ZMFuj0taKexHQciaIW/9m9EM65ci6WDwWbHdgJTkaTzkRTjCObaJxZgx4gI7LAl8cl0eNuuVYZifvl5thAT5szfkyOXifP8rK9LQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RJxTtGGC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S+TpWCyh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728679630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gd1mCLQa5OR07H5WFhnZyXaGrxdTE6PhTdlThrGJGPk=;
	b=RJxTtGGC/MMOYEnAlxUUq2fG8vqYs/QNZh4iB0KEPi+fjJ25RONrd6JjjNmlcY6dDj6szx
	NsGz9EBNPRQoBO2PYqWALJLK2gZhFNgpd8eBYDOkAxbTW6i2OLDTqViDYoYcVDVWo9Hx7k
	SQ2DN3Kn+HnUxNjNmpwsHso3djdK1z25uNTx3flnILyEaTB9AfhGWlKh5rO1nn76Pn6JgQ
	FnlsRUQNp2zaJGKsBkBsckh5385yIA8aU9vMSec5Yo1dHNm58dQ0vHfhQ0daS6P5UeX06w
	jG+HBk+92gynVvZpeqLM3Lp4hPJcYK+oQAYylh/p+ccMieLG2mCpVu7UTTt4Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728679630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gd1mCLQa5OR07H5WFhnZyXaGrxdTE6PhTdlThrGJGPk=;
	b=S+TpWCyhufB1iYP1qeA9mBlNLydOHeG0338d1nVdE1hQrPEJuX09x/i6xBMXPhYO2g3Xw9
	WkpnFFYmUYxoxHBw==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Waiman Long <longman@redhat.com>
Subject: Re: [patch 20/25] debugobjects: Prepare kmem_cache allocations for
 batching
In-Reply-To: <cd9df252-8ec8-cb84-533f-ebc98a788032@huawei.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164914.198647184@linutronix.de>
 <cd9df252-8ec8-cb84-533f-ebc98a788032@huawei.com>
Date: Fri, 11 Oct 2024 22:47:10 +0200
Message-ID: <87jzeegyep.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 10 2024 at 16:40, Leizhen wrote:
> On 2024/10/8 0:50, Thomas Gleixner wrote:
>> +static bool kmem_alloc_batch(struct hlist_head *head, struct kmem_cache *cache, gfp_t gfp)
>> +{
>> +	struct hlist_node *last = NULL;
>> +	struct debug_obj *obj;
>> +
>> +	for (int cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
>> +		obj = kmem_cache_zalloc(cache, gfp);
>> +		if (!obj) {
>> +			free_object_list(head);
>> +			return false;
>> +		}
>> +		debug_objects_allocated++;
>> +
>> +		if (!last)
>> +			last = &obj->node;
>> +		obj->batch_last = last;
>> +
>> +		hlist_add_head(&obj->node, head);
>
> There seems to be a need to use hlist_splice_init() outside the loop like patch 2/25.
> Prepare the local list first, if all ODEBUG_BATCH_SIZE is successfully allocated,
> attach it to 'head' at a time, including account debug_objects_allocated. Then back
> to patch 8/25, keep debug_objects_freed still in lock protection and do not move it
> into free_object_list(). Seems like it should be.

In case that the allocation of 16 object fails, the accounting
concurrency problem vs. free_object_list is pretty irrelevant.

It's debug information and moving it under lock protection for a corner
case is just making the code more complex.

Thanks,

        tglx

