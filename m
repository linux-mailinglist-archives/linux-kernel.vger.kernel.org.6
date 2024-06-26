Return-Path: <linux-kernel+bounces-231629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B658919AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5E5C1F2169E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AD15194A50;
	Wed, 26 Jun 2024 23:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f0NnXEZ9"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C06B194A61
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443076; cv=none; b=DQSeUHcLwDiRWClHVXKccbQbz4dcEyIdm/baoFxWsP04HrGQ1shUbm3+iZr1syyZwZmoeijiCPwgYKLjkMS5bXW+NYRzLW/JUIOGiG/0Aed8W3Lr4Y8btM76szptU1thfVKSD38BFO5XCIJksHsH/fruGy450FBinJxuRF/9c7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443076; c=relaxed/simple;
	bh=vKCPSZCxsriB7WThJFHjvVytk0B8CH0/B2lctEhKZJI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PCQ5ajjFVovYSZndtCOnHUkDohpRBKCVQNfm9RYMP32l3842ia0mPB+gFOFstWxWe2Y5wWa0xYab8mub/hF+u1g8lnGKAzOOugKrL0hx0ZDs1j9h+s1UgrBURuOH95L5/iH/NmAxIvXLcvHQTnhctDQrOmya0gYmUuCW7F9ScRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f0NnXEZ9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62fb4a1f7bfso173887227b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719443074; x=1720047874; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PEyKI1QsiIJEewnF527ltuQV4oeBpkyWMn9QtWCUb2g=;
        b=f0NnXEZ9Kk4PBi87AmOOr4ZP9E2uGHCVvpqZazMUUTnAs56AaHJtI/TOfFi+tLtBmJ
         hH1+RGzbJecDuDK8XCgF0jd1BHxkK2W4/DW5Xx8Y1hGbIlx6/cSpp7Wq9aJ0Qag1HtUj
         xvjC8sOa5CdpkYChSCUZSQztrLTia3kk6ueGISxEhtSfI540IwHJ2kwGpxNOZ9MO35jZ
         zCWGT6Kl1AJ6JyIfjmIBdqolHdxz8vwze/xfFsG028AMF9aTVv8416EhTuzTLbliM5QS
         bGmdjgHNPR+F4a5iYJxmEC0DqqHZrzCb3umUBCfDT6X0imzoE1Zh6a2GCGQOvZAYmNeQ
         JxMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719443074; x=1720047874;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEyKI1QsiIJEewnF527ltuQV4oeBpkyWMn9QtWCUb2g=;
        b=jmu8boNG1IvqIOx9jnuVtjC75oP8aOWKcwkE1ugbnOmcvzmmwCXQmZmwMptlr6Cteo
         0VVT6eaXKWcn4AdoZPO1F8ako1tqCxOeT5M5xe9Y/cGuO/NO7L/DSVEIkeFR+jL/7eji
         OVwdV8HtK6gRJyBSWmDpa8awiEbfVWxjrD1sLBsf0aIkMT159rEpMeKQin0b+bjqjq1r
         QRoPi9uYYxPbDuWozPkRf92WzuVgD5rs8ao7TLqfp25zcDYXmmIStJVmmxV6lr48IAZ4
         C9TVjN2BCWBLTkyin6e+GOjXhOhgkDwXg6VgaDCDBwIdn89lms4j2SGyPMFIf2FDE8Fi
         P46w==
X-Forwarded-Encrypted: i=1; AJvYcCXZPAbIIwRShKU/5mHWzeWwiF64JZfGjsUs+FoMwWBf9hiFeru1YiACqnnzooxwxB6AXqdAD4TSr2anov1TxwuAVcNfEUZaPRt8utBF
X-Gm-Message-State: AOJu0YzX9+HOVbuM5X15yU0VNdLAFe+fpMGkMlNm6T+oYS5QHpT9xSQp
	jfBLV82UtPS5TE0bna8fyQKo6WVJ4Iku3hMMnwFxl5QoZ7pYkoJNXTeTfNLqPK6V9z7IJi0U1Ms
	/fjt8fXQNVA==
X-Google-Smtp-Source: AGHT+IHEjGoOj0rKBY90tBQ+URsGB4VTurQ8pFXkmw/P+KxoNfpIx64+6no67l8qdUYDXNV6XjzwXAXXQvy3Bw==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:690c:fc8:b0:648:2a9d:1a63 with SMTP
 id 00721157ae682-6482a9d24bfmr2023537b3.7.1719443074353; Wed, 26 Jun 2024
 16:04:34 -0700 (PDT)
Date: Wed, 26 Jun 2024 23:04:11 +0000
In-Reply-To: <20240626230411.3471543-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626230411.3471543-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240626230411.3471543-7-ipylypiv@google.com>
Subject: [PATCH v3 6/6] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before
 using result_tf
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 02af4d5d5799..d5874d4b9253 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -242,10 +242,16 @@ void ata_scsi_set_sense_information(struct ata_device *dev,
  */
 static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
 {
+	struct ata_device *dev = qc->dev;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
 	unsigned char *sb = cmd->sense_buffer;
 
+	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
+		ata_dev_dbg(dev, "Missing RTF: cannot set ATA PT sense fields.\n");
+		return;
+	}
+
 	if ((sb[0] & 0x7f) >= 0x72) {
 		unsigned char *desc;
 		u8 len;
@@ -923,10 +929,16 @@ static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
  */
 static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 {
+	struct ata_device *dev = qc->dev;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
 	u8 sense_key, asc, ascq;
 
+	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
+		ata_dev_dbg(dev, "Missing RTF: cannot generate ATA PT sense data.\n");
+		return;
+	}
+
 	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
@@ -970,6 +982,12 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
 		return;
 	}
+
+	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
+		ata_dev_dbg(dev, "Missing RTF: cannot generate sense data.\n");
+		return;
+	}
+
 	/* Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
-- 
2.45.2.803.g4e1b14247a-goog


