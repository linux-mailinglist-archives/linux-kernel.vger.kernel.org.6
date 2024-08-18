Return-Path: <linux-kernel+bounces-291092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A211955D28
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 17:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 498B51C20A7B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Aug 2024 15:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2350713BAE3;
	Sun, 18 Aug 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKVfYHDd"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3FF7D405
	for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 15:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723994822; cv=none; b=UK8XxZXUzHcwYVpcgAgbNM5yLgDoOvYP4ACjidBq8BRU8vG/izKZiTBRHY3tj4cqzhLL8FgdCAI0oXZsI/0aGTuLsivY9/kJpNVTNg1kwyycGp037wN1WcW1sfa0Z6PMNSXgw/woOpXjRclyymff1d2PO53TzozgzAyyV5shGQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723994822; c=relaxed/simple;
	bh=LS8eF8OweOQBSggprqaSIy6dvHsmBgDQg5tvoyMHgPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gMyx71PxdPh9PTd16So2u+oN/OMNTQxlZ78Kn2svvw7UkuRa9FoG0FfeZ3eRCYaGtE3Gyi3aB9Tgu1W6CQBirgC98MYUplYRSM5ji+4DUTyoDHihC7ClKp3eFK/z+fwIcA3Q2N8KbT9g9hmSxuXh9FlMWeB3TvNPSJsK3lzXP2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKVfYHDd; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f149845d81so36642451fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Aug 2024 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723994819; x=1724599619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RHx6D1zKrkAV68zeEgpHIyICDAfmO0Yll8Q2BD72P7o=;
        b=aKVfYHDdXepSas/zUOuxfbhI7auWTP4IErgRg7Brme6wxnPDIhNSDBcBshTrYaqTqL
         UAm2vH0OqBJV80hf5ASVE/xP2IgwmJNdNLUuVZXAXWih9EuGIp56hnQDNoCa5ttnranq
         XrifzNK8ZDHK2ar10I2sNRiMCKy5YD4iYEOLJJ2s6056FWqg3UXItUTxT5jGfFJyg1KX
         IdnUbKH+A2AYYartmLKsz7Y1VMcAIClk03Tg2bGEzWMFRpKOcicx8h+NTxsdmJjg7Lws
         pWGEVEhBEcMS99+R2sY639esaLOsyDho0iehkPRjkilkd1YRvJw7TkOndP6119QbWTJP
         kfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723994819; x=1724599619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHx6D1zKrkAV68zeEgpHIyICDAfmO0Yll8Q2BD72P7o=;
        b=AzPJOHj2zPLwcg2zVCCSpeyCPWnBtsAtN0ZvKAHzlzDTNRkQCsKQW8seuaG5YKaFsJ
         zqXTJMr/2LOQo9wUZDtoUfYE4uSB/1d+pORpRidYo5V6Mria/E93aQ15il5uro0KA9Y5
         L2C/+Jm70rpyEMOhi+oV0E87FieMl8/FTpDcOVT8lHiv7PllysE02PFbejM68L3BxC0Z
         onfMnkoTzKRimoXznRs6w9Au/JuRo+AeUZ4kFsdBZqhEOp9xN0wfEmetOSHqkGQ93PaP
         PHpptDJ6GOTtVqQfde5QiliP5uIWReIl3fc3qxOaNd2ZnvZDc3eDDPf/xGvidwmt6tuk
         kPpg==
X-Forwarded-Encrypted: i=1; AJvYcCXxo1NkYNT/6ih5Zz/zo1tEogby7dOubPlBCDypZQgBctWXW+dbzrEVQbEVELnXSrTP65O0Q68FiiO0SLTwcbQOnNP0uhIoQou8/6Gx
X-Gm-Message-State: AOJu0YxSz28m42zjdFR3kfNeAxju1ycYSZqGNlivwCjHIy9Xul+Ivkgo
	3JqwhkATqAHQ6IXKT7vU96Bj0Wi9K0XwoRVm9TgEu5iQCym50u3qb3l2/w==
X-Google-Smtp-Source: AGHT+IEkeS6ykZk1MjvKLwnRlKxacIaVt3qa2Z7l0SNRPjt79dqhcsjQGzRgvxSG+RaYtiqcOXbOcA==
X-Received: by 2002:a05:6512:3b21:b0:52c:df8c:72cc with SMTP id 2adb3069b0e04-5331c6d98d3mr5226359e87.43.1723994818326;
        Sun, 18 Aug 2024 08:26:58 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396d0cdsm528574766b.219.2024.08.18.08.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 08:26:57 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] mm/kmemleak: Use explicit cast to cast pointer from percpu to generic AS
Date: Sun, 18 Aug 2024 17:26:11 +0200
Message-ID: <20240818152634.17443-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use explicit cast to cast pointer from percpu to generic address space.

The patch will avoid future build errors due to pointer address
space mismatch with enabled strict percpu address space checks.

The patch also fixes following sparse warnings:

kmemleak.c:1063:39: warning: cast removes address space '__percpu' of expression
kmemleak.c:1138:37: warning: cast removes address space '__percpu' of expression

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
v2: Use explicit casts instead of IS_ERR_PCPU().
---
 mm/kmemleak.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 764b08100570..fc2e09ec48f8 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1059,8 +1059,9 @@ void __ref kmemleak_alloc_percpu(const void __percpu *ptr, size_t size,
 	 * Percpu allocations are only scanned and not reported as leaks
 	 * (min_count is set to 0).
 	 */
-	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
-		create_object_percpu((unsigned long)ptr, size, 0, gfp);
+	if (kmemleak_enabled && ptr &&
+	    !IS_ERR((const void *)(__force const unsigned long)ptr))
+		create_object_percpu((__force unsigned long)ptr, size, 0, gfp);
 }
 EXPORT_SYMBOL_GPL(kmemleak_alloc_percpu);
 
@@ -1134,8 +1135,9 @@ void __ref kmemleak_free_percpu(const void __percpu *ptr)
 {
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
-	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
-		delete_object_full((unsigned long)ptr, OBJECT_PERCPU);
+	if (kmemleak_free_enabled && ptr &&
+	    !IS_ERR((const void *)(__force const unsigned long)ptr))
+		delete_object_full((__force unsigned long)ptr, OBJECT_PERCPU);
 }
 EXPORT_SYMBOL_GPL(kmemleak_free_percpu);
 
-- 
2.42.0


