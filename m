Return-Path: <linux-kernel+bounces-375395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B11F49A956D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 03:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357AB1F240DE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 01:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C4513957E;
	Tue, 22 Oct 2024 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3N0BImI"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F485C5E;
	Tue, 22 Oct 2024 01:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729560211; cv=none; b=tldunRGOv04rhLbeg6phTOz+OVJH+uNcBjNzp0aqhBcplE+4LL2AKQc+O9BQsODyqm0Ar/2+T5NwI86uMDKzI4l9oWAcHa+dCuESSR23fBKbJoWHdVbJqGZDAXR/r0xERF1YdAS/TH2svVzHJy93j5ZLsd2ejP7n5i18ymFNZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729560211; c=relaxed/simple;
	bh=MIGPOdo21PTWbv6zESRF7XdStcwjMCU1AGOn2z3JMpM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r1PdolKxteYa5FNimSIz/vNLcfaqOP8njSg/+irPPkG0Jh6HKRnDA6SAeepzWtz4h+l31i+UqnKo+bF6jF2W85qXmk53SFg8O2byozwS3GfLMJQojZJSJBjIFX3DGMIUQnUmjdE17W4Ln/e5/Iu2jvInxxK+C7gaUYmV3akK1os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3N0BImI; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e2dcf4b153so3709752a91.1;
        Mon, 21 Oct 2024 18:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729560210; x=1730165010; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0kpvlTNyCm02akaAvuo0njQRu2uaU/VS1NFzMgstuUA=;
        b=c3N0BImIvY5cduUTvGafDkpAAOEwHY+JnLF3cn+rzCewOqnUDpAvUu/koxgLaN/N5Q
         HnZuLT5srW8CrhcOUcjrdw3464LBmipm8Wa+YudvFwyfbtzVVPqtCLQXfvSTuZ1GLXqm
         4EPWNo5aQYUfxaYdmgMkEOVRBy9WVjWCMifaW6SNrYXJ+LapbPSXDP4iLKmtyZqA851v
         SLASUkbhoimnw8YCxbJOE0Uc3aJMRUqJgo2z9clppBhpKr8ahQqx1hh4ENFoADfPl+Dv
         fDMOY69cIeCpB0k7evLnyNrxD7XxlgsTOXRGy7dByiXQ3vANVeJ9QrsyOGrgqfoBiybz
         XKEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729560210; x=1730165010;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0kpvlTNyCm02akaAvuo0njQRu2uaU/VS1NFzMgstuUA=;
        b=OKI930XPd1dixvTGa98LFN6O+GUyh/aA/CR4KB5dvfnJbhIk3b6JFSJY20hoMqtDo2
         IaXudvjCqk9jITvXNAcqs+gEvUqU7NNBMg4MfySEhl8QgUbaldNfmWK/udMLsbXm5Ee/
         sXtkLa2vqJlvX6IUlglTN0E3rgp0syYEVvDogPklXDtVo60ela+KJ/k2i2JoftZS60Nu
         qLFpaXIwREdgSNh8SQe7tTGafttJpygD6Q8Ji5U7QqKl4UCg+wbjD8ALW6HfBEoPaX6Z
         lMD+5HD4UpqLi4oE8DTwK3gjBeGXGyeFIExyLykxqs7OPWHABnYo0FB7bIebWFceszdg
         kzgw==
X-Forwarded-Encrypted: i=1; AJvYcCWoSv2sdmt1SD9ydDVEF3kUbjKw2+++Xmbk1+a3TLYnkTPHJDW9Jyc8jvNXVfnyQ2wi6rGaxxZxoilZ@vger.kernel.org, AJvYcCXZ0i0QsuCuQimMWb9Q6mMPfU6NCUihCO4ofSUWICB0SckMFgTrRdE6spLeZfazHHONHjptMohw5YHL52T+@vger.kernel.org
X-Gm-Message-State: AOJu0YwJwzyAO1Rsm8O2y3ymkBNd95ESvGUaZIQRyrg7HYnQe6c0yDeN
	EvODfk5pUZpaa6aeMsN1ZNIj+WYRRxWmLBzH/vUY/dKZtwIZCf0V
X-Google-Smtp-Source: AGHT+IFDF8vNafHQIu1BhZKfSynLDr8X+Y76zj3pF0K4HDOWPyQhGrBM3vZ3HSYkUohWmDmh0iN3ug==
X-Received: by 2002:a17:90a:fd10:b0:2e2:8c75:b45 with SMTP id 98e67ed59e1d1-2e5da580a85mr2166127a91.11.1729560206396;
        Mon, 21 Oct 2024 18:23:26 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e5ad365d14sm4718919a91.13.2024.10.21.18.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 18:23:26 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Tue, 22 Oct 2024 09:20:47 +0800
Subject: [PATCH v2 2/2] ipmi: ssif_bmc: add GPIO-based alert mechanism
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-ssif-alert-gpios-v2-2-c7dd6dd17a7e@gmail.com>
References: <20241022-ssif-alert-gpios-v2-0-c7dd6dd17a7e@gmail.com>
In-Reply-To: <20241022-ssif-alert-gpios-v2-0-c7dd6dd17a7e@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729560198; l=2721;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=PUD6kC7ss3fWPkXsFlsDDO/XmHqy3YarK27U7zFcq0Q=;
 b=MyfetClwEMMrsdJaxnzazo2rPnNjJCZ9K1ekxRTXpo/c8c/YsSJqGaU10vFCc71b8hk75UtUe
 2GRhg/5TkDrCWG8W1UO6rPs30IqeFSulmQw9mAGIAVkp3ZJVH0iVizv
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


