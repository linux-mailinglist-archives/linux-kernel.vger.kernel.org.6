Return-Path: <linux-kernel+bounces-258959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA11938F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 14:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4B4281E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9FF16D4D8;
	Mon, 22 Jul 2024 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="MxNfwqq9"
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7CA322E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 12:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721651972; cv=none; b=Vpugg312KNojeaYHb1aAxDM+y/ZMlaSE6xj/PDQ85831LtkYhD2pPStQ8H+ah5om+u1cj358ZUEKRJTi0goF3PzvT1hMHJ/yXYOsD/B0MRigSgzoOi/OCoPNp98hczlK+KzPGuIG4YrvZca7xZKfD2i8ZajHlQuUFi0AIYpZ2Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721651972; c=relaxed/simple;
	bh=q4B6CnIBisdjIeaTnGwa+EuAanP7Ge/LHdBNdocREGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U86e2SsTHEpwNkqc+ZALQnKEz5wl8+xSWdzvXu6tFvYuIhuE18UCVbLfZaS3p5oo2f4iMpYHGTAUKijZblcRB6LB4vaTIlfLMHqcqt7NoO9WngOGDYwAjSODjk8AR2A7RcVuylxP6TIq+TcDA/fkFHV4ct+ZgLUChCJbKlkY9io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=MxNfwqq9; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721651954; x=1722256754; i=spasswolf@web.de;
	bh=J4lM5L5pKqgUoxmlP002m5V+oxTlNrdG/aRja77Futo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:cc:content-transfer-encoding:content-type:
	 date:from:message-id:mime-version:reply-to:subject:to;
	b=MxNfwqq9JdNKQHlpkeVqaG8mqk+C8skMNeKWoXhO0JuwNwKM4MTq2OtK7w0a6GLY
	 V1FysmpG61Dn95V1K49QjNztaGU3C132rBjFOEghENrmKcqFrlEb8FeltWumRFxqn
	 sDfiPLJiVk+KbB6+Mu5J+JDnkwIs0xCZB2n3qIXGIhsYOILaBXidfKEArCg0R68Yf
	 pyv0ITsswN8EggqWCbDyYNCwL0ngvta6C37B8mT+/enXraGnHu+P/VcUV09GpAAt+
	 SN9RrMD0QeNg5PDbnC2Zbzy3qkdY81/yr4MIZa8mMhjkP1XX4YptJsa9K1Or2k9lk
	 RUkOV6TQwYGnj0sR+Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost.localdomain ([84.119.92.193]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1Mq1CA-1s0g9g0ueY-00j3AA; Mon, 22 Jul 2024 14:39:14 +0200
From: Bert Karwatzki <spasswolf@web.de>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Bert Karwatzki <spasswolf@web.de>,
	tglx@linutronix.de,
	frederic@kernel.org,
	linux-kernel@vger.kernel.org
Subject: commit 7a5ee4aa61af causes warning on boot
Date: Mon, 22 Jul 2024 14:39:11 +0200
Message-ID: <20240722123912.3602-1-spasswolf@web.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: 20240717094940.18687-1-anna-maria@linutronix.de 
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:bPpuyn1lpMqXFRyyVvPZ4LyJ2WAx5kJymCBMAAu4SDvG9hjHUCq
 PlS+csMRFdDxK6sOf7J3DjFSmH1URTLPcLLP14wHGuHgxcgYcREPqOdJFtLPt1pMT1sYW3i
 aCITdd9sdwT3GmdbFYGEHPi9dlmyHHldORDr6axbrM6XEjpWeOBT7KHGMi77lgpKAGA5UoS
 +HeS0I91Ym+nh52Qt4LXQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jtcD4LYMh8E=;JaaXK/ApsxBnrWCGGV9pwxO/IZ+
 1sQl7VmD2SO0J0+43mXDfGRb8rzpvfEiAxVPP0YyFbhSEgC0QkAzyYAMcmaQBX4kTLxS7YlaE
 3QxiKM5xT07aPXD3U4JLt5Wk+8il5GHQ84zG7wWPIRrHnima/totfexL04PzkkwziTDKku8pB
 wVG+ouNvlEAhfHLtpSMzZxhwiFWzTcZnkMAwsxHyeP1XShP61cQKKbJqe1STRNAotK4o59+E8
 TDCxB7FiNgPW4GHVRyYWBt0LP3PrKVw6tDsi/D5WddzmtIbVgYUFKypch7DrS25RLTsbxEbmd
 +iGURJEfyLZQLzg3WXuUnooSTNcv4F7ZHZXOSkkhJlUfUaXtDus92JxT1TA9HBRbGECUKnPIK
 rgx62ukLxoy967IBxxFNlhVSVT1TRJQcnLR1aatF98W0tBE4ml8BvmKbyK2kpLiTu2kNL4N5t
 5pesX6wrxqvn0vGttv86T84wjtksvdDamOU4Pspmcnp3w16vLFTVReBVpEhQ40XTe8vyM1eLY
 HTz77EF/is/WFm9EApgs0i50eQjmb2+Xbi7b4sMHkQAO1VdaASqxBsA6TS9Jysi68bqNmXTMD
 COyBXbOkVt3BiFTmcU94RjZEJnlJ+BjwAJbM+OBUnqdnwbSdDT0mphTXpK+KpAEqNalbtX8J2
 IAwQzeG79E9Kw71gJYDCnS17F+CRep6w7yWO3f9dd/BXFRA2W2U03j5W7a09sFMg8C5sctBsw
 zm2Tk9+m//GPkbrMfewlDT+tu3jEyUm/yQpcjPonCIwAW2JE6yOBKGgtEc/3jVfp5wKn5XqyG
 w7TXBsFDgaqYV0xBBEYoCv6Q==

Since linux-next-20240722 the following warning is shown on boot which can
be bisected to commit 7a5ee4aa61af:

[    T1] ------------[ cut here ]------------
[    T1] WARNING: CPU: 0 PID: 1 at kernel/time/timer_migration.c:1742 tmigr_cpu_prepare+0x469/0x540
[    T1] Modules linked in:
[    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.10.0-rc6-bisect-00002-g7a5ee4aa61af-dirty #135
[    T1] Hardware name: Micro-Star International Co., Ltd. Alpha 15 B5EEK/MS-158L, BIOS E158LAMS.107 11/10/2021
[    T1] RIP: 0010:tmigr_cpu_prepare+0x469/0x540
[    T1] Code: fc 7d 00 0f b6 43 60 48 89 de 48 89 ef 48 8d 54 24 28 88 44 24 40 e8 16 fb ff ff 84 c0 75 94 48 83 7d 08 00 74 8d 0f 0b eb 89 <0f> 0b e9 d6 fb ff ff 48 89 ef eb 08 49 8b 7d 00 41 83 ec 01 48 8b
[    T1] RSP: 0018:ffffa2e3c0107d60 EFLAGS: 00010246
[    T1] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    T1] RDX: ffff94edee61bcc0 RSI: 0000000000000040 RDI: 0000000000000000
[    T1] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[    T1] R10: ffffa2e3c0107d40 R11: ffffffff90099d48 R12: 0000000000000000
[    T1] R13: 0000000000017400 R14: 0000000000000040 R15: ffff94edee61bcc0
[    T1] FS:  0000000000000000(0000) GS:ffff94edee600000(0000) knlGS:0000000000000000
[    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    T1] CR2: ffff94e666c01000 CR3: 0000000826818000 CR4: 0000000000750ef0
[    T1] PKRU: 55555554
[    T1] Call Trace:
[    T1]  <TASK>
[    T1]  ? __warn+0x6a/0xc0
[    T1]  ? tmigr_cpu_prepare+0x469/0x540
[    T1]  ? report_bug+0x142/0x180
[    T1]  ? handle_bug+0x3a/0x70
[    T1]  ? exc_invalid_op+0x17/0x70
[    T1]  ? asm_exc_invalid_op+0x1a/0x20
[    T1]  ? tmigr_cpu_prepare+0x469/0x540
[    T1]  ? srso_alias_return_thunk+0x5/0xfbef5
[    T1]  ? prb_read_valid+0x16/0x20
[    T1]  ? srso_alias_return_thunk+0x5/0xfbef5
[    T1]  ? cpuhp_issue_call+0xf7/0x170
[    T1]  ? __cpuhp_setup_state_cpuslocked+0x128/0x2c0
[    T1]  ? tmigr_trigger_active+0x30/0x30
[    T1]  ? tmigr_trigger_active+0x30/0x30
[    T1]  ? __cpuhp_setup_state+0x5e/0xe0
[    T1]  ? tick_nohz_init+0x120/0x120
[    T1]  ? tmigr_init+0xd2/0x130
[    T1]  ? tick_nohz_init+0x120/0x120
[    T1]  ? do_one_initcall+0x70/0x2c0
[    T1]  ? kernel_init_freeable+0xc5/0x260
[    T1]  ? rest_init+0xc0/0xc0
[    T1]  ? kernel_init+0x15/0x1b0
[    T1]  ? ret_from_fork+0x2f/0x50
[    T1]  ? rest_init+0xc0/0xc0
[    T1]  ? ret_from_fork_asm+0x11/0x20
[    T1]  </TASK>
[    T1] ---[ end trace 0000000000000000 ]---

Hardware: MSI Alpha 15 Notebook Ryzen 5800H (x86_64)

Bert Karwatzki

