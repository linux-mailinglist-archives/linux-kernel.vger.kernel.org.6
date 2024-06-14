Return-Path: <linux-kernel+bounces-215454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 757519092E6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849751C20D46
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790011ABCB8;
	Fri, 14 Jun 2024 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6Yo+ktA"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B61B195964
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718392735; cv=none; b=AoR2K1VE8Wa/zWIeg/FVh9Kugut18R3V4WrNvCUBxQWM8NDJupjBumb+xL+mO5R1SqCKDX9UNb3rOCOE8EIc+oVC5v/DoQEuZ59oAVnOfUmAJ4AZcDaAHTp7x+MFQxWqH2PoC9ikJ1iOOueI0bFmb/n1sLhe41WhLIiMIjryIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718392735; c=relaxed/simple;
	bh=qgmtNL4k97jHCwRfQqDmBVh7jd6+0c78XagNpSAyDsc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f1fEvT7OPTmA3McVBdl/nmhogiGd6lCZAdXrw7nbW4CkhTP/XshDTI6FXm88FT8COQG8UsfbggRe+Ix3ral9tM9Gq9JiM0w2+WO/hoZquifq2rpiuxCX49rOCb+b8nEl0s+YHQdDcdJdcCFEfrk6Z10/olok9eESaoBwshuPn20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B6Yo+ktA; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6ea972a3547so2149134a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718392734; x=1718997534; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4AyfSTdpu6N2Lo5b6nZ4La1DDoSqqNXNC9AYdKo6X0=;
        b=B6Yo+ktA4Y6r0pnzTunJVbAAVCggpn02WJlQah7rNLepgOF10Ue7B9hbbDHeNi7Sff
         um9ZhtjPxHctqi4rM1PiBTV76aZksTMo7WhKDr+/9VFuY/3XSpIzmj6JCix2hslAV258
         ePiqhnQd3WtakFp0EqYdtrqnPkCJLnXh+xZ8n9licsks2I5uaws8Gd1lP9p5hK8vMVt0
         YLKsnZFUXagyci6m77TSRQC68AGLEJmaZMDgfqKYkvRmTb4C7N/HvXXLOme0jOI0dpKo
         a7Ye4bfKLypEV9dxmSQUUY5bwYpmTyLVPS2tw085zPtGWseih0JJ6UKT64ChrRd+andL
         ehRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718392734; x=1718997534;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/4AyfSTdpu6N2Lo5b6nZ4La1DDoSqqNXNC9AYdKo6X0=;
        b=e0+2Rbj1Tp9NRPRZV0orhTqB83JI6X6a9A+n4u6M52/RgAXECLmjhu2WTLEUfJpoCY
         fZnuJmAMyFurZWyxbQT3gAOq5ltARTqMS6xiYgtrHRh2M71XSSkMly9gNCo6dEXTu8QM
         vJ8HIUug4K6NRJ3bSUJyWfklDHuMOMuJE/A1vAgDXTka2TNArE8Qhb8RjukPu1iZM0bS
         UZm66PPldKzCbCQ/INDeDd6tjiVA8Aq7aMgL8nbUyynLQtpuhDY3+Qj91N0UwU5TJxhs
         eqqkbEbFRK1fp3zc0U5TtzE1VKF6wESlpi2uAv0MDKDO4Y1Z8JM5pAko3oAmwnOykfTR
         gF9w==
X-Forwarded-Encrypted: i=1; AJvYcCUE7bjY5iN8jMxMBSt2F6kJORXfAlMCzL+fdZcI8682IatNtw7BC3qZAhlf67c0QPdgHj7ALUiuFOXezfBCgJ36DewRC7HT9lAfn9tC
X-Gm-Message-State: AOJu0YzG/+4TjnhUwm5xydC8gKTy1XgmUS5+QHjvM/0isWByj6XesbRZ
	uR8pppwoKEg0QuoQShEMxlaTnRO6u/FQIgzRZLylWh+o5MbEJgu3f9g2Sq4G4G/y0uF941AOSKh
	1BVVoy0zrUQ==
X-Google-Smtp-Source: AGHT+IFhH0CY+7Imr4D7VPghy++YvEZgaw5IeIxH2RrSR71z103r+UyBHoV1Cf87mIAHSR19WF+ZEMhiq4U01Q==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a63:4c04:0:b0:6ea:87eb:9493 with SMTP id
 41be03b00d2f7-7019504fd99mr9226a12.2.1718392733536; Fri, 14 Jun 2024 12:18:53
 -0700 (PDT)
Date: Fri, 14 Jun 2024 19:18:35 +0000
In-Reply-To: <20240614191835.3056153-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240614191835.3056153-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240614191835.3056153-5-ipylypiv@google.com>
Subject: [PATCH v1 4/4] ata: libata-scsi: Fix offsets for the fixed format
 sense data
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, 
	Akshat Jain <akshatzen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Correct the ATA PASS-THROUGH fixed format sense data offsets to conform
to SPC-6 and SAT-5 specifications. Additionally, set the VALID bit to
indicate that the INFORMATION field contains valid information.

INFORMATION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

SAT-5 Table 212 =E2=80=94 "Fixed format sense data INFORMATION field for th=
e ATA
PASS-THROUGH commands" defines the following format:

+------+------------+
| Byte |   Field    |
+------+------------+
|    0 | ERROR      |
|    1 | STATUS     |
|    2 | DEVICE     |
|    3 | COUNT(7:0) |
+------+------------+

SPC-6 Table 48 - "Fixed format sense data" specifies that the INFORMATION
field starts at byte 3 in sense buffer resulting in the following offsets
for the ATA PASS-THROUGH commands:

+------------+-------------------------+
|   Field    |  Offset in sense buffer |
+------------+-------------------------+
| ERROR      |  3                      |
| STATUS     |  4                      |
| DEVICE     |  5                      |
| COUNT(7:0) |  6                      |
+------------+-------------------------+

COMMAND-SPECIFIC INFORMATION
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

SAT-5 Table 213 - "Fixed format sense data COMMAND-SPECIFIC INFORMATION
field for ATA PASS-THROUGH" defines the following format:

+------+-------------------+
| Byte |        Field      |
+------+-------------------+
|    0 | FLAGS | LOG INDEX |
|    1 | LBA (7:0)         |
|    2 | LBA (15:8)        |
|    3 | LBA (23:16)       |
+------+-------------------+

SPC-6 Table 48 - "Fixed format sense data" specifies that
the COMMAND-SPECIFIC-INFORMATION field starts at byte 8
in sense buffer resulting in the following offsets for
the ATA PASS-THROUGH commands:

Offsets of these fields in the fixed sense format are as follows:

+-------------------+-------------------------+
|       Field       |  Offset in sense buffer |
+-------------------+-------------------------+
| FLAGS | LOG INDEX |  8                      |
| LBA (7:0)         |  9                      |
| LBA (15:8)        |  10                     |
| LBA (23:16)       |  11                     |
+-------------------+-------------------------+

Reported-by: Akshat Jain <akshatzen@google.com>
Fixes: 11093cb1ef56 ("libata-scsi: generate correct ATA pass-through sense"=
)
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 4bfe47e7d266..8588512f5975 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -855,7 +855,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cm=
d *qc)
 	struct scsi_cmnd *cmd =3D qc->scsicmd;
 	struct ata_taskfile *tf =3D &qc->result_tf;
 	unsigned char *sb =3D cmd->sense_buffer;
-	unsigned char *desc =3D sb + 8;
 	u8 sense_key, asc, ascq;
=20
 	if (qc->flags & ATA_QCFLAG_SENSE_VALID) {
@@ -880,8 +879,9 @@ static void ata_gen_passthru_sense(struct ata_queued_cm=
d *qc)
 		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
 	}
=20
-	if ((cmd->sense_buffer[0] & 0x7f) >=3D 0x72) {
+	if ((sb[0] & 0x7f) >=3D 0x72) {
 		u8 len;
+		unsigned char *desc;
=20
 		/* descriptor format */
 		len =3D sb[7];
@@ -919,21 +919,21 @@ static void ata_gen_passthru_sense(struct ata_queued_=
cmd *qc)
 		}
 	} else {
 		/* Fixed sense format */
-		desc[0] =3D tf->error;
-		desc[1] =3D tf->status;
-		desc[2] =3D tf->device;
-		desc[3] =3D tf->nsect;
-		desc[7] =3D 0;
+		sb[0] |=3D 0x80;
+		sb[3] =3D tf->error;
+		sb[4] =3D tf->status;
+		sb[5] =3D tf->device;
+		sb[6] =3D tf->nsect;
 		if (tf->flags & ATA_TFLAG_LBA48)  {
-			desc[8] |=3D 0x80;
+			sb[8] |=3D 0x80;
 			if (tf->hob_nsect)
-				desc[8] |=3D 0x40;
+				sb[8] |=3D 0x40;
 			if (tf->hob_lbal || tf->hob_lbam || tf->hob_lbah)
-				desc[8] |=3D 0x20;
+				sb[8] |=3D 0x20;
 		}
-		desc[9] =3D tf->lbal;
-		desc[10] =3D tf->lbam;
-		desc[11] =3D tf->lbah;
+		sb[9] =3D tf->lbal;
+		sb[10] =3D tf->lbam;
+		sb[11] =3D tf->lbah;
 	}
 }
=20
--=20
2.45.2.627.g7a2c4fd464-goog


