Return-Path: <linux-kernel+bounces-247435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BBA92CF78
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEC51F21B76
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610A5194087;
	Wed, 10 Jul 2024 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5cofXG1"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AF218FDCD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607790; cv=none; b=jGuNiItnBMDzAsNzCaLTO+vQLHPxCGb2dSQ0zd1OtMTnB+1FI6MPZxEJfMn3ClxBGAF84UkvmHn2M8OzuCeTkjYJNGfhV6B5tH+syhvFbyhQrMlNNd9B3c/uJjDj/Ot2u2Q3AO4h5zeCOxsdw5EGAfQpJG9de0sgcl+HE5TM52Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607790; c=relaxed/simple;
	bh=L+ZjCKgJQd3G0PXfqSF2z2XSQSaCrAKVX6BKXiPVSoU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ta+Dt2WLH7nM6qAY5oC0LEuZjSJ3eQ+D9XxUlxvSItbd83ICFs9+NYy6aQgl0UodoE4ebkIAS+Etv4QTA+xzK7WoFjdo+W1WlLn2cUR/vwJVyIxezTWMuFeXeiKfdPE74uQwoJgrXBvOGsU/OCm69edgLx0TUFgdqp9zUHoB5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O5cofXG1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a77e6dd7f72so473844766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720607786; x=1721212586; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YiC5Ast8q9nR3kdM0WnbV9ytZ6Sn5cRnJD9TbOLzqZ8=;
        b=O5cofXG1F5FTXiDem2ZXmdm63Tz7E/sZfwGlp6XBwmu06Wfz0E4DlisfC6plvw2A5u
         zbiqhwrzWLJIwX52TpPpAX/C4MwAaaTrKecASXBhWevtFLzW1k45aSBJxdb6RCIFTy3q
         QXESoHOm2R4gbT4SbTG0opUub+jpauCeltzzn7Wgvl6PQUTfY30bw9jv+4Wu9IWC8sak
         IUIvLoUySWV+pdrnItLHK2XfvKJuO9L8iYZNYaXwa1Zw4Yqps6TObaBvtz8gCesD0C00
         8E03OpzYWrnfEA80lSjiuRIc9oyO6fXpc7IRP9itpM2QwFm5YX2BdiVjHn7Gj5Ubz6ak
         R0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607786; x=1721212586;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiC5Ast8q9nR3kdM0WnbV9ytZ6Sn5cRnJD9TbOLzqZ8=;
        b=ovt8oVTaf0B+/wedoOuDO/+HBoSVo7TKOMmx3oZnjdwztkXNcC/BZlrOpbgT0ZMu8w
         z55vl50OI2Zse/kEcY0A5nj7hYosTBOEUgeDHGrJC5FUVmydGngqz9LFdPZ9Ky9hTX1T
         yFdaTq5RaLCtv5TXScHKQoj87yTXdu6Efczr7QSSgD1IPxjf6VWb0vX78UGwKVx9XLFf
         O//w4f1M1m0IRvtE44jtIuxlr6AgFbFlO+G0nrg5Dbau+aLl5E9+bxSiN12rKl9usxR5
         ChU4kOmFK4TnvlSlQBteJRUPnG84V6X34ru+rvuPtkZoRD0Bm34dX6VcipQlC7+7aAjR
         U1FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf9AHD+vXLukESMsW9M+eZcKyR0pGMOorykiOFriOahTLK4DLF/Fcsr75mvTFyD/Eo7uRbhZORadWVq3BbDX5xANvmeq9B2KBO+bET
X-Gm-Message-State: AOJu0YwGnNnJtevuAhw7phMUMRWNQoIM1tAM3v9okpvlLs8OE0rMvdJP
	c1VUDG9yc2rzBcs3Aj2rkRnBN3t4SlYCkKJXZoOQ2HrVaxtEzqyRa3m0Ld/4W4o=
X-Google-Smtp-Source: AGHT+IE+yjpCcruIKHgr/jvVPlk1m+tPU0e6J3vGdtJfJHpFEX7F5AeCWZd8y9c3wpmTQ6Iekk68xw==
X-Received: by 2002:a17:906:7d1:b0:a6f:e47d:a965 with SMTP id a640c23a62f3a-a780b6ff0ecmr330515266b.41.1720607786309;
        Wed, 10 Jul 2024 03:36:26 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc77dsm146576966b.52.2024.07.10.03.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:36:26 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 10 Jul 2024 11:36:14 +0100
Subject: [PATCH 07/15] usb: typec: tcpci: use GENMASK() for TCPC_TRANSMIT
 register fields
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240710-tcpc-cleanup-v1-7-0ec1f41f4263@linaro.org>
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

Convert all fields from register TCPC_TRANSMIT to using GENMASK() and
FIELD_PREP() so as to keep using a similar approach throughout the code
base and make it arguably easier to read.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci.c | 7 +++++--
 include/linux/usb/tcpci.h      | 6 ++----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
index ad5c9d5bf6a9..b9ee9ccff99b 100644
--- a/drivers/usb/typec/tcpm/tcpci.c
+++ b/drivers/usb/typec/tcpm/tcpci.c
@@ -607,8 +607,11 @@ static int tcpci_pd_transmit(struct tcpc_dev *tcpc, enum tcpm_transmit_type type
 	}
 
 	/* nRetryCount is 3 in PD2.0 spec where 2 in PD3.0 spec */
-	reg = ((negotiated_rev > PD_REV20 ? PD_RETRY_COUNT_3_0_OR_HIGHER : PD_RETRY_COUNT_DEFAULT)
-	       << TCPC_TRANSMIT_RETRY_SHIFT) | (type << TCPC_TRANSMIT_TYPE_SHIFT);
+	reg = FIELD_PREP(TCPC_TRANSMIT_RETRY,
+			 (negotiated_rev > PD_REV20
+			  ? PD_RETRY_COUNT_3_0_OR_HIGHER
+			  : PD_RETRY_COUNT_DEFAULT));
+	reg |= FIELD_PREP(TCPC_TRANSMIT_TYPE, type);
 	ret = regmap_write(tcpci->regmap, TCPC_TRANSMIT, reg);
 	if (ret < 0)
 		return ret;
diff --git a/include/linux/usb/tcpci.h b/include/linux/usb/tcpci.h
index 3cd61e9f73b3..f7f5cfbdef12 100644
--- a/include/linux/usb/tcpci.h
+++ b/include/linux/usb/tcpci.h
@@ -148,10 +148,8 @@
 #define TCPC_RX_DATA			0x34 /* through 0x4f */
 
 #define TCPC_TRANSMIT			0x50
-#define TCPC_TRANSMIT_RETRY_SHIFT	4
-#define TCPC_TRANSMIT_RETRY_MASK	0x3
-#define TCPC_TRANSMIT_TYPE_SHIFT	0
-#define TCPC_TRANSMIT_TYPE_MASK		0x7
+#define TCPC_TRANSMIT_RETRY		GENMASK(5, 4)
+#define TCPC_TRANSMIT_TYPE		GENMASK(2, 0)
 
 #define TCPC_TX_BYTE_CNT		0x51
 #define TCPC_TX_HDR			0x52

-- 
2.45.2.803.g4e1b14247a-goog


