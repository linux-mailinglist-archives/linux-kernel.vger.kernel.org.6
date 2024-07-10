Return-Path: <linux-kernel+bounces-247431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF24A92CF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A38451F22AEA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69044191F95;
	Wed, 10 Jul 2024 10:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tY5w+BVA"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4BB18FA04
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607788; cv=none; b=AmIS/yDX2yhrpQWs6j66WUTJNrHOiIlhAcoXR0WdLHI1lE2QmaztTLfpiT4VkVswJfLkF1U+old6upxbNO861u403J0VluyZETy1Rn2B+Sp1+CO6hCbAJRODByDVBC05XGkY4eNesWoWJV2gPHREig2CHwCxhM5wd/Iskn2s89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607788; c=relaxed/simple;
	bh=mil0Paw7dKSF+yYmtF7z93+PPTbySeNKiljnw4gmtA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B7umf58klqkbeYfQ91sU1MdiGNz/hrpwIuR/j2N7fgg/wjhlz3xwY88hksNTKqrmoDh/O7Bp+VK24LGf2qKB/uGD4+yFB5VVYxIBUyZYlpSzxxbMzEN9nI/Hq2KPmIubtCh/vbnEH9aoTaokTXxKPnQUV7gjvbxr19IyanCUX2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tY5w+BVA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-58b447c51bfso7805012a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 03:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720607784; x=1721212584; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ugko5125K/DlhjBE+oAKmwE1ZDstjFq/scQfmJhd89w=;
        b=tY5w+BVAKh/Jbp1CuBRSpHMzAMn4dc/KnCJZF9W/turj5AR40sYiT/FFH0DqHzzI7M
         ZfwHV3y/tosY3DwpHVdCHDEHi06LAxQvEGbGsOOd8h64iwhg2X1nhc1i25Emx6TevizU
         MJUr91lTl8ovxB+uTgAeOaEus34YoEMjdB2qIVPxKxh4DP6FEvXWezZ4SnDa8ldoZvTh
         EamkVQ9Z2Lu1c45Nrm4BxkuvVFzDDQO/prWV72lSn///mQmC7Ed6kLjU+q+XoBHTjf+B
         h1JJpF85qC7bwhh+Zsmz8qIe97Sz31sRcCOu3lw48V9cEJmrlVVOl7LdqCANOitrALVb
         T/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607784; x=1721212584;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ugko5125K/DlhjBE+oAKmwE1ZDstjFq/scQfmJhd89w=;
        b=mxj7qN35zVkU/3Xi247bclupUqKwbtt37gcRPROE9fnL+3MFicDCnkAXM1Wtq1pYuU
         IFeBlj0GI14cLAQutleFjOTLqcbfZ1+CmwCCdxyCgeBUm+MzEndxQPemhhAh+cy41DuN
         dJKjt4tT/OVhwsHrxgWVOM37LF9kZnSpHIZ0dMGSTXdrla2TuhvVHmRtYBe5xd5kvMaS
         u9U2G5Nui1baAZLnc2aF0irqjcufl8dqTeIkZMiNOBL9wQnts+prJJFVKTaJz0IJTGEq
         GcyTHnMRpOkpeg1QN6Cpe5vCKnLdFF7uDsZsV2kB/dOXQhdQ4O9f8zy9O9gw7BLQOjYw
         H1GA==
X-Forwarded-Encrypted: i=1; AJvYcCXAtyBajRJrWpkw2ZoxiKr/RhmkgNS5ZxiRi3CIPC3URvEt2epWi2MmB6OtFKpkyTPq6YTDR8ts2bnFvxfwCJEGO6ZFyAZYBlqBfzmS
X-Gm-Message-State: AOJu0YxIe2yFfBzak1Ng4zcerxNWEx9xKXDMe23Mm6sv4sYAj4niNCtK
	X9YgzhviDnPbsKuAg9J9jSLe/f4Pn1THYUuBcoiSULdaCLSVaEqL91XU+f8WI90=
X-Google-Smtp-Source: AGHT+IFn15u2cejyFoefO6hJ902KlcwxPbEv119zyj3cGShttSJFkxT2Jd9K7A4TdHzThGIHgNPh9Q==
X-Received: by 2002:a17:907:7717:b0:a77:daa9:402 with SMTP id a640c23a62f3a-a780b6fe400mr324241666b.35.1720607784079;
        Wed, 10 Jul 2024 03:36:24 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc77dsm146576966b.52.2024.07.10.03.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:36:23 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 10 Jul 2024 11:36:09 +0100
Subject: [PATCH 02/15] usb: typec: tcpm/tcpci_maxim: clarify a comment
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240710-tcpc-cleanup-v1-2-0ec1f41f4263@linaro.org>
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

We loop while the status is != 0, so rephrase the comment slightly for
clarity.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/usb/typec/tcpm/tcpci_maxim_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index eec3bcec119c..87102b4d060d 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -397,7 +397,7 @@ static irqreturn_t max_tcpci_irq(int irq, void *dev_id)
 	}
 	while (status) {
 		irq_return = _max_tcpci_irq(chip, status);
-		/* Do not return if the ALERT is already set. */
+		/* Do not return if a (new) ALERT is set (again). */
 		ret = max_tcpci_read16(chip, TCPC_ALERT, &status);
 		if (ret < 0)
 			break;

-- 
2.45.2.803.g4e1b14247a-goog


