Return-Path: <linux-kernel+bounces-238761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AAB924FA9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 05:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA9228EC0D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 03:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA9B17BA9;
	Wed,  3 Jul 2024 03:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPzzBHJa"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87733D969
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719977782; cv=none; b=HCf5XEzEy/qUcoDUBLCeTMfWmNWjHPALCqglJEuOIbctqyAhj7dcZqt8+6fPK4ILHJ+FbPLfab+qNf523UOOSJL3gUuyv8LmctQXEqlVZw0NV08hWBAo0EGiT7muJPNBM8gchFstdQCP6TVY0ewedFDLkTLfWoWlFjlmcpcOLQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719977782; c=relaxed/simple;
	bh=4eMOivaNyGq3AAE/jp7yke6+6PAXIf8vuuNWSJKJq1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JFlJbVX3R/XhEbjybeQr83onoHuKtGQRe++35DZBKdaRJ2JmlwH8YF6X1jpnaH7Sz6tHBVe+P7UNCtDYUwe5eP0ZP2N29p6TIC+CBah1LwmsqGfzw/6rR5lU721hQN/IC8I8hlgzHxYbhpToD1dn9xX85qPTiFYXuhR5i5AvVrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPzzBHJa; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-71884eda768so2820127a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 20:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719977779; x=1720582579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lws+ZLig0oV0HzzX4lmzZbMJvRrN++IbAE2lJR9pEa4=;
        b=NPzzBHJaYuvklHTSLFevUUE2H1REwKCbQsW4kgl3WQDF3sYWdt0e+NbTGk4ZV/0Vz/
         ceClXZrrAwcaj8pQ8LMjs5QDhusXzrxMODTQHM2Z9ipMCDv3zE/YFkZjwzgbHXn5qrfW
         Cp0piMoGsNTua2grVFMvmq+uWk3LjkgyTDfFa5y1j5nMPVD0eapwb1lQd4L5ratM1atV
         X1xdc8IpaMx1NYPYDdgMMNbNRzBAUyEzsGEZOXkb0d+cpD2CpImbhh0oBgwvG0XmuSIC
         CzuV6bs2oMf1yfaGoxTPqcS2a9PxX2gguVLFJtM9B7gHA7wViALFnNG6oHXjn50wnDXF
         le/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719977779; x=1720582579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lws+ZLig0oV0HzzX4lmzZbMJvRrN++IbAE2lJR9pEa4=;
        b=k4Bi90pU8MfNNzYWA0n8LsNEaIGwSv0VIKiVZinbM5DKnvC/v26G3M2EmQrm3kMO2x
         ghqTMweaKMH9jnhR/YFVWjihP8mR65OLHr0/A3lIlxLSjUdnSo+SVHB3R2TvxPsBVlYr
         se0C+6JXu0EnzSOro0cJmOgN4so7V9sE3hF3PnkKCRO7SW/B6+A/ucZYQRwMlVw6nhsj
         fHEBLl7ioiSY8I12xXNPtXWREbEXYuOh94KIANzLtPJuIBjm0KmEvfevnJeV4+GUkv1d
         TUKYaU5BURUBqewtJawgX4bXeJFJEULlhfGlK1vItBWEtHWJFMD8DcK2NoIxmJCnZYnM
         /U5g==
X-Gm-Message-State: AOJu0YztRzZy8UTLDuzpzSN/h1M+30LFwMPkqEELtEfXLjerdVm8KcCL
	c4hj5bKdF+0eQZBI2eZCxBU7ZQ+Be9F8O9r5WsbGnIM8XurKNtK53CJCTw==
X-Google-Smtp-Source: AGHT+IF0l8eugTgllvLJTnwYtOC4OQsSPG3BE9H1d3jWcGDuYL2+VncEdV4DmPcltO0syFLtFPW3Zw==
X-Received: by 2002:a05:6a20:3d86:b0:1c0:bf35:ef42 with SMTP id adf61e73a8af0-1c0bf35f31cmr852347637.3.1719977779562;
        Tue, 02 Jul 2024 20:36:19 -0700 (PDT)
Received: from localhost ([47.89.225.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c97cf8fc68sm160047a91.36.2024.07.02.20.36.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2024 20:36:19 -0700 (PDT)
From: Lai Jiangshan <jiangshanlai@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Lai Jiangshan <jiangshan.ljs@antgroup.com>,
	Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 3/6] workqueue: Separate out destroy_rescuer()
Date: Wed,  3 Jul 2024 11:38:52 +0800
Message-Id: <20240703033855.3373-4-jiangshanlai@gmail.com>
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

Separate out destroy_rescuer() to simplify destroy_workqueue() and
prepare of reusing it in alloc_workqueue().

Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
---
 kernel/workqueue.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index cf1a129eb547..0dd9a12befb5 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5548,6 +5548,22 @@ static int init_rescuer(struct workqueue_struct *wq)
 	return 0;
 }
 
+static void destroy_rescuer(struct workqueue_struct *wq)
+{
+	struct worker *rescuer = wq->rescuer;
+
+	if (rescuer) {
+		/* this prevents new queueing */
+		raw_spin_lock_irq(&wq_mayday_lock);
+		wq->rescuer = NULL;
+		raw_spin_unlock_irq(&wq_mayday_lock);
+
+		/* rescuer will empty maydays list before exiting */
+		kthread_stop(rescuer->task);
+		kfree(rescuer);
+	}
+}
+
 /**
  * wq_adjust_max_active - update a wq's max_active to the current setting
  * @wq: target workqueue
@@ -5772,18 +5788,7 @@ void destroy_workqueue(struct workqueue_struct *wq)
 	drain_workqueue(wq);
 
 	/* kill rescuer, if sanity checks fail, leave it w/o rescuer */
-	if (wq->rescuer) {
-		struct worker *rescuer = wq->rescuer;
-
-		/* this prevents new queueing */
-		raw_spin_lock_irq(&wq_mayday_lock);
-		wq->rescuer = NULL;
-		raw_spin_unlock_irq(&wq_mayday_lock);
-
-		/* rescuer will empty maydays list before exiting */
-		kthread_stop(rescuer->task);
-		kfree(rescuer);
-	}
+	destroy_rescuer(wq);
 
 	/*
 	 * Sanity checks - grab all the locks so that we wait for all
-- 
2.19.1.6.gb485710b


