Return-Path: <linux-kernel+bounces-543671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A722A4D865
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E626188AA3C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154652046AC;
	Tue,  4 Mar 2025 09:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xg6WVpOx"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FDF2045BA
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080369; cv=none; b=gXhU+vtIw7GSGBCuiEiMlSJVOTtvEi9P0t6umebS9m5qZNvSozZFmYAnS8cOq80kpZgp2S82UHCBtHaskTWpUOMrOeuvkFP0x4eG4x5+fwkx+mGok0GXAajJsqCA1yQkxeLUPJv+EwP8WQ2fpbBdJASBQ+9fs6Y8YdON6J2zNro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080369; c=relaxed/simple;
	bh=X1ktC5ZjhhR5WSX79RqJwEmztNg59gjqNnHaZ1eRNbI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZMamePamrp8Ko+cs7pDxQ3QLHHT1P1dv5Fgl1yiMvZkIWXka/88CUGV1O15ugZSxQwWGWXfZVAfDKmqRiaAWdDqoxRS97qnCgeK5M4DhioCaHSTsU54KfktfARX1J3P9ryks9gPIbJYVS2KOkAgLjDBGD9CB0e3JtSGaCc8PQ98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xg6WVpOx; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5da15447991so6390803a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741080366; x=1741685166; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ljSfvhYh8x6xwHsInA1Gu+wF89bLF/D0O2qs3l3oGhs=;
        b=Xg6WVpOxl4Uw1y9DqvyTg/3197RCryGmiSeYMqKUZTtF6ekER1WDtt4QMiXC1TPcg6
         HnOBzDtLMIUNk+pLQAEWYm23m6PNy2Axi/a9mFpCp7arNL23sz7yugjjTL0VVBPQmfB3
         rLoYFizmAR8YildAdPPxqlIMei1XwrW9W//4YPDHVd6dlGFtPOIPYs0SyfHSDWoVscUQ
         Q3zeOgQlAbM9V4q7fahK+x+vvd7CKuq2ESx/uiBT7Lr3XUn3mpCh3w4zYvjgh8D83Kme
         I+feMdM/bDcLp18cuqHklttRGdhpsf3ipe5zBWljPKEX9UY/59IQ05SWZKiEKS+iGxN/
         jq/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080366; x=1741685166;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljSfvhYh8x6xwHsInA1Gu+wF89bLF/D0O2qs3l3oGhs=;
        b=pB+6EqN5zcGoAe3bGIIfk1xwm3OfjfR9mpkVzBaMIK3xftWOchZJxnwlF+jsdl9vt0
         KKuBc3rO40EWHWWX70P/IBd6N1yrx+9od9H3CRBGr82G+WvFeXF4q0LxA4RlcmXiXAsi
         a/nGoSOQKWgVZko/WPAGRp5qJLBuvAHJttFOLERTyQY3+F9cjyw7BF6EeteP+8aknGxU
         zl1hob2KMVpmHPPgavqLLllAIoPY7eCyiyn89KecSH/RjFmW8846P+zs2Bfd2K3KaXaf
         Lt/i0YQrLh7jkqX6NYgHKaTPiDUoItGtiVOyFgGTuG/E5cJ20S9JsSQVlSWnvLs+XeKo
         SR+A==
X-Forwarded-Encrypted: i=1; AJvYcCUMlgHjNikg8wI7tZe1fOIEZZZuNul2zqDrKvmfrmq1C/PjLbyWyAOeD7eI1DruDSIXUpqWTfQ1TQmxiwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF8XgbXR+w6tZjjaRVFcjzfZXJh95EgaUWre4CAEvnfKDfor71
	hyETtopp2KgxWzxZiIuFfwR0atSrefb8eHu0J5NeH0FI+OveN33u4EDt979aCP5rttvCGPoWcw=
	=
X-Google-Smtp-Source: AGHT+IFrMBW+OhCnT9icBam/s/vk6OKWe4X42OWK7ynSC2VTQQKw5GLkAoEuFIfZ1S6J7yhnX5gf47Hang==
X-Received: from edbij24.prod.google.com ([2002:a05:6402:1598:b0:5de:504d:836a])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:234e:b0:5dc:80ba:dda1
 with SMTP id 4fb4d7f45d1cf-5e4d6ad7afcmr43438170a12.9.1741080366105; Tue, 04
 Mar 2025 01:26:06 -0800 (PST)
Date: Tue,  4 Mar 2025 10:21:20 +0100
In-Reply-To: <20250304092417.2873893-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304092417.2873893-1-elver@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250304092417.2873893-22-elver@google.com>
Subject: [PATCH v2 21/34] debugfs: Make debugfs_cancellation a capability struct
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Bill Wendling <morbo@google.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ingo Molnar <mingo@kernel.org>, 
	Jann Horn <jannh@google.com>, Jiri Slaby <jirislaby@kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, rcu@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When compiling include/linux/debugfs.h with CAPABILITY_ANALYSIS enabled,
we can see this error:

./include/linux/debugfs.h:239:17: error: use of undeclared identifier 'cancellation'
  239 | void __acquires(cancellation)

Move the __acquires(..) attribute after the declaration, so that the
compiler can see the cancellation function argument, as well as making
struct debugfs_cancellation a real capability to benefit from Clang's
capability analysis.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/debugfs.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index fa2568b4380d..c6a429381887 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -240,18 +240,16 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
  * @cancel: callback to call
  * @cancel_data: extra data for the callback to call
  */
-struct debugfs_cancellation {
+struct_with_capability(debugfs_cancellation) {
 	struct list_head list;
 	void (*cancel)(struct dentry *, void *);
 	void *cancel_data;
 };
 
-void __acquires(cancellation)
-debugfs_enter_cancellation(struct file *file,
-			   struct debugfs_cancellation *cancellation);
-void __releases(cancellation)
-debugfs_leave_cancellation(struct file *file,
-			   struct debugfs_cancellation *cancellation);
+void debugfs_enter_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation) __acquires(cancellation);
+void debugfs_leave_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation) __releases(cancellation);
 
 #else
 
-- 
2.48.1.711.g2feabab25a-goog


