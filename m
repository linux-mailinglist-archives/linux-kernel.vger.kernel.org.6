Return-Path: <linux-kernel+bounces-390546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8419B9B7B21
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:54:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3597B1F24186
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970BB19D087;
	Thu, 31 Oct 2024 12:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0y3Yf9S"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C190619D88F
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379273; cv=none; b=GIpOsE1yPwnG/+tTnWkGaDhQrTit67oa7pF0lSZXEiOLYv6tHCNp1llab6ONKDsLjR0VLg4lmc7Qbk/JEdTek/JBnJLLS1OPJ8RorkIMBdJPe7YPH/HiRTazY+W4dFribilq5yWkT/PHBe38X+k9dc3g0Nnh2kzWmV8ta5D28yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379273; c=relaxed/simple;
	bh=yTGcm6xnkCvzDchL9iODKQALg0v7tzeBcQTH8YhCuWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lCbpRtC9YZuUOp9NQuPYVeSxQ38pthIc2gIYmSgkIV4VQiw3MO0ynn1ymiQaj8TSCF3moIVVPgMJ3KvD3FkVFm+bWkHEJXzhTvnOGX39qzqNdVasqPuul0smYQ0OVsKotCEwVU/JP1x3D1ZH5n9NdDbv9sOclsWTfNyK21eBwMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0y3Yf9S; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so7916045e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 05:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730379269; x=1730984069; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5uCi3aO0BGmm0EDQgR0wYVCbitVHRTsTt34+mj1c9Ok=;
        b=N0y3Yf9ScDpJm1LTbuDOGBR6VnGYlTnoSHZEcM1uUA1mpdclMrOB3yYuzqSVn1Sl0w
         4QI5w0o0EaMn8ZqZ3YIbpdnSlgUvBydk5CE2TntFjdCuUjSnLJZCwoZK/WQSstCwMPBu
         fuiO9ayY8+2wvtgNUufWGFr6Z/WP4mVxETFDT3J85Dkx/gNnxoEDqek9fUGYf6LSfF5P
         OljYihl/PRfM3J9Uw/beurDvSmqHOIGJBfIHWluf67AwpE/F9w7UOJKNdEkAbSHkv+NP
         SKgakhnvJhkOgNrv2v7Yw1FQYorbUoKtRoS5HJ4BSVC3z42SpbMi7NUpHiZHYXtps8xA
         h42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730379269; x=1730984069;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5uCi3aO0BGmm0EDQgR0wYVCbitVHRTsTt34+mj1c9Ok=;
        b=KZ61YJZQrol0dQC9HTW6O0iEFJyam20UiusUlP/wgeWODqqggDM9O4MJtXmd6pTERS
         jcocqjidZivncZzIix5ng3Uji+zJhOz2v4YnCEf7P5Z6CYoVWwq5l7JT2+w/QzFBchlq
         aRPqBsPYdr8Uivt8Pmm4BJ0Y+QLO8+ZOe30IPJiabIEHiGCBp1rtI/alRAOAaMlZJfpX
         kYhbLW7+uTi7Q1yS8sEO8cL6rUuSobC/zOz7ECriTW662KZPY27no76Vb2qNAuPTW33/
         kiFjEliG/uW3gkENDDP8KK+U4hqY+E1sJuyK1vqcs5YD+Qcfgm3YKDpiIdOYIpvd9nGz
         bxWw==
X-Gm-Message-State: AOJu0YxCEs2PykosZQ8LpUPJYim2Gn9nL6LHxxWYv3cf6AJtXHLd6JYn
	ZNArxAj89hQbLeeOLBKeRgUgFtLA1PwNmxy2yx2UAiKbofSqQZsG
X-Google-Smtp-Source: AGHT+IELiP2wBm8hCwnDrACU2Pb0NQl8f7Q9rBRzNbkJeG2141pBXXBGQb3WuHTWZAFI5hQ7JOdGig==
X-Received: by 2002:a05:600c:3507:b0:431:4e3f:9dee with SMTP id 5b1f17b1804b1-4327b6f46d3mr29514475e9.4.1730379268957;
        Thu, 31 Oct 2024 05:54:28 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-d7b9-afdb-c541-d023.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:d7b9:afdb:c541:d023])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9a99c8sm55250505e9.29.2024.10.31.05.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 05:54:27 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 31 Oct 2024 13:54:23 +0100
Subject: [PATCH v3] clocksource/drivers/timer-ti-dm: fix child node
 refcount handling
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-timer-ti-dm-systimer-of_node_put-v3-1-063ee822b73a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAP59I2cC/5XNTQ6CMBCG4auQrh3TH2yLK+9hDIEyQBOhpEUiI
 dzdghuWupnkncXzLSSgtxjINVmIx8kG6/oY4pQQ0xZ9g2Cr2IRTnjLKBIy2Qx8vVB2EOXzT1Xn
 vKsyH1whVypW4SK1kpklkBo+1fe8T90fs1obR+XlfnNj2/QOfGDCgpqYmK4SSOr01XWGfZ+M6s
 uETP4Bc/wByoICyzApWihqlOoLrun4ABQZ89yEBAAA=
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730379267; l=2248;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=yTGcm6xnkCvzDchL9iODKQALg0v7tzeBcQTH8YhCuWM=;
 b=kX7mPU3fN2z0kyvCg5OxaTngsR8eN3bTMbxh09uotxPsLFFjebUAA07VtpXilJgAJlSDIakA3
 9QAxptsf/ILA2S9JWxWIW1QbigYXga6cnMe/e85HBXxqf4yiSLCYGxh
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

of_find_compatible_node() increments the node's refcount, and it must be
decremented again with a call to of_node_put() when the pointer is no
longer required to avoid leaking the resource.

Instead of adding the missing calls to of_node_put() in all execution
paths, use the cleanup attribute for 'arm_timer' by means of the
__free() macro, which automatically calls of_node_put() when the
variable goes out of scope.

Fixes: 25de4ce5ed02 ("clocksource/drivers/timer-ti-dm: Handle dra7 timer wrap errata i940")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This series adds the missing calls to of_node_put(arm_timer) to release
the resource, and then switches to the more robust approach that makes
use of the automatic cleanup facility (not available for all stable
kernels).
---
Changes in v3:
- Squash patches for mainline solution without intermediate steps.
- Link to v2: https://lore.kernel.org/r/20241028-timer-ti-dm-systimer-of_node_put-v2-0-e6b9a1b3fe67@gmail.com

Changes in v2:
- Add second patch for automatic cleanup.
- Link to v1: https://lore.kernel.org/r/20241013-timer-ti-dm-systimer-of_node_put-v1-1-0cf0c9a37684@gmail.com
---
 drivers/clocksource/timer-ti-dm-systimer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/timer-ti-dm-systimer.c b/drivers/clocksource/timer-ti-dm-systimer.c
index c2dcd8d68e45..d1c144d6f328 100644
--- a/drivers/clocksource/timer-ti-dm-systimer.c
+++ b/drivers/clocksource/timer-ti-dm-systimer.c
@@ -686,9 +686,9 @@ subsys_initcall(dmtimer_percpu_timer_startup);
 
 static int __init dmtimer_percpu_quirk_init(struct device_node *np, u32 pa)
 {
-	struct device_node *arm_timer;
+	struct device_node *arm_timer __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
 
-	arm_timer = of_find_compatible_node(NULL, NULL, "arm,armv7-timer");
 	if (of_device_is_available(arm_timer)) {
 		pr_warn_once("ARM architected timer wrap issue i940 detected\n");
 		return 0;

---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241013-timer-ti-dm-systimer-of_node_put-d42735687698

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


