Return-Path: <linux-kernel+bounces-211230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5208904EBE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B701C2211F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16B016D330;
	Wed, 12 Jun 2024 09:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Z4+OcGkg"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9FC152DF7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 09:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718183047; cv=none; b=MDeSjY6RiG0Fl4iyqwKpQ4uPvsBpaa0Yt4dIL/Ru1rzRFdIbjkDytGg0ijFOjlJVzi8hiWVeI/x+qyZVyabal6U1xN7WyjBxAkJ1hXNZeWtufZ3fhT9UP3pJJx5sS4JlGzxIXpFZyIFpme51xHPiSDyDpbY9JETLAy6qoJad+Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718183047; c=relaxed/simple;
	bh=k/9H0pM0A0dFO3ilwRedgqW0NIzBimUeZ5MYY4JstAY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m+Q6xNWRgvcyPIbS4YCzoakjhw3BI+2rbY+jvIy9HBr45sUEy9XScbHrjZh2gL1GpLwLUXSu0rF/VKpY457Y8e0f3q+/OfWql6ZGpNTColxHtf+2LTe8KTsiGmXOfz5JsRzdYsZh0XFHdvSpVIag/E3h9n3DLDTKLUH1n/p5F+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Z4+OcGkg; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 656B640E016C;
	Wed, 12 Jun 2024 09:04:01 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id d1YnLNVEWZxb; Wed, 12 Jun 2024 09:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1718183038; bh=H8qBLyR0FUbO0sc9bD5N/JpT1XyBDi0j6su6LjJZlqM=;
	h=Date:From:To:Cc:Subject:From;
	b=Z4+OcGkgJdc/o3j/1Vlbbt4xpgicPvhFnreMdTtAAVGhCH8BbOxMMiX8M1zut/UAk
	 HXShYJ73PKf4tigzGKw2devJsQfYFngoeHz7d3qIqUw8rBjxWfmeL2feZ7n1EiBFxq
	 sZyPkmdcZHlYcdPswupdOE4FHSq/ngKl9rEUMggknCwzHzQHfmr0sjUioVNsu0WwW3
	 mQAUPEvriInx/gAJvbxrakZ8BmnLLh1PhOGavEduketHWsWWi9PbTlqMlnQbDrty2g
	 js0TtQlYU2Q/9CvJVhkKUKJmJMbFY74YHrZTbn1CilPmfPGcrr8USBr+9IqmU89MOz
	 u/3C5vVpTkUGi9wz6pNXOlLEmsv4ltpbq8rflHW3rFjymSXOMUHNYcjnKu0QBA1s6o
	 UsaO4ByWA9MT9NeOetXQRq8Pbpi4FJZM3oNw7b09Rr3k63VmllW1IhJqCd26b0Frqj
	 kxJcN8RNoByal4hHkcTCm02Wuj67xlyG3/W4OOK7N0ij+SPHxITj5jNYazrR5pqfgy
	 HUAoEOR5P/O9eZFaD4TZvIGh5Y2Njqemde4nFp1Kv5qibOttmpbwqWWyVF3eG9R2iC
	 y01RplkUwgrCQK05vTQGWo73Y6aH5bbWazpbJvsxM+946nBOv/9IdZ3EKyA66GvxNy
	 9U0mwOhCnKJr06oU20jA8Mhg=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EDF8C40E0081;
	Wed, 12 Jun 2024 09:03:52 +0000 (UTC)
Date: Wed, 12 Jun 2024 11:03:47 +0200
From: Borislav Petkov <bp@alien8.de>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>
Cc: Narasimhan V <Narasimhan.V@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	lkml <linux-kernel@vger.kernel.org>
Subject: WARNING: CPU: 7 PID: 0 at kernel/time/timer_migration.c:1332
 tmigr_inactive_up+0xd2/0x190
Message-ID: <20240612090347.GBZmlkc5PwlVpOG6vT@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

one of our testing machines hit this today:

...

resctrl: SMBA allocation detected
resctrl: L3 monitoring detected
IPI shorthand broadcast: enabled
sched_clock: Marking stable (5784002478, 2856728882)->(8961215448, -320484088)
Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
------------[ cut here ]------------
registered taskstats version 1
WARNING: CPU: 7 PID: 0 at kernel/time/timer_migration.c:1332 tmigr_inactive_up+0xd2/0x190
Modules linked in:
CPU: 7 PID: 0 Comm: swapper/7 Not tainted 6.10.0-rc3-1718152260480 #1
RIP: 0010:tmigr_inactive_up+0xd2/0x190
Code: cf 74 0f 45 84 c9 75 0a 41 0f b6 44 24 60 41 88 45 18 48 b8 ff ff ff ff ff ff ff 7f 49 39 45 08 74 0a 49 83 7c 24 08 00 74 02 <0f> 0b 66 90 48 83 c4 18 44 89 c8 5b 41 5c 41 5d 41 5e 41 5f 5d e9
RSP: 0018:ff53ce854029fd00 EFLAGS: 00010086
RAX: 7fffffffffffffff RBX: 000000000010ff00 RCX: 0000000000000000
RDX: 00000001701e4800 RSI: 0000000000000000 RDI: ff44640202b1e800
RBP: ff53ce854029fd40 R08: ff4464110bda61c0 R09: 0000000000000000
R10: 0000000000000080 R11: 00000000063c38d0 R12: ff44640202b1e800
R13: ff53ce854029fd50 R14: 0000000000000000 R15: ff44640202b1e850
FS: 0000000000000000(0000) GS:ff4464110bd80000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000007403c001 CR4: 0000000000771ef0
PKRU: 55555554
Call Trace:
<TASK>
? show_regs+0x6d/0x80
? __warn+0x8c/0x140
? tmigr_inactive_up+0xd2/0x190
? report_bug+0x193/0x1a0
? handle_bug+0x46/0x80
? exc_invalid_op+0x1d/0x80
? asm_exc_invalid_op+0x1f/0x30
? tmigr_inactive_up+0xd2/0x190
? __pfx_hrtimer_get_next_event+0x10/0x10
tmigr_cpu_deactivate+0xba/0x180
__get_next_timer_interrupt+0x1e8/0x310
timer_base_try_to_set_idle+0x42/0x60
? srso_alias_return_thunk+0x5/0xfbef5
tick_nohz_idle_stop_tick+0xda/0x380
do_idle+0x1cd/0x240
? complete+0x71/0x80
cpu_startup_entry+0x30/0x40
start_secondary+0x12b/0x160
common_startup_64+0x13e/0x141
</TASK>
---[ end trace 0000000000000000 ]---

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

