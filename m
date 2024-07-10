Return-Path: <linux-kernel+bounces-247437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F11CB92CF79
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9D01C23919
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16691940BE;
	Wed, 10 Jul 2024 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MeLVdz1U"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F241922E7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607791; cv=none; b=MHvdTyU82h+gYtCUMsG/sOWBwAEVICb0vPjX3hCK+F7WwU4sM1Fhk298A+z+yNTmYTDCRoBSXrgSeOgnfi3sD4Z+WjkTkkxf+0NosAJh6weI/0MYp75497Xr3DgoM/vxNr1gurPEpvHT0PspzK/ppOq/TGfy5siHRhrBgbb3+L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607791; c=relaxed/simple;
	bh=Gh7tR4aP9b3dMS0ig0OinTPBM3NkuA777qx/jRALIJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HqIhxlAz1VoNAKWpahn1bf8oTlfUmms7rr9MqZGbbOjIg0Es0gS8m9D49l9xArGawlQ4rN0zdgywVsod1QbYCOWjmP/frf2xHQBCnPuZXys3Jj5iAJ1vkvLA5pVqB+sC4R//3oyFhDZSgeS+gGRFM5J405nC6qG8SvoIkEl0tCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MeLVdz1U; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77cb7c106dso628610066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720607788; x=1721212588; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WjiPMEKAWGEGZZNGnZ5jjN6tgFH5yhFtTqyqgRl8h3E=;
        b=MeLVdz1UA7b8E76eKlPSLQFo9v78NM8jo11fLJlWW5xsmHpvEtIqewy8EjQ0YPcRIZ
         588IxYu/Vhy4fDnW0GGbO4hlU5sKsae5amiz3AVgw5XSAQoZ1y2429Y2h0ra071bD3Zw
         Pvm6btEKO8S6NnMoRu9KClBYri44stFdEr+EAfJx5yOzNX1w24qhpGszaPm1f9hcWkK2
         Ja42NT96mN5v96SIwCdPgwEElXFqQ6YM3WIPuK/4XK75A/NGPhZXegYlwjJDq85d7RO/
         ik7d3m2goVUuWeplFuKizPTnTZA/wvX/txdl24TslinNR/CQfWAuNHoFf/h9TF5N3cOW
         bDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607788; x=1721212588;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WjiPMEKAWGEGZZNGnZ5jjN6tgFH5yhFtTqyqgRl8h3E=;
        b=naKYankFFXHu15JizPL7qD+zPsCSAvz8P+r4QVkbE6vBlpvsrFAdKNf12oAQmSqf1B
         lxYxnl/W+iMFCyKoHnwkrRQdlV3J/OV+oE79sbs6R6rCh6Aa8ZFueFI2u/6WYp2evdQu
         FBF3/qyao0Iyqj3BI7ZIb+jbVI4wEqGLvCZPk/y4Tghh8QhZbnpZnVmzgBNyG875zCgk
         uRASuVGeeXxEWBsxeiUU9IGeAaXZ/u7s5hZtUL7tfhJxuxw65ieh6VbP+gWnJ2y1EyMQ
         sG0m9JdA1x3Z/UXxQFMNmVDZPn60OaQo/SCg1MeHbxQ31SBLX1dv18XJeIK1Mxp2NlhR
         VFiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI7iurxDaXfO2D8fkPyHawfwjNguoa5pJmoMNfVNqGQYxdoDKxuSJOdOWGpKk7Ip+nQ120EWjN941ST0k/9iH1X4WfR2d46p7nevyd
X-Gm-Message-State: AOJu0Yx9b3j92Im1sjinC4HR2C43NAPEbLF5n/ndvXS38rzejEa27Pge
	6HrwLHdkrPzsKJudVrotqkjURcVRH00/rgwSgriDiIMGBZ5/9g1P842IUoeLWEg=
X-Google-Smtp-Source: AGHT+IE5hxKfVWgP9N3rYz80ioQEE8TEjgdhOaRO1OuJCq2mi7IUtcanoHfuvuVGxv5EDLkBBXZiWw==
X-Received: by 2002:a17:906:1782:b0:a77:f2c5:84c4 with SMTP id a640c23a62f3a-a780b68a1d4mr333328766b.12.1720607788116;
        Wed, 10 Jul 2024 03:36:28 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc77dsm146576966b.52.2024.07.10.03.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:36:26 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 10 Jul 2024 11:36:16 +0100
Subject: [PATCH 09/15] usb: typec: tcpm/tcpci_maxim: simplify clearing of
 TCPC_ALERT_RX_BUF_OVF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240710-tcpc-cleanup-v1-9-0ec1f41f4263@linaro.org>
References: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
In-Reply-To: <20240710-tcpc-cleanup-v1-0-0ec1f41f4263@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, 
 Badhri Jagan Sridharan <badhri@google.com>, kernel-team@android.com, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

There is no need for using the ternary if/else here, simply mask
TCPC_ALERT_RX_BUF_OVF as necessary, which arguably makes the code
easier to read.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index ad9bb61fd9e0..5b5441db7047 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -193,9 +193,8 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 	 * Read complete, clear RX status alert bit.
 	 * Clear overflow as well if set.
 	 */
-	ret = max_tcpci_write16(chip, TCPC_ALERT, status & TCPC_ALERT_RX_BUF_OVF ?
-				TCPC_ALERT_RX_STATUS | TCPC_ALERT_RX_BUF_OVF :
-				TCPC_ALERT_RX_STATUS);
+	ret = max_tcpci_write16(chip, TCPC_ALERT,
+				TCPC_ALERT_RX_STATUS | (status & TCPC_ALERT_RX_BUF_OVF));
 	if (ret < 0)
 		return;
 
@@ -297,9 +296,8 @@ static irqreturn_t _max_tcpci_irq(struct max_tcpci_chip *chip, u16 status)
 	 * be cleared until we have successfully retrieved message.
 	 */
 	if (status & ~TCPC_ALERT_RX_STATUS) {
-		mask = status & TCPC_ALERT_RX_BUF_OVF ?
-			status & ~(TCPC_ALERT_RX_STATUS | TCPC_ALERT_RX_BUF_OVF) :
-			status & ~TCPC_ALERT_RX_STATUS;
+		mask = status & ~(TCPC_ALERT_RX_STATUS
+				  | (status & TCPC_ALERT_RX_BUF_OVF));
 		ret = max_tcpci_write16(chip, TCPC_ALERT, mask);
 		if (ret < 0) {
 			dev_err(chip->dev, "ALERT clear failed\n");

-- 
2.45.2.803.g4e1b14247a-goog


