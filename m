Return-Path: <linux-kernel+bounces-527942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C33A41176
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 21:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8DA17383B
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Feb 2025 20:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D386322A7FE;
	Sun, 23 Feb 2025 20:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyAXacY8"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D5E1482E8
	for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740341213; cv=none; b=PfQSAm88+4XiutNlL9Z1QDJjGsXHIPT8wPSiYHPF9k8IbkgIrdPLaxpYXo/yxepxXcrLhwSf1N3tcTKxDnPW8bGIFCFWKtXWpa/rtulli7eZAblcz73A0gR24OVA/ELfLCi9F8G9N8QCHLRrzGAzQtI2dJIMgdRu4KRR6DUwyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740341213; c=relaxed/simple;
	bh=eKDSnNjq9uTYBXDkqwtMTf3jm9i9p6UEGlqS/o3Vd54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SG4y41D1ZYwRmMwzYDczCi404bvOMFx58polg6qKCXHM5MLrHHdranPcc+CWiZ2QNLnBWTGBi6WZvzngjiOvt1j/qil+AggASlChxvJ44Rj2GOVb5RF0cRHOMBamek0A+VNJMF3Xq6Fp+OToM4JmAoKb86k6C+XYjG0uTSh6Igs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LyAXacY8; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2f9d3d0f55dso5642059a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2025 12:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740341211; x=1740946011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kjhFIINeK8RqUNIN9kMsXE1mL/G5qdLA9ymV1Kj4r+E=;
        b=LyAXacY8VeL0BQNIr516OYqcd99ar0xmD/MRiGJBR3d9URkAJD52VpCtJMToFXPDFF
         OHMMG8VAbhEo5VhzcoShzgStErYShGfHH7DlDyUef5JFFejrI45wVA/aVqevPP3k6vsq
         uKQxPwWbsOgzOVRLTBDADkjAnXOdXnJTgNCUOCIf6/RieEXNFWFKNbkXnnbIAHThzLw5
         o7H7Jb0VMeuQFnA+0mdIvub7w101jS0lzfMwIkVkhLoZ/h1R/PtWgyoKNINhoEisjoHK
         zqrsCHXEiTrM5kdDAMWiwozNK4ByW7qmgRBdAQb4k55POM7UdIg6NBnvk5cV4Aq76Q4X
         IgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740341211; x=1740946011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjhFIINeK8RqUNIN9kMsXE1mL/G5qdLA9ymV1Kj4r+E=;
        b=jW9mMDY+RqUlUQTmpl88H33CRLaK0yzYz5T39ehc8V7t7vZXeoTAt9Ss5M1ucE7BfT
         jfhXaJ64/4ElsfqZZ75JpsAUWwQDca49iukvJsx/NXQDuwbCmSRAhuWQkOPjq2P5xHQa
         hDaAHeQCDucK7qVBuS18Hj1rVF7DpLM79pMjJJe8y8T4Uo00CLstWzd5vYyHK7yW1Was
         UG/v4Ab9YI9sUVp3LwfFqLy21/YCYg5ex0khBdhIbvTQ4RSPdjfcUx89GvwPXmOpUBZQ
         qK9s81urQdzS3U++faBfnPX0q5iEdly6nP53KE0/IX5OmxXhgZUQEXeIlmixmeo8Ns0A
         7X+Q==
X-Gm-Message-State: AOJu0Yy9JLeSyTH3eRtGvFqgrmssvvNOFUtmyB+KOZ75sOvR5uAK0hJN
	3J6zguFJMMH7YvhuDnApw6579+xVIxtuRAhD1b/IgpgY8lmEWdIPeR9gMP+UqnU=
X-Gm-Gg: ASbGncvozArqcs5V6MOhTuhJm625vSU5ITMWDDbbcutqwJPf2SGM1sYCh00SJbcN7C3
	Z6d5EIm/i/abVDU9CPvqPNzdKGuzWe2y3jxTFetazr7Ix2csMDjQsG9SxcNFy0NTVVPBiVzOkz6
	2KJ3sA3OTc7cSNdMRBWj/LvsmEW2qHOeywgpB0kf9rqg5443I9q+ljOM8S5IwkQdq/sbGN9RI9t
	iDNkFhyYf1WfbADqxR51lLSXNZ//tAiIM5OViukWI6aoVjseuzuypnFYFgNB2rbBuQr4plgwQJn
	egC9rIJm789LSyalF3HBUWr6wjI1DneRjF4rLl5j0huBW9aMwWF0
X-Google-Smtp-Source: AGHT+IGl+NstTMjgybGB9EYD0JQzbEyUpBX9if8jrfjZ3Iu1/Mb/HSyvxMxcHsmcI2VRTWEE65ru+A==
X-Received: by 2002:a17:90b:3904:b0:2ee:c918:cd60 with SMTP id 98e67ed59e1d1-2fce78cda3fmr17653440a91.20.1740341210769;
        Sun, 23 Feb 2025 12:06:50 -0800 (PST)
Received: from ideapad.tail50fddd.ts.net ([139.5.199.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fceb110411sm4959806a91.36.2025.02.23.12.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 12:06:49 -0800 (PST)
From: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org,
	ayaanmirzabaig85@gmail.com,
	syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com
Subject: [PATCH 1/1] radix-tree: Prevent NULL pointer dereference in radix_tree_node_rcu_free
Date: Mon, 24 Feb 2025 01:31:08 +0530
Message-ID: <20250223200603.38895-1-ayaanmirzabaig85@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzkaller reported a kernel NULL pointer dereference:

BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0 P4D 0
Oops: Oops: 0010 [#1] PREEMPT SMP KASAN NOPTI

Call Trace:
 <IRQ>
 rcu_do_batch kernel/rcu/tree.c:2546 [inline]
 rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2802
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 __do_softirq kernel/softirq.c:595 [inline]
 invoke_softirq kernel/softirq.c:435 [inline]
 __irq_exit_rcu+0xf7/0x220 kernel/softirq.c:662
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:678
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194

Reported-by: syzbot+80e5d6f453f14a53383a@syzkaller.appspotmail.com

Link: https://syzkaller.appspot.com/bug?extid=80e5d6f453f14a53383a
Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
---
 lib/radix-tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/radix-tree.c b/lib/radix-tree.c
index 976b9bd02a1b..5cefbfd7677e 100644
--- a/lib/radix-tree.c
+++ b/lib/radix-tree.c
@@ -292,6 +292,9 @@ void radix_tree_node_rcu_free(struct rcu_head *head)
 	struct radix_tree_node *node =
 			container_of(head, struct radix_tree_node, rcu_head);
 
+	if (unlikely(!node))
+		return; //Prevent NULL deref
+
 	/*
 	 * Must only free zeroed nodes into the slab.  We can be left with
 	 * non-NULL entries by radix_tree_free_nodes, so clear the entries
-- 
2.47.1


Note to reviewers:
I'm new to kernel development and would appreciate feedback on patch
formatting or workflow if I missed any conventions. Thank you for
your patience and guidance.

