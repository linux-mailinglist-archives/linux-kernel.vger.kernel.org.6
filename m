Return-Path: <linux-kernel+bounces-322024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B804972302
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63DCA285056
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AA5189916;
	Mon,  9 Sep 2024 19:48:40 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BB818C31
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 19:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911320; cv=none; b=AEvhUJybcoi5ZOfoYVqZ4vJMsS39rW/ymEVpn7Cqy5HIpWHKMnlKF/LPTvlvMELg0QtxMShR/hFu2VMP5OT0PkUVodCebUJ+NpavEDak6RJWVMfY0q2Ygx0OHq9DjlmDu+iMUMt27cUX4Qa/lSajL1yhteGvo/x88pGcpfl8QzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911320; c=relaxed/simple;
	bh=KX2mqS5Z98wEgIpp7TBW4RVIeQg+9mkp6bZr2FfjkpY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=BbWI26WbWyA4MwBO8sWNB/uPyqo+w/BkhuTWmz6v5L8nraxivWY+5QMafFyJtpzxDKb9Jz0a2asyvbNfBXkecfya2/md+En+OslvlTiB9TBxw4oi0N3j3HnHZHXKlUgPPYHMWItNypRoRyayghkm1LgTcavE1H4J6//a/8YrYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.106] (31.173.81.96) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 9 Sep
 2024 22:48:26 +0300
Subject: Re: [PATCH] irqchip/gic: prevent buffer overflow in
 gic_ipi_send_mask()
To: Marc Zyngier <maz@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <048ff3bb-09d1-2e60-4f3b-611e2bfde7aa@omp.ru>
 <87cyli5zj7.ffs@tglx> <86o752v8xs.wl-maz@kernel.org>
 <f0efe812-a77b-9a77-c17c-ece503475923@omp.ru> <87wmjmv632.wl-maz@kernel.org>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <052d20d5-e8e4-3133-4fa0-1c026ffb4209@omp.ru>
Date: Mon, 9 Sep 2024 22:48:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87wmjmv632.wl-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/09/2024 19:29:02
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187638 [Sep 09 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.96 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.96 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.96
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/09/2024 19:32:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/9/2024 4:30:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/8/24 12:37 PM, Marc Zyngier wrote:
[...]

>>>>> ARM GIC arch v2 spec claims support for just 8 CPU interfaces.  However,
>>>>> looking at the GIC driver's irq_set_affinity() method, it seems that the
>>>>> passed CPU mask may contain the logical CPU #s beyond 8, and that method
>>>>> filters them out before reading gic_cpu_map[], bailing out with
>>>>> -EINVAL.
>>>>
>>>> The reasoning is correct in theory, but in reality it's a non problem.
>>>>
>>>> Simply because processors which use this GIC version cannot have more
>>>> than 8 cores.
>>>>
>>>> That means num_possible_cpus() <= 8 so the cpumask handed in cannot have
>>>> bits >= 8 set. Ergo for_each_cpu() can't return a bit which is >= 8.

[...]

>>> 33de0aa4bae98, the affinity that the driver gets is narrowed to what
>>> is actually *online*.
>>
>>    What I haven't quite understood from my (cursory) looking at the GICv2
>> spec (and the GIC driver) is why only one CPU (with a lowest #) is selected
>> from *mask_val before writing to GICD_GIC_DIST_TARGET, while the spec holds
>> that an IRQ can be forwarded to any set of 8 CPU interfaces...
> 
> Because on all the existing implementations, having more than a single
> target in GICD_ITARGETSRn results in all the targeted CPUs to be
> interrupted, with the guarantee that only one will see the actual
> interrupt (the read from GICC_IAR returns a value that is not 0x3ff),
> and everyone else will only see a spurious interrupt (0x3ff). This is
> because the distributor does not track which CPU is actually in a
> position to handle the interrupt.

   Ah! Previously I was only familiar with the x86 {I/O,local} APICs,
and my recollection was that they somehow manage to negotiate that
matter over the APIC bus... but my knowledge it pretty dated, I've
had almost no part in the x86 Linux development. :-(

> While this can be, under limited circumstances, beneficial from an
> interrupt servicing latency, it is always bad from a global throughput
> perspective. You end-up thrashing CPU caches, generating odd latencies
> in unsuspecting code, and in general with disappointing performance.
> 
> Thankfully, GIC (v1/v2) is a dead horse, and v3 doesn't have this
> particular problem (it replaced it with a bigger one in the form of
> 1:n distribution).

   GICv2 spec does talk about 1-N and N-N interrupt handling modes;
at the same time, I can't find such words in the GICv3/4 spec. :-)

   Thanks a lot for your explanations! Despite being involved in the
ARM dev't since 2008, I have a limited knowledge of the ARM low-level
things... :-(

> 	M.

MBR, Sergey

