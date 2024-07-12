Return-Path: <linux-kernel+bounces-250694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2E192FB36
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:21:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9868DB21BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C041662EC;
	Fri, 12 Jul 2024 13:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="neGe+Nnt"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B59C16FF28
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720790489; cv=none; b=h7UbtuBs+ryMIHmzLxeuZCXyX9UTlqqH2bUEFbkE2KvJ9cTe/DtZ4bOnxXVZ+YGlRVkQM/+1mEu3YtfofxY2uYsRPH9SFDMvQG5qq1mFRhGb0MM2/XosduBUoN4JzCHGXl6HiYau4230MqCTWSdEreMb+vozoZxJIyfT0JhH1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720790489; c=relaxed/simple;
	bh=b9Hiyb9V12OK0cWf/wcBNEcB+j8b6dfOtprF3E37KfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZyhkWKJJyq88h8qXLa0gIkffQfN6omNLAtKmjujug4VxQIcuH0sqZAcdPQ8XvFMsk7BUbGEnqr+ExLuDIt9jzk2fVXluWwhy/wrESqcImYhD5aJFkvPRGegZrZwLs3BB7UTqSiDAo+wSvAogq1qGZuohTxZM8YGYd0zisdudb8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=neGe+Nnt; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=HxMoF
	pqBNOKvW9AuKefuACYfanWfnrRyWhtwQoiUxdE=; b=neGe+NntTW2M2mqZ0hBbU
	btskUR43l5vvfl1dejrIUsA6WPXIMeHjdNYb+11lRUu4+Q8UQ1faapn9gpS7IVmF
	JVxG1Kw7I0PTuTQIo2P3CJWn4YFmcFWRfZ2/FbLx8E67GDmZgAeDi//gT8OH32qs
	ZSLTLjpoFcXWL7KvwPqb6E=
Received: from localhost.localdomain (unknown [111.35.186.71])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wDnr2xjLZFmMD3DCg--.271S4;
	Fri, 12 Jul 2024 21:19:35 +0800 (CST)
From: David Wang <00107082@163.com>
To: peterx@redhat.com
Cc: akpm@linux-foundation.org,
	david@redhat.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	peili.dev@gmail.com,
	skhan@linuxfoundation.org,
	syzbot+35a4414f6e247f515443@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] mm: Fix mmap_assert_locked() in follow_pte()
Date: Fri, 12 Jul 2024 21:19:31 +0800
Message-Id: <20240712131931.20207-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <ZpBhCHsG39wIVnQN@x1n>
References: <ZpBhCHsG39wIVnQN@x1n>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnr2xjLZFmMD3DCg--.271S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxXr43Wr1fKryruF48uFykZrb_yoW5Xr47pF
	1Yqr4UCrWxGr1DJr4xta13tr10y3yjy3W8urs3Gr18Z3W5J3W3JF48Jr4jvr98Krs09rW7
	tFWDXa1UtrWUtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRrsqAUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0g0aqmWXy9z-AAAAs1

Hi,

> Ah yes, I had one rfc patch for that, I temporarily put that aside as it
> seemed nobody cared except myself.. it's here:
> 
> https://lore.kernel.org/all/20240523223745.395337-2-peterx@redhat.com
> 
> I didn't know it can already cause real trouble.  It looks like that patch
> should fix this.
> 
> Thanks,
> 
> -- 
> Peter Xu

Just add another user scenario concering this kernel warning.
Ever since 6.10-rc1, when I suspend my system via `systemctl suspend`, nvidia gpu driver would trigger a warning:

             	 Call Trace:
             	  <TASK>
             	  ? __warn+0x7c/0x120
             	  ? follow_pte+0x15b/0x170
             	  ? report_bug+0x18d/0x1c0
             	  ? handle_bug+0x3c/0x80
             	  ? exc_invalid_op+0x13/0x60
             	  ? asm_exc_invalid_op+0x16/0x20
             	  ? follow_pte+0x15b/0x170
             	  follow_phys+0x3a/0xf0
             	  untrack_pfn+0x53/0x120
             	  unmap_single_vma+0xa6/0xe0
             	  zap_page_range_single+0xe4/0x190
             	  ? _nv002569kms+0x17b/0x210 [nvidia_modeset]
             	  ? srso_return_thunk+0x5/0x5f
             	  ? kfree+0x257/0x290
             	  unmap_mapping_range+0x10d/0x130
             	  nv_revoke_gpu_mappings_locked+0x43/0x70 [nvidia]
             	  nv_set_system_power_state+0x1c9/0x470 [nvidia]
             	  nv_procfs_write_suspend+0xd3/0x140 [nvidia]
             	  proc_reg_write+0x58/0xa0
             	  ? srso_return_thunk+0x5/0x5f
             	  vfs_write+0xf6/0x440
             	  ? __count_memcg_events+0x73/0x110
             	  ? srso_return_thunk+0x5/0x5f
             	  ? count_memcg_events.constprop.0+0x1a/0x30
             	  ? srso_return_thunk+0x5/0x5f
             	  ? handle_mm_fault+0xa9/0x2d0
             	  ? srso_return_thunk+0x5/0x5f
             	  ? preempt_count_add+0x47/0xa0
             	  ksys_write+0x63/0xe0
             	  do_syscall_64+0x4b/0x110
             	  entry_SYSCALL_64_after_hwframe+0x76/0x7e
             	 RIP: 0033:0x7f34a3914240
             	 Code: 40 00 48 8b 15 c1 9b 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 23 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
             	 RSP: 002b:00007ffca2aa2688 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
             	 RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 00007f34a3914240
             	 RDX: 0000000000000008 RSI: 000055a02968ed80 RDI: 0000000000000001
             	 RBP: 000055a02968ed80 R08: 00007f34a39eecd0 R09: 00007f34a39eecd0
             	 R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000008
             	 R13: 00007f34a39ef760 R14: 0000000000000008 R15: 00007f34a39ea9e0
             	  </TASK>
             	 ---[ end trace 0000000000000000 ]---
             	 PM: suspend entry (deep)

Considering out-of-tree nature of nvidia gpu driver, and nobody reported this kernel warning before with in-trees,
 I had almost convinced myself that nvidia driver may need "big" rework to live with those "PTE" changes.
So glad to see this thread of discussion/issue/fix now, I have been patching my system manually ever since 6.10-rc1,
hope things got fixed soon...


FYI
David


