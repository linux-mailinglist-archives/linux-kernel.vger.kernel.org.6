Return-Path: <linux-kernel+bounces-449444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4C99F4F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:20:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747C31885D14
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B76C1F4E3D;
	Tue, 17 Dec 2024 15:18:30 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFFE1F7073;
	Tue, 17 Dec 2024 15:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734448710; cv=none; b=WTMz+16UInWXct4c1dcCjkv9fVEdp0+MzdKWTHiBja7Fz0NuJBj3zIT/SI7tvjIVX5HnWQYE5iLGi92K9EmkUI9AjYDfkZY2GWp+SsdQVhzjt+g0MuOr663BzIXS7rbOHwA9bZGFlnl6JZhNzylVnSBL8oJXP5amVAHBDdpF7dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734448710; c=relaxed/simple;
	bh=7MBMiE/oizu7qjst5QPV5DHgtwVbZGV41mHe79c8yXc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=XcTrduKYOuPlaAvj3DtJITpYn+VXIyvrZj8T/W1ny0mYjih5f70UjvdRCkOJpNx07xLavOOU4Wddjz05BrrE32qAgljnRIRyXqoelLT7O7V20WJ9XJf+rPm3PQhmGa0HqHtlGryA2Adc6y5mIXiAfqzVcTb/4j18ykTWzhEySGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17FAC4CED6;
	Tue, 17 Dec 2024 15:18:28 +0000 (UTC)
Date: Tue, 17 Dec 2024 10:19:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, linux-staging@lists.linux.dev
Cc: Dave Penkler <dpenkler@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>
Subject: [PATCH] staging: gpib: Fix allyesconfig build failures
Message-ID: <20241217101904.370bca1a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

My tests run an allyesconfig build and it failed with the following errors:

  LD [M]  samples/kfifo/dma-example.ko
ld.lld: error: undefined symbol: nec7210_board_reset
>>> referenced by fmh_gpib.c:1512 (/work/build/trace/nobackup/linux-test.git/drivers/staging/gpib/fmh_gpib/fmh_gpib.c:1512)
>>>               vmlinux.o:(fmh_gpib_detach)
>>> referenced by fmh_gpib.c:1637 (/work/build/trace/nobackup/linux-test.git/drivers/staging/gpib/fmh_gpib/fmh_gpib.c:1637)
>>>               vmlinux.o:(fmh_gpib_pci_detach)
>>> referenced by fmh_gpib.c:1342 (/work/build/trace/nobackup/linux-test.git/drivers/staging/gpib/fmh_gpib/fmh_gpib.c:1342)
>>>               vmlinux.o:(fmh_gpib_init)

ld.lld: error: undefined symbol: nec7210_read
>>> referenced by fmh_gpib.c:46 (/work/build/trace/nobackup/linux-test.git/drivers/staging/gpib/fmh_gpib/fmh_gpib.c:46)
>>>               vmlinux.o:(fmh_gpib_read)

ld.lld: error: undefined symbol: nec7210_write
>>> referenced by fmh_gpib.c:54 (/work/build/trace/nobackup/linux-test.git/drivers/staging/gpib/fmh_gpib/fmh_gpib.c:54)
>>>               vmlinux.o:(fmh_gpib_write)

It appears that some modules call the function nec7210_board_reset() that
is defined in nec7210.c. In an allyesconfig build, these other modules are
built in. But the file that holds nec7210_board_reset() has:

  obj-m += nec7210.o

Where that "-m" means it only gets built as a module. With the other
modules built in, they have no access to nec7210_board_reset() and the build
fails.

This isn't the only function. After fixing that one, I hit another:

ld.lld: error: undefined symbol: push_gpib_event
>>> referenced by fmh_gpib.c:1166 (/work/build/trace/nobackup/linux-test.git/drivers/staging/gpib/fmh_gpib/fmh_gpib.c:1166)
>>>               vmlinux.o:(fmh_gpib_internal_interrupt)
>>> referenced by nec7210.c:956 (/work/build/trace/nobackup/linux-test.git/drivers/staging/gpib/nec7210/nec7210.c:956)
>>>               vmlinux.o:(nec7210_interrupt_have_status)
>>> referenced by nec7210.c:962 (/work/build/trace/nobackup/linux-test.git/drivers/staging/gpib/nec7210/nec7210.c:962)
>>>               vmlinux.o:(nec7210_interrupt_have_status)

ld.lld: error: undefined symbol: gpib_match_device_path
>>> referenced by fmh_gpib.c:1370 (/work/build/trace/nobackup/linux-test.git/drivers/staging/gpib/fmh_gpib/fmh_gpib.c:1370)
>>>               vmlinux.o:(fmh_gpib_device_match)

Where push_gpib_event() was also used outside of the file it was defined
in, and that file too only was built as a module.

Since the directory that nec7210.c is only traversed when
CONFIG_GPIB_NEC7210 is set, and the directory with gpib_common.c is only
traversed when CONFIG_GPIB_COMMON is set, use those configs as the option to
build those modules. When it is an allyesconfig, then they will both be
built in and their functions will be available to the other modules that
are also built in.

Fixes: 3ba84ac69b53e ("staging: gpib: Add nec7210 GPIB chip driver")
Fixes: 9dde4559e9395 ("staging: gpib: Add GPIB common core driver")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/staging/gpib/common/Makefile  | 2 +-
 drivers/staging/gpib/nec7210/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/gpib/common/Makefile b/drivers/staging/gpib/common/Makefile
index 0c4c77bea75b..460586edb574 100644
--- a/drivers/staging/gpib/common/Makefile
+++ b/drivers/staging/gpib/common/Makefile
@@ -1,5 +1,5 @@
 
-obj-m += gpib_common.o
+obj-$(CONFIG_GPIB_COMMON) += gpib_common.o
 
 gpib_common-objs := gpib_os.o iblib.o
 
diff --git a/drivers/staging/gpib/nec7210/Makefile b/drivers/staging/gpib/nec7210/Makefile
index 8d4d90f21109..64330f2e89d1 100644
--- a/drivers/staging/gpib/nec7210/Makefile
+++ b/drivers/staging/gpib/nec7210/Makefile
@@ -1,4 +1,4 @@
 
-obj-m += nec7210.o
+obj-$(CONFIG_GPIB_NEC7210) += nec7210.o
 
 
-- 
2.45.2


