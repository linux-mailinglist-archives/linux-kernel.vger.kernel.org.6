Return-Path: <linux-kernel+bounces-240479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B88926E2E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D803E1C21551
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BFA7171A7;
	Thu,  4 Jul 2024 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q9UkG8j6"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA2B3F9CC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720064804; cv=none; b=SwQ5DTQOYfmmnSmo4MVu4Uf/0Jo9AR5B5JW50XfenybrUI3WOsbenUGXYUwg4OMLHO8QTu4mtBl7YgnyPHCeCVy2wpGkICYhDTHAFjPy7dFoTookqVPcteLuz/AB6vXDNqqVi05mu8BNK7Ljd4ldNtio9RjD720Ck6e1c+vpVjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720064804; c=relaxed/simple;
	bh=2hz8w6CnLDWNAJ0UImaMdvulcV4dgoKmxYQT2AaAy0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZrCzg+fjTGnmf9YTzyrvXtnI4pFPB9rycO3TrNmtXex3Gvp9uqcOCOMeGta6MgVQyXG1zLxFROtuKYed+jkj+0OCVLOQz9H94xktxAr5jNMKiqXwIuziECABC8vHPuwpVkYiGghCunscV0vp0QS1Tdjo3xGjUwNEqIDMfOqZz+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q9UkG8j6; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3c9cc66c649so103230b6e.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 20:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720064802; x=1720669602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nL/uAUjz0QFR5irOqrlwan8U0RfC4351qVASkU+SBbc=;
        b=Q9UkG8j6Xk2T5xAkU8KPV+FL2hD6lc6NXMBESR/3xNVaHMSSTMPv77cZ4fBolgp4c3
         Xd84Bfj0jhUObmZtRaqcEHJeDVZPT/MftIPajfNIm0PYwCNUCWfjFkuJs1/q5tijlitU
         QpX5JdmapgWOVa5S5/koRmGe53UneG50h4yPjiY9gIajCwyFFX1UGi/tW6wZ1QJCOFZK
         4XFdPI2X5LRKJCJz9/TOvJmwbqKUeLBE0FspK0RkCgl/POdQ31L2OFD85KKnKtgD1OsT
         wuILtFhhQrx+OahYCWVMNxKdSHhLhsLFFizx9/tTIhQrgljP6lc4KH9Lpdkv3e+h9y5a
         /QiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720064802; x=1720669602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nL/uAUjz0QFR5irOqrlwan8U0RfC4351qVASkU+SBbc=;
        b=EQQGieHbnpA+Czg5j90KM41KYFsNjvYF645hAhx0hQ0Zi//ldlrlf90e//XZ9ub/XG
         X3T29AHTwSuqHOcE5JJGY1IXMNsmKu4yPTyBgmzP2rMKPDfXXVIw4iJlhWq1CoBZlrmp
         fYTn521K7YO2J04xM63JAjvkGuYc3AmrDMYp5VtaDOc8rF+qIsXATKvJJEcRUe/N95ET
         f3FxySjirhtysKX4IIeZmJ1wwqUUCZA+ZiXEXw1HEAX8c0CPGOlmjbhDMcOGc7C9ru/F
         6u0rWQpM8L2TJ0QZu+0Eloesmj7puiuNVTMFa9j3VumKHBnMd+4/3LSxYp0dTYwnIKkx
         /7VQ==
X-Gm-Message-State: AOJu0Yx1P3PUhLEQNclijb4fy1+omtkflRZ1QGRrXYvz3WqoJIABIsX5
	3jagXk9HNZEGtPs7MSrVYdS8K3NE1dpaXn/qK16yVtaFHCj5dmWMsG9orQ==
X-Google-Smtp-Source: AGHT+IEvrcb/9RX2ZoQl9IDvDfhpTacvk2PTnkEGZleuOdxfiQ4sQcPRFFUjpZAFAj1/SFbB5DX0VA==
X-Received: by 2002:a05:6808:21a4:b0:3d2:257b:2b5e with SMTP id 5614622812f47-3d914ea9b18mr522949b6e.50.1720064801866;
        Wed, 03 Jul 2024 20:46:41 -0700 (PDT)
Received: from localhost ([47.254.32.37])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708044ac419sm11243008b3a.164.2024.07.03.20.46.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2024 20:46:41 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH V2 3/5] workqueue: Move kthread_flush_worker() out of alloc_and_link_pwqs()
Date: Thu,  4 Jul 2024 11:49:12 +0800
Message-Id: <20240704034915.2164-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240704034915.2164-1-jiangshanlai@gmail.com>
References: <20240704034915.2164-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

kthread_flush_worker() can't be called with wq_pool_mutex held.

Prepare for moving wq_pool_mutex and cpu hotplug lock out of
alloc_and_link_pwqs().

Cc: Zqiang <qiang.zhang1211@gmail.com>
Link: https://lore.kernel.org/lkml/20230920060704.24981-1-qiang.zhang1211@gmail.com/
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0c5dc7c06b81..cb496facf654 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5476,12 +5476,6 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
 	}
 	cpus_read_unlock();
 
-	/* for unbound pwq, flush the pwq_release_worker ensures that the
-	 * pwq_release_workfn() completes before calling kfree(wq).
-	 */
-	if (ret)
-		kthread_flush_worker(pwq_release_worker);
-
 	return ret;
 
 enomem:
@@ -5714,8 +5708,15 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	return wq;
 
 err_free_node_nr_active:
-	if (wq->flags & WQ_UNBOUND)
+	/*
+	 * Failed alloc_and_link_pwqs() may leave pending pwq->release_work,
+	 * flushing the pwq_release_worker ensures that the pwq_release_workfn()
+	 * completes before calling kfree(wq).
+	 */
+	if (wq->flags & WQ_UNBOUND) {
+		kthread_flush_worker(pwq_release_worker);
 		free_node_nr_active(wq->node_nr_active);
+	}
 err_unreg_lockdep:
 	wq_unregister_lockdep(wq);
 	wq_free_lockdep(wq);
-- 
2.19.1.6.gb485710b


