Return-Path: <linux-kernel+bounces-226100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F17D8913A28
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 13:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D86B61C20C2E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 11:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34DD174ECF;
	Sun, 23 Jun 2024 11:46:28 +0000 (UTC)
Received: from outgoing.selfhost.de (mordac.selfhost.de [82.98.82.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387C17106D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.98.82.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719143188; cv=none; b=e3xCFxLZqIYZGA25Mjg/+GTlqXk4DpIltkfH8SS25Khv0SZG9SBchM3irJjYg5WEJKj8tfbgF77dbtMSx7Mq3eJqxOQRG2AgZOV2UTOx02A5DDwycGYSDBBewlFR60ZJCC7y+YkiEg9Ad9SKPqbCjaZv0oqRJZFe/87K6Eyn3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719143188; c=relaxed/simple;
	bh=RskTX3L6IhrHwjdAZDc4inx6uRON4x4Azhmwv9WwHVA=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=hZxx2ERZYC8Te0N0e3/MkiRI4KZ1DCJsCmTzcVwbNkYhk9j76kLgzmAcBRnpzOe0XP02o9ryBGSTwUiIUNM3bisP4l6xT2+YwzraPebp6Ay1DSFXzA4uWTaV8mgn5OaSGARnN4UpmkOQ+w5q+kNmlieXTgfG9JS2gosqEtlzBhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de; spf=none smtp.mailfrom=afaics.de; arc=none smtp.client-ip=82.98.82.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=afaics.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=afaics.de
Received: (qmail 11617 invoked from network); 23 Jun 2024 11:39:41 -0000
Received: from unknown (HELO mailhost.afaics.de) (postmaster@xqrsonfo.mail.selfhost.de@62.158.105.246)
  by mailout.selfhost.de with ESMTPA; 23 Jun 2024 11:39:41 -0000
X-Spam-Level: 
X-Spam-Report: 
	* -5.0 RCVD_IN_DNSWL_HI RBL: Sender listed at https://www.dnswl.org/, high
	*      trust
	*      [2003:e3:1f18:c802:68fd:ffff:fe6f:e76 listed in]
	[list.dnswl.org]
	*  0.5 HELO_NO_DOMAIN Relay reports its domain incorrectly
	*  0.4 RDNS_DYNAMIC Delivered to internal network by host with
	*      dynamic-looking rDNS
	*  0.0 DMARC_MISSING Missing DMARC policy
Received: from [IPV6:2003:e3:1f18:c802:68fd:ffff:fe6f:e76] (p200300e31f18c80268fdfffffe6f0e76.dip0.t-ipconnect.de [2003:e3:1f18:c802:68fd:ffff:fe6f:e76])
	by marvin.afaics.de (OpenSMTPD) with ESMTP id ac1e92da;
	Sun, 23 Jun 2024 13:39:41 +0200 (CEST)
Message-ID: <6ca2b58c-f689-447f-abc8-4e8dd9bf677a@afaics.de>
Date: Sun, 23 Jun 2024 13:39:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
To: linux-kernel@vger.kernel.org
From: Harald Dunkel <harri@afaics.de>
Content-Language: en-US
Subject: shutdown gets stuck on ancient Intel CPUs (>10 y)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi folks,

I've got quite a number of ancient systems that do not shut down
gracefully. On "reboot" they get stuck instead, with these messages
on the console (for example):

[3100272.289498] NMI watchdog: Watchdog detected hard LOCKUP on cpu 5
[3100274.206164] NMI watchdog: Watchdog detected hard LOCKUP on cpu 6
[3100274.432631] NMI watchdog: Watchdog detected hard LOCKUP on cpu 12
[3100277.888319] NMI watchdog: Watchdog detected hard LOCKUP on cpu 11
[3100278.939282] NMI watchdog: Watchdog detected hard LOCKUP on cpu 2
[3100280.147329] rcu: INFO: rcu_preempt self-detected stall on CPU
[3100280.590580] rcu:   14-...!: (5248 ticks this GP) idle=afe4/1/0x4000000000000000 softirq=85687678/85687678 fqs=38
[3100280.713513] rcu: rcu_preempt kthread timer wakeup didn't happen for 5308 jiffies! g227828925 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
[3100280.856203] rcu:   Possible timer handling issue on cpu=3 timer-softirq=46376324
[3100280.945837] rcu: rcu_preempt kthread starved for 5367 jiffies! g227828925 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=3
[3100281.077083] rcu:   Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[3100281.188462] rcu: RCU grace-period kthread stack dump:
[3100281.251112] rcu: Stack dump where RCU GP kthread last ran:
[3100282.053462] NMI watchdog: Watchdog detected hard LOCKUP on cpu 10
[3100284.061698] watchdog: BUG: soft lockup - CPU#8 stuck for 26s! [kworker/8:0:2191850]
[3100284.065698] watchdog: BUG: soft lockup - CPU#9 stuck for 22s! [migration/9:62]
[3100284.077698] watchdog: BUG: soft lockup - CPU#13 stuck for 22s! [migration/13:82]
[3100285.095828] NMI watchdog: Watchdog detected hard LOCKUP on cpu 7
[3100288.045764] watchdog: BUG: soft lockup - CPU#4 stuck for 23s! [etcd:1614]
[3100291.949829] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [etcd:556385]
[3100292.037830] watchdog: BUG: soft lockup - CPU#1 stuck for 22s! [migration/1:21]
[3100292.081831] watchdog: BUG: soft lockup - CPU#15 stuck for 23s! [etcd:1613]
[3100293.997839] NMI watchdog: Watchdog detected hard LOCKUP on cpu 3
[3100308.078097] watchdog: BUG: soft lockup - CPU#14 stuck for 48s! [rasdaemon:2267297]
[3100312.062164] watchdog: BUG: soft lockup - CPU#8 stuck for 52s! [kworker/8:0:2191850]
[3100312.066164] watchdog: BUG: soft lockup - CPU#9 stuck for 48s! [migration/9:62]
[3100312.078164] watchdog: BUG: soft lockup - CPU#13 stuck for 48s! [migration/13:82]
[3100316.046230] watchdog: BUG: soft lockup - CPU#4 stuck for 49s! [etcd:1614]
[3100319.950295] watchdog: BUG: soft lockup - CPU#0 stuck for 48s! [etcd:556385]
[3100320.038297] watchdog: BUG: soft lockup - CPU#1 stuck for 49s! [migration/1:21]
[3100320.082297] watchdog: BUG: soft lockup - CPU#15 stuck for 49s! [etcd:1613]

These systems are >10 years old. The CPUs are Intel Xeon E5620 or similar. Kernel
is 6.1.90. An old NAS running with an Atom CPU D525 and kernel 6.7.5 is affected
as well.

The problem is quite reproducible (esp on the NAS), but it requires a little bit
of runtime. Immediately after startup the reboot works as expected. After a
few days it doesn't.


Every helpful comment is highly appreciated

Harri

