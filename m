Return-Path: <linux-kernel+bounces-361841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF93599ADB1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 22:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8F61C225CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01AE1D0F68;
	Fri, 11 Oct 2024 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ij9wq7SO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PpaH7Z+S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64E7199231
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 20:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679728; cv=none; b=OtheNtLQKsgGBAtJ+pxbVUNCGYkRmtUytugI0qMshd0YNMmrQrJdW6FMT2/87r3hNZv6cKTiou8w3GakGBji7ceTsaLVzTq+p1SqR3CuzdTXOng8AjkPnBmeQ6CRbGgpnbRIUb16R5T+QpBUwpzfqR/NzW2HHGALHCimRcYM5S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679728; c=relaxed/simple;
	bh=TrLw7SOn3CSgaEf7nJdHr1PPnUpRN/VhHFxGsbksxtQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s62oIwDqWXh35x3loE8XqgHyUzQnDv7HHK9aktM8FOQppjhHq2cjgz4s4Fcj17D3PQMOk9wA3RvCOIvsvaQJT6kLHEX9ulTEp+2Li3NqTavr+yg61LHJm/uCzbcKdN1ckCJ+1FBAtfHNl2kdGc24ELqe1Eb2qtKiLrRJ88JMZgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ij9wq7SO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PpaH7Z+S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728679725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8wFu7WjaFcyAPsWrFrRTdxP973Geay07tCh8n6j2KU=;
	b=Ij9wq7SOlbwSr0svoVUu4uG/134/pnA3upcSmcJfGbI9LC15zyPgYJKcMgzyMO0DzKtIEl
	0W4afDWjauQBdvMDFT6QlpdSMxvdaT5fJst7xyjMZ2cY4Q2C/HnYYXpWPXSPgl3iAZWQIV
	hHeE6YkyZ4pn+g4ia5nq8RCr0ERzuTmjtoqmNzZAXjELzpLa6TUm1nrItkcFp8FVHWN901
	AFfpM6ZN8B+5BR6i4C8sdi2FuixYate4D08vWjdDmutWQ4taN7L6xR3O+JoTQsooEq1np/
	tvbqfW96WO6fAnBFHj9vLV7dLi+m+/OQJnFKp8fzu4PJtPQbc7aV8s5Dd/1Aag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728679725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P8wFu7WjaFcyAPsWrFrRTdxP973Geay07tCh8n6j2KU=;
	b=PpaH7Z+SXlSnUU9e2uiFBoS12vY8UtBlohQ0tq0f29CM8X3WWBmAK8UAgalW4qdc4MK8Wl
	ALYPkcUHm9kpDiAQ==
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Waiman Long <longman@redhat.com>
Subject: Re: [patch 21/25] debugobjects: Implement batch processing
In-Reply-To: <192cb914-556e-4617-fdfa-25bdc8c56f43@huawei.com>
References: <20241007163507.647617031@linutronix.de>
 <20241007164914.258995000@linutronix.de>
 <192cb914-556e-4617-fdfa-25bdc8c56f43@huawei.com>
Date: Fri, 11 Oct 2024 22:48:44 +0200
Message-ID: <87h69igyc3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 10 2024 at 17:39, Leizhen wrote:
> On 2024/10/8 0:50, Thomas Gleixner wrote:
>> Adding and removing single objects in a loop is bad in terms of lock
>> contention and cache line accesses.
>> 
>> To implement batching, record the last object in a batch in the object
>> itself. This is trivialy possible as hlists are strictly stacks. At a batch
>> boundary, when the first object is added to the list the object stores a
>> pointer to itself in debug_obj::batch_last. When the next object is added
>> to the list then the batch_last pointer is retrieved from the first object
>> in the list and stored in the to be added one.
>> 
>> That means for batch processing the first object always has a pointer to
>> the last object in a batch, which allows to move batches in a cache line
>> efficient way and reduces the lock held time.
>
> It seems that adding a helper function hlist_cut_position() can make the code
> look more concise and clear. But there's a lot of patches now. We can do it
> later, and maybe I can do it then.
>
> Similar to the current list_cut_position():

Yes. Thought about that, but then ran out of cycles. Feel free to look
at that. Help is welcome.

Thanks,

        tglx

