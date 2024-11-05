Return-Path: <linux-kernel+bounces-395885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF519BC479
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 05:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 360C31F21E34
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 04:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CB91AC43A;
	Tue,  5 Nov 2024 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCVLQKA6"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57846817;
	Tue,  5 Nov 2024 04:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730782543; cv=none; b=WMK+TW+7+C6Mmi9oJERkzWG2h8kZE/MukntGwJ7pEFBnE/QDw4WrgRFFk4PT/7SJjin5JCLrbKAfChcozAHQaC0/w1uO3eRj1yHC+pxzlGPFIOSURpQlxQnGYiqrOqr5GRmpZrpUFGRTCm2Og2E9yf+QFD+gHqj+/aUahPjJQrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730782543; c=relaxed/simple;
	bh=sxiKf1QSynbCiQhKN3mYKws/pWiRRPLGHnWa2jxfXNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CzJ/oui33Pt50sED6PbrTmnN54DoXCmYX7GjfS3Mx+Fc44a3QjdTKYkvlV+6CX+xXuSpO0BEo88uUVgUGvle1FBhE7kzsJ4UT0RX/wYNizDetoqsNYmajgrXnB0k6Vkwm0Zu+/aHinxPo3jQu1Ci7OMzaTFzMk36zWsHhxRRYUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCVLQKA6; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-720d01caa66so3295228b3a.2;
        Mon, 04 Nov 2024 20:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730782539; x=1731387339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Khb4VZYAXplP3XxpEGrYynPr+Zwc/4+weimCSwjc31U=;
        b=aCVLQKA6i/v+YiVRgAUCL9Bm1dSiy5tmcW5/xgCWJskTamxng3gfrSlCHCXyketE2Y
         p+xMSBERdKk4MfAQ363GmL6Ks9NybCOmWBZCSyhCUECqzGkiG2ByQc2z9WdiScWoC0VQ
         klXn6SWWjF2K3eAtXgAjLSFdR6dAP3BVBFpObsbPjpKYC1pDjrsfWCcP8epwU7MjwXYe
         NGKY9tYPmXM6veyJhCDfGsosVyVd57rRypCWekqHh0UIQnAnjPQeJ/dTrluS0KcK34Bo
         PRly9C/CcZJ0bxtE6nhWEfRzRHWHYqcaNBi48jGu9dPwfJBTWoPFwznQwx6MNhsR70h7
         tiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730782539; x=1731387339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Khb4VZYAXplP3XxpEGrYynPr+Zwc/4+weimCSwjc31U=;
        b=HIZykQWz65LYJdUh6y5bTjXwuS/F9OS++BpDso63VvG3N8HkdB2+rYFafuT808MiNZ
         UrVZPYbPAFj37+w4VohYjMPi2uxO0dzYzhFbdkAv2OsomNCmmawNwQtzOt3i+yCi3/lm
         Whk3WfUnulzzrGiMzxbvMpgJguv7yF4QwPnJ6azASoBNe5qU6ilBWC/6s5tS2E25maQ6
         C8q/PF5j181NM8YQnu4TdkyqXlgvGFFaPnSUxncadB3zRLOR47XmcWPMJ3cGFESY8Q64
         zsyMZeI0FPKKp5kFwblA5uOHR3C0wps5+StqbDLGNpx2hoYyuMNXENkkhvvFX3WnrmLg
         SyOg==
X-Forwarded-Encrypted: i=1; AJvYcCXP8V4bshdx1vn8Ve1kC7haeIv+Soc7RghU05BR4kWx/vaZZZQ1sCTO3vo+WAbdEJQsddokqHvdWes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUkGh7HPaFWZ9ECSb2kYa/L2xUkLSOa7ZO2xT2Hk7QXP0/6E4P
	An5dIOO+QlWoCt99AKBlRmsvHJR3oNksOVRkf7HmhRw4eQ6SxTXoqdBL6Gd7PzY=
X-Google-Smtp-Source: AGHT+IExk0G7LiGaZbfMTZkKL2qjAppCeCkx9BZurQClRIxD6QUURr+YszGwe8GY7pKy7eUHg1mBCQ==
X-Received: by 2002:a05:6a21:3399:b0:1db:de9a:bb01 with SMTP id adf61e73a8af0-1dbde9ac070mr8242587637.40.1730782539411;
        Mon, 04 Nov 2024 20:55:39 -0800 (PST)
Received: from anishs-Air.attlocal.net ([2600:1700:3bdc:8c10:d414:4f86:7740:65e1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93daad721sm8698351a91.13.2024.11.04.20.55.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 04 Nov 2024 20:55:38 -0800 (PST)
From: anish kumar <yesanishhere@gmail.com>
To: corbet@lwn.net
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	anish kumar <yesanishhere@gmail.com>
Subject: [PATCH] drivers: core: Clarify EPROBE_DEFER retry mechanism
Date: Mon,  4 Nov 2024 20:55:35 -0800
Message-Id: <20241105045535.84071-1-yesanishhere@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing documentation for EPROBE_DEFER explains its purpose
and usage, but does not specify when deferred probes are retried.
This patch adds information about the retry mechanism to provide
a more complete explanation of how EPROBE_DEFER works.

Specifically, it clarifies that:

1. Deferred probes are added to a pending list
2. A successful probe of any device triggers moving all devices
   from the pending list to an active list
3. A workqueue processes the active list to retry deferred probes

This additional context helps developers better understand the
behavior and implications of using EPROBE_DEFER in their drivers.

Signed-off-by: anish kumar <yesanishhere@gmail.com>
---
 Documentation/driver-api/driver-model/driver.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/driver-model/driver.rst b/Documentation/driver-api/driver-model/driver.rst
index 06f818b1d622..c86b948d0dfe 100644
--- a/Documentation/driver-api/driver-model/driver.rst
+++ b/Documentation/driver-api/driver-model/driver.rst
@@ -171,10 +171,13 @@ released all resources it allocated.
 Optionally, probe() may return -EPROBE_DEFER if the driver depends on
 resources that are not yet available (e.g., supplied by a driver that
 hasn't initialized yet).  The driver core will put the device onto the
-deferred probe list and will try to call it again later. If a driver
-must defer, it should return -EPROBE_DEFER as early as possible to
-reduce the amount of time spent on setup work that will need to be
-unwound and reexecuted at a later time.
+deferred probe list and will retry again as and when a device or driver
+gets added to the system. A successful probe of any device will trigger
+moving all devices from pending list to active list. A workqueue processes
+the active list to retry deferred probes. If a driver must defer, it
+should return -EPROBE_DEFER as early as possible to reduce the amount
+of time spent on setup work that will need to be unwound and reexecuted
+at a later time.
 
 .. warning::
       -EPROBE_DEFER must not be returned if probe() has already created
-- 
2.39.3 (Apple Git-146)


