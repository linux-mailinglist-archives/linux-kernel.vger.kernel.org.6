Return-Path: <linux-kernel+bounces-555816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BE8A5BD25
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6645189946C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2B42343C1;
	Tue, 11 Mar 2025 10:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dKEoMRHt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A022B8D9
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741687319; cv=none; b=uB0Rzg/WjyB3Y8wJwag9I649NVdzjO837xCxdDlc5EJCVqaI39z8e3Jz5YLoqllXpgJFTIOpHpSUUQIeTtFhhzspbSySfEpjj47eOI/iMFP9ZHCiyulqtupoyuQeSUdgyOvsPwAiVfQH9JzrCtC34ARKXIaF/98zPsWj+Vq/fIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741687319; c=relaxed/simple;
	bh=NPMtqpwCVKN/t6dM0TTZRO7xhNc09lkELwdXpym2pPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJQf9dRf9x8NKd6hi+pFzs1Mbvj34fs5IVnJI71A2xmzyPWvsaLoY8HLL/RdctGHK2eUJzvch8Urg37KDiFswZOZRat9/PToXTYyWCfeqImEBlmFyYu9S8CPC6jaEfWn84DaF90PVbfzRYtQhorWgrnKT2y18eDAwinKePH6EjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dKEoMRHt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741687317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R8AbLV0QZow5eKDSyCJQccGErTMPbE7El3aX8DLCI50=;
	b=dKEoMRHtY5l+u5n4ebz/9gbHaQvXcXsQm48ve2hivKIaXDoe43C636D53uU8PTTQDZ6USh
	FJQi+nf8SHXQG5ANeLsslumYue6N3EUWNQ3QFQH5EItpY4/xRrCoU/7T5ENpq8bz724se4
	8Ex+0yw054/cPFAqFQzboQxwldXGw3U=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-hU5Fwp8VNyi_MhUw0GCVsQ-1; Tue, 11 Mar 2025 06:01:55 -0400
X-MC-Unique: hU5Fwp8VNyi_MhUw0GCVsQ-1
X-Mimecast-MFC-AGG-ID: hU5Fwp8VNyi_MhUw0GCVsQ_1741687315
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac286ad635bso267659366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:01:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741687315; x=1742292115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8AbLV0QZow5eKDSyCJQccGErTMPbE7El3aX8DLCI50=;
        b=iE3bFQvXVgPTIHPTa+ls2LfO9pZva0sinCGv77f771C50MniTcA+u0SeHnmhhyDbs7
         S4iaCtoogaTaKgHrJdIiMGphkoS/fuaQXoNMEw59a4sXAmIefMoSWbF2swtl0FU644Ju
         gM3cuabq0P8NYdH9un24XUd4wMdAJONB3JL37idksBx3KAFk1XAcjqRsPjWnHmzAwtwO
         OXrrfKr+cKSXGB4c7FbgeRZl3fYOpVCDUBD5AW981KcootOHElykToyY5+NxJh7DuOEy
         uby0o4xDD/wf7a385Bj4myOTNGOZmx0GjeFW139pys9FxtyHE8+RFq1Razc0KU3YBlae
         1UDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKUIRYGJ3vgBvzpvxYg++6F+KuyccjF/ZLDVBUUfYVuDFf6hbV4ncofOYZHgbXj0SouVveODZCHwzAlsw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBYyUs5C55egO+JmBVA8eSwuLVFZGk8p4x0Xv/s3jDEkjUsHvy
	kpUVvNi7HFX2puA7U2igh9Y8Es91FabcUZi5/VAAJoygJXlDf+qcRufxWRA2J7ecOC+eccLAqc7
	HZerRP93TIpiMT+JqH7qocV3IHwEFTARwdvOd/g0Qnl8uQtAb3Yq28xoyFlG+ow==
X-Gm-Gg: ASbGncs38WprGyrwhx7lcvYfySf0VUkiddjtMZzOV3TAgJKERwphdvHN6rZrGpMNdBO
	PWSvTyrs7tifpWMHmHm6Ti8eNmkUmhr3G4q1kc1TzqzjDkBvB/KY0OLb2LLSZ3+eUFWFR6xBfMj
	u/MrklgWW/Oxi9ZLgKOva4zhMc7+s10NyzTYl5cN0DD7OqGxJGE6yhHHdecR5l2J/kfl8mOqhQ6
	sy7tEe8P9nFXp3FgOP61EmiFrl7eiOcI++kYEx3ySlvY9SxusOFg6iupB6VnGbFfq2JH6gi9J2e
	0+tTlh8HD3fk+O9vDrzzJl5iboFjbKmUz3kpGzmq1FCfaSCl3GOYj2BhKwgcyvuIbWkDLKxE
X-Received: by 2002:a17:906:f589:b0:abf:d4a9:a0a5 with SMTP id a640c23a62f3a-ac252f8e28fmr1854096466b.45.1741687314600;
        Tue, 11 Mar 2025 03:01:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGQ38gLVsp3SfDC4i23YFLhiD4lGnf7z9JZYc5KUOq4ySpfuIH/T3U1+SixSbQ8V0WVV7O7aA==
X-Received: by 2002:a17:906:f589:b0:abf:d4a9:a0a5 with SMTP id a640c23a62f3a-ac252f8e28fmr1854092166b.45.1741687313983;
        Tue, 11 Mar 2025 03:01:53 -0700 (PDT)
Received: from localhost.localdomain (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239485d55sm903426166b.67.2025.03.11.03.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 03:01:52 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [RFC PATCH 3/3] tpm/tpm_svsm: use send_recv() op
Date: Tue, 11 Mar 2025 11:01:30 +0100
Message-ID: <20250311100130.42169-4-sgarzare@redhat.com>
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

Let's simplify the driver by implementing the new send_recv() op.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
Note: this is based on "[PATCH v3 0/4] Enlightened vTPM support for SVSM
on SEV-SNP" series [1].
If we will merge this series before it, we can just ignore this patch
and I'll squash these changes in that series.

[1] https://lore.kernel.org/linux-integrity/20250311094225.35129-1-sgarzare@redhat.com/
---
 drivers/char/tpm/tpm_svsm.c | 46 ++++++++-----------------------------
 1 file changed, 9 insertions(+), 37 deletions(-)

diff --git a/drivers/char/tpm/tpm_svsm.c b/drivers/char/tpm/tpm_svsm.c
index 5540d0227eed..63208313f86e 100644
--- a/drivers/char/tpm/tpm_svsm.c
+++ b/drivers/char/tpm/tpm_svsm.c
@@ -25,60 +25,32 @@ struct tpm_svsm_priv {
 	u8 locality;
 };
 
-static int tpm_svsm_send(struct tpm_chip *chip, u8 *buf, size_t len)
+static int tpm_svsm_send_recv(struct tpm_chip *chip, u8 *buf, size_t buf_len,
+			      size_t cmd_len)
 {
 	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
 	int ret;
 
 	ret = svsm_vtpm_fill_cmd_req((struct tpm_send_cmd_req *)priv->buffer,
-				     priv->locality, buf, len);
+				     priv->locality, buf, cmd_len);
 	if (ret)
 		return ret;
 
 	/*
 	 * The SVSM call uses the same buffer for the command and for the
-	 * response, so after this call, the buffer will contain the response
-	 * that can be used by .recv() op.
+	 * response, so after this call, the buffer will contain the response.
 	 */
-	return snp_svsm_vtpm_send_command(priv->buffer);
-}
-
-static int tpm_svsm_recv(struct tpm_chip *chip, u8 *buf, size_t len)
-{
-	struct tpm_svsm_priv *priv = dev_get_drvdata(&chip->dev);
+	ret = snp_svsm_vtpm_send_command(priv->buffer);
+	if (ret)
+		return ret;
 
-	/*
-	 * The internal buffer contains the response after we send the command
-	 * to SVSM.
-	 */
 	return svsm_vtpm_parse_cmd_resp((struct tpm_send_cmd_resp *)priv->buffer,
-					buf, len);
-}
-
-static void tpm_svsm_cancel(struct tpm_chip *chip)
-{
-	/* not supported */
-}
-
-static u8 tpm_svsm_status(struct tpm_chip *chip)
-{
-	return 0;
-}
-
-static bool tpm_svsm_req_canceled(struct tpm_chip *chip, u8 status)
-{
-	return false;
+					buf, buf_len);
 }
 
 static struct tpm_class_ops tpm_chip_ops = {
 	.flags = TPM_OPS_AUTO_STARTUP,
-	.recv = tpm_svsm_recv,
-	.send = tpm_svsm_send,
-	.cancel = tpm_svsm_cancel,
-	.status = tpm_svsm_status,
-	.req_complete_mask = 0,
-	.req_complete_val = 0,
-	.req_canceled = tpm_svsm_req_canceled,
+	.send_recv = tpm_svsm_send_recv,
 };
 
 static int __init tpm_svsm_probe(struct platform_device *pdev)
-- 
2.48.1


