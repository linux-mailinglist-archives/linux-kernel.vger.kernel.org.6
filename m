Return-Path: <linux-kernel+bounces-387478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0F79B51C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C6C91F241E1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3BF200BB3;
	Tue, 29 Oct 2024 18:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LBndWOvA"
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364CE1F80D6
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 18:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226473; cv=none; b=s4Br1KfSR9wDQ+ADyPvLkXBsD7722xfcNY4cJVvTeJjs4gwzCMkGSK2+NiAqFzsvww83bixUdkmumj6emOQwtulMo4Xm2Lu1lNXfBNrRpTH+GZu/F0wrU2J9jBur0h0YBgZwscE6VY6M5yrcozA7HmMeQTnPpqQYGAHeMf/DzQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226473; c=relaxed/simple;
	bh=vikCzX2Lmxe+Ca6up6FeEKBTzb4qRXBzgII+NbpWJVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3/pkKH4e8chVVDdd09yVSnDN/GBVoxshFDjEt38QpQWM0VHLfGB6QLslfUCG66i9Hjh3t0ap+jRpG9NrLWBogIkUl1rI82DE2s+cdU3H8r7HFzXmySTcu2yeeV2TgR6NT6GD5aZHxnbqEZIS7FEm1jjnk9VlXeXuMGFKksPqUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LBndWOvA; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-6cbdd42bdf3so9906016d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 11:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730226470; x=1730831270; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZV5gpvjUR+EykM0ZxxcYQtXw9y+J9pOXPkeHwhke3m8=;
        b=LBndWOvAzH3wiyENInswPmsuYejFKRKz3lz/SqNfnAHAIlMV+pYd7arv7v/HCVb9qR
         Ib5LUBnGfhOO+Dxas/7qI8hnFjb0nPQi+22Pkha76fUWq0h//ciK9tEH4loMoxNrBwyy
         yF49MaRANqz1Yg+ZsmOcaeh6Nt2n5TmC1jpjwBac1ErHiAnv8mInhbDta0XZ4kr4/YBJ
         8uBIinmmCc1c2j6cewwWHfjmGw5fy8zXjNpV5FK/njwu7vWlcoZfKVlG0iTK3TB7CVhJ
         +eDNqyyvwsMgu+cdbspV2oeWmLlUuMNSn9iDiVPDt5rxfaCRl8Xct7TfQSV8328o1DxO
         GpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730226470; x=1730831270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZV5gpvjUR+EykM0ZxxcYQtXw9y+J9pOXPkeHwhke3m8=;
        b=bLFyzQ5KG6YmjdeZs+mGOoyIW0L6fvJ4m6gaZhdqyqFViRSeMI1H7+z7zSv4j2IyZk
         FWHEBr1+f4FwEPbQ0Ig7Z8woYVeMqkNd3Q/km1fl/JnNjsN2kvMg9zA6wdjrxLPuBuYa
         cxPIqNlBSNV5TMWjKjW1po0yRnY6VC5TdheNhlti2v6rsjT6ZjFQtvEo52VL2J20eXIT
         3Mwxf/LKjvUvJ5lqgA5om2jd1xwdFiM8GNr2fWQb2I9PSvYEuujKeVAqIR3O005rmsNQ
         SA004HK5vlXquchc7TB2XWasKtJCZI7Vkgow9YsvW4xqm1rGZutGzmho+vZs53xRvyCV
         K4dg==
X-Forwarded-Encrypted: i=1; AJvYcCX/q2XCM3Mr3fZeqPzYLgB+VirjsVusiTff8i/9JLFPwGrr+qfaDBJs60NCGxJNmR4qiiAM96eAu9uEqpU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5ATT5bf82NHJ2xDIaXNza00taOCseX4X6y0qo/4kUBLAR2I55
	kxSHyDRquK5vdmKsYoGJf8a53fo8BwHbRf/Nh7KAItAcpvgrA3YNWoXHAvjjhMGwLHrRwQnKUnG
	uynuezA+7nKBhA4UvX0oxCUrK+xKFZuPZ
X-Google-Smtp-Source: AGHT+IFnPuCJvcOk+SL4kW2cd9qDJykBF5/qbW7Ee6jFXP6Ew9vkWFqPk2xr3c/aaOZuDPQek+PxvxYWlEFA
X-Received: by 2002:ad4:5c8e:0:b0:6cb:e6c8:2ad0 with SMTP id 6a1803df08f44-6d185693ff5mr100648366d6.5.1730226469987;
        Tue, 29 Oct 2024 11:27:49 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6d179a7b0e0sm2473716d6.75.2024.10.29.11.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 11:27:49 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D92A63400B8;
	Tue, 29 Oct 2024 12:27:48 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id BD414E40CF4; Tue, 29 Oct 2024 12:27:18 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: skip RPS if packet is already on target CPU
Date: Tue, 29 Oct 2024 12:26:58 -0600
Message-ID: <20241029182703.2698171-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If RPS is enabled, all packets with a CPU flow hint are enqueued to the
target CPU's input_pkt_queue and process_backlog() is scheduled on that
CPU to dequeue and process the packets. If ARFS has already steered the
packets to the correct CPU, this additional queuing is unnecessary and
the spinlocks involved incur significant CPU overhead.

In netif_receive_skb_internal() and netif_receive_skb_list_internal(),
check if the CPU flow hint get_rps_cpu() returns is the current CPU. If
so, bypass input_pkt_queue and immediately process the packet(s) on the
current CPU.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 net/core/dev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index c682173a7642..714a47897c75 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5855,11 +5855,11 @@ static int netif_receive_skb_internal(struct sk_buff *skb)
 #ifdef CONFIG_RPS
 	if (static_branch_unlikely(&rps_needed)) {
 		struct rps_dev_flow voidflow, *rflow = &voidflow;
 		int cpu = get_rps_cpu(skb->dev, skb, &rflow);
 
-		if (cpu >= 0) {
+		if (cpu >= 0 && cpu != smp_processor_id()) {
 			ret = enqueue_to_backlog(skb, cpu, &rflow->last_qtail);
 			rcu_read_unlock();
 			return ret;
 		}
 	}
@@ -5884,15 +5884,17 @@ void netif_receive_skb_list_internal(struct list_head *head)
 	list_splice_init(&sublist, head);
 
 	rcu_read_lock();
 #ifdef CONFIG_RPS
 	if (static_branch_unlikely(&rps_needed)) {
+		int curr_cpu = smp_processor_id();
+
 		list_for_each_entry_safe(skb, next, head, list) {
 			struct rps_dev_flow voidflow, *rflow = &voidflow;
 			int cpu = get_rps_cpu(skb->dev, skb, &rflow);
 
-			if (cpu >= 0) {
+			if (cpu >= 0 && cpu != curr_cpu) {
 				/* Will be handled, remove from list */
 				skb_list_del_init(skb);
 				enqueue_to_backlog(skb, cpu, &rflow->last_qtail);
 			}
 		}
-- 
2.45.2


