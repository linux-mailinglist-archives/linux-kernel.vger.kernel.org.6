Return-Path: <linux-kernel+bounces-222439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 553A8910194
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 12:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DED6DB21DBF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10201AAE13;
	Thu, 20 Jun 2024 10:39:14 +0000 (UTC)
Received: from smtp134-24.sina.com.cn (smtp134-24.sina.com.cn [180.149.134.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1217CA1B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.149.134.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718879954; cv=none; b=d0n0+OR8eYuUwkKscjOA3JlCEv5/9US2izBtUGTXgiav1utpe7XhatRfWGsMyd2fDANzckSd9nkjONrI/IVG/DYXyVPeXnXz8H6p/gcj4zklDCGcFOghnA1UQ3QiwaakiChksF6sris3gGfjhAhtPtjhDCsYljJUDCkd20cZOaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718879954; c=relaxed/simple;
	bh=cP1vXZPPRqr0Uz61ZzQZpG8sk0PrcO4TOyTTsBrcVtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u8wiLPS+RlShrDFa/eybt7NdPi9avtYXXaT9CySEJgkwlBJCh+3D1fPMD3upvo/Ka/agNENnf3oP8KFB6A5rhPAUZgTJ6q8hPN9E6cTuEe1d5khPBmVPtdbN7/VsYhN2YeJbfktFTjPifyo8MGRmkkq8GMsKCyWNGNR0s2OQKr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=180.149.134.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.90.46.255])
	by sina.com (10.185.250.21) with ESMTP
	id 667406BE00007ABF; Thu, 20 Jun 2024 18:38:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4741273408515
X-SMAIL-UIID: 77F886C4FC4640BF932F5FAFC4B80EF9-20240620-183857-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+973d01eb49b060b12e63@syzkaller.appspotmail.com>
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Boqun Feng <boqun.feng@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-usb@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] INFO: task hung in wdm_release
Date: Thu, 20 Jun 2024 18:38:47 +0800
Message-Id: <20240620103847.1724-1-hdanton@sina.com>
In-Reply-To: <0000000000000ff9cb061b4ea872@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 20 Jun 2024 02:08:21 -0700
> Showing all locks held in the system:
> 3 locks held by kworker/u8:0/11:
>  #0: ffff8880b953e7d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
>  #1: ffff8880b9528948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: psi_task_switch+0x441/0x770 kernel/sched/psi.c:988
>  #2: ffff8880754f0768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:5966 [inline]
>  #2: ffff8880754f0768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: cfg80211_wiphy_work+0x35/0x260 net/wireless/core.c:424

The info looks bogus given acquiring mutex with runqueue lock held.

static inline void wiphy_lock(struct wiphy *wiphy)
	__acquires(&wiphy->mtx)
{
	mutex_lock(&wiphy->mtx);
	__acquire(&wiphy->mtx);
}

