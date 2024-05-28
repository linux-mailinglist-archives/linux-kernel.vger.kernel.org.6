Return-Path: <linux-kernel+bounces-192642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B840F8D2010
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 17:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E90AB1C2306C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC73172BCE;
	Tue, 28 May 2024 15:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DBY9wQdL"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC586170855
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716909287; cv=none; b=pJPMdorw1i1Fa1X4FUhkLpcIqT1fT/OsBIMb9l7I1iRJuXHWFRobjDV8tCru5JyTehD5yk5R1nLC4shRAUHhchQ1cdBRwK3GXWeiMJhleVKxkurfOzy+wVJ34eKvWy3KDYB1WUe2MDHjKzDVPiqRu75dXCLy9OAhUfMZsFEMQ34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716909287; c=relaxed/simple;
	bh=bXkg/CgxYBXiILs6UFR7oH6OBkmjVLVOD25GL20hsao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J6fzk6C6J/CDwgKibi3KZKtkUs/1fP8FJqDaPYX9qQh3mZm6O8/MaBDxcr4sM99+zqUir60z53Vsk+npf0wg2PE1fZZyX4gVmOCiyvjea+UOCF+EB7r3jEs8FPaFYIKOA0sr3/e2mO4e7p/tsqJVxcFaxpIydv0iOuh2WHpFnHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DBY9wQdL; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=AuM0r
	CbJ0hWZ3V+vajoUI/lChlXnydV2UEWmf0D1iXQ=; b=DBY9wQdL30Y1DDfpylrwy
	K3J0skFmoD/lClkwpeCm8fs6DfCo8mGospFS10UsFgNx95p2du3ermckS3b/t7T3
	FjY0byc92tQ6UVEWfOwa9znyBKKWC/jdJCJxBdl5npng//iVCFKQGSM4SV7onQrl
	lRNZrCnYSeFYfUEH4vYZ/E=
Received: from localhost.localdomain (unknown [111.35.185.173])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wDXj7ek9FVmILt8Ag--.50944S4;
	Tue, 28 May 2024 23:13:45 +0800 (CST)
From: David Wang <00107082@163.com>
To: yjnworkstation@gmail.com
Cc: akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	willy@infradead.org
Subject: [BUG] 6.10.0-rc1: segfault at 0 when reboot with kernel config INIT_MLOCKED_ON_FREE_DEFAULT_ON=y
Date: Tue, 28 May 2024 23:13:40 +0800
Message-Id: <20240528151340.4282-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXj7ek9FVmILt8Ag--.50944S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7tF4fXF45GF4Utw18Cr4UArb_yoW8Kr4fpr
	1j9F15Cr4vg34UAF18Jr43tF18t3yqka47Xr4DGryDXF1q9F15Jw17K3y5trWDGF45u3W7
	J3WkXa18Kr1UXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07joGQDUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0g3sqmWXyBCpagAAsw

Hi,

My kernel is 6.10.0-rc1 with CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON=y, and 
I got following screen when I execute `systemctl reboot` on my system.
(The text was extracted from a console image, there may be some parse error. And my kernel was tainted mostly because of nvidia driver)

	42.855067] watchdog: watchdog0: watchdog did not stop!
	42.905871] show_signal_msg: 14 callbacks suppressed
	42.905874) systemd-shutdow[1]: segfault at 0 ip 0000000000000000 sp 00007ffcc8af7318 error 14 likely on CPU 6 (core 4, socke 42.906017] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
	42.906080] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b 
	42.906143] CPU: 6 PID: 1 Comm: systemd-shutdow Tainted: P OE 6.10.0-rc1-linan-0 #244
	42.906220] Hardware name: Micro-Star International Co., Ltd. MS-7889/B450M MORTAR MAX (MS-7889), BIOS 2.80 06/10/2020 42.906308] Call Trace:
	42.906329] <TASK>
	42.906346] panic+0x31d/0x350
	42.906375) ? srso_return_thunk+0x5/0x5f
	42.906411] do_exit+0x968/0xad0
	42.906441] do_group_exit+0x2c/0x80
	42.906472] get_signal+0x876/0x8a0
	42.906502] arch_do_signal_or_restart+0x2a/0x240
	42.906544] irgentry_exit_to_user_mode+0xc2/0x160
	42.906585] asm_exc_page_fault+0x22/0x30
	42.906619] RIP: 0033:0x0
	42.906640] Code: Unable to access opcode bytes at 0xfffft fffffffd6. 
	42.906693] RSP: 002b:00007ffcc8af7318 EFLAGS: 00010206
	42.906736] RAX: 0000000000000011 RBX: 000000000328adea RCX: 0000000000000005 
	42.906794] RDX: 00007ffcc8af73b0 RSI: 0000000000000ea8 RDI: 0000000000000001 
	42.906852] RBP: 00007ffcc8af73be R08: 003b459fca9238c4 R09: 0000000000000069 
	42.906910] R10: 0000000000000008 R11: 0000000000000202 R12: 00007ffcc8af7330 
	42.906968] R13: 0000000000000ea8 R14: 0000000000000000 R15: 0000000000000000 
	42.907029] </TASK>
	42.907328] Kernel Offset: 0x21a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff) 
	43.081928) --- [ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---


I rebuild the kernel with `CONFIG_INIT_MLOCKED_ON_FREE_DEFAULT_ON not set`, the system can reboot normally.
My guess, some memory is zeroed unproperly when reboot?


David


