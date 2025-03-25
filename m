Return-Path: <linux-kernel+bounces-575990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2CDA709AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC7F17A335
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 18:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A2B1C6FEC;
	Tue, 25 Mar 2025 18:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4EYSlkYM"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811771ADC86
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742928552; cv=none; b=SrOqwKqRe/q507y8uB9pgNUU0vnDokbPQYYitEVd0zOEKqg06k6iBGOFiqPlgTM4ePRb9blcwjI/fHQ4n1uCvNGMJSFza94qysunCC5Z1a6GnrfKo6ZZsEsrcu2Aqjzwg7OPNvzkgNvexmQuH05SU/7W4L+pU9DXP+mQi/rGiOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742928552; c=relaxed/simple;
	bh=6AKG+4MIU3nFkzhQI1KPFHDmJM4sAAvKCqzFZ2pchRM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aAayKH7s36L6Jxy1oNJkjUpbUKt6IOfX/N/+u7hYVyxDtAttLYXwp3pxYvo7PoNSbwRp9UaxHiv+9BFa4XV6G+HUcS7+t3IpQ4iPDrXlF+AwJxbEaEvSJv1zUNvQDFf55DZcEtXrJfuXcPg6/CylVyPkecIDaMAPUGZsmqwyxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4EYSlkYM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff78bd3026so10189129a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 11:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742928550; x=1743533350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+GYzbbMon8zBFYnMfBByCIqb+0VFAaEep9NdHw4CNu8=;
        b=4EYSlkYM2zHNZ7lYAjytaJNEMkXEMarq568obbxlDzWgGhYw1ENd9KHYAdzDO4eZOH
         0sJU+cAfUvnptluNFYkQlUv/RLSlbEUwYOs1CXxv5eti85XxvsENNv9Z7dI9nU7K+Sbr
         AicBI6jq9u9tQbarHeBaCXzOA/7MexU7CWJ5W+T0S7YWXzK9Ik0XNXgqQFHDbmW1Mqkf
         A7Ko3mNOfDR/VQe0cQnCFzsE0VMsu9WXHj9EYey3O+xd8OUYzDzwdFsso6QV22dBIa3U
         FdK4I+V9K2rrREbQTXUO8npkuVH4l02Fk4jP4Td/nQg7jCLgOIq8C3Ftmc4npnmF02Xq
         3gvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742928550; x=1743533350;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+GYzbbMon8zBFYnMfBByCIqb+0VFAaEep9NdHw4CNu8=;
        b=u9BPCUu9va/y+o7RNUyRWINo2Wmhx2yAsggwpy1m53pH6SQ+o0zE8A85oL/PQSBQAA
         7iSQEY6SMEMePN+TJqBrH3QbtnCUjDlVkZwIpo5qXFOeQUpPSs3m+wkY3vXipCCfZnuj
         fVGs0Q0hga/4cL5Atvm+TzqkC+ETGhyzXIrcks8aAkkzB3nWmzdY8sHaelATFJ35V/XC
         v4bdP1MArI2nuryyJfSf1QzeDkbGdGQH2LE3iZ7FDActev93BE9gPSyfXCoyqFHsjKxW
         DR2TrV5+d91cuH76bAoDZW25YGLTTc+l6VpykGBesNMEvBp2y/UNpeAjN8l6LOJuZq/B
         mgRg==
X-Gm-Message-State: AOJu0YyPQxC/QSoC2LZbpKk8HWOo2QBDwaDdxK7GMMSqP3S+0psRQdLm
	Ex7mgd/GYrG/qbbu5/4DQeD727GuptM8Hbbf8vJw5cf8rNCtlIJKLHKchV5W9QY8mDjObPVjVvX
	wRoTs5pVqOg==
X-Google-Smtp-Source: AGHT+IFLLKVhdVugqD5pcE0y+fL5jXQTQK+4ePWC9LHMiExN+AlvX4zavqO6tq0PKuWuySMriKun4+wfAAS6zQ==
X-Received: from pjm7.prod.google.com ([2002:a17:90b:2fc7:b0:2f8:49ad:406c])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:134c:b0:2ff:53ad:a0f4 with SMTP id 98e67ed59e1d1-3030fe93f0dmr35266909a91.12.1742928549694;
 Tue, 25 Mar 2025 11:49:09 -0700 (PDT)
Date: Tue, 25 Mar 2025 18:49:00 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250325184902.587138-1-cmllamas@google.com>
Subject: [PATCH] binder: fix offset calculation in debug log
From: Carlos Llamas <cmllamas@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com, 
	"Tiffany Y. Yang" <ynaffit@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The vma start address should be substracted from the buffer's user data
address and not the other way around.

Cc: Tiffany Y. Yang <ynaffit@google.com>
Cc: stable@vger.kernel.org
Fixes: 162c79731448 ("binder: avoid user addresses in debug logs")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 76052006bd87..5fc2c8ee61b1 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -6373,7 +6373,7 @@ static void print_binder_transaction_ilocked(struct seq_file *m,
 		seq_printf(m, " node %d", buffer->target_node->debug_id);
 	seq_printf(m, " size %zd:%zd offset %lx\n",
 		   buffer->data_size, buffer->offsets_size,
-		   proc->alloc.vm_start - buffer->user_data);
+		   buffer->user_data - proc->alloc.vm_start);
 }
 
 static void print_binder_work_ilocked(struct seq_file *m,
-- 
2.49.0.395.g12beb8f557-goog


