Return-Path: <linux-kernel+bounces-249106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F1E92E6BC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 13:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9698284EB7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BC615EFAF;
	Thu, 11 Jul 2024 11:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="B2kumLOo"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1AA156225
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720697291; cv=none; b=m7ABnQAUpuIuRggTrgM4BwTp4MRT4HOZR1Ela8y5yUrJFmCu9ckfO58T0/4hHmKXnh3KJKp1tc5Bm/j9VDuZkgxTh5SPJlOsL0hlKlBkHr197YgwOgwI0vbLjiFP/4eK9BYs1n+NtOkmIthLZVL0hE9ZxQOyC79ID7fNNT5gWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720697291; c=relaxed/simple;
	bh=ue/D6aaMj20smtKi2jAbMVRAEMMLERO+XAiZ94XCja4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ryeR4Sleyj1IIjgdq7Psu42ztXok19aPsLsab3nVqg76Og3n1eyGvIjoI2P1uQVfXHu1RBrfEPfWOg8KiXXcEYIUOnj0kThLsxBSE52u/1M/KVaFnNMg08YedVmo72d70giR1bZwPHP+2lDQKl/HkCmvotNEf/EW9vJSjX/5WKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=B2kumLOo; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44ad1c9fb04so3899981cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720697286; x=1721302086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n4IagqgBEWB1oo5Cqg5iaPlJgTTeYOkk6mC1e1sE7v8=;
        b=B2kumLOoBZfQagH4WlbhIsn9jGu5A1BZzCWcEW/vunpuURyNNk+6+a6b2BDitqk8Uk
         Vx6sL7JUYuphwYkssiTDthhCRzgKmB1ED69ZcE5sRfDs3Dx6TKddhStqkna/1jp66L1h
         Yz2y2xz79H9CW42YAzbgMCg9rBUsmsXQG2PwYL6kp5TolIR8j3Zd0M7qWA1gEiY8soDV
         ur4QEFIvEGYjtuRmEWFH0XPu3eElYrHIWzNRHwYGT7dikNOKdMeI8AkWdxSm/MLfZH4q
         RbXXZS0206wWcHSzjKi7xuceR8HKVJHM3VlUOk2VBxB35q2lffge5I0APCsl/DbO372U
         XOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720697286; x=1721302086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n4IagqgBEWB1oo5Cqg5iaPlJgTTeYOkk6mC1e1sE7v8=;
        b=kFp3DdzmZegSy/MsMjERGs7V9xkDFv7VVvWJjx5gleEn2mwX+E9IQDlXeVf8j7JjLo
         ih1xh7DDO+iKATRc9ixSEQj9qaQuLHJuROxrirFlPZ7F951AXJl72bJ9WbB+QBYXMy8l
         tn/dgF1LNN7xyBKtT3V0vlCfhekMqHXc5pLFQxn9T3WQVAfM4UXJebwLf7WFzgc5S30a
         Fy8R8VY3QuvpMUray+XY8zOYLLi6kcU/xAKcNXVgHOXP8iGW890ihQ3GOZ6AUHIrEX4e
         erMSMU3yJ9lCYD7Yz54dYOBSZ2I/HDGQre6bERowmDFYuKXVDTn5VGQDPiuuFbyLz+Fo
         adkA==
X-Forwarded-Encrypted: i=1; AJvYcCVZqLw4ME5YPvotv2Sklm7Da0K0W8tSTzh5xITq86ocFTYN5enGA0qur0AJGMxBPgbY3yZAtUquz+fRpPqjcYin5Hi1xTiBlZuPYis1
X-Gm-Message-State: AOJu0Yy9/2X4mkJH6Rk1FGLEOsI/yv8LhCevaNCw8fapCaJlpLUiGpn+
	9xNg8ZV4AxBzuCMFylFcKytm3aoOfvPz+AMzWVONCa5e/9Pkk2C2EkyQyXKfSK8=
X-Google-Smtp-Source: AGHT+IGWL63JOeSzdCwUk8BUGlsc844oQVV8aJNmtUwKqG3hECJfCelzieYR6PSvclWPksawC9mUZA==
X-Received: by 2002:ac8:5910:0:b0:447:bf9c:3ea8 with SMTP id d75a77b69052e-447faadc5dbmr90068481cf.65.1720697286688;
        Thu, 11 Jul 2024 04:28:06 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-447f9b3d293sm29021281cf.25.2024.07.11.04.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 04:28:06 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pwm: axi-pwmgen: add .max_register to regmap
Date: Thu, 11 Jul 2024 07:28:01 -0400
Message-ID: <20240711112803.3942189-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was missed in the basic driver and is useful for debug, so add it.

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
 drivers/pwm/pwm-axi-pwmgen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-axi-pwmgen.c b/drivers/pwm/pwm-axi-pwmgen.c
index aac4f395497b..3ad60edf20a5 100644
--- a/drivers/pwm/pwm-axi-pwmgen.c
+++ b/drivers/pwm/pwm-axi-pwmgen.c
@@ -51,6 +51,7 @@ static const struct regmap_config axi_pwmgen_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.max_register = 0xFC,
 };
 
 static int axi_pwmgen_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.45.2


