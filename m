Return-Path: <linux-kernel+bounces-415215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 523FC9D32FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 05:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FACDB229AE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 04:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7D6156649;
	Wed, 20 Nov 2024 04:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xp1pGaWV"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1529115098B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2024 04:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732078134; cv=none; b=H+lGTouTtuyWQuuYbaS50+tKx/fyiXIa+QG2NvcyoUMoTHQWcCyf4w/4PqQcq867rclUJqBuP6RQMKwLfeBeNpR+yUpmYSM/32dNllJgtkUrpA6Gn5fEuTTSzDZQvXsyZ4Kjh8CHpy/Ie/MrEHzzjmIFh3eoFJhz/0AMd9BC7Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732078134; c=relaxed/simple;
	bh=kq6/Br8lHOxRr9BSYYVYZA7aLKDcB2iAf+uWmLP7DyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDAEBB4U+iiteIR4xEGgplUQExBycseng/QbOehsbMtjRRTc37C/pZdGlGsaVHj9MeCxexu3q0IPRO2iZHbiLGzYAm2clXSmy8Sxtdxi8OcrTETJChY+EOV6mlWLiHOzvuUKat8UgnIDFZdTVzVFnx9Jno5xVcfH+fO26jFHdWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xp1pGaWV; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7f71f2b1370so4565921a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 20:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732078132; x=1732682932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zvTYpT8q1jc8sS0GImfUQ096d0hfXDGsD5wyPCtbq1k=;
        b=Xp1pGaWV9K/GsKJ56bisbGCfm2OdWNOv3sXp0JYL1EpLWQJBNN5nhe+mysHDib+hzy
         Vxqm11Muu4sl0DVyZgqxR45qdE3CyUMC3vfmIyGtXJ+eYM2A/RorV54pR5w3yMXK9m7U
         FZDY7Y3bnzKSYgeUem6M4TtcG/q5t6lsAne3d1dy0QVxa6vzaJgCDwprVFv1sI1/eHgp
         gscdsZQKv3PHw/9zCAofyvqM7X7nChUnzILlZ0naart99I018jxw5L+fkUhXTCOhfqqH
         6hYJw5F8Z+vQG2/36nJbbTcIKjvqUqVJzI346c2Vv5NutNl3tqbHod4Xpxt2rcIlU6Cl
         56sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732078132; x=1732682932;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zvTYpT8q1jc8sS0GImfUQ096d0hfXDGsD5wyPCtbq1k=;
        b=KPd29R85kitgKhGWxrg8sXCo2dPtAUsTDL6tfr6v74x/7SBUAmuLKWp69/iHYxN10r
         FjOhMchHfYlwU24usb1KhGGWZNbXeQS/BMZuA3uhXz07cwsSnBGjWcPftzsHofoSVIdV
         OA9UOwApVzWvD6moRROVu2d/S+zYtsWSObOQlFjvbWwQVsdiFjHnjnhfK494WMr4GPI4
         5gBYAKFve4csAYHSs6ioYhddq5xXzTFfDGKw7BwjmdgxM8OYOYdS+xAINpcScpji8nY9
         Kyb1s1RN73iGI7KlivS+/FlTZaW2CIBP+fbtflFjZs45/6es4ffkkMZigwYNF6HYgQSh
         BaDg==
X-Forwarded-Encrypted: i=1; AJvYcCU5cjvTjiFa0141YrrLVTWJ2YU4xZ9wZwDf1TQ80bsfUZH+TnR9Rbyv+WAf39COYk8+kPDzqtffRD2tIbE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3H8gHhiJNBHv7vcOkm4dAYXIMvAgzFpL7VZGiDjsvo3b7QzzG
	IQFtHiBoSgnTAciy+msf18ABKNZeBslPbutTo3kZL/1ZqadXEhZqsPM8+v/V
X-Google-Smtp-Source: AGHT+IGESoz5zqVHuhK+DhIBeFZeRtPWUPmGOFgTAJvyOlJPhz5Ckl7f+Q0aMYsQuL4Ny9Hy+WpTqQ==
X-Received: by 2002:a05:6a20:9152:b0:1dc:151e:d800 with SMTP id adf61e73a8af0-1ddae5e01e7mr2471464637.16.1732078132254;
        Tue, 19 Nov 2024 20:48:52 -0800 (PST)
Received: from localhost.localdomain ([175.112.156.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befe9a91sm614924b3a.183.2024.11.19.20.48.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Nov 2024 20:48:52 -0800 (PST)
From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
X-Google-Original-From: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
To: Russell King <linux@armlinux.org.uk>
Cc: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] unwind: remove duplicate word
Date: Wed, 20 Nov 2024 13:48:43 +0900
Message-ID: <20241120044843.10492-1-RuffaloLavoisier@gmail.com>
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
 arch/arm/include/asm/unwind.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/unwind.h b/arch/arm/include/asm/unwind.h
index d60b09a5acfc..a75da9a01f91 100644
--- a/arch/arm/include/asm/unwind.h
+++ b/arch/arm/include/asm/unwind.h
@@ -10,7 +10,7 @@
 
 #ifndef __ASSEMBLY__
 
-/* Unwind reason code according the the ARM EABI documents */
+/* Unwind reason code according the ARM EABI documents */
 enum unwind_reason_code {
 	URC_OK = 0,			/* operation completed successfully */
 	URC_CONTINUE_UNWIND = 8,
-- 
2.46.1


