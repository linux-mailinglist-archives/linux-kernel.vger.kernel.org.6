Return-Path: <linux-kernel+bounces-240477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F75F926E2C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29087282B18
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE474200A3;
	Thu,  4 Jul 2024 03:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeDZqT5w"
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A0376E1
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720064796; cv=none; b=rkyGaoOtUETtonCcUcpfgXHAdrueF1L2qZ4m5+dGx2aRxzdC1RYcpJc4vP/Ge5KrVrW+27+dkygehFPYAUE3B2fYW8MI0bs7hrkMs/YnppvRYfK4PEjkkBKbjegMjHiYTP4+aKyr3E2YNu96BPpzhrDRAJxEnagU9sb1pzMyPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720064796; c=relaxed/simple;
	bh=vkihHeUPVc2ZjFVGWuUy6dhg/iIN8IgnkEmqLqIu4r4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SnwfQqApKDlejp+b1U1/wGBaxXuN3fIMDA8I9JW/cmpHI/cV+FSVMiuZfu6YRHw6uojNnU4nM7Jls6tyYevDnu59uuu8bXEJa/jBalVVM6/OvG31oWBvhWFa/lMpXA3xj2R0kxG7ePyCwD9x5kA+GzT8T+iNNl5NMS2yDBVwOZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZeDZqT5w; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3815eaa136eso984715ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 20:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720064793; x=1720669593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCyTuMbFoDwGev6RpdFwFdS1vydkz87hmYVqtPgiqyo=;
        b=ZeDZqT5wxSh11ypK/xk4jLh2L+kQ1qCkd46Ze99UEPRTneLOyVcuXL248uHeQVNshb
         EBYwHfFSA8ak5WZgCbMtcc0wgeYfoDNyr8hB1tjnYyFfzco8Ckeukznhj5x1rdmXWSZU
         HO8ED5SzRfqNEmRRqV59xU1Qax/yYyiJfK1ucHlP6TQ8QG4SGfAt7qc8vMY1OhCOEkgm
         gXcDlSDoXo+rplxevHbQ02gs3kTqtoEzNOweeDXK00bYT2KNQE2BtxGEYq0XRtuDd7Yy
         Q+gGqCRvzaHu8YYmw3Uh36pZEBgstfkw4zWJ+mXM1vFmNqLTUyhnTiL2daTZF1O6ry0W
         ffzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720064793; x=1720669593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kCyTuMbFoDwGev6RpdFwFdS1vydkz87hmYVqtPgiqyo=;
        b=c+afdkhf3YQV4YDPuebrf+BsJiOmxPRi1fhA9pULxHRCfEuClIjI3bKR4zeUO8nvqC
         QnGTMoMsq7rRYqIBTL8zzH+RZZa301GOEC058xzzYUjvrZEgwh0IoYMgK6R3j0fQRGz5
         WglyrdK/1TJ/BWXbLHW7bNDm76Vi+OlUTx3UM8o6DvGaY+x30Frh8sXyjBEdytFK6RQ+
         qEpaPwW1ZfXuOMxQt31R3AarMbfH1SlZHCUDE5BqxZCGWjgHIV3r/jZBiet7VjwiL7JW
         XXD9uYe/QGn4yUEMIB4RK999F7A+jHh6qlHLHzUqN5MWsr4YrwiE9kk7yHqqyg6kpxJC
         aSEg==
X-Gm-Message-State: AOJu0YyBFHE7QdhLJlPdnIudZXktEfbGyhCl60o5HpqSpkdppm0PRJ13
	UbwGlY1sCWgwOwRxIwa/wSNtk2yeW1NX2ptvp7Z2Z5zsfxKYqMHsD+SJqw==
X-Google-Smtp-Source: AGHT+IHW8LWS/4C0uRRrfwyvzarWiQR6rYooB1Sa1/HYFmGrYkinBUPiKlgeARfACMOy5VYG8LxRdg==
X-Received: by 2002:a05:6e02:1846:b0:383:206a:1b31 with SMTP id e9e14a558f8ab-3839b099794mr6425985ab.24.1720064793264;
        Wed, 03 Jul 2024 20:46:33 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6c7f761fsm8741479a12.62.2024.07.03.20.46.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jul 2024 20:46:32 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH V2 1/5] workqueue: Register sysfs after the whole creation of the new wq
Date: Thu,  4 Jul 2024 11:49:10 +0800
Message-Id: <20240704034915.2164-2-jiangshanlai@gmail.com>
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

workqueue creation includes adding it to the workqueue list.

Prepare for moving the whole workqueue initializing procedure into
wq_pool_mutex and cpu hotplug locks.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a38a67ac4e80..904a1a6808b7 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5693,9 +5693,6 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 	if (wq_online && init_rescuer(wq) < 0)
 		goto err_destroy;
 
-	if ((wq->flags & WQ_SYSFS) && workqueue_sysfs_register(wq))
-		goto err_destroy;
-
 	/*
 	 * wq_pool_mutex protects global freeze state and workqueues list.
 	 * Grab it, adjust max_active and add the new @wq to workqueues
@@ -5711,6 +5708,9 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
 
 	mutex_unlock(&wq_pool_mutex);
 
+	if ((wq->flags & WQ_SYSFS) && workqueue_sysfs_register(wq))
+		goto err_destroy;
+
 	return wq;
 
 err_free_node_nr_active:
-- 
2.19.1.6.gb485710b


