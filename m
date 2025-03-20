Return-Path: <linux-kernel+bounces-569814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285A0A6A817
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FDD818862C3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758CF2253A4;
	Thu, 20 Mar 2025 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQKm0sLe"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F089222595
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 14:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742479256; cv=none; b=oJrlbIWvfQtsml6GEqOJLOP+QmiEFiNIL8LqCoCF8MzWsjyKi1bg5b0BjRGncKqUM7hdo9aBwFu98TFjHX5IEPQEocGUAthOHEDy8UC5hY+/+/5qHkTWhTYuUfdQbVdIC3Vq+Q+6LKSOVW7e8nQUqVsNtfuBN1TJRVaXfUZKo/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742479256; c=relaxed/simple;
	bh=j4UBzDHgk4sG7kqb/Znxr+FvEZ/5sfuewiW9AIFkVSw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kpLvbUZkO5MxhkYuwFGV1c4etDqS4jeISMTe54cIRZAjDQePpASrgHIQio219SvjW8K6mQWMCpQTL/x2BAmStpdg91r/RRo2R9DL7J4agnAo8WhA/bi8ujhb2EmIJmiM+708cyY0lEYAj7J503T4EtftqEmU1EOHfsJag+qqZJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cQKm0sLe; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5439a6179a7so904047e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742479253; x=1743084053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c1plaKCpUseZn1Yu08x42hT09CM3UN2ZDD1b7XB7y9s=;
        b=cQKm0sLeTjuwdlVVvYLjN9asI7wj2qtKjMsKwagbLBhQsuKFjOROR4CefAp/TMN9KL
         BU9SMUv3CmjzGVxwiwG1ikgSm1FlU2axBS0yT7smPmWGRTjH2EL2G8hJHcvIW5L2iWtB
         ue7WqJ2vAnZYF/VI7N3A339gVTUkTB5GgGJAk5TISCuAz9NoK2hz4cPJHy+A4UrLGgtJ
         KHZ63nhfwmUoTVTIqiktk08sZZ8UPbSS3vaLaYlbPx67YtARPqe/f1eu+qEm3RZE3N3+
         XpJGI4IIqBGAZuJlhJm2FAjqNeoQqogsaGXckcI8eiB30ztKRhPhGVz/UoAfG6ljdXQx
         9p0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742479253; x=1743084053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c1plaKCpUseZn1Yu08x42hT09CM3UN2ZDD1b7XB7y9s=;
        b=b2iVTRlSSYr3h1lc6Rb1N3B7Z6IwO9byAPFJvcJiu+R6SbyhChxfwAldlvDuuNhm6C
         +F7rmG7J51JboXPpxcmyb1kDWc82lPJRBzBQ5Upz5hq/tjwGM2j9y6ugTZul1apF/EQ3
         xsLG7i6koTrOROgI6iAYZjJFewxv35u9DDqWW+Q1WJp3aQkWXQdivF+v75mIZ49M+TMa
         eXGWLHVTq2xG81IWVzAJokbrLQPnyntAGJCpfbP2iwkokq7ENS7aTcTLZ/aLBweMMbSD
         D4flRmEIRwhgD8UieZkWTKuR/oMvqPTWugZPe5Kd7Ml8+Q8uuLVdT7Y2DVjBWne0A9io
         qohA==
X-Forwarded-Encrypted: i=1; AJvYcCXKbCLQn0G/8rsTJAdy63oKHg9Y77hL7P9WGN/QYJijqfJnqGcIrrF2QcygCnhribNx0u+rKFa7RfotbiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2xJtOXnoTWrXVgUNmY2RWBuN5S1s1HcV67atAuEsHZHMIkqyL
	japQCVkuxzaT9SoW7lHNzY++PAdul6uV3zpWnDX3gm9RA0GoW4lugIz0HSrSRRw=
X-Gm-Gg: ASbGncvRtCkejwQKaIfknUdUBdxMzk0b+7S+5joqE69RQONrTTVs2cx7AJDa9IhJ8g9
	8MBJeXwRxhJ7RBdIclQrqEUlBNvgNa/U9DuxacTkRew5KYYNNobJPTTsgABLZm3zoyQqclcTo0c
	OMcEaHHeC2x+GMUKqumOxpGG51LC8aqJo6GBjHtAFFUre8MmeVrs1MaTqkWRRLnyArf6mraDwax
	qJJ37OIdEuoB+poKFIaQKfE81d3HFS/t4O3VQ/StvTmqsvy25i/VgmeekzcmZPRDqNXN4xS6UU1
	xeS36MqeEg+LFYYU3a5PWc7JJ5hHBTxACUg7rohOwRPDS5xEaz8vyXAf/nh6lAo9I8JWbMbXgq6
	zN7ymuViPCQ0V+m9TgjA=
X-Google-Smtp-Source: AGHT+IGLDkayWqw+uQ+t5WY6cfFF97KDSfF4dlhtyKOD98B93BOTyBSUBT6MzlDFFxBRVZdolYijWg==
X-Received: by 2002:a05:6512:304f:b0:549:6ae7:e679 with SMTP id 2adb3069b0e04-54acfa79c17mr1505467e87.3.1742479249732;
        Thu, 20 Mar 2025 07:00:49 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba864dd9sm2295029e87.148.2025.03.20.07.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:00:49 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: linux-mmc@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] mmc: core: Convert mmc_can_poweroff_notify() into a bool
Date: Thu, 20 Mar 2025 15:00:32 +0100
Message-ID: <20250320140040.162416-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250320140040.162416-1-ulf.hansson@linaro.org>
References: <20250320140040.162416-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's really a true/false value that matters, let's make it clear by
returning a bool instead.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 1522fd2b517d..3424bc9e20c5 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -2007,7 +2007,7 @@ static int mmc_sleep(struct mmc_host *host)
 	return err;
 }
 
-static int mmc_can_poweroff_notify(const struct mmc_card *card)
+static bool mmc_can_poweroff_notify(const struct mmc_card *card)
 {
 	return card &&
 		mmc_card_mmc(card) &&
-- 
2.43.0


