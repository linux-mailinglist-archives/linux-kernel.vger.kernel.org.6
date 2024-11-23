Return-Path: <linux-kernel+bounces-419157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AB6B9D6A15
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 17:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A320D1608FC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC4D86AE3;
	Sat, 23 Nov 2024 16:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LP45Vikb"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C833C466
	for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732379233; cv=none; b=j74ei6WKpgB8Zek2kw36ocihWhScvKMU7RJmsib3lLRX3mL+hLAG7zOU9nhuf4HaZct6rmal1Kx9V/ApfXTYRVnXFOBB5UwKOvXcrbKClPyUvcaaiTYvHIrHVidAS1Cedf/oH2uuhPW7ywLs658uGg59w1MJlRo4+6qhMJgucdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732379233; c=relaxed/simple;
	bh=0TBw21LwCgxgBFV6kS3V3lT4FpxvX3RWOKZV6tu6ry0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5e6mBYqyPx382HzMYhw0Gkzut41F53+24YboEQl//OziITEH2qqjsTHCx1TakP0IVVlxBEB3zepT2SKWvZC8DxIjY5APzBjzof07JaFsWM0O+dFDMdRczdvQheObU15rW0wA54x+w4MhLZKhiKYCJcrXBx4dpnuh23eit8Eyc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LP45Vikb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-720cb6ac25aso2608669b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Nov 2024 08:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732379231; x=1732984031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BqUR/3S09gGH/ZXC0Rud3BDL81IOdN/TetzqHoco4Ik=;
        b=LP45Vikbbq22uqkc4Drnb4+cjtnvRCYv7M1jPNED87C45lf9Cqys1eUpqZ5twXarEo
         3YVA0aTHBTf/m6NfCLfgxdYBhmByx9/E6NimZbjMGa+eqZgErK/ht7G8wZxK6puDTR43
         6QHmj927xKTYwyBfFjNTbNJQzdqYeWJhPweSYbXmM8FxMMFBWH/Rf+KzSqSzxGj1bHjU
         wPRlP+xpjdoDEFJdMFdA1R6PZhJIjv4GBXwXzdYhcPq1P9NHtLuU74ayDi5ZRX6QMLfk
         Ew/6p9iU2G8usVWHDcdDTb4Hnht8JNZS8KErSbMuiQZ0wpEqPUm1wikgNzPkEBTJtkd0
         PNqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732379231; x=1732984031;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqUR/3S09gGH/ZXC0Rud3BDL81IOdN/TetzqHoco4Ik=;
        b=YXZQ77iicJ6zqcqvAKB6loKCpHqvg6117j8FznC2jGsvLgn3jl4a931PzgLLPX2KD0
         I+eebAuNEM3gm+cdVFpyNIWDja1108VVOJoyjLCfe6k8U0Cc+X8qntGrSSU3WVbm350D
         zNSdUwt5lMR02d5tHHFVSDah5w+BB8gfXoZF683gLcP4JamG0oaIu/7El6Pni3tylQZy
         dlGWXIpgMaHiSm+r19+x5nxNY+syx+2xgrQyEeVUlQn1zhLM17pKCobB0QkbHnNIQR50
         65aPoUjsiU2y8G5egUUK5x1mhjz6Z/LZjwwtfU30AeyyUwcfg9ywjX6TD9Qb/HtS3n4o
         SJQg==
X-Gm-Message-State: AOJu0YyNj/j8ghz3Z8d2Kgznyrs8dis9678vFBii3k025lKGC0aXBnYD
	PKdOfHhX9tOusxboHBVSTuQZto97YaF010WZcuQN2Zms+darY0+m
X-Gm-Gg: ASbGnctuek38HPKDASKNqIl1zMLALg8qUerYzDe/0xm9QrvAu1Ypj3ZVzbjDofvsZMK
	2BpaYWoj8iubPpwo3jAjxd6mcrpT4tCAa9K6UhuJ/VfoK7EeE6RNJbxnn28HHwseiX5KJSQXMEP
	XOSbS0sbSvQuXusOync5DiMv4Tz+m8tB7r++W20xYx/tn7xuhIwpxoynxCNyOjq7XGHz7bwCjht
	oZmvX4pLmwqxKhH7t3y/tftwRqGZIvpWQ6Ad1dPeO1YXbJggnpPyfx8HDiPgyo=
X-Google-Smtp-Source: AGHT+IFVCNRaLMbmWz36rZZkqK90JwqawKBL+OSqjYfS8bI8s9I6OzuUiVxaTk2VEQ9SmedyO0tK3A==
X-Received: by 2002:a17:903:230e:b0:212:3f13:d4d5 with SMTP id d9443c01a7336-2129fd22060mr92617485ad.27.1732379230986;
        Sat, 23 Nov 2024 08:27:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc13ab9sm34625415ad.171.2024.11.23.08.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 08:27:09 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 23 Nov 2024 08:27:08 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/1] lockdep: Enable PROVE_RAW_LOCK_NESTING with
 PROVE_LOCKING.
Message-ID: <7656395b-58fc-4874-a9f3-6d934e2ef7ee@roeck-us.net>
References: <20241009161041.1018375-1-bigeasy@linutronix.de>
 <20241009161041.1018375-2-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241009161041.1018375-2-bigeasy@linutronix.de>

On Wed, Oct 09, 2024 at 05:45:03PM +0200, Sebastian Andrzej Siewior wrote:
> With the printk issues solved, the last known splat created by
> PROVE_RAW_LOCK_NESTING is gone.
> 
> Enable PROVE_RAW_LOCK_NESTING by default as part of PROVE_LOCKING. Keep
> the defines around in case something serious pops up and it needs to be
> disabled.
> 

On sparc64:

=============================
[ BUG: Invalid wait context ]
6.12.0+ #1 Not tainted
-----------------------------
swapper/0/1 is trying to lock:
0000000001b61428 (pci_poke_lock){....}-{3:3}, at: pci_config_read16+0x8/0x80
other info that might help us debug this:
context-{5:5}
2 locks held by swapper/0/1:
 #0: fffff800042b50f8 (&dev->mutex){....}-{4:4}, at: __driver_attach+0x80/0x160
 #1: 0000000001d201a8 (pci_lock){....}-{2:2}, at: pci_bus_read_config_word+0x18/0x80
stack backtrace:
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0+ #1
Call Trace:
[<00000000004e3190>] __lock_acquire+0xa50/0x3160
[<00000000004e63a8>] lock_acquire+0xe8/0x340
[<00000000010ea57c>] _raw_spin_lock_irqsave+0x3c/0x80
[<00000000004434e8>] pci_config_read16+0x8/0x80
[<00000000004440ec>] sun4u_read_pci_cfg+0x12c/0x1a0
[<0000000000b7437c>] pci_bus_read_config_word+0x3c/0x80
[<0000000000b7d878>] pci_find_capability+0x18/0xa0
[<0000000000b772b0>] set_pcie_port_type+0x10/0x160
[<0000000000442758>] pci_of_scan_bus+0x158/0xb00
[<00000000010c0c60>] pci_scan_one_pbm+0xd0/0xf8
[<0000000000445e34>] sabre_probe+0x1f4/0x5c0
[<0000000000c0f9a8>] platform_probe+0x28/0x80
[<0000000000c0d0b8>] really_probe+0xb8/0x340
[<0000000000c0d4e4>] driver_probe_device+0x24/0xe0
[<0000000000c0d70c>] __driver_attach+0x8c/0x160
[<0000000000c0aeb4>] bus_for_each_dev+0x54/0xc0

Is this a problem with the test or with the platform ?

Thanks,
Guenter

