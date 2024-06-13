Return-Path: <linux-kernel+bounces-213525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F30B190766A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 17:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B8D1F25442
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615D0149C45;
	Thu, 13 Jun 2024 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKOcT5SD"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF0414A4D0
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718291869; cv=none; b=XBgj1qiRiwhIe9rte+R5aI6241vGopkniYVeAWqm0whohDYeG6UpXJQQWUUtLhpCPVOD36Xvd9nagci4golGZEFB6OsXwnmUPxo/R8nKmUXhfD+GxSSpdTuDuaHWIOy3MMBzL+CdQctHOa26l7QXZfk0KoJjVvH2Yb4mbD0gbqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718291869; c=relaxed/simple;
	bh=A7Z2pNuahnQTHPxYxgbC81iuG8UWkVYNqmAEGoD+kuA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AURdP1Gm0B0QhpTff1uMix+Pc4Y+m6LQzmuWEnPQtOhiAXu+WSEiQj5DDoRxH4DlC6x2luwWfu2PqhJtBuGaDqL2yciyoTYnP4NMHppHXjESm2oI+QFd2fDSXrjTAXcSccwQC7Q77ZISRnBkGLK3Nj6HBSQW6tEH9n5NN9rWW9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKOcT5SD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f1bc2ab37so1123930f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718291866; x=1718896666; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPaCGuMACw1TWMHFIb28HSglVp7CXEoBq/vp9txrrWI=;
        b=iKOcT5SD+Z0MTAR1zsM8qtAwbNYTl0k4RcMf8P0F6bqoeUxfn9aVkI3FiRh4a6e8C+
         YUPiGA4beH1g4zojc/VRa3CMKpjv1Lf9WhozpnKgrK54OgvXa1qRYLUIgnpCQ2xMMao/
         /9L9Lnw7O4HHuXrE6rYijcQPKhFjHFK48mIbhOpD6gL7BIQYEii3BGXb0D7d88v59nLn
         mvMKYJCT3V6Wa+uOPPod6HiFFRLBjdW4LyCqIuqODCPUUPFvCYE/ScmTRq8BeUHdylBA
         nPmb8CabfFADSlT66UzYDHekZHNwhqdnWc6Y8/oCJGB+RZuFrFb0G8VYnHmE8gbkHt+L
         uDUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718291866; x=1718896666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPaCGuMACw1TWMHFIb28HSglVp7CXEoBq/vp9txrrWI=;
        b=v4NrYl05iJP8a8rEfIL3I7D8kQaWayuRzQniIuao5SHPXDJkEn2O0h9jmZzoho1Qc2
         qOrdMLsM/J/HCUBh9MaybirjUhF9EwPpmJD54JhHlgxLWhn9M7BxfIbJnbvC2EJx0vvm
         xzIMLgQCwGHJPH16ZxR3VKWQTWrZHL6fdjH5o0Tm9OaDy3Yx4FuqFN/E3gjOzfSOt2NL
         yQbK8MS7lqXawgnMw8CXMg91z+X1OYTGED0gc+PVcScX+Dt7wPawR3U7rdSUJixWAT3T
         58+0eOrnNLJ4Ig5U0BHxBXVygSu5Oyrr47pWzPYDgAjce7OtSVaW9NcbxSeNC8a9sqQA
         MI/A==
X-Forwarded-Encrypted: i=1; AJvYcCU7pCZQXtbyUEP7TLbtWHKjEHN2nN4uLyXNiSQAOFBmc7JXqmABpaDR7cVwbqJRMMWZsvOIL/86sBZO0d4yfqkJR1maqwqVaQrh33cb
X-Gm-Message-State: AOJu0YwrPXJ8Fw2fDmVSfQBm/UATpFkYQ3dSyYz6vILl1/g6dFDBktLw
	m6nYWr1JSrDodzHKiGa1kSDcFPawoP7FOOvyoe8wC1o+XeKicoR6
X-Google-Smtp-Source: AGHT+IGGAq1T0qklGDhjiu70NrGM6D4AW7xx5q3tlIKfPGCaY0I4BD1ue5u9m+TKfrrNKPRQfT77uA==
X-Received: by 2002:a5d:400a:0:b0:35f:25aa:1b1c with SMTP id ffacd0b85a97d-35fdf79a22fmr4180254f8f.7.1718291866212;
        Thu, 13 Jun 2024 08:17:46 -0700 (PDT)
Received: from localhost.localdomain ([31.120.167.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36076515a80sm1856978f8f.76.2024.06.13.08.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:17:45 -0700 (PDT)
From: Teddy Engel <engel.teddy@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Teddy Engel <engel.teddy@gmail.com>
Subject: [PATCH 6/6] staging: rtl8192e: Remove unnecessary pre-declaration of struct net_device
Date: Thu, 13 Jun 2024 16:16:37 +0100
Message-Id: <5669c01c390e31b1014f96c5b1ddd0272a6f1f8c.1718291024.git.engel.teddy@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1718291024.git.engel.teddy@gmail.com>
References: <cover.1718291024.git.engel.teddy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove pre-declaration of struct.

Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_cam.h | 1 -
 drivers/staging/rtl8192e/rtl8192e/rtl_pci.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
index 615b84bca9b8..3a5635494385 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_cam.h
@@ -11,7 +11,6 @@
 #define _RTL_CAM_H
 
 #include <linux/types.h>
-struct net_device;
 
 void rtl92e_cam_reset(struct net_device *dev);
 void rtl92e_enable_hw_security_config(struct net_device *dev);
diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
index 866e0efbc4fd..c645775b2150 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_pci.h
@@ -13,7 +13,6 @@
 #include <linux/types.h>
 #include <linux/pci.h>
 
-struct net_device;
 bool rtl92e_check_adapter(struct pci_dev *pdev, struct net_device *dev);
 
 #endif
-- 
2.39.2


