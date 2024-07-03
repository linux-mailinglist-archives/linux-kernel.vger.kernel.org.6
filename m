Return-Path: <linux-kernel+bounces-239122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D809C9256A8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 11:25:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E0DC1F2734B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 09:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ACDA13CA95;
	Wed,  3 Jul 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ad7AD44W"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8228136647
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 09:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719998698; cv=none; b=gLRJp1e3MYEw4sLbWCXAQoDF+2QVlGQBcSkf3hKhmPgyKj4VHPbGAvmHVn6w6fakoaUACtgMZQyPqNtbT11s1m1Rbo9z0og+xfyg9t4wKDBWMYk+G5/D9HwYi4Q/FNAh8pyuBSVbXraNDUhi6lU1jUkwVJ/2Za3NP50bsGoXpBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719998698; c=relaxed/simple;
	bh=w70dg3NU09xPvW75Hf/Cqc27EsWfJxPMRi3a6IZC05w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bVvAK/4Jg1XdFpHI/W+ALHAJOQ0R9Ne7KS8Stetect4eLX3czLPlljUpHwb8vZKYBfkYa1RxZkNmQeOZBuLwGr2VI0yEDBHrVxJviFIdyYuSA1iW9EcW2jKE4RuXjzdHPOKj32MWi6hC08fbJkzFyj9ZtZFeVOkdQoQP2xI3Ox4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ad7AD44W; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f4c7b022f8so37075965ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 02:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719998696; x=1720603496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rw7V34xfGdU6YxdyJCAWuvLClxn5aRb+ZbDqiKrc59U=;
        b=ad7AD44WGGEUhV6PF3NyBSFmN9SnxuFvqgesIMU2VKqCX7vZlqURO14pWA8fVe4Koz
         vKqSAeVOm7smHxmLKe84fvi8kuitv0L9JlzV6taEsGQTvzPEqQQrbHo4HiezkQmf6Fjl
         IMp3k2DBtLC5mNXkaRQxaL3EMJ7Sl4KOaTfPq7qbSjg2QNRS+paqslLc4tIb2SIT3kUf
         Mk3VhmwuOhJ29IP3+yAJKVN/SdSt2ZA7vX9shXQtK2ndUsvFMJm8iql0rB+KHqiW0QYS
         +5rubs0Ex/wnqx49BQmplXo4f/ephgub88Ao8QnPa4l6t+DWUN3/bzQtKLdSXRgrY1P3
         8I2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719998696; x=1720603496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rw7V34xfGdU6YxdyJCAWuvLClxn5aRb+ZbDqiKrc59U=;
        b=OhxC2R8KgcuPlPKiGeBWjsH8U+rZMXQwm+0WhXEYy1EaGkxdArAGNbbrsqHFfWvmNL
         O6oNn3b4tO0zlH3kLRVnRnetVtbR96vTcJJONEoU/fc4WisL5hC+93jGgq86sN9sfUHZ
         Vr/TFCGJz8BDoKQH24wAboxb1WOPDpsKqPekZXYqDboF3ODUBPr9l7/t5wOoq8UgimDk
         8TftnPlDzCGLudGu+ccOY3cfCCBKMA8vzwjv/2y2QgIFIT5nE4IkVaLEZB4WmYrj6asZ
         xizsHzqW9emPjRj7Q4w4ChbITgGcJqA9TIF3hus0DCDMg2dQduGGSlak2/hRf/W5XHH7
         D19w==
X-Gm-Message-State: AOJu0Yz6L0wanq91BmT7a4qy6q6gr/j3NP+JcjhTISqrS6TN9KUhST2u
	R1OkJf9jfS6fCoGmaz/+Mb/1wf+bTcGqZiDDxjOPwziYNlUB7UghfJet1A==
X-Google-Smtp-Source: AGHT+IH6ZmDF85ZL5dDEhTe1omW6D9BQC8Bqti5DL98SIfknyUeFi0jVFbYtpVLV0w45nLSTG9wEow==
X-Received: by 2002:a17:902:e80f:b0:1f6:5013:7842 with SMTP id d9443c01a7336-1fadbc8af6bmr120495215ad.27.1719998695517;
        Wed, 03 Jul 2024 02:24:55 -0700 (PDT)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15966b1sm98640835ad.262.2024.07.03.02.24.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2024 02:24:55 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] workqueue: Always queue work items to the newest PWQ for order workqueues
Date: Wed,  3 Jul 2024 17:27:41 +0800
Message-Id: <20240703092741.22997-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

To ensure non-reentrancy, __queue_work() attempts to enqueue a work
item to the pool of the currently executing worker. This is not only
unnecessary for an ordered workqueue, where order inherently suggests
non-reentrancy, but it could also disrupt the sequence if the item is
not enqueued on the newest PWQ.

Just queue it to the newest PWQ and let order management guarantees
non-reentrancy.

Fixes: 4c065dbce1e8("workqueue: Enable unbound cpumask update on ordered workqueues")
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c910f3c28664..d4fecd23ea44 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2271,9 +2271,13 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	 * If @work was previously on a different pool, it might still be
 	 * running there, in which case the work needs to be queued on that
 	 * pool to guarantee non-reentrancy.
+	 *
+	 * For ordered workqueue, work items must be queued on the newest pwq
+	 * for accurate order management.  Guaranteed order also guarantees
+	 * non-reentrancy.  See the comments above unplug_oldest_pwq().
 	 */
 	last_pool = get_work_pool(work);
-	if (last_pool && last_pool != pool) {
+	if (last_pool && last_pool != pool && !(wq->flags & __WQ_ORDERED)) {
 		struct worker *worker;
 
 		raw_spin_lock(&last_pool->lock);
-- 
2.19.1.6.gb485710b


