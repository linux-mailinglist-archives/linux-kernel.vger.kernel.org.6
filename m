Return-Path: <linux-kernel+bounces-241584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC28F927CE0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97AAF2824D7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C9847A53;
	Thu,  4 Jul 2024 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZQk64Zs"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A00101DB
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720116793; cv=none; b=fDTr3mvD3RG2DoeDU7XVe0WoMMAk8Ap554aXHDTI5a20XDvgkre2aqAJup6UYr/j7oMcjqJJZC7zRLTBr4ZL2YBt+6Gzp9/3/RM8I/yrVHFPU7csPUJGgXModut+XYwGciWb5qiOHpKB/8sW/r5WceAhYKl6oqptN1wLOdhRja4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720116793; c=relaxed/simple;
	bh=CpLK/Sxc92K19alngbXkZuKCqkTbIngvnO+WtGWh2FU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Au7SaTesTq5ALXTxQSC1YT7ZKd3ef1dX6h5lCrp+v159BnLWimB1B/Vx8wev3cv/3E/zWZ06lpAY9mpexEZR1fph4I6tmVfr7gK6hoyTj+DSmpVULptKl1OzpXdgW4mfpkYC3aWaDQXNrxWLfcpiXlV8saugadjBfYfxT8spqgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZQk64Zs; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42578fe58a6so5916595e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720116790; x=1720721590; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1c3emy1MSAOHwaj2khLcexIGaDcNUblGT92MLUxkzl8=;
        b=cZQk64ZsAwxkek0e9rccLNLICRzAXrsuHB0hBtoqutG0Sihu8DWGX+gOHHiXBdfF/g
         +QEh6gy7+aYQ20hVgjng8D6mmWY5YnKEyzGKPhjoGTDudUf9Dz5X2scIrV+8RTXmIZJU
         yVySHJhBRfVtbLMHzVzqBQR6HPYIyhKWWpcRAQ7CDyWCNOx+1ebF+ths4FtRghwUq68B
         OVKvAsN9dmT30lw4pNbrgKXfVDJdQwpPac1ydFRQVGW5neyLUFE3JhRFO33G/Vqf7ZeT
         xZ/D0+W+Tbp6PIzjPD1FDBaguNE0p3ncMV+UkrPr8i8mhhy/BgqwLLKlrH3f9+gtKjUS
         Kteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720116790; x=1720721590;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1c3emy1MSAOHwaj2khLcexIGaDcNUblGT92MLUxkzl8=;
        b=YOI5P6jbzJV7GVyDshFZ66GOAuwRvt2dODNpUOvzNtz634fSRuRaQCPJ8pc4s1fjd+
         /93/1nGp7mqj96O8C5MHRrHajbB6gZPSGfd/lxSw/goq8bGiZJBqF57xGYx4jJSHgIuw
         PX/PpFH4o3S5gtlxBVL2pmtXJo1O+Ui/3Dg40QF9fuq4H7MNX8xOisc76N456Agv4+OV
         DNYYbN6b0sqv9ErkcrTNzVOlrfGQSXARgg6NUFoa8SyjiTqvWquXBrcw1Aixh1yvt/GA
         3Vl9VDOl+4QGmoGMITsEKpxInLLrIozyEoWsQoGtgBbri3HdULVtg/YZ+rTntGX8agx7
         fGtA==
X-Gm-Message-State: AOJu0YxbT0saDXXaqtYj3OXLK7R6mKDylm2zdBJpXRZvYVFoxSHDfnLI
	SdQI7v8KiLgwizem8e8P6nAxep3PLfdg2mnCSx3fsmL25Ohjwt7z
X-Google-Smtp-Source: AGHT+IFnZTR41bV/gBghYptPVAOALKujpP+8j8qMbsHCpVN+Si+PtRTl7MMvUEyfyUoWR/mQ0ghupg==
X-Received: by 2002:a05:600c:1d16:b0:423:668:4c39 with SMTP id 5b1f17b1804b1-4264a3d768cmr18880405e9.1.1720116790337;
        Thu, 04 Jul 2024 11:13:10 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-0b06-a203-2f25-a0f6.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b06:a203:2f25:a0f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a25198dsm32993855e9.32.2024.07.04.11.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 11:13:09 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] regulator: Constify read-only regmap_config struct
Date: Thu, 04 Jul 2024 20:13:06 +0200
Message-Id: <20240704-regulator-const-regmap-v1-0-bce0ddef63ea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADLmhmYC/x3MQQqAIBBA0avErBPMAqOrRAvRyQZKY6wIpLtnL
 d/i/wwJmTDBUGVgvChRDAVNXYFdTPAoyBWDkqqTWnaC0Z+rOSILG0M6Pm9mF0rLZlZtr51xUOK
 dcab7H4/T87yx5YGHaAAAAA==
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720116789; l=761;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=CpLK/Sxc92K19alngbXkZuKCqkTbIngvnO+WtGWh2FU=;
 b=eTb17YXSBW19K+8iDRAz7jAYi1uFI6e/KsdEVUQQYSGOik9pmogZTIq6jxa7yfzCxFgBRjPqI
 rNRLspt4G2IDQqqywmTUihUec6UtG6cHKohQd88la3MHFlHBlxJlViM
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This series adds the const modifier to the remaining regmap_config
structs in the regulator subsystem that are effectively used as const
(i.e., only read after their declaration), but kept ad writtable data.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      regulator: da9121: Constify struct regmap_config
      regulator: max77857: Constify struct regmap_config

 drivers/regulator/da9121-regulator.c   | 6 +++---
 drivers/regulator/max77857-regulator.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
---
base-commit: 0b58e108042b0ed28a71cd7edf5175999955b233
change-id: 20240704-regulator-const-regmap-2701f2387dad

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


