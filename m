Return-Path: <linux-kernel+bounces-171078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC1C8BDF8C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CAE61F23702
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A89F14EC6E;
	Tue,  7 May 2024 10:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LeAc4xYv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IFhfTbr7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EC514EC4A
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077250; cv=none; b=jAwuayytrTpr4UrSdopP9SotwSpeJiRvcJa2FYMVte0kMCBJKTZXmrgjzSmufxTxhX4W2S5YQD/v5yFQUqHqBSfqojtQngbl700KwT35mndJ0i6ta8y+kjZMxDC/GYlbiUR8iM7Bt6aVc8FKsLxr2FvVTrGWpaIKv7RSUXoqvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077250; c=relaxed/simple;
	bh=F4mEaspsKH+C3SRbI+tnMOWwoo2Lhi0QrK0rMcAr70w=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cr5A6G2A+plSH8QKrlc5MtPubNe4HJWMWHh9J512sdsmNtXjdyNfZI8g6nk64WaYef2pgliu/qeCXl9xCAUOlxZ2W3JJhu75LaeOzm63ymjO6H9CvV1CwBD135gf8OqEcDL6LeMMho3ewKpHFTTOXIj5+4g/j7wqiKZFBK7Sl1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LeAc4xYv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IFhfTbr7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715077247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XhEN/ky7pbyVwbgnC9pAsY2qwoBMWLKX+rA0d7wKphA=;
	b=LeAc4xYvuqRyPDjZNgFLwy+p6uWE1mzlysZJ7qLSBgAnSVqhNhCue6MpxfCKTJ27X6ZdYp
	NpWJXBUr7xT2XJATVp0S3pf39Sl9M88CFtz1qDb0QdTQ7mxj/OzII9pEMx4I0UxumiOSi6
	QOIsSyVAtaywdlnSKwbmbPcHdzl4AFjOnw/Bo7Bt9r0HSTrakw/4MA3gALTjIQtpqC6vNk
	6v/Ye/yyyeosn7GJu1ESJLfj4HJ1vnQV5wCEdPU5ZiuJTOizacXLT4i8Nim/cscv7RY+MW
	vwzoYrje9R9hU8DaJJoyphxHfQS2QfhFuOshGJ1UgmUio5T9qEtFyricTcjDXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715077247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XhEN/ky7pbyVwbgnC9pAsY2qwoBMWLKX+rA0d7wKphA=;
	b=IFhfTbr7iOTQuSa3OVjBVUfyeOPHy9ewZ8aQYlsjcm8WczKXzLkTumecJi+Vqg5USo0lFb
	wL3ik5chp0oP0uDw==
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: Simplify the check for __irq_get_desc_lock()
In-Reply-To: <a75c2818-11eb-3f78-1699-94a5b10ef232@huawei.com>
References: <20240506125057.307586-1-ruanjinjie@huawei.com>
 <87seyurfk7.ffs@tglx> <a75c2818-11eb-3f78-1699-94a5b10ef232@huawei.com>
Date: Tue, 07 May 2024 12:20:46 +0200
Message-ID: <87bk5hrkht.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 07 2024 at 09:16, Jinjie Ruan wrote:
> On 2024/5/7 1:55, Thomas Gleixner wrote:
>>>  	if (desc) {
>>>  		if (check & _IRQ_DESC_CHECK) {
>>> -			if ((check & _IRQ_DESC_PERCPU) &&
>>> -			    !irq_settings_is_per_cpu_devid(desc))
>>> -				return NULL;
>>> -
>>> -			if (!(check & _IRQ_DESC_PERCPU) &&
>>> +			if (!!(check & _IRQ_DESC_PERCPU) !=
>>>  			    irq_settings_is_per_cpu_devid(desc))
>>>  				return NULL;
>> 
>> The existing code is readable and obvious. This is not.
>
> Thank you for your review. The existing code is indeed clear, but it
> seems that both judgments are checking whether the percpu flags are
> consistent.

The code checks whether the descriptor is marked as per CPU devid if and
only if the caller requested it.

As the code exactly doing that, what is the point of changing it to
something incomprehensible?

Thanks,

        tglx

