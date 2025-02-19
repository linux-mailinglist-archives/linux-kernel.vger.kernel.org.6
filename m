Return-Path: <linux-kernel+bounces-522187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7628FA3C731
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE243AD79E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 18:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C85214A6E;
	Wed, 19 Feb 2025 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YjX+GVIu"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE741FECC1
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739988994; cv=none; b=rWKIgpc9jKJHyxnaIbXbDOFURspNOqv0Mo8CKoyTKcXDip+/mrpYrdsfJDE21Z7DFS4NVsa2us3grJN50+AajUxJiKVh3esOjXWbJUZVnsVt2DN6eKJU0dM5HT2sqR8NYrOKr1Flz03j4f9fYKKRhEzY2xlMUxL16VjD4GfR2XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739988994; c=relaxed/simple;
	bh=bH0LnxAkANrFnbgQGbgWcMkIQPF2gj+UHBqxzcqtXjU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tS9PXsBiTwCDcruBU1LceIOWsW7G85TJjDTzIZVBAg/QtAPOGKy/ZdlcYgJuhAapKqHyNcU5NO/jrv5v/yXZh45RZFkzW3jDfwtLKwJ1QS8alz2Wdns5KgfyxqR6qUBt5A1w+9Vz5tH89tv8TdrpFpjGaVRpdG80/b/8+Bx+hTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YjX+GVIu; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-46fa7678ef3so528281cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 10:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739988991; x=1740593791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xlbf30x0uNFungZc8BjzdSdt4uJVOLJQoZrvNr982Z4=;
        b=YjX+GVIu8H3ZHUx5U1mAXq80QA6+bRwLoeZqzcHG+bpo/HNBlRxRSm6eH2AQZyoymh
         ZI0hFOgbFvGLqtSaARKJvSAq34HXT9MOlbYHo1LJR+XDTPaA4hmEOq/X8W+rz4nTfvPx
         2PcLTwpnD6QLYf2L2ha1Lb1ZkXb/c2BbZ6ldRtkrcbjgKvsoJ7cjO+F55TtiBS5RzHHf
         78LmJbx2Yo7vA20LD4Df9Bgtm9xgatDzgz7sGEvd+TtXi+o+Z9ng8L7pFs+ipJhEvgRx
         f5bs/AawkUiol6uMN7VullZJfxLm8iAkORZDydHbYR0WDHFx6Gxp+BNmU/7SA0TJK9se
         Nt6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739988991; x=1740593791;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlbf30x0uNFungZc8BjzdSdt4uJVOLJQoZrvNr982Z4=;
        b=DyWAKw2u+6gQtu1N8hT7cqGxy2YYDYGR+k0NizbbeZUgPryyi81I9Wb0PILYcXcNIg
         g04KU1G4f89x1DIkv89AszPsMuAB5YcY7D8JtCS5esAeh+wm/Srlbx0yZk3SVwmjCmGR
         oxfz35egIfK+Fev2bHyL57fVnKObEgwQH87b3x8ov7JzkbMjhRRUVVA7S2DuyWoRnN1+
         1GlFm0BQgfrpDAD9I+PilEv3jcUJ0+oD+Pmjqvi7wUQfGz/N8047cJjoC/j721BfIXL/
         PKoDyR1MgAHCwMjA6XIq+1eec5JgI1xP31lTPSYPWOW/Sbu5vJmRu1xqVCsxFruevY60
         zerw==
X-Forwarded-Encrypted: i=1; AJvYcCWI8O5hCr4seiNcpqX8BuPsEl4eTYznqaJWf5P7Il+3lemu2XXvB2e7s5Dy9O8VQVI6En2tsxVQ0fPaJyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnQtF+ACKJo3IQlAtMkBQATRRbGV2t2BFh6jV6jO7FNkVPIQhp
	8BJlc4WT8Ac3+medXYrDTT5JAwJBKl/fdTUYmH/SRQvDUqlBMnefRoLU2ub9voU=
X-Gm-Gg: ASbGnct9zAbpBFydFZ8WkuYTZEKSnE6vGf7XQBF8mlPKWfFn68GT+EahVTePiaqIHNZ
	KJtimUQxAAhW1kRxYAy667+AYa6w8LWRnWITTct6wwbP7skQjtwZcHVvp4WpQpjw1vczA9l/NwK
	R6abSZGIeNzQ3KrshzM8pwg9VB8XydsI3kJZOAN0L6jJ+DPp8uuavIEVGR1hBHMTWyq2VU0oNJw
	0UKY1FbFtQAF+9+97VxDYoW9Uh4C2HJaAezvnvfvDQNhX27qNphWIKLoHVd/1QX40CAXUm7nksK
	UE998ksvNuq5s9M=
X-Google-Smtp-Source: AGHT+IGRbWWvXf5h1lYoK4mfqaPbGMmhAWcsiQxS9BI2ulaH26wMHaL1bNQlGCgZmcBATXiOR7+yzQ==
X-Received: by 2002:a05:6214:2586:b0:6e6:6c10:76fb with SMTP id 6a1803df08f44-6e69750c134mr70728246d6.25.1739988991095;
        Wed, 19 Feb 2025 10:16:31 -0800 (PST)
Received: from maple.. ([174.89.15.101])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f38absm77357466d6.88.2025.02.19.10.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 10:16:26 -0800 (PST)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: linux-rt-devel@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pawel Laszczak <pawell@cadence.com>,
	Frank Li <Frank.Li@nxp.com>,
	Ferry Toth <ftoth@exalondelft.nl>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [RFC PATCH] usb: gadget: u_ether: prevent deadlock under RT
Date: Wed, 19 Feb 2025 13:15:52 -0500
Message-ID: <20250219181556.1020029-1-ralph.siemsen@linaro.org>
X-Mailer: git-send-email 2.45.2.121.gc2b3f2b3cd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A deadlock can be readily triggered when using NCM gadget with the
Cadence cdns3 USB driver, under heavy traffic from "iperf3 --bidir".
It has been observed under 6.1, 6.6 and 6.12 kernel versions, but
only on PREEMPT_RT. Once deadlocked, even magicsysrq has no effect.
However, there is periodic output from the rcu stall detector:

[   71.105941] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   71.105966] rcu:     Tasks blocked on level-0 rcu_node (CPUs 0-1): P125/4:b..l
[   71.105992] rcu:     (detected by 1, t=5252 jiffies, g=-515, q=7 ncpus=2)
[   71.106003] task:irq/507-s-f4000 state:D stack:0     pid:125   tgid:125   ppid:2      flags:0x00000008
[   71.106018] Call trace:
[   71.106022]  __switch_to+0xf4/0x158
[   71.106046]  __schedule+0x2b4/0x920
[   71.106055]  schedule_rtlock+0x24/0x50
[   71.106064]  rtlock_slowlock_locked+0x348/0xcb8
[   71.106077]  rt_spin_lock+0x88/0xb8
[   71.106086]  eth_start_xmit+0x30/0x1490 [u_ether]        /*****/
[   71.106112]  ncm_tx_timeout+0x2c/0x50 [usb_f_ncm]
[   71.106131]  __hrtimer_run_queues+0x180/0x378
[   71.106143]  hrtimer_run_softirq+0x90/0x100
[   71.106151]  handle_softirqs.isra.0+0x14c/0x360
[   71.106165]  __local_bh_enable_ip+0x104/0x118
[   71.106177]  __netdev_alloc_skb+0x1e0/0x210
[   71.106192]  ncm_unwrap_ntb+0x1ec/0x528 [usb_f_ncm]
[   71.106206]  rx_complete+0x120/0x288 [u_ether]           /*****/
[   71.106221]  usb_gadget_giveback_request+0x34/0xf8
[   71.106236]  cdns3_gadget_giveback+0xe4/0x2d0 [cdns3]
[   71.106286]  cdns3_transfer_completed+0x3b0/0x630 [cdns3]
[   71.106320]  cdns3_device_thread_irq_handler+0x8b8/0xd18 [cdns3]
[   71.106353]  irq_thread_fn+0x34/0xb8
[   71.106364]  irq_thread+0x180/0x2f0
[   71.106374]  kthread+0x104/0x118
[   71.106384]  ret_from_fork+0x10/0x20

The deadlock occurs because eth_start_xmit() and rx_complete() both
acquire the same spinlock in the same instance of struct eth_dev.
The nested call occurs because rx_complete() calls __netdev_alloc_skb()
which performs a brief local_bh_disable/enable() sequence.

Prevent the deadlock by disabling softirq in rx_complete(), with the
same scope as the spinlock. With this fix, no deadlocks are observed
over many hours of continuous testing at USB 2.0 speed (480 Mbit/s).

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Discussion items:

0) This is somewhat similar to the recent discussion
https://lore.kernel.org/linux-rt-devel/20250212123302.0f620f23@gandalf.local.home/
and my solution is to "sprinkle local_bh_disable() around",
which is clearly not optimal. Hence the RFC on this patch.

1) There are several more places using the same spinlock, for example
the gether_suspend() and gether_resume() functions. I'm not using power
management, but I wonder if there might be more deadlocks lurking?

2) By keeping softirq disabled for a longer duration, this patch could
potentially increase the RT latency. I tried to quantify this using
cyclictest, but I cannot get a baseline for comparison, since it
deadlocks almost immediately when the USB is active. Other suggestions?

3) The fix is in generic u_ether.c code, to match the scope of the
spinlock. Alternatively, it could be done in cdns3 specific code,
such as in cdns3_device_thread_irq_handler(). I'm not sure if the
same problem exists in other USB drivers?
---
 drivers/usb/gadget/function/u_ether.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
index 09e2838917e2..dc511c01b741 100644
--- a/drivers/usb/gadget/function/u_ether.c
+++ b/drivers/usb/gadget/function/u_ether.c
@@ -233,6 +233,7 @@ static void rx_complete(struct usb_ep *ep, struct usb_request *req)
 		if (dev->unwrap) {
 			unsigned long	flags;
 
+			local_bh_disable();
 			spin_lock_irqsave(&dev->lock, flags);
 			if (dev->port_usb) {
 				status = dev->unwrap(dev->port_usb,
@@ -243,6 +244,7 @@ static void rx_complete(struct usb_ep *ep, struct usb_request *req)
 				status = -ENOTCONN;
 			}
 			spin_unlock_irqrestore(&dev->lock, flags);
+			local_bh_enable();
 		} else {
 			skb_queue_tail(&dev->rx_frames, skb);
 		}
-- 
2.45.2.121.gc2b3f2b3cd


