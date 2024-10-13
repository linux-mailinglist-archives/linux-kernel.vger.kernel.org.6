Return-Path: <linux-kernel+bounces-362831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 875F099B9B6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 16:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E3D4B21278
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Oct 2024 14:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FD9145B22;
	Sun, 13 Oct 2024 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RG1IJ424"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD1713B5AF;
	Sun, 13 Oct 2024 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728829521; cv=none; b=Xut2rEJySsEm+tGyU17rDipnZyN3nwXvj4O+2GoQd9cYzF+ptLN1dwPZeeGwH/MxW4Kjy1RS2oNgbGWSnlUnwXJEewJ+JqlApRbPdWcD3lYm8qHgVIjU6mPhN7uWWVLPz8yxuv+bNrA45FXunbPUmC3STigfbfjmXNHOwIn/Kvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728829521; c=relaxed/simple;
	bh=jMPj2QKOfEDbQLxjjZXHfPkOYmbyJE9CFwFNUtvx/KM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I5okoKieCGmKHh7uy6XGsOZjHRGYvrG9br//3Xcd20aOObeJgGk6S4gAZUwD3r2EthNC70X/ksFvXX6Yi5CQ0l6Mf/J4Cwz+Mv/Ht9MLmLpwa4v8ZGFWxtf+iYLMvGUm1y93OPIStOYyFJFYcV0Q4YqRaKgrvpAW+nwaZtfIL0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RG1IJ424; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20c7edf2872so26175375ad.1;
        Sun, 13 Oct 2024 07:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728829520; x=1729434320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5qBaw6WcetARAK786CwFtGAjmur6yWCok1z7OMhs38g=;
        b=RG1IJ424AG+GRLcT4yGo5x9bRZqna0LSksSLmTJBopRT2lPsHnoK8eZZcNxGlBDeL4
         pK6JZmKowzSCC26c1qfd8XKM4JkSppJjRXyNxebZT+uPcsvkRnaeTFe/NxCp4CXzpdWr
         uQcO8VP4bOVmddKsPer7FzI+yfF4jeXhHvwVWA3d0uG+5lZTWjzKTDRg6sO728DKQIjb
         c/5YYVS/KKmQ/AAZpbfvzB6NKu8SPfmN6nBlgDB2Acc35v7TnsC1MVBYDrKkIpvwkp3w
         tWeTaZ3eFs5q/vqqE5Z4aKX3hJykGxuY8Q8KH3xOiKITXNa71xAJ99M7i+U4SNStlcmB
         FGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728829520; x=1729434320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5qBaw6WcetARAK786CwFtGAjmur6yWCok1z7OMhs38g=;
        b=jiyUgcpDb2MOT/m/ec7iKls5CFZbmV1sTqQlcq9hXtoCgM/vZ4ftJbgoGHgGUjmDk5
         16P2jAe6s9oxE9jljZhKT84pPg4nSKmI2NlCykg1hmAwskVkwEkFuHmofM9Dq3637Rm+
         NfSumdHpirwECrcQMBr5P2W/4mdTmtVGd4+aubFUR+Uf0zUOWaU/h3xIbfjeBjl3UKp7
         qE++SKZOb4/qVZ8PjaPFH5tZXCbcJ2wSrFA09Nz4G4Qz5EEWdBKMCYQUe42UEzKordb0
         4XnbQtC5hlwsvj/B8dAEMQ0dSuhMCc8PVWI3KS2OtnBe4W9JgxUCbxfCF301CW6lTvgS
         i6wg==
X-Forwarded-Encrypted: i=1; AJvYcCU0M39RNNuSagPUBVY0eJcLrD1we5rMi6bBUV/UYavpmzqskmJVIjJ6m9gPTL+l3lA0lKNAoH5KiGOeTGo=@vger.kernel.org, AJvYcCV7stUGnkmAg86TyEmIycxXOqCxcF62IwFCaSvEI/07OA9vSrmy15viWvlFwEnuyCeP/nz7/vU6w8JG@vger.kernel.org
X-Gm-Message-State: AOJu0YyHL8JyKQQvIaWNd7Lgxit3+9N3TW3IJsZO89JLLulRbLqi5EnG
	KYsBcx8Qn1/9B4sc+30tCsscFvaLLXu3WpbLyyuIIR1MzTkSaSF9
X-Google-Smtp-Source: AGHT+IE8oOFbATlhJ4vqkaMSGeyjZrtaqiRX69LpT6qy6t2Tpr3Icc6I4joA6l0T8gsW+SLawQvoEg==
X-Received: by 2002:a17:902:f686:b0:20c:68af:a4e3 with SMTP id d9443c01a7336-20ca03d67dfmr136140215ad.22.1728829519569;
        Sun, 13 Oct 2024 07:25:19 -0700 (PDT)
Received: from embed-PC.. ([2401:4900:1c26:6cc5:3690:fda3:d7c5:f949])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c0eb44dsm50244985ad.148.2024.10.13.07.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 07:25:19 -0700 (PDT)
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Frank.Li@nxp.com,
	m.grzeschik@pengutronix.de,
	dan.scally@ideasonboard.com,
	andrzej.p@collabora.com,
	quic_jjohnson@quicinc.com,
	shuzhenwang@google.com,
	arakesh@google.com,
	skhan@linuxfoundation.org,
	rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: gadget: uvc: Remove extra semicolon from the macro
Date: Sun, 13 Oct 2024 19:55:11 +0530
Message-Id: <20241013142511.9946-1-abhishektamboli9@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the extra semicolon after the
do {} while (0) in UVC_COPY_DESCRIPTOR macro.

Fix the following checkpatch.pl warning

WARNING: do {} while (0) macros should not be semicolon terminated
+#define UVC_COPY_DESCRIPTOR(mem, dst, desc) \
+	do { \
+		memcpy(mem, desc, (desc)->bLength); \
+		*(dst)++ = mem; \
+		mem += (desc)->bLength; \
+	} while (0);

Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
---
 drivers/usb/gadget/function/f_uvc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 40187b7112e7..edf0355d712c 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -465,7 +465,7 @@ uvc_register_video(struct uvc_device *uvc)
 		memcpy(mem, desc, (desc)->bLength); \
 		*(dst)++ = mem; \
 		mem += (desc)->bLength; \
-	} while (0);
+	} while (0)

 #define UVC_COPY_DESCRIPTORS(mem, dst, src) \
 	do { \
--
2.34.1


