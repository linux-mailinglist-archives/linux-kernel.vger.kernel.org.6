Return-Path: <linux-kernel+bounces-427891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E649E08C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8348FBA12E9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E0B208996;
	Mon,  2 Dec 2024 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=matoro.tk header.i=@matoro.tk header.b="XMVGxkWx"
Received: from matoro.tk (matoro.tk [104.188.251.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C05207A23;
	Mon,  2 Dec 2024 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.188.251.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153528; cv=none; b=e2MXhlhvlrZJwB0klH3GrP4ei+6n/NvlHzz0GRQVrZPh1s7WenYHZdSHfvwTFDrG7sfwrbl30l77/sjdBkYmrI+bmWRsULKYYjYNThj4/2HTGhJnqsqhMqvtWKPsQORY4D9On5k7kS7fRlXiECKcde8UO4Qqs5BDB+NTNR1ceKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153528; c=relaxed/simple;
	bh=JboAeFbBfaKvuYsLCqe9RRJrPmux2NsiIo9viIavLOU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VHVDIytCAhUliVxrVAfJIseBeq1m11eVo5oorQH6N08zI+XzGfH9YvYvIjAB1KQGDFNah4MDLHHdajjd8wdMUdNT8h0DodoNn3mSVmzxUXqb9G83TCoTIUtor0aPdvqxS++VswRc7nxGttedz5/qyogEyfVekZFlNvhd8S5WjX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=matoro.tk; spf=pass smtp.mailfrom=matoro.tk; dkim=pass (4096-bit key) header.d=matoro.tk header.i=@matoro.tk header.b=XMVGxkWx; arc=none smtp.client-ip=104.188.251.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=matoro.tk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matoro.tk
DKIM-Signature: a=rsa-sha256; bh=+3dr10krtlXBP5oVbtn7s4qwz6eEmKTbxTLPOCId09E=;
 c=relaxed/relaxed; d=matoro.tk;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@matoro.tk; s=20241120; t=1733153506; v=1; x=1733585506;
 b=XMVGxkWx1Y8G7efGg7fhqctqTZQ3jU64LTNBgtkpfU75OrkGN1Eq+YlmEPg/g4S3TCNcuZuY
 LLdw8gNkrNPg1ero7GiCLtMITlW/glkZEjkt6J3RhP8bocCzPdArrSi23WHSsdr9EuX3MX+KcHj
 ZRCg6mYbRKXBDEa3HuMMWINA5WWdmxgSmQ1L0GJ3UDycOCH1I0wIRu7fcZtycXsAooBbYkXIppO
 uh9YLzt8sM1GakZzafXQ+Wq1AJ/k5Ab79MJLsMYAwyoEoChzedAO+zHS/yiVAd39kx+VITqsYls
 tPdtuhyf233rqHihd8WerGHec0R2tch1blMXqsy4xV1K8J9ik6hbNcWAkawlYC3d8cAmZcUYVOw
 31t/kbaYW0Va3uL0UZr4Yf30A/UxkeNaaElWmcm3A1UcqkngV7xnEhDJuT0i6sweG6zwwqCZX5E
 4tlc8gIMx5caGXLOKAXfJaqPvg+R+vHqsd44dHVb+qMUrggKspu3ZJWpigVTrku/mCBBtru+EJz
 Vy9EV14T608PH2t9s9u7KCLGT4jMGT4opndRhjykTjygYK1xb58/fVYcMyR+FpPy7ZIozIHMpOd
 jqnJ6eQfumHimM/1unBod3Pr5TJ1AnDcHj9GroMbAsyV8WGDsqCAm9x+7IWoyLggO3YWZwBkJiy
 C3cS9IzP9AQ=
Received: by matoro.tk (envelope-sender
 <matoro_mailinglist_kernel@matoro.tk>) with ESMTPS id 08c597b6; Mon, 02 Dec
 2024 10:31:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 02 Dec 2024 10:31:46 -0500
From: matoro <matoro_mailinglist_kernel@matoro.tk>
To: John David Anglin <dave.anglin@bell.net>
Cc: Magnus Lindholm <linmag7@gmail.com>, Linux Parisc
 <linux-parisc@vger.kernel.org>, deller@kernel.org, Deller <deller@gmx.de>,
 Sam James <sam@gentoo.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Subject: Re: [bisected] ext4 corruption on parisc since 6.12
In-Reply-To: <03978220-0153-417c-8479-09239d19c9ba@bell.net>
References: <84d7b3e1053b2a8397bcc7fc8eee8106@matoro.tk>
 <31c884b9-77c8-48dc-b84c-20e52cdc4d44@bell.net>
 <71fae3d3a9bd816ea268eb73c152b564@matoro.tk>
 <CA+=Fv5Qy0818xS3uW2bh2nVpy-3COUzbq5X0JPY6=YzbfYgNOA@mail.gmail.com>
 <03978220-0153-417c-8479-09239d19c9ba@bell.net>
Message-ID: <9bdbf64bd63ab7eef2f5ead467f3c8c4@matoro.tk>
X-Sender: matoro_mailinglist_kernel@matoro.tk
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

On 2024-12-02 09:54, John David Anglin wrote:
> On 2024-12-02 1:30 a.m., Magnus Lindholm wrote:
>> On Mon, Dec 2, 2024 at 5:55 AM matoro
>> <matoro_mailinglist_kernel@matoro.tk> wrote:
>>> Hmm, this is my config, also on an rp3440:
>>> 
>>> #
>>> # Timers subsystem
>>> #
>>> CONFIG_HZ_PERIODIC=y
>>> # CONFIG_NO_HZ_IDLE is not set
>>> # CONFIG_NO_HZ is not set
>>> # CONFIG_HIGH_RES_TIMERS is not set
>>> # end of Timers subsystem
>>> 
>>> lindholm can confirm on their hardware/config.  Maybe you can try that and
>>> see if you can reproduce?  I will try your config as well.
>> Hi, I'm on a HPC8000 "parisc64 PA8800 (Mako) 9000/785/C8000". I can confirm
>> that building a kernel CONFIG_SMP=n will mitigate this problem.
>> I haven't messed around with the config in the Timer subsystem so in my 
>> case the
>> parameters suggested are unset. (my config looks like matoros)
> The clockevent driver was tested on both rp3440 and c8000, and some other 
> SMP machines.
> Helge knows details.  I have used it on rp3440 and c8000.
> 
> I would try my settings.  The primary reason in switching to the clockevent 
> drivers was to
> improve clock resolution.  The best resolution with the old drivers was 1 ms 
> at 1000 HZ.
> This caused problems with various package tests.  If config is the issue, 
> probably
> CONFIG_HIGH_RES_TIMERS needs to be forced when clockevent drivers are used.
> 
> Almost every other system uses the clockevent drivers.  So, there was a risk 
> that parisc would
> become unsupported.
> 
> I wonder if this could be caused by dead RTC battery.  Did you check output 
> of date command?
> Maybe a dead RTC battery interacts badly with clockevent drivers.
> 
> I run ntp on all my machines.
> 
> What files have bad dates (i.e., is this really a ext4 file system issue) or 
> is it just that system has
> a bad clock?
> 
> Dave

The files that have bad dates seem to be the ones /init on this system 
touches at early boot.  See the output here:  https://paste.matoro.tk/8cq8omg

When booted into the bad kernel, date(1) works and displays the correct time. 
  I'm using chrony for time syncing as well.

After switching to the config specified above, boot hangs before even getting 
to userspace with the following output:

[   12.473410] 0000:e0:01.1: ttyS2 at MMIO 0xfffffffff4050038 (irq = 73, 
base_baud = 115200) is a 16550A
[   12.757386] sym0: <1010-66> rev 0x1 at pci 0000:20:01.0 irq 70
[   12.761419] sym0: PA-RISC Firmware, ID 7, Fast-80, LVD, parity checking
[   12.885367] sym0: SCSI BUS has been reset.
[   12.889389] scsi host0: sym-2.2.3
[   13.053380] sym1: <1010-66> rev 0x1 at pci 0000:20:01.1 irq 71
[   13.055515] sym1: PA-RISC Firmware, ID 7, Fast-80, LVD, parity checking
[   13.165367] sym1: SCSI BUS has been reset.
[   13.169388] scsi host1: sym-2.2.3
[   13.208927] rtc-generic rtc-generic: registered as rtc0
[   13.281367] rtc-generic rtc-generic: setting system clock to 
2024-12-02T07:17:02 UTC (1733123822)
[   13.281367] NET: Registered PF_INET6 protocol family
[   13.281367] Segment Routing with IPv6
[   13.281367] In-situ OAM (IOAM) with IPv6
[   13.281367] registered taskstats version 1
[   13.281367] Unstable clock detected, switching default tracing clock to 
"global"
[   13.281367] If you want to keep using the local clock, then add:
[   13.281367]   "trace_clock=local"
[   13.281367] on the kernel command line

At the end there the clock seems to stop progressing forward, as there are 
several real-time seconds that elapse in between messages with the same 
timestamp.  So I'm completely unable to boot with this config at all.

