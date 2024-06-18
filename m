Return-Path: <linux-kernel+bounces-219173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D84EB90CB7F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 162B7B258E3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62F91420BB;
	Tue, 18 Jun 2024 11:52:41 +0000 (UTC)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FAD13FD9F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718711561; cv=none; b=ZMelrKCV7sGDh7GIMFAolo7sKP++Qln6aUSPBCRQNfLf2rwMUC0UGUFLSgtSFTLInN3BJAgw85b8vDQvBK/+T055YqBzmysRmGVOv83mnxMBRnfHd/atRCvo2m1sIBvvyrbyVmDJKMBpheWiczb5rE3rqxLQSLEdoC4P9YdQZDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718711561; c=relaxed/simple;
	bh=ry3TqrT9h7jK8A5SjX+EQVSOg9/YHE19C/+4e6RIneg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zo+qjkdsGOj6Tb6+HmjW+614POANBwnd8FrFRJK3qYVIwjMkJqAqVZQqUzFw+2qkGonjtbMOC/4WMApYwJBqVNCalZtkKS78gPoiyUvCM8X4eki1CPo68IdGca1BTj8j3xihhJS9yKUifvmNJsnIFhjs2zw+Y6bxzL9n84eXKDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 47927E000B;
	Tue, 18 Jun 2024 11:52:36 +0000 (UTC)
Message-ID: <9268589d-9ccc-4cdd-9de2-5019407ef313@ghiti.fr>
Date: Tue, 18 Jun 2024 13:52:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] riscv: Fix local irq restore when flags
 indicates irq disabled
Content-Language: en-US
To: Andrea Parri <parri.andrea@gmail.com>
Cc: Xu Lu <luxu.kernel@bytedance.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230725070549.89810-1-luxu.kernel@bytedance.com>
 <mhng-a0239c56-385e-40a9-8a71-45d50e28b45d@palmer-ri-x1c9>
 <CAPYmKFvXf7q_8QzFe4VFL1s-j0P3ZGSZ8nG1q4HmtU4rzek77Q@mail.gmail.com>
 <CAPYmKFvqpe48zaLKrTz085cJcO9fwL+BtHujU4p48onR1Nodfw@mail.gmail.com>
 <329b22c6-435c-424a-8211-b9a029b0897d@ghiti.fr> <ZnFqDRXRjoHMaJXW@andrea>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <ZnFqDRXRjoHMaJXW@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Andrea,

On 18/06/2024 13:05, Andrea Parri wrote:
> (merging replies)
>
>>>> However, if local_irq_save() is called when irq is disabled. The SR_IE bit of
>>>> flag returned is clear. If some code between local_irq_save() and
>>>> local_irq_restore() reenables irq, causing the SR_IE bit of CSR_STATUS
>>>> back to 1, then local_irq_restore() can not restore irq status back to disabled.
> But doesn't that represent some bogus manipulation of the irq flags? cf.
>
> config DEBUG_IRQFLAGS
> 	bool "Debug IRQ flag manipulation"
> 	help
> 	  Enables checks for potentially unsafe enabling or disabling of
> 	  interrupts, such as calling raw_local_irq_restore() when interrupts
> 	  are enabled.
>
> in particular, raw_check_bogus_irq_restore() in raw_local_irq_restore().
>
>
>> This got lost but this is still correct and needed.
> You mean because of the mentioned rtl8723e example? are there other such
> instances?  IOW, why do you say that the changes in question are needed?


Simply because the scenario in this driver and I looked at the arm64 
implementation which restores flags unconditionally.

But if that's considered bogus, let's drop this. Sorry Xu for the noise, 
and thanks Andrea for pointing this.

Alex


>
>    Andrea

