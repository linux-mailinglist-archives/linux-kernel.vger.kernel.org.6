Return-Path: <linux-kernel+bounces-319462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C973F96FCD1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 22:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19650B279E6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 20:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB29156861;
	Fri,  6 Sep 2024 20:37:01 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB291B85DA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725655021; cv=none; b=EjA/qc2MopKomvWzjEUj/R3BNsEd9/KZJhFkQTejyB36pBDqM55w2dUOYOP+//hlRb9Kxt7gTysiB4Y7b6+e8WZX6eNQOBt+F7RvYdhV+LYZ1OCxQRf7G1R6nv+a+XowO3QDCNBv6pnKHnd+IpPd3jmvYSU4o+wwd50bCsmQGfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725655021; c=relaxed/simple;
	bh=jF+JxXLgBVmgTgH6Y5wMqWNV2mUy6xRkg+tW2uayMw0=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=c1t51kUUzON2MkGEPaJkukBLln8capOhiQNJNc1WEcWDNwLOcMXKW16rlvXkzwXazp6eZCNBS1+e9us1xVDfnzqnMe2zpo2MRkbSOrvvMzBrcsfazZYq2eio0IeIGzs2rdWSLZ503Z7yLMYsBrkGXUgSFLnQXaV8w8VQaaaThC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.75.14) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Fri, 6 Sep
 2024 23:36:47 +0300
Subject: Re: [PATCH] irqchip/gic: prevent buffer overflow in
 gic_ipi_send_mask()
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <048ff3bb-09d1-2e60-4f3b-611e2bfde7aa@omp.ru>
 <87cyli5zj7.ffs@tglx> <86o752v8xs.wl-maz@kernel.org>
 <f0efe812-a77b-9a77-c17c-ece503475923@omp.ru>
Organization: Open Mobile Platform
Message-ID: <b7d701e1-3cdd-3490-2ee1-70d96fa22703@omp.ru>
Date: Fri, 6 Sep 2024 23:36:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f0efe812-a77b-9a77-c17c-ece503475923@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/06/2024 20:17:39
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187598 [Sep 06 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 32 0.3.32
 766319f57b3d5e49f2c79a76e7d7087b621090df
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.75.14 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.75.14
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/06/2024 20:21:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/6/2024 7:13:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/6/24 11:29 PM, Sergey Shtylyov wrote:
[...]

>>>> ARM GIC arch v2 spec claims support for just 8 CPU interfaces.  However,
>>>> looking at the GIC driver's irq_set_affinity() method, it seems that the
>>>> passed CPU mask may contain the logical CPU #s beyond 8, and that method
>>>> filters them out before reading gic_cpu_map[], bailing out with
>>>> -EINVAL.
>>>
>>> The reasoning is correct in theory, but in reality it's a non problem.
>>>
>>> Simply because processors which use this GIC version cannot have more
>>> than 8 cores.
>>>
>>> That means num_possible_cpus() <= 8 so the cpumask handed in cannot have
>>> bits >= 8 set. Ergo for_each_cpu() can't return a bit which is >= 8.

[...]

>> 33de0aa4bae98, the affinity that the driver gets is narrowed to what
>> is actually *online*.
> 
>    What I haven't quite understood from my (cursory) looking at the GICv2
> spec (and the GIC driver) is why only one CPU (with a lowest #) is selected
> from *mask_val before writing to GICD_GIC_DIST_TARGET, while the spec holds

   Sorry, meant to type GIC_DIST_TARGET (or GICD_ITARGETSRn, as the spec
calls it)...

[...]

>> Thanks,
>>
>> 	M.

MBR, Sergey

