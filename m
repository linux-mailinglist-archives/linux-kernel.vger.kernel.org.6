Return-Path: <linux-kernel+bounces-324338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABB8974B55
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 09:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A55A1C24747
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 07:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F87F14D6F7;
	Wed, 11 Sep 2024 07:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AWqja8Do"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1145714A0AB
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 07:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726039718; cv=none; b=D8CungiEbGM0SbZmswH4YypNExAabin77c2jjtt1UqZXaGXHYMbbe+OAAH55PUT8Xg5DAurK+qZXPqxbM/LGNsIRj4MSmGbN5ks/j5f031ygcQcE96RsBxL3tna4+ncaRAFQCHGf7LoRipCaaRvno4tXof3RKz1ZGSlJLOaYQSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726039718; c=relaxed/simple;
	bh=XxiTjlQcSLEHrjz0okO6v8gsp7M/kr47QP0mR5JSK08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QBrEhaUOUBkRUeaFslnaObjX7H/JMA4q1MpRzEu1sOiXiUM3Rke874NIh8cAAaKbwZgqL7KFjlZQj4GPh69ptZKCXMjxZNg5tTMC/YMAjDHl3FuJ5+e0Juj7R5CVsLqjJF4U1MRP0ivO4nXY5u57Upl8dIoyQDaTmJY1wLTYNic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AWqja8Do; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7179069d029so4548207b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 00:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1726039716; x=1726644516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZj+Rwt2K/givoXdUXg/sARHG7LMQ+JDTIquBzN2oCY=;
        b=AWqja8Do11n2xY2bO0h7B7OseZ4raQjQ86+PRPLDN7Bb7g3d2kQX/PGqZFi+cRCacC
         Dam7Wx8/GIrN5M/VGsQxOuDdphRIAMhEKn43gFOVxIRq9GbVjXOGb+/GWJPlvRpqOQw2
         81uvN2vw7OIRfE9fzi/SjQuYwdjgin7HOoja4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726039716; x=1726644516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZj+Rwt2K/givoXdUXg/sARHG7LMQ+JDTIquBzN2oCY=;
        b=rEyrDV4BCDucmBPmHZ5aH6HgxcQOR/eN/2SuqsZwJVhifjeVW5J2M4Z9TdUOskcFUW
         /qyYEkpWfAonan7uu5mbYAWM7pBYJJbURdNf+PmLo2amcsEqaiYnvn78StY3qOLsSkme
         F4IKYksIDo6yrcfZZEodLb2OoJ9BsQs1NZpDHR24rwwCmW3sVQPuDzqf3Dz7JTc0oJZM
         AzufqGCo2VIK6GhasZlTMzrIZtIKnCNc012yBIu8trdho2tXQtwpaYEVV2ZoBZJB9USo
         HfVmxvTcXLOLzBxbK8mIN2tMYA7SPtGrJEe3QlGsc13UPJuyqLPjAeTr3RoNsJ0jHSVw
         Swcg==
X-Forwarded-Encrypted: i=1; AJvYcCUmSNCaWrwftZQqoYW8dgOxJ5gIQVgeFCMYRdoj2pg+Qa0mB7RgmF907YovbzytZtrbhtgNCwXxRSJ7qUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwKECcxpvWKMs5CX6NUjU4Is9bpxAkahpg1FGJ9mVMl3DoSqy5
	ea+7yBTZwwatbyf9919ZznpqzOWc/VOD+z2EpbvYY/BFaohQL/CYV6BJkDTBwg==
X-Google-Smtp-Source: AGHT+IHedUO15STr+MI+20JywnkGwOWN1412qS2q6DZSwhZSeZ7SKRwPtcyUrKy5SFYgpsHfqp5wRg==
X-Received: by 2002:a05:6a20:cd0e:b0:1c0:eba5:e192 with SMTP id adf61e73a8af0-1cf5e0f52bcmr4279897637.27.1726039716399;
        Wed, 11 Sep 2024 00:28:36 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:8398:fe34:eba2:f301])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71908fe4e7esm2399415b3a.80.2024.09.11.00.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 00:28:36 -0700 (PDT)
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
Subject: [PATCH v7 05/10] i2c: core: Remove extra space in Makefile
Date: Wed, 11 Sep 2024 15:27:43 +0800
Message-ID: <20240911072751.365361-6-wenst@chromium.org>
X-Mailer: git-send-email 2.46.0.598.g6f2099f65c-goog
In-Reply-To: <20240911072751.365361-1-wenst@chromium.org>
References: <20240911072751.365361-1-wenst@chromium.org>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes since v6:
- Collected Andy's Reviewed-by
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
2.46.0.598.g6f2099f65c-goog


