Return-Path: <linux-kernel+bounces-238763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 274D1924FAD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC45328ED54
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69EA482C3;
	Wed,  3 Jul 2024 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btFD0uGp"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E464778E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977788; cv=none; b=r2sot/X6Plx0ZX5m8aaenNvpz4ASbNDU2xbh5tDKRQB47U6SzPQk4MgZKXFbf+83SecmFkqPUoMA6FPdDPUqMXsfMZCGFeAd2i8HV9k2PNFcu4Zq+Dj9d3Ov4cBsDinVyy/x4+NlYgTOY6DC0Z8qwULnQHzJbehZ8f8gpvU7nlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977788; c=relaxed/simple;
	bh=0XFSVIlzk9KeflJQ/V8WREO6DICk2IQJGTOsOZswXeo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ol286qlPZXrogIQ7+yYWtI3tDPyZGjBW+yX0qTQUGFtsjvWNoY8kzgXGnoBxTLQvTZXfCQ8adUMotGxti9PCak3HR19UdBRZa8VdQ7yiY4b37GURb0E9V+5js6LKu6d5QkBVir94LE9ZY6EAde8GsDL9qfi69qu8DEsLa6qeRXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btFD0uGp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fb0d88fd25so1501415ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 20:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719977786; x=1720582586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xK30j/brdYQ+0YiuZHRD9U+3lQnGwcSFkyDSPgUQ3s=;
        b=btFD0uGp12pcHsZ4hiJThEcHWbtu/p0wB6Ak5dlhfK2ErFMSP+RUuC7j1zINEKC8u/
         P/dovoE3+hTzR1MsppKo7Xce7ze3K91XsYdXHRAytEFqXXGd/JHPAZaCJTUjxRvgnOqX
         1kJ7Vs7gcRJ4KUKUVPQK0JaQtex0R7c5N1GSGuEhyb6AjWfY4d+sTMwPwi6Zqwyg1tDa
         Tn5mXP0cM+mLPiE0UHNR/a3biHZtKN6nwhuq84dRkOF3KS30jk8J+wjDt3YW9zo3GaOK
         p2riXOUau69PGiAjOZRQ89tySCRXMmf2Ig9jITHz9u2OOkfjUeQiI8wmPXrqa9SX+R9y
         cKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719977786; x=1720582586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xK30j/brdYQ+0YiuZHRD9U+3lQnGwcSFkyDSPgUQ3s=;
        b=jVP6PtdGxEinNjpBB2Qs9LjqlpyFrtdkvtIOWgweG4ukpYYLiK2myF/Q+7pf1nSnNT
         oJJ/mLGKpSe4U5wwxILExbuYvfC+9AGWoLzwsge18AT3EviLZ9YsbfbW1IdZB5X6ZtmG
         L5xWK8/ik0KTZAJob2f7go9+wzLtf33R9kStfzAgdkfFc/g7iz737nDmNXmnnubufUIE
         +LSJXxdYegEHzOg474CHgMB9D6aKP7hUxQSYyano0j6MlzlnCa+dgSN/X3r2TISR4aM8
         JTBScqQHunfeO02t/nfz4aSivR4X1Jr6gpDypJnq9sK0SnYWLIGFrXk98SA34Ys8mogR
         +b6A==
X-Gm-Message-State: AOJu0Yyhs5jY5jD+/CdrINOqj65Aix0Z3MDzOYJA2cZRX4YkAeKSYMIJ
	A4QJueE4GNAukQz1O/ANcyFB6JvIUhTHnZck69vUlW/Qvew9ppnkZoUL/Q==
X-Google-Smtp-Source: AGHT+IHrB4cPTnryLg4bjh1sDUAI8jWYCt17Cc918NeYncRR3Sw1Ny1uK5+mLk7X+FLJiUTdpy1gFg==
X-Received: by 2002:a17:902:d04b:b0:1f9:e2c0:d962 with SMTP id d9443c01a7336-1fb1a124fa7mr4906345ad.31.1719977785802;
        Tue, 02 Jul 2024 20:36:25 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10d1b61sm92222165ad.57.2024.07.02.20.36.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2024 20:36:25 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 5/6] workqueue: Move kthread_flush_worker() out of alloc_and_link_pwqs()
Date: Wed,  3 Jul 2024 11:38:54 +0800
Message-Id: <20240703033855.3373-6-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240703033855.3373-1-jiangshanlai@gmail.com>
References: <20240703033855.3373-1-jiangshanlai@gmail.com>
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
 kernel/workqueue.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 810ea55c0ac9..3203c67ec4cb 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5472,12 +5472,6 @@ static int alloc_and_link_pwqs(struct workqueue_struct *wq)
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
@@ -5731,6 +5725,14 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	return wq;
 
 err_free_rescuer:
+	/*
+	 * Failed alloc_and_link_pwqs() may leave pending pwq->release_work,
+	 * flushing the pwq_release_worker ensures that the pwq_release_workfn()
+	 * completes before calling kfree(wq).
+	 */
+	if (wq->flags & WQ_UNBOUND)
+		kthread_flush_worker(pwq_release_worker);
+
 	destroy_rescuer(wq);
 err_free_node_nr_active:
 	if (wq->flags & WQ_UNBOUND)
-- 
2.19.1.6.gb485710b


