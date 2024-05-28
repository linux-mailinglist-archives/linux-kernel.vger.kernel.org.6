Return-Path: <linux-kernel+bounces-192417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8998D1D03
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15403285C4E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1F16F26C;
	Tue, 28 May 2024 13:30:47 +0000 (UTC)
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED30816DEDB
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.54.195.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903046; cv=none; b=aoM3WSNLi/G5P9dyTmsCRfn/eMEpVlGJRQAwLv+HRaRx4dG1paifdB0q+g302d5HhUc2ihg/FNMftD+ziA07ikZzSKBo8senYt6S6CxIJQvXH9t2z/TK9y3Jzsn7ke4veKfSDvvg1hFdc5UqIfbwxyCSGjrDKvUT4m5DITDCgVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903046; c=relaxed/simple;
	bh=6Jie44RqKx5Qzojma1qH3Xylibo10Il3iCQdi7nNgsg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tjYz2Fsg/H1fHKLmqzN3+lpSVPRMf3uWS63iMj/zPzilvB0YTv911yP9CEQcZZkwxa7NAG9/EC4+45e8/sQsx73kg7luEvtXzJGevOxojyA2uING9uLh0HdUWwRi39Eg+NXjAYpl7GcYWI8JQs27F/wqRWydXihVPTlemOso+D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru; spf=pass smtp.mailfrom=fintech.ru; arc=none smtp.client-ip=195.54.195.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fintech.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fintech.ru
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Tue, 28 May
 2024 16:30:32 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 28 May
 2024 16:30:32 +0300
From: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To: <syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com>
CC: Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	<syzkaller-bugs@googlegroups.com>, <linux-kernel@vger.kernel.org>
Subject: Re: memory leak in r8712_init_recv_priv
Date: Tue, 28 May 2024 06:30:27 -0700
Message-ID: <20240528133027.37641-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <00000000000092f61e05b6f1215b@google.com>
References:
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)

Hi,

I am pretty sure this issue is close to obsolete.
Original error, I imagine, has been fixed in some other commit,
while the latest bug iteration refers to a similar but technically
different issue [1] with a trace:

BUG: memory leak
unreferenced object 0xffff88810891f000 (size 4096):
  comm "kworker/0:4", pid 5084, jiffies 4294944455
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    [<ffffffff8166d8d2>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
    [<ffffffff8166d8d2>] slab_post_alloc_hook mm/slub.c:3944 [inline]
    [<ffffffff8166d8d2>] slab_alloc_node mm/slub.c:4000 [inline]
    [<ffffffff8166d8d2>] kmalloc_trace_noprof+0x282/0x320 mm/slub.c:4147
    [<ffffffff84171382>] kmalloc_noprof include/linux/slab.h:660 [inline]
    [<ffffffff84171382>] _r8712_init_xmit_priv+0x2b2/0x6e0 drivers/staging/rtl8712/rtl871x_xmit.c:130
    [<ffffffff8416bb57>] r8712_init_drv_sw+0xc7/0x2a0 drivers/staging/rtl8712/os_intfs.c:311
    [<ffffffff8416a6d6>] r871xu_drv_init+0x1c6/0x930 drivers/staging/rtl8712/usb_intf.c:386
    [<ffffffff836c72bf>] usb_probe_interface+0x16f/0x3f0 drivers/usb/core/driver.c:399
    [<ffffffff82fafe8c>] call_driver_probe drivers/base/dd.c:578 [inline]
    [<ffffffff82fafe8c>] really_probe+0x12c/0x430 drivers/base/dd.c:656
    [<ffffffff82fb0263>] __driver_probe_device+0xc3/0x1a0 drivers/base/dd.c:79

[1] Other issue in question can be found here:
Link: https://syzkaller.appspot.com/bug?extid=83763e624cfec6b462cb

Patch to fix the error in [1] was sent by
Nam Cao <namcao@linutronix.de>.
Link: https://lore.kernel.org/all/20240525073229.4144612-1-namcao@linutronix.de/T/

Once that change is pushed, this issue should most likely be closed,
since none of the old or newer reproducers trigger original bug.

Regards,
Nikita


