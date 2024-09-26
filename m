Return-Path: <linux-kernel+bounces-340178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E117986F6E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 10:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2671C21A84
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7A71A727E;
	Thu, 26 Sep 2024 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QKPGpqTA"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181861A704E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727341089; cv=none; b=GtbXLmjZRYq41/HDuo3huTuqOFRNQmR4h2yFSdjSYhDkbLuMgO5jcjrrJ60JfzeAHMVUqaOS+8UJ9GCtZz8E2jdoKyZzRVIE7XlsR8NvSYqTCGTcZ8tPROFAOtzlpj75vM3iXKeAQtTGmpCOvxn4OOoRyZHGcei9zj6PRyuOyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727341089; c=relaxed/simple;
	bh=ecC2z/c4Aw1JD9IoLa3qrlvIPoaMAVXsw8lDwgmh5Go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XTVzbEbKTWQ3HPjGW1b+qqij8N4RyJdOqeLt1QvcSmqSNFlqZ3Yy9R6hkkNqsVFXG7NjoVMI/8Ag0JqlitNqXNW3+HtSLh8sqtR5emf3sVB5o2OL8ZCGze3H+Z072B8dPlEEC1M7U/OywLWutDC7YBDe0nNkuK1506SwJQr9fy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QKPGpqTA; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727341084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HwnfQhQfHwIJfYZWKOzdiCTrnr1rtPy3Ikzpap3ilAA=;
	b=QKPGpqTAbzWoRHUOM2G5EaT2BrBGhhXstdjrwgRqomZg19jjKHGcinWC+BpDd/giZnTaXD
	gRvs80odi9kyqkK6g7YF0j1tgfXs7GPqK5nwQTZ7qsmPrIGxpkc0RnLKGR3Bg44MnugIhE
	sMeUIfCUY3E1OR3+b/dynz0Tn1eAyII=
From: Jackie Liu <liu.yun@linux.dev>
To: liu.yun@linux.dev
Cc: kent.overstreet@linux.dev,
	linux-kernel@vger.kernel.org,
	surenb@google.com
Subject: [RFC PATCH v2] codetag: ensure module memory has been freed
Date: Thu, 26 Sep 2024 16:57:57 +0800
Message-ID: <20240926085757.9426-1-liu.yun@linux.dev>
In-Reply-To: <20240926084901.9014-1-liu.yun@linux.dev>
References: <20240926084901.9014-1-liu.yun@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Jackie Liu <liuyun01@kylinos.cn>

We found a problem that can be quickly reproduced using the self-test
script [1], (the latest version of the test script no longer releases
the module immediately). There will be a warning message that the module
memory has not been released. In fact, it is released through kree_rcu,
and its memory will eventually be released, so this warning message is
incorrect.

I don’t think this is a correct solution. I tried to use rcu_barrier for
synchronization, but it didn’t work. After using schedule(), the warning
message disappeared. It ensures that kfree has been called, so the counter
will be cleared.

The specific error message is as follows:

[   76.756915] ------------[ cut here ]------------
[   76.756921] drivers/net/bonding/bond_main.c:5122 module bonding func:bond_update_slave_arr has 320 allocated at module unload
[   76.756991] WARNING: CPU: 0 PID: 5503 at lib/alloc_tag.c:168 alloc_tag_module_unload+0x1a8/0x238
[   76.757371]  aes_neon_bs aes_ce_blk [last unloaded: bonding]
[   76.757379] CPU: 0 PID: 5503 Comm: modprobe Kdump: loaded Not tainted 6.6.52+ #7
[   76.757383] Source Version: d828af5b77f6a3d3a91203e6d60a02c83ce77d74
[   76.757385] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/06/2015
[   76.757387] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[   76.757390] pc : alloc_tag_module_unload+0x1a8/0x238
[   76.757395] lr : alloc_tag_module_unload+0x1a8/0x238
[   76.757398] sp : ffff800081f07890
[   76.757400] x29: ffff800081f07890 x28: 0000000000000008 x27: ffff6fc980b10000
[   76.757405] x26: ffff800081f07930 x25: ffffb2b6c410ef00 x24: 0000000000001402
[   76.757410] x23: ffffb2b72ed28500 x22: 0000000000000140 x21: ffffb2b72ed23a40
[   76.757415] x20: ffffb2b6c40edca0 x19: ffffb2b6c410ef80 x18: 0000000000000000
[   76.757419] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   76.757424] x14: 0000000000000000 x13: 0000000000000001 x12: ffff645015cef093
[   76.757428] x11: 1fffe45015cef092 x10: ffff645015cef092 x9 : dfff800000000000
[   76.757433] x8 : 00009bafea310f6e x7 : ffff2280ae778493 x6 : 0000000000000001
[   76.757438] x5 : ffff2280ae778490 x4 : ffff645015cef093 x3 : dfff800000000000
[   76.757442] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff2280113be400
[   76.757447] Call trace:
[   76.757452]  alloc_tag_module_unload+0x1a8/0x238
[   76.757455]  codetag_unload_module+0x184/0x218
[   76.757458]  free_module+0x30/0x270
[   76.757470]  __do_sys_delete_module.constprop.0+0x2c4/0x408
[   76.757473]  __arm64_sys_delete_module+0x28/0x40
[   76.757476]  invoke_syscall+0xb0/0x190
[   76.757479]  el0_svc_common.constprop.0+0x80/0x150
[   76.757482]  do_el0_svc+0x38/0x50
[   76.757485]  el0_svc+0x40/0xe0
[   76.757501]  el0t_64_sync_handler+0x100/0x130
[   76.757504]  el0t_64_sync+0x1a4/0x1a8
[   76.757511] Kernel panic - not syncing: kernel: panic_on_warn set ...

I think this problem occurs not only in the bonding module, but also
because the memory allocation profiling does not take the kfree_rcu
situation into consideration.

[1]: https://elixir.bootlin.com/linux/v6.6.52/source/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh

Fixes: 47a92dfbe01f ("lib: prevent module unloading if memory is not freed")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 lib/codetag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/codetag.c b/lib/codetag.c
index afa8a2d4f317..7eab77e99381 100644
--- a/lib/codetag.c
+++ b/lib/codetag.c
@@ -228,6 +228,9 @@ bool codetag_unload_module(struct module *mod)
 	if (!mod)
 		return true;
 
+	/* Make sure all module's rcu memory is released */
+	schedule();
+
 	mutex_lock(&codetag_lock);
 	list_for_each_entry(cttype, &codetag_types, link) {
 		struct codetag_module *found = NULL;
-- 
2.46.2


