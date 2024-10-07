Return-Path: <linux-kernel+bounces-352674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B3399227E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 02:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49F51F218FE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 00:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD1BD520;
	Mon,  7 Oct 2024 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="08ZPEBQn"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE54B641
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728261914; cv=none; b=Ya81YMHNX5gDVBJKWn2ysXLN8eKBczwauEDWBYpw7JljpBKY8REjh5mBi6iNkAvpnJEDuhizsRN1CH/A6O6bq/+onecWciBD4V77h0gjmgbY1fCI67bnWOmEkj5irdmk7W2a6SgW8EXyHGFV/g9ttIFx3irh6U5FcCUGK7zqErE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728261914; c=relaxed/simple;
	bh=qm0lYxInDYdP21GpTnJgrtMG4C2lGQ832g/0lJU2BGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NguPmcMl4ZsYPdMgai/KFZgZmx/l0NJMquLyfvY16Xz5GM1byoT4U5LCwNw8lW9gPfg8ufbIpZ3gYJLRKQsTyaC5AZLHbjUhDBzYP+MJIkpsIXUsSckno1HaJC8g5MkkYAN1163AsxWL+ZVUB6v1Rpsgn7lCIPH1JBSJF4GysUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=08ZPEBQn; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4XML5t5XLJzlgTWP;
	Mon,  7 Oct 2024 00:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1728261904; x=1730853905; bh=6va03PNeHC0qODKPtqd2V6pf
	2tZQQzaG5Wkz6Cvk8C4=; b=08ZPEBQnu9ACAdiQGgjFm5bspt/v4pT8sAiLWzTA
	o3kc9jphK+E5wQB6OcdvGP+G2s+DBOEmAdGEwsvBi4JdkzM9RV+nVhd2eQVfChdE
	HejQtBNIfsW81yhI8r8frHqFQ08oEDfMIYrH2P0ma+mNgLaE1bqmw3oGfSOkG2Sl
	OfB0lo/3ZZhKefWi1qNtIrdm20qjnibqyeAwItucDOKp/25cl46/eQ6VJrWAdd/C
	PBpY6c9c+aNznLZCe6atweIYVVMtshNyY3L3smIM3rd3oLRMJYgSTuZ1B2Ad8Qy8
	9kOeobpLcQepQ3F889Qm+Y8xxHcIiVRSsMQ4Tg9GwxRSrA==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id hhRRpo0xX_dG; Mon,  7 Oct 2024 00:45:04 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4XML5q3SnNzlgTWM;
	Mon,  7 Oct 2024 00:45:03 +0000 (UTC)
Message-ID: <cb045717-5eb8-456f-aa50-667e9f8aabfd@acm.org>
Date: Sun, 6 Oct 2024 17:45:02 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/21] hpet: Switch to number_of_interrupts()
To: David Laight <David.Laight@ACULAB.COM>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Russell King <linux@armlinux.org.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Clemens Ladisch <clemens@ladisch.de>
References: <20240930181600.1684198-1-bvanassche@acm.org>
 <20240930181600.1684198-8-bvanassche@acm.org>
 <b315cbe2e1264d98b57ce57fe5f66a23@AcuMS.aculab.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b315cbe2e1264d98b57ce57fe5f66a23@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/6/24 10:13 AM, David Laight wrote:
> From: Bart Van Assche
>> Sent: 30 September 2024 19:16
>> --- a/drivers/char/hpet.c
>> +++ b/drivers/char/hpet.c
>> @@ -195,7 +195,7 @@ static void hpet_timer_set_irq(struct hpet_dev *devp)
>>   		v &= ~0xffff;
>>
>>   	for_each_set_bit(irq, &v, HPET_MAX_IRQ) {
>> -		if (irq >= nr_irqs) {
>> +		if (irq >= number_of_interrupts()) {
>>   			irq = HPET_MAX_IRQ;
>>   			break;
>>   		}
> 
> This is horrid.
> You've replaced the read of a global variable (which, in some cases the
> compiler might be able to pull outside the loop) with a real function
> call in every loop iteration.
> 
> With all the mitigations for cpu speculative execution 'issues' you
> pretty much don't want trivial function calls.
> 
> If you are worried about locals shadowing globals just change one of the names.

Since HPET_MAX_IRQ == 32 and since the lower 16 bits of 'v' are cleared
on modern systems, would it be such a big deal if number_of_interrupts()
is called 16 times?

Since number_of_interrupts() has been marked as __pure, and since the
kernel is built with -O2, do you agree that this should be sufficient to
let the compiler CSE optimization step move function calls like the
above from inside a loop out of the loop?

Thanks,

Bart.

