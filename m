Return-Path: <linux-kernel+bounces-300329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DD595E272
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 09:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C6B02827C3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Aug 2024 07:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A7948CCC;
	Sun, 25 Aug 2024 07:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gJQtXvkv"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6807F320C
	for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 07:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724571070; cv=none; b=d87MnUVJRHxyO4DBPIXeud2ojvyq8zWb5IRwQQXDW/pvamUcwZlpBYXIZfDc9zxaeOwyWc3gfE7yxsSEq3Av5UzRGmvXWj6tIFlENgXFMfWaInd87BgElm1EPK4uQFo+x+cKrp66opaVmibOft/QhHeJtdaPz+EJO+W5t1kyAHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724571070; c=relaxed/simple;
	bh=hoNuMWYxkglcTbbg0GqNeZkJrv+ll78JOQKbQTS/5ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rIHb9hsLTiKsfN0B9OBGakS2cC6dcVpkrFqQr6pFvNZpsYjq80p3Vz31HOae5noqiA/z6AbPsi3N7TrXIRaE7cWnR61mg2iABFVR4ogl1Tj14Ow8mIuxjfJR8MK1M849fm8msETs3O3FrJfI2/Sj+A//1O9CLk2nVoUJGWMr2eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gJQtXvkv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7142a30e3bdso3131568b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Aug 2024 00:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724571069; x=1725175869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ts7yizrblkO4nvNk46I7HF9q9zW3lz7Ntet34lL3n2M=;
        b=gJQtXvkvpgdKYk1Aat69Wzh1/LCVPtNmGA08Yv42Xlg958F4rurLeOC3Ow72u+urtC
         Z1jwhDuglI/k02Eq1xVhKn/blkIzCJePChqoUzSD/r80xBt9po8RskZydUmLablky5zd
         RKIQUXYSzsP47oaWfimahveo6vlwmeth77HwW7ZxI5aiYK8rIcxl4Jfd3s5x7MUacryI
         Q9EnaxVdqFSf9VImm2h2CjaIzR1l+GYZCadDpc1LLLvFMV6yyX4lLmaG+RmLq81xGN7H
         z/rW2EmiK17ci4mkYDESTfs99rACEgsWqACPvVsmzKjSGygrnHyL/wPZPSRxYEkTO8mN
         V0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724571069; x=1725175869;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ts7yizrblkO4nvNk46I7HF9q9zW3lz7Ntet34lL3n2M=;
        b=XKEm+SoNWImA/2ZfEwNkqjl5x2VaD5rVxxCARucSegKdn+5iBXOxQyNhSuv1zTHG15
         8bCeGYaqDap5bRE1iqJTt67TNMC4/tEQgN+/OGbzNrRBLCLgCm6kqCwVQqzjkuF/i+I+
         rlTe1LYCu1YqxT2hRE4FvTAhlOnA7iAuoFShfQprNdTqetmqauZebh7aKQbCr3mfqEp3
         N76mJ4TfaFH6seGJipXb9em3TybGuooM/7f7MbwTw4k8t57anQT3JuHG7Epl8S3v7AQ4
         JG6Z7lJQCHt7uFJj84LGcQPiz5y2Dvtixm9s2qdyILLRmvxVwSoI0uRGGi2whPEmXaSY
         70tA==
X-Gm-Message-State: AOJu0YwR3CywSQyndTWLszEqDaZtv35o+1sTocxbHjDwwMvNBdylNMxX
	Walw4usffiQofeIWqENo1a5c4JcjaM6KX+GkLVsqJVRQ+mf/eX8l
X-Google-Smtp-Source: AGHT+IH7lU3KoQ/SeTlBO6d1KhFa8NQOHP+IDt/nph6Xawu52Eo9pLZ7BB6ZhUz7C4miDDYBfynzAA==
X-Received: by 2002:a05:6a21:4d81:b0:1c4:85a2:9958 with SMTP id adf61e73a8af0-1cc8a0804bamr11150477637.25.1724571068314;
        Sun, 25 Aug 2024 00:31:08 -0700 (PDT)
Received: from fedora.. ([122.180.191.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-714351aee05sm5386041b3a.91.2024.08.25.00.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 00:31:07 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH] staging: vme_user: Change slot number type from int to u32
Date: Sun, 25 Aug 2024 12:59:55 +0530
Message-ID: <20240825072955.120884-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change the type used for VME slot numbers from int to u32 throughout vme
driver. This modification more accurately represents the nature of slot
numbers which are always non-negative.

The changes include
- Updating variable declarations
- Modifying function signatures and return types

This change imporves type safety, prevents potential issues with sign conversion.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
 drivers/staging/vme_user/vme.c        | 2 +-
 drivers/staging/vme_user/vme.h        | 4 ++--
 drivers/staging/vme_user/vme_bridge.h | 2 +-
 drivers/staging/vme_user/vme_fake.c   | 2 +-
 drivers/staging/vme_user/vme_tsi148.c | 4 ++--
 drivers/staging/vme_user/vme_user.c   | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 42304c9f83a2..aa3be2d7248d 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -1696,7 +1696,7 @@ EXPORT_SYMBOL(vme_lm_free);
  *         or the function is not supported. Hardware specific errors may also
  *         be returned.
  */
-int vme_slot_num(struct vme_dev *vdev)
+u32 vme_slot_num(struct vme_dev *vdev)
 {
 	struct vme_bridge *bridge;
 
diff --git a/drivers/staging/vme_user/vme.h b/drivers/staging/vme_user/vme.h
index 7753e736f9fd..66388767b6c7 100644
--- a/drivers/staging/vme_user/vme.h
+++ b/drivers/staging/vme_user/vme.h
@@ -102,7 +102,7 @@ extern const struct bus_type vme_bus_type;
  * @bridge_list: List of devices (per bridge)
  */
 struct vme_dev {
-	int num;
+	u32 num;
 	struct vme_bridge *bridge;
 	struct device dev;
 	struct list_head drv_list;
@@ -179,7 +179,7 @@ int vme_lm_attach(struct vme_resource *, int, void (*callback)(void *), void *);
 int vme_lm_detach(struct vme_resource *, int);
 void vme_lm_free(struct vme_resource *);
 
-int vme_slot_num(struct vme_dev *);
+u32 vme_slot_num(struct vme_dev *);
 int vme_bus_num(struct vme_dev *);
 
 int vme_register_driver(struct vme_driver *, unsigned int);
diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
index 9bdc41bb6602..6778447eadfb 100644
--- a/drivers/staging/vme_user/vme_bridge.h
+++ b/drivers/staging/vme_user/vme_bridge.h
@@ -160,7 +160,7 @@ struct vme_bridge {
 	int (*lm_detach)(struct vme_lm_resource *, int);
 
 	/* CR/CSR space functions */
-	int (*slot_get)(struct vme_bridge *);
+	u32 (*slot_get)(struct vme_bridge *);
 
 	/* Bridge parent interface */
 	void *(*alloc_consistent)(struct device *dev, size_t size, dma_addr_t *dma);
diff --git a/drivers/staging/vme_user/vme_fake.c b/drivers/staging/vme_user/vme_fake.c
index 7f84d1c86f29..81601bfa4155 100644
--- a/drivers/staging/vme_user/vme_fake.c
+++ b/drivers/staging/vme_user/vme_fake.c
@@ -987,7 +987,7 @@ static int fake_lm_detach(struct vme_lm_resource *lm, int monitor)
 /*
  * Determine Geographical Addressing
  */
-static int fake_slot_get(struct vme_bridge *fake_bridge)
+static u32 fake_slot_get(struct vme_bridge *fake_bridge)
 {
 	return geoid;
 }
diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index d81be8e4ceba..65237fb12466 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2109,7 +2109,7 @@ static int tsi148_lm_detach(struct vme_lm_resource *lm, int monitor)
 /*
  * Determine Geographical Addressing
  */
-static int tsi148_slot_get(struct vme_bridge *tsi148_bridge)
+static u32 tsi148_slot_get(struct vme_bridge *tsi148_bridge)
 {
 	u32 slot = 0;
 	struct tsi148_driver *bridge;
@@ -2123,7 +2123,7 @@ static int tsi148_slot_get(struct vme_bridge *tsi148_bridge)
 		slot = geoid;
 	}
 
-	return (int)slot;
+	return slot;
 }
 
 static void *tsi148_alloc_consistent(struct device *parent, size_t size,
diff --git a/drivers/staging/vme_user/vme_user.c b/drivers/staging/vme_user/vme_user.c
index 5829a4141561..63f8efc19324 100644
--- a/drivers/staging/vme_user/vme_user.c
+++ b/drivers/staging/vme_user/vme_user.c
@@ -506,7 +506,7 @@ static int vme_user_match(struct vme_dev *vdev)
 	int i;
 
 	int cur_bus = vme_bus_num(vdev);
-	int cur_slot = vme_slot_num(vdev);
+	u32 cur_slot = vme_slot_num(vdev);
 
 	for (i = 0; i < bus_num; i++)
 		if ((cur_bus == bus[i]) && (cur_slot == vdev->num))
-- 
2.46.0


