Return-Path: <linux-kernel+bounces-555815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C1FA5BD1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B28173A667B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECCD23099C;
	Tue, 11 Mar 2025 10:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GZ6wp+tB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0698B230997
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687315; cv=none; b=Ua0YoEokSDsO7oU2Sg9XX0sizqoti8+RONCKVt1XmRnGEQim5fhMtf0ZxfHqBRfv+XOR/k+GM0vqg8cGiKV/QvhRCRcoAW5dN7X6jELmjpNHs18UxF5DgFYkoO1L7ZZl6paiOK2d4GQpMnXYNIJ5NOLodkwsbrCETk8p5pZM6RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687315; c=relaxed/simple;
	bh=Jm2/ux1vKHax2qopOtD5cqQYVayOaqNeh+rZVk6cOwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rDzQCq9DcjC6rVqJQknC4/LHsSYJuFINucUyM3FdWOFRWSPosBHDPi7Q4jp/PZ9o45L+GRXikwbv0BAeSrmvB1WAwA9qCmeIzAL2NfiyjHGhcOSedI5D+WBjgBv7i/pdutIgC/mzRM7VZ6ZF6Vo3dSIjYjW7H9Tg9aBMRSTHDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GZ6wp+tB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741687312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KPPKTGvTQZd77Cs+WjdLnlEj4HAhCixTZCeAE7Dlt2w=;
	b=GZ6wp+tBjnV7bd4i6Q4NEZ1cRfKUNZP4YaDUJ2/1v9r1/ViJi15xOLUhVGlkQRHTsArWwb
	1EeDX5zdpUzFo6o1fTDRLZFf54cFaOZZz/hw+ltFYBLjWNbYhJ70syVKspO/wXG9vU2fgR
	uoG+hHoVVusdQZiUZ5TOAnbm9ttrfdA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-L1Ni1Z_lMHWugfpSBvf9rw-1; Tue, 11 Mar 2025 06:01:50 -0400
X-MC-Unique: L1Ni1Z_lMHWugfpSBvf9rw-1
X-Mimecast-MFC-AGG-ID: L1Ni1Z_lMHWugfpSBvf9rw_1741687309
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac27d8ac365so228319866b.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:01:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741687309; x=1742292109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPPKTGvTQZd77Cs+WjdLnlEj4HAhCixTZCeAE7Dlt2w=;
        b=tRFClu9FOtzg7McsOSX5SpcA07Mtm56pFRzu/b0TeogoyReKvHD98F7AWPIQ9EOThX
         UtDP+wPJBTBGRb24/MeJeC6QJYi3oGp8r4rAigdoCSN92meCaqo6yvnwDxLdvV+0B6et
         r8wX8RDLFu1bT0pmWaIALX1wPuWc87vOg4msRw5ZyUnTKk8Lzv2Ctt2L1nbYnvlBzGaG
         xJjUYCsumgLExBcJsYlq70lkKvslrlFdP0+9o3JcqL96DoYTDIwquLkSIsmQRhPZ4tkL
         CduKdGJWllfxIRwLAu2I+3mhVVjUUfFz/bJrtQrYRWh+jOIp/F9HVuXTEzT+rcR1J76x
         lfDw==
X-Forwarded-Encrypted: i=1; AJvYcCUT7O+ew6YYHTFv9gPPAatzTV6W7mRhMQ3wraQowtjioe7+1w/mlBM4vbIweQZuMZBFTQxtmS+dIcwd8kU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUg7C9uSq3Rpb8ZACQhZl7ipQjtOM5SS+YStP6gGu6Hbv4+Lmy
	plaMvzRh0nwIG9JGo831Bw/y8H5+VqtbUQPWpsc4n1HHbywVfEO2DeGD1meEZPH9HrzONlBX6b/
	OLzV91uznYlZCpA7+klAgZypYonY8lJG/YRhvWDITv+x5eUaGLD/pS4boiLIddg==
X-Gm-Gg: ASbGncuTaXIkhrBnnIyndgyDP2Z4l+KI6nM0panHLDaXRf5CoUvWY/iBunkaIQ1Z4dX
	7YfDrzciOmnAQbWMzdBQd6ngaRBQl4yGkd/JBN6RYIozdQkBHjWAwBYhtZjMxUOwu4PnAs7ZKr6
	m/S+VvaN88AqqyHBNSSwhLUftorUT0W64ZOwfd9iJPZoafQZvZOQLm+qMmI6jws26AjKtcYq/7P
	Lm/4MA5C3yFQqVzUdkyi+F2OKo5S6t2hLQ1AF7AqO74Hqnvzen8LIq2RHbxAvITg7uzHUKBc2AE
	D6pgIk1sIsY90ydXQEktTtlUfnDoJAF+68QO2XrulU2YMUM/dqFkCsjpSaoGqxJpvTZmsIg/
X-Received: by 2002:a17:907:7213:b0:abf:6f87:c732 with SMTP id a640c23a62f3a-ac2b9de96d4mr330695366b.20.1741687309277;
        Tue, 11 Mar 2025 03:01:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbKu5HMA42qiS6MJ30Na3MKSdLChwgJ/VZYOOUxT/L4wbU6L/bdxGQ/p9i7lzsXp61vSa7QA==
X-Received: by 2002:a17:907:7213:b0:abf:6f87:c732 with SMTP id a640c23a62f3a-ac2b9de96d4mr330685666b.20.1741687308530;
        Tue, 11 Mar 2025 03:01:48 -0700 (PDT)
Received: from localhost.localdomain (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac296527b70sm382964466b.58.2025.03.11.03.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:01:47 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 2/3] tpm/tpm_ftpm_tee: use send_recv() op
Date: Tue, 11 Mar 2025 11:01:29 +0100
Message-ID: <20250311100130.42169-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311100130.42169-1-sgarzare@redhat.com>
References: <20250311100130.42169-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver does not support interrupts, and receiving the response is
synchronous with sending the command.

It used an internal buffer to cache the response when .send() is called,
and then return it when .recv() is called.

Let's simplify the driver by implementing the new send_recv() op, so that
we can also remove the 4KB internal buffer used to cache the response.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
Note: I don't know how to test this driver, so I just build it.
If someone can test it, or tell me how to do, it will be great!
---
 drivers/char/tpm/tpm_ftpm_tee.h |  4 --
 drivers/char/tpm/tpm_ftpm_tee.c | 86 ++++++++-------------------------
 2 files changed, 21 insertions(+), 69 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.h b/drivers/char/tpm/tpm_ftpm_tee.h
index f98daa7bf68c..72b2f5c41274 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.h
+++ b/drivers/char/tpm/tpm_ftpm_tee.h
@@ -23,16 +23,12 @@
  * @chip:     struct tpm_chip instance registered with tpm framework.
  * @state:    internal state
  * @session:  fTPM TA session identifier.
- * @resp_len: cached response buffer length.
- * @resp_buf: cached response buffer.
  * @ctx:      TEE context handler.
  * @shm:      Memory pool shared with fTPM TA in TEE.
  */
 struct ftpm_tee_private {
 	struct tpm_chip *chip;
 	u32 session;
-	size_t resp_len;
-	u8 resp_buf[MAX_RESPONSE_SIZE];
 	struct tee_context *ctx;
 	struct tee_shm *shm;
 };
diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 139556b21cc6..f0393d843780 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -31,45 +31,19 @@ static const uuid_t ftpm_ta_uuid =
 		  0x82, 0xCB, 0x34, 0x3F, 0xB7, 0xF3, 0x78, 0x96);
 
 /**
- * ftpm_tee_tpm_op_recv() - retrieve fTPM response.
- * @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h.
- * @buf:	the buffer to store data.
- * @count:	the number of bytes to read.
- *
- * Return:
- *	In case of success the number of bytes received.
- *	On failure, -errno.
- */
-static int ftpm_tee_tpm_op_recv(struct tpm_chip *chip, u8 *buf, size_t count)
-{
-	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
-	size_t len;
-
-	len = pvt_data->resp_len;
-	if (count < len) {
-		dev_err(&chip->dev,
-			"%s: Invalid size in recv: count=%zd, resp_len=%zd\n",
-			__func__, count, len);
-		return -EIO;
-	}
-
-	memcpy(buf, pvt_data->resp_buf, len);
-	pvt_data->resp_len = 0;
-
-	return len;
-}
-
-/**
- * ftpm_tee_tpm_op_send() - send TPM commands through the TEE shared memory.
+ * ftpm_tee_tpm_op_send_recv() - send TPM commands through the TEE shared memory
+ * and retrieve the response.
  * @chip:	the tpm_chip description as specified in driver/char/tpm/tpm.h
- * @buf:	the buffer to send.
- * @len:	the number of bytes to send.
+ * @buf:	the buffer to send and to store the response.
+ * @buf_len:	the size of the buffer.
+ * @cmd_len:	the number of bytes to send.
  *
  * Return:
- *	In case of success, returns 0.
+ *	In case of success, returns the number of bytes received.
  *	On failure, -errno
  */
-static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
+static int ftpm_tee_tpm_op_send_recv(struct tpm_chip *chip, u8 *buf,
+				     size_t buf_len, size_t cmd_len)
 {
 	struct ftpm_tee_private *pvt_data = dev_get_drvdata(chip->dev.parent);
 	size_t resp_len;
@@ -80,16 +54,15 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
 	struct tee_param command_params[4];
 	struct tee_shm *shm = pvt_data->shm;
 
-	if (len > MAX_COMMAND_SIZE) {
+	if (cmd_len > MAX_COMMAND_SIZE) {
 		dev_err(&chip->dev,
 			"%s: len=%zd exceeds MAX_COMMAND_SIZE supported by fTPM TA\n",
-			__func__, len);
+			__func__, cmd_len);
 		return -EIO;
 	}
 
 	memset(&transceive_args, 0, sizeof(transceive_args));
 	memset(command_params, 0, sizeof(command_params));
-	pvt_data->resp_len = 0;
 
 	/* Invoke FTPM_OPTEE_TA_SUBMIT_COMMAND function of fTPM TA */
 	transceive_args = (struct tee_ioctl_invoke_arg) {
@@ -103,7 +76,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
 		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT,
 		.u.memref = {
 			.shm = shm,
-			.size = len,
+			.size = cmd_len,
 			.shm_offs = 0,
 		},
 	};
@@ -115,7 +88,7 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
 		return PTR_ERR(temp_buf);
 	}
 	memset(temp_buf, 0, (MAX_COMMAND_SIZE + MAX_RESPONSE_SIZE));
-	memcpy(temp_buf, buf, len);
+	memcpy(temp_buf, buf, cmd_len);
 
 	command_params[1] = (struct tee_param) {
 		.attr = TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT,
@@ -156,38 +129,21 @@ static int ftpm_tee_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t len)
 			__func__, resp_len);
 		return -EIO;
 	}
+	if (resp_len > buf_len) {
+		dev_err(&chip->dev,
+			"%s: Invalid size in recv: buf_len=%zd, resp_len=%zd\n",
+			__func__, buf_len, resp_len);
+		return -EIO;
+	}
 
-	/* sanity checks look good, cache the response */
-	memcpy(pvt_data->resp_buf, temp_buf, resp_len);
-	pvt_data->resp_len = resp_len;
-
-	return 0;
-}
-
-static void ftpm_tee_tpm_op_cancel(struct tpm_chip *chip)
-{
-	/* not supported */
-}
-
-static u8 ftpm_tee_tpm_op_status(struct tpm_chip *chip)
-{
-	return 0;
-}
+	memcpy(buf, temp_buf, resp_len);
 
-static bool ftpm_tee_tpm_req_canceled(struct tpm_chip *chip, u8 status)
-{
-	return false;
+	return resp_len;
 }
 
 static const struct tpm_class_ops ftpm_tee_tpm_ops = {
 	.flags = TPM_OPS_AUTO_STARTUP,
-	.recv = ftpm_tee_tpm_op_recv,
-	.send = ftpm_tee_tpm_op_send,
-	.cancel = ftpm_tee_tpm_op_cancel,
-	.status = ftpm_tee_tpm_op_status,
-	.req_complete_mask = 0,
-	.req_complete_val = 0,
-	.req_canceled = ftpm_tee_tpm_req_canceled,
+	.send_recv = ftpm_tee_tpm_op_send_recv,
 };
 
 /*
-- 
2.48.1


