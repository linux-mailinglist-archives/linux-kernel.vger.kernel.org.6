Return-Path: <linux-kernel+bounces-196383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C4A8D5B0E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE8DFB258C8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 06:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8091132C39;
	Fri, 31 May 2024 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ARoHmKXL"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C23C80C02
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 06:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717138685; cv=none; b=t6+iI2t+nVcPZ56tsGxBfJdHbc8o5cxvn1u4Ew7DZ51X2rZNdAqaxJVg+jqPxxeSnPcgrj8or+KsY/JkR5Sn3G8e8TSht67VNcvxWk4tEEbJT3Hn7xbQe6pEQ5EyK6W5LDJE+m7GGM3AN9tTWZGuPee/ftnHDygl8rjCX6lBaJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717138685; c=relaxed/simple;
	bh=tataYpIwbqjUNC38Cpqdn61J/E/LMYXIwOZFRNJQDg4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hdysFtTsvupqfYfQU1UevZU34YgRtlqzeeLphtGursinA2HPSiFT5/L5nG+PeZALvZ2KqyUtB54v9uXEH8SA+GIurVp34d6qp+TJts+BR3UZ1uGlZVWlyygHefrSzmv7NrYmRmIBMjBNt1fCYaoTXiOK4DgjKkP9mJjjWvZAwpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ARoHmKXL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6267778b3aso135654866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 23:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1717138682; x=1717743482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XSggwFbXR3Z6yEAWH/Qxl5wRCutoL0pDxIi0O5Vr5vQ=;
        b=ARoHmKXLWi+DJoag6NaryfEzF0fAWvYX+XaKdTw2Cr8krH8M7BRYb9cb/0QDiRIIED
         pF9/b2+igGbOMezoZrdq3lJRglD42KAYOF4CZ5/JEnCShYZkDQbXD5ljr+KWG118mvl5
         0pI3KxHYie2abDYrIt/bSQT1oYfdP5hg+KH6wS9acn+NUk5TO5tU9wKLixVi2nfVxEDB
         rrFdsfdS3FPGhH92MlwwFnnCjBBLVsC/diqnzo6rfCIZRnSpDCfsUTuBTsi1ej+/mYUj
         lGCCtPQG9ZReOLhRhzIidN4OwwaBhQCoZDZzsBPMCMJSKwZw2nBCltouFRVUPTYVuVnw
         //gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717138682; x=1717743482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSggwFbXR3Z6yEAWH/Qxl5wRCutoL0pDxIi0O5Vr5vQ=;
        b=kSrRzUleyojAS3pfjnTOrTfwTxK8fCfkhw4aBdB5nWGwGGAUQnSl3aCJPPZ+e+QuAv
         5FY95i3rl5lt17W2OEKYM6dSCoFi/c6tdF8sTkkkaJuK684/Bfz0RH1oEf8cK8gqA0UL
         /SzqW8g1NCC9iWgRew/nJHZuTsRHHUpJ9O5C/nwPIsYgosJp37vhXPh17AUPP+PggkY5
         Q0wynmN4DTfreL3Yy3y3DC17c5J0blxnaF64s6ZBOnL8+i1qNIMLZCuXR3Ws2Jb7rdzI
         VEx+Mpw2PCcRkYS9XatIiT9Z7GTF3K7Az/QnyuK20/sdH/KNpx97+AV7eq+xRgwTjM98
         Gpvw==
X-Forwarded-Encrypted: i=1; AJvYcCXXS3THcnNRRkhicc135lAefZ/4QIh3waJ8yViLBryAhxDmT/9roTGEc3SwSpQwuhP1pMdAFj3Pkd59dcCH0tAY7KYU64LWx85nNuPX
X-Gm-Message-State: AOJu0YwgKvqFsfz5EuXUNp1JigM+9SKB8RxabW3gfMIT5O3JcZRFZHEp
	/VX+O1eRWGdS5W/fXHoafS4CUcbTR/zfRB/FJ7OQnDfyWsZ80XiIIpJvJ1dK94M=
X-Google-Smtp-Source: AGHT+IGqZzEldpU1/algbNdzWdRvgU8R3XkGrHfgM9jfgkXwYF5W+sjHd4ln26EEr1jRdXi+TqJwiA==
X-Received: by 2002:a17:906:df54:b0:a62:2eca:4f15 with SMTP id a640c23a62f3a-a6821b7167bmr57133366b.48.1717138681893;
        Thu, 30 May 2024 23:58:01 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e73fc1a5sm54205566b.53.2024.05.30.23.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 23:58:01 -0700 (PDT)
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
Subject: [PATCH v9 8/9] watchdog: rzg2l_wdt: Add suspend/resume support
Date: Fri, 31 May 2024 09:57:22 +0300
Message-Id: <20240531065723.1085423-9-claudiu.beznea.uj@bp.renesas.com>
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

The RZ/G3S supports deep sleep states where power to most of the IP blocks
is cut off. To ensure proper working of the watchdog when resuming from
such states, the suspend function is stopping the watchdog and the resume
function is starting it. There is no need to configure the watchdog
in case the watchdog was stopped prior to starting suspend.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
---

Changes in v9:
- collected Guenter's Rb tag

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- remove the usage of pm_ptr()


 drivers/watchdog/rzg2l_wdt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index d77290f7fdea..2a35f890a288 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -286,6 +286,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 	priv->wdev.timeout = WDT_DEFAULT_TIMEOUT;
 
 	watchdog_set_drvdata(&priv->wdev, priv);
+	dev_set_drvdata(dev, priv);
 	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
 	if (ret)
 		return ret;
@@ -307,10 +308,35 @@ static const struct of_device_id rzg2l_wdt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, rzg2l_wdt_ids);
 
+static int rzg2l_wdt_suspend_late(struct device *dev)
+{
+	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
+
+	if (!watchdog_active(&priv->wdev))
+		return 0;
+
+	return rzg2l_wdt_stop(&priv->wdev);
+}
+
+static int rzg2l_wdt_resume_early(struct device *dev)
+{
+	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
+
+	if (!watchdog_active(&priv->wdev))
+		return 0;
+
+	return rzg2l_wdt_start(&priv->wdev);
+}
+
+static const struct dev_pm_ops rzg2l_wdt_pm_ops = {
+	LATE_SYSTEM_SLEEP_PM_OPS(rzg2l_wdt_suspend_late, rzg2l_wdt_resume_early)
+};
+
 static struct platform_driver rzg2l_wdt_driver = {
 	.driver = {
 		.name = "rzg2l_wdt",
 		.of_match_table = rzg2l_wdt_ids,
+		.pm = &rzg2l_wdt_pm_ops,
 	},
 	.probe = rzg2l_wdt_probe,
 };
-- 
2.39.2


