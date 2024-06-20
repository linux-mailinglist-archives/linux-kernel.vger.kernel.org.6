Return-Path: <linux-kernel+bounces-222343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A66D90FFFD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 11:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EEC2B21162
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 09:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2B819B3D7;
	Thu, 20 Jun 2024 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QDBMOHtV"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB8E558A5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718874654; cv=none; b=rn+XQUrPbU/mqcAFfmcaciuFJPV+kFeDoKbwSaF4sMVac7V4aa7hsuYDI7Y3KNT1mf6eawbjAy8c8YGEiiZjrTaFNc7DfLTjcTwyNscOafpnIgbEALgY1Gp7hcgoqxpDxbNe2UJ6Toi7+QZ6wpUy2M6uuHLu26a6r0xFkgm4sZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718874654; c=relaxed/simple;
	bh=c4D7Z9CR9MfOFr8x4TqhuN903N+QSpMF6a7kToVGrDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jEaGqokT1t6iBuyJqEnz4b+B2kn3gvk77fmY9VTgb3RDZqAftNIA0fBNmiNi3I44ah6M3RAibFmdWkzhYVCCHAnkqfBOBHzj1RCM/GqMoke2U/1Nt1lqWE8HC3mPxuWpFr+LJYONLsjJ/aJWHHSOzvTEUky4z/Osxdu0xhf63es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QDBMOHtV; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42172ed3487so5331345e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 02:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718874651; x=1719479451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PHBkJAins6g8k8CRgVDBSrncktJoQ1zQZ+ZidiRGnrM=;
        b=QDBMOHtVhk8SbJrlUhTaJ+GhUSxTSy/grzZmM/2hAueByrRzq6Uv+L0ONoeJLdo2/M
         17C+jk/F8/bHVXNz8ftEbzZhaDOVQT0nwG+HpR16PfDt/PyY6npeu6d+SNg5u+57xRKE
         b84zWHgfk+zDJhNx9rTWD1AP1bcdlY0zl7+1GGc6YT1fkKBHyH1F2tjBWMy7QhGNBb04
         Nd9dBmj7bExKq/d/h88AuuGBXJQ309zlHgjXgZwdeKYvULQkfhQedCU6DWZ6SjHkuvwm
         btFC4pCn5CXdHkSZoJ98upl4htgGNhCCcLsg15SLIMaS1hAjgkFlv7ZKarbDBLfSkj5X
         bc3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718874651; x=1719479451;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PHBkJAins6g8k8CRgVDBSrncktJoQ1zQZ+ZidiRGnrM=;
        b=YrQ7nLnbVzhQuNVg9V+9Kk8YvnWWcHWS42mdnEK+lEWlDTQvI8HtHFL6tvXRCtd++q
         9agJaUNGQ897g6MCQdhLDcnpjlzR3i4lSjn75sBPBEutAKE16vZADYHK6GljzLi/xn4f
         TP/IrWjJP5K69OoRFdEQ7GoXsw5Z5EEiNuGCtr/tnPnCK4PKNrQlKTlgLNP9OdUAXIl1
         HSpzkr22FSI5/TQXH2cUEDRxMVSAMKLRuZkmTyzt9VnEpK/1vGSX4ScZ/mOd8+ZVPlXV
         61X9oSteriaj3XCbrOrvDgrisVw9B3fGjpmsAhfJ5qnt7FPkFHZvrV1/1rTrj9yBRKCD
         hv+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXhEuynmTQ7XdtZRI7JwIhlq1VxgdSKbiL586tnij0my2xEbjFskqFHKsCy/TxqaJYo117j4a/3d7LqhfFdZk8EVobs/2pa3FeU+Zyw
X-Gm-Message-State: AOJu0YysN+tAjV+7kCHzF/oXUKDlywmbN3hcJ50Hvi3KZnK0Xxfd6nhf
	9xBEDtILV+QThqKspPKnyvKvoGfq4GlRHdLFbtGY7Tz/7mj30NblpIe5CdXlmlLtvBCWzs7dCFG
	I
X-Google-Smtp-Source: AGHT+IGbAsr4VCtVmR91oxpzAar7lPnAha8zhGqOQi2bz0FL/BFRbaDZAys1bZaV9FZphUYTqCbqqA==
X-Received: by 2002:a05:600c:158c:b0:422:dfb0:8644 with SMTP id 5b1f17b1804b1-4247529bc07mr38253855e9.33.1718874651188;
        Thu, 20 Jun 2024 02:10:51 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247ef50750sm8238195e9.14.2024.06.20.02.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 02:10:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] soundwire: bus: simplify by using local slave->prop
Date: Thu, 20 Jun 2024 11:10:46 +0200
Message-ID: <20240620091046.12426-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sdw_initialize_slave() function stores 'slave->prop' as local 'prop'
variable, so use it in all applicable places to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 191e6cc6f962..263ca32f0c5c 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1410,7 +1410,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 		}
 	}
 	if ((slave->bus->prop.quirks & SDW_MASTER_QUIRKS_CLEAR_INITIAL_PARITY) &&
-	    !(slave->prop.quirks & SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY)) {
+	    !(prop->quirks & SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY)) {
 		/* Clear parity interrupt before enabling interrupt mask */
 		status = sdw_read_no_pm(slave, SDW_SCP_INT1);
 		if (status < 0) {
@@ -1436,7 +1436,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 	 * device-dependent, it might e.g. only be enabled in
 	 * steady-state after a couple of frames.
 	 */
-	val = slave->prop.scp_int1_mask;
+	val = prop->scp_int1_mask;
 
 	/* Enable SCP interrupts */
 	ret = sdw_update_no_pm(slave, SDW_SCP_INTMASK1, val, val);
@@ -1447,7 +1447,7 @@ static int sdw_initialize_slave(struct sdw_slave *slave)
 	}
 
 	/* No need to continue if DP0 is not present */
-	if (!slave->prop.dp0_prop)
+	if (!prop->dp0_prop)
 		return 0;
 
 	/* Enable DP0 interrupts */
-- 
2.43.0


