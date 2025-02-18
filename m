Return-Path: <linux-kernel+bounces-519937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BD5A3A3C4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 18:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7826F3A5302
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 17:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A1E280A3F;
	Tue, 18 Feb 2025 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5+ntEOv"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4796027FE7A
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 17:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898517; cv=none; b=pXrf87khyBinaV4xk9zF6aMdILzET11PUa9IWZZLjEjYIRLwWEaSb/Ik91A4ed37n7Vd+hlnb+3odsVa255qlxok31Ua92vBlBU5aMi1NlTWqPApZiAEhFCQbpbPIF6UBRzuj0FVKqID8LNlcV4keuXb8RpHov9U3pSvEkkStmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898517; c=relaxed/simple;
	bh=5TvCkp0MnHWh7GsS1WRI/iBunatRfB5yBJ2gYQ3Yvsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQOWYKt0MPsdSXFcqbid+Rt24Nfx9jlJzWfj+OdqPPXVL1w/LIM6pdj6xHjqzcQAc0zfM58PA3S3UlWerrw34g799J6u7/ioNo5FB7F8ZYmPywaLqPxOtnnDoj7Gr3F0VWWs/7+oi+LQ4C3waLfjyBxeppJjtx5nnwybS+M56Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5+ntEOv; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-438a3216fc2so59966435e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 09:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739898513; x=1740503313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=22DLucK3+Yc7gD+u5BwcgCf4UC4+6P633YUEKabQtVs=;
        b=h5+ntEOvgTqL0NkSJWu8T/Vq3E45iUXwwq5utLXy6siENMWpr8xRpzBADdGiNZxX3/
         XR4DqFPXZx9M0htaulwu9pPLHwLkMNUZIWiiMGhkhy2fu7NXCSDw++Cgecm7HURreabJ
         rkiYNnT3qXsP5PoTNzD82MqjUy+8ERi0TKCudYx2Jxsce54eICcWfHD+eug7YwuAZ9Z/
         BdWJ/wzBQJ9gFX814DzWE26a4Hw+cdHR1GYN39O+XfIGlmkcEqwKC2BzjJBftY9WBR2D
         +Alh5y5dKUYbsj1zbwx9F3Y4Pjt+wX4dAS24UKldCfv7ZOJCVXH1oBE/HvfQcPe1lSLv
         hVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739898513; x=1740503313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=22DLucK3+Yc7gD+u5BwcgCf4UC4+6P633YUEKabQtVs=;
        b=texliMWlC9ArbhFc91cdL1AF7agQPIi/aueMT/fx0qGKZzWT5cixtNaCZy+cBFShpR
         +UnCp8mNsktXnxGOYFiERsOn0dEMCwLEj46gx5oyoaaNen6uZBp8ejdMCBKtETgswbmJ
         vV3gw1zrTb8RuG6Iu8Zhgm7WWiwrlytOdAv3xiB+reBihiZUhuB046EqbfNcSwmX7Rs+
         QqmYnf3kt3EV4dHJMsiFAY4q/AszEKhNGFATFTavEuLNqVJTzALSlUWn9ahtHN7g2J3e
         nDs3VkqezM6S1KipWjg/qRpTOPsuDYRsIAu7b/9ZhJ4TyFxtcnNXQu7m5mLZLww0kDLK
         lREA==
X-Forwarded-Encrypted: i=1; AJvYcCUUyXLGDvMLzCH5oXPU/RF6rk5s1TU0oKqPsb9fETWZewPnaLoRIJMDMCzPj8M94KiaLUKt09eV64jqj4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTSJ/GLUPiUr4o/7YzbsyM2vPJUMjem1M5pi4ap+s4yUITWtvX
	FnL3qNukeRlgM+V8eSLQLzG9Tq9zDqpQQZIXc8/LCKi5uCKhM8fL
X-Gm-Gg: ASbGncsxgkgokzRoy0cVqazUXJ9KLO5f/cbykCcBJPjQbOJJxy43SGuoeV5E3aZfWcV
	YeoO999SwznnW2BT8LRb4f11hthQRsNDZxkaSEvkLOew7fyv/GIQjUfmagbYfgMygiUeqf0G9Bz
	ycGA3yPvsAjg4CBtRfcmTsfXYHkdqWs3TdFGWYjnWUF9MbECP1hS3sh0/qUsxTvmSIApV6hScVV
	7Y/De3gb41g2hwKczPR4vV9JCLfAL4JzIxsE3sSeuAwkmJRkpZKEGxgnNROwuLD5uxFtrqIsn7F
	ADZx00Fiwke0a0+bGw==
X-Google-Smtp-Source: AGHT+IGiD3HptGQJEipMmcpgiCAIU0akacuYmIdP7lpU6nnc+z3is2VM6M2uT+zI0Es6m92LwRl5VQ==
X-Received: by 2002:a05:600c:4e8c:b0:439:99e6:2ab with SMTP id 5b1f17b1804b1-43999e60444mr3652025e9.28.1739898512471;
        Tue, 18 Feb 2025 09:08:32 -0800 (PST)
Received: from fedora.. ([213.94.27.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439941bd54bsm24680135e9.11.2025.02.18.09.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 09:08:32 -0800 (PST)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 16/16] drm/vkms: Remove completed task from the TODO list
Date: Tue, 18 Feb 2025 18:08:08 +0100
Message-ID: <20250218170808.9507-17-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218170808.9507-1-jose.exposito89@gmail.com>
References: <20250218170808.9507-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the configfs related TODO items from the "Runtime Configuration"
section.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 3068879ce1fc..0a5fcf0b3114 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -225,21 +225,14 @@ Runtime Configuration
 ---------------------
 
 We want to be able to reconfigure vkms instance without having to reload the
-module. Use/Test-cases:
+module through configfs. Use/Test-cases:
 
 - Hotplug/hotremove connectors on the fly (to be able to test DP MST handling
   of compositors).
 
-- Configure planes/crtcs/connectors (we'd need some code to have more than 1 of
-  them first).
-
 - Change output configuration: Plug/unplug screens, change EDID, allow changing
   the refresh rate.
 
-The currently proposed solution is to expose vkms configuration through
-configfs. All existing module options should be supported through configfs
-too.
-
 Writeback support
 -----------------
 
-- 
2.48.1


