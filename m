Return-Path: <linux-kernel+bounces-230888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3177B91835A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 15:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FE131C20B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 13:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3C818410C;
	Wed, 26 Jun 2024 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b="YNQaqc8T"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2AD183066
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 13:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719409964; cv=none; b=o9hcK2n8cMJt01b9LWnskbjGPzVqZXSa+tOwRzqDJbA29BlBMjuN4OtKA1wns8U5DWdpRkgzntAauthvG3N4SfwcXcExg1/X6uShJ1Oqfv/9XlppY1m2xvGGsxG9kTN7O/axv7KHSq4HmUJiPjtFGOFTX7Ro9rPeM11gcpGaYeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719409964; c=relaxed/simple;
	bh=UWuxARd963PTRuc1dV8trvcvv+pfkuk1MtM25GNikLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FMDOEB6QO8Aot7ahnW33Kvp6sSejpCvM6Pcaazmqcj3BLexy63lrxTTZLEqXqessMydU72BwPTJxWH8b1IHAs3VBxuSy817+bihQtMyFBW/THApyzsL8yOE/BnUCNeq0pTx5YkUZ6Kf8aL8HaED56CTyISy6hFwByMu9GllhzdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com; spf=pass smtp.mailfrom=tweaklogic.com; dkim=pass (2048-bit key) header.d=tweaklogic.com header.i=@tweaklogic.com header.b=YNQaqc8T; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tweaklogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tweaklogic.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fa1a542466so5696585ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 06:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tweaklogic.com; s=google; t=1719409961; x=1720014761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iazP3yI5m3l9lJVwFwixRYPwhKO1w0d0YUzUh64kBe8=;
        b=YNQaqc8T8DDdKKoLI2yVfea80LUaKRtLLGee1CXoawbvnIRzxP9s7Rx+h86ybnmbq7
         rSI47vxdW0BrWm1tJB/nNQfgrDTpk7lDN07CqQZoTM69bfspNH9oF9g19dSDO7LbMILt
         YlSrasYme7rZ9LOgamIbNF7ys6E3Ct/+oBOOUk1d/1hjH3S/P766sqbE8Dvv1edYIh1j
         eS8lYn1hWXQtLDW9jf1mChwIn89DhKbvyJObv3Brvac1ZhXrsf8Y70olGhJd0iPPLLHA
         s9z4UURI+CPXY+KXbW1v9frPux6y/cdZ1oVrchlGkKaQ4y1anZMHPxGOaVAr2pFXc9iQ
         eLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719409961; x=1720014761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iazP3yI5m3l9lJVwFwixRYPwhKO1w0d0YUzUh64kBe8=;
        b=DNEUvZ51mPMg0es0Hy/bEC7q6CZAGOxv4CLJoPAeeH4sesj1zoMHqUhM0qRaz9YCnx
         eleModBmw4I6vXIzdu5yh/y0a+bxmXcFGG8aEZS8eG6ixjPIkcXSqxfXTsk9fTvSxRg1
         iqnPFcBlRsBOT5rZbTv5Fu3B/ztX/y1+32jSWovOYwQzcwNs1T2GVuTJS72OWGHRU1zO
         vl5VPtv0DuNRTqmkK7jcfrhJ9BjyBLRb8+gMKTNVB9guSv9scKdMnzf+V1CJqJtQmpIp
         FLLUeOpEpjPBJ83ttaJE+8s9nM9sUYt6HevmHIVfosx92F9I1clIk0wbySrgLHG9+EiT
         HMIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEI09Zsr+Amjam0D/yLTua6CTugk+4Lk703Xg5BPJW8tjQuulGnl7B6Wbx/OLE0GXdVkkUf3QFUpylHSChTen4GNiXYYKwQ7sYQVZG
X-Gm-Message-State: AOJu0YzU1gH/iSQs74k40HtF40ysM+f6yz55Y3LzQNEfz76Si/BvIRd2
	Ig9oNA/qaEqyRc/+Kk2DvN7/Sh0utou/Ji6bNKkWHk0Dg7YdXuze1sMT/fAM87nXZN5z5UKh+0t
	e
X-Google-Smtp-Source: AGHT+IH3CNjIyClXeBhBIYEQod0tmwp3pXAtZsMXPvN3G1ST+U+6N/EhFhUwyDrDXsZEiJ5m4B+KRQ==
X-Received: by 2002:a17:903:22c6:b0:1fa:918e:eac with SMTP id d9443c01a7336-1fa918e0fe8mr20229275ad.35.1719409961073;
        Wed, 26 Jun 2024 06:52:41 -0700 (PDT)
Received: from localhost.localdomain ([180.150.113.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9ebbb2a7csm99231815ad.256.2024.06.26.06.52.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 06:52:40 -0700 (PDT)
From: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add AVAGO APDS9306
Date: Wed, 26 Jun 2024 23:22:31 +0930
Message-Id: <20240626135231.8937-1-subhajit.ghosh@tweaklogic.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer of APDS9306 ambient light sensor driver.

Signed-off-by: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ca8f35dfe03..ebe19ba2d62f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3521,6 +3521,13 @@ F:	include/linux/cfag12864b.h
 F:	include/uapi/linux/map_to_14segment.h
 F:	include/uapi/linux/map_to_7segment.h
 
+AVAGO APDS9306 AMBIENT LIGHT SENSOR DRIVER
+M:	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
+F:	drivers/iio/light/apds9306.c
+
 AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 L:	linux-iio@vger.kernel.org

base-commit: 55027e689933ba2e64f3d245fb1ff185b3e7fc81
-- 
2.34.1


