Return-Path: <linux-kernel+bounces-248828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D42592E27A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E43D288981
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01B3158DCC;
	Thu, 11 Jul 2024 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFORmsHk"
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCAA158DC0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686792; cv=none; b=B8OYyrH3jw8A+qWNQp9bNbs0x0OYTZcB2PD7XxpLClt6rbpTWn2dibMqb52FK1vCrcfxfzHmLZkkXhcaMe8PKFr+KfwV7J1nfVsWIhDJN0TDryP47znv8MkWCX/2TNuwc8uHO96bnVsSIwaF/4uy0f2E8Q1OTLKOIO6fRCxa8Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686792; c=relaxed/simple;
	bh=J01Udbb+7haZ7zQxS66iwS9X/ZK3619tj5qzguCB6CU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LQ3irjTLjS4B3YzromemGCCOw4AA66Evvzp+RNEev6sJns3H1UtP6GPN08xfbCdiBcHlFrE94CK/NpS/ujB7YM3N6HoivKiAo57hzgCgsrE2v+GSQFISrwa37v7tsKiVIDBcNSpHj0r4qQKZVpWkK3CvBkjbJBzmD4ZP30dUmeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFORmsHk; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d9da46ca13so323737b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720686789; x=1721291589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ISdFRDOPdwq4hY2ipcyEEN+MSmkx59XM3IiNTOk+oE=;
        b=CFORmsHkPubASyR6mu7w1LWGAiV+X9+Wq+7tSvxWNa8huXYhcLEic4JX1wUOcbskXR
         LWqgdrhJX3SmBgGOu3pzFNPT6JJDB0fe5IZqGTteP2eEJZfFQTDf7TQkxrNdJsc+jaVc
         qC1pu6xZq046SuGzQYqdnEUDeNl8RnxzkXOnYy2iI8eRgknr2zMT3vIn6GlDY2JppUDe
         NpChl2FeZwZBfZS1D3oC0DiB7U7r7R6XLmaLx9MzsuYWmsjXgTlx+yrvotRkqNOJDhaO
         4xKtWGM8NlYLh4PiYomp2MPsHGjUz7cLJPJM9JcXLEcn2ddX7TR9GnCD8mOgHilZvPvF
         FTwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720686789; x=1721291589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ISdFRDOPdwq4hY2ipcyEEN+MSmkx59XM3IiNTOk+oE=;
        b=RDxBKW8KZZk4h+4QFdDChNbmqeaTvzf0gFVdkdbuGn0PUzfuFdMeN8Eo+Rk9Pn+a46
         ld9lS5VaeN2GtJ/2x1p4cawyyf1Xwf4uN1hEAYA/q0n2+7ACA6T/qnL07VxLIzSMX6IK
         zHLAYScoz3tJ/a9I87B/GgDc8R/n9zzMzRqhPvLseO082n8ppPCI6CicdpU1S4cwM7Da
         5BeJwvUw9+6c5Bmu5xyxojb3BhfdqnBxJvnJvYDksiC5Sk/ixtBUNccVozAPT6FOibYJ
         m4EmSbPm3Ifdr8PAtjmX7IcDGaUIu8MtlqweP1vXISQGLE3xy3lRAe0GpkKvGKhdd+CW
         lhSQ==
X-Gm-Message-State: AOJu0YzP4RX3k/tISkeZN3srygk+yFHWfUOOPzhq5wP9738+oGw7+LzL
	8exQJ1knRGO8goDQJfimk5cZG9o2ZTFkSPKIrXuvBZL1DXWYxe32/7VWBg==
X-Google-Smtp-Source: AGHT+IE6IG3nkzv3Jmcc67ZoMjvU3n062KXEQrt2L6eRR5pfjfi/wjkD6fm4M1YpFUmaZY+7anmNHw==
X-Received: by 2002:a05:6808:2129:b0:3d9:26fe:298b with SMTP id 5614622812f47-3d93c056b7bmr8925065b6e.17.1720686789497;
        Thu, 11 Jul 2024 01:33:09 -0700 (PDT)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d682b38e4sm3988188a12.77.2024.07.11.01.33.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 01:33:09 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 3/7] workqueue: Remove cpus_read_lock() from apply_wqattrs_lock()
Date: Thu, 11 Jul 2024 16:35:43 +0800
Message-Id: <20240711083547.3981-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240711083547.3981-1-jiangshanlai@gmail.com>
References: <20240711083547.3981-1-jiangshanlai@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

The pwq creations and installations have been reworked based on
wq_online_cpumask rather than cpu_online_mask.

So cpus_read_lock() is unneeded during wqattrs changes.

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 9f454a9c04c8..64876d391e7c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5123,15 +5123,12 @@ static struct pool_workqueue *alloc_unbound_pwq(struct workqueue_struct *wq,
 
 static void apply_wqattrs_lock(void)
 {
-	/* CPUs should stay stable across pwq creations and installations */
-	cpus_read_lock();
 	mutex_lock(&wq_pool_mutex);
 }
 
 static void apply_wqattrs_unlock(void)
 {
 	mutex_unlock(&wq_pool_mutex);
-	cpus_read_unlock();
 }
 
 /**
-- 
2.19.1.6.gb485710b


