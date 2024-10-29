Return-Path: <linux-kernel+bounces-386457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E839B43AE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 09:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9721F236A9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 08:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC20202F82;
	Tue, 29 Oct 2024 08:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="crIUykRg"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C5C1DF243
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 08:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730188979; cv=none; b=AWuhrIOEnh+oskhfU2HjVBuVtf8cm9q5MQx4vAX4ICLLwATM6G4gTf/hr7d93Tw+FAmHWLe5YhLrp+T4cfCmq8Xqpe/++9RJSS5i3N1opePmnI7Jl3BkLb3xKyWqI1+F5HZGTFxc0r2aCSEwf+tP33QfkIVgu7ZMdmJLfBeUXaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730188979; c=relaxed/simple;
	bh=VUedAv/Vm0ig6g+H6A9FqmCfMSKGESVF3W8HefGSG4E=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=I4zqWYDA9feKyioSD76Un83PtU92Rq8uA66+sZ6FNEP9frvrOLpqij1k3UWi0LQGYm1azeVY8we12PudHqCZt4O9Q3qinCLAh+kxS5WbgsKK0Sggr6RkraU0JJm8IbFlWZx8FGxW9mSBvcdRrTEkV+qP9SBi9H2KdB/pbvo+tgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=crIUykRg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0f198d38so746517866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 01:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1730188975; x=1730793775; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=McIeLxc/I8ZCOijPmuvx5G6a3Z9JrJHkQQNqaaLpR/s=;
        b=crIUykRg7I0IOaxjj+k7aU5+oBKlXh8Q/5v4xodCJS9Jk0/lRiKltUZYANuM14w14X
         k5D2DWZ6ET6p4rdaomMuAoOuWfcIS4Uvb+5U4Sh25ndTc/i1pgkMily1IRoHSe5IZyEr
         xGSGwNZHwFutoOq80yDPZ72dEWZqYjvokr1LY77P4g7UBvC0t8J9iHmp/JQi91VY5jIJ
         Egq7FWlFNSu7X26sv4tXv8Ij93UBDxyydjoLLhXpyWuhvHxw/APv2r/Sd2lLu7TzbtV/
         IR3yRohwD0jpQRQG92JFRTwul75dE1x3yWuzatBgbfWcAMbZMCzaLPXcW6TqNJwq5t/4
         0FCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730188975; x=1730793775;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=McIeLxc/I8ZCOijPmuvx5G6a3Z9JrJHkQQNqaaLpR/s=;
        b=kXUHqNtmms+dli7j/mpL8//U//xWn8NpKg9Qhh/NxfmW6FNtGZ8PT9UmdVTHY5K/nS
         9NZLL2uT3YicyJ1uV5IvFeNempjbri/7qFYOawvZGm/6ZELw6ElySJQo8gOTFa7Jjl7E
         e1+wDg6VoCaXAHM8UBKQPjQJKjtjOWXo8swt/Q7a5Ldk6ce+Qrw2LUxzxHlXKlWhTfyL
         LNsfCsfZMg9ltGhERqmppGNu3XGKRSK2MP22r4KWSZXkISou8CnTwxG0UqjlUoZci8j+
         ScoUW3eNSR6uey7RACDD88NQIXQ7ry3feokPVuncjgTiA1wtuN6S/rsPSiaqvg33AeCy
         hUtg==
X-Forwarded-Encrypted: i=1; AJvYcCXTPBONAeN24kZ9NwqEZgBXyHocmtYPQKy7ce09uO0jFoJb8JNRuihGbvRinE8ETYriDAh2xVk4skt/Y/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6JOvFsjRn+/JwA0Gaz/X/JmNN0TAd5g6n0eyxl+R9Mny7GRJs
	3s/cZzNVvELasMDp6KvQA2qaxusTtDoupZDIi33j2f4Heh1gbrkZvBhn7uaEQljX8EZbPa/Yoo0
	NeNyYI06Vmq0svD+yYvCW3Y3uwUFfgvAxt6yq8A==
X-Google-Smtp-Source: AGHT+IFezQjqaoM6cFT+taUuHTrTbswQpDSP0bXqMBfH/ImJxymn05/BoWrJCAQmg8UKRqW79Rou5DUp0G0OhPPsqaM=
X-Received: by 2002:a17:907:60c8:b0:a9a:dfa5:47d2 with SMTP id
 a640c23a62f3a-a9de61f5a6emr1001801466b.59.1730188975265; Tue, 29 Oct 2024
 01:02:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 29 Oct 2024 09:02:44 +0100
Message-ID: <CAKPOu+9DyMbKLhyJb7aMLDTb=Fh0T8Teb9sjuf_pze+XWT1VaQ@mail.gmail.com>
Subject: Oops in netfs_rreq_unlock_folios_pgpriv2
To: David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi David,

maybe this crash is related to your recent netfs refactoring work; it is on
a server with heavy NFS traffic (with fscache enabled). The kernel is
6.11.5 plus a dozen patches that are not relevant for NFS/netfs/fscache.

 BUG: unable to handle page fault for address: 0000025882015121
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP PTI
 CPU: 11 UID: 0 PID: 247837 Comm: kworker/u193:32 Not tainted
6.11.5-cm4all1-hp+ #219
 Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89
10/17/2018
 Workqueue: nfsiod rpc_async_release
 RIP: 0010:netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
 Code: 4c 8b 04 24 48 85 c0 49 89 c5 0f 84 38 01 00 00 49 81 fd 06 04 00 00
0f 84 f2 00 00 00 49 81 fd 02 04 00 00 0f 84 35 02 00 00 <49> 8b 45 20 ba
00 10 00 00 49 8b 4d 00 48 c1 e0 0c 83 e1 40 74 08
 RSP: 0018:ffffb0056373fc90 EFLAGS: 00010216
 RAX: 000000000000002d RBX: ffff89de0d2a6780 RCX: 0000000000000001
 RDX: 00000000000000ad RSI: 0000000000000001 RDI: ffff89deb02e7b50
 RBP: 0000000000000000 R08: ffff89de3c9e9400 R09: 000000000000002c
 R10: 0000000000000008 R11: 0000000000000001 R12: 00000000000000b7
 R13: 0000025882015101 R14: 0000000000000000 R15: ffffb0056373fd28
 FS:  0000000000000000(0000) GS:ffff89f51fac0000(0000)
knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000025882015121 CR3: 000000005942e006 CR4: 00000000001706f0
 Call Trace:
  <TASK>
  ? __die+0x1f/0x60
  ? page_fault_oops+0x15c/0x450
  ? search_extable+0x22/0x30
  ? netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
  ? search_module_extables+0xe/0x40
  ? exc_page_fault+0x5e/0x100
  ? asm_exc_page_fault+0x22/0x30
  ? netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
  ? select_task_rq_fair+0x1ed/0x1370
  netfs_rreq_unlock_folios+0x40c/0x4b0
  netfs_rreq_assess+0x348/0x580
  netfs_subreq_terminated+0x193/0x2a0
  nfs_netfs_read_completion+0x97/0xb0
  nfs_read_completion+0x12e/0x200
  rpc_free_task+0x39/0x60
  rpc_async_release+0x2b/0x40
  process_one_work+0x134/0x2e0
  worker_thread+0x299/0x3a0
  ? __pfx_worker_thread+0x10/0x10
  kthread+0xba/0xe0
  ? __pfx_kthread+0x10/0x10
  ret_from_fork+0x30/0x50
  ? __pfx_kthread+0x10/0x10
  ret_from_fork_asm+0x1a/0x30
  </TASK>
 Modules linked in:
 CR2: 0000025882015121
 ---[ end trace 0000000000000000 ]---
 ERST: [Firmware Warn]: Firmware does not respond in time.
 pstore: backend (erst) writing error (-5)
 RIP: 0010:netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
 Code: 4c 8b 04 24 48 85 c0 49 89 c5 0f 84 38 01 00 00 49 81 fd 06 04 00 00
0f 84 f2 00 00 00 49 81 fd 02 04 00 00 0f 84 35 02 00 00 <49> 8b 45 20 ba
00 10 00 00 49 8b 4d 00 48 c1 e0 0c 83 e1 40 74 08
 RSP: 0018:ffffb0056373fc90 EFLAGS: 00010216
 RAX: 000000000000002d RBX: ffff89de0d2a6780 RCX: 0000000000000001
 RDX: 00000000000000ad RSI: 0000000000000001 RDI: ffff89deb02e7b50
 RBP: 0000000000000000 R08: ffff89de3c9e9400 R09: 000000000000002c
 R10: 0000000000000008 R11: 0000000000000001 R12: 00000000000000b7
 R13: 0000025882015101 R14: 0000000000000000 R15: ffffb0056373fd28
 FS:  0000000000000000(0000) GS:ffff89f51fac0000(0000)
knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000025882015121 CR3: 000000005942e006 CR4: 00000000001706f0
 note: kworker/u193:32[247837] exited with irqs disabled

 (gdb) p netfs_rreq_unlock_folios_pgpriv2+0xd2
 $1 = (void (*)(struct netfs_io_request *, size_t *)) 0xffffffff813d80c2
<netfs_rreq_unlock_folios_pgpriv2+210>
 (gdb) disassemble netfs_rreq_unlock_folios_pgpriv2+0xd2
 Dump of assembler code for function netfs_rreq_unlock_folios_pgpriv2:
 [...]
   0xffffffff813d8093 <+163>: call   0xffffffff81f0ec70 <xas_find>
   0xffffffff813d8098 <+168>: mov    (%rsp),%r8
   0xffffffff813d809c <+172>: test   %rax,%rax
   0xffffffff813d809f <+175>: mov    %rax,%r13
   0xffffffff813d80a2 <+178>: je     0xffffffff813d81e0
<netfs_rreq_unlock_folios_pgpriv2+496>
   0xffffffff813d80a8 <+184>: cmp    $0x406,%r13
   0xffffffff813d80af <+191>: je     0xffffffff813d81a7
<netfs_rreq_unlock_folios_pgpriv2+439>
   0xffffffff813d80b5 <+197>: cmp    $0x402,%r13
   0xffffffff813d80bc <+204>: je     0xffffffff813d82f7
<netfs_rreq_unlock_folios_pgpriv2+775>
   0xffffffff813d80c2 <+210>: mov    0x20(%r13),%rax
   0xffffffff813d80c6 <+214>: mov    $0x1000,%edx
   0xffffffff813d80cb <+219>: mov    0x0(%r13),%rcx
   0xffffffff813d80cf <+223>: shl    $0xc,%rax
   0xffffffff813d80d3 <+227>: and    $0x40,%ecx
   0xffffffff813d80d6 <+230>: je     0xffffffff813d80e0
<netfs_rreq_unlock_folios_pgpriv2+240>
   0xffffffff813d80d8 <+232>: movzbl 0x40(%r13),%ecx
   0xffffffff813d80dd <+237>: shl    %cl,%rdx


Right now, the machine is running and I have an unstripped kernel, just in
case you need more information from /proc/kcore.

Max

[resent as text/plain only - damn you, gmail!]

