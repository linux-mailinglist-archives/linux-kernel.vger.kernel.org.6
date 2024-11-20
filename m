Return-Path: <linux-kernel+bounces-415213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E09769D32F9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 05:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763B91F23ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 04:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4572B15622E;
	Wed, 20 Nov 2024 04:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhvZfUIB"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B161494DF
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 04:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732078016; cv=none; b=WN7y/fTo5moe+Rb3yId5M9f927i+njiKFBycpU5XrEK+pNw/Yx3XTmxpRltHeJN6R2Gus34ja30l9wxvPJAuztqXf+4uZmmT/qlMFcVOjhov5A0+VtXcdbnSlssGoZNV9CeSgJpg6r/edRRo3TWYxBhLEkvqLrJsgKXJv+TRz5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732078016; c=relaxed/simple;
	bh=dtQwPq7EMRakBqVzEuPHlfLpKnCjPrJfLK1X90u0Eyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mcc4c9qIGoJuYy6eOCFKFplFr5iQ/ATHSTMm+Wm/hnXQwqESx2D+hsSbeAJB44IBteYs4suEP04t9x8q0TdZL3bvNUSirxCYiCyPSaYNHxBKNhPcZhDVfkow/Y4OvzJdRbjnwFN6iazOZd9VO/1c4Uh1W+3al2XSuoaPnRopvGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhvZfUIB; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7f8c7ca7f3cso3927889a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732078014; x=1732682814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5onQwIhmjkcNfQKy+hiSaETiCPradWTZcUAdilgGxTQ=;
        b=XhvZfUIBPvtZmqHQexzStqnlZnI4anrrJHnRijQLJHZ0ttjkXH63E7mJLT2yUBLD3d
         KuPBmj2+6gj2lv9u//eNuWo+c4yLq/jGFlxtZfyGdAvvEOa5xXhWkqEEEkTS3OyArYhv
         MdN4m3bM6n5IjhDUMXKUYwa/sWaCq9TpSjzmoP+Lt998tWFVqffSgZ2f8M7+L6ZCtJTR
         V0lH0MzklKjSAnaJk2TD/iWcN5lqEKcR5fNT6SW4RGuecW9JDq+gbWlRFV17FzDtw5ef
         owvh9NNgDRzSr3hlNwsMFTmHjMw0Tye8Fu8WxDdB2NihwUctaZ28vlPu3S9pBZXo5891
         l8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732078014; x=1732682814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5onQwIhmjkcNfQKy+hiSaETiCPradWTZcUAdilgGxTQ=;
        b=gGC3jl0INep5hER6O8rKTbqipVp0pL85P7zsSflokxp7y3sfZHXYbjaMJQuwtrrFgf
         bOQAXMQRI+dbNalO/+wNu3Fv8HKwYHV0DIDBjzcGoXlPxSSFoixGPLYyv7DXIMKipBKl
         skpWuKGfitcnUSaN9TjjxMS/tm0Z7IyxPNlJO7gpt3lvav3S6URdxY5xc8IYRC6Ow3R+
         hby1nvl2Exsl5qRRWl9pujSRCHL0AZmwPzUmojJ8zj71xNDQGrwIGA37MFEBQneB/RxM
         VkZqA3jptb+XdPndmp4rYCi9VUhTjMLNyMEEGBEoEddlCFVlxObMELdM4lEmIablb14m
         99TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU16L7b7IOIDYDz/4+U/KltiuaqOfZ3ybh23oKNql0ucCakgksW0HBk9bGhVaHB5PIGPNw2VTj29J96w/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyfwn7rLoZXpkNXyrnvChT5wsQySy9yP2OerPZv0XDI/F2sFV/U
	Ol0bDfMjz/aRi5Z4+tznHFMbCHEmxzXFO413cssSiUZPUwMidQuM
X-Google-Smtp-Source: AGHT+IHGDwWzUqRuzBRThH89VZ4tUNwTi0GUWsE1QUrp7jgjkbrXmG5/4QZ3cEnWhCMsiUXPj88Q8A==
X-Received: by 2002:a05:6a21:6d87:b0:1d9:25d4:e8b1 with SMTP id adf61e73a8af0-1ddaebd99f3mr2250797637.25.1732078014489;
        Tue, 19 Nov 2024 20:46:54 -0800 (PST)
Received: from localhost.localdomain ([175.112.156.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724beeb833fsm621712b3a.23.2024.11.19.20.46.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Nov 2024 20:46:54 -0800 (PST)
From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
X-Google-Original-From: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Kconfig: remove duplicate word
Date: Wed, 20 Nov 2024 13:46:44 +0900
Message-ID: <20241120044646.6335-1-RuffaloLavoisier@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Remove duplicate word, 'the'.
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 202397be76d8..289368a39727 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1501,7 +1501,7 @@ config ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND
 	bool "Extend with bootloader kernel arguments"
 	help
 	  The command-line arguments provided by the boot loader will be
-	  appended to the the device tree bootargs property.
+	  appended to the device tree bootargs property.
 
 endchoice
 
@@ -1643,7 +1643,7 @@ config DMI
 	  continue to boot on existing non-UEFI platforms.
 
 	  NOTE: This does *NOT* enable or encourage the use of DMI quirks,
-	  i.e., the the practice of identifying the platform via DMI to
+	  i.e., the practice of identifying the platform via DMI to
 	  decide whether certain workarounds for buggy hardware and/or
 	  firmware need to be enabled. This would require the DMI subsystem
 	  to be enabled much earlier than we do on ARM, which is non-trivial.
-- 
2.46.1


