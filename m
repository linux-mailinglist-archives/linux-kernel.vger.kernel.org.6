Return-Path: <linux-kernel+bounces-372923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911689A4F4C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 17:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A94131C22834
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Oct 2024 15:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177D018E022;
	Sat, 19 Oct 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S12B1X13"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7E718C34B;
	Sat, 19 Oct 2024 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729352455; cv=none; b=EGDRGihasEq03VtzlXcL3FnFwzhuCdCJsi/ElGoLJ9a4yCxZ1P//zJO7YggYj09RSV5JtTYPyAFWclvkVfCR+QY0xDmwO4pE4V5KfpDG7twx0+pX0O4gzco5bhDrAEt29DQ9DbFFNBEDXravMhEpDhi8zD5BNsZ/Uoo3CzCtH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729352455; c=relaxed/simple;
	bh=MIGPOdo21PTWbv6zESRF7XdStcwjMCU1AGOn2z3JMpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uZiz+FWQEjF2XnOd3BSI78CLoTHDBXXNBVYZ3tVp6H2zxEjc4w5uM3oLMkpRrPzdJS2s5rhnRtXVhYjyE2f1QyZSMzfGSjcANp6T/t8EJoCvPcHPVZo12/Rkq2o9xBahy7m5Q2TpoilBDYdltPdGqTSBWwEvTTUzfssVG+WQ1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S12B1X13; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so2359500a12.2;
        Sat, 19 Oct 2024 08:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729352453; x=1729957253; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kpvlTNyCm02akaAvuo0njQRu2uaU/VS1NFzMgstuUA=;
        b=S12B1X13nQD3WMrnvywJe5LY3RTEU9FVRVubnZITqGRbEvIxU21+6ulU/ajRoeGE7P
         PFvGRCFqHC7OfysFRqRRsyWQWYmhA6x7hGCL4of1+bDbFVYVMOShIiw4iv5GJhsk2tRy
         U4uqGgkgIzePkxlc8m9843lWP72BU9ozWuEPU8DO+9zdgnbdyeBNkg9e4PxmAjM7Jk5O
         atXDMOCO29e3qcyC3j4ghuukwavMSC3R1kqNkeS52M0jT9KfctZy83ONryEBZyt7WetI
         xrAJ7ekCf3b3jbVXHcPLAASLejWqjv2zdd7EwFbNGbxgiQaoSi0WEsp78QgAx2fJxztK
         Mwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729352453; x=1729957253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kpvlTNyCm02akaAvuo0njQRu2uaU/VS1NFzMgstuUA=;
        b=iS2Bo1iouBeWl/nYP6M2cOcjt4kBEB6+Rxi7I5FkcTrKU8g+u95NWm3U58UVSLDEyM
         GCKxpQb5ors5c72ELhRo5PAUrUIXxcfkHr7/N4xr3Ty67xcT+qsfPOTye6e1cgoL+CaR
         8dixwemYNaahWRpr8KskP9gR2T5bqOq3F6lUVQF7Y9GUGvKwXU29R7cp2EpswaF3DhDU
         yBd+jcb6AVyAXHGG1QUZvHmv4oEMx8Dy/rZ8IDxfSie+3QM2B8dFE/I9eZhkyxE+9zza
         f5x/FJuk7+RBnhw2ajIe+K/MDujgzSWaC+FreuJ1eFJIDTWyIb7QhCCo6XiXvCoa83u6
         cG2g==
X-Forwarded-Encrypted: i=1; AJvYcCUPTzG1tBlww/7t/ZBwUNZYv7Q8sG2vCOBNS6XKWLa/gjrGBa/YeM4ltX/jhV7iaomXfdkY1TdIHPrHOSQI@vger.kernel.org, AJvYcCW3kbX/oENvnXN18G9Q3ER11PAG8d1ffqUYk3Ae5WQ0HqVyQs723luGxjtl2OeX0RUuiCPjknyKjmu9@vger.kernel.org
X-Gm-Message-State: AOJu0YyGKA05MvSNuceARLWgr0AS1A0sTZq2UDcIU0lmpVuTBHf/7HMy
	ujGzS/US7ituvMDwIkSQqGlk9SoZ9fIwnYlFRUiKm8l3WZn3PbuH
X-Google-Smtp-Source: AGHT+IFdLrj9ecgap3E+CV4uniSSefMCOxPr2gq2twi75rct7WYFoHMPbtABci+Q0/SowtSf0WvsXw==
X-Received: by 2002:a17:90b:1d85:b0:2e2:c6c2:b3d5 with SMTP id 98e67ed59e1d1-2e56171dbe2mr7135012a91.9.1729352452752;
        Sat, 19 Oct 2024 08:40:52 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e55d7ade96sm2781319a91.1.2024.10.19.08.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Oct 2024 08:40:52 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Sat, 19 Oct 2024 23:38:05 +0800
Subject: [PATCH 2/2] ipmi: ssif_bmc: add GPIO-based alert mechanism
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241019-ssif-alert-gpios-v1-2-483eee5f99d3@gmail.com>
References: <20241019-ssif-alert-gpios-v1-0-483eee5f99d3@gmail.com>
In-Reply-To: <20241019-ssif-alert-gpios-v1-0-483eee5f99d3@gmail.com>
To: Corey Minyard <minyard@acm.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Quan Nguyen <quan@os.amperecomputing.com>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: openipmi-developer@lists.sourceforge.net, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Cosmo Chou <cosmo.chou@quantatw.com>, 
 Potin Lai <potin.lai@quantatw.com>, Potin Lai <potin.lai.pt@gmail.com>, 
 Cosmo Chou <chou.cosmo@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729352444; l=2721;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=PUD6kC7ss3fWPkXsFlsDDO/XmHqy3YarK27U7zFcq0Q=;
 b=2u8vlc9BMIFn8F0V/Ypep6jH2SfZWpPZ7MTD1f9cjupP6HhxPFbYLnyKovj3E7PIGZKWC41Wp
 r1I0R1vIRB3D9QI0RQG+wvSp/E5VPhf7lQO7/Fc185L35HpT3J0+n8l
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

From: Cosmo Chou <chou.cosmo@gmail.com>

Implement GPIO-based alert mechanism in the SSIF BMC driver to notify
the host when a response is ready.

This improves host-BMC communication efficiency by providing immediate
notification, potentially reducing host polling overhead.

Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>
---
 drivers/char/ipmi/ssif_bmc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/char/ipmi/ssif_bmc.c b/drivers/char/ipmi/ssif_bmc.c
index a14fafc583d4..73be166b0042 100644
--- a/drivers/char/ipmi/ssif_bmc.c
+++ b/drivers/char/ipmi/ssif_bmc.c
@@ -17,6 +17,7 @@
 #include <linux/spinlock.h>
 #include <linux/timer.h>
 #include <linux/jiffies.h>
+#include <linux/gpio/consumer.h>
 #include <linux/ipmi_ssif_bmc.h>
 
 #define DEVICE_NAME                             "ipmi-ssif-host"
@@ -102,6 +103,7 @@ struct ssif_bmc_ctx {
 	struct ssif_part_buffer part_buf;
 	struct ipmi_ssif_msg    response;
 	struct ipmi_ssif_msg    request;
+	struct gpio_desc        *alert;
 };
 
 static inline struct ssif_bmc_ctx *to_ssif_bmc(struct file *file)
@@ -222,6 +224,9 @@ static ssize_t ssif_bmc_write(struct file *file, const char __user *buf, size_t
 
 	/* Clean old request buffer */
 	memset(&ssif_bmc->request, 0, sizeof(struct ipmi_ssif_msg));
+
+	if (!IS_ERR(ssif_bmc->alert))
+		gpiod_set_value(ssif_bmc->alert, 1);
 exit:
 	spin_unlock_irqrestore(&ssif_bmc->lock, flags);
 
@@ -584,6 +589,9 @@ static void process_smbus_cmd(struct ssif_bmc_ctx *ssif_bmc, u8 *val)
 	memset(&ssif_bmc->part_buf.payload[0], 0, MAX_PAYLOAD_PER_TRANSACTION);
 
 	if (*val == SSIF_IPMI_SINGLEPART_WRITE || *val == SSIF_IPMI_MULTIPART_WRITE_START) {
+		if (!IS_ERR(ssif_bmc->alert))
+			gpiod_set_value(ssif_bmc->alert, 0);
+
 		/*
 		 * The response maybe not come in-time, causing host SSIF driver
 		 * to timeout and resend a new request. In such case check for
@@ -640,6 +648,8 @@ static void on_read_requested_event(struct ssif_bmc_ctx *ssif_bmc, u8 *val)
 	calculate_response_part_pec(&ssif_bmc->part_buf);
 	ssif_bmc->part_buf.index = 0;
 	*val = ssif_bmc->part_buf.length;
+	if (!IS_ERR(ssif_bmc->alert))
+		gpiod_set_value(ssif_bmc->alert, 0);
 }
 
 static void on_read_processed_event(struct ssif_bmc_ctx *ssif_bmc, u8 *val)
@@ -808,6 +818,11 @@ static int ssif_bmc_probe(struct i2c_client *client)
 	if (!ssif_bmc)
 		return -ENOMEM;
 
+	/* Request GPIO for alerting the host that response is ready */
+	ssif_bmc->alert = devm_gpiod_get(&client->dev, "alert", GPIOD_ASIS);
+	if (!IS_ERR(ssif_bmc->alert))
+		gpiod_direction_output(ssif_bmc->alert, 0);
+
 	spin_lock_init(&ssif_bmc->lock);
 
 	init_waitqueue_head(&ssif_bmc->wait_queue);

-- 
2.31.1


