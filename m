Return-Path: <linux-kernel+bounces-569937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B67A6A9D9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54578980C7B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 15:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598AD224AF7;
	Thu, 20 Mar 2025 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KyCK5eTi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F222424C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742484290; cv=none; b=pQPXYSEeFXByCVayhc+kp3ayfMJKF/knsnWuOXoRNYeOulCvku/otAwAj7rpx0Fl14Ap30mWtz1MMnwKJbJbs+1uZWthGdeNbZAHCM6jDovCAzkhdAZoe/avUYKT293wBOG45X9jag3/Tns5bm28W4L7MtlHvq60HqSVFNzMZBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742484290; c=relaxed/simple;
	bh=myzODkLCXU9k+CNuyKZbtSDZie+rrUzmakLImNhXOvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=geN8pPOICYtcRqiNm+gk4SB8vKR+u+S2sT7EsQaFYd1g5gGQ0QV6w7+U14qSmEUO+OailVaE6VZSXX0zqM7OK5rMs3CzZLiae26IIGByP1/pvpg4JUxaJ76B96r3DbnKt6OgM7++rh+KNb8xDs2szmt/6JYcyRPffbiK+wDVX/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KyCK5eTi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742484288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z2gxWk7Mqfo6u16dcSf4IdAvykfJIBF0LRh5CbMS2gE=;
	b=KyCK5eTix5t+Lq3zQ6T56LC2o7wJ9l5Kqv1SxP9/LfnTnUBZwcAiY77PYNA+NjJj52zFtY
	8MAHm0AgY61aIJURvus6+etbh43etlSTbJdvkbF4j6z8eUA0KVGZrLDDaSPymxffGgq04k
	xJr500oYwifD/6Wp3AN6k7p1EjOGE5w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-MR9KYDbQN-iXRKfwP4ELlw-1; Thu, 20 Mar 2025 11:24:46 -0400
X-MC-Unique: MR9KYDbQN-iXRKfwP4ELlw-1
X-Mimecast-MFC-AGG-ID: MR9KYDbQN-iXRKfwP4ELlw_1742484284
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43947979ce8so4271665e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:24:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742484284; x=1743089084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z2gxWk7Mqfo6u16dcSf4IdAvykfJIBF0LRh5CbMS2gE=;
        b=iDod980WkVj/9VUPb9zHEBXUHDKH1iaZEgKUVb7HkCSI3nY1ZimTyH/b7HCbbgEt8K
         kRF3/Rq8Q032aR5LiZ6DxNUe+O/cu00gTLZ8AUXBKXQMQvfllV2dMJRx0p6kOKAUAN2Z
         EaVr3C8W+ZWX3fDl/D4MlybmxEVDr81//ml5VVDUh64LVFeL6BoIVZEDSvW1xINUHPOQ
         H2+6m2zcfKfosdrWoC9R+5i80MLfk4MWsU3Mg3HqdRG9xrm14ea10KrGK4RDiLfq+lxc
         iw+F3tzv40PqYlTJyC31KCylaWAKKwo+g3NFzPfZXJL3lOZUhUWL6aRvRMLKcicuQp5K
         noLA==
X-Forwarded-Encrypted: i=1; AJvYcCVQtJeVbcdlFxMEmKoeBuobEzigYK3Eh+P4tAHuUckzpicndpH6r3tjrWpIS6zGhu0Ja6wInSqhUtSSNkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrnW3Nd84DfHElD1qt6Vgu0S/rtXuGeE83+SlC/mmWy+p30kER
	weP0cUHVdvnm5P2yKqMxxzP+oeFBuWfMn2kMFfCB2hD882nQyONrFL9h38aTxZTfhORfihZQUch
	3ZB1TbW7D3oNXxSUAinTiZZ1Cc5Lkt28KMzXiTNc2eCn8yDzEmscPlqftOWPgqw==
X-Gm-Gg: ASbGncvjfirRI76Qf4MJ1njlw0DkOSIrNLWVlC9jzZah0dhtklBM1t5fsp9Ge+Imcej
	8/X0FxW+S5svcVUfdCTikWt6uIGhAbim48rzkQaCxRYikuW7GZtbAgJ2u57HH/lFT4J4udkOXFI
	I2NE3/VSLkFlUK0kqyWL0E7B/A9c3JsGgCO0MckSHky0s2BlAEEH0vW/1Fdspn3IU4VLUmWuD2F
	lM5R6lRY8NPelpe2M4EtWf/yXQXQkyHU7iExTMpXqlQ5m7ovvXCG9OU+xh4I8M0ln8W5aEmks/m
	792jaWEbHD5cUFjo7J0zMvcOyWC0fGH0zXeXZeUwTGT1Lg7O4GuWa00M9UYcouGZnQ==
X-Received: by 2002:a05:6000:1a8b:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-399739b4dbamr6532450f8f.9.1742484284377;
        Thu, 20 Mar 2025 08:24:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8AHddaOw437CUySFfwsnP8Hprx1HumUa59qJL3ncy08x6hV7c2+DaL0UrDROuWkbDQnZ/yg==
X-Received: by 2002:a05:6000:1a8b:b0:391:6fd:bb65 with SMTP id ffacd0b85a97d-399739b4dbamr6532410f8f.9.1742484283787;
        Thu, 20 Mar 2025 08:24:43 -0700 (PDT)
Received: from stex1.redhat.com (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fceacf3sm974085e9.3.2025.03.20.08.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 08:24:41 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org,
	Peter Huewe <peterhuewe@gmx.de>,
	linux-integrity@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 1/2] tpm: add send_recv() op in tpm_class_ops
Date: Thu, 20 Mar 2025 16:24:32 +0100
Message-ID: <20250320152433.144083-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320152433.144083-1-sgarzare@redhat.com>
References: <20250320152433.144083-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

Some devices do not support interrupts and provide a single operation
to send the command and receive the response on the same buffer.

To support this scenario, a driver could set TPM_CHIP_FLAG_IRQ in the
chip's flags to get recv() to be called immediately after send() in
tpm_try_transmit(), or it needs to implement .status() to return 0,
and set both .req_complete_mask and .req_complete_val to 0.

In order to simplify these drivers and avoid temporary buffers to be
used between the .send() and .recv() callbacks, introduce a new callback
send_recv(). If that callback is defined, it is called in
tpm_try_transmit() to send the command and receive the response on
the same buffer in a single call.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 include/linux/tpm.h              | 2 ++
 drivers/char/tpm/tpm-interface.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 6c3125300c00..4e796b8726b5 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -88,6 +88,8 @@ struct tpm_class_ops {
 	bool (*req_canceled)(struct tpm_chip *chip, u8 status);
 	int (*recv) (struct tpm_chip *chip, u8 *buf, size_t len);
 	int (*send) (struct tpm_chip *chip, u8 *buf, size_t len);
+	int (*send_recv)(struct tpm_chip *chip, u8 *buf, size_t buf_len,
+			 size_t cmd_len);
 	void (*cancel) (struct tpm_chip *chip);
 	u8 (*status) (struct tpm_chip *chip);
 	void (*update_timeouts)(struct tpm_chip *chip,
diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
index f62f7871edbd..7f4e01790352 100644
--- a/drivers/char/tpm/tpm-interface.c
+++ b/drivers/char/tpm/tpm-interface.c
@@ -82,6 +82,12 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 		return -E2BIG;
 	}
 
+	if (chip->ops->send_recv) {
+		rc = 0;
+		len = chip->ops->send_recv(chip, buf, bufsiz, count);
+		goto out_send_recv;
+	}
+
 	rc = chip->ops->send(chip, buf, count);
 	if (rc < 0) {
 		if (rc != -EPIPE)
@@ -124,6 +130,7 @@ static ssize_t tpm_try_transmit(struct tpm_chip *chip, void *buf, size_t bufsiz)
 
 out_recv:
 	len = chip->ops->recv(chip, buf, bufsiz);
+out_send_recv:
 	if (len < 0) {
 		rc = len;
 		dev_err(&chip->dev, "tpm_transmit: tpm_recv: error %d\n", rc);
-- 
2.48.1


