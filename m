Return-Path: <linux-kernel+bounces-546731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D94A4FE1F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9FB617349F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 12:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5924224293C;
	Wed,  5 Mar 2025 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oT2aPgLB"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2525243361
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176003; cv=none; b=DP9vQkf2h/41yITZ3VJwqi8U2+tY+ICfdf7Sp7tdVLdSv8L/JTIzGfTDh72XMptZp6k37vZ6LIn24aNU9+xg/u2b2xtQqBUqJfY1KxKUIDz+aIWD1pQkua00xQLy7+Y8JGLgpbHH8u5YHT3Vb8e1ON9PMZVCFDTI6ql4npC89/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176003; c=relaxed/simple;
	bh=S3yywfLU2jBCwtpObciQg//2fXcEYPd0gB20atqKbaU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K5orH1h3ZA729GdT2vnNgD7fXZ1Ou5cm1kCIBlBBgpM0mAWiDktWs5YrKvHnTYfneYrobIchfrkv77Awj7YYfTHZGRCa4PMzrnBX0lABYrYT0DVGs3E6MBfrLNz7rvpMGibXg9yyb42oeGytMly4U6cqa+EF4ROiswRy6K9Ro9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oT2aPgLB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ab5baf62cso49034995e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 04:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741176000; x=1741780800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nxrQLrve5ZYCaqi57EKV0xP1vwlYg25qE1yTCds7PDM=;
        b=oT2aPgLBlGo1m3kzcC3jwe/CEDX2GOuttRzRHWcHcPZcZOvlG5xwXu3cMXj9om0MIl
         oBUhmY+bmJNX1/A1P4/XHp7/Rt+dvxK+HFtAQu9S2UTKSSgSHZ5pqHvahDWC17eDy2GV
         KUep/6hAWUpq/vckqJhquWZs1pe0dnHiBpDGQRGTSB68q+5HPb00fh4ua0+cbrS40hyi
         vkDLebGQdbnbUbM/Jf6/ANcfZpUUopDoioB/rfGeEdNfAVdFKrDdaVffzSvg2jII0sxQ
         tUwAjLoSPyQZq49HI1L9Vvf1P2Vd2WVkbwXFlS+FchSgWzo5B5xAWnHVHecTaI2GWx+b
         SGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741176000; x=1741780800;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxrQLrve5ZYCaqi57EKV0xP1vwlYg25qE1yTCds7PDM=;
        b=uLfjyLTHG6VW7xvS7+/POd4PspnS0eVAcm+lr+IRotgj4rQV/9yulNYl0JQyEen7Pp
         26tapIv8eadUzSb9c73sjLSfdkR8rkB8YhHSZjzxR3Xt2qLUqxULPA1rJorwKQDwy9WS
         i1Ngdbm7SIDtTbXIribqSqD6d4olgg55+rD4but/vD1sWm8JNevzWjySQqLPEQswRQoq
         t2DfzbiCTKiqSsJrmv8oAudodDyYM+utWiwEDFz3Iq0YOrpNoDYq6G8U5ylbGM00K6ki
         azBHjbyQZ/7uyr38IrdUdv78BbddVVl4UL3Hb7RL8JjtvEk4AkCHLSFQx0p5tH4DYujP
         bwHg==
X-Forwarded-Encrypted: i=1; AJvYcCW8TXLZUfJEE2qaGkDTkFtcc69zl7wRyADCXn0YxxZuQRMEX6oJIAOFxPIBvrK2fPx65TQ361hq1GiOSHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGu+651GCoMM/JaZ80evEaidQGh9AGDnACuXQwm1xKuIWVJGeP
	yu22jjnI0uQHHDBnpRy50pD6HsK/CuyYDNCvlxlCcbiQfSY6Ps1/WP9nLLXYPdS/Dvvr8kzhZkI
	q5+ggIdI4x9ylEA==
X-Google-Smtp-Source: AGHT+IEp4F4FRlg80to2EP2sY+4qO0ru8U+D3wg9quZRpyNms8E1gnkZpcYcpd3+IIhL0cRuubq1VuG2e9urz9g=
X-Received: from wmqa15.prod.google.com ([2002:a05:600c:348f:b0:43b:bfff:e091])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fd2:b0:43b:d025:76a6 with SMTP id 5b1f17b1804b1-43bd298fcfdmr22365455e9.15.1741176000162;
 Wed, 05 Mar 2025 04:00:00 -0800 (PST)
Date: Wed, 5 Mar 2025 11:59:58 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <Z8g8vhS9rqQ_ez48@google.com>
Subject: [Bug report] Memory leak in scmi_device_create
From: Alice Ryhl <aliceryhl@google.com>
To: Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi <cristian.marussi@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, arm-scmi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

Dear SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/SCMI) Message
Protocol drivers maintainers,

I flashed a v6.13-rc3 kernel onto a Rock5B board and noticed the
following output in my terminal:

[  687.694465] kmemleak: 4 new suspected memory leaks (see /sys/kernel/debug/kmemleak)

It seems that there is a memory leak for devices created with
scmi_device_create.

This was with a kernel running v6.13-rc3, but as far as I can tell, no
relevant changes have landed since v6.13-rc3. My tree *does* include
commit 295416091e44 ("firmware: arm_scmi: Fix slab-use-after-free in
scmi_bus_notifier()"). I've only seen this kmemleak report once, so it's
not happening consistently.

See below for the full kmemleak report.

Alice

$ sudo cat /sys/kernel/debug/kmemleak
unreferenced object 0xffffff8106c86000 (size 2048):
  comm "swapper/0", pid 1, jiffies 4294893094
  hex dump (first 32 bytes):
    02 00 00 00 10 00 00 00 c0 01 bc 03 81 ff ff ff  ................
    60 67 ba 03 81 ff ff ff 18 60 c8 06 81 ff ff ff  `g.......`......
  backtrace (crc feae9680):
    [<00000000197aa008>] kmemleak_alloc+0x34/0xa0
    [<0000000056fe02c9>] __kmalloc_cache_noprof+0x1e0/0x450
    [<00000000a8b3dfe1>] __scmi_device_create+0xb4/0x2b4
    [<000000008714917b>] scmi_device_create+0x40/0x194
    [<000000001818f3cf>] scmi_chan_setup+0x144/0x3b8
    [<00000000970bad38>] scmi_probe+0x584/0xa78
    [<000000002600d2fd>] platform_probe+0xbc/0xf0
    [<00000000f6f556b4>] really_probe+0x1b8/0x520
    [<00000000eed93d59>] __driver_probe_device+0xe0/0x1d8
    [<00000000d613b754>] driver_probe_device+0x6c/0x208
    [<00000000187a9170>] __driver_attach+0x168/0x328
    [<00000000e3ff1834>] bus_for_each_dev+0x14c/0x178
    [<00000000984a3176>] driver_attach+0x34/0x44
    [<00000000fc35bf2a>] bus_add_driver+0x1bc/0x358
    [<00000000747fce19>] driver_register+0xc0/0x1a0
    [<0000000081cb8754>] __platform_driver_register+0x40/0x50
unreferenced object 0xffffff8103bc01c0 (size 32):
  comm "swapper/0", pid 1, jiffies 4294893094
  hex dump (first 32 bytes):
    5f 5f 73 63 6d 69 5f 74 72 61 6e 73 70 6f 72 74  __scmi_transport
    5f 64 65 76 69 63 65 5f 72 78 5f 31 30 00 ff ff  _device_rx_10...
  backtrace (crc 8dab7ca7):
    [<00000000197aa008>] kmemleak_alloc+0x34/0xa0
    [<00000000500dbc08>] __kmalloc_node_track_caller_noprof+0x234/0x528
    [<000000004990eea4>] kstrdup+0x48/0x80
    [<00000000ad4d2923>] kstrdup_const+0x30/0x3c
    [<00000000e9d3bdc3>] __scmi_device_create+0xd4/0x2b4
    [<000000008714917b>] scmi_device_create+0x40/0x194
    [<000000001818f3cf>] scmi_chan_setup+0x144/0x3b8
    [<00000000970bad38>] scmi_probe+0x584/0xa78
    [<000000002600d2fd>] platform_probe+0xbc/0xf0
    [<00000000f6f556b4>] really_probe+0x1b8/0x520
    [<00000000eed93d59>] __driver_probe_device+0xe0/0x1d8
    [<00000000d613b754>] driver_probe_device+0x6c/0x208
    [<00000000187a9170>] __driver_attach+0x168/0x328
    [<00000000e3ff1834>] bus_for_each_dev+0x14c/0x178
    [<00000000984a3176>] driver_attach+0x34/0x44
    [<00000000fc35bf2a>] bus_add_driver+0x1bc/0x358
unreferenced object 0xffffff8103ba6760 (size 16):
  comm "swapper/0", pid 1, jiffies 4294893094
  hex dump (first 16 bytes):
    73 63 6d 69 5f 64 65 76 2e 32 00 03 81 ff ff ff  scmi_dev.2......
  backtrace (crc ccc21b9a):
    [<00000000197aa008>] kmemleak_alloc+0x34/0xa0
    [<00000000500dbc08>] __kmalloc_node_track_caller_noprof+0x234/0x528
    [<00000000cdc440a0>] kvasprintf+0x90/0x11c
    [<00000000500fc732>] kvasprintf_const+0x98/0x138
    [<0000000030e28143>] kobject_set_name_vargs+0x68/0x104
    [<00000000f15f6ece>] dev_set_name+0x6c/0x98
    [<00000000c1f76eb4>] __scmi_device_create+0x17c/0x2b4
    [<000000008714917b>] scmi_device_create+0x40/0x194
    [<000000001818f3cf>] scmi_chan_setup+0x144/0x3b8
    [<00000000970bad38>] scmi_probe+0x584/0xa78
    [<000000002600d2fd>] platform_probe+0xbc/0xf0
    [<00000000f6f556b4>] really_probe+0x1b8/0x520
    [<00000000eed93d59>] __driver_probe_device+0xe0/0x1d8
    [<00000000d613b754>] driver_probe_device+0x6c/0x208
    [<00000000187a9170>] __driver_attach+0x168/0x328
    [<00000000e3ff1834>] bus_for_each_dev+0x14c/0x178
unreferenced object 0xffffff810637c800 (size 512):
  comm "swapper/0", pid 1, jiffies 4294893094
  hex dump (first 32 bytes):
    00 00 00 00 ad 4e ad de ff ff ff ff 00 00 00 00  .....N..........
    ff ff ff ff ff ff ff ff 00 1e ee 83 c0 ff ff ff  ................
  backtrace (crc 732b3ae6):
    [<00000000197aa008>] kmemleak_alloc+0x34/0xa0
    [<0000000056fe02c9>] __kmalloc_cache_noprof+0x1e0/0x450
    [<0000000026a3cb30>] device_add+0x54/0x570
    [<00000000e515c343>] device_register+0x20/0x30
    [<0000000042008204>] __scmi_device_create+0x184/0x2b4
    [<000000008714917b>] scmi_device_create+0x40/0x194
    [<000000001818f3cf>] scmi_chan_setup+0x144/0x3b8
    [<00000000970bad38>] scmi_probe+0x584/0xa78
    [<000000002600d2fd>] platform_probe+0xbc/0xf0
    [<00000000f6f556b4>] really_probe+0x1b8/0x520
    [<00000000eed93d59>] __driver_probe_device+0xe0/0x1d8
    [<00000000d613b754>] driver_probe_device+0x6c/0x208
    [<00000000187a9170>] __driver_attach+0x168/0x328
    [<00000000e3ff1834>] bus_for_each_dev+0x14c/0x178
    [<00000000984a3176>] driver_attach+0x34/0x44
    [<00000000fc35bf2a>] bus_add_driver+0x1bc/0x358

