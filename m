Return-Path: <linux-kernel+bounces-428110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9CC9E0A56
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 18:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CFB4282148
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB201DACB8;
	Mon,  2 Dec 2024 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JJaKMh7J"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82227E0E8
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161547; cv=none; b=PySRSxaR3l+Xo16OX5E4iFBAlNZ7XfZaHrjXHjvbmeG/pr/sHf3zoDXfkVxdiHtFYxccLQ+HZHar/3CSTtnYfZzB44RQClhDrj3C8cAGG1Fmi3JDt2k+1KrfB9B+jQ7QGMYUD6OvYG4cuy7EQR4RJDw48/JU7EqO8LYeWbzknNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161547; c=relaxed/simple;
	bh=z+cHfkEdofAUSDaqIVg0Z1cSdifjauaRlbhZ1WorbtQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cWm9tsqB+eAna/nwl8fKgXe5eoZ3/hEX143sHLbh+j2ZxWu3wUi9f2VRlcOuhTyo2QM5DvS+GE+RINfGZARHQG1fyaUaH+r7dha0uKc1o8LQ3KATZNtNHtUqBtWLroz6VYy8/wItsNcCwXTvBL823driUDxD8yJfEB05+WQT6wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JJaKMh7J; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1733161541;
	bh=z+cHfkEdofAUSDaqIVg0Z1cSdifjauaRlbhZ1WorbtQ=;
	h=From:Date:Subject:To:Cc:From;
	b=JJaKMh7Jonw1++41i7HOnnKyggY2hqY9DPdRG6JTXFQg95+BzTWLVnJRfTpAyD4bV
	 aV6cmgk3thspkV9KFGevc0RqZ/TFgBKi3fKrZg/knEAEyTtsKyFkRLaMwQepTVvSNP
	 XQKqXd//s5Dhb4Ic+N6uZkGq4l7q01ERm6YrGLBI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 02 Dec 2024 18:45:41 +0100
Subject: [PATCH] locking/mutex: Mark devm_mutex_init() as __must_check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241202-must_check-devm_mutex_init-v1-1-e60eb97b8c72@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAETyTWcC/x3MQQqDMBAF0KvIrA0YrSC9SpEQJ986lERJogji3
 Rtcvs27KCEKEr2riyIOSbKGAl1XxIsNXyhxxdQ27Us3nVZ+T9nwAv4ph8Mbv2ecRoJkxZb7oZu
 cHWZQCbaIWc4n/4z3/QeFX32kbAAAAA==
X-Change-ID: 20241031-must_check-devm_mutex_init-cac583bda8fe
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
 Boqun Feng <boqun.feng@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733161541; l=2236;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=z+cHfkEdofAUSDaqIVg0Z1cSdifjauaRlbhZ1WorbtQ=;
 b=o/Dglmg09ww/hRm5ldvVor+HHazQsl/5h+NsLj1zjXAURIWENoCtf4jhZtKMVZg5iCqZLF97E
 vq55iQmoxr+BMD7R2NG8/bPfW0NFNB7deNNTWaZXj5TDhQMJL0LLmqG
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Even if it's not critical, the avoidance of checking the error code
from devm_mutex_init() call today diminishes the point of using devm
variant of it. Tomorrow it may even leak something. Enforce all callers
checking the return value through the compiler.

As devm_mutex_init() itself is a macro which can not be annotated,
annotate __devm_mutex_init() instead.
Unfortunately __must_check/warn_unused_result don't propagate through
statement expression. To work around this move the statement expression
into the argument list of the call to __devm_mutex_init() so
devm_mutex_init() directly expands to __devm_mutex_init().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/mutex.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 2bf91b57591b49e4668752e773419ae945f124da..3ab77d0d85bd54a700e99694fd4bcf1d310175bd 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -126,11 +126,12 @@ do {							\
 
 #ifdef CONFIG_DEBUG_MUTEXES
 
-int __devm_mutex_init(struct device *dev, struct mutex *lock);
+int __must_check __devm_mutex_init(struct device *dev, struct mutex *lock);
 
 #else
 
-static inline int __devm_mutex_init(struct device *dev, struct mutex *lock)
+static inline int __must_check __devm_mutex_init(struct device *dev,
+						 struct mutex *lock)
 {
 	/*
 	 * When CONFIG_DEBUG_MUTEXES is off mutex_destroy() is just a nop so
@@ -141,13 +142,12 @@ static inline int __devm_mutex_init(struct device *dev, struct mutex *lock)
 
 #endif
 
-#define devm_mutex_init(dev, mutex)			\
-({							\
-	typeof(mutex) mutex_ = (mutex);			\
-							\
-	mutex_init(mutex_);				\
-	__devm_mutex_init(dev, mutex_);			\
-})
+#define devm_mutex_init(dev, mutex) __devm_mutex_init(dev, ({	\
+	typeof(mutex) mutex_ = (mutex);				\
+								\
+	mutex_init(mutex_);					\
+	mutex_;							\
+}))
 
 /*
  * See kernel/locking/mutex.c for detailed documentation of these APIs.

---
base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
change-id: 20241031-must_check-devm_mutex_init-cac583bda8fe

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


