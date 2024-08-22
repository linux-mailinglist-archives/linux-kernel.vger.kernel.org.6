Return-Path: <linux-kernel+bounces-297001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E1895B1BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F43E289730
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E9A175D2D;
	Thu, 22 Aug 2024 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B5bq7eUz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0C516F0CA
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319145; cv=none; b=PNyck8VBE1h8aIxTvaXEVE1VHIY69zxjOmXeWSWDdAKHhcxd7YlJQ5KeI/5Kmn19F1PqlH/Jp/bDe5A3mO1UAuBwHlAJOoNnFhDwL9adUpf0WeNFAq1vJQzLoth/ZmSKZK3aCMY8HKWm2tEg76LSr6goSd9ysYcExrUDi2RGFMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319145; c=relaxed/simple;
	bh=gUrHAKSaX6UcopS37quWU0A/UxZ/IMN9f951BD+QaQQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IZ0+le/QjTe5RkR6soU1OZ4VR+VncXaBBGSd7u6ptU4T6yzgEwkK9HWtIQmlCRfdUL1lFAebMQ2isz4/iXckLiXzvnYOsItNrVzCmOzKxzXVP+PfpSnQ0dJsB6OXrjvAc3341sbfkLMiI62LYAK4hODikmgw8iAyCK/q0o4kgPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B5bq7eUz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724319143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VrRQKavLiiaQBn0XrFebgkKC6r5pSaJyduSfzpagwWQ=;
	b=B5bq7eUz1SZ81hHGYstmfeuQvoN4ojSPC6XmZf2re4u1ibnQv3mACih6OiySTYrJ5huT/Z
	uvJ0GIE606NUfZ4PonLH4a+USYRimTYo6eNHc0vXRh1v92OZSRBC+9MKu/T8J+pXlAFBfr
	b8ySl56qq3PFdo5sMu0+Ew+TyjmlfDE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-r5F1JFsbPMeyVteMA6xmCQ-1; Thu, 22 Aug 2024 05:32:21 -0400
X-MC-Unique: r5F1JFsbPMeyVteMA6xmCQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a864097e296so89225566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 02:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724319140; x=1724923940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VrRQKavLiiaQBn0XrFebgkKC6r5pSaJyduSfzpagwWQ=;
        b=PqN+imH5RuyVdAc8OCiIghGniYtn2mxOaNofsDARk3Mk2YfDBSwu43OhFwIPvsCxOn
         UZ7qTCLW4g0z4JOhzCChKm1n0CkMl9ONsaCOKc3vc25bJaq92lwK1j+yTfMVUOP1OTXx
         QpEDMjq7qzSMDKwuXlazkkpWXyzjCh5x1H7uzZOgHE6cp/Dnnk4+C/STmiREHpJ/NI1/
         zOmCOgGV24t5Ehl+0ZmiUdQVean63HNRTU6y7qRWmQmwe2xRd/EzmegrpTo/gqZbxyP8
         r05TIPbkvr3zQ1WfYjpY4d8jsGxw0F6aAUv/z2phs0hWSX/MqcApy8ME20BVY26KB8nq
         TvGg==
X-Forwarded-Encrypted: i=1; AJvYcCWGPnZu/xNbbspmPkGatHXFUsRVd5olpHWkgaNuWoY36iWSsAV4GuflntYLIunRnnIFa2bwRbYYFfSnVNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVTTSvRTJ1vb7t9WzgwuXSH+oZeZ+VcF/99Kn18iQyDo5fBRLY
	6ClK6t+trv5jAwPao7K0FYJ46759d3miVmBgzYwEBGsFSMklHBEBekDcyLM3rPbXy9sS+LJEdMe
	PU1WQ7croMyMdvdd4RWD7Xe4NCsamTeQL0uuv6KsHrbbBXFyVJUvzokHEdt+xiDSU/IEKSMBY8r
	tGDMakezJXP9mmEQdjmCavk5H85lp/AdxIbDy/
X-Received: by 2002:a17:906:730c:b0:a7a:cc10:667c with SMTP id a640c23a62f3a-a8691aec96dmr125318366b.16.1724319139982;
        Thu, 22 Aug 2024 02:32:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFk8SCJ3mWSlNwEFsNNBwd7rluMSnRXE/8EGRVCmnmvn66vZXHiZpkq+BeFKufzw7mKdK1vPTpyB8ACMrOZ9ac=
X-Received: by 2002:a17:906:730c:b0:a7a:cc10:667c with SMTP id
 a640c23a62f3a-a8691aec96dmr125311966b.16.1724319138642; Thu, 22 Aug 2024
 02:32:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820130001.124768-1-tglozar@redhat.com> <20240821160316.02c03c44@gandalf.local.home>
In-Reply-To: <20240821160316.02c03c44@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 22 Aug 2024 11:32:07 +0200
Message-ID: <CAP4=nvRTH5VxSO3VSDCospWcZagawTMs0L9J_kcKdGSkn7xT_Q@mail.gmail.com>
Subject: Re: [PATCH] tracing/timerlat: Check tlat_var for NULL in timerlat_fd_release
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkacur@redhat.com, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 21. 8. 2024 v 22:02 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.org>=
 napsal:
>
> I'm able to reproduce this with the above. Unfortunately, I can still
> reproduce it after applying this patch :-(
>

Thank you for looking at this. I was at first not too sure about
whether this is the proper fix, but after some discussion with Luis
(in CC), we have come to the conclusion that the double-close of the
timerlat_fd might be a possible explanation, and this patch worked for
both of us. Are you reproducing the same bug (NULL pointer dereference
in hrtimer_active) with the patch? IIUC that should not happen anymore
since the patch explicitly checks for zero in the hrtimer structure.

I have caught however a different panic in addition to the one
reported above while testing "rtla: Support idle state disabling via
libcpupower in timerlat" on an EL9 RT kernel:

BUG: kernel NULL pointer dereference, address: 0000000000000014
CPU: 6 PID: 1 Comm: systemd Kdump: loaded Tainted: G        W
-------  ---  5.14.0-452.el9.x86_64+rt #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39
04/01/2014
RIP: 0010:task_dump_owner+0x3d/0x100
RSP: 0018:ffffadd6c0013aa8 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffffa00c864f4580 RCX: ffffa00c87453e10
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffa00c864f4580
RBP: ffffa00c87453e10 R08: ffffa00c87418e80 R09: ffffa00c87418e80
R10: ffffa00c88236600 R11: ffffffffb73f1868 R12: ffffa00c87453e0c
R13: 0000000000000000 R14: ffffa00cb5e430c0 R15: ffffa00cb5e430c8
FS:  00007f9336b41b40(0000) GS:ffffa00cffd80000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000014 CR3: 00000000025ee002 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
<TASK>
? show_trace_log_lvl+0x1c4/0x2df
? show_trace_log_lvl+0x1c4/0x2df
? proc_pid_make_inode+0xa0/0x110
? __die_body.cold+0x8/0xd
? page_fault_oops+0x140/0x180
? do_user_addr_fault+0x61/0x690
? kvm_read_and_reset_apf_flags+0x45/0x60
? exc_page_fault+0x65/0x180
? asm_exc_page_fault+0x22/0x30
? task_dump_owner+0x3d/0x100
? task_dump_owner+0x36/0x100
proc_pid_make_inode+0xa0/0x110
proc_pid_instantiate+0x21/0xb0
proc_pid_lookup+0x95/0x170
proc_root_lookup+0x1d/0x50
__lookup_slow+0x9c/0x150
walk_component+0x158/0x1d0
link_path_walk.part.0.constprop.0+0x24e/0x3c0
? path_init+0x326/0x4d0
path_openat+0xb1/0x280
do_filp_open+0xb2/0x160
? migrate_enable+0xd5/0x150
? rt_spin_unlock+0x13/0x40
do_sys_openat2+0x96/0xd0
__x64_sys_openat+0x53/0xa0
...
</TASK>

This was preceded by a WARN:

refcount_t: addition on 0; use-after-free.
WARNING: CPU: 6 PID: 1 at lib/refcount.c:25 refcount_warn_saturate+0x74/0x1=
10
CPU: 6 PID: 1 Comm: systemd Kdump: loaded Not tainted
5.14.0-452.el9.x86_64+rt #1
RIP: 0010:refcount_warn_saturate+0x74/0x110
Call Trace:
<TASK>
[   78.184877]  proc_pid_lookup+0x161/0x170
[   78.184883]  proc_root_lookup+0x1d/0x50
[   78.184890]  __lookup_slow+0x9c/0x150
[   78.184899]  walk_component+0x158/0x1d0
[   78.184908]  link_path_walk.part.0.constprop.0+0x24e/0x3c0
[   78.184915]  ? path_init+0x326/0x4d0
[   78.184922]  path_openat+0xb1/0x280
[   78.184926]  do_filp_open+0xb2/0x160
[   78.184934]  ? migrate_enable+0xd5/0x150
[   78.184942]  ? rt_spin_unlock+0x13/0x40
[   78.184950]  do_sys_openat2+0x96/0xd0
[   78.184958]  __x64_sys_openat+0x53/0xa0
[   78.184964]  do_syscall_64+0x5c/0xf0
[   78.185011]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
...
</TASK>

> Looking at the code, the logic for handling the kthread seems off. I'll
> spend a little time to see if I can figure it out.
>

Yeah, it seems there might be multiple bugs in the user workload
handling, the other NULL pointer dereference and refcount warning
above might be related (but I have yet to reproduce it on an upstream
kernel). I'm also going to look at the code and will post any findings
here.



Tomas


