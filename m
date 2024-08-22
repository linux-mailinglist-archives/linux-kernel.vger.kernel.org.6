Return-Path: <linux-kernel+bounces-297829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2D695BE31
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 20:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BCFD28299D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38B41CFEC6;
	Thu, 22 Aug 2024 18:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DQAbb8vj"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5AC7347D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724351039; cv=none; b=M7aO8C7Ny6yt6zG5pb0Y7a1VviXBI4/SoaErYPTqVn6HMIcIZGpC7pvOYbWjpvjfkUD2MgbYtN4fkVa0aZiz3Tqk61sIvyvUI8DB0N13q0vZl7+KzJ/M+Ee4lymxGc0AARhR3qpTPxw+YtFhF+bbIJB4Xljt8pPlqGkjl/SFQQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724351039; c=relaxed/simple;
	bh=6oJWkRUERFpB3blIaG9wUxYb6rEF/EMjl0nYm0PPiQo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DUYzk45Wp8TmG+teTIJtdGozXvb6b0pqqfJeQ/xWfZp4vccTtwlG/1a5h9CTRzzIc8J1eNVaDmA4IpnSGSWwQ1AnMWGpT1D1wjWo+d//vc8SxHgswt2WXYEca96KNQW65Q1uMHKn1zbV/rLqEMB6+pkq2bWGiSoNCyeMy1KyoZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DQAbb8vj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b38bd44424so20715637b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724351037; x=1724955837; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U+hG+801nTFiswIqakBQXEm/IokDZ+OxzOt1ioPF7rw=;
        b=DQAbb8vjuklhZKWnRN8YbX9GwD3cpEHVJ/WHCplTep5m3cOOKqaLR7MRtuDgRslis+
         rl6P3r3PfnLypmAel90ucym3tLX43BDVXEks9YEobymw8vRZgNoEz/B8LmiGCoKhGzOO
         P0YBfpOozkrZAhYWyQ9kVb9S4oydWVE9ugr7dE0yrIQS1TTbYtAbrSiRLarpNUUqaF/P
         yvIRSTxpSaREX8Un5D24SaYkrsnEMvQv3gkXKydcVYIvcf6tnyCD7vnn0cRLFO59uO0q
         jhSrb95LGn73h/bG2ejVXITQ2RTuHa0N1ZdVj3MlHQdJmK9xcOwfpla8YcjXaQ22KyMs
         LbLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724351037; x=1724955837;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U+hG+801nTFiswIqakBQXEm/IokDZ+OxzOt1ioPF7rw=;
        b=rLbsohBUth3LbOgShGqfaFH4ewgJNVsB5HSD5/Wy7tGVTcx+OO1HFZMsZj2mMhDHUE
         icTm13YNIJlrP3xHEhkFe3+y/L8qXxfi3abeii5Dcn8zEe5J5QXH0F4KNfDevXK0ofDj
         nBTht9/61cyJesgtXYZYdavyQdoyF/aNpmIZsKl9bmcJ16hu9IsX+WHWaQrYYmxMMHci
         BkSuV/SJiWPkcdS2P5Q4b199ndnKmHKP2QFLzWTrwSBaUiMiytuZ1r7RULuXJNT0mG1X
         Qi/rbbxmqrAnBIm6U4c7EC4pLIXHIk4WphOLPf5619Gc2s+wZ7VQMpx/FVDLvLRavp4U
         QMwA==
X-Gm-Message-State: AOJu0YzCIWn5kTgWBhKwVfOFwdcZN7dCPOA9Mdb4karxwYKOWZWF34Qx
	NYWh7UxtsqsyH70FP5X5mZipsZphpRa8aZAd334w9isdOF09v2UIZv4w0KgzUbK8iWooyXTIqYK
	MuV5RwLlLGQ==
X-Google-Smtp-Source: AGHT+IGL3M8E0FGhFOjRuhFKH/kFSpPF3ugmAHbWuJ2qVdPZ+0SaWvWhHdLf4oiHO4rCpWSjXyBMkwnrPwO5tw==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:690c:62c8:b0:69b:2f8e:4d1a with SMTP
 id 00721157ae682-6c0a08fcac2mr4589687b3.9.1724351037439; Thu, 22 Aug 2024
 11:23:57 -0700 (PDT)
Date: Thu, 22 Aug 2024 18:23:52 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240822182353.2129600-1-cmllamas@google.com>
Subject: [PATCH] binder: fix UAF caused by offsets overwrite
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Todd Kjos <tkjos@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Binder objects are processed and copied individually into the target
buffer during transactions. Any raw data in-between these objects is
copied as well. However, this raw data copy lacks an out-of-bounds
check. If the raw data exceeds the data section size then the copy
overwrites the offsets section. This eventually triggers an error that
attempts to unwind the processed objects. However, at this point the
offsets used to index these objects are now corrupted.

Unwinding with corrupted offsets can result in decrements of arbitrary
nodes and lead to their premature release. Other users of such nodes are
left with a dangling pointer triggering a use-after-free. This issue is
made evident by the following KASAN report (trimmed):

  ==================================================================
  BUG: KASAN: slab-use-after-free in _raw_spin_lock+0xe4/0x19c
  Write of size 4 at addr ffff47fc91598f04 by task binder-util/743

  CPU: 9 UID: 0 PID: 743 Comm: binder-util Not tainted 6.11.0-rc4 #1
  Hardware name: linux,dummy-virt (DT)
  Call trace:
   _raw_spin_lock+0xe4/0x19c
   binder_free_buf+0x128/0x434
   binder_thread_write+0x8a4/0x3260
   binder_ioctl+0x18f0/0x258c
  [...]

  Allocated by task 743:
   __kmalloc_cache_noprof+0x110/0x270
   binder_new_node+0x50/0x700
   binder_transaction+0x413c/0x6da8
   binder_thread_write+0x978/0x3260
   binder_ioctl+0x18f0/0x258c
  [...]

  Freed by task 745:
   kfree+0xbc/0x208
   binder_thread_read+0x1c5c/0x37d4
   binder_ioctl+0x16d8/0x258c
  [...]
  ==================================================================

To avoid this issue, let's check that the raw data copy is within the
boundaries of the data section.

Fixes: 6d98eb95b450 ("binder: avoid potential data leakage when copying txn")
Cc: Todd Kjos <tkjos@google.com>
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 905290c98c3c..e8643c69d426 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -3422,6 +3422,7 @@ static void binder_transaction(struct binder_proc *proc,
 		 */
 		copy_size = object_offset - user_offset;
 		if (copy_size && (user_offset > object_offset ||
+				object_offset > tr->data_size ||
 				binder_alloc_copy_user_to_buffer(
 					&target_proc->alloc,
 					t->buffer, user_offset,
-- 
2.46.0.295.g3b9ea8a38a-goog


