Return-Path: <linux-kernel+bounces-345079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A322F98B1B8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AA8282057
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677EEC153;
	Tue,  1 Oct 2024 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="xAM1UiF3"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B707A4A28
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 01:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727745396; cv=none; b=mmd77pfJt0fGT8A8PksL3T2hYwAeAVJsGHCG3DUHWAe9RpzJvoeLg/w3mi1KQ7NY81RYOFkofLok2LkihtlOiYBLTGtF2ncnym1onjcfO8UsZHlgzEyaxGTkumbMDZGraIYnjEc9QC7x2jfmwt1FmRMGexcpkjw9fbZvcRgxCb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727745396; c=relaxed/simple;
	bh=Zu6cgo/Xo6ZKx870GI3TUoBzinzwawYyCgh0RUs8DL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g5fPjOuj/Z5lKX3Jv4mabZhoixCIteRbad4DWDlST5WugLTBKOv0fHVeVo8hgmXJWRoYbuYknYc2FAoWNl1nB9L5oLvyRS7nHShWtifwKtuAbuYFVBru7+8oh+ys+2s4ipLiy40myBkR/UmLv+laASiqyWTZ95l3Yjmil/8rirs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np; spf=none smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=xAM1UiF3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=everestkc.com.np
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20ba733b904so7248955ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1727745393; x=1728350193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nbwMiFAr+Z16mU53YheZTsxf4FRwmHNw4rDavq7J5XU=;
        b=xAM1UiF3bdrCAFeaoWv1mQgHcwvCymGU58lgSi1Zg+TJWloc6Ia3Md4W8iEnvfvOiL
         3V9bxc4lq3ioBfJvTF/TKAtXXa0HGnkCMZrB/JUld8K1M+X4x37VnaXbsvEsyQSFbNz5
         y5t2lfIrX9AcHa/ETqxTuH3SdrG3sm3KSIMif4Z1VkHd/A4ZI7Wyl5/0irgPuDEUx2lk
         Ac0gNGlRjVJ/946GB32qh6kB89D6jA+zpZRjdcFriVcqj1l5LDI4X6iHYRefqWYuOYC1
         7h2uSWrIB2i2BJzIrPsHpxmcmZoBtufRHYqbcdVICnsgCIjrVz7bOTnASEY/iVELVJrg
         Vc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727745393; x=1728350193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nbwMiFAr+Z16mU53YheZTsxf4FRwmHNw4rDavq7J5XU=;
        b=VVH7O3qOAILIgA3nL3idblkHagJRyuswWswcLSR712cEiGqqch1fQWXqNZwWuDUasg
         Mer3osE48qf5x880kKZT/GNH5bhmhnm6z7tROGGPaDtiEPUusDKoWUBWsDQzjZG+KXX/
         /Ty3ljxGUCnzmtVnP4+O/K6O+iIs6FBedCkD/CX2BvNhkDvkOqNDxXiq1OVLKNT+SB+V
         1xjwiUpUi1Cn5tfosFT4YzB6ZdSCthHzEBlehzHv/lGuSqJV1/HVRl8Wh6NH5I65Q8X7
         bZLXpW/iCuQmNVKEWTR0qrLIBlsfEiSIekD6wB5o7C/fkMxCFc/0Owrvf79+vOfzvlxu
         Zaag==
X-Forwarded-Encrypted: i=1; AJvYcCWWjDP7Zj/20+jlamza73lqbmDCndx1axgF5jJhpD9IvoSYWEXUnJ4eJ+e6EFFtMqsT50tPoBotSaWTdb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjT6XUbkpeeUXWMBGIY1FBtytuIx5H7dIIX9NNN8Mvd0EZYNKG
	PnZIbm8KMLUpj4yRm9UEJoGKaE23HEAbxbJRz0ixbcM3R/eQQzqYTVb9zyPcaa8=
X-Google-Smtp-Source: AGHT+IHAHjzt4edcj+TAa1QxJwtc9AoYzlGYgtCj4uZZGhnsYdVKDndWfUc1uSZJwqwm96AY9Xla4g==
X-Received: by 2002:a17:902:e74b:b0:202:508c:b598 with SMTP id d9443c01a7336-20b37bcfa36mr234462425ad.59.1727745393080;
        Mon, 30 Sep 2024 18:16:33 -0700 (PDT)
Received: from localhost.localdomain ([132.178.238.28])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20b37d5edc6sm59922495ad.28.2024.09.30.18.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 18:16:32 -0700 (PDT)
From: "Everest K.C." <everestkc@everestkc.com.np>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: "Everest K.C." <everestkc@everestkc.com.np>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (max31827) Fix spelling errors reported by codespell
Date: Mon, 30 Sep 2024 19:15:17 -0600
Message-ID: <20241001011521.80982-1-everestkc@everestkc.com.np>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Below mentioned spelling errors reported by codesepll
were fixed:
	respresents ==> represents
	signifcant ==> significant
	bandwitdh ==> bandwidth

Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
---
 Documentation/hwmon/max31827.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31827.rst
index 9c11a9518c67..6cc5088b26b7 100644
--- a/Documentation/hwmon/max31827.rst
+++ b/Documentation/hwmon/max31827.rst
@@ -136,7 +136,7 @@ PEC Support
 
 When reading a register value, the PEC byte is computed and sent by the chip.
 
-PEC on word data transaction respresents a signifcant increase in bandwitdh
+PEC on word data transaction represents a significant increase in bandwidth
 usage (+33% for both write and reads) in normal conditions.
 
 Since this operation implies there will be an extra delay to each
-- 
2.43.0


