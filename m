Return-Path: <linux-kernel+bounces-521133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B94C3A3B4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8FDB1885AF3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDE31EFFBD;
	Wed, 19 Feb 2025 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bbf+Sdyw"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908B01EA7CE;
	Wed, 19 Feb 2025 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739954277; cv=none; b=cccRghZ9IPhBWzN2gJWrZwbE5ck6oIuruhMWs5dR0N9bOQ3A/vlJmXD3STWVpEQ3EspfUTD6LpaDM/Qb+2LbgzCzyN7QB6W55jmdOOoiOrRerqG3p3+UAuGAAYZWTOTybTRqbHooQkWBQEfqrrsWxwFz6Po6aCj8awuDC08dCVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739954277; c=relaxed/simple;
	bh=/XLK+daHIrD0JUs6qF5Tb18zmYYnPeTNEGxJ9lAE7MU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ALcrvaGCPLVnkynGMdA/rh61Pwg8RJFPdgsAnOXCOIdCDlIzpXqTqZuthCTrmGqOH9gBZvccf4DahNB8d+E5XXfNuGgg2Rp1LQxf/3pNsvuEx7zKANBaLVaC6uJs7dIFq8pJDJeEigMdn4uztHm3kHeF1eQeJq789K1ItGnjMAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bbf+Sdyw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abbb12bea54so399944066b.0;
        Wed, 19 Feb 2025 00:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739954274; x=1740559074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aEMQm4psPyovFJMOlQxIsVIRwEzwiIeGeanslSFpEok=;
        b=Bbf+SdywspqMpK4KjsHvvn6RQQniQ9FrOQkaAMh+dDKGKkb2HZpxHNhRbWp1uvQj8p
         FpsCTrUfWoCea3W6Gi/Ec/OfYQ6hT7LFpjIhwHA164dDE0q1wbFEQnxTA4SiaXsq2yLb
         gHnn94yWPglIuaFLSnTE7UaW6xcPEW4C5e/t7ZYiHsThMSkzxmfhskGZnfj5NfcVRdN1
         r6r4Dan0vniSkdCks9iul0M9AqD6EFn+AnfsaK/aojrGim9g1/a7GXxZPcZroZWhi1yv
         ervgjoxhNFbH7GROxnwW2HePtqes306SSYVVaKuAlYVUWu/ChBVC04uB/aI+0OAYncvM
         1xBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739954274; x=1740559074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEMQm4psPyovFJMOlQxIsVIRwEzwiIeGeanslSFpEok=;
        b=l9aT6Y5exMfzQpspjMNhtXP0kM8YYmHqlRJ7JUZdJ384nrlPo6mvO1EbdCD6Uu2MJ5
         3tIjzipQZmgIn/pb4wT9qyM/WRMaI063dKXjxjqYrPzKMhH82WHk6xZbPCJ6iGyQwduP
         ypz2SM4Z+9ORDK5XTYkN9DXha5tzi/FfHt3zN5X5YialKOoyz1N8LhxUGNo8TiTrPBck
         BkTq1JmcLrEy+ZuMN5+siesQDiQXKomfn4D3isIIiEUcLvV8gS2JxtS1oRRJvW2KzWFR
         +aF5rJZdocjhBabH6sd/YfyB3OhC6vWbZi/LoJcoYuHjklmQM+/GhMsJiupXvn9PKap9
         ylPw==
X-Forwarded-Encrypted: i=1; AJvYcCXG7sE9vM+U125PhggEcuLJVhLLNe6uJjx2A1E8gOuJ56I7Y7Rv87IDZVsnuGO4gCOxb4LIbMTEUPSMoUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+qJuNP3zqizXsC+wO27czd+MnC80WJyxVtWPSLPyFAxol7Ef
	dRchLKV0HEz4nh60X2xLplxeNrzGlUWE4lVyah4WEu0oDNMnBhJA
X-Gm-Gg: ASbGncupDQ54zukoI+2sxMWgIVbtC6RRM8PAset5yYuNN8QBha0vMB7tbo2mWUN2+Ob
	SYcZwuRtB1hBH3WSv2Dzrn0TY2FXMDOg/e/a4Q+BELlWGUj14XQhFPsUH0pMN0vh+Z2eSNpHFWR
	p8PBzxlhIV+8DLljeeAuF44FvZLhiODAF4O9534E3yi2Pm9WOb+Ls3SbVk3FZZeAGG02JCecKwh
	JKT6OkHkw8SoTlHSSmzoRNHhpJZewTOtKrndD0gaYM4hefzpzdLrB1mSWEzj74P4WO7W6oBu/vI
	uzb1vb+V5rjxLA+tSpnMDN4iIdfiDdq7IpE1OxVuL9eWuYhXJMBur0pAOOdCiAvX6Q==
X-Google-Smtp-Source: AGHT+IFIfgmIsE9od5jUiVuNIYBBGDleFzsDrKi//m+gjFVpl/fUNq/U0YkPAcRxvV7z/FjZnsJYRA==
X-Received: by 2002:a17:907:7706:b0:abb:2334:af2f with SMTP id a640c23a62f3a-abb70b18461mr1371333066b.13.1739954273806;
        Wed, 19 Feb 2025 00:37:53 -0800 (PST)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba532322b9sm1224319066b.37.2025.02.19.00.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 00:37:53 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: gregkh@linuxfoundation.org,
	stern@rowland.harvard.edu
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: [PATCH v1] usb: core: replace usb_sndaddr0pipe macro with usb_sndctrlpipe
Date: Wed, 19 Feb 2025 09:36:44 +0100
Message-ID: <20250219083745.10406-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

The usb_sndaddr0pipe macro is only used in the hub_set_address function.
Replace it with usb_sndctrlpipe which provides the same functionality
but would also consider the endpoint device number.

If the device has not been initialised, it is safe to use
usb_sndctrlpipe in this context because udev->devnum is set to 0.
Therefore, this change does not affect behaviour, but reduces code
complexity by reusing the existing macro.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
Even though this patch does not fix a bug it is related to the following
discussion and addresses the change proposed by Alan:
https://lore.kernel.org/all/aa0c06f6-f997-4bcf-a5a3-6b17f6355fca@rowland.harvard.edu/
---
 drivers/usb/core/hub.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 59e38780f76d0..66dfdf0bab90b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -4697,8 +4697,6 @@ void usb_ep0_reinit(struct usb_device *udev)
 }
 EXPORT_SYMBOL_GPL(usb_ep0_reinit);
 
-#define usb_sndaddr0pipe()	(PIPE_CONTROL << 30)
-
 static int hub_set_address(struct usb_device *udev, int devnum)
 {
 	int retval;
@@ -4722,7 +4720,7 @@ static int hub_set_address(struct usb_device *udev, int devnum)
 	if (hcd->driver->address_device)
 		retval = hcd->driver->address_device(hcd, udev, timeout_ms);
 	else
-		retval = usb_control_msg(udev, usb_sndaddr0pipe(),
+		retval = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
 				USB_REQ_SET_ADDRESS, 0, devnum, 0,
 				NULL, 0, timeout_ms);
 	if (retval == 0) {
-- 
2.45.2


