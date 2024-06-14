Return-Path: <linux-kernel+bounces-215452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D4B9092E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C58BD1F24966
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BE31AB53C;
	Fri, 14 Jun 2024 19:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3iA6cSmg"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9111A3BB2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718392732; cv=none; b=QYE7/FUSs3XlvEYf/rfJ5s7vJENDuK9Yqf5LJdJN6FXGmbIhTxpWLBu6usGNymqzzzWS6bHlJyF9sb7hhaT9YPPIjyN7G1VxLP1rimzG/wVUfssr26+/ocjnYmsvT41r3hx37OXW/LBEVNHiqPqS2487MnUqZI4VnFJ/KYc65dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718392732; c=relaxed/simple;
	bh=OXTK3gM4Pr8t3G/JNhWI9HNDMuZTEBhK+WvzY4WWxdI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J7/g/bDEfNxwrhMw1V4RnUVBvDKn1+NIejdhRCKNYHUvtTzev05OIBzLWrqxRGbVb4h1VMFmERzRlTssEqICTx0YTh1R63A7rT2hNUNhp9/myQg13DTNRNyaatuAfNEdNBUnGfHCGIP713BCysrvcE/aa4kxTtSNs0zKJlhGgkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3iA6cSmg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a1e9807c0so27015047b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718392730; x=1718997530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U+A9L+Row2dnJmZ3QpC1oG5yWdVfX7wPmeHXsPZEOds=;
        b=3iA6cSmgYmEBTuAgmjE3+BsFfK1KRTliplTZ7NlVWdBBZBovwI0cTZ5q8F43rizXy/
         Artx1iqvVwlwgpPxw+rJ8r5w9x8qAU+VYmod7v3tQuBNBPkp0NHqQp6xyo2zQ4d1MFLn
         k8TBdh71DQwG24lcmDAwS6z470rPqSWjsPcaCi+aG94irDaAIYZ9e5Mp1h6PPO6JVWTJ
         TTXFsL13IbOmK33I1LiWsNN0+WtPVLIycowaoTj8HFnms4W6KrDd7CZh9VjoTFnXqi5n
         a1OuAih5hDOrWfZEHfPb1WZE8bw6RhGkUJvZWfCNDMOfYhKiUNG7MSqqUWjPmeZf7q7j
         m/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718392730; x=1718997530;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U+A9L+Row2dnJmZ3QpC1oG5yWdVfX7wPmeHXsPZEOds=;
        b=UD3dK/vr3JZCiCZsAcSU1cI55fon2Ih3/SIjCdiyDDfR3FVhORm2JyyACVbGbOgArE
         SuMx8Tj7OkPGIlxn7kRd+hWdnewGfMpKPACpJJJMM8uLyiOnl5ucnpT/MzaKJIpcAlOO
         hNhG93NPw3JJPmzM28jq0pSNTY8clhsyrpfPoaSiWx57TUC4rXLk82R2PR1yxukD/BHH
         Pon/+CtoWZkIG9F9N8YgCh+qq7X9GF6tdloxQIP40mGCavp+1HxUyhc+MIcwrv1y0j04
         OLzJW9XdSdEN7+0NwxE/ojsBQrps2TZRJOt7Y2jJy6JVisV+T26FoXbkMNrctSSUvxI9
         T+jg==
X-Forwarded-Encrypted: i=1; AJvYcCWbygUggHX6AQ2LZFGfHMCRdoODKE2ppEkMB5ZETWNBB5kS0iYfmv7exjBpgbQHq8HXHmmVn2awDV4V4qq18oLDxVy4tA5kjrFt0Ham
X-Gm-Message-State: AOJu0Yz4P815x0lKRqKArH5pPySHVtS4URbUCJS7PYp80AR/hO8XFSEW
	xT3LA93qRyBU+TFKfynENRWoalCPbxecXogbCBfRNSfJYCfwX55n5elRNYUFYDHyNIR/knSlxRy
	hpsGcfsF8qA==
X-Google-Smtp-Source: AGHT+IEgr36e43Ztcq9blL3xwno/d+31kbeTYxCB2shQPDd8Hlpao0W3TzB2dN5UT4kq97FW/dtEczVMQBa9BA==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:690c:6e0a:b0:618:5009:cb71 with SMTP
 id 00721157ae682-632072d3bb5mr9083077b3.5.1718392730342; Fri, 14 Jun 2024
 12:18:50 -0700 (PDT)
Date: Fri, 14 Jun 2024 19:18:33 +0000
In-Reply-To: <20240614191835.3056153-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240614191835.3056153-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240614191835.3056153-3-ipylypiv@google.com>
Subject: [PATCH v1 2/4] ata: libata-scsi: Generate ATA PT sense data when ATA
 ERR/DF are set
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

SCSI/ATA Translation-5 (SAT-5) Table 209 =E2=80=94 "ATA command results"
specifies that SATL shall generate sense data for ATA PASS-THROUGH
commands when either CK_COND is set or when ATA_ERR or ATA_DF status
bits are set.

ata_eh_analyze_tf() sets AC_ERR_DEV bit in qc->err_mask when ATA_ERR
or ATA_DF bits are set. It looks like qc->err_mask can be used as
an error indicator but ata_eh_link_autopsy() clears AC_ERR_DEV bit
when ATA_QCFLAG_SENSE_VALID is set. This effectively clears the error
indication if no other bits were set in qc->err_mask.

ata_scsi_qc_complete() should not use qc->err_mask for ATA PASS-THROUGH
commands because qc->err_mask can be zero (i.e. "no error") even when
the corresponding command has failed with ATA_ERR/ATA_DF bits set.

Additionally, the presence of valid sense data (ATA_QCFLAG_SENSE_VALID)
should not prevent SATL from generating sense data for ATA PASS-THROUGH.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 032cf11d0bcc..79e8103ef3a9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1632,8 +1632,8 @@ static void ata_scsi_qc_complete(struct ata_queued_cm=
d *qc)
 		!(qc->flags & ATA_QCFLAG_SENSE_VALID);
=20
 	/* For ATA pass thru (SAT) commands, generate a sense block if
-	 * user mandated it or if there's an error.  Note that if we
-	 * generate because the user forced us to [CK_COND =3D1], a check
+	 * user mandated it or if ATA_ERR or ATA_DF bits are set. Note that
+	 * if we generate because the user forced us to [CK_COND=3D1], a check
 	 * condition is generated and the ATA register values are returned
 	 * whether the command completed successfully or not. If there
 	 * was no error, we use the following sense data:
@@ -1641,7 +1641,7 @@ static void ata_scsi_qc_complete(struct ata_queued_cm=
d *qc)
 	 * asc,ascq =3D ATA PASS-THROUGH INFORMATION AVAILABLE
 	 */
 	if (((cdb[0] =3D=3D ATA_16) || (cdb[0] =3D=3D ATA_12)) &&
-	    ((cdb[2] & 0x20) || need_sense))
+	    ((cdb[2] & 0x20) || (qc->result_tf.status & (ATA_ERR | ATA_DF))))
 		ata_gen_passthru_sense(qc);
 	else if (need_sense)
 		ata_gen_ata_sense(qc);
--=20
2.45.2.627.g7a2c4fd464-goog


