Return-Path: <linux-kernel+bounces-361026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2538F99A283
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 479EC1C22A8B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BB22141C6;
	Fri, 11 Oct 2024 11:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggeiNJxk"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00D01CF291
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728645200; cv=none; b=fyABciofPSYjkikIe0gUWz7kHfjPx1y8wiPIGEwmHnRqyFJoyjqj6ELKlbfXVN6cGb85klYYQz3N4TQKygY98Osa6smnpKLL7mRrzi5GS1f2khHsIIRBYxsnZBPMPs1dNRhnskkNLmntytTg70oRlqoq+VsvVsJ/3qQjmyLOVHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728645200; c=relaxed/simple;
	bh=nS4faFlSiUDqrBE/RgDmN12VcZfAlUNv0bX4T1C9apM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KPW9nhif21T8cCi1WqJMcyScXXQH+wMcoBJVrfbmlQ7AbY+2lSu0bZQeZdegUHsIzEbmyRtggjgjeHHuRq3MY7wcg6//OBeXjn6kvSkiAFa5YverN9qU3E91U73OPpAf6FiyNQQCsQ+2NFlU3Qdkuhqm7Ev1Kxk96x0BXCdL1CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ggeiNJxk; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c89f3e8a74so2519826a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728645197; x=1729249997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EI5iC8dm73D3LZ+RFta2UnjsQ3/rJ2IOcAI5wCq7cgw=;
        b=ggeiNJxkF5o0H+1UinumYGrISIjAWeq1kXTb0SsIJBEQ7bxGpVSi6YCuiCfrw1GmNj
         GZwl5POrnwii55CaryFReKzSGdNX1QleW9UmuAVHCBtIZZb1zG4KB+b47wq3eGSmhJhV
         DMvcIldoVZ1Y+2jThDMbz1wT8pquECeLOS+nclWf5kOAgr+JoKsqvpai4Pm4Sbeirs8Z
         gKqJu47+bqFs9p/tX0OvLjGexH+Rdlwq6Puq6ES2JJAXQrSqhOOdMGwtHKWL7hCLWAne
         6b2NUdDmzywZnpI29N3kkH4fMvCztwzm82qW5yIEdZYIQwDRBa+6erPGqAMnUDEzAKyl
         Lh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728645197; x=1729249997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EI5iC8dm73D3LZ+RFta2UnjsQ3/rJ2IOcAI5wCq7cgw=;
        b=iD6AFW7dYm9g5A2hpBWELk8Pce+iVQpoxm2CI4ZxzeOcro07WVYNbcJkD8XOTsA85y
         SJFM5KMQqTCBSfpuMrzZguLY3Fopynf9waDIDy4XVEwkoZCFmqFHSEDEU9JB1JUYf2ys
         n1y8sNyNJu+uEGY+mYD2hhH0XUWp8v9nIJ4k+wXIdELcPaKR53jC9Krsy+Bv3BXCpdno
         iqthe+5dQ9K25/DVxURfWWaXsbMFsJvqs+uL7myQCmQd//DQglfKbIalGmuZdXtSW5Ri
         +mI2jfQ97ACmNELz4PyiYQ95xGN5VeOmveoZYCXidKB8Ps63uXdManZjgjAypwl+7Bot
         h9ng==
X-Forwarded-Encrypted: i=1; AJvYcCXfXPhwRkUQgHsb8vcGshZNNZS5eIO4OQe3zs8JXITr09bGD7Zkp8EUx7+xQzj3+26X+9KGHR+8q0p525Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7gwigpkM42AwWlX5pl/t4ZOKoi81APSlxcMYo4uFGPB9dGcS0
	YPkltbU00BjiA7fHc3UZR9RIQv9QGOg9w7DVG4oiP4fhAONfJDeTgS2Y/k1q2WffXFIVz1Snf8Q
	ycdfUoAsJ2DWD4XzaG0Up0gCMzWzN5YNi8IHD
X-Google-Smtp-Source: AGHT+IF58r+qWw4r4Z1TRy24lZ4hMVAwi3YpVnwO7v841ug2Ui4qG0NhwF1IBtRJPOYn+9D9A5p6rpKwRSQn9h2lY9s=
X-Received: by 2002:a05:6402:3487:b0:5c9:4548:db8a with SMTP id
 4fb4d7f45d1cf-5c948cc7d30mr1768545a12.16.1728645196914; Fri, 11 Oct 2024
 04:13:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011074811.2308043-3-stefan.wiehler@nokia.com>
In-Reply-To: <20241011074811.2308043-3-stefan.wiehler@nokia.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 11 Oct 2024 13:13:03 +0200
Message-ID: <CANn89iKFB=T94_wRyND_Z_fGp-Wd9u0EHF_DXg-scQye_tb-Bw@mail.gmail.com>
Subject: Re: [PATCH net v4 0/5] Lock RCU before calling ip6mr_get_table()
To: Stefan Wiehler <stefan.wiehler@nokia.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 9:48=E2=80=AFAM Stefan Wiehler <stefan.wiehler@noki=
a.com> wrote:
>
> Lock RCU before calling ip6mr_get_table() in several ip6mr functions.
>
> v4:
>   - mention in commit message that ip6mr_vif_seq_stop() would be called
>     in case ip6mr_vif_seq_start() returns an error
>   - fix unitialised use of mrt variable
>   - revert commit b6dd5acde3f1 ("ipv6: Fix suspicious RCU usage warning
>     in ip6mr")

Hi Stefan. I think a v5 is needed :)

Please double check your syslog

[   18.149447] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   18.149471] WARNING: suspicious RCU usage
[   18.149649] 6.12.0-rc2-virtme #1155 Not tainted
[   18.149726] -----------------------------
[   18.149747] net/ipv6/ip6mr.c:131 RCU-list traversed in non-reader sectio=
n!!
[   18.149792]
other info that might help us debug this:

[   18.149824]
rcu_scheduler_active =3D 2, debug_locks =3D 1
[   18.150050] 1 lock held by swapper/0/1:
[   18.150090] #0: ffffffff95b36390 (pernet_ops_rwsem){+.+.}-{3:3},
at: register_pernet_subsys (net/core/net_namespace.c:1356)
[   18.151482]
stack backtrace:
[   18.151716] CPU: 12 UID: 0 PID: 1 Comm: swapper/0 Not tainted
6.12.0-rc2-virtme #1155
[   18.151809] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   18.151982] Call Trace:
[   18.152122]  <TASK>
[   18.152411] dump_stack_lvl (lib/dump_stack.c:123)
[   18.152411] lockdep_rcu_suspicious (kernel/locking/lockdep.c:6822)
[   18.152411] ip6mr_get_table (net/ipv6/ip6mr.c:131 (discriminator 9))
[   18.152411] ip6mr_net_init (net/ipv6/ip6mr.c:384
net/ipv6/ip6mr.c:238 net/ipv6/ip6mr.c:1317 net/ipv6/ip6mr.c:1309)
[   18.152411] ops_init (net/core/net_namespace.c:139)
[   18.152411] register_pernet_operations
(net/core/net_namespace.c:1239 net/core/net_namespace.c:1315)
[   18.152411] register_pernet_subsys (net/core/net_namespace.c:1357)
[   18.152411] ip6_mr_init (net/ipv6/ip6mr.c:1379)
[   18.152411] inet6_init (net/ipv6/af_inet6.c:1137)
[   18.152411] ? __pfx_inet6_init (net/ipv6/af_inet6.c:1076)
[   18.152411] do_one_initcall (init/main.c:1269)
[   18.152411] ? _raw_spin_unlock_irqrestore
(./arch/x86/include/asm/irqflags.h:42
./arch/x86/include/asm/irqflags.h:97
./arch/x86/include/asm/irqflags.h:155
./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194)
[   18.152411] kernel_init_freeable (init/main.c:1330 (discriminator
1) init/main.c:1347 (discriminator 1) init/main.c:1366 (discriminator
1) init/main.c:1580 (discriminator 1))
[   18.152411] ? __pfx_kernel_init (init/main.c:1461)
[   18.152411] kernel_init (init/main.c:1471)
[   18.152411] ret_from_fork (arch/x86/kernel/process.c:153)
[   18.152411] ? __pfx_kernel_init (init/main.c:1461)
[   18.152411] ret_from_fork_asm (arch/x86/entry/entry_64.S:257)
[   18.152411]  </TASK>

Thank you.

