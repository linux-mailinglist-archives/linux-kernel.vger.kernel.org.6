Return-Path: <linux-kernel+bounces-236958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 609A091E90F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC5011F23A64
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD208171075;
	Mon,  1 Jul 2024 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yOtzG8WJ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BCA173328
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863901; cv=none; b=lqYvTeVL0Ecv0ASNp95InE7HcXN2fcLExURGCha4V/jeyjiL6Oz1Rtw54trlOPg7+ygBmmPmSjlGziG2tprG/Rwt00/dTHCd8pz83zMCzEkWlZhIk+s/vXpS2zpFd+j89VcnO73SjJXp7yjDkTaCeLTlMgsLsqsOify9c5cr9mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863901; c=relaxed/simple;
	bh=SGLDCCdcSGl/5KZWzQWNbQHDwV7PVlEgpPhtBzv/BHs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mw/TQqokj7E6HmZ/azSLFZSJxO7afNdkUIRzmPZ4GaobKYWRHqhDdMrj8OQSFSQDxlLsFDNZ6e5kq6uNQpLsa6YZk78xQJJb/+wcBxSC5smtoni5OjHZr5f3WNuw/ih223sxJWx2nKFJe8YpoFAVtPF04zeTbnkchYPS+8EC8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yOtzG8WJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64a6cda8ba1so58835607b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863899; x=1720468699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AVwwqckKyhckc77/Vm3GySk6R9oDUsxFVKO3y3cHTK8=;
        b=yOtzG8WJEs1vUsgqA5seVUbbZlYb7arCrMoH4tcrjajgfrE5EkEnSVhTVfOBdwpa+z
         2ckXHNdMBZ0/pPkrE76O2n4Byp1ObY0+AfZ8o9oCKo/Ns6JxpzVJt7XaNQyEWnKKFYnd
         sV7FXQlTqKsOWOAn2kcZRAQ1apuynkiUcIm+xzOo8Y7MrjMJ5feJ7WTZSVhXV6iciwMk
         8c0qyIyGBehCmdLfiYGo95HTtoBLzwqW9hJywwd4TD8St+8PUUL5bG5NpbgrbE13IyB+
         MhoFaUZU0RF53nYegnbyUztzbx7zox94gw0HWMMRp6dmlgaUodsIHPtbnN2y+D62rgjy
         Z85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863899; x=1720468699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVwwqckKyhckc77/Vm3GySk6R9oDUsxFVKO3y3cHTK8=;
        b=Wb/x4t+W27vCydLdrqdBdK9pPbpKQq43YNhZwsZ/40Q49ghli3G772djEjFh4YSTIZ
         rLBrRMSL9NdhFoSTUG6noCJ6mI8epcfGU2u59KarDhlYXVGvFxrV5OPrzTlR8TFvCXIJ
         aLH3iooxFvY4BO63ywRvCjOIt0dtNbqwWNvhtza4HzZWSRPDZ5a9itvPOkUauvC1ScfU
         RyGNqvHFHRXTFuHshG1t/sEBb0oaBUZ8bxbIvJaJdWGgUEQpXB5dORzFxcJ3DX+ktKPu
         T/IyXbecI+ATYMw5iVn6BRXbxlqSCMMjbF7uTko0Hspj9h8dpDc3RJHJB41a1P4TyXB1
         jMtA==
X-Forwarded-Encrypted: i=1; AJvYcCUEq/pMjINJaYOrooO7gmhIVH6emePV8dELHZUa3+Fv5/yL7cUN/dlwjHRHKhWmiwtuH+/Ft+03i/VmvWCaTrEdhyFsTlIAIPjAdCQO
X-Gm-Message-State: AOJu0YzgRsLLEvAGsgXnI/G9AaboN2I3YGO3/xM0alOv6wG/rkKQgoxv
	RmJtDBFkZwWnXuqRBVoNfLr2ZJxW8MqAMCeA/78IDemT2UGBsNrk7A10v7kSxkPOUfrCo1Qdu5D
	aiPPsjxo7+Q==
X-Google-Smtp-Source: AGHT+IFUWN0zMur3c1eDEJteOuIigfCOtAjrWxujYZwgpJadqu5Y3EF6L0+M+Mf+VIqZA2gUeEINdCt1Ta4ZHg==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a81:6057:0:b0:64b:7bd4:1fcd with SMTP id
 00721157ae682-64c76d2ffa9mr194767b3.5.1719863898807; Mon, 01 Jul 2024
 12:58:18 -0700 (PDT)
Date: Mon,  1 Jul 2024 19:57:58 +0000
In-Reply-To: <20240701195758.1045917-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701195758.1045917-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701195758.1045917-9-ipylypiv@google.com>
Subject: [PATCH v4 8/8] ata: libata-scsi: Make ata_scsi_qc_complete() more readable
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

The ATA PASS-THROUGH handling logic in ata_scsi_qc_complete() is hard
to read/understand. Improve the readability of the code by moving checks
into self-explanatory boolean variables.

Additionally, always set SAM_STAT_CHECK_CONDITION when CK_COND=1 because
SAT specification mandates that SATL shall return CHECK CONDITION if
the CK_COND bit is set.

Co-developed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a66c177b6087..8f21b3b0bc75 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1659,26 +1659,27 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	u8 *cdb = cmd->cmnd;
-	int need_sense = (qc->err_mask != 0) &&
-		!(qc->flags & ATA_QCFLAG_SENSE_VALID);
-	int need_passthru_sense = (qc->err_mask != 0) ||
-		(qc->flags & ATA_QCFLAG_SENSE_VALID);
+	bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
+	bool is_ata_passthru = cdb[0] == ATA_16 || cdb[0] == ATA_12;
+	bool is_ck_cond_request = cdb[2] & 0x20;
+	bool is_error = qc->err_mask != 0;
 
 	/* For ATA pass thru (SAT) commands, generate a sense block if
 	 * user mandated it or if there's an error.  Note that if we
-	 * generate because the user forced us to [CK_COND =1], a check
+	 * generate because the user forced us to [CK_COND=1], a check
 	 * condition is generated and the ATA register values are returned
 	 * whether the command completed successfully or not. If there
-	 * was no error, we use the following sense data:
+	 * was no error, and CK_COND=1, we use the following sense data:
 	 * sk = RECOVERED ERROR
 	 * asc,ascq = ATA PASS-THROUGH INFORMATION AVAILABLE
 	 */
-	if (((cdb[0] == ATA_16) || (cdb[0] == ATA_12)) &&
-	    ((cdb[2] & 0x20) || need_passthru_sense)) {
-		if (!(qc->flags & ATA_QCFLAG_SENSE_VALID))
+	if (is_ata_passthru && (is_ck_cond_request || is_error || have_sense)) {
+		if (!have_sense)
 			ata_gen_passthru_sense(qc);
 		ata_scsi_set_passthru_sense_fields(qc);
-	} else if (need_sense) {
+		if (is_ck_cond_request)
+			set_status_byte(qc->scsicmd, SAM_STAT_CHECK_CONDITION);
+	} else if (is_error && !have_sense) {
 		ata_gen_ata_sense(qc);
 	} else {
 		/* Keep the SCSI ML and status byte, clear host byte. */
-- 
2.45.2.803.g4e1b14247a-goog


