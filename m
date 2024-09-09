Return-Path: <linux-kernel+bounces-321990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7027B97227E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 21:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0662E283F18
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 19:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2AD189B81;
	Mon,  9 Sep 2024 19:23:34 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969B03B791
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 19:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725909814; cv=none; b=TmXb1RyePiwA8ob+LKKiqGLw/y0YI26tbCvIVo//naabd6XH6ZhU+hU+rxxI2lFh5YQTchZTGHUO1cotxW/QF81bnEOT7gL8sXPx1Y6oYNANGEgUZ+oTykin14xEbIJIygNjOOAng2KfXKNEo5+lTLI1pt4Px3NO80I1qfmOFjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725909814; c=relaxed/simple;
	bh=WxYA18Z9ULzrNShVdG9IgXbo4QUfxmI5AbCPKxUpit8=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DJ1qubapscAcWvB6no5uZeyay0NX1pIGWnANOzPGggOe7ZxNRlBkncFWBm6pnOnzhyg1FqbV9zsLLhJdE8pnNt/9JS4cMjt3O+WUM4GuJjlQ9ImCNEHTaMP+Xq4ZJV/O4pSBCB2kEIH4q21SGytoH9iuIUVn3FR+p/Gt6bmKbCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.106] (31.173.81.96) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 9 Sep
 2024 22:23:22 +0300
Subject: Re: [PATCH] irqchip/gic: prevent buffer overflow in
 gic_ipi_send_mask()
To: Thomas Gleixner <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>, Marc
 Zyngier <maz@kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <048ff3bb-09d1-2e60-4f3b-611e2bfde7aa@omp.ru>
 <87cyli5zj7.ffs@tglx>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <d1c2f362-da11-b17a-40ff-daecb5abf909@omp.ru>
Date: Mon, 9 Sep 2024 22:23:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87cyli5zj7.ffs@tglx>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/09/2024 18:56:08
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
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
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
X-KSE-Antiphishing-Bases: 09/09/2024 19:00:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/9/2024 4:30:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 9/5/24 10:29 AM, Thomas Gleixner wrote:
[...]

>> ARM GIC arch v2 spec claims support for just 8 CPU interfaces.  However,
>> looking at the GIC driver's irq_set_affinity() method, it seems that the
>> passed CPU mask may contain the logical CPU #s beyond 8, and that method

   s/8/7/, of course... :-<

>> filters them out before reading gic_cpu_map[], bailing out with
>> -EINVAL.
> 
> The reasoning is correct in theory, but in reality it's a non problem.

   Frankly, before finalizing this patch I had tried to ascertain whether
cpumask could contain CPUs with the logical #s higher than 8 but that was
taking way too much time and I gave up... :-)

> Simply because processors which use this GIC version cannot have more
> than 8 cores.

   And big.LITTLE not involved?

> That means num_possible_cpus() <= 8 so the cpumask handed in cannot have
> bits >= 8 set. Ergo for_each_cpu() can't return a bit which is >= 8.

   Perhaps adding WARN_ON() would make some sense though? :-)

> Thanks
> 
>         tglx

MBR, Sergey

