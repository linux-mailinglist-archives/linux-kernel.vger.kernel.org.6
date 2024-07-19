Return-Path: <linux-kernel+bounces-257231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB19937718
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 13:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9F101F2264D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 11:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F416B85283;
	Fri, 19 Jul 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tfc7/4kL"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F4B81749
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721388105; cv=none; b=tXBmz6ot/E0avWVGDYa0bKo5f+qDszUi7EZ7V9QiE9yePrAztlO6kR+c9XbJiNQkWYnPL6mho4lbT6Htr8TRIOzqC19avPT5NAVIzOq4wGH6lqrYjehxPCs5QCoGeEu/wr6tiI44029JD6HuOhsIJg8Tewlt8nU4yZeMoqufHUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721388105; c=relaxed/simple;
	bh=55xjmpAmbggRS3zUxzXrZVFp6O0djg6yHSBGwvbz8Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BZ8thJqXOSL8Z0AnChWF8CpnI3Ixs98qz+HqNObroNf8nrf/+2kB47fUd71PRbc2B3sS3a62l2YCtguQ3tm8rg8xJw/ojPgqybbW6AwyUMQywJSiFMD2UN1dtKl1e1pAgfdAV4Xwxr7vXl85Smlxydrd2y4wVEuZroGpj8owzis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tfc7/4kL; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a10bb7b237so954411a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 04:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721388101; x=1721992901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gADSwh7vQ0pmA4LGOHCgRmZsvdwxT2u8pSsPjGHcyRw=;
        b=Tfc7/4kLXCLQtvoaSLJHfg2KUt40PVmq0i5NhTgmSNCRzLgUHXDcIeyDOWivQTRlkW
         J36ZkWyu6aeEnh2ILKrG78ASmjrOxi7t5Y5v8n9MfDl7/SRe5PZQJIR9yGxlAoPlnh6M
         oIxGYLLN+7qYaf/WjhSWJPDjgeuPPLjZ4qPhIiU5+oq7KEtjSgcA/VPyNx15EOESWOnU
         I8F87U8PbYVlYwweI9NatY9oYuWTtnpwTInjnQDroKAjhazO4eMY37bw3oAheIy0oir2
         50Vhjuk+9TWlLaw4mAhJwUHIpaJ+ar2d+zkfYCWSet0SG09U/bTP8K9E3wl2Hq/bXVcy
         255Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721388101; x=1721992901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gADSwh7vQ0pmA4LGOHCgRmZsvdwxT2u8pSsPjGHcyRw=;
        b=TfZzWi6JT3/sN/g8PCCn6hP8vjGeTo46niwZA62L9qbZ5Nt34eBFazksCxQpd5hkTd
         cMgWW85c732OrUeT8tu21Mniwk9jHWP2nQr3xErb4RYpS2af7Cac8FW29IO/uksGEDaj
         L7A8lZDkJ2s2qENNbBj12mVZTZxFIXbIo4qIGxgYdq6V08yyOjzho1BsAb30PXyL2lY0
         gcyDMQOh663DhdJL/rfNxJq3BhRj/qLijPbkoYQOsOdG1RhddrW/FV9SwrDbOTaAS4ou
         7rv476Kz9XJDyE0EBScMeRid/9TJXi7RdB4Y9EZG/gxHsKELJqi0/kcEeYhmzAGWVZql
         MFDA==
X-Gm-Message-State: AOJu0YwA0DxgT2q5DiZOdGYE+r41MWoSnSQs7ImlJDD2Sk1eCk35Mvz5
	jG50qc9n8MOFkjzpt5kxD1pyFwpARRc5HuXsDvm/LSUUw432lkvNeJh6R2ww
X-Google-Smtp-Source: AGHT+IGz1ib9L3gWtw6QlE2ukRn14VnEMe0vgXS75fkv///96mBYwIsNIgLMAA6XrFUV5rDAAzZxGg==
X-Received: by 2002:a17:906:594d:b0:a6f:96ac:3436 with SMTP id a640c23a62f3a-a7a0113f1d3mr486123166b.11.1721388101272;
        Fri, 19 Jul 2024 04:21:41 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7a3c7bf13fsm18656666b.90.2024.07.19.04.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 04:21:40 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] locking/osq_lock: Use try_cmpxchg() family of functions instead of cmpxchg()
Date: Fri, 19 Jul 2024 13:21:08 +0200
Message-ID: <20240719112130.59260-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace this pattern in osq_lock.c:

    cmpxchg(*ptr, old, new) == old

... with the simpler and faster:

    try_cmpxchg(*ptr, &old, new)

The x86 CMPXCHG instruction returns success in the ZF flag, so this change
saves a compare after the CMPXCHG.  As an example, the code in osq_unlock()
improves from:

 11b:	31 c9                	xor    %ecx,%ecx
 11d:	8d 50 01             	lea    0x1(%rax),%edx
 120:	89 d0                	mov    %edx,%eax
 122:	f0 0f b1 0f          	lock cmpxchg %ecx,(%rdi)
 126:	39 c2                	cmp    %eax,%edx
 128:	75 05                	jne    12f <...>

to:

 12b:	31 d2                	xor    %edx,%edx
 12d:	83 c0 01             	add    $0x1,%eax
 130:	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)
 134:	75 05                	jne    13b <...>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
---
 kernel/locking/osq_lock.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 75a6f6133866..4f89ac8e6a69 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -58,8 +58,10 @@ osq_wait_next(struct optimistic_spin_queue *lock,
 	int curr = encode_cpu(smp_processor_id());
 
 	for (;;) {
-		if (atomic_read(&lock->tail) == curr &&
-		    atomic_cmpxchg_acquire(&lock->tail, curr, old_cpu) == curr) {
+		int tmp = curr;
+
+		if (atomic_read(&lock->tail) == tmp &&
+		    atomic_try_cmpxchg_acquire(&lock->tail, &tmp, old_cpu)) {
 			/*
 			 * We were the last queued, we moved @lock back. @prev
 			 * will now observe @lock and will complete its
@@ -157,12 +159,14 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	 */
 
 	for (;;) {
+		struct optimistic_spin_node *tmp = node;
+
 		/*
 		 * cpu_relax() below implies a compiler barrier which would
 		 * prevent this comparison being optimized away.
 		 */
-		if (data_race(prev->next) == node &&
-		    cmpxchg(&prev->next, node, NULL) == node)
+		if (data_race(prev->next) == tmp &&
+		    try_cmpxchg(&prev->next, &tmp, NULL))
 			break;
 
 		/*
@@ -215,8 +219,7 @@ void osq_unlock(struct optimistic_spin_queue *lock)
 	/*
 	 * Fast path for the uncontended case.
 	 */
-	if (likely(atomic_cmpxchg_release(&lock->tail, curr,
-					  OSQ_UNLOCKED_VAL) == curr))
+	if (atomic_try_cmpxchg_release(&lock->tail, &curr, OSQ_UNLOCKED_VAL))
 		return;
 
 	/*
-- 
2.42.0


