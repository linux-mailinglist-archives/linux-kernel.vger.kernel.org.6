Return-Path: <linux-kernel+bounces-349559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E602B98F86A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3301F230CA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 21:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC981ABEA7;
	Thu,  3 Oct 2024 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="LfLJ4zSc"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E4512BF32
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989445; cv=none; b=Z2c6x7OVvWwf1NrZqk912+MvVPSzaAKsIajCWDvs4OuCWMO/zlaxlyRShyDt51nusrl8JjaY5ZijHwvSQj9D80uvu7r2+xpN14Zk9LV6Bj0FZhCcQqtfClpyFS1RlEwV9508bWwDUzg/VYhIEB6sXRNAWJ1lN6GIYKGa3S9EE9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989445; c=relaxed/simple;
	bh=d+EGOvf3j7zDZDDOeSc6phtQ3f1z/cJ/Nfa1S1FPqtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NX0SpjpKRJBoLZcJsvQEHL5mrP+hGtelm2XOPgyULU/d5Er1U20gTTDuMkRa3qejtuc+LtaeowizW1kMcNDWCfcbHHWz1U/XOM2ADST2hT3KDm+gkOLS5RkRTmgvE/m9j1OCM2ooFU3jzZOhZL6Xxc4N+eWBAA+YMp6csncX2wE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=LfLJ4zSc; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XKPH23MGcz6ClY9l;
	Thu,  3 Oct 2024 21:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1727989276; x=1730581277; bh=7/osrRoVHM/TvCOSzQ45c2QD
	hn33bgw9QDaYPkG0Rx4=; b=LfLJ4zScXXzAXKbTSbXP6/BOMtdacmv6u9OCICgh
	F+22pHe8Lxi1ncIZWYQFm9M0Gazocr8y2gFpHclbyn8EOX0CkGGmot5eQZCaBZwF
	KSsrVUcTGElRGHjgkl1A24/7W4AoGLkHbKpraZDe9/mHPw5Qn+EmkI7W6HJv9l9y
	plgJ9FcPu2UY+47MUX80sNIf2KZxP8sftEdM0CsAmmAI4IGMMyNOoCqMO7hJJINR
	d1MWrTrUTRU/11bBxELQuC2IOQyWW+IaejPp/T45y7Ld5ns/0SLJgYmWn1rpiqEx
	cCmlfcNaiZy23Il28Yy7Iv1Xy/SzzHiFmzwUXY/PhM0+wg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 6h5daKYvn5kH; Thu,  3 Oct 2024 21:01:16 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XKPGz0zg2z6ClY9W;
	Thu,  3 Oct 2024 21:01:14 +0000 (UTC)
Message-ID: <b4eabf2f-5c88-4d36-89e3-d27cda0eef36@acm.org>
Date: Thu, 3 Oct 2024 14:01:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/21] genirq: Introduce number_of_interrupts() and
 set_number_of_interrupts()
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
References: <20240930181600.1684198-1-bvanassche@acm.org>
 <20240930181600.1684198-2-bvanassche@acm.org> <875xqcypds.ffs@tglx>
 <bd377620-7781-4b93-98c1-93f778b74724@acm.org> <87ikuawlm1.ffs@tglx>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <87ikuawlm1.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/2/24 8:49 AM, Thomas Gleixner wrote:
> On Tue, Oct 01 2024 at 13:12, Bart Van Assche wrote:
>> On 10/1/24 5:33 AM, Thomas Gleixner wrote:
>>> On Mon, Sep 30 2024 at 11:15, Bart Van Assche wrote:
>>>> into a variable with file scope.
>>>
>>> Also what's the rationale for this?
>>
>> Suppose that a patch would be submitted for review that removes a
>> declaration of a local variable with the name 'nr_irqs' and that does
>> not remove all assignments to that local variable. Such a patch converts
>> an assignment to a local variable into an assignment into a global
>> variable. If the 'nr_irqs' assignment is more than three lines away from
>> other changes, the assignment won't be included in the diff context
>> lines and hence won't be visible without inspecting the modified file.
>> This is why I mentioned in the cover letter that this change makes
>> patches easier to review. With this patch series applied, such
>> accidental conversions from assignments to a local variable into an
>> assignment to a global variable are converted into a compilation
>> error.
> 
> Can you please add that to the change log?

I will do that.

>>>>    extern int nr_irqs;
>>>> +int number_of_interrupts(void) __pure;
>>>> +int set_number_of_interrupts(int nr);
>>>
>>> Please use a proper name space prefix for the functions
>>> irq_.....(). These random names are horrible.
>>
>> How about irq_count() and irq_set_count()?
> 
> Sure.

I just noticed that a macro with the name irq_count() already exists.
How about the names irq_get_nr_irqs() and irq_set_nr_irqs() instead?

Thanks,

Bart.


