Return-Path: <linux-kernel+bounces-524675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BEAA3E5B0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29AD97AB3DE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674E61E9B25;
	Thu, 20 Feb 2025 20:19:11 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E728D1D5160
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082751; cv=none; b=uSOGGx1QRMgupBh4om70vPC5fnHnTRSl4gFsGxyuI56JNO2YiC1DpEsbNkrEwRrh1hv/beX1IibiPqUYLn3vUS78l60v9YSDjpO/bve3hfcAxYW7VsYvyP1y6/F/8MVto7Czcm7lbAtrdb+5qWU01GUaMpQLDJJUkAvBkZLOKB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082751; c=relaxed/simple;
	bh=6LJFzXXkSSPJ9SlpoWBIFIr+sZHFQrtuMRLPXUlLdWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PL3lSeib+HxH9w9B23Sms95/lD1qMZFIt2C1MljaCVU0kkmL3ebvOFyiBafbQ7AMh8QxT0QeDjIiKo+hxhoEp/NaAhzPdf/3Hhm0tgVxiGAXlWVXGEN1wYBbMspUbEBntC0wRvMflL3DlN4lqbHX6+kPvEGK6IZCPXtHqldfd9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af4e3.dynamic.kabel-deutschland.de [95.90.244.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0848F61E6479C;
	Thu, 20 Feb 2025 21:18:49 +0100 (CET)
Message-ID: <47903c9d-3949-43b3-8f27-d59db20acb1e@molgen.mpg.de>
Date: Thu, 20 Feb 2025 21:18:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux warns `sched: DL replenish lagged too much`
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <6ebe1130-0143-4388-9d69-ead0bf1fddf9@molgen.mpg.de>
 <Z7cvifR-y0CWK1e6@jlelli-thinkpadt14gen4.remote.csb>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <Z7cvifR-y0CWK1e6@jlelli-thinkpadt14gen4.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Juri,


Thank you for your quick reply.

Am 20.02.25 um 14:35 schrieb Juri Lelli:

> On 20/02/25 11:47, Paul Menzel wrote:

>> On the Intel Kaby Lake laptop Dell XPS 13 with Linux
>> 6.14.0-rc3-00060-g6537cfb395f3, waking it up from ACPI S3 with an LMP USB-C
>> mini dock connected, that had an Ethernet cable and a power adapter plugged
>> in, everything was lagging, and also the video in the opened Firefox Nightly
>> browser lagged quite a bit. This has happened in the past, but not that bad
>> and long. Today for the first time, Linux logged the warning below:
>>
>>      sched: DL replenish lagged too much
>>
>> (This is from `kernel/sched/deadline.c`.)
>>
>> I have no idea, if it’s related to the hardware itself, that causes it to
>> lag, that a suspend/resume cycle fixes, or if it’s related to the USB-C
>> controller that has bugs in that early generation, or if it’s related to
>> GNOME/Mutter (*mutter-common* 48~beta-3) or Firefox or the Web video player
>> used by the site.
>>
>> As often the case with this, I have no way to reliably reproduce it, and in
>> this case to reproduce the warning. I can only say, that this warning has
>> not been logged in the available log files since September 2024. Linux
>> “6.11-rc0” was used then. Please find the log messages attached.
>>
>> In case this information is not useful, should this happen again, it’d be
>> great if you could suggest what and how I should collect debugging
>> information next time.
> 
> Assuming no explicit usage of SCHED_DEADLINE, I would say the warning
> message might be related to the recently introduced deadline servers:
> 5f6bd380c7bd ("sched/rt: Remove default bandwidth control") and related
> commits.
> 
> They were merged in v6.12 (IIRC), though,

Indeed, it first appeared in v6.12-rc1.

> so I would expect you had noticed already before if they introduced
> issues on your setup? That said, it might also be the case that
> something else changed more recently that now triggers a corner
> case.

On this device, I sometimes experience lags after resuming from ACPI S3, 
and, although I cannot prove it, using USB-C mini docks (LMP USB-C mini 
Dock [1] or Dell DA300) seems to increase the chances of hitting the 
problem. Re-plugging and doing ACPI S3 suspend/resume again often helps.

> The warning message per-se it's not fatal, it just warns that the kernel
> is recovering from an unexpected situation. Did you notice that things
> went back to normal (no lag from a user perspective) right after that
> message was printed?

As far as I remember, the lagging stayed even after the log was printed. 
In this case, I had to reboot the device, and until now – with no ACPI 
S3 suspend/resume – it works fine.


Kind regards,

Paul


[1]: https://lmp-adapter.com/product/lmp-usb-c-mini-dock/

