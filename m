Return-Path: <linux-kernel+bounces-320619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 908A0970CD8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 07:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CE81282183
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 05:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC1F1AC8BF;
	Mon,  9 Sep 2024 05:09:47 +0000 (UTC)
Received: from audible.transient.net (audible.transient.net [24.143.126.66])
	by smtp.subspace.kernel.org (Postfix) with SMTP id BB08A41C79
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 05:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.143.126.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725858587; cv=none; b=je4BOlw8lSbdeyR3trIPEIfJ0vgIUeX7VU/QIsHNz+IQ1C6BeT683cv7u2atpilMCQkYoC24GGYpu7muZbQdrAlAxjFtO3J4P4T9Yy8aXpl3x+crH/S8ycC8reZYkygtaJ8CVuZI5THU6I0DbHFn8h3RzZA9w8vIOcb69ocNce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725858587; c=relaxed/simple;
	bh=/2kXoqBNQdf7ykw6S13Nf1luYg7cKmioSmSLrJVJFGA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DEgmMilc38n4AJ28pouuMQoDJ3Ipws+GqI/fngHl16J8zaVRpu5udpixwzdxw0AupMUX/d5q8Allo+L6g/PBN7WkcXLQLAc1u6h5St7AOQ1BrK/XoR6XvQMrrXgae+SECfYuZGDWAsdeZ64+XpRoqehZXdwifINwqc/A2WxeY7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=audible.transient.net; spf=none smtp.mailfrom=audible.transient.net; arc=none smtp.client-ip=24.143.126.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=audible.transient.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=audible.transient.net
Received: (qmail 2552 invoked from network); 9 Sep 2024 05:03:04 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 9 Sep 2024 05:03:04 -0000
Received: (nullmailer pid 16368 invoked by uid 1000);
	Mon, 09 Sep 2024 05:03:03 -0000
Date: Mon, 9 Sep 2024 05:03:03 +0000
From: Jamie Heilman <jamie@audible.transient.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, tglx@linutronix.de
Subject: regression in 6.6.46; arch/x86/mm/pti.c
Message-ID: <Zt6Bh2J5xMcCETbb@audible.transient.net>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	tglx@linutronix.de
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

3db03fb4995e ("x86/mm: Fix pti_clone_entry_text() for i386") which got
landed in 6.6.46, has introduced two back to back warnings on boot on
my 32bit system (found on 6.6.50):

------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at arch/x86/mm/pti.c:256 pti_clone_pgtable+0x1ba/0x2e8
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Tainted: G                T  6.6.50 #3
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./To be filled by O.E.M., BIOS 080014  06/01/2009
EIP: pti_clone_pgtable+0x1ba/0x2e8
Code: 00 00 89 f8 e8 57 fd ff ff 85 c0 89 c6 74 1d 8b 08 31 d2 89 55 f0 8b 55 f0 89 c8 25 80 00 00 00 89 45 ec 8b 45 ec 09 d0 74 0e <0f> 0b 0f 0b e9 62 ff ff ff 2e 8d 74 26 00 89 c8 31 d2 89 55 f0 83
EAX: 00000080 EBX: 00000000 ECX: 014001e3 EDX: 00000000
ESI: 81c0f050 EDI: 815a4630 EBP: 81caff70 ESP: 81caff44
DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010202
CR0: 80050033 CR2: ffbff000 CR3: 01830000 CR4: 000006b0
Call Trace:
 ? show_regs+0x4c/0x5c
 ? __warn+0x6e/0x114
 ? pti_clone_pgtable+0x1ba/0x2e8
 ? pti_clone_pgtable+0x1ba/0x2e8
 ? report_bug+0xd5/0x110
 ? exc_overflow+0x58/0x58
 ? handle_bug+0x31/0x50
 ? exc_invalid_op+0x1b/0x70
 ? handle_exception+0x100/0x100
 ? __SCT__bpf_dispatcher_xdp_call+0x8/0x8
 ? exc_overflow+0x58/0x58
 ? pti_clone_pgtable+0x1ba/0x2e8
 ? exc_overflow+0x58/0x58
 ? pti_clone_pgtable+0x1ba/0x2e8
 ? __SCT__bpf_dispatcher_xdp_call+0x8/0x8
 ? rest_init+0x7c/0x7c
 pti_finalize+0x30/0x4c
 kernel_init+0x49/0x1c4
 ? schedule_tail+0x37/0x40
 ret_from_fork+0x44/0x50
 ? rest_init+0x7c/0x7c
 ret_from_fork_asm+0x12/0x18
 entry_INT80_32+0xef/0xf4
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at arch/x86/mm/pti.c:394 pti_clone_pgtable+0x1bc/0x2e8
Modules linked in:
CPU: 0 PID: 1 Comm: swapper Tainted: G        W       T  6.6.50 #3
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./To be filled by O.E.M., BIOS 080014  06/01/2009
EIP: pti_clone_pgtable+0x1bc/0x2e8
Code: 89 f8 e8 57 fd ff ff 85 c0 89 c6 74 1d 8b 08 31 d2 89 55 f0 8b 55 f0 89 c8 25 80 00 00 00 89 45 ec 8b 45 ec 09 d0 74 0e 0f 0b <0f> 0b e9 62 ff ff ff 2e 8d 74 26 00 89 c8 31 d2 89 55 f0 83 e0 9f
EAX: 00000080 EBX: 00000000 ECX: 014001e3 EDX: 00000000
ESI: 81c0f050 EDI: 815a4630 EBP: 81caff70 ESP: 81caff44
DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010202
CR0: 80050033 CR2: ffbff000 CR3: 01830000 CR4: 000006b0
Call Trace:
 ? show_regs+0x4c/0x5c
 ? __warn+0x6e/0x114
 ? pti_clone_pgtable+0x1bc/0x2e8
 ? pti_clone_pgtable+0x1bc/0x2e8
 ? report_bug+0xd5/0x110
 ? exc_overflow+0x58/0x58
 ? handle_bug+0x31/0x50
 ? exc_invalid_op+0x1b/0x70
 ? handle_exception+0x100/0x100
 ? __SCT__bpf_dispatcher_xdp_call+0x8/0x8
 ? exc_overflow+0x58/0x58
 ? pti_clone_pgtable+0x1bc/0x2e8
 ? exc_overflow+0x58/0x58
 ? pti_clone_pgtable+0x1bc/0x2e8
 ? __SCT__bpf_dispatcher_xdp_call+0x8/0x8
 ? rest_init+0x7c/0x7c
 pti_finalize+0x30/0x4c
 kernel_init+0x49/0x1c4
 ? schedule_tail+0x37/0x40
 ret_from_fork+0x44/0x50
 ? rest_init+0x7c/0x7c
 ret_from_fork_asm+0x12/0x18
 entry_INT80_32+0xef/0xf4
---[ end trace 0000000000000000 ]---

Reverting that commit removes the warnings (tested against 6.6.50).
The follow-on commit of c48b5a4cf312 ("x86/mm: Fix PTI for i386 some
more") doesn't apply cleanly to 6.6.50, but I did try out a build of
6.11-rc7 and that works fine too with no warnings on boot.

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/

