Return-Path: <linux-kernel+bounces-171083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C87788BDF98
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BEE284F61
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 10:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B5814EC76;
	Tue,  7 May 2024 10:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0tm8/+1j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Re5Qxkcx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C9F14E2F0
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 10:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077335; cv=none; b=bVxIfj0S36wHWDjmSInpxRnm8paJi445Yk/04TN1M2lMQAi2lR/P1U86i+/RiOmAr+kHBjERKD9vSrNyQjEYOfj2ngsr30LNXuexKHKI7paRq/Dq3zuSZDAi2pOn6fiEc5SC6Faj6uq4z0tZOO7T0I149bm72P8vR7RFWzcNtYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077335; c=relaxed/simple;
	bh=utN6QsNDW6/1TqW1p0nlc7DtEq5+tRszYxoklAIovMU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TNiUimF5rY5Qbb9F0fTRyleod1akFq1jULufTzrPL+i1ydQEfYnhk29s+1SpbS6x/0Bz5r+goaJ6TIBK0k+zC46GJCiC+UkhQ0qvQ+Ze0W1TcmN4uVG0ljPbE02Kn8BxbsNU6r3Q3xjJx2BgjSHuKKUYDpDK7PkK4/kX8JV4xr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0tm8/+1j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Re5Qxkcx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715077332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tx1iOx6iL5l8MnXbGHlbt/Ab5a5r6LT3B6HBF7AzDks=;
	b=0tm8/+1jYTneFfI0BPn5+TlMzbOBvCidrOzh5a622/jOg5yIE42VTHMjDqsNIfPsP3cGog
	2rAV2X34XlKEqxaINEOtfw/6Y9rg21NhgC5v7uo6PmQ0LqpaAdIZ2ZH84VkNDtGVZ5pdEi
	U72+fHxzmlsAlBv1fxMKyZ1aQYB5bjaVvO0vcUEKEC+DnlFwaosJwwALxRW+iX1ma6jcG3
	9Lx2c+nJr9Vv1xMpT7gyfYNfCp7iVFqb/ZyGRvCMnOHW0zLJ0ycxz+ZtRNgd5GKJhLAqqE
	vPm+7eqgZV9Pdq1Mh4ccywKbRjWqT8w+G+ojwOS5FE51caevdMIOFWvY9EJImw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715077332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Tx1iOx6iL5l8MnXbGHlbt/Ab5a5r6LT3B6HBF7AzDks=;
	b=Re5Qxkcx3puoOtE3LRIP40cllBQAurgDPM0Qn6knDzamk9GpqmEyoZ+rdvJmniy3P3Zf/2
	uAK9lH8EqD+DOLBw==
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/irqdomain: Clean code for __irq_domain_create()
In-Reply-To: <887d424c-c6b5-e5c7-21d3-9b920272fbc3@huawei.com>
References: <20240430093353.1919862-1-ruanjinjie@huawei.com>
 <87pltyrf9l.ffs@tglx> <887d424c-c6b5-e5c7-21d3-9b920272fbc3@huawei.com>
Date: Tue, 07 May 2024 12:22:12 +0200
Message-ID: <878r0lrkff.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 07 2024 at 09:22, Jinjie Ruan wrote:
> On 2024/5/7 2:01, Thomas Gleixner wrote:
>>> +out:
>>> +	domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
>>> +	return 0;
>> 
>> This function is horrible. The only shared thing here is the
>> domain->flags manipulation. I'm not seeing how this is an improvement.
>
> Yes, the IRQ_DOMAIN_NAME_ALLOCATED flag is shared, the purpose of this
> change is to make the code that allocates the domain name in the
> __irq_domain_create() function look like it doesn't take up too much
> space, so it looks cleaner.

I'm failing to see the cleaner. All this does is shuffling code around
for no reason.

Thanks,

        tglx

