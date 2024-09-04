Return-Path: <linux-kernel+bounces-314617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C99E396B5D4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A2B1F2205C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9DE1CF7DA;
	Wed,  4 Sep 2024 09:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nFGD00MS"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AD71CF7C8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725440450; cv=none; b=Y+UXf1EAZciJrwdWYLLJ0q3lmzoDdT3h03pDOd8U+XBkjM8qy7LuKRwYZm24XYQ2EmPj9ShERlgrkAl2JWiOssAMDYRd749iAY9rUCjnTn7quOMn33k7uBHkV4qCOnuCboMqlI5YC4cqU2zLn2JcuF/tsTE9CHxWtTrPqtpRu5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725440450; c=relaxed/simple;
	bh=/6+e29D1jTzHcDiEl7NM7CoTAoSOKhezsDzMCtm9gzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUHyunOEEnI8lSlMWAPtnSZHlgRHthZ27Fkmy4U6tYIzILwNUON4po5qGniPFlpsWFHY7BXO/1PyXXi37ilDjJAsJ1Rht2xaBcxzYyrOP6mYYlvdzLGxjq1RO+N9+iPvpSR0X0ctoBtUYkCTkxmE/sq3eKQ3Yqk8siMCSQIAJOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nFGD00MS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7176645e440so368565b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 02:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725440448; x=1726045248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1lx3yQsWkTb9x7LagKbuMm4vpMCf33yZ7BqsG5IeSJA=;
        b=nFGD00MS5rxhyjP+cGASjFLb6A1Pk1osknyZHSio5PPze02s4bhkL/qnQf9z8XihKY
         qEe3mVK8ZGeUC0YItRKmqTqXjkrrTXvT0EQeWvdYWKFmaw4Q525icTxKTa/CPY0iIBnu
         CPMUIf8P0IpikobI/WHx6kXPDdQytS38AcXUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725440448; x=1726045248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1lx3yQsWkTb9x7LagKbuMm4vpMCf33yZ7BqsG5IeSJA=;
        b=qb11yMYcqIc97vi5a+fW9n+mWEBU25moyGIsvxReWbrJUhhil6ic7NLTvaE8aXikpU
         5sLwMjaElZmbczrbIrmO2af/8N0bg5qTmmkVVW/iXqBknqUWYqgPyShaYIL6q0J6tUij
         Rk762PD44l1VF6k8EZouDVrI/lQJ951vOBPoV9yy3bFGLVd1spGd/9Pr+liCIfKfgkN8
         xOPodM0+OtWPthufKBqB2NLW0hL4723YFoeb9OIV5gFkCCue19jTe/6AggG0EtgzzfIU
         XdLXK3MF0bip1QW4sl7Cs2kNQZXdY1PAsu76Xr1oB6J/6XP4at+zJxMw4AEfC+kws+fB
         w+XQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXo6xLrY6fdgNo+11+Z5ieANUs2p+Di9ETQpCoj9g+DwNHQswO8zdoVBDViJW3kiV71yxO7QIjXfKJO7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1F+UyRepal1xWiyCCejieH/Q758ni2gHumUWsXw6tPpfdSoyh
	Vqr0xGH8tcSvX+GloVYhuNxgTYJ6hoDlfFmDGwafcjDkV247DiDGjhHnnf4ap+aetWl7ckeRFgE
	=
X-Google-Smtp-Source: AGHT+IFljw5CEOubKFgJs6Qw/4fe2qNKJQ/lUogumRK/GAi7DQzBwRnb7bCkK8F5ANHCSTOzSxDq3Q==
X-Received: by 2002:a05:6a00:2e08:b0:714:228d:e9f2 with SMTP id d2e1a72fcca58-7177a92187bmr2450461b3a.3.1725440448446;
        Wed, 04 Sep 2024 02:00:48 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:83fc:5c8e:13bd:d165])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-717785b5183sm1153279b3a.197.2024.09.04.02.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:00:48 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Wolfram Sang <wsa@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	chrome-platform@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Douglas Anderson <dianders@chromium.org>,
	Johan Hovold <johan@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org
Subject: [PATCH v6 07/12] i2c: core: Remove extra space in Makefile
Date: Wed,  4 Sep 2024 17:00:09 +0800
Message-ID: <20240904090016.2841572-8-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240904090016.2841572-1-wenst@chromium.org>
References: <20240904090016.2841572-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some lines in the Makefile have a space before tabs. Remove those.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Closes: https://lore.kernel.org/all/ZsdE0PxKnGRjzChl@smile.fi.intel.com/
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v5:
- new patch
---
 drivers/i2c/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/Makefile b/drivers/i2c/Makefile
index 3f71ce4711e3..f12d6b10a85e 100644
--- a/drivers/i2c/Makefile
+++ b/drivers/i2c/Makefile
@@ -5,10 +5,10 @@
 
 obj-$(CONFIG_I2C_BOARDINFO)	+= i2c-boardinfo.o
 obj-$(CONFIG_I2C)		+= i2c-core.o
-i2c-core-objs 			:= i2c-core-base.o i2c-core-smbus.o
+i2c-core-objs			:= i2c-core-base.o i2c-core-smbus.o
 i2c-core-$(CONFIG_ACPI)		+= i2c-core-acpi.o
-i2c-core-$(CONFIG_I2C_SLAVE) 	+= i2c-core-slave.o
-i2c-core-$(CONFIG_OF) 		+= i2c-core-of.o
+i2c-core-$(CONFIG_I2C_SLAVE)	+= i2c-core-slave.o
+i2c-core-$(CONFIG_OF)		+= i2c-core-of.o
 
 obj-$(CONFIG_I2C_SMBUS)		+= i2c-smbus.o
 obj-$(CONFIG_I2C_CHARDEV)	+= i2c-dev.o
-- 
2.46.0.469.g59c65b2a67-goog


