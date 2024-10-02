Return-Path: <linux-kernel+bounces-347877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E835A98DFCA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 17:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C401287E9F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA00D1D0DE1;
	Wed,  2 Oct 2024 15:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bypDRX1B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Rw4N3VO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17061D0DEC
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727884186; cv=none; b=KNdYNQQz1LbmusDG5GQMHB2hRoenezgkxSo1RRWLCQdmgpERqPEQIo2uKeHYmRQ7oBJgr9cWJESeM7j7XxfbwtBOC7lvdGIDl61AFui+MtQ7QAwuBdFpbiffnnS/vdgwNGVKO/r+/xSAj5aIxYQ8PPWJL/+jyn59he2bNKIveAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727884186; c=relaxed/simple;
	bh=KzMN+mCpuuZKEWt2KvlnBzGAM3Xx3koXUsMzbwP1+i4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q+J1zs3hdwfPCKwrr80op3nSO8TOHIFjB/6T2wIVWOC+Vv9OhHgyL7U07WfZ/V/RaLL1/XYiro5J69eFF2EosH7WKVmrP8nfna7M4vVBbNJWeCABC35AKAI8awevo1+pPb6MUw/CRzYmQNRmK4f5xN3UhroWdh/Xyf3yqtUKNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bypDRX1B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Rw4N3VO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727884183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTrfLrZPlUo2RvGCfybUFlO3KL4ajpYO5JBnl8ZZcEE=;
	b=bypDRX1BFECRk1S/4tOeFbxEk3tzYDeuqGRXTmyOxEKX1FAIp59SbhYNqg6n1p7lojnQkt
	a0sDSd2vc7ipUx0F75BzP5xT2PCNSVeZpRk+TK6jbn+prWEPEXfzWFwNYcP+d0hWVsmT82
	ri+Xo9M2lQi8zs/ExMOMlyjalT+PFWjFUCJRTJv/LJVjFWftlafnG/JbcEB0Y30du14N7T
	CiplB3Yjb5PvS+QtfX7pVqO2H4iwwEM8lrOVLHc6B9gGs/UydGv2Oyli45hTjzJNuQ4g+W
	YRP3/UdXglll6S16WY9SPKj0ta2H0hK02P+K1IKvV7Jp/QC7KINAkriKGRnqhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727884183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZTrfLrZPlUo2RvGCfybUFlO3KL4ajpYO5JBnl8ZZcEE=;
	b=9Rw4N3VOrB5bV9mvacUCLEJ+b1y2rU4++pJKauIrJzy3hXWzXfFwcIMktC6lu32SSxZgXa
	Alv67htYKyoX4dAQ==
To: Bart Van Assche <bvanassche@acm.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King
 <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/21] genirq: Introduce number_of_interrupts() and
 set_number_of_interrupts()
In-Reply-To: <bd377620-7781-4b93-98c1-93f778b74724@acm.org>
References: <20240930181600.1684198-1-bvanassche@acm.org>
 <20240930181600.1684198-2-bvanassche@acm.org> <875xqcypds.ffs@tglx>
 <bd377620-7781-4b93-98c1-93f778b74724@acm.org>
Date: Wed, 02 Oct 2024 17:49:42 +0200
Message-ID: <87ikuawlm1.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Oct 01 2024 at 13:12, Bart Van Assche wrote:
> On 10/1/24 5:33 AM, Thomas Gleixner wrote:
>> On Mon, Sep 30 2024 at 11:15, Bart Van Assche wrote:
>>> This patch prepares for changing 'nr_irqs' from an exported global
>>> variable
>> 
>> git grep 'This patch' Documentation/process/
>
> Is this the documentation that you are referring to? Anyway, I will 
> change the patch description into the imperative mood. <quote>Describe
> your changes in imperative mood, e.g. "make xyzzy do frotz"
> instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
> to do frotz", as if you are giving orders to the codebase to change
> its behaviour.</quote>

Yes.

>>> into a variable with file scope.
>> 
>> Also what's the rationale for this?
>
> Suppose that a patch would be submitted for review that removes a
> declaration of a local variable with the name 'nr_irqs' and that does
> not remove all assignments to that local variable. Such a patch converts
> an assignment to a local variable into an assignment into a global
> variable. If the 'nr_irqs' assignment is more than three lines away from 
> other changes, the assignment won't be included in the diff context 
> lines and hence won't be visible without inspecting the modified file.
> This is why I mentioned in the cover letter that this change makes
> patches easier to review. With this patch series applied, such
> accidental conversions from assignments to a local variable into an
> assignment to a global variable are converted into a compilation
> error.

Can you please add that to the change log?

>>>   extern int nr_irqs;
>>> +int number_of_interrupts(void) __pure;
>>> +int set_number_of_interrupts(int nr);
>> 
>> Please use a proper name space prefix for the functions
>> irq_.....(). These random names are horrible.
>
> How about irq_count() and irq_set_count()?

Sure.

>>> +int number_of_interrupts(void)
>>> +{
>>> +	return nr_irqs;
>> 
>> Why is this int? The number of interrupts is strictly positive, no?
>
> Yes, the number of interrupts is strictly positive. The return type
> comes from the type of 'nr_irqs' and been chosen to minimize the risk of
> the changes in this patch series. Anyway, I will audit the code that
> reads and sets the global 'nr_irqs' variable to see whether its type can
> be changed safely into 'unsigned int'.

Thank you!

      tglx

