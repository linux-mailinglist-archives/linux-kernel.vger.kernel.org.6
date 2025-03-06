Return-Path: <linux-kernel+bounces-549008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60496A54C17
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E3A77A3DBE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B27020E30A;
	Thu,  6 Mar 2025 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JMwaUY8Z"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772F420D510
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 13:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741267531; cv=none; b=pAn05OZfyFAz9cgouLpmeQcI1Akf0OucuQLkn19m579Son9V85TeXBV3JLd+/4qNRxQyFQrfNW/NCKKnQxklkSn+lQ3+EQqpHt3WzbPMixzZALzN2EUdFEGjvXkKJ12txdcTs8u/x/MRLlkRdRmxE/3Ub8aKUj3qQWx2zCYNYrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741267531; c=relaxed/simple;
	bh=ckVgwD1idrTgBPnpfYdKRlrhltmVgKJP8KD/7137wAo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DMAp3Ojs0w/td9VhrjFQ+cvFoT5mrc9gZ0OzBX9pv9XycYIEUNjTqiAvX46Bu5Iqj2tLCWZv4JdGPPoYUkWXROh9EIfgCaojLliRL+Vf+ebz6oVE0X7Wp8YPtJbAdHyBnz+1juP9tnj60l1WAGX2ONFSQggRCuWEuHIqW8joWKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JMwaUY8Z; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bc1aa0673so2653035e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 05:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741267528; x=1741872328; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XjvY8QE+WfjDEBedvFnnwEvqcwGNoef7rD13NkLbjhw=;
        b=JMwaUY8ZCxQmjqMeR/9FOdvl27VJBE9yDRuZ+fT+c7menTiKcI3fWvh1LCmef25d5U
         wiGVFQDhL9/MqHX86G5jFpo9xZfQM0Aki6VtR15MHLvC+IwC8Xk6KQr/gBlOz26hGMDB
         oSN2uQ9lh1dmG7//d5+/AoU9bWXTVvbHVMSumLjzfBborjf1jp8WKj5SAZvygI0Cyn+c
         zea4N0yvC/viIJVYYQDSe6uhAjJx1FzzIs+jmeVwROpXE0s6KUeRYL2ICDcHtrJI/vto
         RVPEaTDtBAyEeDZWaFs8Roia4AxNavf8FVifw0KKMej6J6wRCY0/FTzQMA8gyBZA/AgK
         8D3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741267528; x=1741872328;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjvY8QE+WfjDEBedvFnnwEvqcwGNoef7rD13NkLbjhw=;
        b=uzO5VvoC4YnMbU70Q6Z6vVNoUL3QGueu8HQjhvFiv880RzG1uUSA6F/oKK86TXYJKo
         NFgaNzp+govgv+JMOJQ089ae9u0kx8Kotl7YeOe1k5gdNBhy1xz3nqrv6rVh4E2Y75gG
         LaAv+X6wL5CpA8pvqYJeM1/xI6z2XLSu0Lrm9U0UC7+kuprxnC7wMaFUVowU3PBUr7s8
         3GX8FKcW6xTCiPJNNrwEYkaXxRPxJdIdg8x7WFYch+u/qvU+hVHD+uvUQo8xk3YZyTQc
         RSe7rG5gPG7eiSf0ozWz5QGmo01Mgv/1Ks6eV0fxz3zm+L3YEgBfB9ptNlWd/0cqqMP/
         ZRsA==
X-Forwarded-Encrypted: i=1; AJvYcCUspOyAsOwscoeB2LRP940wNenNNYHN4x9OE75Le5slx5FpbqvnykomSyJwVuTPMrFUshbcZErMOgzm95Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwRy3Nlndk1bnn4ur1XErp2YabgRichX7YOvQHOE/g/qJnAFzq
	LA5OUlquMMqJAZiLJuaMvT40kjD0yJME70WzRX7Lb95q/ag/AA+JUTPYEcZfEMNvFyr2HF3X1Dd
	EJpOeCZ1N3RsXOg==
X-Google-Smtp-Source: AGHT+IGu6TNRJ9xsT+tbNha9i/40T4DWFVb5ajxHxFzrjaRSighLgqQn9S9T5+RQz5NbxV86JeMfKntspt/d6/4=
X-Received: from wmrn30.prod.google.com ([2002:a05:600c:501e:b0:43b:d157:3b9e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4447:b0:43b:c0fa:f9e4 with SMTP id 5b1f17b1804b1-43bd29589fcmr52982055e9.13.1741267527969;
 Thu, 06 Mar 2025 05:25:27 -0800 (PST)
Date: Thu, 6 Mar 2025 13:25:25 +0000
In-Reply-To: <Z8maCX5QJRqODl6u@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Z8g8vhS9rqQ_ez48@google.com> <Z8iFeEWq16pNQdMa@pluto>
 <Z8mCbc2Z2QGd3f8M@google.com> <Z8maCX5QJRqODl6u@pluto>
Message-ID: <Z8miRewURwdvU36h@google.com>
Subject: Re: [Bug report] Memory leak in scmi_device_create
From: Alice Ryhl <aliceryhl@google.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, 
	arm-scmi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Mar 06, 2025 at 12:50:17PM +0000, Cristian Marussi wrote:
> On Thu, Mar 06, 2025 at 11:09:33AM +0000, Alice Ryhl wrote:
> > On Wed, Mar 05, 2025 at 05:10:16PM +0000, Cristian Marussi wrote:
> > > On Wed, Mar 05, 2025 at 11:59:58AM +0000, Alice Ryhl wrote:
> > > > Dear SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/SCMI) Message
> > > > Protocol drivers maintainers,
> > > > 
> > > > I flashed a v6.13-rc3 kernel onto a Rock5B board and noticed the
> > > > following output in my terminal:
> > > > 
> > > > [  687.694465] kmemleak: 4 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> > > > 
> > > > It seems that there is a memory leak for devices created with
> > > > scmi_device_create.
> > > > 
> > > `
> > > Hi Alice,
> > > 
> > > thanks for this report.
> > > 
> > > > This was with a kernel running v6.13-rc3, but as far as I can tell, no
> > > > relevant changes have landed since v6.13-rc3. My tree *does* include
> > > > commit 295416091e44 ("firmware: arm_scmi: Fix slab-use-after-free in
> > > > scmi_bus_notifier()"). I've only seen this kmemleak report once, so it's
> > > > not happening consistently.
> > > > 
> > > > See below for the full kmemleak report.
> > > > 
> > > > Alice
> > > > 
> > > > $ sudo cat /sys/kernel/debug/kmemleak
> > > > unreferenced object 0xffffff8106c86000 (size 2048):
> > > >   comm "swapper/0", pid 1, jiffies 4294893094
> > > >   hex dump (first 32 bytes):
> > > >     02 00 00 00 10 00 00 00 c0 01 bc 03 81 ff ff ff  ................
> > > >     60 67 ba 03 81 ff ff ff 18 60 c8 06 81 ff ff ff  `g.......`......
> > > >   backtrace (crc feae9680):
> > > >     [<00000000197aa008>] kmemleak_alloc+0x34/0xa0
> > > >     [<0000000056fe02c9>] __kmalloc_cache_noprof+0x1e0/0x450
> > > >     [<00000000a8b3dfe1>] __scmi_device_create+0xb4/0x2b4
> > > >     [<000000008714917b>] scmi_device_create+0x40/0x194
> > > >     [<000000001818f3cf>] scmi_chan_setup+0x144/0x3b8
> > > >     [<00000000970bad38>] scmi_probe+0x584/0xa78
> > > >     [<000000002600d2fd>] platform_probe+0xbc/0xf0
> > > >     [<00000000f6f556b4>] really_probe+0x1b8/0x520
> > > >     [<00000000eed93d59>] __driver_probe_device+0xe0/0x1d8
> > > >     [<00000000d613b754>] driver_probe_device+0x6c/0x208
> > > >     [<00000000187a9170>] __driver_attach+0x168/0x328
> > > >     [<00000000e3ff1834>] bus_for_each_dev+0x14c/0x178
> > > >     [<00000000984a3176>] driver_attach+0x34/0x44
> > > >     [<00000000fc35bf2a>] bus_add_driver+0x1bc/0x358
> > > >     [<00000000747fce19>] driver_register+0xc0/0x1a0
> > > >     [<0000000081cb8754>] __platform_driver_register+0x40/0x50
> > > > unreferenced object 0xffffff8103bc01c0 (size 32):
> > > 
> > > I could not reproduce on my setup, even though I run a system with
> > > all the existent SCMI protocols (and related drivers) enabled (and
> > > so a lot of device creations) and a downstream test driver that causes
> > > even more SCMI devices to be created/destroyed at load/unload.
> > > 
> > > Coming down the path from scmi_chan_setup(), it seems something around
> > > transport devices creation, but it is not obvious to me where the leak
> > > could hide....
> > > 
> > > ...any particular setup on your side ? ...using LKMs, loading/unloading,
> > > any usage pattern that could help me reproduce ?
> > 
> > I looked into this a bit more, and actually it does happen consistently.
> > It's just that kmemleak doesn't report it until 10 minutes after
> > booting, so I did not notice it.
> > 
> > As for my setup, well, I boot the kernel over pxe and the rootfs is
> > mounted over NFSv4. The memory leak happens even if I don't do anything
> > at all - I just boot and wait. The device is a Radxa Rock5B.
> > 
> > Not sure what other information there is to give.
> > 
> 
> My question as stated above was mainly to understand if the SCMI stack
> was built-in or compiled as loadable modules (lsmod|grep -i scmi)...
> ...I am just to try to pin down a possible 'more-vulnerable' configuration..
> ..I could not see any report even triggering a kmemleak scan on v6.14-rc5
> BUT I only tested with a fully built-in SCMI stack indeed as of now...so
> the question.
> 
> > I tried again with v6.14-rc5, and I still got the leak:
> 
> Ok...thanks I will investigate with different configs.

Here is the config I used:
https://gist.github.com/Darksonn/ecd31a0512f43f7e74a30ab83ff2196f

Alice

