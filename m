Return-Path: <linux-kernel+bounces-346600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFB998C68A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F33E328451F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 20:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0568B1CDFDF;
	Tue,  1 Oct 2024 20:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Qn3nXBQ4"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3BE1CDFBE
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 20:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727813561; cv=none; b=pHg2PjFZTz1DubOzTQv6lGMku+pxHbHUpLHZEJuESCE0CFlP4SuIO/oo/j4alIldeyv4GZTbCOgPB2y5uDniScB7xRaV0JQS1HHkggiSxBnMSLZMzjWZtG+vXbKdI/N570bDv9VncnqDjTF78KTj5p/tu+9XgVfirdBoF+d5ebE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727813561; c=relaxed/simple;
	bh=fNMd55I0jHEAsYtrFtHgsnrb4aZsNwGt8uKcaSpO7Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ta83KYBggUFP6HDjFfwpErNm/gbxZQXyze4pyOL16tLn1gf/4crZk2EmKA2A3PbokAtVCjulmacJgYgs61VSsJEQeYNnKQU0KacJmIyH3God/ce9qLQFfYkyn6ljqTZwCN6xvq6Uf/0H1Fk4eQ1BR5WyiUovLsBurR7pVmQJxwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Qn3nXBQ4; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4XJ8Hj1f8Lz6ClY9Y;
	Tue,  1 Oct 2024 20:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1727813550; x=1730405551; bh=B+h7iFqSVAi5fs0yH/ytyIxY
	SNbRu5j0dDTVIbwQ3gs=; b=Qn3nXBQ4mxFdlO3RW379h4P2RUx4S1S5XzxEmG3c
	EM2zXhxpUKsq4DWGMms+hnAQsQeXoOP8nkJFECapW9cQelb4XquhyO78eM1JUer1
	1wRKwirYBqD7ZHT2TH/ylJ16q3hvW3bR0sYxfQujxooX8l37Of8+twOucdUynQo1
	7qrKLX65r5nKuLAp5EWGiMuj49hkNPGOGsE2XnxAMeWt2Bjr7nBwXEzkTW4l7FA/
	wPRu4IKK+Jo23AuG1Ar1jkz8pmcdFujcPqjtk2ok8Adee7xAg1dOPcLNYFVaqeZe
	FCxY/aLR9yK3z6edEWM3M7FoULRh5alsgUSGRiRYeVqLAA==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9kAoNow497kB; Tue,  1 Oct 2024 20:12:30 +0000 (UTC)
Received: from [100.66.154.22] (unknown [104.135.204.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4XJ8Hd607qz6ClY9V;
	Tue,  1 Oct 2024 20:12:29 +0000 (UTC)
Message-ID: <bd377620-7781-4b93-98c1-93f778b74724@acm.org>
Date: Tue, 1 Oct 2024 13:12:26 -0700
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
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <875xqcypds.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/1/24 5:33 AM, Thomas Gleixner wrote:
> On Mon, Sep 30 2024 at 11:15, Bart Van Assche wrote:
>> This patch prepares for changing 'nr_irqs' from an exported global
>> variable
> 
> git grep 'This patch' Documentation/process/

Is this the documentation that you are referring to? Anyway, I will 
change the patch description into the imperative mood. <quote>Describe
your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour.</quote>

>> into a variable with file scope.
> 
> Also what's the rationale for this?

Suppose that a patch would be submitted for review that removes a
declaration of a local variable with the name 'nr_irqs' and that does
not remove all assignments to that local variable. Such a patch converts
an assignment to a local variable into an assignment into a global
variable. If the 'nr_irqs' assignment is more than three lines away from 
other changes, the assignment won't be included in the diff context 
lines and hence won't be visible without inspecting the modified file.
This is why I mentioned in the cover letter that this change makes
patches easier to review. With this patch series applied, such
accidental conversions from assignments to a local variable into an
assignment to a global variable are converted into a compilation error.

>>   extern int nr_irqs;
>> +int number_of_interrupts(void) __pure;
>> +int set_number_of_interrupts(int nr);
> 
> Please use a proper name space prefix for the functions
> irq_.....(). These random names are horrible.

How about irq_count() and irq_set_count()?

>> +int number_of_interrupts(void)
>> +{
>> +	return nr_irqs;
> 
> Why is this int? The number of interrupts is strictly positive, no?

Yes, the number of interrupts is strictly positive. The return type
comes from the type of 'nr_irqs' and been chosen to minimize the risk of
the changes in this patch series. Anyway, I will audit the code that
reads and sets the global 'nr_irqs' variable to see whether its type can
be changed safely into 'unsigned int'.

Thanks,

Bart.



