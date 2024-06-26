Return-Path: <linux-kernel+bounces-231624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F2D919AEF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D19B21151
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE80619413E;
	Wed, 26 Jun 2024 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BnlfWH+k"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7563519309C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443067; cv=none; b=HGGnLFFED1l6/GsGAPYp50gUhemRQsWhHdwbEg5AdvQhtvqj4YCRcmEOdJ3kJmlLl+ULYx6xcfVTJbaeFnf2NBDV3BTc8HlgITdCnt+ygscG8qEKvnG5V3GEkNmSvVzu+dNqZu4U9mW9bWyrieiGq82dASOegz0HZinI2ayj9Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443067; c=relaxed/simple;
	bh=khdJffv/7S+fJo+T1ERSS/3kzh8tOaLDJIGVkc4xP/s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YzfXz1pKsu4oi73RaMkvSNoRE8/wHh8fnjRH6XtrHG1m5O++s9bcshRJGdbHMYiiXLLYDZDdOXaE4qYT64auUC2bJFwOf+ng+Ag2VjAUhc4l3DK0Dz36VCBt5wuUCqhxzs1lJ6FoHZAqU5zYyEn3JPIjJhYPW1thkvR9J4W9kRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BnlfWH+k; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70667c46701so6134723b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719443066; x=1720047866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dnwRRitprzkm9CFQnXP8vP+tPUkvyuIbgLz5w5FglfM=;
        b=BnlfWH+kh4pCSzSEkA0JamA1/YmsqWcYd5476OH6k4G7l4Oblp6jxNxDyr1zeg9+0/
         BjeTM+s9+o0NhMPcINf+RAl/e2ET2gVrDoCcQIIIUymr3MgS3gBSjufDy+OdapotWTG2
         R6Gbk1DdvZv78rNwPb72ZcqORnjPibBYuWePHXQNbNBPa9ISpYp8knYKAYSCH4Fe5wCd
         gWfEor51PdTw1+Dsj2iIaRiFovVA19YmTkm7VP3H+hGDn/CMb01An4gqY/bfsQ82tPT+
         7MG9KazcDzqH6PpHM3JqjSBXI6iK8x0bzq1xpxUZxuz8aXDZKAQ6AbnFZ6JTq3oFWh7A
         jiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719443066; x=1720047866;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dnwRRitprzkm9CFQnXP8vP+tPUkvyuIbgLz5w5FglfM=;
        b=N17fOsXAbXT7GLvHMMcKBfrrhcg5lmLANzZ/rVSbuc6sEADBQAXeLRU+iiSs+Ic55F
         pJs81hwyoUtoQSnCCttd6J2gKsR9eSRYtAod9aT4e2WLLsTM1KFHyzZ/RDQvs0/8X6/X
         DFyGYYB2RS73HWqwNqr8axpD7QrCiVRr4fRZ55AZa4WXonF4jydMCfYzETqPH22GY61d
         eOUfNAagVTFeSPoTUpNATNnJqKWZXAbapUMcbEDhsuAXEF2a84vsQRpFtNaU5V12ebPR
         /qpf/zT+MVhLeggWVl1xLUF0XARXda7OJLyZHuyW0zfHP1NzXZw8Ab53F49Z9NBD12rk
         +Tnw==
X-Forwarded-Encrypted: i=1; AJvYcCUNVd0d/GAo/10YsZ3h2avqWCT0EQY/KMVfAhvGk6IsyoHngh73BiEvkF/8CTC0LENhN2GvNqgnd8yD6XaNkRMrz1LZQK/DggFNJeGU
X-Gm-Message-State: AOJu0Yyhg5I5rO9n37sA6CN1jN/kiyuv6Z1/ZHmHD/IKhzF8rPodhnaO
	cpl2V0MkTyr9uSUwrdVtSN/dIKILxVb5pliG+lVrPPj4bjZnm9zRJkpYVZFfyXM69tPG0/7d0Jo
	eE4QvGFS50g==
X-Google-Smtp-Source: AGHT+IHvsNwVLyqt1nlHJrNX+JOFz8qm6kONJcbmJ7hVLToZgq5nwNwp7+9RQ6WkWCM2moHWG+jhCkeW/hz4Og==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6a00:3319:b0:704:2cd2:7822 with SMTP
 id d2e1a72fcca58-7066e721059mr108308b3a.4.1719443065577; Wed, 26 Jun 2024
 16:04:25 -0700 (PDT)
Date: Wed, 26 Jun 2024 23:04:06 +0000
In-Reply-To: <20240626230411.3471543-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626230411.3471543-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240626230411.3471543-2-ipylypiv@google.com>
Subject: [PATCH v3 1/6] ata: libata-scsi: Fix offsets for the fixed format
 sense data
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, 
	Akshat Jain <akshatzen@google.com>, stable@vger.kernel.org
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index bb4d30d377ae..a9e44ad4c2de 100644
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
 	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
@@ -877,7 +876,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cm=
d *qc)
 		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
 	}
=20
-	if ((cmd->sense_buffer[0] & 0x7f) >=3D 0x72) {
+	if ((sb[0] & 0x7f) >=3D 0x72) {
+		unsigned char *desc;
 		u8 len;
=20
 		/* descriptor format */
@@ -916,21 +916,21 @@ static void ata_gen_passthru_sense(struct ata_queued_=
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
2.45.2.803.g4e1b14247a-goog


