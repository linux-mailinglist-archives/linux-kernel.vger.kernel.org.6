Return-Path: <linux-kernel+bounces-237229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD6B91EDB8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FDC31F23B92
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F4D4F1F8;
	Tue,  2 Jul 2024 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0m4AxPi"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9AB49633
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719893549; cv=none; b=XMc+GnFjPCKfIEA4jKJ3xYgVkoEGVUmDI7ZB2odb2hkfyFBT+QyPNHPIrC1QkYya4mFbAprrc9KBSTjuXNpnP3/1OEJqqMtUVPQSd/XH+Njbll7BUpBrSowC5b405aFqFC97T7bs/de4Vf02gS/gMEieQxcDLnf7NGhZWPuXfno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719893549; c=relaxed/simple;
	bh=2JOeR7fENn6vQvRJ0I6IcJoBl0wuu+rGXpaa+IZPSs8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D0fHt2mYw4zFPkzyibTBsZ1JjXEZJCmwbljkX+35XS7n2+p1REIGKr/qNsC1Tt1ZzjdQQY3FrwKYGdXGr/8FxNMrI7VshgEYzlNjvC48vu/OMmaWb9K11xRZKlfWf+5x2PNz4EpeUjrBe6BEZrfWWXcagi3yUTTaN29IBOJF3+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0m4AxPi; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-25da8a19acaso1711331fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 21:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719893546; x=1720498346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MHleub4mTrFQ67+iGWbwKzDxzdJV1cPZuDZmtYlZDR0=;
        b=K0m4AxPifYojef7iYAh5Gi+IXc2nO9871+ouHJ1JWeNIQxP6X1OEXcFn+r1MM9A9vn
         EW6qzac5yd/T43kSG+92X5qqpmZ/f9fF4Eew5FinSONI13r0C0EcvXGeEkfzkbbhLMJc
         3fQ0h3ls4VEwThX8Buasfdal2E79aSLPxkXC1ttHx9POz2SwKiQb0oNvdLbfPLkcg0nD
         keTGnrxHn5MmkXLYts6E4r818V00b4iRLMSAU5HnN4CuE++Hhgz/S11lK/QdhOaLensh
         HPbj9id5kcLboK/TSr7+JaXGDJbglR7uNBp3aheBaIYXom8D+yuab1ghKBX6LH2SqkWF
         TefQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719893546; x=1720498346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MHleub4mTrFQ67+iGWbwKzDxzdJV1cPZuDZmtYlZDR0=;
        b=HqSZsRaGc3WkJ3TGMhrCULga4iHrHraEO4XCfp+JEE+SCVE4++Hix2DdxRJOWa0vjm
         b9eMaQMUkpKFFC1dSl9dkf4/uFzxwac+v3vv/6XuRoQqax6QBCcI6CpFcZfWyyweZMDc
         mGnH5WeOtTL1vjqkeRkgYr3SBvmbzemLDE4w3Qk2D5/DdBKuCZsBdKpE+MhdmYjQDdPv
         z9ktGNBWgMKLYiVh9kpcq2fWGQ4AzKVQbdK64jaT7eEELgwCDdfrpek+6E8tMsGf9s3y
         XWsMTJrKYh4yjQHF1I0SgHeaCDEvg82bgfTc5Ybg24wtAAOC3kDmhoNPV67XMNw48S/a
         I+5w==
X-Gm-Message-State: AOJu0Yz/qUtRD8fjY8JoPwbaoAxz8kdDYXP50J7pdMvuiN8G2QNi4c1W
	w7JbbPbdWwRV7vCKlAIelmi62h9/jodavmYYk2Veu5pDwwRaEDMszR+CDw==
X-Google-Smtp-Source: AGHT+IHxoa0cbbZvmF/M6jub10PdERSR4mAqHILNcKZX+NqO4q2QM0Cy6F69HJl9DSAheOiwi4QuJw==
X-Received: by 2002:a05:6870:d1c8:b0:259:8805:b634 with SMTP id 586e51a60fabf-25db36cd02amr6985728fac.49.1719893546109;
        Mon, 01 Jul 2024 21:12:26 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708045a69a6sm7377734b3a.165.2024.07.01.21.12.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2024 21:12:25 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 1/2] workqueue: Update cpumasks after only applying it successfully
Date: Tue,  2 Jul 2024 12:14:55 +0800
Message-Id: <20240702041456.629328-2-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240702041456.629328-1-jiangshanlai@gmail.com>
References: <20240702041456.629328-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

Make workqueue_unbound_exclude_cpumask() and workqueue_set_unbound_cpumask()
only update wq_isolated_cpumask and wq_requested_unbound_cpumask when
workqueue_apply_unbound_cpumask() returns successfully.

Fixes: fe28f631fa94("workqueue: Add workqueue_unbound_exclude_cpumask() to exclude CPUs from wq_unbound_cpumask")
Cc: Waiman Long <longman@redhat.com>
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index dc9acf8ecd0c..a3f9ff4fe657 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6853,9 +6853,6 @@ int workqueue_unbound_exclude_cpumask(cpumask_var_t exclude_cpumask)
 	lockdep_assert_cpus_held();
 	mutex_lock(&wq_pool_mutex);
 
-	/* Save the current isolated cpumask & export it via sysfs */
-	cpumask_copy(wq_isolated_cpumask, exclude_cpumask);
-
 	/*
 	 * If the operation fails, it will fall back to
 	 * wq_requested_unbound_cpumask which is initially set to
@@ -6867,6 +6864,10 @@ int workqueue_unbound_exclude_cpumask(cpumask_var_t exclude_cpumask)
 	if (!cpumask_equal(cpumask, wq_unbound_cpumask))
 		ret = workqueue_apply_unbound_cpumask(cpumask);
 
+	/* Save the current isolated cpumask & export it via sysfs */
+	if (!ret)
+		cpumask_copy(wq_isolated_cpumask, exclude_cpumask);
+
 	mutex_unlock(&wq_pool_mutex);
 	free_cpumask_var(cpumask);
 	return ret;
@@ -7202,7 +7203,6 @@ static int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 	cpumask_and(cpumask, cpumask, cpu_possible_mask);
 	if (!cpumask_empty(cpumask)) {
 		apply_wqattrs_lock();
-		cpumask_copy(wq_requested_unbound_cpumask, cpumask);
 		if (cpumask_equal(cpumask, wq_unbound_cpumask)) {
 			ret = 0;
 			goto out_unlock;
@@ -7211,6 +7211,8 @@ static int workqueue_set_unbound_cpumask(cpumask_var_t cpumask)
 		ret = workqueue_apply_unbound_cpumask(cpumask);
 
 out_unlock:
+		if (!ret)
+			cpumask_copy(wq_requested_unbound_cpumask, cpumask);
 		apply_wqattrs_unlock();
 	}
 
-- 
2.19.1.6.gb485710b


