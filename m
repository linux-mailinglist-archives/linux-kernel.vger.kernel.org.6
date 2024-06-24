Return-Path: <linux-kernel+bounces-228006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0086D9159A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC881F213D3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61941A257B;
	Mon, 24 Jun 2024 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CeoPKjEN"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA5B1A255B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267156; cv=none; b=qmxpeDqaR5X+/ccBrnhRUPd2xJqjeWH3Lx7M/V3g8OIYc4IGhZsD5dbLgkbd2wkBhfa/KXirB3jKiLU/zzCl+3nLYyaDQOtPEu2knY+Xct89WxuAuJXnmSQzLHxXHS75mMpSgLdx8avluFvFSdt1vqyj1BZJDppfWVUck2yj6Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267156; c=relaxed/simple;
	bh=H5jrycwQOQCdDzP8twQBwlLk8k5oMojnGk5RZ+lwoJ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D3598g8HdZ5vSJtgO9y8ESgHfGLfxFaVgxRVi4tRCTjhWgT8q/sBDDZ34JsxzuAL1unPpEYqaYlKdY4JybkdGyO61qwfcZpgw0EQzmXnutzGmKY71yX5liwXl763Md7JcJwjIYN9Bki+F5FY7w35O9BJNamlA+v1LnGcDTTITpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CeoPKjEN; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63bf44b87d4so55161637b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719267153; x=1719871953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T/zaNrBpCV4cTZnzSBNY9sM7nHv2+L5v4mANyaf/Yiw=;
        b=CeoPKjENBZb2J4VuW6bGUvi/X0QeGFXyM4UUyyf7nD6jvZaorIMDbRPU0XLMSjArly
         HLZQNpXH1wMWCaSF4NbQ40Qs7LSFYwJ58h1l8f1z+cv+idGFXr6HDQo8o4Ey+EgEQNTC
         dZ0xbb5fnItrNmAvXzxxBpfNoXCe/aGvuliGZcGJSQC/EbA6WO9NVSSwaliQDDABkTgf
         7bq7ZhSbqQheqkZfOnoYn4v7qrK9RT3zjpPpx92bgT6JhyU/uSsA1NeRMdOMOVSEX1qv
         tC6s0ONfvDKs55Au6+EdRL507MTO0HxIdXro9h875Mm6T4XR1D76Ww9tc2HhxvMImDTs
         GmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267153; x=1719871953;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T/zaNrBpCV4cTZnzSBNY9sM7nHv2+L5v4mANyaf/Yiw=;
        b=qdwQdkaA7G0LoUndHarK+eO0RRzI/x/O9n+bOnR83ZPPIqJY5xr05iSz7lT/6j4vtU
         2AuAS8mQ8cgd9VZ+HJkfsfseSAlyLH2J5ifhFBr3L1H+vgMmJsBwNQd5q1Y6kbqBs6dl
         i1HRF+Azqjjwp0KBCLJjR3XC3x4DEPgrLRBVBtDZWfvEpgJwZZIEjVFAuBy3qBJrj9WU
         orPsHVrJydQmMk+FHigF1vOCJLnS7Y/WeIZXavrIyQGLXcnVRaO5ZNYFotGUgGU4ubTG
         1nuCPqckvpyfggDv3DXShDLxq9+0F2FhPkxaZKegoQTTFEpIpHbXe8sKCk54OiN81EEf
         2oYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY1IaS4Y1yTf7qjtt2grvXmdTnDuZfkJ3NZc219bztN0UtZ66wfTVbjoo1b5P/Y0IvkNTiiGZXyT7p4kfr3IU4NzC579dYsy6R2Sl0
X-Gm-Message-State: AOJu0YwG1zs7l4KjVxwmE+kC43JTYkfKMjPhBVC5vzdh/rup8F5bvgbG
	wMzbfcXiOMuCH//j8Sty8/zIFrONNC+JmeogD56y9ytuD3hK6YlmAPuN+JT0mySinoNGKqA/uu6
	VUif7gTFXTg==
X-Google-Smtp-Source: AGHT+IGwpjqGiG6hgZr2YQON7q+hgaHg5oxM/rLJ5AZXXSxHW2LM1a7J7YCKisq5jnPXZ8sPzDD0RIZb9fURmA==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:690c:6a0e:b0:61b:32dc:881d with SMTP
 id 00721157ae682-64255f08ef6mr333117b3.3.1719267153627; Mon, 24 Jun 2024
 15:12:33 -0700 (PDT)
Date: Mon, 24 Jun 2024 22:12:06 +0000
In-Reply-To: <20240624221211.2593736-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624221211.2593736-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624221211.2593736-3-ipylypiv@google.com>
Subject: [PATCH v2 2/6] ata: libata-scsi: Fix offsets for the fixed format
 sense data
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, Akshat Jain <akshatzen@google.com>, stable@vger.kernel.org
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
Cc: stable@vger.kernel.org
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 54fed6a427b1..26b1263f5c7c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -245,9 +245,9 @@ static void ata_scsi_set_passthru_sense_fields(struct a=
ta_queued_cmd *qc)
 	struct scsi_cmnd *cmd =3D qc->scsicmd;
 	struct ata_taskfile *tf =3D &qc->result_tf;
 	unsigned char *sb =3D cmd->sense_buffer;
-	unsigned char *desc =3D sb + 8;
=20
-	if ((cmd->sense_buffer[0] & 0x7f) >=3D 0x72) {
+	if ((sb[0] & 0x7f) >=3D 0x72) {
+		unsigned char *desc;
 		u8 len;
=20
 		/* descriptor format */
@@ -286,21 +286,21 @@ static void ata_scsi_set_passthru_sense_fields(struct=
 ata_queued_cmd *qc)
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
2.45.2.741.gdbec12cfda-goog


