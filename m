Return-Path: <linux-kernel+bounces-236957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C5891E90E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A88B51F23805
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA8117332C;
	Mon,  1 Jul 2024 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCtS9x2R"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7465172BBC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863899; cv=none; b=EHq08xXNvbZpma8ibjwn7V4ZAKYqa+GmuajbHwfCalfpm+iYb2pm/0PlevTQm5G6LyNAngELda/26ToVfPX/ANBU1YmEd2Rh/9Ra+4bnyHQXfg4aQEMxVh1CjtXjozlH0TGcL0245IRibXC6fVoUqc1DYVth4eUYh5qNdaqo2D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863899; c=relaxed/simple;
	bh=TdwWxPt68vemC3NjLpNegwFE9LXNnMsLaGF7PK7//vE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VJcwTIYqn/0tZW1FPUvErAC99gLYZKsdYe0RWy2XWLf2ZGGysbymiIrc5eKO2EP1OF8U7w/jsi+0EhGBPZX/kkOnmq+1yskqR1SF8AWV7PwcMpQvnAVQz4TkNE8UYXOgmrYMlgbWt4+RjG+E1LKVJSGL6XT1YpF/ZiJxudiA6uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCtS9x2R; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-704d99cb97aso2219433a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863897; x=1720468697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fAE+S7QoWzFH/OclA3EgmIeGcizxeFkCmPKpIfdU7EE=;
        b=JCtS9x2R0x7nXvkMbjq7/Mq+2+zaq/R7/Ecer4K/gfErnNAxpYOK7LENS4rjeYGj1l
         /5aoh51sMyBqLvHNmiMM0xvXQHI512uOBiuqPlY9rz6e531dgNyUS6Cj7FxXVHg4zWEo
         rjyNCaDhRQp1UVg+5k2lH1E7uHyjX7y1InJTEshYVR+ucoB8yfnUKYghI+mBCa957uoo
         pK7QBtPck6+OYEMGVJLshZJpKDp7c6zJC7bdk7ZvWVrL3A7xw8kFbPD5YRi0ep1LhVX+
         W6zKdQAoao9Q1+6aDQkyDar3CQ42m31TQLB9xc81K/Oi29nVxpc8LkaBQqi1ZZWdU1kj
         zJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863897; x=1720468697;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAE+S7QoWzFH/OclA3EgmIeGcizxeFkCmPKpIfdU7EE=;
        b=GsaM4LTES8T6iKfBgorzTnYHgZWHkhAjeUNH+qSfdhVdkhCCFXvWQgJ8jSNRUMMgYp
         ziNxhPUlvjIKZSxKqh9XZpm+gxNbn2WJ6zxI+WNf97LHZFCXPmgvEUjefZwAm2f7Ntpu
         ZL5RBENjsG+CMD5YHI6uHTeo60f5ePzZTvMxMi2ZmF1reKmgsb3fx6MxxNV2rUJpLLv6
         3gDQ/jOrNtG17ERpfaUP3p/VAklA4rssNqH4/vXwNUbIeGaoNaYVlK91VF+OtTkIp0WB
         AqyTsl4r+0jU27Kk7h/jlyFZvPMGcaYF2lhvd/e0EFQtDMg5pXe6Q0sIodX9EC2XTqsc
         pD9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVh+06DanV8mDWx/DJoHPk0Tv1yqQoPqsUmufJOS3qrdnbyHoNTSybTpaxL0A7NQKU3osgtVfACvSKvmmrtG9XMmO4Zcktq+dRSNUbX
X-Gm-Message-State: AOJu0YxsxEB5RpdsyGzzDLxpQXXk+O8zZMJYBpNPXaPhsO6Fj5+PEYua
	2RJd8ZP9ZS9G6ml99G2S1X4zxUCD4Y2a6SyAfwfOF1zan2kRKxvUe80a8etstt9kLMypTh/fVSK
	gS6pX+Pmcew==
X-Google-Smtp-Source: AGHT+IGeBjcfeksNmObJJCdjEL5DSD5FQ7r2tl+wmERKHImybrRhNIc+EbJN086wSbYxF7ttUGty6fFeKxqwDw==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a63:3347:0:b0:718:b441:478f with SMTP id
 41be03b00d2f7-73cf2c29ad8mr16400a12.3.1719863896897; Mon, 01 Jul 2024
 12:58:16 -0700 (PDT)
Date: Mon,  1 Jul 2024 19:57:57 +0000
In-Reply-To: <20240701195758.1045917-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701195758.1045917-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701195758.1045917-8-ipylypiv@google.com>
Subject: [PATCH v4 7/8] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before
 using result_tf
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 92d75780fc3b..a66c177b6087 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -242,10 +242,17 @@ void ata_scsi_set_sense_information(struct ata_device *dev,
  */
 static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
 {
+	struct ata_device *dev = qc->dev;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
 	unsigned char *sb = cmd->sense_buffer;
 
+	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
+		ata_dev_dbg(dev,
+			    "missing result TF: can't set ATA PT sense fields\n");
+		return;
+	}
+
 	if ((sb[0] & 0x7f) >= 0x72) {
 		unsigned char *desc;
 		u8 len;
@@ -923,10 +930,17 @@ static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
  */
 static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 {
+	struct ata_device *dev = qc->dev;
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
 	u8 sense_key, asc, ascq;
 
+	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
+		ata_dev_dbg(dev,
+			    "missing result TF: can't generate ATA PT sense data\n");
+		return;
+	}
+
 	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
@@ -967,6 +981,13 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
 		return;
 	}
+
+	if (!(qc->flags & ATA_QCFLAG_RTF_FILLED)) {
+		ata_dev_dbg(dev,
+			    "missing result TF: can't generate sense data\n");
+		return;
+	}
+
 	/* Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
-- 
2.45.2.803.g4e1b14247a-goog


