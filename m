Return-Path: <linux-kernel+bounces-521560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09061A3BF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59EC417A575
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B8F1F37DB;
	Wed, 19 Feb 2025 12:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udfAtBfN"
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C02B1F17E9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969733; cv=none; b=N57fu2nNyeKZ8FOtH5cwY/2tgkJjzreLH3rIvLDhxZ5AAVWbMRZGAnLwlqRk4HrrZntmXlvBo53juixmLfdcBueGdSvrhaKkotjKGIPteL2tn1MhiI9s8U/TNRWzdcbY6MWh7MyKG44PoLPDuPVrYJ6K7qDJd1pN2zomcVQ1Rog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969733; c=relaxed/simple;
	bh=YNpyjz01xX66Zcbq5ZIBxOqE+DPXQAGfAfnvffOlMDk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hKMHq74UDr6R9AVh7aYU4lXV7aiIW/7mGvSwitgh+1WRKXh+KCbgpVZWsG/pRUq0+oMJp586oAavuaWGyy3/ZyQWBKj3lMT1Nfg8rp4+SR43r9Nlgf8w75sxkyb80mFeF5qCBUZMCUEeV13eoGtVfnJ0/HamRTiLq6/K+UyFncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=udfAtBfN; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-471ec7f1969so15510981cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739969731; x=1740574531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ID8IGZqUO+EaQVQOsNgcPNApuu1uRf/knYDdUOiCuA8=;
        b=udfAtBfNYZl8xUqwcc7eiJTXkfEY7PmE0m/yaxQ87ILtnNiUG4s5KBLriiPliM5L07
         eUXTLV9hZeKtaofOSYFvhQT2bYEhX81omRiB4aJKpziydLgYrjttfTUu+T5GLsrJhzyO
         NSTFnldHnf7ow7DR7/aKFHL0RmxeFa5TTcUuV1XSFBVNkgQWX2bu4S0bwVGKvTf2MGlF
         ZkDY/X2q2BdWdWrkDdKhtWtwuu/oWU0RwGRmld149y/D6KWwm4shrRHeMaALgaHu1+F2
         IHlBF4PVWNjImA4KzkBlFExnCcTctcebf4/+aq7p4iSsSrX+Rh96Mr3jX2qGOYsTwvVG
         IdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969731; x=1740574531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ID8IGZqUO+EaQVQOsNgcPNApuu1uRf/knYDdUOiCuA8=;
        b=CHjnR7NczP+13ptgvieIeEKPpr81nzFIRRXuV6v1E8lHeBOsE/dNn7+o4zoeu74WE2
         3bLcUocmEY7SMemn+DTEOGqGxjqhEwkKLLYl+BcfOLDSYOBDmruUvz7PYGXFP93fHTqC
         pxEGE0xrsoz1p3BZlD6wFV73D3lafVSwUzcr6HsqMtcn+pd2zzDpuUXsMSRQE6GcfUOm
         WBypwAIfbDktEtu6vNsg7l+LG84Sbz2nIze1Hv4K+8Tr3vC6r9QSUpyZ5MPc81ZG1SYL
         M/yCCoeOZfokgkuzDe3M72VmXuJ2QlnOYq1CvgNCUq46iE1dS2h4kJyrjkFqJzmsF6ON
         W+6Q==
X-Gm-Message-State: AOJu0Yxv9x2uqfnAs9/cEyUavuYBEAy3uKifbGApije2kfHmkN5gLdki
	/8uCtacmIYFFo0+39X3g2fG3XJZW9fc1dn8N/8wlNsBBQ2yjUAMc3DCWC05qJAF5stC0GB90Fnq
	fFOjqw3P3Zg==
X-Google-Smtp-Source: AGHT+IGMWYiioxnG7omelh4V0T3z0njtoj2X+co3SS255ZXFQTkE7JlCElj/s4tgxjXkNInggTXn9aHyuvdnpw==
X-Received: from qtbfe5.prod.google.com ([2002:a05:622a:4d45:b0:471:ede7:80e3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1825:b0:471:fadb:9d41 with SMTP id d75a77b69052e-4720810e19fmr50457841cf.17.1739969731326;
 Wed, 19 Feb 2025 04:55:31 -0800 (PST)
Date: Wed, 19 Feb 2025 12:55:22 +0000
In-Reply-To: <20250219125522.2535263-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219125522.2535263-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219125522.2535263-5-edumazet@google.com>
Subject: [PATCH V2 4/4] posix-timers: Use RCU in posix_timer_add()
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

Also add a cond_resched() in the possible long loop.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 kernel/time/posix-timers.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index ed27c7eab456..bd73bc4707c1 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -125,7 +125,19 @@ static int posix_timer_add(struct k_itimer *timer)
 
 		head = &posix_timers_hashtable[hash(sig, id)];
 
+		rcu_read_lock();
+		if (posix_timers_find(head, sig, id)) {
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
 		if (!posix_timers_find(head, sig, id)) {
 			timer->it_id = (timer_t)id;
 			timer->it_signal = (struct signal_struct *)((unsigned long)sig | 1UL);
-- 
2.48.1.601.g30ceb7b040-goog


