Return-Path: <linux-kernel+bounces-376480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 590879AB233
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:33:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1001C220F2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875321A01DD;
	Tue, 22 Oct 2024 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="su8s0RHB"
Received: from out203-205-221-221.mail.qq.com (out203-205-221-221.mail.qq.com [203.205.221.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15DA2E406
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729611212; cv=none; b=OF2laNGHDh7H0rzMLCAJNUeJPc819DPRLbxKdEACcIQ3j0+HPyq1rmzSj3PqqxhrJChAYYS5+74yGOTXY9dqiWTeH3jL5Qy1mxmyO+UOsZ4cCjxLNpx4RnDhBIK41WnPWHnsZuleBt3nV3lUDGunnPLaG51ZIuLTtzrJ77Q3qkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729611212; c=relaxed/simple;
	bh=cGj65xZ9ShfA/LKSalGymoQpuHqs+4hgwqbMe3QrFMA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Brx8XhQnwvELpkYg1564g0arNLwHqN119ylxpni8gKXyxs1pitE126Z+7tqLlBw8xruHvKvr0lTH1XSRZXPFMZk/qbyfb52hxAw5zs3aoRw9xdvytn5S51hzwjZ0YLV0Uk8grsFGkapSedN6C4dN7hye+7uADRZV9ZKil+ok33k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=su8s0RHB; arc=none smtp.client-ip=203.205.221.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1729610902; bh=g6+dwhEkZN0C25ovd76j+GcYPC568U79rzgvztMe/6Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=su8s0RHBtg4yWxAi6+n4o+Kpl/dcqHJMbBIAqGwhachOMFjaJ59Ccmu/JBafJVSxE
	 ZB3zrPO1oN9+lSgRwDvEW+OoZv1nvKpkaRrys1e/IHRzYGZfavpVOsUXQJymlgG/0k
	 dKg9Qm2N9KJ2VQCI9y1w1cAmZe8OKSOgA8Pd3sOc=
Received: from pek-lxu-l1.wrs.com ([111.198.227.254])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 7131ACDC; Tue, 22 Oct 2024 23:28:19 +0800
X-QQ-mid: xmsmtpt1729610899t6479w7vf
Message-ID: <tencent_AB5DCD99304FB68D9CA5E58DDE12185D8C07@qq.com>
X-QQ-XMAILINFO: NvKyM24IHTKSRwfinymltxLX/Kp4R028G0FBOhjjiWQADTJdMDvoPRVA4FFChi
	 8QwYwXJh2x5LgA3+WSWgPgdBXa92swaPZUQzCsdwnZjVj0OMoSt3y5j5PzHszYqMsE94YmiVst0q
	 H7kiJAabpail/5OTEkqhAByugL0m3mwc4PeloeynyFiDMO8cR/y9XjiYP1CTvviNjcy96IHrOnqS
	 qHmzJX8iHh/bpUTcFv6yk7SKn6LSGxqVOneuCcNvg4WsBi70m1AHHD+wNQPUCtTXS6lHq9vDX7zR
	 wzaat9jKXJ3I3RDgkzRRLReOgStpiUwRUzdmer0PidZRVcCtIOv6el70wDwvJvE752zikuL3crd5
	 /4mcbsnPO4gmlon0wntOg80Uyc6coNd81ZEO5buh+VcMct77ZVXsRuIud4CURt7gKPp+UWolfmlE
	 nHzoYj21ZVDMoIgNWn430BrYKRIMH5PYlJ6msa8AQfvbAAcNboGMF/Fxo/X6XmqvNfTSwUAkxiG7
	 LYJYGLdNDMAwQI4IiKGAgU6k29BfS+0MNkJDYh86dBg/zT+1ONqYrJcgTZxpOVGri/SRwf76h+kq
	 UFSYgKm/pM6vxr7M+8aR5VVzrpkds8/8WcEoSDlGW6U0ExkT3bB6DFBpWbZ4dZ9IF+VJtM6yqcQz
	 n3pDjFaNFBlKB9JYJHgSqlro7kn29MJQDCwYLw7AdP0JcH6uznjDOb+6aQ2/8pu3m2fb8Xr0w8wr
	 wf5B59OHmf63eskGnlll6QJMlmUdKW0xOjA3omHy7kjuDOBx07w56tXte3uJow1MwFQ7JDL1S+nV
	 +ih4p9A2MXS+PS6byPv4x9NsOYCMc9LLSUmUtqKhhetZxC++JABxVf64QYMOa5LuILwsDmzuDtcM
	 YHsHcLIFTxDAe9fgjuYAnPpdHB9LDiNVkxQ1av2OdP9Hc7rTkUIsV/qmMEXi1Iwnmz4te2oYvkBT
	 W+pG1pFjSaJSLmpULbVw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: willy@infradead.org
Cc: brauner@kernel.org,
	eadavis@qq.com,
	guohui.study@gmail.com,
	jack@suse.cz,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	lizhi.xu@windriver.com,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: Fix null-ptr-deref in write_special_inodes
Date: Tue, 22 Oct 2024 23:28:14 +0800
X-OQ-MSGID: <20241022152813.3896117-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <ZxeXBwLCsIwNYmlP@casper.infradead.org>
References: <ZxeXBwLCsIwNYmlP@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 22 Oct 2024 13:13:59 +0100, Matthew Wilcox wrote:
> On Tue, Oct 15, 2024 at 12:50:05PM +0800, Edward Adam Davis wrote:
> > There is a race condition when accessing ipimap and ipbmap.
> > 
> >         CPU1                              CPU2
> > 	====                              ====
> > 	jfs_umount
> > 	sbi->ipimap = NULL;               lmLogSync
> 
> how are we unmounting the filesystem while still writing to it?
Based on the test logs when I reproduced the problem,
[   77.691713][ T7747] jfs sbi: ffff88801d8b0000, jfs_umount
[   77.706091][ T7749] jfs sbi: ffff88801d8b0000, write_special_inodes
[   77.706976][ T7749] jfs ipbmap: 0000000000000000, ipimap: 0000000000000000, write_special_inodes
[   77.708233][ T7749] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
[   77.709985][ T7749] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
[   77.711133][ T7749] CPU: 2 PID: 7749 Comm: rpeml Not tainted 6.10.3-yocto-standard-00118-g7bc0a34d8159 #1
[   77.712466][ T7749] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
[   77.712614][ T7765] loop4: detected capacity change from 0 to 32768
[   77.713219][ T7749] RIP: 0010:write_special_inodes+0x126/0x203
[   77.715528][ T7749] Code: 48 c1 e0 2a 80 3c 02 00 74 08 4c 89 f7 e8 72 02 c3 f7 4c 8b 73 10 b8 ff ff 37 00 48 c1 e0 2a 49 8d 7e 30 48 89 fa 48 c1 ea 03 <80> 3c 02 00 74 05 e8 4f 02 c3 f7 49 8b 7e 30 c
[   77.718177][ T7749] RSP: 0018:ffffc9001229fbe8 EFLAGS: 00010206
[   77.719011][ T7749] RAX: dffffc0000000000 RBX: ffff88801d8b0000 RCX: 0000000000000000
[   77.720088][ T7749] RDX: 0000000000000006 RSI: ffffffff816ef99b RDI: 0000000000000030
[   77.721187][ T7749] RBP: ffff88810a012000 R08: 0000000000000005 R09: 0000000000000000
[   77.722284][ T7749] R10: 0000000080000000 R11: 0000000000000001 R12: ffffffff81c2be90
[   77.723383][ T7749] R13: ffff88801d8b0028 R14: 0000000000000000 R15: ffff88801d8b0038
[   77.724474][ T7749] FS:  00007f8e58b94740(0000) GS:ffff888063680000(0000) knlGS:0000000000000000
[   77.725712][ T7749] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   77.726621][ T7749] CR2: 00007fffc26cc6e8 CR3: 0000000108778000 CR4: 00000000000006f0
[   77.727715][ T7749] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   77.728813][ T7749] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   77.729901][ T7749] Call Trace:
[   77.730354][ T7749]  <TASK>
[   77.730764][ T7749]  ? die_addr.cold+0xd/0x12
[   77.731400][ T7749]  ? exc_general_protection+0x147/0x240
[   77.732177][ T7749]  ? asm_exc_general_protection+0x26/0x30
[   77.732992][ T7749]  ? __pfx_filemap_flush+0x10/0x10
[   77.733712][ T7749]  ? vprintk+0x8b/0xa0
[   77.734286][ T7749]  ? write_special_inodes+0x126/0x203
[   77.735036][ T7749]  ? write_special_inodes+0xf0/0x203
[   77.735775][ T7749]  lmLogSync+0xe8/0x71e
[   77.736360][ T7749]  ? __pfx_lmLogSync+0x10/0x10
[   77.737032][ T7749]  ? dquot_writeback_dquots+0x24f/0xb40
[   77.737810][ T7749]  ? __pfx_dquot_writeback_dquots+0x10/0x10
[   77.738631][ T7749]  jfs_syncpt.cold+0x10/0x15
[   77.739277][ T7749]  jfs_sync_fs+0x88/0xb0
[   77.739884][ T7749]  ? __pfx_jfs_sync_fs+0x10/0x10
[   77.740582][ T7749]  sync_filesystem+0x115/0x290
[   77.741255][ T7749]  generic_shutdown_super+0x83/0x360
[   77.741998][ T7749]  kill_block_super+0x40/0xa0
[   77.742652][ T7749]  deactivate_locked_super+0xc6/0x1b0
[   77.743405][ T7749]  deactivate_super+0xec/0x110
[   77.744080][ T7749]  cleanup_mnt+0x224/0x450
[   77.744707][ T7749]  task_work_run+0x156/0x250

As long as the test runs for a long time, there may be situations where sbi
uses the same address (of course, on two different CPUs), at this point,
the null pointer dereference issue will be triggered.
Based on the tests I conducted later, both T7747 and T7749 triggered the
same path when running cleanup_mnt.

BR,
Edward


