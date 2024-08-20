Return-Path: <linux-kernel+bounces-293477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 872D4958042
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 09:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9BE21C211E8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 07:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC23189527;
	Tue, 20 Aug 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PE8OV0hL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+MTA0FTe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD87F18E34F
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724140179; cv=none; b=spcGDHhosZOGoI7rDW0YGvmN30uWjrC5mtHRyabJ3oGmEJtl6ONNEmmtiMAWc306lJ7zK8fKq2aHawVOk2Q3sLlqR3rYR8tpDTgqrQP0o3kgSnGHkH3EV+iITMrNKgxQ/JOcQhvzv5Nfcue1eIkmybJzSuUDvk2olno+ezn1ukI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724140179; c=relaxed/simple;
	bh=AkpFn2l5JcneMbN1nlsCfGxbJ0SKCtgZAWOXvjetaXU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=buh0mvH+l6PXd80C7z2wa9Bhamyeq0R1mOaG6BPfZ5HPARH65vEqLZNJMpWCF39Ecao1fxpSscnIr4Zu4KCET5HDlwpR29JbwUZSwwF1eawLN8Bp47zqeAEdXIp8EvE57ir3NvNGQo4BIF1HekAffqKi1Cq1ye6BgpmAGcQs9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PE8OV0hL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+MTA0FTe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Aug 2024 09:49:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724140173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=M5NmlRYVePqzfpvCRGYGwIXh0bDq30gB15n+FrvAydk=;
	b=PE8OV0hLCxMqeXg8hS9mvU7QnLYzey9M0w/fMeAuVJ1cJy4rKTC1PYTp6maqF6MALwfEXm
	cTVz0fWkiuoPM/gYbEXRLIuvx1jLMCeTvUW5PAK+i9L55gNyILKj0q4XhxdkAjEI/YupJ0
	7BW4LIMhcxx2JyIqyzGrUimxA9woEjTRaxQE9NHaxEqXROYfCEGvaL0jrjqi8/CcWJ+u85
	XDG7aCybX9r0GVo1Clv2vWDjyMBK1sRcmTrbBgo4c7HjWsoTlT4MW5dw+ED0sZmX9pD20d
	grPSGzQkOLmxsGNyXU2Tejkw/lgBechynWzjdjmG7wU28WLGVIQH7cyju9bXGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724140173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=M5NmlRYVePqzfpvCRGYGwIXh0bDq30gB15n+FrvAydk=;
	b=+MTA0FTeEAynBAvdPlV4rTlOo59sQn9r1aklahwhOqzBIo2j1l0NFZ9LFzACZW7KpqHS5j
	EPhOIJ2j4iDFaICA==
From: Nam Cao <namcao@linutronix.de>
To: Atish Patra <atishp@rivosinc.com>, Palmer Dabbelt <palmer@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: drivers/perf: riscv: BUG: using smp_processor_id() in preemptible
Message-ID: <20240820074925.ReMKUPP3@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I noticed the following issue on 6.11.0-rc4 with CONFIG_DEBUG_PREEMPT=y.

BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
caller is debug_smp_processor_id+0x1c/0x26
CPU: 2 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.11.0-rc4 #2
Hardware name: StarFive VisionFive 2 v1.3B (DT)
Call Trace:
    dump_backtrace+0x1c/0x24
    show_stack+0x2c/0x38
    dump_stack_lvl+0x5a/0x72
    dump_stack+0x14/0x1c
    check_preemption_disabled+0xb6/0xb8
    debug_smp_processor_id+0x1c/0x26
    pmu_sbi_device_probe+0x474/0x570
    platform_probe+0x52/0x96
    really_probe+0x82/0x202
    __driver_probe_device+0x5c/0xd0
    driver_probe_device+0x2c/0xb0
    __device_attach_driver+0x6e/0x8e
    bus_for_each_drv+0x64/0xb8
    __device_attach+0x82/0x144
    device_initial_probe+0xe/0x16
    bus_probe_device+0x86/0x88
    device_add+0x508/0x6ac
    platform_device_add+0xcc/0x1c8
    platform_device_register_full+0xee/0x142
    pmu_sbi_devinit+0xd4/0x11c
    do_one_initcall+0x58/0x19c
    kernel_init_freeable+0x210/0x27a
    kernel_init+0x1e/0x112
    ret_from_fork+0xe/0x1c

If you fix the issue, please add:
Reported-by: Nam Cao <namcao@linutronix.de>

Best regards,
Nam

