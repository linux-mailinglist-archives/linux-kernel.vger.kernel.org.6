Return-Path: <linux-kernel+bounces-332403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E2D97B94D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FA22832A9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08365172BD8;
	Wed, 18 Sep 2024 08:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="jZqo8LkY"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546B2233A
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726647821; cv=none; b=Ceh61+4UMI0pvRaDNtCPoFa/tdyEw2cI13QsSPSxEgYVsrwLOJm8FpxUQ35ncrXACUBhrvODll88kmhMXEcsZPp4FOUcGTlp+kSTlCS8tLW3oOOy81f3YUPrq+1Z2tt/GyLhF3k2u5ZoVwvW5MCoS/X4KphOxcTf8rSibu6YhXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726647821; c=relaxed/simple;
	bh=/5IEvTBleS798AvFcvG7Ej9WDr2fyFzyFv8KBzmwEGU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ioqkZSAR4hBdoOpDL+WtVD0oYEiOGh3dkrS5/nNQ5aYVI+dDOsp0SOfWmi9vvaWc3KV1yCKpfVEQhPNxxQS6isdnIbK+ZWtbzr81RUMIpdyGyHkw/O9hcHRynx5nN5S/PieAeM84rx14rNVCyoUJHakjXppkhuMv1JXiL84p/UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=jZqo8LkY; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2053525bd90so48798595ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 01:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1726647818; x=1727252618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cj7vh/y2frqTNpX+KgUh7EaoShQEplhQ97z3yW6WbXM=;
        b=jZqo8LkYBpO6aNJdwLxiFvR/5bhL+fYQEG1/DB9HTnOcUXscP+D0ZZ+Aio259LVw2p
         l8j8Ypi85FTJ6VG18+xND+z+in+omzrCxHchBsSWJKOU76+rHct331jfx6RrLkwuGOqu
         vhBL5rGCqVcWDKvNxnBBsxbzuCzOCzW/Yy9C40Sz7iMGydRYQZ7kGuh+1wyCVeKuZW41
         nXHOPW91JbKCi5sManJUtOgfGBK/KJzjt4OOAjP2DxGX7HPmWXe0PKWLqH0Ne8ZBn6YE
         oe6zyEnHH0xWqDFOe5eG2FBoIuVX/a8+Kjm0SDIzjfia1R+o5wwpgg6kbv3NUedS3/Sr
         rkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726647818; x=1727252618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cj7vh/y2frqTNpX+KgUh7EaoShQEplhQ97z3yW6WbXM=;
        b=HXQGvVjb+/uuIQL0l9VT1jSwLBfPyDlxmjCeKuFAZ3B7vY6dVTp5dkY0zguY1ib61G
         mlF8vrKc2CHISR0qS42tqUydh9rvaUhSbJrC7iahL9xTPgFteLNPEZ1rNENv19zrtuYK
         aQlQYsj0efcz1Pe7tQKxNuPmgpXT971o+hBx0MXuS6kSRyot7iTSr4PLG+gNwgyrFcaG
         pbcc0etp5R7EgzwWbIrwovCe6al1E0eLwL+wVO3GIoYfRrCyLWApcEebJME7NQw0dIg6
         CWb6pim959Kc0oTV/md9o1izZmK+QTp37caKmSDA6MppsAeQi8uNko6yyD29osg4IqGx
         sZDA==
X-Forwarded-Encrypted: i=1; AJvYcCWsVlzWtVUs3U85DMgbY8Q6fFLh9tXE53MRnyZoZTfKt/58xH8GEYf2hjydfXby5pFU7r8N5ma2Po7+O9E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjTbDpY2nqZcywcEAXfV2pij5WIXmJrTtnPHfhW33YMyNeySxR
	rX9Eq7SdYz2gNjlgLuKnwbyO6vHNKR4O8ZQ1301SZdoCwrsin2G1FU+5t/3U5Tk=
X-Google-Smtp-Source: AGHT+IFaAkemKhufsn5sv7mN7nbCZYrjjcBHtJybEdesp7vxkC4JwTzE7RKsrSsGTBsVs3JkFcM0mQ==
X-Received: by 2002:a17:902:e852:b0:203:a14d:ed0 with SMTP id d9443c01a7336-20781b42d61mr325351095ad.11.1726647817574;
        Wed, 18 Sep 2024 01:23:37 -0700 (PDT)
Received: from localhost.localdomain ([132.178.238.28])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-207946d2a86sm60680715ad.171.2024.09.18.01.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 01:23:37 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: hdegoede@redhat.com,
	mchehab@kernel.org,
	sakari.ailus@linux.intel.com
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: atomisp: hmm_bo: Fix spelling errors in hmm_bo.h
Date: Wed, 18 Sep 2024 02:21:11 -0600
Message-ID: <20240918082203.4941-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed spelling errors reported by codespell in
drivers/staging/media/atomisp/include/hmm/hmm_bo.h
as follows:
        increse --> increase
	decrese --> decrease

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 drivers/staging/media/atomisp/include/hmm/hmm_bo.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/include/hmm/hmm_bo.h b/drivers/staging/media/atomisp/include/hmm/hmm_bo.h
index b4c03e0ca9c0..6d3c74156345 100644
--- a/drivers/staging/media/atomisp/include/hmm/hmm_bo.h
+++ b/drivers/staging/media/atomisp/include/hmm/hmm_bo.h
@@ -159,12 +159,12 @@ void hmm_bo_device_exit(struct hmm_bo_device *bdev);
 int hmm_bo_device_inited(struct hmm_bo_device *bdev);
 
 /*
- * increse buffer object reference.
+ * increase buffer object reference.
  */
 void hmm_bo_ref(struct hmm_buffer_object *bo);
 
 /*
- * decrese buffer object reference. if reference reaches 0,
+ * decrease buffer object reference. if reference reaches 0,
  * release function of the buffer object will be called.
  *
  * this call is also used to release hmm_buffer_object or its
-- 
2.43.0


