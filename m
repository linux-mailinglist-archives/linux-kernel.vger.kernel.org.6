Return-Path: <linux-kernel+bounces-212524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 928659062B1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 05:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439271F228F1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 03:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E9F1304AA;
	Thu, 13 Jun 2024 03:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hueS8v01"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74AE12E1E0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718249780; cv=none; b=rncpGVa+gqgLzhWe0U0sgrgxjx/jsj2VDRpt6vghmW+ZUhlIXYAi+UV3F4HXp7ReEB8pNnTkcNlxEkG1rlrITEyZsz12OGXt5lSOiqbVSshHCl5HwkTbdMzIVMOFFClhVy8t9lghyEfmGi15cgRHVZmGDQ8lrX5BU8LeTQcuVJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718249780; c=relaxed/simple;
	bh=MQvxwyoGp7g3FzFWr/I0a8kc0piwyy+lN8wILvBTQy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MAT++Rcio/U+XdEbZ8jrrxfwapPVB/CLwI/jIdl2cAxLz5S3VgTlJT7v67LFltX8jnd+0pzSjSyjMU6vVOycfncxGkvYt0uV1eWOylBmTEJlnHxKBm57+P0f/u1Yzg9wX4I+r3OyaJTVxTOtzdkbHVc4X6l8m70axPZ4lZ3e74U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hueS8v01; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b52b0d0dfeso336732eaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718249778; x=1718854578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=64lQ+7Ne2blEM462WW0QA7sA2eePUzeaPGxGMR2In9o=;
        b=hueS8v01MYr828mABqvrGpiWaRnYG81cXJTWFrzzz0xA6H9NEbaJWXvkbN727XdVPe
         pfZY4uo+uZlTO3mG5f6lrU2Nwf68ssIDsKRTXCp+1YzCK1nqLALBRpJmj+SaoZ/9N/1m
         Uv3dEK7JQ0b8G1PVqnHmbQnEzHpTuY+RWE038XMk4MLIbEFZH1lM6I6VfwYvJjFT17yj
         CEdzKDn/nvgby4WClrQROiYDhwLNQ+WqLIWK38vmLnIiZp/jmpVWtFPjPl8RNZuOPYVA
         2SnJY9ggZ4gkK978PCRT8aQgezIbebiZ0Ta/gtuONWGblb9Gwoj1kwc6hD68OdRruQ06
         qKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718249778; x=1718854578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=64lQ+7Ne2blEM462WW0QA7sA2eePUzeaPGxGMR2In9o=;
        b=SC70Pnhd8LGqMF6Qzwv8CSQ3mZ46qdrgOaf0RNSfDhQT4EsQYQ7gXL1885GUhRzzls
         wxdcSGeJONF19U5S9dTUhbG3UUm26XLtLckcBDL+3pqxmEraB5U3Oqre4PaTi42ZlaEl
         3e/XnxMASQWB7fWgQDRLvMq/u/Rr8F1ZHABlVaD6QFF1xZynzKzXqXyx0lO8FyTv8taa
         WI30VYBw0FsNjQzJm4KECHi9+VuhrIWbS4YC6aN1wC/Qh86v12CqQWqDcZyPiV100N04
         UGeNkaOsGBrV+YGxH2owoYMZRGMZVGbF4lBxikUbEiVzM0bRhgyPxYtGm6BpA0+LZDGk
         L/Ng==
X-Gm-Message-State: AOJu0Yy5sEYkOwp4aJsMmGOcVeTVzzC+KhT7Val51+G5I95SuaZsPdHt
	mO6YYNfFMC8v8CKR0U2Oa3TRRPxcM7Bxm4KZhr3YVPNo0DGWNScF
X-Google-Smtp-Source: AGHT+IE80SY50dZdFy1xl9v8PfNTianjog93BKZeMJ8tQeDEKKN5Lwm9paN23qqwZnRLR2dyGZ1+JA==
X-Received: by 2002:a05:6358:5699:b0:19f:4ca6:86c8 with SMTP id e5c5f4694b2df-19f69cf6c29mr424899255d.6.1718249777660;
        Wed, 12 Jun 2024 20:36:17 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.165])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fede53d188sm184919a12.36.2024.06.12.20.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 20:36:17 -0700 (PDT)
From: Yongliang Gao <leonylgao@gmail.com>
To: kent.overstreet@linux.dev,
	j.granados@samsung.com,
	jsiddle@redhat.com,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	Yongliang Gao <leonylgao@tencent.com>,
	Huang Cun <cunhuang@tencent.com>
Subject: [PATCH] hung_task: ignore hung_task_warnings when hung_task_panic is enabled
Date: Thu, 13 Jun 2024 11:31:59 +0800
Message-Id: <20240613033159.3446265-1-leonylgao@gmail.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongliang Gao <leonylgao@tencent.com>

If hung_task_panic is enabled, don't consider the value of
hung_task_warnings and display the information of the hung
tasks.

In some cases, hung_task_panic might not be initially set up,
after several hung tasks occur, the hung_task_warnings count
reaches zero. If hung_task_panic is set up later, it may not
display any helpful hung task info in dmesg, only showing
messages like:

Kernel panic - not syncing: hung_task: blocked tasks
CPU: 3 PID: 58 Comm: khungtaskd Not tainted 6.10.0-rc3 #19
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
Call Trace:
 <TASK>
 panic+0x2f3/0x320
 watchdog+0x2dd/0x510
 ? __pfx_watchdog+0x10/0x10
 kthread+0xe0/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2f/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Signed-off-by: Yongliang Gao <leonylgao@tencent.com>
Reviewed-by: Huang Cun <cunhuang@tencent.com>
---
 kernel/hung_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 1d92016b0b3c..6ca859715d8a 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -127,7 +127,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 	 * Ok, the task did not get scheduled for more than 2 minutes,
 	 * complain:
 	 */
-	if (sysctl_hung_task_warnings) {
+	if (sysctl_hung_task_warnings || hung_task_call_panic) {
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
 		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
-- 
2.39.3


