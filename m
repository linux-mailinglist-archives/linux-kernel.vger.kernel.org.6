Return-Path: <linux-kernel+bounces-337516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B34D4984B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DEF1C22DDF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 18:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CDC1AD40E;
	Tue, 24 Sep 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jNCK/OEz"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC2C1AD3EF
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 18:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727203451; cv=none; b=ISBuJrqmQjWJp6x+Scx+JQGogKkbJ7haE5RK7EX7WpN1FBupudFOe+eF58Iqoe+4j3E5c30SX9y03JmZ3yiO71ov+jwmO742D6d7ElgbV8BVQSeaqwho4NUkkkhTwoEaVHRnHxfziYfMhQaCs5jnTG5ZRH0qJevKVsLXNUFc0+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727203451; c=relaxed/simple;
	bh=UUyHqG3rcD0Ab4SuxciBNPWo8eGj+cJzd/Ppwu+p3nU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Et0RQ3NKeDfnHDwppD26j3Kc+Ik7nt1qhGjxG2O5GxuxXbmAg2lFPGU35LhSWYcBP3VGasIZTmv+gXT8AP6vK7sPXGLcDQq81nM0F8EmXHq6JeyrxHNZxj3Tg24oKGT8C3DggsR5Zyzdt/o18jVicViorL9YWWmGKIR3mcnxq9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jNCK/OEz; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1a8de19f7aso8807545276.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727203448; x=1727808248; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=mXFF096w9+eTa7nycrgDe+dtSt6FL1ltl1Hn5Oq0MR0=;
        b=jNCK/OEz2Jee8Ov6y1oeqbHTrGDNwyQzbzAdYnJoev27IlOW1W6lRsdUuBJ/TA9ciV
         69nsTudB565xqephWbjN/MSLsRT5e18GSQ/fE3cwFuzCrGmITKiLtpRs+oKlz6JZpmJR
         8O+Agzx7NxODJMn8SNaT8BtxcecfNycefWnZhrPeMkDNbAJgMDMmzlpDONEcoUxarQ/h
         PEUfkahtM2SwS7C+8z26NGlYwFQBv2af3bqhYboEwC3gtZ0s3m5i3MKsoEr1FfbHyOwq
         VKzvbV0gHvdBcMI9tsXJN+z86CYeCHUJJta44us2BxkYdAatfAV7FW6M4V2hUy2bRw+Q
         byTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727203448; x=1727808248;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mXFF096w9+eTa7nycrgDe+dtSt6FL1ltl1Hn5Oq0MR0=;
        b=Pv7A5Bm8a0Eg7eEhlKMaLm+cNIzaxc6JxQ6QJdJnzQ3MV1hmq9RFJH2eO5z4chDzRw
         EI3M7hQf6kuFRV3xLGIAX/fEphsNJUa4282Cogw+Chz/Pdk+u2e9mOPLUiyy9B9tuZui
         3GkFeeDefwMbOLIouMGoexiH/cUZgu6yzE8siRZAE2369kc9nFcFy18p6soHfHQi5QsE
         ACCizXYQqAfNLTsI1Y0LiqbhraZaRby4qGWA1BEbE4qr3ZrC8unyw5Mm7qQW1orDk0Tf
         kubJ5LQL0+q+9h6/J9LhfrELYUFFOHhjScXQJPhbzT70X6moEV1VakuB1ZyvUtiPIHGV
         qsKg==
X-Gm-Message-State: AOJu0Yy2FcE0AgeeUjWRdkW/to6TKelCe+8xyGf5oXxs5uhsmoTqRwgM
	q/DjJfSAcw4OB1M5hVnijNHRwgKmvyuQuHWeGwq+xfiJG4I1gG50Lze3gdwxhL9lT+S0y+UBXOE
	1yVodJoJyQQ==
X-Google-Smtp-Source: AGHT+IE7TREog/VYCdRW7BmWSNJlfncdLF6ON0YLjqEPFLZxC6f6VINj+tsVFYW1XLjggy8Ip/b3i6zoUVctPA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a5b:b12:0:b0:e11:5a3c:26c7 with SMTP id
 3f1490d57ef6-e24d9ec1441mr63276.9.1727203448526; Tue, 24 Sep 2024 11:44:08
 -0700 (PDT)
Date: Tue, 24 Sep 2024 18:43:54 +0000
In-Reply-To: <20240924184401.76043-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924184401.76043-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Message-ID: <20240924184401.76043-3-cmllamas@google.com>
Subject: [PATCH 2/4] binder: fix OOB in binder_add_freeze_work()
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In binder_add_freeze_work() we iterate over the proc->nodes with the
proc->inner_lock held. However, this lock is temporarily dropped to
acquire the node->lock first (lock nesting order). This can race with
binder_deferred_release() which removes the nodes from the proc->nodes
rbtree and adds them into binder_dead_nodes list. This leads to a broken
iteration in binder_add_freeze_work() as rb_next() will use data from
binder_dead_nodes, triggering an out-of-bounds access:

  ==================================================================
  BUG: KASAN: global-out-of-bounds in rb_next+0xfc/0x124
  Read of size 8 at addr ffffcb84285f7170 by task freeze/660

  CPU: 8 UID: 0 PID: 660 Comm: freeze Not tainted 6.11.0-07343-ga727812a8d45 #18
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   rb_next+0xfc/0x124
   binder_add_freeze_work+0x344/0x534
   binder_ioctl+0x1e70/0x25ac
   __arm64_sys_ioctl+0x124/0x190

  The buggy address belongs to the variable:
   binder_dead_nodes+0x10/0x40
  [...]
  ==================================================================

This is possible because proc->nodes (rbtree) and binder_dead_nodes
(list) share entries in binder_node through a union:

	struct binder_node {
	[...]
		union {
			struct rb_node rb_node;
			struct hlist_node dead_node;
		};

Fix the race by checking that the proc is still alive. If not, simply
break out of the iteration.

Fixes: d579b04a52a1 ("binder: frozen notification")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 4d90203ea048..8bca2de6fa24 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5593,6 +5593,8 @@ static void binder_add_freeze_work(struct binder_proc *proc, bool is_frozen)
 		prev = node;
 		binder_node_unlock(node);
 		binder_inner_proc_lock(proc);
+		if (proc->is_dead)
+			break;
 	}
 	binder_inner_proc_unlock(proc);
 	if (prev)
-- 
2.46.0.792.g87dc391469-goog


