Return-Path: <linux-kernel+bounces-196376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A0D8D5AF0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8BCD1F25289
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32ED80C13;
	Fri, 31 May 2024 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TaeDAe++"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830180635
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138672; cv=none; b=mS0yPIV0sgA24Hz7EEQpwjSzrjpcGmbThFul1Nd17VTZGnkfvNRdA5DC3EQWbECQg4vbS7YN1OF4m6myNX9Fey+EQjesvq0+eWuVQR70UQGDFy5ZlEZz4eP/+yRuw2/nBqilmboxMKI+/jRb44CtsQwK/q3T4JKpbrbcwwK3nYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138672; c=relaxed/simple;
	bh=TJ37oY0V5Jeq9pwzVqB5NXbszEJmtjwoCWFdS6GxE4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8cAN5GA9xXCyN+OTKAQAU1g1pcKNscP6kDGlE+o0JWDzY5sXNFswlCchkQzFYfmvfqHfQgCgqGdqiMYlR1JGBMBKWCV/3DyqJhiFH4nfUauauBOVNaQIeP+4sSS4C33Odl7cNtea4fhWLDG0Fkdu3VSnRvPnjG+jq0OUgD2aow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TaeDAe++; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6341cf2c99so171038266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717138669; x=1717743469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3zKbshCSYA/cMA+U0AV3V6eLZi4juLiiPopO0uScF4=;
        b=TaeDAe++0m4Ns6B9zifIbUdv+4nb22aFjinH885cmLjGfdVytsdez+mGx4huERlpWE
         VotWKT7DlrfDsf44L4YmgSqawU7o2MqHv3yLfQXFmFS/l/77Bv35JY7w6bEls4z4FhM6
         /Y8HmqSs5I7ZzyIzw2HgDSxvCwqj9BXTHCc3UK+IvlNLGRreiUaC9dua8ZNEfNscsjdD
         bq30uZ27saV3xD6xF6s6Npsa6eVr7L1cBG3piKAkNPAt/I1uI2vmxEtSZodCQiw4WPH3
         eHN4bRX+ZmR4bbWR7woMiQxxqJFhda75ownrRGdhfPDXfCTOnld8jv4tPi2DPxuverv8
         5roA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138669; x=1717743469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3zKbshCSYA/cMA+U0AV3V6eLZi4juLiiPopO0uScF4=;
        b=fzkw0pzqrPjP6eQ9kwYdkr3cvmwSQ2rFiFcI8SOZhvr9r/poOBrdiDBhestCr0jfmF
         hqBL+RW6rhcUrE5ytj3mwxBwt3lJcBWCqE0/B2JM2zvPk/wG/bpInhBsHmDUQKok+TGg
         nSs2jz5MsdBHePJtBe6zNPf+7zPK1hOxVsKMxrHeDq4Wf7HZgh+dRkLsKkF4BIStgPSZ
         8xJLay+WXtV/xeyOxKo2QzMgb5wToDnfzbLmaH/ZQMHwgchHE1dhqRekH652S2JuXu45
         59Q5KadYfojfeTZYp0TdWr1hmbjByXHv4cQcmzB0c6eNH+P+o/i6L5ps+ZHqIdIDx01E
         pY4A==
X-Forwarded-Encrypted: i=1; AJvYcCUD9SjaYWFGsI+bqwkPGs2eZjawHikdorIKGpw43qT1VScF9+8ObvPQaQkqhIIoUaItm4s59kjLBaNFIiRP6LlVvckpspU8J/pIYfsG
X-Gm-Message-State: AOJu0YzKrVhkXFP4DW1k8dDszMSnVd2lakj3f3EJgpRAfDvzZgJXzwB5
	HSeWblrXVKF/LGZUqGStu/NV14Qb4zR3MBzHqs+27wiJKb3c7PuLWYCshtdIkQ0=
X-Google-Smtp-Source: AGHT+IHKh7xpZYum2rGFe8T9b7OxPvNEJ0hlv1rVuy7vQA537DHUDNfq1OsJivp8xoV77YksfQsONQ==
X-Received: by 2002:a17:906:c34d:b0:a59:cdf4:f939 with SMTP id a640c23a62f3a-a681f87e9e5mr60156866b.3.1717138668988;
        Thu, 30 May 2024 23:57:48 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e73fc1a5sm54205566b.53.2024.05.30.23.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 23:57:48 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com
Cc: biju.das.jz@bp.renesas.com,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	claudiu.beznea.uj@bp.renesas.com
Subject: [PATCH v9 1/9] watchdog: rzg2l_wdt: Restrict the driver to ARCH_RZG2L and ARCH_R9A09G011
Date: Fri, 31 May 2024 09:57:15 +0300
Message-Id: <20240531065723.1085423-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240531065723.1085423-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240531065723.1085423-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The rzg2l_wdt driver is used only by ARCH_RZG2L and ARCH_R9A09G011
micro-architectures of Renesas. Thus, limit it's usage only to these.

Suggested-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

Changes in v9:
- collected Guenter's Rb tags

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- none

Changes in v4:
- none; this patch is introduced in v4

 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 85eea38dbdf4..ecd025dd0fef 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -932,7 +932,7 @@ config RENESAS_RZN1WDT
 
 config RENESAS_RZG2LWDT
 	tristate "Renesas RZ/G2L WDT Watchdog"
-	depends on ARCH_RENESAS || COMPILE_TEST
+	depends on ARCH_RZG2L || ARCH_R9A09G011 || COMPILE_TEST
 	select WATCHDOG_CORE
 	help
 	  This driver adds watchdog support for the integrated watchdogs in the
-- 
2.39.2


