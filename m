Return-Path: <linux-kernel+bounces-263219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3D293D2D4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F671F21A66
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5EE17B42C;
	Fri, 26 Jul 2024 12:09:41 +0000 (UTC)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29A8A3D;
	Fri, 26 Jul 2024 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721995780; cv=none; b=nwpyqKIRyfgVVsGF8N5Osgblez4OG7+rBjr3m21yYR5imqDcfNx0yztufMGONTFi/TL4TLF7i5gZ3dAD6HYBEglKpTJ3IOCZRGBzfWf9tm4wTEhN2bTXvLS5O2yYbtvA5gM+SvIzRHfQrs0EEp98tQdmjla994gSGJVxyG9/nAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721995780; c=relaxed/simple;
	bh=bnda64iSGU0m6KI9KDID0lLqIBqN6jiSVGUS9ihm/JI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=feeerBUz57s9ZIaZfVKh19WTDpQ6kcOq4zJsaCq1LxNLeszrKwpI2K1sR0hBwWEBBAaRSGjugKPj3sqMIjQIyzBYhmxmkZVqknCWmocKyxwQS9E9t58pQPEaA5EFnvY6TQoXOMc5eBjgnBv8Kh2Vt61NyU5jDAnmLLJDPPVGxHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ef2c56da6cso12774091fa.1;
        Fri, 26 Jul 2024 05:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721995777; x=1722600577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6MGhkO10DAFXXxWz/b8Cy8KqtLa3ot91CZL6+UeC3sM=;
        b=j34lwHha6bTZ4sQe9xhDbWo07coJ5SmYsb6HJj963ZhECaNDGw4CwI3I2tHIAXdWaS
         VQ4DjUMGBH7h+p1vpP5ivX+Tv7N4UQfIhA180L4vOSPzhP0R/l4650Vm6gc5ukL6PIRP
         ikBLeylESNRNojEfoYDxyidmuwasWVzb3a3uNj/ZHdg7qiVkpLisoW1VdHttQR/jdLmS
         gZ3vGNRAcnnhLxHco+jhKGCfOdmUt5f0JWDqRkUf1lMOxdG3yeybvONwUBqORgZ0+iAz
         +rAiG4dMX5zMxKb7fPjTzdcj/Y8LBWCT7Ne5d7Q8/LqNoioFupRtzY52jzrMAYPVzLLw
         8jiw==
X-Forwarded-Encrypted: i=1; AJvYcCWAJ8w+NSiIM2iCaWF7fuyhXj9hpiqB+2XP9vUJxZA50GArD8YZbe00AcxPG07mIUDkX+EvEn0Ssi6O/lzUTOX9o+Zfq58kdKSSweiLhhNieyaU9OVVE2/4cv3EcK2Jl7hvldWO++32
X-Gm-Message-State: AOJu0YyjO7FhQfYigVOXdYedSn2KtGop0UNLSV9sbhAAwknsRiTnbcVG
	YjQuL0ok34SF2xcDd9VeUTcgi1sNQCovSxOvpkTSSTEHkFE6RJGn
X-Google-Smtp-Source: AGHT+IFjWITrc1duUxyZEVURki42n1i/s79zMtzH8JRb44wpFw+niqIwLT/ZeSzb4wAjOgCN3Wwgzg==
X-Received: by 2002:ac2:4ece:0:b0:52e:9beb:a2e2 with SMTP id 2adb3069b0e04-52fd602a7c3mr2704369e87.19.1721995776593;
        Fri, 26 Jul 2024 05:09:36 -0700 (PDT)
Received: from localhost (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b038asm1857206a12.14.2024.07.26.05.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 05:09:36 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: Akinobu Mita <akinobu.mita@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: kuba@kernel.org,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] docs: fault-injection: document cache-filter feature for failslab
Date: Fri, 26 Jul 2024 05:09:30 -0700
Message-ID: <20240726120930.3231333-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The failslab fault injection mechanism has an undocumented capability
that provides significant utility in testing and debugging. This feature,
introduced in commit 4c13dd3b48fcb ("failslab: add ability to filter slab
caches"), allows for targeted error injection into specific slab caches.

However, it was inadvertently left undocumented at the time of its
implementation.

Add documentation for the cache-filter feature in the failslab mode
description. Also, providing a practical example demonstrating how to
use cache-filter to inject failures specifically when allocating socket
buffers (skbs).

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 .../fault-injection/fault-injection.rst       | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/fault-injection/fault-injection.rst b/Documentation/fault-injection/fault-injection.rst
index 70380a2a01b4..07c24710bd21 100644
--- a/Documentation/fault-injection/fault-injection.rst
+++ b/Documentation/fault-injection/fault-injection.rst
@@ -141,6 +141,14 @@ configuration of fault-injection capabilities.
 	default is 'Y', setting it to 'N' will also inject failures into
 	highmem/user allocations (__GFP_HIGHMEM allocations).
 
+- /sys/kernel/debug/failslab/cache-filter
+	Format: { 'Y' | 'N' }
+
+        default is 'N', setting it to 'Y' will only inject failures when
+        objects are requests from certain caches.
+
+        Select the cache by writing '1' to /sys/kernel/slab/<cache>/failslab:
+
 - /sys/kernel/debug/failslab/ignore-gfp-wait:
 - /sys/kernel/debug/fail_page_alloc/ignore-gfp-wait:
 
@@ -459,6 +467,18 @@ Application Examples
     losetup -d $DEVICE
     rm testfile.img
 
+------------------------------------------------------------------------------
+
+- Inject only skbuff allocation failures ::
+
+    # mark skbuff_head_cache as faulty
+    echo 1 > /sys/kernel/slab/skbuff_head_cache/failslab
+    # Turn on cache filter (off by default)
+    echo 1 > /sys/kernel/debug/failslab/cache-filter
+    # Turn on fault injection
+    echo 1 > /sys/kernel/debug/failslab/times
+    echo 1 > /sys/kernel/debug/failslab/probability
+
 
 Tool to run command with failslab or fail_page_alloc
 ----------------------------------------------------
-- 
2.43.0


