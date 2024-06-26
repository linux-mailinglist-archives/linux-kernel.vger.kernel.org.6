Return-Path: <linux-kernel+bounces-231627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B380919AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E7FE1C2201F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175641940A1;
	Wed, 26 Jun 2024 23:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wLm0kUne"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2BDA194158
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443073; cv=none; b=js6A6vdThahMA5GNCrBmCSySnncCLnxWvI3oc2pE3XSqy2CnY/sFgAY9NXXUL5mT2G6N3Ff+W/8X2xiOvqSsICLDkfaBOfA/pKuREsHsxW4EnutCLkuLKKoYJTdAF5Yq9+mvTpgKC5NzPtiTqqlj7SHv2PCawIRsDYvg5yq/Ea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443073; c=relaxed/simple;
	bh=rrgk4/GN+4afQi82RWjkVdACN68Mce2bh09M2M+kIiE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LiRL/FqCM/qsVJGzKAMskJ/U3mwh9hRTaCNjS06TFmOa6VVA6slGOpw7lFjkfllatsIxgYTUHfs0EMfWtIsSr+G2+LOBZcHhmKDc0+6+1LLd1ngG8+BcDhb3fCnTP5gJ8QlmlIMTCYZ4nqIVcqvDz+Ufh9qpA6X/griuV/TCgiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wLm0kUne; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-62fb4a1f7bfso173886097b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719443071; x=1720047871; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t/AvM/q6eju1FsW+yZoXAdsmFslERaWnMqALTvRepcM=;
        b=wLm0kUne+f06wja8x6z0zsOrKV5ScP28P/L/bdTpFOyUM1ZIhDhGDy+hboncNldeZ0
         AfABcmWmhvwIgCXoC7bbeowqvcGTd7ZyzQnbRYJY2NMYxNWqjkDB93iy2r1IohQGzAZG
         OK+JQU/wc23B+zbdhc2zSie+k3ag9/MuTFahFwLVtLCuiEZBGnwWbOdYomTZ3ozx3hYK
         lo7w0X1j7z9hNkmijOWRPqsW4QnwtOv7XiQ77HOEHy9/5JAcnhpLia6dstp9LOkkZwqL
         BZIEXaWNfn9aYXwKtet/ZZpWHruVCDycYdTzgGCzXqKL9K6uMqDlrP0TomkZzKeg0MUM
         lV2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719443071; x=1720047871;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t/AvM/q6eju1FsW+yZoXAdsmFslERaWnMqALTvRepcM=;
        b=hBwH0IbN+bbmlAPw4xFit81B10NcpXjf9Vv92ZQvLHjddKlEef+f80Ba1gg4gF7kA2
         ideeRhe0ZBpwnnWDyObGZl7gBZsjHUTLyO2chowsFIQiPg+K0bSuuIYAT8PSdkDghBAR
         7UF2pc56QpfO9vs5etdtii/wI56foESEUuRCN1EwPN5PUhIcbQzbecS+g7kojvibWckh
         i7yDljZstHSuIUu9MFq2OS6VLJufHhVhm0O+q5Nj6CKGpxlaKlCvYVi84wN1vzm//FIu
         Xdl2qJnPj/7V4LKptpdml6NLcnmMie1GRj4qxzEnM+W0LiDl5wjpHyCK7JCSQKh6K+rk
         t3IA==
X-Forwarded-Encrypted: i=1; AJvYcCVqF7fVA8Y+9xHwyyU2+2Y956lsDiMiBK8WJPg0bbfJOBUIdZsBUgykAVu4PlFR1wwpeY3eQ1BBBkQbmhvBglgcSHxX4EXAGCDinL3h
X-Gm-Message-State: AOJu0YwwQkQIWe9RJ64UtWZomm85BcgkmYVL6oe6bNFXHJaUGs9ls/GL
	rWBFx9PvgyXNut0hAcQ4AEjqyRly5X0TqrSqTuRQ4R0rl94r3j0qPWZRjozVlynkBzNXk91e/BB
	TlLHQACRHqA==
X-Google-Smtp-Source: AGHT+IGHbW9wWs9Mfi0inpboOmSQg9uCUPvebnEdxpQuJ2+zXLOG/ST6R9W4mdAq7jmPeHiFUa3LGqjhiLvsAw==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:f85:b0:e03:33c7:5678 with SMTP
 id 3f1490d57ef6-e0333c75779mr304400276.13.1719443070943; Wed, 26 Jun 2024
 16:04:30 -0700 (PDT)
Date: Wed, 26 Jun 2024 23:04:09 +0000
In-Reply-To: <20240626230411.3471543-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626230411.3471543-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240626230411.3471543-5-ipylypiv@google.com>
Subject: [PATCH v3 4/6] ata: libata-scsi: Do not pass ATA device id to ata_to_sense_error()
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

ATA device id is not used in ata_to_sense_error().

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 6b6e35292620..02af4d5d5799 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -785,7 +785,6 @@ static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
 
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
- *	@id: ATA device number
  *	@drv_stat: value contained in ATA status register
  *	@drv_err: value contained in ATA error register
  *	@sk: the sense key we'll fill out
@@ -799,8 +798,8 @@ static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
-			       u8 *asc, u8 *ascq)
+static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
+			       u8 *ascq)
 {
 	int i;
 
@@ -934,7 +933,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	 */
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
+		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
@@ -976,7 +975,7 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	 */
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
+		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(dev, cmd, sense_key, asc, ascq);
 	} else {
-- 
2.45.2.803.g4e1b14247a-goog


