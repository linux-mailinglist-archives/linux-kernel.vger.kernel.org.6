Return-Path: <linux-kernel+bounces-321550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6586A971BEC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9861B25EB1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A281BC9EF;
	Mon,  9 Sep 2024 13:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QfxSyHaS"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3A61BBBF8;
	Mon,  9 Sep 2024 13:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725890227; cv=none; b=DxNzH1pS9et1P41IcHHfB+Nz6y2ML6YmKTbqiegFOavLMOtRLcUulvf/io+doa657ZqoweGxTsmVT0fLNkJ1htjmoHRp0PTUPMl/P2Dyyk9S8AVtlIRnfV3WQ2sBZFURz2pAWcv9gxKL9NU8pXFdon5bLRJdejN3O4L13IUPorY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725890227; c=relaxed/simple;
	bh=K/YF07QvVB4pjMrCY5CC3H2YEBaImarIAH3FFuhYvTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vw0ALKS2excCGxWKlBK84pIM7IQLOOsXBSbspHEWJ/GIsNzmvdmeXsfVJcwB4oy1z+ZrZQFJYiiHe+kpx2qDjv9HXtBrzahrkkGfjjArTE5Fo1k2tuRG16etopu+Kd+O+HsG0ZRTH4NXbnRcoYnbAZq2PQ4CVhfP/w7NCl47Fhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QfxSyHaS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cba6cdf32so5266695e9.1;
        Mon, 09 Sep 2024 06:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725890224; x=1726495024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7+QMbzautmlcHBhreHHmtbMmq5qanob45DDspc/nC+0=;
        b=QfxSyHaSDbP8LWxj3suo0X8xanDyDnQdmj1w41j+9TiCMUxqFRvIwkGsGku1qdinGl
         dk1APH6OmqeATD4P1Jn4DliOAqP3boRiAc03vjQHK7cghA9rTfu1uSym9lOr+YJjOhoO
         w8HZpqM/MOTiWGN7ILXXFGPUHmHGm1hZESiX8wEwU/+7qO4j3B5hThz85qJiCuaVT+3t
         LaXPDoSNTGll1RvcDJ0ZV4/dKjTleNNlDhYTXoUyPYHcbqaRe9fR5FVMqG6kF0f5qCFO
         zo3Rc+bQElqWzTGtyPF+u3WjnRyLcUlhK12x5Q03jgsUQnangQWQ8l8GzlbFzxGWTQoR
         KkOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725890224; x=1726495024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+QMbzautmlcHBhreHHmtbMmq5qanob45DDspc/nC+0=;
        b=WKHqJJ3edkU3aROMDYwrPjD18WWR0b3uAJFYJr3eaXxdckyW0Ku5kdZlYc2eEcq6IG
         sOX5h6UwYkA/2j62tkYe3GtyUGo4FGIHTaTP5KhLLFYxaC61rXZt06kgRE8u4/UbBvj+
         xT60Y9Cnj/wOpAaezsCtOCqLJ1ZDTdLDP3rLvAYibNIhJtwisyUhE2qG1mCMq4L5UlFv
         I6JgCzOjC14tmOGkmp3lskJIa1Eq99f2UE2fR7pyB4NvdUG3wsZsIaJRrkIP2wrGxuss
         wUQXoeL3jZCIHKHdPkendddFxDEk9hOHkd3QUxV7bAM8I+64DU6Xs0+m34as+peZrcW+
         FW0w==
X-Forwarded-Encrypted: i=1; AJvYcCWPk/c+EhpU2k4kEvT8oTzE79gvTX0YFXgAVpB6e/tNNaNJpldwE6UA5bc24tshZKFIrImk4SWsZdsa3nKQGjs=@vger.kernel.org, AJvYcCXix3cHzy+JGPvl9TX0qCZXpo6UZh6zBM7h/X9/Y1k7DPW/VPNhos3KpzicxgZM54JpiNlJ6eo7Vc3dOaHF@vger.kernel.org
X-Gm-Message-State: AOJu0YziT+DP/+ODrjnVe+34rhY9kWtKVm0HKIZfKm6sNSt93G5QwHmp
	BeKVKZ8xSQ4VWa6fgpoH6eAP5R3FTGjX7irVJw4WCrso/50G5ijb
X-Google-Smtp-Source: AGHT+IGNiwsklAcwJsZ31JpPrYhy+/GxiLBGkeOy+QCaF9wlyRktASdo5P3FRt0YHXiCITrSxdhrHg==
X-Received: by 2002:a05:6000:136e:b0:371:8ed6:663f with SMTP id ffacd0b85a97d-3788967492emr7094167f8f.37.1725890223631;
        Mon, 09 Sep 2024 06:57:03 -0700 (PDT)
Received: from void.void ([141.226.14.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956d3743sm6147963f8f.79.2024.09.09.06.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 06:57:03 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] accel/ivpu: Fix a typo
Date: Mon,  9 Sep 2024 16:56:38 +0300
Message-ID: <20240909135655.45938-1-algonell@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Reported-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 drivers/accel/ivpu/vpu_boot_api.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/vpu_boot_api.h b/drivers/accel/ivpu/vpu_boot_api.h
index 82954b91b748..d474bc7b15c0 100644
--- a/drivers/accel/ivpu/vpu_boot_api.h
+++ b/drivers/accel/ivpu/vpu_boot_api.h
@@ -8,7 +8,7 @@
 
 /*
  * =========== FW API version information beginning ================
- *  The bellow values will be used to construct the version info this way:
+ *  The below values will be used to construct the version info this way:
  *  fw_bin_header->api_version[VPU_BOOT_API_VER_ID] = (VPU_BOOT_API_VER_MAJOR << 16) |
  *  VPU_BOOT_API_VER_MINOR;
  *  VPU_BOOT_API_VER_PATCH will be ignored. KMD and compatibility is not affected if this changes
-- 
2.46.0


