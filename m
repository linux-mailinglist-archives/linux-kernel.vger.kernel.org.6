Return-Path: <linux-kernel+bounces-246797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2786592C6D5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 02:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49E381C22028
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4F42231C;
	Wed, 10 Jul 2024 00:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Un0hwkP3"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7E51A28D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720569733; cv=none; b=sYYn9sne+dLBoxlmvZvKrOTopjlOJl1hOWKVbApb6y0wVflIh2hyF8C3B7tJ2t/N+uOcgdWxfvTbj3aCwMdL9aV3rfDI/BU4V+h2OCYtsxzej3kHmKo/BYl3Tyj+8lSjo16UnFQG+/PgQnGLZ48pzoL/bXIh4j2bzqYDVERNt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720569733; c=relaxed/simple;
	bh=N6FTunEJMi98xb25SK+lKkgV+TreEYIo6vUhgIGtTyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Su9z0tIJ8IIbcDJnX9pJUe+gqVtYHRlOIJTBret78VP8QTyC2wl1JH0A8cLKB+pCYRPdKbMDUdKlomHK0QSU6rbI6RzzZrPRUhJooZLxetXlAViTYuYyTkA1X5myjXzkRNumikaX/WfyS7I0N7l0T+w73yICclc6ucKBjcueaas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Un0hwkP3; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb0d88fd25so1765185ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 17:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720569732; x=1721174532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7/DO3foNj8vO9MurllYMRlFmpyKnlPqGtJ5JuQ+lqPg=;
        b=Un0hwkP3f5YRYlQsGAOsta9shfgc8qmUhq8C3gaNzDOZuaSt5noBlltWNYstUXhSz/
         KIhPG5AJ/ZLfuWOcFfb0/VxiHgqdfD1S+eB1XFYVTawTA29ErwYDgc8mvR0XiL5Mde4S
         6UW1Q9Db6gNz6Ol32/yq75pwXZWXr8OdVXjp0GX9IfgIIJMBivXaSk7em+14j6N0nITl
         I9x47zAooNwDdBhPn6Z8Hdj53X7utjsFTu4gXy3/Cleu8EHHxdpcKRUprSKrY4gtlh3N
         nI/UUk8aU4ijahxDfFQ83fNUKWdbyrXDjDyZwcghMphuobFms01CPIm23SNbKyZo5y2B
         7D9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720569732; x=1721174532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/DO3foNj8vO9MurllYMRlFmpyKnlPqGtJ5JuQ+lqPg=;
        b=gNgtUvTKovxXQocfF3XPV/vBfrM8rT/hzOg1vRuuXEZJ/+vUpVsfozUPwmIJ8Np4im
         HH8MHCwzaZxDLHbTqJqO/PnCruPs+ozDKbdYrYyGbrPmMr4l2gyi/wWzKag8c7sUY0it
         HwMK8dDaq555pbdnlMNfSCqHR98w1cR0a4awe5PgWg7qNgwdvK0jey11sPx769W9pZG9
         HLNNIDMwaZkj+MGCdl8QdIBgU22m1k5wxcTDQVdPiwIluVQYZflO9H1qiPV2mlFuyYoe
         tuHec8uIVP/VBS/MnID8p3gZQhOk0HYL2cT8Ko+Qqs6CadjnbFTWa0JRgONrL8PRY/dU
         N/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVDFYWI0A/W/UoKX6S1cfgIAvJ6lXru7gshiRPtyWQaxkeUtFjIIGEXbisw+ynpCSx3ZT5DbxEk0otEziSeVjxhPna86XUa5eBXrGhw
X-Gm-Message-State: AOJu0YyONCSbRo/hIBI5zMai0FtMAIpwoEeV/vwxJUg3e2lHw8Lsb3O1
	PBcCHWxK5ebkpZuNhI/7ZtfCsZCeMx5cnFrhcklVgO8Hq3uC9496
X-Google-Smtp-Source: AGHT+IFTLDdhO0v1iGMCa/JgDgWolpL49wFw3KKJvUC6FGrTAKVDgUKGj7ytL7bPhhVJdzooRVEb2Q==
X-Received: by 2002:a17:902:d491:b0:1f9:f6c5:b483 with SMTP id d9443c01a7336-1fbb8043e56mr63473625ad.27.1720569730013;
        Tue, 09 Jul 2024 17:02:10 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ab7d22sm21592295ad.181.2024.07.09.17.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 17:02:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 9 Jul 2024 14:02:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Aboorva Devarajan <aboorvad@linux.ibm.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Subject: Re: [sched_ext/for-6.11]: Issue with BPF Scheduler during CPU Hotplug
Message-ID: <Zo3PgETt43iFersn@slm.duckdns.org>
References: <8cd0ec0c4c7c1bc0119e61fbef0bee9d5e24022d.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cd0ec0c4c7c1bc0119e61fbef0bee9d5e24022d.camel@linux.ibm.com>

Hello,

On Tue, Jul 09, 2024 at 01:21:38PM +0530, Aboorva Devarajan wrote:
...
> Steps to reproduce the issue:
> 
> - Run the scx_simple scheduler.
> - Randomly offline and online CPUs from 1 to 127.
> 
> During the CPU hotplug, the custom scheduler successfully
> unregisters and registers itself without issues. However, it
> occasionally encounters a crash and the system becomes unresponsive.

How reproducible is the problem?

...
> [64650.801834] task:scx_simple      state:D stack:0     pid:11214 tgid:11214 ppid:11013  flags:0x00040080
> [64650.801949] Sched_ext: simple (prepping)
> [64650.801978] Call Trace:
> [64650.802062] [c000000e9bdf35b0] [c0000000016f0c06] scx_dump_state.trunc_marker+0x2078/0x5d2a (unreliable)
> [64650.802231] [c000000e9bdf3760] [c00000000001dd68] __switch_to+0x238/0x310
> [64650.802437] [c000000e9bdf37c0] [c0000000013e6170] __schedule+0xa10/0xf80
> [64650.802599] [c000000e9bdf38c0] [c0000000013e6764] schedule+0x84/0x128
> [64650.802700] [c000000e9bdf38f0] [c00000000023f4dc] percpu_rwsem_wait+0x13c/0x1a0
> [64650.802807] [c000000e9bdf3970] [c0000000013ee7ec] __percpu_down_read+0xac/0x21c
> [64650.802926] [c000000e9bdf39f0] [c0000000001739b8] cpus_read_lock+0x158/0x180
> [64650.803065] [c000000e9bdf3a30] [c00000000021fd88] bpf_scx_reg+0x5d8/0xb80
> [64650.803161] [c000000e9bdf3c10] [c00000000049e308] bpf_struct_ops_link_create+0x158/0x200
> [64650.803259] [c000000e9bdf3c80] [c000000000407628] link_create+0x78/0x3b0
> [64650.803319] [c000000e9bdf3cd0] [c0000000004026fc] __sys_bpf+0x39c/0x560
> [64650.803389] [c000000e9bdf3dc0] [c000000000400b00] sys_bpf+0x50/0x80
> [64650.803449] [c000000e9bdf3e00] [c00000000003218c] system_call_exception+0x10c/0x2b0
> [64650.803559] [c000000e9bdf3e50] [c00000000000c7d4] system_call_common+0xf4/0x258
...
> [64650.808330] Showing all locks held in the system:
> [64650.808391] 1 lock held by kthreadd/2:
> [64650.808431]  #0: c0000000029259c8 (scx_fork_rwsem){++++}-{0:0}, at: sched_fork+0x80/0x240
...
> [64650.810515] 4 locks held by scx_simple/11214:
> [64650.810606]  #0: c000000002a609b0 (update_mutex){+.+.}-{4:4}, at: bpf_struct_ops_link_create+0x134/0x200
> [64650.810781]  #1: c000000002927170 (scx_ops_enable_mutex){+.+.}-{4:4}, at: bpf_scx_reg+0x80/0xb80
> [64650.810886]  #2: c0000000029259c8 (scx_fork_rwsem){++++}-{0:0}, at: bpf_scx_reg+0x5d0/0xb80
> [64650.811023]  #3: c000000002913278 (cpu_hotplug_lock){++++}-{0:0}, at: bpf_scx_reg+0x5d8/0xb80
> [64650.811174] 7 locks held by hotplug.sh/11440:
> [64650.811240]  #0: c000000e9bfe6450 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0xcc/0x370
> [64650.811362]  #1: c000000e11b31e90 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x10c/0x260
> [64650.811514]  #2: c000000df2892620 (kn->active#73){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x118/0x260
> [64650.811675]  #3: c000000002aebc08 (device_hotplug_lock){+.+.}-{4:4}, at: online_store+0x6c/0x1a0
> [64650.811814]  #4: c000007ff4ce0128 (&dev->mutex){....}-{4:4}, at: online_store+0x94/0x1a0
> [64650.811929]  #5: c000000002913168 (cpu_add_remove_lock){+.+.}-{4:4}, at: cpu_up+0xa4/0x1b0
> [64650.812061]  #6: c000000002913278 (cpu_hotplug_lock){++++}-{0:0}, at: _cpu_up+0x78/0x420

It's difficult to tell from the log but I wonder whether the problem is CPU
hotplug operation needing to fork to complete (e.g. maybe it needs to
schedule a work item and flush it?) while sched_ext enable path first blocks
forks through scx_fork_rwsem and then does cpus_read_lock(). That'd create
ABBA deadlock. It's a bit tricky as the existing code already makes it
impossible to flip the nesting order.

It could also be specific to ppc64 (e.g. there's something dependingon fork
during CPU hotplug), or at least doesn't happen on x86. I'll probe it a bit
more.

Thanks.

-- 
tejun

