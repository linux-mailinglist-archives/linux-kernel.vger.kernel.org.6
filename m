Return-Path: <linux-kernel+bounces-345819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB4298BB7A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD8F1C236C3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54FDE1BFE07;
	Tue,  1 Oct 2024 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvYI6DVn"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CCA3209
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727783184; cv=none; b=Wox0e9kQ2mehD3CWL0iWxRa5aMKHbcmR5fNHX0j5UNUEesMhOFj5djn56e7MGtHfYSt3VJW8reiP7YwAIQ+g6wZHgMtt/aqFBc8RdaxibGa+y5tgydgsi2jBJgdRsjs9BzTHU/4lUu+USnkn1xiHxxcS35uX4iu9Db+IIt1JdTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727783184; c=relaxed/simple;
	bh=6XAJetPE5odAFJnlpEz8QN5/rOna8OaSwBnmgM6gRJk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kn6ar3UyzwMDq3xI1XkJBbvtrW74O9KV4LBYgd0DCXFe7129Z933XVbhQTHiuZ/3lSgJjUxZF8JUeto2ntJoX4lV+kbq7/HZfkoqzNqfQivth5oGBzV1fCH/hdt5uOSSz4As0fTpu3yL5dr7zOTRqlDttGaeqQoVFPmQw1CSa+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HvYI6DVn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42cbbb1727eso47982205e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 04:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727783181; x=1728387981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pp4OoMJE260sGCJG2dLTQy0ixyNPfcVKJzV9b5k6Axw=;
        b=HvYI6DVnYlI0qSOqyj0LX5DGUDxsE0vx6NuTedsx3vx3iIaAjaQmTC3hIF/HBUtz1l
         PyY5kJTthinWq2k6AfV5l7xeO1Gm11U/lAXVQO5YqGEavJ5xoFJY2v3pOJlPqnNs7dzX
         jykBX3CqEjug5m0valuviA2TwcyAJhsgdwRObtlCb39ONAV0BJoiD9VprASuPoiuUzVT
         FoKFZaS5Tszos3UmpYNThkLNw1/WBSQPWjQD6N5jIH/9Ys038lGJL79ROMrwhUNRh4ap
         Wo1th6xiAtkxOHPuUWrcPvx4AdHPEi7Lusj4+bXAyYX5kD2cE/YTrMFOm4adLTUhgOlA
         oTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727783181; x=1728387981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pp4OoMJE260sGCJG2dLTQy0ixyNPfcVKJzV9b5k6Axw=;
        b=uU1XVXGbPsGiFyTjrGpQx6j2dsh31I6SCvzQ1QU87ElZgaGme4pdJpJ7wIYY74JJ3C
         7t2luP33EkIt5QGXOqJcAFzrXVQmBkeWIRT+h/y8WYZHPWFgPy374Rh0rKK8+c4iobeb
         bYwcjm3vMzBUFGv01sVlGVcKlpHj8FdxVkUBxNmvQW83Bm8XL4+e8J934IR2a9TDKNXO
         G17SV4ag36ioDQaCv/ug2RoApge1cCwcO7W3Z5ZWnkF/5ZTQrq6CwT5PXIEsuQCDX6Pg
         PIBE0gmp2KcwcaS91ZhJDbAsLc0LyZEaJptPHUuW8DjC5zwaCM5DXJOZno9r2uqB0Or8
         yZkA==
X-Gm-Message-State: AOJu0YzVMXx265Tpk8eAxB/dmMJSuDOc9QhcEjENdKUQz2NJmZmDQCYl
	3OdUPMhfzWCwlhfFJe09Lsoud0YjKveR8288ybrKi8RYojZqURsypShpTa8OOiE=
X-Google-Smtp-Source: AGHT+IHOqmNJYykIVf20X3n6aw1kM58lGG52U6As1fH2UOfnsS8qwotzf8UH3vcVaf3p9uEYo1z7kA==
X-Received: by 2002:a05:600c:a02:b0:42c:c003:edd8 with SMTP id 5b1f17b1804b1-42f5840a6d1mr113363675e9.6.1727783180564;
        Tue, 01 Oct 2024 04:46:20 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57e1394fsm133260455e9.33.2024.10.01.04.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 04:46:20 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH] locking/osq_lock: Use atomic_try_cmpxchg_release() in osq_unlock()
Date: Tue,  1 Oct 2024 13:45:57 +0200
Message-ID: <20241001114606.820277-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace this pattern in osq_unlock():

    atomic_cmpxchg(*ptr, old, new) == old

... with the simpler and faster:

    atomic_try_cmpxchg(*ptr, &old, new)

The x86 CMPXCHG instruction returns success in the ZF flag,
so this change saves a compare after the CMPXCHG.  The code
in the fast path of osq_unlock() improves from:

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
 kernel/locking/osq_lock.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 75a6f6133866..b4233dc2c2b0 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -215,8 +215,7 @@ void osq_unlock(struct optimistic_spin_queue *lock)
 	/*
 	 * Fast path for the uncontended case.
 	 */
-	if (likely(atomic_cmpxchg_release(&lock->tail, curr,
-					  OSQ_UNLOCKED_VAL) == curr))
+	if (atomic_try_cmpxchg_release(&lock->tail, &curr, OSQ_UNLOCKED_VAL))
 		return;
 
 	/*
-- 
2.46.2


