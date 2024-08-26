Return-Path: <linux-kernel+bounces-301983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B786E95F83F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 19:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D4491F235AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F426198A0B;
	Mon, 26 Aug 2024 17:37:39 +0000 (UTC)
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9150E6F2E0
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 17:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724693858; cv=none; b=gTPEl4w1N/2yR202uYRFymkzn4FGbofSgVxu7nugiuq2ZGhKMR0dFVc5BOnGL07Gsx+kUx3gyGO2WjR/CNJ6B/OEfvtgWbanNjVfxVubXreltqXqz7m23suZRlaf8L7wlfJWlW9ett9BQAMlSa/KlMTxWw1mMQSuXr0fJsy+gCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724693858; c=relaxed/simple;
	bh=9BYXXDe4j8/4SHr6WmCJ3CbjkPN8478KJwcMUdea9fk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhFjGi9QE8CEeuknm/FoEV5WqDR9KtiVPjBtOGQGTQ7Z7jO0koKtqMW/+OSXVmO2+VKvcQsop6dpWTjoZAW7+7hxexs07nRLIwjWCxKUJkWFNIR8MEAiWUI2jke/DV8T9Qfb7lH9UQHsRn0nEyGB17/qIriYltBeYgethyeMyQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 332B7C0008;
	Mon, 26 Aug 2024 17:37:31 +0000 (UTC)
Message-ID: <0e694f91-aaed-4412-a919-49779f37dabc@ghiti.fr>
Date: Mon, 26 Aug 2024 19:37:31 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -fixes] drivers: perf: Fix smp_processor_id() use in
 preemptible code
Content-Language: en-US
To: Nam Cao <namcao@linutronix.de>, Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
 Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240826165210.124696-1-alexghiti@rivosinc.com>
 <20240826173143.CxUkM4j0@linutronix.de>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240826173143.CxUkM4j0@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 26/08/2024 19:31, Nam Cao wrote:
> On Mon, Aug 26, 2024 at 06:52:10PM +0200, Alexandre Ghiti wrote:
>> As reported in [1], the use of smp_processor_id() in
>> pmu_sbi_device_probe() must be protected by disabling the preemption, so
>> simple use get_cpu()/put_cpu() instead.
>>
>> Reported-by: Nam Cao <namcao@linutronix.de>
>> Closes: https://lore.kernel.org/linux-riscv/20240820074925.ReMKUPP3@linutronix.de/ [1]
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Tested-by: Nam Cao <namcao@linutronix.de>
>
> I think this also needs:
> Fixes: a8625217a054 ("drivers/perf: riscv: Implement SBI PMU snapshot function")


Indeed, thanks for the tag!


>
> Best regards,
> Nam
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

