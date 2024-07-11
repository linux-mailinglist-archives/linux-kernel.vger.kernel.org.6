Return-Path: <linux-kernel+bounces-249218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00F092E8A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 14:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B13D28311E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 12:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A5715E5C8;
	Thu, 11 Jul 2024 12:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XfkRxMzj"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DA6155C95
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720702670; cv=none; b=B2jp9h/Em5vC83LqMmrDYRIWZQk5T45cyeZJzBUBN8lqj/bEpzicCsRBHKi4a+gIlF03U4lsdAp39ZbL1VuD9h7EGjG1apij0oV/EyvHmTKnEBmmyKXUP2cG2YmXa2ZUvVE8HcmNnsL3jW4HK2Nn0x/ebvHyr4IAK9o15F6Gb+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720702670; c=relaxed/simple;
	bh=Vx6CPpucW1dVTursOE1Z9XKW8q/kkQLneTmD5Q7DytE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H43eQVxo8ZcgX0bqsEU6vCXTUniq69JbEtNeJcAD9D4bE/U7Oo6oynDVgLX6BzVF5rCL7D4V5LZvMZSMDX5Es7R2vaKbrg2UGmMbJ3VjCWYvMIY62Hy+HwLxSjnFccwNURqOjfVBgK88WrSP29pthaQ6FFobJzSM/2W95AJukXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XfkRxMzj; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b5f128b18bso5193756d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720702666; x=1721307466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3RhlYUt3ny8up6uyZNoufuOfOOhzfMiuUgDnGkq+BvM=;
        b=XfkRxMzjF6ztiNKv7g/YUaTX5a3VMAMOdgzKwFe+sqjG33gAxpANQal6nU8FhNeRwB
         w5098R5rWrKPFPx4RwPwetnqDLiByFQMyirNQONNnUeU9ZLPBOcjM/92zAjrBJ5p8McS
         WymmcTv1EDf15Foy7YWBE6PEV7TJ7LKWmJ1fyEuPUbyAUJtN2iLky0z+J383DdnSnvES
         fQhR8BYwfZb91u+pWay9Z+VUzqXUPDXyG7fhSPzZXnNlo9Hs8gUVjmAOY7VqlmUnkUoy
         QWBz2p0so34B+6RZuCIIY/2IQiqM3CZRGu1A9xt/lJOjNohWhs92trXmmLFocy6F5why
         92Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720702666; x=1721307466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3RhlYUt3ny8up6uyZNoufuOfOOhzfMiuUgDnGkq+BvM=;
        b=jAJKFFlr4zZEglwrh68oDZDM0vi8p0axyf/v1rebgNJs+OkKIaxvwFw3RyZcsIhr1J
         gMg1X+9j6tYO+7XhBDigNlnlAX7VbP4rLMknboBW9oHbSyrolX1yQX8km+hjbKZkVC37
         oNUJq+C6PPskamw2WtI4PqRZEN3+l4Yv3+RxR8WvMR5xxOXlpPMYQwjrqHbtCFgDT+/K
         NpT8nNmHJcvk21vJblkBdRvnsQWxq6qaNrdX5EpZIp6975Cets8TDHnFTicSG3GliRFJ
         FGZwuE0qTt+eX+EIz18XTODStdGkCx8MbAf1vaBbCf4xrVSc2AH/Tp1MWlvHs7001Av4
         jgxw==
X-Forwarded-Encrypted: i=1; AJvYcCX0a3qNk683D0hKvCotVF/8WaF6yFXQKn8njUos7u+MQN0yacf5CPaZJaQSZ1LxhU1krU6MsSXRHjiJAPg0c2o6WH7YeRjigZcXld6m
X-Gm-Message-State: AOJu0Yz7085DZqVQ2NoQ8LTZLW8qkMEY3tIba8k7ML4MEBYXgIDLPIBT
	Mfe4M22OehhTMlpjXSa55r62cFhqLdsNLaDQiHjbWBQxy/4kf6GzqzNM4h7Z5o4=
X-Google-Smtp-Source: AGHT+IGZe2XeyJolVMfrU/NNN+zi+srmj/3LzeR7gEZGXpnOdTb9rm6L3xYcOAkjrm/i/YwFK1CAFQ==
X-Received: by 2002:a05:6214:19ea:b0:6b4:e702:56ee with SMTP id 6a1803df08f44-6b61bc80649mr105664946d6.11.1720702666056;
        Thu, 11 Jul 2024 05:57:46 -0700 (PDT)
Received: from megalith.oryx-coho.ts.net (d24-150-219-207.home.cgocable.net. [24.150.219.207])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba9f434sm25218326d6.134.2024.07.11.05.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 05:57:45 -0700 (PDT)
From: Trevor Gamblin <tgamblin@baylibre.com>
To: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] pwm: axi-pwmgen: add .max_register to regmap
Date: Thu, 11 Jul 2024 08:57:42 -0400
Message-ID: <20240711125743.3956935-1-tgamblin@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This was missed in the basic driver and is useful for debug, so add it.

Example regmap output before the patch:

|root@zed-tg:~# cat /sys/kernel/debug/regmap/44a60000.pwm/registers
|0: 00020100

And with it:

|root@zed-tg:~# cat /sys/kernel/debug/regmap/44a60000.pwm/registers
|00: 00020100
|04: 00000000
|08: 00000000
|0c: 601a3471
|10: 00000000
|14: 00000002
|18: 00000001
|1c: 00000000
|...

Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
---
v2 just adds an example of the effect to the commit log.
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


