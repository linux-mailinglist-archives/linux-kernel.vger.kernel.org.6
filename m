Return-Path: <linux-kernel+bounces-528400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CF9A41762
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D283B5AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1721C8605;
	Mon, 24 Feb 2025 08:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vylbfStb"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7561991BB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740385645; cv=none; b=pAEOgnhGP5bG8H59xt+X461/WFCSdDoy0yegnXcVmiMsUN8qAIncRR8mFatPAxwrTCgbYuMUTMfVJCr6TcrwQDFgG/JzUrb1N+mJtdhmedo2YGqwlaPB4fKbuIXLYxYmtN+xsfVmuLbPtWkphJ8C4bcYWprvHv6KcgTEpXYhhbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740385645; c=relaxed/simple;
	bh=WEwufN0C6Da76f80mjDGNWOq+qPLBT6It6oOTpWRUUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SEqqDbFuB3Lk8jv/+x2kjdoYS19JfnfDJylZZ+jvRxrY9F7oyJhtO4MjYQKHiTd5uRfhJt1FMCliJBVGONfvMDYyDvwv6dAHKEFyt4XkyhWXIeiERkjW4xpdFmYG7/lUTwh6+Sqf36bK4ivDu7LIAIul7RCWGmf6RMCN5Muqw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vylbfStb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4394345e4d5so25895225e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740385642; x=1740990442; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0mLZ8aDGec3ZA3HBLn8nFBClxMH4vzor4RA7AoG0JY=;
        b=vylbfStbI8OI+mqrlNHo32MpYVF8IICPAlaKeX4CKMxcNCP82P9DcFmbRkSyYjR0Zf
         J1WUnnHtgNaMzkxz4XL0bgAuv+FHH41+bOmuUoC3tQ++02ILCYEb1gqemEyicS4uziYr
         C5WDsW671JmGj3D49Husltj/iEsJtEAGp/1Bl4bE9hSxK+42CRieSbGSZYpbexlO8TbY
         wAV7rlj0+H+k1QxMDHPvQiNdXAmQyjN4VdUQ+KL3LMTDMkplAnAm86bILT44l/zPVjC6
         MyqNG5vi8C+4h1EMAlIJSQ5+TJ5nESAiJkhQsoxLqjmKnkLeQglOQLGcfXxa7ar2JN05
         XEQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740385642; x=1740990442;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0mLZ8aDGec3ZA3HBLn8nFBClxMH4vzor4RA7AoG0JY=;
        b=Ej2xRgHwwhPtTs96qRfQVqsF1UE7TfXjaNxxSDAnYlgbx/uxkiSIRGYGKJiHkWKbbd
         jdCPA34wykIh2q34tuXJHCAQVbavtUJbT6ODYtZf2CYcNdo8pZkbc4g9omRuJLaJs9Ab
         fa6chVlKNNJh1qT+Sv8etsM2+E0XpwOKpaaYA8xFFca1dD1AOCXXV6oCBJEre32jCiW9
         CW0HRQENjbsKcFXMOANYj1xRyu+OJu+c+FQXpn3rc/cMfI4ET0i6X91U3Ps4jQe3JDC8
         UOQWtALWpDlEPeAvBVpj1Ft0mU+qagUsdlKqzQXdvzyzae4FVOcgc4eFDOT2/ssAMilC
         FeSQ==
X-Gm-Message-State: AOJu0Yz3Hyh3bC6CbbCmbXdHZ7v79/9EvAIsKLIwKgps/jVcK4wuu381
	ZmjMoXzfAyQrZw3f5obTgL1GqIxgoRcEJaj34SnhIsgKd6Uwksgt1LR8c2Bx6oA=
X-Gm-Gg: ASbGncuOJb5oofIfRZ5WsqLIUR/CK0Fpd9LDxAcqvSgEWi6k2AIqo08OVqRp/0PaiBI
	hN4b0/ifMDr/yrpGqQ1STT2JTOSDTXp7ecWkqnk3cRGOPnttLpKceKatSZZyCP85bmVUHUYn+Zm
	BfouA1TS4s3ArNTV5+ldmiqj00W/xgf+LtStX9ARYYgKDpLD6paSd2eFVG18iBvd/I5uX/rI2wF
	/AHIio6wqD3I44Pr3QoISkUsnuCuIGb4FOVl94Ia9LnzyQpRLgAwxLv+1lhxfHiwJm4PYMWhOEJ
	zYpIuIgqdkgckWaF5ciRngbuRR87rN6e36+ee84xmfowxEESZGcE/ZxiKiH3BzykULPy8ZSSqd6
	ZxaQLwQ==
X-Google-Smtp-Source: AGHT+IFKQ1uNeNV3fTYP3rNQfGMp+Cmi02jyOhk7zI1MJlrHb9GT1CNOMyyQrhWu6ADrvprOTDrjsQ==
X-Received: by 2002:a05:600c:4f92:b0:439:9377:fa22 with SMTP id 5b1f17b1804b1-439aeb3453dmr96701895e9.18.1740385642236;
        Mon, 24 Feb 2025 00:27:22 -0800 (PST)
Received: from ta2.c.googlers.com (169.178.77.34.bc.googleusercontent.com. [34.77.178.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439b02ce428sm101226065e9.5.2025.02.24.00.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 00:27:21 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Mon, 24 Feb 2025 08:27:17 +0000
Subject: [PATCH v2 5/6] mailbox: remove unused header files
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-mbox-mutex-v2-5-9d699148fe4e@linaro.org>
References: <20250224-mbox-mutex-v2-0-9d699148fe4e@linaro.org>
In-Reply-To: <20250224-mbox-mutex-v2-0-9d699148fe4e@linaro.org>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
 peter.griffin@linaro.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740385635; l=872;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=WEwufN0C6Da76f80mjDGNWOq+qPLBT6It6oOTpWRUUA=;
 b=33BrSzmBZCmO7UuYHSKOFU12ITPgTpI0lBFILdYbaJ+cjpt8t3PAZqCy2+Kg0acahU6SF8RPR
 pfyneL2ZWw8A/JBrsheGXn6qeYaGUGyynkfbmGmUkcHNI5SATn4s5ey
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

There's nothing used from these header files, remove their inclusion.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/mailbox/mailbox.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index fa3dcec63940..5e3a1d0315f9 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -6,17 +6,14 @@
  * Author: Jassi Brar <jassisinghbrar@gmail.com>
  */
 
-#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/interrupt.h>
 #include <linux/mailbox_client.h>
 #include <linux/mailbox_controller.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/slab.h>
 #include <linux/spinlock.h>
 
 #include "mailbox.h"

-- 
2.48.1.601.g30ceb7b040-goog


