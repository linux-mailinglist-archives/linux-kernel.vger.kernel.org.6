Return-Path: <linux-kernel+bounces-515087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A58A35FB1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 089217A59F2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35E6265CB8;
	Fri, 14 Feb 2025 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z5ozKLeg"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30F265CBB
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541559; cv=none; b=TMganlbNVCvQaEZukVzvXD3O/isniPPlmZQyQHboF/T1EFC2m3p4kgioiqTzDZ/pVotsdMwIwyQx8/c52lNFJ2YdYpGEiSKJ7rD5DZMfRbAKZjoD55vyiaznWTcJyHRzmwGs3QPFBpn7D1uWLEsGPuBfz7g8Pot2d3y4I0kGvXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541559; c=relaxed/simple;
	bh=g+Ef+bvJCXnr2fnE6ROAKPn2T26076corKifdGv/dhE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DkXxWbiJML0i7P5hG7fxMUPPVIzGyPwUAbJmVqMkiySaG+FeT5B0FApVXC4GXtSVw4T966BRz+UXc+Bu8956Anc9fk9uHAp9b2WhRJjxoXuDT2u72cg1OAoBlYNLSfwCse7bUn8l3DQvL+BWhJBgIFIxPkh0DEgvh5e6n2kTOIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z5ozKLeg; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c0784e91e4so208773485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739541556; x=1740146356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/AyOaPuXyGpDU+d1RnpKJaFpTE21ht1sJRDkQSr5LTU=;
        b=Z5ozKLegQd8wqTH9xOpJhcnQl1Wnsnd96fQo3K2JM61Y9K06dczL6+50kautk+cG2i
         z6s+KXWoZhpO6+0ZccpJBo1M56Ng9wlKgCJY8XFjnl+UZFN+pAHVZcDNgO/EODKSflIb
         YLeF7Px8dF9jWUzTRkW97UM2YkTGajarcDYCoRvnx6IguYBdcSjUE3ANJWugJTzGYVGw
         NelQccYN7SBAvZRCuaWE3U/BSaUbGrXGH446bP9JYbEy2fxAVMUnxgfRjnrnSG6C4jdH
         QyNLheY+A1ECAy6dA4k6bj6zqYYD9CKji6zzT6BKGqKUr/mXi2hYQszphWZcMooP58Lw
         Zvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739541556; x=1740146356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/AyOaPuXyGpDU+d1RnpKJaFpTE21ht1sJRDkQSr5LTU=;
        b=xNxupqHq5t6TbhVTinLNbuvlo5W3ynms2Ki1e0fDdkRxk9lvx5vbKZR2HKKGeRhDpc
         UzM0Evsurh11YPuTD/mS3rV67jBoryJfC3iJ4hWJNjJch9V4lBLN28WDyn8nRYqrZndT
         LHfg+HLNoBJFw1gJMj89hZzwp2ah1E+/AoSXeINhjNBAeq3ZYFxPFIC07fjHpZ1UI0QH
         qMMhn6at0tn/fbzFhdq+HsEVsKGTkRS4hOUfCGzNchXTEiQotEyCUIJIKRF5VV4lwxe5
         uUTckCXG2L0kSg3qBik1AwdtsgagSX+UxzyFpBa5DWmugBuxRHmxj0A/f+zTTGKLA+ax
         VgKA==
X-Gm-Message-State: AOJu0YxY/1O88rECuyLOdLD5DtET/+k8LpQIsosRsaNm1kJgUU0x1aII
	YEUCWdnGpbqfwxhtGyBzPo88Kt0sumYZs2rsWt/+pmKeT0IxY3uwqkzL7VRz+ZZw5BkZUy0lOb+
	vYRD+UTStlg==
X-Google-Smtp-Source: AGHT+IFk1SYInwiB6mhJ0ITE2lup7Kgau5WwsvYxr3MNuBisVxDBaec6CE0IuS4GB3hIjUkZ5gG36fKqG+BZYg==
X-Received: from qkd3.prod.google.com ([2002:a05:620a:a003:b0:7c0:6ed4:fcee])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1993:b0:7c0:8950:e3ed with SMTP id af79cd13be357-7c08950e4ffmr65514385a.54.1739541556299;
 Fri, 14 Feb 2025 05:59:16 -0800 (PST)
Date: Fri, 14 Feb 2025 13:59:11 +0000
In-Reply-To: <20250214135911.2037402-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250214135911.2037402-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214135911.2037402-3-edumazet@google.com>
Subject: [PATCH 2/2] posix-timers: Use RCU in posix_timer_add()
From: Eric Dumazet <edumazet@google.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall <bsegall@google.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

If many posix timers are hashed in posix_timers_hashtable,
hash_lock can be held for long durations.

This can be really bad in some cases as Thomas
explained in https://lore.kernel.org/all/87ednpyyeo.ffs@tglx/

We can perform all searches under RCU, then acquire
the lock only when there is a good chance to need it,
and after cpu caches were populated.

I also added a cond_resched() in the possible long loop.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 kernel/time/posix-timers.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 204a351a2fd3..dd2f9016d3dc 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -112,7 +112,19 @@ static int posix_timer_add(struct k_itimer *timer)
 
 		head = &posix_timers_hashtable[hash(sig, id)];
 
+		rcu_read_lock();
+		if (__posix_timers_find(head, sig, id)) {
+			rcu_read_unlock();
+			cond_resched();
+			continue;
+		}
+		rcu_read_unlock();
 		spin_lock(&hash_lock);
+		/*
+		 * We must perform the lookup under hash_lock protection
+		 * because another thread could have used the same id.
+		 * This is very unlikely, but possible.
+		 */
 		if (!__posix_timers_find(head, sig, id)) {
 			hlist_add_head_rcu(&timer->t_hash, head);
 			spin_unlock(&hash_lock);
-- 
2.48.1.601.g30ceb7b040-goog


