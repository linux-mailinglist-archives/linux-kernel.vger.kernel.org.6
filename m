Return-Path: <linux-kernel+bounces-548848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83372A54A06
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D95527A6187
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F83C20AF7D;
	Thu,  6 Mar 2025 11:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBIWW7Mt"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEB8201001
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261835; cv=none; b=XVVj8xsZk5/3FTmWwMEPN5iFXE/fv/qBILnTKogoxUR1eqaXjxn9g0rsgsMVP12vERkhIU7xB5EpxObLiZ0H3h2bi8EmcEdUj+7kqX5m+138jL3ZsFqYXRWD0KbTW6akBKatNfz1DMudOP55x+2L5Dkl0SZizCGyC7/+SSL66eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261835; c=relaxed/simple;
	bh=KW6gKhNVEHwn32fugr/2U2g0sGFhRAaeprfNuQzxcMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cNbeDPqEXFLA1gqtDltBxtR1cYwvuv4sa6nQPQYeetzK5Gu7fH7bRNS7glRkiTT1j4zjk5paGRBSWXckDKvn5ITmJV+f/nicVjVVdD8SCnT890VZmTPh0tf7Zo9Fe5po11oVj9RQCZdODZmTbr2C+CTEkV4RkdY81m0upoG+Y/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DBIWW7Mt; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-543e4bbcd86so713186e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 03:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741261832; x=1741866632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHLEs56MXmKRrOJm00TIGhH5j9WFJFOF+SMISsj0tcM=;
        b=DBIWW7MtfNX9+gR+Ke4+i2JVVq8sXsuYY+QJumWktUmlKcPAlJtrbM5S8GNbGnN/TK
         hSFNIisCNGutu7eI4AOHES6aBsiEzj8unW6nIZg+X5dwfD4g2tfn7I0AKcJz44fNuyft
         q8OzWFBJOgKjCfwOzVUI/koSJYhHy3X35ORXRTqT28ymR+IUpc4UfIDBO0NBjDrnKap+
         EQbIDJxT7V2j3HWIWIRAquzT5ZpQ5HmD0Mxm95lcE3npmBws6mQJjVxeMqNWVU9NPtDJ
         Z1Fw/6xP6zez73FyMNyYjUx1IACCWNIDKSyPUZIstcigE9zccqb2HHOBD7mCKqggDWx7
         UOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741261832; x=1741866632;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHLEs56MXmKRrOJm00TIGhH5j9WFJFOF+SMISsj0tcM=;
        b=LPA+tpxB1986wcYcNFlL0SQKnhOk+/AWQfCgE6dE7HmuBa4sPXT1Pzn1uuEV5bNpZE
         IjClhX3zygT5tGUAxjtBQDsC05CnpGhAL699NTlTMRvAUnZXH+uWK5rnaSkf5s2uS+Cp
         aFwbC/bpfzP60x/ix1uQim9xSULwpxpx1RRVJ2gaAdD9iYpCq8wsfOtIJNec8b98acqh
         L242MYVpH/Okr0l50s3WJbTSE95/DPurhYWt5AFFqGZX4YVMed3nnmseQT0ssmHiBnEF
         BjgkZS8Kilun3Vwx65vLOn205MZfMAqBDpdUpdRN0BQps3wgfunJ/n+CD9TwH0Ur1rR0
         jYDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0MIUCMbjAKVkl5CO6XYHDB/gUxdDnItwt59v1lLLH/AZ0X6xXn2xsJYaJlP2m21TrumxUb3xiGg65TSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM8aXC3phJuQzo8vFidQuuQzPxfkQKCH54U3/icRiFi7s5KoMz
	4U4KVV4a8NjhMe9kFFHt6BN1pY+aJ7GLYkvilUed2JV7OIJTxcedi2dL93U50v0=
X-Gm-Gg: ASbGncsEkk3uFAZImHcq73IObK7AyZxVinfi+ITKaTUNIs+GOdCL1DXzFZxKnwJiAm4
	6iX2AhGXNq8QXlaVy9WxG4CEBD9rqYDX0IzF1IpNXJ6RHAciUX51db0+vrq5ZgC1J9ERWfecGWe
	xLYJGYK94emZlB3KeSh2d5xusuEIu39NBhwbyBfVaK/tWS/59E86QqYn8laVgywqmEJmQK/KspH
	zmAGt367v52vvesX1VyNSUfK38zmODczlcFBhnrWwVoR087UmO98YdlgeGehLvXTQCVqy6eeMtU
	Urk0qzOObAUac3O9/tPV7rVxfoOPSPHzQzorVYKi6fqK51zCKlpiZUqhjzNIIi+8NIqR8B7KIOW
	s/8IK6jsIZ51wvoRUuHo=
X-Google-Smtp-Source: AGHT+IE3CFGsM2+vONvv9cMx7SdQHkTLKhGRwMFX9yWJVCnOit8f9RZqZcfJ9UeVca/gWd2EI8lsaQ==
X-Received: by 2002:a05:6512:4025:b0:549:8f10:ec48 with SMTP id 2adb3069b0e04-5498f10ef22mr35757e87.29.1741261831815;
        Thu, 06 Mar 2025 03:50:31 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1bc53bsm154826e87.191.2025.03.06.03.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:50:29 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Input: hisi_powerkey: Enable system-wakeup for s2idle
Date: Thu,  6 Mar 2025 12:50:21 +0100
Message-ID: <20250306115021.797426-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To wake up the system from s2idle when pressing the power-button, let's
convert from using pm_wakeup_event() to pm_wakeup_dev_event(), as it allows
us to specify the "hard" in-parameter, which needs to be set for s2idle.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/input/misc/hisi_powerkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/misc/hisi_powerkey.c b/drivers/input/misc/hisi_powerkey.c
index d3c293a95d32..d315017324d9 100644
--- a/drivers/input/misc/hisi_powerkey.c
+++ b/drivers/input/misc/hisi_powerkey.c
@@ -30,7 +30,7 @@ static irqreturn_t hi65xx_power_press_isr(int irq, void *q)
 {
 	struct input_dev *input = q;
 
-	pm_wakeup_event(input->dev.parent, MAX_HELD_TIME);
+	pm_wakeup_dev_event(input->dev.parent, MAX_HELD_TIME, true);
 	input_report_key(input, KEY_POWER, 1);
 	input_sync(input);
 
-- 
2.43.0


