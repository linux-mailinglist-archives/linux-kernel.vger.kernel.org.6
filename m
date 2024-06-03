Return-Path: <linux-kernel+bounces-199013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AFC8D8083
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DE58283E8A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 11:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B8784A2F;
	Mon,  3 Jun 2024 11:04:28 +0000 (UTC)
Received: from smtp134-32.sina.com.cn (smtp134-32.sina.com.cn [180.149.134.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE5978C80
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717412668; cv=none; b=XF1xUO2nzwAbRm8+1vmTBFOnimx1pUhd2YeYcWmq6LApqkzZ0aLt07AMDZ1b1lDKWbP9DBJmahhIkw6L+1NqbISTv0k0FWD7M0OgAcq11twNpkMZbTysH6qx5RvccpVP6bhy9lm0kHjicv/5RCt3YMl7o8XmPnjMk36VtCpGaHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717412668; c=relaxed/simple;
	bh=8vqp2CCDZ0RAWzYrbyjrsBwEkza5gxC/UurRQDd4Sco=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LUiGXn1pYD63w20Pe8Tx6H5DnUx12HAu4hb3BQmVJoKRLuB4O0/NG4by4iM/4xvdCkJ+2lt9fLo97nBzaGLEalYIS18YMRNmwPvHLw/wFbX3zbb+DqFcNb/CPEEAHUvgD8DGqnDWZdiDPfbyhXuCU8U7tlscZdhZzGqEMXl1Wac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.186])
	by sina.com (10.185.250.21) with ESMTP
	id 665DA32A00000E68; Mon, 3 Jun 2024 19:04:12 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2263583408501
X-SMAIL-UIID: D4937BB46EC843979FC1444F050976C8-20240603-190412-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+558f67d44ad7f098a3de@syzkaller.appspotmail.com>
Cc: frederic@kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tglx@linutronix.de
Subject: Re: [syzbot] [kernel?] BUG: unable to handle kernel NULL pointer dereference in __hrtimer_run_queues
Date: Mon,  3 Jun 2024 19:04:01 +0800
Message-Id: <20240603110401.1580-1-hdanton@sina.com>
In-Reply-To: <000000000000deb5250619f9b5f4@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 03 Jun 2024 03:22:29 -0700
> Unable to handle kernel NULL pointer dereference at virtual address 0000000000000090
> CPU: 0 PID: 3192 Comm: syz-executor607 Not tainted 6.10.0-rc1-syzkaller-00027-g4a4be1ad3a6e #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 204000c9 (nzCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : rb_next+0x1c/0x54 lib/rbtree.c:505
> lr : rb_erase_cached include/linux/rbtree.h:124 [inline]
> lr : timerqueue_del+0x38/0x70 lib/timerqueue.c:57
> sp : ffff800080003e70
> x29: ffff800080003e70 x28: 0000000000000000 x27: fff000007f8cf780
> x26: 0000000000000001 x25: 00000000000000c0 x24: 0000001f0198bc90
> x23: fff000007f8cf780 x22: fff000007f8cf7e0 x21: fff000007f8cf780
> x20: fff000007f8cf7e0 x19: ffff800088c3bd60 x18: 0000000000000000
> x17: fff07ffffd319000 x16: ffff800080000000 x15: 0000ffffef309d38
> x14: 00000000000003bb x13: 0000000000000000 x12: ffff8000825e0028
> x11: 0000000000000001 x10: 0000000000000200 x9 : 0000000000200000
> x8 : 0008000000000000 x7 : ff7ffffffffffbff x6 : 00000000019a23f5
> x5 : fff07ffffd319000 x4 : 000000000a2dca90 x3 : ffff800088c3bd60
> x2 : ff7000007f8cf8e8 x1 : 0000000000000080 x0 : 0000000000000080
> Call trace:
>  rb_next+0x1c/0x54 lib/rbtree.c:505
>  __remove_hrtimer kernel/time/hrtimer.c:1118 [inline]
>  __run_hrtimer kernel/time/hrtimer.c:1667 [inline]
>  __hrtimer_run_queues+0x104/0x1bc kernel/time/hrtimer.c:1751
>  hrtimer_interrupt+0xe8/0x244 kernel/time/hrtimer.c:1813

After scratching head skin 30 minutes I failed to work out how the timer
was armed.

