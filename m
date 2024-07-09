Return-Path: <linux-kernel+bounces-245620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D170192B509
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C5A0B22F7D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B0B156F44;
	Tue,  9 Jul 2024 10:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GFbjvMbn"
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com [209.85.166.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E745156862
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520400; cv=none; b=abephzQuVNb9WzKmUWZ7sKP69LKsEu7ikdzmP6rNRJvUqEUJsvTTdRNbHZtv4Zaqxqe8FLnGwbdYiXTpYmiZ7oUxFgIo9HtEVEB5T0wseyjq8p8aDTsPGRNMmhWZB1flVpe5rXC3qb7d7rfXweCISoh5DGd+t3BWlZzsAgYVsDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520400; c=relaxed/simple;
	bh=1hlpKuB9Bhnf6iyh2qDuWQVcWhNS4D+IdvrMXKwBarM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EVa+Hbn8nso5WmB2U+RbXdOh+H6wTNiaQ2Bof2SK+Cwlsg24hVDhC7X6pnGVU+F8qeT6R/4CKNd0ypwHxd45vCR0ZGybHjwuRks7F5AC6g44pwOwPQr4bKYl/yNBSrPqCEulm5w1W2/avt73dCGs5zdpTE8GZkA4Lv+8OyaMWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GFbjvMbn; arc=none smtp.client-ip=209.85.166.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f67.google.com with SMTP id ca18e2360f4ac-8036ce66108so864239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 03:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720520398; x=1721125198; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6eo/T2MDeFuTGwCTeEol3bq4AUNqiYv36Kk27s7zY+0=;
        b=GFbjvMbnTq2ORe9ArcUxZDk/q5SZQW9UQ9994rZwsHsa4wY/hYsvtRSXGvMlH7iI89
         jycGwD+H3Ve/SXFbbAhjMHOLifaZRBQQXY8eAvgigRS884FmHNTbv7rrZAVCm/zfhP/q
         DwlG4Iu9XhVBaF/0llnjqyWp/e79sSR0ud5bA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520398; x=1721125198;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eo/T2MDeFuTGwCTeEol3bq4AUNqiYv36Kk27s7zY+0=;
        b=PDmLtB4Je4U+i687+4Sy6KrTTO5P6KHwR6tF3HvbBZKEWeyYqzQkPelwINY+BG1wXN
         RiIPCC22VmJrDePyKtfm3p0X2w9KJTQC3F+YfwqXnSVIeAS6EORgN/oTrqDLrKM0j8VA
         Zfi1T9Q5nWniNxG8N+hRI1G3UszqnXIUsvvC4xBjebW9GQJvg+/Z6lDSB1pif2i9KpAF
         9nizlcL8CbxEHTF2eD0U/PFWVnDPZKmeUK9UgbhYkT/6HBZu2AuljR66bKqREKcBpDLW
         GoAMXVHNzdLHzM2vobPhQChxfVcipn6EnktCxBlGWR6SozdoAQRtSEAQ5cuVu8jed63S
         QAFw==
X-Gm-Message-State: AOJu0YzEr1c9oIj0nCCe7KdZTq+AzwioeFRKg0NDPW4iR4Kxo1b/WAi7
	V8F1534tR+e7WG6+G3FcLO14ox3IE0SV/0DmrBZh7SkhsA+CpH9zvZ36Hc7FLzTrquR7Pw4aeW0
	WBJUaxz8WTLI10MkiGT+v3tn0/QkU+sdOB5e/Bl4MQ7MnFiWACf3rjirnvs4B/PY5gzBSDL06mk
	NnW+TG24A7E1pYtyCYUm7uVMRG6lenKprtnkbEh3w/xT8wtbDdZLrwfR81cGc=
X-Google-Smtp-Source: AGHT+IGVeRx4E+l9eXcBpFewtCojZ3GAL+3nL22Gtq5ScRBbs8/g0Vz6xgC5/Q/KF+PA5BI7nJl6eQ==
X-Received: by 2002:a05:6602:164b:b0:7f3:cd10:40b3 with SMTP id ca18e2360f4ac-7ffffe21e74mr312552739f.1.1720520398192;
        Tue, 09 Jul 2024 03:19:58 -0700 (PDT)
Received: from kashwindayan-virtual-machine.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967345sm1426016b3a.112.2024.07.09.03.19.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2024 03:19:58 -0700 (PDT)
From: Ashwin Kamat <ashwin.kamat@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	davem@davemloft.net,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	florian.fainelli@broadcom.com,
	ajay.kaher@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	tapas.kundu@broadcom.com,
	ashwin.kamat@broadcom.com,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v5.15 2/2] net/ipv6: prevent NULL dereference in ip6_output()
Date: Tue,  9 Jul 2024 15:49:44 +0530
Message-Id: <1720520384-9690-3-git-send-email-ashwin.kamat@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720520384-9690-1-git-send-email-ashwin.kamat@broadcom.com>
References: <1720520384-9690-1-git-send-email-ashwin.kamat@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

From: Eric Dumazet <edumazet@google.com>

[Upstream commit 4db783d68b9b39a411a96096c10828ff5dfada7a]

According to syzbot, there is a chance that ip6_dst_idev()
returns NULL in ip6_output(). Most places in IPv6 stack
deal with a NULL idev just fine, but not here.

syzbot reported:

general protection fault, probably for non-canonical address 0xdffffc00000000bc: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000005e0-0x00000000000005e7]
CPU: 0 PID: 9775 Comm: syz-executor.4 Not tainted 6.9.0-rc5-syzkaller-00157-g6a30653b604a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
 RIP: 0010:ip6_output+0x231/0x3f0 net/ipv6/ip6_output.c:237
Code: 3c 1e 00 49 89 df 74 08 4c 89 ef e8 19 58 db f7 48 8b 44 24 20 49 89 45 00 49 89 c5 48 8d 9d e0 05 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 4c 8b 74 24 28 0f 85 61 01 00 00 8b 1b 31 ff
RSP: 0018:ffffc9000927f0d8 EFLAGS: 00010202
RAX: 00000000000000bc RBX: 00000000000005e0 RCX: 0000000000040000
RDX: ffffc900131f9000 RSI: 0000000000004f47 RDI: 0000000000004f48
RBP: 0000000000000000 R08: ffffffff8a1f0b9a R09: 1ffffffff1f51fad
R10: dffffc0000000000 R11: fffffbfff1f51fae R12: ffff8880293ec8c0
R13: ffff88805d7fc000 R14: 1ffff1100527d91a R15: dffffc0000000000
FS:  00007f135c6856c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 0000000064096000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ip6_xmit+0xefe/0x17f0 net/ipv6/ip6_output.c:358
  sctp_v6_xmit+0x9f2/0x13f0 net/sctp/ipv6.c:248
  sctp_packet_transmit+0x26ad/0x2ca0 net/sctp/output.c:653
  sctp_packet_singleton+0x22c/0x320 net/sctp/outqueue.c:783
  sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline]
  sctp_outq_flush+0x6d5/0x3e20 net/sctp/outqueue.c:1212
  sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
  sctp_do_sm+0x59cc/0x60c0 net/sctp/sm_sideeffect.c:1169
  sctp_primitive_ASSOCIATE+0x95/0xc0 net/sctp/primitive.c:73
  __sctp_connect+0x9cd/0xe30 net/sctp/socket.c:1234
  sctp_connect net/sctp/socket.c:4819 [inline]
  sctp_inet_connect+0x149/0x1f0 net/sctp/socket.c:4834
  __sys_connect_file net/socket.c:2048 [inline]
  __sys_connect+0x2df/0x310 net/socket.c:2065
  __do_sys_connect net/socket.c:2075 [inline]
  __se_sys_connect net/socket.c:2072 [inline]
  __x64_sys_connect+0x7a/0x90 net/socket.c:2072
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 778d80be5269 ("ipv6: Add disable_ipv6 sysctl to disable IPv6 operaion on specific interface.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Link: https://lore.kernel.org/r/20240507161842.773961-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Ashwin: Regenerated the Patch for v5.15]
Signed-off-by: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
---
 net/ipv6/ip6_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 770ee7ffb0d5..ce37c8345579 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -221,7 +221,7 @@ int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
 
-	if (unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
+	if (unlikely(!idev || READ_ONCE(idev->cnf.disable_ipv6))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 		kfree_skb(skb);
 		return 0;
-- 
2.45.1


