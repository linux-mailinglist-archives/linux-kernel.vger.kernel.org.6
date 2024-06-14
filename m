Return-Path: <linux-kernel+bounces-215453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C67C79092E4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDF692859F0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB0119D061;
	Fri, 14 Jun 2024 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBOPVBvU"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4E81A3BA7
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718392734; cv=none; b=XUeicco9J40cpeMzRYTgORbrBPD95ilWcsGaVclq1SGqi4rNWHsPKS0L1AQjc0QulcxVPn15a+r+mON4xUMiib2gxRBowZLYjdr0L20HkTVhCfceOM1l3iAevKuNKudJvXWoV+xAutkxkE7/tJkuVaQBs62dI8U6hMgRI3sfg6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718392734; c=relaxed/simple;
	bh=OsE7aRRVqh2vPXKdIi6uRApNlBEwCqMLvrna3Rqbvuw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=feT3OYRu62lxcMa4Cp8pjSJKHGDSVqCjV72t2JBTFrkfwhphvM6uxbsAnWbC78hLllb6gOZtt44YMVu2WGLe2MYSNVuyWKv51zyZ8/odxAyMnXBd7DZqNaKTAJMk2bJFevhvU8tNBLzn6N3Nt/B8Pfp0BBO9CV23NKScxzWuN98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBOPVBvU; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-631d53af5e1so29091217b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718392732; x=1718997532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N5Y8Q6R7VHhS5DlEz/CEIrnOSJXapU1igMdb8ysJrOY=;
        b=DBOPVBvU3EXdWiCghMmclltYGpzQ260xnSnXIqsRnLQk8eY2XQbWaRUzX5pv/w3COX
         iDhHNFDnx8gg6vedSdPF2l1LpJCBcb1ef1geKqNRsRFSA9mHU/ZFE00JhwfN7F5X+tOo
         rIYOPR3YeRwYSOvJbO93F3ybna1DbI4yjpf+bMPHT4eC+jvucMAJ8Ohi/rGZ6GvkhNge
         ZvqMAuhpUG7okfesfQLSVtmyfThCFIlSXs9T/aRWZZmMTLe5cKEi0jMjip0ArrVeLvd4
         TAZ+FYzGmmAbNpbwpzqlj6xhs//8qCa4a4Gud6cPxbchM56ooebaRN7WdPZk99OjcoxQ
         Bklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718392732; x=1718997532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N5Y8Q6R7VHhS5DlEz/CEIrnOSJXapU1igMdb8ysJrOY=;
        b=m5N0XfCTCrWP7nJxP/WG8uJbPqGVk6KvkDFtqD0rCaqrZ8K09hD7qWThwCdv/96jmM
         fuTLu6zd0afnbrbvr6iOo5mpTSPXxkp7RzmlRm0L6JO4YPFP+Vpc26LC+kJRPnzhMRnd
         jY9Yy2Qh+SKn5ZpHH0rcJjnCyL7Dldx+4ekqxmeL9GgZMslp4LrqX/h5iHWM27nWRvQn
         jpCOvf+CAV/jrtdY+2YuzLqYjUkf6Xjzebj1VAuqA1lungbjDHNFdyt/w02thQEHyMKw
         0T8fBS50/mEwCqJqT/RZeaDE75tKhShfrVg4rZLqQcKMEyhtcbkBOxPLvF/31zsxtF6q
         aMYw==
X-Forwarded-Encrypted: i=1; AJvYcCXcjuWn8N4QSxMDl1CvzqJqOQcGS6gaj8JkieXrnlls7gCyYfKPFFmeexxKml7d2f+ubnzC6CSj+DKgtDGu+NEfFZaUKseKv8O7lUaK
X-Gm-Message-State: AOJu0YxSyMLPrqEcOqX8I6/0hWICN8K42FYggtiTYtnViIrDyQgeY8rh
	FwSKATAIJ4A041iUFXnkv+oQbm7HYTOPQsgSLxY+aCe8FSMlTdU2MWoA0ukWzk2z0JPkO4RGHJq
	iHglAKH11MA==
X-Google-Smtp-Source: AGHT+IFAQcSwFKGcNCpGx6cDExUUokRstHtgNipOk4oYaWFz9OzYHZCeAbLOqEXX5BK7k/s00LnS2IvikgPe7Q==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:690c:398:b0:62d:a29:537e with SMTP id
 00721157ae682-63222565d7emr10233367b3.4.1718392732108; Fri, 14 Jun 2024
 12:18:52 -0700 (PDT)
Date: Fri, 14 Jun 2024 19:18:34 +0000
In-Reply-To: <20240614191835.3056153-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240614191835.3056153-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240614191835.3056153-4-ipylypiv@google.com>
Subject: [PATCH v1 3/4] ata: libata-scsi: Report valid sense data for ATA PT
 if present
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

Do not generate sense data from ATA status/error registers
if valid sense data is already present.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 79e8103ef3a9..4bfe47e7d266 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -858,12 +858,17 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	unsigned char *desc = sb + 8;
 	u8 sense_key, asc, ascq;
 
-	/*
-	 * Use ata_to_sense_error() to map status register bits
-	 * onto sense key, asc & ascq.
-	 */
-	if (qc->err_mask ||
-	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
+	if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
+		/*
+		 * Do not generate sense data from ATA status/error
+		 * registers if valid sense data is already present.
+		 */
+	} else if (qc->err_mask ||
+		   tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
+		/*
+		 * Use ata_to_sense_error() to map status register bits
+		 * onto sense key, asc & ascq.
+		 */
 		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
-- 
2.45.2.627.g7a2c4fd464-goog


