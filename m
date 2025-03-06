Return-Path: <linux-kernel+bounces-548745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BE2A548CD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0362D172FCF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4FD20ADE6;
	Thu,  6 Mar 2025 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFi/bRhc"
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com [209.85.221.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6BF207DE2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259379; cv=none; b=RXMKoeux9CEI/J/jXRYjYUDTkbLwFMOeuxwKPl/Ri9HDixzSjq6QPLXBljMj4OQ7kOC32fftT1wRkscKQqBNdNcO+PFNncxDGmRmgYliFWV/fgo46/9ltzxelez6mY+o7DPNyHme95DN6DbnaU9mNSLSgGlw8fCkuM731R8BVo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259379; c=relaxed/simple;
	bh=pNwD/jCtSIx93BC08iWoA2Gl7Ec0p86LPlXEVkGvFZI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LIQJpaaxGppGZ1BBWVPtHuv9736pXwzTMQ7S7ztZZlO5R3y6BExMRobtVz80GvbUgDnQ7Wu3Vv4CsG3CW6rG02viouDLsc3+u3N6VFEGOj0LUAD09fFUq6DwzLpGyrfkcguiEoah2zk7b9aOAGQWKI4d1y6rQVsTHy1uiUqzXrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iFi/bRhc; arc=none smtp.client-ip=209.85.221.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f74.google.com with SMTP id ffacd0b85a97d-390e50c1d00so576849f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741259376; x=1741864176; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/dFYrb2sW0Ny4BYm+P6FPy8/gogBw8ybwCYFPW/5Wfc=;
        b=iFi/bRhcWL1uTWVB9DO+gCMUGIALNdgJWob/mBx7a4p2pW2898d71bJE37r4Yue30u
         2AqLSz5FUliDpL5cbQafeOWOwPogGXrXQ4Ka8D5hjr07gZojbDZm9B1KsVF8p+O9gN3e
         J63PfztOfmsRu0UqT0/89eh0JAE1uKgMN7yxLHDDr0cL0E91GSdQXMqoPgpW/x6IP2Ot
         LHIq5BqxWlPk3ye+PBESx7RLVVz6LPYg0HZlnyiCxfpvUOXj3yHQZHBEbHXLqQmcDM6A
         rVIKbUHsg7Id9f+dKPvoGEU3BbH7cMY6ydnAZ1+Z99/7yymJdOv85q6Fy1psvcf+/oHh
         Qkug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259376; x=1741864176;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/dFYrb2sW0Ny4BYm+P6FPy8/gogBw8ybwCYFPW/5Wfc=;
        b=eul9ow5lSvERaiUT25tnGVgCegHphs4ONw1Rrc/gHvdAx+/6FGnqkfrfqPZ9aW3Uva
         X+WS9oXhSEJ4ZTs5XkrmiqRMpMJHtukllb2K3bQK/53dQF4kYD1WLdiTIqLH8lCUkkOT
         PqQR3i2PEGGOaxy3oBRqdPDfzsZ1T6ypRk0C2sTmPdOCe2YjTb8lKMlIUNMu9AaJtugi
         x0uuG8UzfAWXy/ouS6zd3UCzmKb5gLwHC4fuRRoUlBGrt3pC5GCSQc9W2/ufJikCK4Dk
         nNfR9v4aRZJ3DzftI2ONlVoqqdn8SpNI0TgzPOJ0FuX+iaIbpDpYiwPJAGk1CMP4eS7n
         SVCw==
X-Forwarded-Encrypted: i=1; AJvYcCV/15grK265+j8FeZuWA0OyI23gavPX0i4nnkQ13n4nt25eWJDtGaQYLWX0imXd3H7fLmVKxCp4vy4uohY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLlGcpRiJJz3Glr0hPYsBSeRyJL6Hgp8If56ymI6zCmpg/jgt7
	2DjH4qMs5kRtpE7PKcRvxfjU3brH4TR00bOT9Jorw87ziS1K/p/xy4eHyCgOskae4Uw6cUfNv9i
	RiIZ/eNXu/yUf0w==
X-Google-Smtp-Source: AGHT+IGQlRF5ezfZt1wPiVd1C9EMKt6NF+Jo3FrWA4EBhp3pS1use0qAKsHwAt88E/Nw+wGskfdJ4hSuXHpuJoA=
X-Received: from wrbef7.prod.google.com ([2002:a05:6000:2187:b0:38f:451d:8e9b])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:47a4:0:b0:391:1473:2a08 with SMTP id ffacd0b85a97d-3911f724cd6mr5943042f8f.7.1741259375699;
 Thu, 06 Mar 2025 03:09:35 -0800 (PST)
Date: Thu, 6 Mar 2025 11:09:33 +0000
In-Reply-To: <Z8iFeEWq16pNQdMa@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Z8g8vhS9rqQ_ez48@google.com> <Z8iFeEWq16pNQdMa@pluto>
Message-ID: <Z8mCbc2Z2QGd3f8M@google.com>
Subject: Re: [Bug report] Memory leak in scmi_device_create
From: Alice Ryhl <aliceryhl@google.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, 
	arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 05, 2025 at 05:10:16PM +0000, Cristian Marussi wrote:
> On Wed, Mar 05, 2025 at 11:59:58AM +0000, Alice Ryhl wrote:
> > Dear SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/SCMI) Message
> > Protocol drivers maintainers,
> > 
> > I flashed a v6.13-rc3 kernel onto a Rock5B board and noticed the
> > following output in my terminal:
> > 
> > [  687.694465] kmemleak: 4 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> > 
> > It seems that there is a memory leak for devices created with
> > scmi_device_create.
> > 
> `
> Hi Alice,
> 
> thanks for this report.
> 
> > This was with a kernel running v6.13-rc3, but as far as I can tell, no
> > relevant changes have landed since v6.13-rc3. My tree *does* include
> > commit 295416091e44 ("firmware: arm_scmi: Fix slab-use-after-free in
> > scmi_bus_notifier()"). I've only seen this kmemleak report once, so it's
> > not happening consistently.
> > 
> > See below for the full kmemleak report.
> > 
> > Alice
> > 
> > $ sudo cat /sys/kernel/debug/kmemleak
> > unreferenced object 0xffffff8106c86000 (size 2048):
> >   comm "swapper/0", pid 1, jiffies 4294893094
> >   hex dump (first 32 bytes):
> >     02 00 00 00 10 00 00 00 c0 01 bc 03 81 ff ff ff  ................
> >     60 67 ba 03 81 ff ff ff 18 60 c8 06 81 ff ff ff  `g.......`......
> >   backtrace (crc feae9680):
> >     [<00000000197aa008>] kmemleak_alloc+0x34/0xa0
> >     [<0000000056fe02c9>] __kmalloc_cache_noprof+0x1e0/0x450
> >     [<00000000a8b3dfe1>] __scmi_device_create+0xb4/0x2b4
> >     [<000000008714917b>] scmi_device_create+0x40/0x194
> >     [<000000001818f3cf>] scmi_chan_setup+0x144/0x3b8
> >     [<00000000970bad38>] scmi_probe+0x584/0xa78
> >     [<000000002600d2fd>] platform_probe+0xbc/0xf0
> >     [<00000000f6f556b4>] really_probe+0x1b8/0x520
> >     [<00000000eed93d59>] __driver_probe_device+0xe0/0x1d8
> >     [<00000000d613b754>] driver_probe_device+0x6c/0x208
> >     [<00000000187a9170>] __driver_attach+0x168/0x328
> >     [<00000000e3ff1834>] bus_for_each_dev+0x14c/0x178
> >     [<00000000984a3176>] driver_attach+0x34/0x44
> >     [<00000000fc35bf2a>] bus_add_driver+0x1bc/0x358
> >     [<00000000747fce19>] driver_register+0xc0/0x1a0
> >     [<0000000081cb8754>] __platform_driver_register+0x40/0x50
> > unreferenced object 0xffffff8103bc01c0 (size 32):
> 
> I could not reproduce on my setup, even though I run a system with
> all the existent SCMI protocols (and related drivers) enabled (and
> so a lot of device creations) and a downstream test driver that causes
> even more SCMI devices to be created/destroyed at load/unload.
> 
> Coming down the path from scmi_chan_setup(), it seems something around
> transport devices creation, but it is not obvious to me where the leak
> could hide....
> 
> ...any particular setup on your side ? ...using LKMs, loading/unloading,
> any usage pattern that could help me reproduce ?

I looked into this a bit more, and actually it does happen consistently.
It's just that kmemleak doesn't report it until 10 minutes after
booting, so I did not notice it.

As for my setup, well, I boot the kernel over pxe and the rootfs is
mounted over NFSv4. The memory leak happens even if I don't do anything
at all - I just boot and wait. The device is a Radxa Rock5B.

Not sure what other information there is to give.

I tried again with v6.14-rc5, and I still got the leak:

user@rk3588-ci:~$ sudo cat /sys/kernel/debug/kmemleak
unreferenced object 0xffffff81068c0000 (size 2048):
  comm "swapper/0", pid 1, jiffies 4294893128
  hex dump (first 32 bytes):
    02 00 00 00 10 00 00 00 40 a3 7a 03 81 ff ff ff  ........@.z.....
    60 c8 79 03 81 ff ff ff 18 00 8c 06 81 ff ff ff  `.y.............
  backtrace (crc 60df30fb):
    kmemleak_alloc+0x34/0xa0
    __kmalloc_cache_noprof+0x1e0/0x450
    __scmi_device_create+0xb4/0x2b4
    scmi_device_create+0x40/0x194
    scmi_chan_setup+0x144/0x3b8
    scmi_probe+0x51c/0x9fc
    platform_probe+0xbc/0xf0
    really_probe+0x1b8/0x520
    __driver_probe_device+0xe0/0x1d8
    driver_probe_device+0x6c/0x208
    __driver_attach+0x168/0x328
    bus_for_each_dev+0x14c/0x178
    driver_attach+0x34/0x44
    bus_add_driver+0x1bc/0x358
    driver_register+0xc0/0x1a0
    __platform_driver_register+0x40/0x50
unreferenced object 0xffffff81037aa340 (size 32):
  comm "swapper/0", pid 1, jiffies 4294893128
  hex dump (first 32 bytes):
    5f 5f 73 63 6d 69 5f 74 72 61 6e 73 70 6f 72 74  __scmi_transport
    5f 64 65 76 69 63 65 5f 72 78 5f 31 30 00 ff ff  _device_rx_10...
  backtrace (crc 8dab7ca7):
    kmemleak_alloc+0x34/0xa0
    __kmalloc_node_track_caller_noprof+0x234/0x528
    kstrdup+0x48/0x80
    kstrdup_const+0x30/0x3c
    __scmi_device_create+0xd4/0x2b4
    scmi_device_create+0x40/0x194
    scmi_chan_setup+0x144/0x3b8
    scmi_probe+0x51c/0x9fc
    platform_probe+0xbc/0xf0
    really_probe+0x1b8/0x520
    __driver_probe_device+0xe0/0x1d8
    driver_probe_device+0x6c/0x208
    __driver_attach+0x168/0x328
    bus_for_each_dev+0x14c/0x178
    driver_attach+0x34/0x44
    bus_add_driver+0x1bc/0x358
unreferenced object 0xffffff810379c860 (size 16):
  comm "swapper/0", pid 1, jiffies 4294893128
  hex dump (first 16 bytes):
    73 63 6d 69 5f 64 65 76 2e 32 00 03 81 ff ff ff  scmi_dev.2......
  backtrace (crc ccc21b9a):
    kmemleak_alloc+0x34/0xa0
    __kmalloc_node_track_caller_noprof+0x234/0x528
    kvasprintf+0x90/0x11c
    kvasprintf_const+0x98/0x138
    kobject_set_name_vargs+0x68/0x104
    dev_set_name+0x6c/0x98
    __scmi_device_create+0x17c/0x2b4
    scmi_device_create+0x40/0x194
    scmi_chan_setup+0x144/0x3b8
    scmi_probe+0x51c/0x9fc
    platform_probe+0xbc/0xf0
    really_probe+0x1b8/0x520
    __driver_probe_device+0xe0/0x1d8
    driver_probe_device+0x6c/0x208
    __driver_attach+0x168/0x328
    bus_for_each_dev+0x14c/0x178
unreferenced object 0xffffff8105be7400 (size 512):
  comm "swapper/0", pid 1, jiffies 4294893128
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff c0 b4 f0 83 c0 ff ff ff  ................
  backtrace (crc 7b92a969):
    kmemleak_alloc+0x34/0xa0
    __kmalloc_cache_noprof+0x1e0/0x450
    device_add+0x54/0x570
    device_register+0x20/0x30
    __scmi_device_create+0x184/0x2b4
    scmi_device_create+0x40/0x194
    scmi_chan_setup+0x144/0x3b8
    scmi_probe+0x51c/0x9fc
    platform_probe+0xbc/0xf0
    really_probe+0x1b8/0x520
    __driver_probe_device+0xe0/0x1d8
    driver_probe_device+0x6c/0x208
    __driver_attach+0x168/0x328
    bus_for_each_dev+0x14c/0x178
    driver_attach+0x34/0x44
    bus_add_driver+0x1bc/0x358

