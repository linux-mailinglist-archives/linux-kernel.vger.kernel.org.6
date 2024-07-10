Return-Path: <linux-kernel+bounces-247434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6818092CF75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C8F1C23A98
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9536A193086;
	Wed, 10 Jul 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USJhRoTg"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDE118FDB7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607789; cv=none; b=BPpw8WBjJgnYxn4dA/AYEODS0Mz44AUX7kEG6+nTdfoYTvdUwaPAd+oD/o3Xm/EfRE8gG1S54D70qJx/mdMCZyjGbu9Z5IgRaQj5JlihJ8hlEeE64w3kyky8oAyzQVGW0UU4B3jy+vfG1kI17pqriRdHHr0sopwG7gFDG3uBrBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607789; c=relaxed/simple;
	bh=0vbDgVH+LSdHvPglDs4hdbAbxgr/GDEnxmyEdgVM9sM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXJxbKhLTruHqbDN44RCw8SDjMzUkvhwe3bNW1OcCs2acSJEf22K0Et1rV4lhPl+HPjNkEZ/OZN5LkFfjmqUeEkG25JfbITJB8DHyoHO5CnxXPULJYFdd8G7bw+z9tfrRf+uXDpD92xWbGmteX89a2blw/4RuLWBqB9pCR5lpo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=USJhRoTg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so689328166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720607786; x=1721212586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KpWex0J8opffQtz+HUwL/QKrEncZVAbQ4+K0E+2/CaU=;
        b=USJhRoTgxFgki0VT4S+OdQ4RMBP1d819V979VEXK2VUWPLhaL5W65ba0qrWd4L8WbW
         yWmHD8Ka0DFQW50HXxfQZ4iLInUDUbnA+t3ZZVNFY1gDX762XIGynem3rjM+mP47Qull
         pca15ku0inlkxh7VN1uyYGYQvs+SFuOXmHI69Mcesm0gMIcjXO9ZotjiF48BTt/0ALNL
         0ATNAnYaX0EI45J6LYcCyT2rDdBfsYTkErvJ0Nu7lM1bP7BaChx+9CWvItOr4V48NE+e
         rnqEQBfTOk0PMw9e7TTeQoIuWfuZVEU0yMiliyZHKz0u6Q40l2J6dqSXC0nLxcK5bwgF
         bsog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607786; x=1721212586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KpWex0J8opffQtz+HUwL/QKrEncZVAbQ4+K0E+2/CaU=;
        b=fpbu7utZnUFS2z1gNpdd9T3FWA3SYE33E6Rn4dFjrzyQgcZF/9kUEkP056kOf/aQv4
         xkovwK15Er11snIto4HbbX2oz78SUElcv5cIyPCFwkAKo4prD/sjUpEVko9TqBL1bNDM
         34MV7GpeQMGH+oA9p+2/1eRV/7TFsaozc2BgJ2RfQad9FajZfJepGEqnxVwPQIyoIrjW
         3FtOMlMQ4f9ddR9L0jPket3hHyBJnGb9FIUAEpouRbTCZjVjF9MD0TFhOGBZ79D81CZz
         JF3dad8OS1DRz4sv6cDsFtSKqLNzRm/x7CbFrX8Rk7q50HdtwyK6GgAEcbQuzfJROz+R
         i7DQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv7yVDLc9qgZiRs+9pfiazRmZJxxo8bAOWrd7SoSk6521XSZSSm462pGSm8d1dMILWTUNxcBA2s5pckJxNcC1j7f50AO1uTMQDKxi5
X-Gm-Message-State: AOJu0Yw/iqDlH1j8Qoyb3d804cLXMo74QogjcQa2ASxQj52B5NBNkafD
	VGZq+0ipedVem0K3g8yw3WsLvAEGj1eyEe8hloWjMYjdcR4sehn128DQy9dTa58=
X-Google-Smtp-Source: AGHT+IGbCQykmyEoSZSMY+LIphQ2ikV/yNZ7fum8Hdl9038LaHNouuQhLYHMn+WIDwmXvJrV1rS1Ag==
X-Received: by 2002:a17:906:32cc:b0:a77:da14:8401 with SMTP id a640c23a62f3a-a780b688941mr381186166b.10.1720607785890;
        Wed, 10 Jul 2024 03:36:25 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc77dsm146576966b.52.2024.07.10.03.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:36:25 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 10 Jul 2024 11:36:13 +0100
Subject: [PATCH 06/15] usb: typec: tcpci: use GENMASK() for
 TCPC_MSG_HDR_INFO_REV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240710-tcpc-cleanup-v1-6-0ec1f41f4263@linaro.org>
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

Convert field TCPC_MSG_HDR_INFO_REV from register TCPC_MSG_HDR_INFO to
using GENMASK() and FIELD_PREP() so as to keep using a similar approach
for all fields.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci.c | 2 +-
 include/linux/usb/tcpci.h      | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index 5ad05a5bbbd1..ad5c9d5bf6a9 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -456,7 +456,7 @@ static int tcpci_set_roles(struct tcpc_dev *tcpc, bool attached,
 	unsigned int reg;
 	int ret;
 
-	reg = PD_REV20 << TCPC_MSG_HDR_INFO_REV_SHIFT;
+	reg = FIELD_PREP(TCPC_MSG_HDR_INFO_REV, PD_REV20);
 	if (role == TYPEC_SOURCE)
 		reg |= TCPC_MSG_HDR_INFO_PWR_ROLE;
 	if (data == TYPEC_HOST)
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index 80652d4f722e..3cd61e9f73b3 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -129,9 +129,8 @@
 
 #define TCPC_MSG_HDR_INFO		0x2e
 #define TCPC_MSG_HDR_INFO_DATA_ROLE	BIT(3)
+#define TCPC_MSG_HDR_INFO_REV		GENMASK(2, 1)
 #define TCPC_MSG_HDR_INFO_PWR_ROLE	BIT(0)
-#define TCPC_MSG_HDR_INFO_REV_SHIFT	1
-#define TCPC_MSG_HDR_INFO_REV_MASK	0x3
 
 #define TCPC_RX_DETECT			0x2f
 #define TCPC_RX_DETECT_HARD_RESET	BIT(5)

-- 
2.45.2.803.g4e1b14247a-goog


