Return-Path: <linux-kernel+bounces-232877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8704D91AF63
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 20:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C9C1C225CA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEED219AD54;
	Thu, 27 Jun 2024 18:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="mrKDO9Ib"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BF9195B18
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719514777; cv=none; b=NZcbTSIPpuN4foqa1WqB6tqmtAIel+DtOhsXAKXxtk0KG9SEX03EiZVV0cBiXCEoa1G5B5D5LRgJ/ZCgFi32BRNE/ONvV6dGn9sIrDwSGXEVt0D5XeefPJjBXP0/3hP0MH86n1Y6K9EVEg+xyCzzKTEbJqtHI+aF3OsIyqk7Tt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719514777; c=relaxed/simple;
	bh=wVWCJIkOk4DfwPRXbdj4ZfIdLLv05Ic6HW/TgXtQy/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oaVahkF734FQLaDF7uMXMFnbDHMgpMjE88xYKzZI/yKDf61u1bvEfeweHWl2rszFY2PPa6zrnJ0PPrv28Zr0K3dTtcEijT9p1yvBsxP/K2maH32pr+J7LR8F+obZuEE88v9sG7lR3LI+zjKW9ZDQaHr7a5eVizu6PtPqLTDX+B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=mrKDO9Ib; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9C59C40C8C
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 18:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1719514213;
	bh=11NDFrtmzJHVKvXyS2kTgfVMF0uqBKbPDuoBNWc2LAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=mrKDO9Ib/7fpe90yYzCqjYWchK0Yrk1fQmPcumsakIj6aOg+dMlLGXPS092T1Za8/
	 0S3vxnZJ2Paii3gH4iYUnBEtmA6mW+16smEZi9PAHmSgPWlzkdxHGT4Qxo7iUUF7yv
	 irf3UKOYPH8VYyM5KmEnVIChSRjLYA2gfpHK5N8ODlYL7ZblnuWS9H5NPwHGKy0smE
	 CWepslFjmDEKzpdAWhvDdgmESmItsRrlg+gyoDpqzFFR60+QjDzRqmWqX8DYpYs/Pt
	 XibQXmLOrCH/cWwLl1ism31iqHfTGG/ldK9hesyldJCdiZmfYt7c99X3wMA7OqeP8n
	 SQvMeMO6PqusA==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-57d22ea3e71so1122562a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719514213; x=1720119013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=11NDFrtmzJHVKvXyS2kTgfVMF0uqBKbPDuoBNWc2LAE=;
        b=bCyHKpyJ/mSZXkT1gJV5IARCNaNrQQ54JryzFafhpYuP3pAI7lE7LcNvP88xJFuRfk
         gXRZN6aFb3ihAlqDTJSWx4MiuKVqqHhvfYakTS+YuRfX6grx5tLmMhpcjxgnMThGFlOa
         CCKY0EmCb8takuVC70neLWD9ffb/TnDW98mkOd+iRxX4WmCm5qjQqBx9cni5ALtQ/xTo
         U4NFfzD1ZPr6EX3In7j++b5UjecGkxMmwEpoREcpdbZX19D9GO2NkVDn7cV1q+WQLXTP
         We6fA/rpAK66IdSC+1vbkw70gH9btLsFrRsg2t8tYPQ/IcamPevaeDxRdzYhWfDOMCZ9
         8bxQ==
X-Gm-Message-State: AOJu0YwIQewCwm5MOZVXxCnUrylFD8zykvlWeELPNYzTKqX1Bl1jlCw8
	/WBwT3tV1raV2d2j9bkZyaYWozJtJ6jTJavBvGf7DWFCdngG8PZgSzwairuVtX/XtF9msAXTBVJ
	1dEhq+2E/dGm9QWmyDoEt52jC4q9L7EnKSn9r22FXrSSd85kPY2yi2J5kUgp4IRf8y8X0ekj9C0
	B/Ng==
X-Received: by 2002:a50:d503:0:b0:57d:4d7:4c06 with SMTP id 4fb4d7f45d1cf-57d4a2815b1mr12472626a12.13.1719514212818;
        Thu, 27 Jun 2024 11:50:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErOw2CkJX4hJdCc0yAyqTfxDujvaW8REYWAMMKhgy5+221dtZtH1vjzh2kbveL6yplyOxWwg==
X-Received: by 2002:a50:d503:0:b0:57d:4d7:4c06 with SMTP id 4fb4d7f45d1cf-57d4a2815b1mr12472614a12.13.1719514212287;
        Thu, 27 Jun 2024 11:50:12 -0700 (PDT)
Received: from gpd.homenet.telecomitalia.it (host-79-55-123-4.retail.telecomitalia.it. [79.55.123.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-586138163cbsm35751a12.47.2024.06.27.11.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 11:50:11 -0700 (PDT)
From: Andrea Righi <andrea.righi@canonical.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: linux-kernel@vger.kernel.org,
	Andrea Righi <andrea.righi@canonical.com>
Subject: [PATCH] sched_ext: fix typo in set_weight() description
Date: Thu, 27 Jun 2024 20:50:09 +0200
Message-ID: <20240627185009.1258446-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct eight to weight in the description of the .set_weight()
operation in sched_ext_ops.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 8e8b44f2c74a..f6e25545bfc0 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -369,7 +369,7 @@ struct sched_ext_ops {
 	/**
 	 * set_weight - Set task weight
 	 * @p: task to set weight for
-	 * @weight: new eight [1..10000]
+	 * @weight: new weight [1..10000]
 	 *
 	 * Update @p's weight to @weight.
 	 */
-- 
2.43.0


