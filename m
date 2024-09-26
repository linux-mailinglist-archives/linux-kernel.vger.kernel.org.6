Return-Path: <linux-kernel+bounces-341154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCFA987BDD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 01:37:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3CE1C22F96
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFD71B07CC;
	Thu, 26 Sep 2024 23:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D0BRapTp"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC7F1B07C7
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 23:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727393816; cv=none; b=IhghtnDJ+QvwPHtgjvdIaC4KXunBH+C15LYunnqmAPYMOcYsk3q4PHnqybf8YVZBcg2WDbWQ4w6QA2Ai+1c+cnFdahDOAMZdNFzI9LMiHzBbvKhBGaxywRT82wyJ7oQh4YT213/WvK4FWhT++8vrR+OE3RTraNA1ZwVTkfjOlbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727393816; c=relaxed/simple;
	bh=ae5tTSVI1o+B0gCRfKTrz5iX28d2to5YMLSbIYZCEPw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dEYs/PQ/DZstiPT36NCbecCTKc2Fllubxup+BWc+9snc0kQBD019D6yyYZTOG6mUEYnf6TzEI8BxrXilHEH6SbGR/NuDmz5yX/+KYiv9fzsmo9trB4Br9AhNgrKBY2/V27zrsTulySYK1dnOepjxauQl2k1o1CEuNIY6Q31NGH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D0BRapTp; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2078e8b1458so16656125ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 16:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727393814; x=1727998614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QhifSB/hHpukB8XTWcNXtGxQM9EjwaxZkFwn+v4ygvg=;
        b=D0BRapTp268kBCwO17A5hxMMWNJyXB/W7DPhD+Epz7uBRPMPwkG7v1GFU7Jis1oqdv
         ml+9v+9LdAp+fT9QSYno7OZj8VMNdjsd5SVSagm7aw+4Jhu10cKOIEAmj++hNBO7WagB
         aualwKnTSoLu3iocjBKwBcShVdf0xhEUm+ZTJwV3UEsqrU6T+jUoocH3pR6rCX7AGsOj
         al3hoIepio3hZlmfG3V+1dCrSbHFY560WYe4FJGqTaCOu/yhoqDR41SlWtB7HQ6dzysH
         XBuC3HU3SXCZD+54ClQhJzlXx01h8J6WNJu6zdtmmHiatJQNwAXUteRfp+N5PA8OwJjy
         crug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727393814; x=1727998614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhifSB/hHpukB8XTWcNXtGxQM9EjwaxZkFwn+v4ygvg=;
        b=YrxAazfRfs/2nGltzZzgAuZbOyxOQHh3sZKX38Q4iJPTb/8+lt6llrNkqUQwDhJvp4
         xpxuLAFKRpWMsmR4dtt6Jdzm6SThemIIjAZoLKD3PmjnXuXZPqfG9JqR43QWxA6DM39N
         /OqLfZvIF7WbFbekkzoITDjgJLpcJnFlZBims37ZGbMgQkUuyzjMn/+kl1WdKRGCq50q
         /1ehohu4psXfHnblVlwtUnAh5j8Y8NxneUGz3Mqx1u5eU1kjP1IikI36/zeUx8a5cKNT
         iVRSCiLKH1+I937TiD5aT5FBZw5VFUXEAbzpyVEjvKRp4Jpsr/RcI0ACmRFJOVG9DJ7x
         LLGw==
X-Gm-Message-State: AOJu0YyiEJhGiSxmh6IUOlimBh82ji2ucCb7F8vPR27wcbqCDde0NsVe
	GztTqjtq3sN4uMnAlK3DXuhIyQaoQVwztpwb3Io1TVNRvf/cTxxClkNHV3vaYfi5dMBBwKW7oBi
	+MwbjBLm4PQ==
X-Google-Smtp-Source: AGHT+IGMSmcCdezkWQqFnhS5J93mwv5qL82nJp4ZmV6uOtM7S8fzgPqEPRAjYDsO1Bar2n2ZoLLnn96gSc75qA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a17:902:d4cf:b0:207:4734:2cb7 with SMTP
 id d9443c01a7336-20b367e701amr149175ad.4.1727393813724; Thu, 26 Sep 2024
 16:36:53 -0700 (PDT)
Date: Thu, 26 Sep 2024 23:36:17 +0000
In-Reply-To: <20240926233632.821189-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926233632.821189-1-cmllamas@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240926233632.821189-7-cmllamas@google.com>
Subject: [PATCH v2 6/8] binder: allow freeze notification for dead nodes
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Yu-Ting Tseng <yutingtseng@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Alice Ryhl <aliceryhl@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Alice points out that binder_request_freeze_notification() should not
return EINVAL when the relevant node is dead [1]. The node can die at
any point even if the user input is valid. Instead, allow the request
to be allocated but skip the initial notification for dead nodes. This
avoids propagating unnecessary errors back to userspace.

Fixes: d579b04a52a1 ("binder: frozen notification")
Cc: stable@vger.kernel.org
Suggested-by: Alice Ryhl <aliceryhl@google.com>
Link: https://lore.kernel.org/all/CAH5fLghapZJ4PbbkC8V5A6Zay-_sgTzwVpwqk6RWWUNKKyJC_Q@mail.gmail.com/ [1]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 73dc6cbc1681..415fc9759249 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3856,7 +3856,6 @@ binder_request_freeze_notification(struct binder_proc *proc,
 {
 	struct binder_ref_freeze *freeze;
 	struct binder_ref *ref;
-	bool is_frozen;
 
 	freeze = kzalloc(sizeof(*freeze), GFP_KERNEL);
 	if (!freeze)
@@ -3872,32 +3871,31 @@ binder_request_freeze_notification(struct binder_proc *proc,
 	}
 
 	binder_node_lock(ref->node);
-
-	if (ref->freeze || !ref->node->proc) {
-		binder_user_error("%d:%d invalid BC_REQUEST_FREEZE_NOTIFICATION %s\n",
-				  proc->pid, thread->pid,
-				  ref->freeze ? "already set" : "dead node");
+	if (ref->freeze) {
+		binder_user_error("%d:%d BC_REQUEST_FREEZE_NOTIFICATION already set\n",
+				  proc->pid, thread->pid);
 		binder_node_unlock(ref->node);
 		binder_proc_unlock(proc);
 		kfree(freeze);
 		return -EINVAL;
 	}
-	binder_inner_proc_lock(ref->node->proc);
-	is_frozen = ref->node->proc->is_frozen;
-	binder_inner_proc_unlock(ref->node->proc);
 
 	binder_stats_created(BINDER_STAT_FREEZE);
 	INIT_LIST_HEAD(&freeze->work.entry);
 	freeze->cookie = handle_cookie->cookie;
 	freeze->work.type = BINDER_WORK_FROZEN_BINDER;
-	freeze->is_frozen = is_frozen;
-
 	ref->freeze = freeze;
 
-	binder_inner_proc_lock(proc);
-	binder_enqueue_work_ilocked(&ref->freeze->work, &proc->todo);
-	binder_wakeup_proc_ilocked(proc);
-	binder_inner_proc_unlock(proc);
+	if (ref->node->proc) {
+		binder_inner_proc_lock(ref->node->proc);
+		freeze->is_frozen = ref->node->proc->is_frozen;
+		binder_inner_proc_unlock(ref->node->proc);
+
+		binder_inner_proc_lock(proc);
+		binder_enqueue_work_ilocked(&freeze->work, &proc->todo);
+		binder_wakeup_proc_ilocked(proc);
+		binder_inner_proc_unlock(proc);
+	}
 
 	binder_node_unlock(ref->node);
 	binder_proc_unlock(proc);
-- 
2.46.1.824.gd892dcdcdd-goog


