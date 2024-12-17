Return-Path: <linux-kernel+bounces-448555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE2B9F41BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 05:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A8116C9BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 04:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC341487C5;
	Tue, 17 Dec 2024 04:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="3Q8gvaxR"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9A361FDF
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 04:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734409619; cv=none; b=ZfoV1fHrpuMTfJoSqrxDvCLZ2B6X0FXJsDjmNveSjewQjnD9lynHNnplorx6htJm2RuQmBFk/W6lJOIktDXL+1LRexDG0ya4OvJLMyKYoMyXsh/1MsozTu3kFJN1PskE7dQ0I3z1/Uh0ZTgBdWNqFwCnQV7QYQrLUnBfldn4r+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734409619; c=relaxed/simple;
	bh=oJeW3gHorvNzOxvEw8nkng1vYKI7qBUk413LRJXqJy4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dMGna6NORMSc2eU/yssQWTu1a3eWYs6HMwD7R8UabZ3EDgVhirWgHLu7G0j2xndpyR1+90v73+zeEWmneoR9ASafLGQ2uMQ7dF4tQ61MWyGNrbHD9WHn7Of1PDU58ZgKvpjAiFuskY1CrmspiEZr+V0WaEd91nEv7oWCBDkfVRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=3Q8gvaxR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2163dc5155fso41491975ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 20:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1734409616; x=1735014416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qXNHpm89djL5PE/bjyK5530d8EfFp1XvecS2lSbh7AA=;
        b=3Q8gvaxRsQqIV02vp0JEpcEjDU/sIs8C299OwaTexIPOmiBrYQqskmdBrNdJEvq1Wa
         9O+nOQOWDEcMOk9EDuFBRm23Vze8pWgZgviHtbPzCPJOh+a/DFuwhgmEX5pFnE/16xXv
         OvcnHli03EJbEmjJgXlzJNtL46l5Rjlt96uoWZxJBMYOZxyqKFmF2v2f97fhnrI5r1i0
         QyHLsIhIgOX7BQJr2KMRDrpwrao2nc2yBxw6rSofIzzeEMXYo4+qkP3LuNwyx6WdtzQi
         sFtqkFFre85cHkZiAQpiNxZr0/JgfnJlS4Ugg1H5w6+0D+vz9XqDr3yZuZ85AUoYjli2
         HKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734409616; x=1735014416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qXNHpm89djL5PE/bjyK5530d8EfFp1XvecS2lSbh7AA=;
        b=Fx/mT4p7an/NfYQuOuXegGY7xT1INLtWoKLXMvGaoF3xK1jWjr+6rVhHEc6ah31F0u
         4qlfPpmZ/yqxQ8+4nk7j8YX5HccETmXvT/fY7CUUoVSHawcnkBzh7dizlUx7SRJFZGcF
         E0XRcntH0OyQG0Pjvsvc4vMnE4zVjYGbDxQ+qoEZWZvzEq3XP1y2DfXbVnYM2/P7gGzT
         k2z3ZuUXs4Yrgg68bM1EFm80IE00MAGhEZf3qyLMfpJF0EQmJZlDmIo9gZpJbNMiH9V2
         b8LN8htdwWplKrCEuy4wk9cMfXHvk/MQmX0hnqwcgTQFsqYeMo2doBd8euVXzh+CY03m
         Oexw==
X-Gm-Message-State: AOJu0YyoYbPFvyz4Zx1VzhYB6YJbywrlleQIzVl5fRTn8ebux5fq5lm4
	BdsRjcyqwoYAOOJZHnwcZzxbdfw5d8TyuD+9KPQ2fAxsgevz8Qw4WsOayuCnsziTdq1GciD69UO
	BzxGVYw==
X-Gm-Gg: ASbGncszA2CCJOuwk6SqoDAJ/c957yOOCrrV3KVwbLY19tlZBwvN6geU8w4qA5nBMu4
	AU6eGoO8FYVbNdV9n1V0Lt+LE1SXPRoE81PgI1euVjE5xh/JN8SKnBD1VH5yRPBke1enJtqdIYx
	PRv3Dg2znIdX6qufjcOr2V2PkLPxdJYA8TzWSnQyPFOydGKIs1sHNw198SRYUZYGGDVch5rcGaU
	SPxsCU5zBqjIcyMXx2SumCDxCtyJdRDmCPxLWf/0qosoAKvhvZJLnM38yfOIUA1Vk3w9V3TYtDJ
	/+ySACDTDwtVyGsJu5vWzTlfFnaDK+helhmbc17i5ME=
X-Google-Smtp-Source: AGHT+IFH25BZPBZgaDXLtn50bVkIX7wRswiFCZVTLFkW/zLvZJtXZK8NPjFXRzbO8WimsQDIHS9rsQ==
X-Received: by 2002:a17:903:11c3:b0:216:410d:4c53 with SMTP id d9443c01a7336-218c9009479mr30366605ad.41.1734409616251;
        Mon, 16 Dec 2024 20:26:56 -0800 (PST)
Received: from localhost.localdomain (133-32-227-190.east.xps.vectant.ne.jp. [133.32.227.190])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db63ddsm50407485ad.54.2024.12.16.20.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 20:26:55 -0800 (PST)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: mchehab+huawei@kernel.org,
	sboyd@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] spmi: hisi-spmi-controller: manage the OF node reference in device initialization and cleanup
Date: Tue, 17 Dec 2024 13:26:46 +0900
Message-Id: <20241217042646.1866760-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

spmi_controller_probe() increments the refcount of an OF node, but does
not release it. Instead, call of_node_get() in spmi_controller_alloc()
and release it in spmi_ctrl_release() to avoid the reference leak.

This bug was found by an experimental static analysis tool that I am
developing.

Fixes: e562cf3aea3e ("spmi: hisi-spmi-controller: move driver from staging")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/spmi/hisi-spmi-controller.c | 1 -
 drivers/spmi/spmi.c                 | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
index 3cafdf22c909..dd21c5d1ca83 100644
--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -301,7 +301,6 @@ static int spmi_controller_probe(struct platform_device *pdev)
 	spin_lock_init(&spmi_controller->lock);
 
 	ctrl->dev.parent = pdev->dev.parent;
-	ctrl->dev.of_node = of_node_get(pdev->dev.of_node);
 
 	/* Callbacks */
 	ctrl->read_cmd = spmi_read_cmd;
diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
index fb0101da1485..e662a7a78df2 100644
--- a/drivers/spmi/spmi.c
+++ b/drivers/spmi/spmi.c
@@ -36,6 +36,7 @@ static void spmi_ctrl_release(struct device *dev)
 	struct spmi_controller *ctrl = to_spmi_controller(dev);
 
 	ida_free(&ctrl_ida, ctrl->nr);
+	of_node_put(dev->of_node);
 	kfree(ctrl);
 }
 
@@ -458,7 +459,7 @@ struct spmi_controller *spmi_controller_alloc(struct device *parent,
 	ctrl->dev.type = &spmi_ctrl_type;
 	ctrl->dev.bus = &spmi_bus_type;
 	ctrl->dev.parent = parent;
-	ctrl->dev.of_node = parent->of_node;
+	ctrl->dev.of_node = of_node_get(parent->of_node);
 	spmi_controller_set_drvdata(ctrl, &ctrl[1]);
 
 	id = ida_alloc(&ctrl_ida, GFP_KERNEL);
-- 
2.34.1


