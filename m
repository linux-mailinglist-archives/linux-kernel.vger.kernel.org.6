Return-Path: <linux-kernel+bounces-564433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6D3A654EF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 16:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0F981631F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA82441AF;
	Mon, 17 Mar 2025 15:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="IxJUohvI"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D421C194
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742223798; cv=none; b=EWyyLbhiT1YTEb0ww5K6weFMnMZ7I/V2ggLAUcDZQekT/4eFWlIIalrmVYC7HwBCnGTEyfbhuPlOc756RVfCI33CapqSk9Uhv2Mh60i9ah6JLJmy/O4PVwImfL0AAt6gaa1FFZhgMkNU+l0x6WQp+9se7xgUHHO4Kybq7cf+D8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742223798; c=relaxed/simple;
	bh=BJnPB9PlojBDzwxQ759MoXiwvQbps86TN1IzXSjk2E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uNeGDcK3AI3cAd0zwSDXAejNk70L6YbbNaytL7GkjxDOLSgt0qo/uSVOquiwB7k/mHxkIEVP4GwRsy99oKRy83UAp1+N94lGfKzQqRLqlanvrMExdwSyUue3/igVLRy5wCJ5Atzdoserwg5pQjrjOP1NIoYhgBeX5cmJX8ZqgN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=IxJUohvI; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EOc691QsiwAedy674oG8RoRz/nnFwbHp2DWBmCbfVyo=; b=IxJUohvILj07//NhWwhQpqi5SV
	q2MPpxYZvl+OpAtQtdmw0apgShzm1U0hpRIjwO1u6oLYkJccNUk2OOymS3bBHlFTS63CV2ExUzr6n
	opakZmNj1o5bG2vpzVS9qQo0bvyLAVor9MG2XttC0uQBvnKQrARH8U5UCsWym8Py63Cuv0ubaereC
	Rpdq4UdJs5bpa+UlNbGjse6ELZH6wprSIhB8oXajuKMoWzvAgTDTWWazQROqjRcM9dL0oNMVrfz2i
	Ok295vbM56gqaZbI446VEr5jOETyjzr9HeSjgfvz3Fq1SQ9wnzJXjhQ4NG6DNV4SC1OOsyqb14/Zh
	7PhKaX+w==;
Received: from [187.90.172.172] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1tuBze-002HEv-L4; Mon, 17 Mar 2025 16:03:07 +0100
Message-ID: <eaef4f28-5531-f8b6-1c29-7a225715012f@igalia.com>
Date: Mon, 17 Mar 2025 12:03:02 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/tsc: Add debugfs entry to mark TSC as unstable after
 boot
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
 mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
 kernel@gpiccoli.net, kernel-dev@igalia.com
References: <20250226132733.58327-1-gpiccoli@igalia.com>
 <20250317144028.GEZ9g0XPSkOQU7A-nO@fat_crate.local>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20250317144028.GEZ9g0XPSkOQU7A-nO@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Boris! Thanks for the attention, responses below.

On 17/03/2025 11:40, Borislav Petkov wrote:
> On Wed, Feb 26, 2025 at 10:27:13AM -0300, Guilherme G. Piccoli wrote:
>> Right now, we can force the TSC to be marked as unstable through
> 
> Who's "we"?

We as in we, the Linux users. I can change to something like "Right now,
TSC can be marked as unstable" - let me know your preference =)


> 
>> boot parameter. There are debug / test cases though in which would
> 
> Which are those test cases?
>

For example, my team and I debugged recently a problem with
TSC+sched_clock: after TSC being marked as unstable by the watchdog,
sched_clock continues to use it BUT the suspend/resume TSC routines stop
being executed; for more details, please check [1]. But the thing is:
during this debug we tried forcing TSC unstable, and did that by
changing the command-line.

Problem: with that, tracing code sets its clock to global on boot time.
We were suspicious that the issue was related to local trace clock, so
we couldn't mark TSC unstable and let the trace code run with local
clock as it would, if TSC was marked as unstable by the watchdog late on
runtime.

That was one case (easily "workarounded" with trace_clock=), but in the
end, I thought that would be way better to just have this switch on
debugfs to be able to reproduce real-life TSC cases of instability,
while system runs. Hope that explains better my reasoning for adding
this debugs entry.


>> be preferable to simulate the clocksource watchdog behavior, i.e.,
>> marking TSC as unstable during the system run. Some paths might
>> change, for example: the tracing clock is auto switched to global
>> if TSC is marked as unstable on boot, but it could remain local if
>> TSC gets marked as unstable after tracing initialization.
>>
>> Hence, the proposal here is to have a simple debugfs file that
>> gets TSC marked as unstable when written.
> 
> What happens if someone marks the TSC as unstable and comes reporting to us
> that her/his machine is kaputt? And we go on a wild goose chase ...
> 

The same that happens if today someone marks it as unstable via
command-line, right? You will see that on logs, and could simply reply
that the user marked as unstable themselves, so..no bug at all!!

But let's think the other way around: what if some user marks TSC
unstable via debugfs, later on runtime, and with that, unveils a real
bug as [1] and then, we can then fix it? That would be a win heheh
Cheers,


Guilherme


[1]
https://web.git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=sched/core&id=d90c9de9de2f1712df56de6e4f7d6982d358cabe

