Return-Path: <linux-kernel+bounces-219133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEEE90CA3A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 13:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63A71C208E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 11:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F031A08C2;
	Tue, 18 Jun 2024 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="CETyuQjA"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845B015AAD8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718709511; cv=none; b=A5eftqMuGGXiwwaHmLh3Rl/NZ+gBK/oQcJxE+p5ZtbUh88A8ti340hOj25pN9ye8R1KGLrLpbacCdghhoniUcpI30YCcbJzcqaDdwu5qblB8ot7G1Yy7SLYRNKBDJ2UF/GNSt0v0alZI+TxZXASBCoSkLxwTR3K8fhPI6rG+Ubc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718709511; c=relaxed/simple;
	bh=VpwLSXxd2so5RpDUPQQbRIpAOvy+lMCNE16WaIXiuXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XxUtQZt8AASKdosEfCClK2wQ2iU33o4CIPo9qrr8yNCBl8bSbqQ2EFUJ6pT2DUfGc0HYhDTnJ9ouBo073KFE5zjP/QhtWEw8s2fqeK7dXoFupoSP4rHhwSvycGZ8Ud8o5N/g0wqH9CvjmN2xlB1XKvoeEqqzx2qO06wGHC31A4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=CETyuQjA; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so58179861fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 04:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718709508; x=1719314308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WAlYx/JuM0nLXWPnb4Hl0KlsCS/vpWurWGlHz9NapmM=;
        b=CETyuQjAxCV/2ihW6z8lGioKPMvlz6+f3nToboCBa0dnC2NR/wGpprrm2AOG9Bf/9+
         sLe9xcFIZwmE7krb8rHSSCyGyprLCBMqJrfiwgbzLe7PgjeU9IdnzHrW0v7oG/v8x4e1
         EunzRkTqsj24x/pEykntig73daQCQoXsIek5Tajep+LNuLxOyvamxNo5mqAdIJDGztqu
         YyBohwrh4cojJcdzfeugNr7YghNgngFGvg/2oXmTv0PnANt7As1+6AsW11GW4qYVKioD
         4/9mjbzT3D3QaQz9mBIyH7nHRyUkR3yFTcodJ6zSRgM3G2GfCGd1ZBfaj2TkqM/mC1mp
         LLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718709508; x=1719314308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WAlYx/JuM0nLXWPnb4Hl0KlsCS/vpWurWGlHz9NapmM=;
        b=Nf0Z+EyugsDq4DrRRQoSPqP5FhYK7KMlSGTUHfNbRTw2Fim7vbS6wOyFXjQji97Yu8
         rfdno+NaK6fx19fJHybCshasg/Zu29uPZUVXja8GHlTBiQ+XTzkAQYFW43GwTmrjYRti
         mrhdPb7IMMT4Gs0+BWD6j8zEpXTY4KR9w4Bzt5pW829JWzGYGCO91lnI6HB2Z0Dpww96
         oT54RnFOsUcWmuhHb5edepqZZNQ+kFRCBRcAaPBHHDPT71maKggzaJwLcRZCZ3O7Hj/e
         XE+0SdzatgU1ij3fopM9oKmETCdBJFr9UfMKjLUy/zm6lzilWT4bYShzedW6hZHsnasP
         /c7g==
X-Forwarded-Encrypted: i=1; AJvYcCV1be77mwv7grt3J62N6NHoo7l82T3+z2lL0ftQfiLLaKZCDN9TP/60riJoupbUj0PCRwJcLrU+ty53EXg1CS5M0U/ozE6kDMjlawmu
X-Gm-Message-State: AOJu0YxTiNsWhgF0PNM3R1W5FPzHZ2dnZwU8x+eDmjVMHsDd0vEAAc1I
	12mIEz6CLjMY5ZdXc15T2v2WcJIDIEqhbv36+jA4dPg8nJatfP/q0U7Ul1V13wU=
X-Google-Smtp-Source: AGHT+IE9A08bBC7d6Sk1JmiWrXwfKAgU+YUKuiR8b7sOFmkrRIqZM7JKEf2GvjkTRTYxJ41G4x7yyA==
X-Received: by 2002:a2e:9dda:0:b0:2eb:fda7:e366 with SMTP id 38308e7fff4ca-2ec0e601058mr92996301fa.39.1718709507530;
        Tue, 18 Jun 2024 04:18:27 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:8d3:3800:4028:a105:7678:4219])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-423b67b3037sm111434235e9.47.2024.06.18.04.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 04:18:27 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Support Opensource <support.opensource@diasemi.com>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH RFT] pinctrl: da9062: replace gpiochip_get_desc() with gpio_device_get_desc()
Date: Tue, 18 Jun 2024 13:18:24 +0200
Message-ID: <20240618111824.15593-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In order to finally confine the unsafe gpiochip_get_desc() to
drivers/gpio/, let's convert this driver to using the safer alternative
that takes the gpio_device as argument.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/pinctrl-da9062.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/pinctrl-da9062.c b/drivers/pinctrl/pinctrl-da9062.c
index 22e3cd2cc963..6f44a13b90ce 100644
--- a/drivers/pinctrl/pinctrl-da9062.c
+++ b/drivers/pinctrl/pinctrl-da9062.c
@@ -139,7 +139,7 @@ static int da9062_gpio_direction_input(struct gpio_chip *gc,
 {
 	struct da9062_pctl *pctl = gpiochip_get_data(gc);
 	struct regmap *regmap = pctl->da9062->regmap;
-	struct gpio_desc *desc = gpiochip_get_desc(gc, offset);
+	struct gpio_desc *desc = gpio_device_get_desc(gc->gpiodev, offset);
 	unsigned int gpi_type;
 	int ret;
 
-- 
2.43.0


