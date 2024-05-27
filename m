Return-Path: <linux-kernel+bounces-190752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 822598D0224
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32FC9285334
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F015EFA7;
	Mon, 27 May 2024 13:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="D6Nsjc8M"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D961640B
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817821; cv=none; b=oCPsG1dBsOhm7l/3Nj2HSgLCAK9FP20LxBQ8i9BcOUyGs70Ld20462c5rdhe+tkQGh4QqmpA81Nu2lb/yW9RORQvJsGhlhW0s46kaRjREZQV+1fFuCSoT3Ft+jaY9BuWro0R32TVnpB93KVGnns8GRrzxSGGoylsY9ncJCuqxKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817821; c=relaxed/simple;
	bh=SlXdApCylnQr8N4neH0zBYcckEuMSS9hVMXK7hRZ0Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q2ztFAMUUl8kp5et8Sow2femhP3qpCzcTSXz7OAXXdMyL/75Tn3hRT9qtV7aj7Yg2aPqd/joZ0azWyIy4px++9RfEMtYfaMkWOzC2EtfjyOTlidGAhg93MHj36iluPCiFVilaVRKYTZ+Cq6GKrzvOtFcdNyGVff6E8jqXJiG6CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=D6Nsjc8M; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52742fdd363so4740476e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716817818; x=1717422618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tIOT9wvexJ79HNlrDmaPIby9uyeD/58/CsVvVIRo/Pk=;
        b=D6Nsjc8M+mozp/1Yt+GtPtqPBNmvMQwHHnB3qJdGlaIf8/8cHyJzmqEeKiQoHBE8yI
         Gc8X0OQzJRYEivdCq4uCi168JDSVQMLd+3LV2UbCuSbWmlavsHBd5SQ5PFhg9eWrsRQN
         07BdIVb7CzPkIvK2LuldHc9lqSESnwjVzoJGW/B+Kk26LIZUJv8eAOp40JdNDLNddTBX
         wI8pLXjFmgsNx/7yl5J/F0QBSNnQePk9zu/QTAZQZcHIvpZaW2HYwIyHYH0xQKCZM3nJ
         UlKFzYcsfd6acOSs9TSAYcrYzpoSOdF5vW2LFLDpmvly7VuthTwgzUvzDCULEWA3n7zx
         iuNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716817818; x=1717422618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tIOT9wvexJ79HNlrDmaPIby9uyeD/58/CsVvVIRo/Pk=;
        b=UONoMVh2p0pI6HWA4FuEKTtvrZnN8dPFAL/+hIg42SEiHraOugbM1kofX69qq6vsUF
         aTisG3sflkS5SX5309bL2OhOm1UTosmIxYmJIhpaQS9XkG7+yFAJGnRsaRbpUKdJbnq6
         kamKoX+b01zDYCrfjf+uju+rlXcSNwClnP6hKSLp9SBAhuqkis2HlN4C7fh44qO8Xba9
         VBl0sZb0xTEXZqn3UGl+X2VEiJQNBMLBIj6QJ2jvIcWpn9xQlM0DJkmEG17qy+HrNQfm
         1MiRs+mp85CnFKpWDTbJd+V4WgdHh5kTzAh2HIi8IYgmIL5QBRIyo/QrHZDE7O82bTnn
         hXIQ==
X-Gm-Message-State: AOJu0YwO2pWwg9jRj9M2gTB9mU2AwH2NGJQUqiFDjgp6jhELAXyhpE8G
	Bg+kYdkORCa8VxSjo8Wps6gnpMbeHZ0mGGeYKptK7rA3BH6upiJWLvZFUOL6Bh7qwHEx7WNpJXZ
	4Kr4=
X-Google-Smtp-Source: AGHT+IEgARaZR+bIcjTK+/X0WoYnEvM7h0HHZFhNHPDwp9UyqUv1nbtDit7XTXMaV1EI/AddrP1s2A==
X-Received: by 2002:a19:7705:0:b0:521:a96:bf1a with SMTP id 2adb3069b0e04-52966bad0eamr5027540e87.61.1716817817617;
        Mon, 27 May 2024 06:50:17 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578524b9e80sm5802279a12.85.2024.05.27.06.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 06:50:17 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v2] w1: Drop allocation error message
Date: Mon, 27 May 2024 15:49:47 +0200
Message-ID: <20240527134946.338398-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the custom error message because kzalloc() already prints
allocation failures.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Drop the error message instead of fixing it as suggested by Krzysztof
  Kozlowski
- Link to v1: https://lore.kernel.org/linux-kernel/20240513154354.185974-3-thorsten.blum@toblux.com/
---
 drivers/w1/w1_int.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/w1/w1_int.c b/drivers/w1/w1_int.c
index 3a71c5eb2f83..19a0ea28e9f3 100644
--- a/drivers/w1/w1_int.c
+++ b/drivers/w1/w1_int.c
@@ -32,12 +32,8 @@ static struct w1_master *w1_alloc_dev(u32 id, int slave_count, int slave_ttl,
 	 * We are in process context(kernel thread), so can sleep.
 	 */
 	dev = kzalloc(sizeof(struct w1_master) + sizeof(struct w1_bus_master), GFP_KERNEL);
-	if (!dev) {
-		pr_err("Failed to allocate %zd bytes for new w1 device.\n",
-			sizeof(struct w1_master));
+	if (!dev)
 		return NULL;
-	}
-
 
 	dev->bus_master = (struct w1_bus_master *)(dev + 1);
 
-- 
2.45.1


