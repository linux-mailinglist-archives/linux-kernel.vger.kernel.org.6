Return-Path: <linux-kernel+bounces-236003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 652CD91DC3E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B3CB2431A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110521494B9;
	Mon,  1 Jul 2024 10:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n0FfDH+q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jXcjzKep"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6B13D61A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 10:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829146; cv=none; b=Jzhrcuinj8amj5v3bFtc6mds73mBcTtqn8HP+RFjNygHjt0mxamdCbRN2vQA4vHsesaCzDNQYqTqJZeuJyQ7YuKPXg1hMrGBJy4p/YyhKzfCVoH2uL0XerstktBWcLwatBDlSS0lvzTM9IYel8Z1AsuGGjVfCkRvHqgvsuuL0f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829146; c=relaxed/simple;
	bh=benwhNThWSYC3tZONYtpR+lOK7wXsAZRQexO5Qwp3pM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FiB6Cy6UhAZC2g5HUGoknESFKFDsuURuYwidJOq0tBjsWCaQYRfOqxBO1vfO5QEKYGsDMCY2azOOGs/h21W4l7S8DTYup07QS9I/dLmzzW83K+EEtx3UFFeWX1QSHQKd5vB7+cVCfHpnNTzCoB67AdCO1AN/rrN++68dDvYJlRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n0FfDH+q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jXcjzKep; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719829137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+aUY3MI7mRJT+MnfqFQU16kFIx+aJUbq9+kmQSfCc/Q=;
	b=n0FfDH+qnXmOGLBz9flxw9KTp6KZuUYB6lRlLus+iPkhSYTC+hozmuXsLcA5hz5tj4gflV
	eZWr5jU7DnJ8p1MBKmRq5/jYbh+uVXKekbBZqCfCFtLy0jOQ0DnTgXsDpS7jZPs+OiZ3Am
	3/sZMz5nrHM5ys9FgwlxZjyRlm40JnPinoBbTgVE/3MedsYpFBQ1jWZcEreS9qGnFUxh66
	7PuS7iyXUQ0/noYGnTfQk9Az3ZxNXIVyCQ1CGl0AL3Ic3FqYcUSgW0d1S6C3dXto+PjOe9
	EBv8+bTfalVTfvSeV0vIANmvXJB3fJ+mJOQpKdHSnTY/Wp4/+h/v5H5KtjJNVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719829137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+aUY3MI7mRJT+MnfqFQU16kFIx+aJUbq9+kmQSfCc/Q=;
	b=jXcjzKepguMzvb1fuMqxggg4uBwrm1Al6qo120abjShX/WYR0kvMleBJuKwfXp0y77/gkZ
	YPo+rY0v70u8fRDw==
Date: Mon, 01 Jul 2024 12:18:44 +0200
Subject: [PATCH v3 8/8] timers/migration: Fix grammar in comment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-tmigr-fixes-v3-8-25cd5de318fb@linutronix.de>
References: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
In-Reply-To: <20240701-tmigr-fixes-v3-0-25cd5de318fb@linutronix.de>
To: Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
---
 kernel/time/timer_migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index bbc849539dd2..bc40cac6b58d 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1368,7 +1368,7 @@ u64 tmigr_cpu_deactivate(u64 nextexp)
  *			  the only one in the level 0 group; and if it is the
  *			  only one in level 0 group, but there are more than a
  *			  single group active on the way to top level)
- * * nextevt		- when CPU is offline and has to handle timer on his own
+ * * nextevt		- when CPU is offline and has to handle timer on its own
  *			  or when on the way to top in every group only a single
  *			  child is active but @nextevt is before the lowest
  *			  next_expiry encountered while walking up to top level.

-- 
2.39.2


