Return-Path: <linux-kernel+bounces-181206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E0B8C78FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C3ED1F215D3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 15:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC49414E2F8;
	Thu, 16 May 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bO9DB/Tt"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF5414D6E4
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872135; cv=none; b=uVJHp1R8e+wrUunz3tANpWgzpuAHj1/bmtCLrvoHlUIPIZgSeK7C5hmzXBDX07Xo9lZ1/6creWHSYcbyDHKOozrHTafC03Vsl9ndPJ3gJv0P6AcZXrGlsadDFi8utGZIYdyfcy3dxkkQMbcEroZkamkvahJKZqJ8yRxiB9efHFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872135; c=relaxed/simple;
	bh=G+dvNYQOBLr+WoKmLXh98J7Aryp0MXfhIBc7+yfe0sM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcSXQdDw4BYJ4GRvXdtt+rxw/LCofhDxCynT7KCRfc3TaJ1F1bAXetmOyUKv1zXPh1nnA+D2E5T0FpjmTey2Km+xJDPtdDmRo8Wv64SI4Pm+jYab3EFbNkFrvmLH1nmZ8lLtw2ApxFIWCrir/TRK5Cz590IOowzYrQKbm6RluJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bO9DB/Tt; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2e271acb015so12135631fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 08:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715872132; x=1716476932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypBfZt6woLl48yZMYWLwJnxD1n063j94AW3SXRtrghk=;
        b=bO9DB/TtArv+1pvyVORnixHhr8CWdanaBXZDbx7w5vfArNShcbpFZzeslsUPEiVHel
         Kxwxph9dVzm+GumrpWlU7IJrBV/TIHCq++s0K5JOZSD2ZrExHAYux3LYAkOE8mZsipju
         fxUEDBZizHwbyNBKY9k+uyZrHDGUJB0YU2mR9EXWd4xlKHPR0a+3ScnzVBMLymcIRRsz
         +zUbW4asZY67COG/eossn22HAnYSSdtOLBwomFy9colskEg8vJYDo/eGKJIE85ZirJfK
         2LBbOIYMIgB3ZUIZxciXWoBRimPILYrMHkCAJwmA/yXPy1jbMOpf1I4Pv1mMLvBFBlBR
         WJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715872132; x=1716476932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypBfZt6woLl48yZMYWLwJnxD1n063j94AW3SXRtrghk=;
        b=aAESowveuT2sYRrQIy4FsRMQXblMOTOHgaLRAsHNJN5IOy23oIWzgDh1ljFYAAxvu9
         QfE4GUaePvYeOYsTOmbp6khHkdn1eVQeeNqhQJZ9cBvaW2QnYI36lrnF/LaOUx7+kesr
         S0qTBwMZGD4Dn0pBsMRfzh0cKzev6NDES4rMlnydl+v9rl3NZEqZEX4HVc+dsO3LNM7c
         nXWSD/CYxHDZbad0cRZEM+VgxHkTwgUcGEj88PhjJTGv7OXF1UsQXqTAHj9Iydp0h5no
         DgpoPzAXLnbk7T71whNaCFyptSsnzVckuRU9WRO7d72aeSrwI9qzzNK/JwkO6D3YKL3z
         mOlA==
X-Forwarded-Encrypted: i=1; AJvYcCW6zbuX/U+cSdj2X5H5YmVnRJvf7TbYvx6h+olfGygFMfdj3+wbDUzuWkHdnfkxKYluv4/cosquSLnwGd8yYkgQJ/bR7PNWP5yR3XFy
X-Gm-Message-State: AOJu0YxBeeQfYwXKgs20FoYkfFdVLfEvqQfPzyF0PEERKVqIvvSpng2E
	XpVrjQS5eaSrwGZIt0vXJ6k4rkL8m6Vwuqh0dLEm/oPl7CYbMk7hfGTGdd7HU8k=
X-Google-Smtp-Source: AGHT+IE8U/D0l2CYHxsSjMxEnW9Nswfn86/rBWx05jmcgu+/3vQwWvbBIKiUixNYwUsYF7gN5EXKtA==
X-Received: by 2002:a2e:81c3:0:b0:2df:907e:6de3 with SMTP id 38308e7fff4ca-2e52038a44bmr116578741fa.35.1715872130810;
        Thu, 16 May 2024 08:08:50 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:1fce:7e5a:e201:edd5])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41f87c25459sm309351725e9.18.2024.05.16.08.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 08:08:50 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Jan Dakinevich <jan.dakinevich@salutedevices.com>,
	linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: [RFC PATCH 4/9] reset: amlogic: use reset number instead of register count
Date: Thu, 16 May 2024 17:08:34 +0200
Message-ID: <20240516150842.705844-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240516150842.705844-1-jbrunet@baylibre.com>
References: <20240516150842.705844-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

The reset driver from audio clock controller may register less
reset than a register can hold. To avoid making any change while
switching to auxiliary support, use the number of reset instead of the
register count to define the bounds of the reset controller.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/reset/reset-meson.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index fec55321b52b..3e0447366ba6 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -17,7 +17,7 @@
 #include <linux/types.h>
 
 struct meson_reset_param {
-	int reg_count;
+	unsigned int reset_num;
 	int reset_offset;
 	int level_offset;
 	bool level_low_reset;
@@ -90,7 +90,6 @@ static const struct reset_control_ops meson_reset_ops = {
 static int meson_reset_probe(struct device *dev, struct regmap *map,
 			     const struct meson_reset_param *param)
 {
-	unsigned int stride = regmap_get_reg_stride(map);
 	struct meson_reset *data;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
@@ -100,8 +99,7 @@ static int meson_reset_probe(struct device *dev, struct regmap *map,
 	data->param = param;
 	data->map = map;
 	data->rcdev.owner = dev->driver->owner;
-	data->rcdev.nr_resets = param->reg_count * BITS_PER_BYTE
-		* stride;
+	data->rcdev.nr_resets = param->reset_num;
 	data->rcdev.ops = &meson_reset_ops;
 	data->rcdev.of_node = dev->of_node;
 
@@ -109,21 +107,21 @@ static int meson_reset_probe(struct device *dev, struct regmap *map,
 }
 
 static const struct meson_reset_param meson8b_param = {
-	.reg_count	= 8,
+	.reset_num	= 256,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x7c,
 	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_a1_param = {
-	.reg_count	= 3,
+	.reset_num	= 96,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
 	.level_low_reset = true,
 };
 
 static const struct meson_reset_param meson_s4_param = {
-	.reg_count	= 6,
+	.reset_num	= 192,
 	.reset_offset	= 0x0,
 	.level_offset	= 0x40,
 	.level_low_reset = true,
-- 
2.43.0


