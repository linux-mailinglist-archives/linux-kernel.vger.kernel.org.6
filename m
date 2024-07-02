Return-Path: <linux-kernel+bounces-237197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAF691ED49
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2230D1F22E1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AB012E1E0;
	Tue,  2 Jul 2024 03:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="opkiiNOE"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EAE12CD8B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 03:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889334; cv=none; b=olA6+eyznFnptbQZCztNYn5hPoYe1+sqEZ6jDVNu3UIOSCkXyBP/En0R9HkcAt8b2NrhnzAxCJ0ZM9me6n0huPTsb1sgio3kkxan/OQf0hXKW3pk0YPfTxd9lyT0IV0+NMd/oZNKy1uuVgTKB96NTEC03xuGdofd7a3okVM7QqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889334; c=relaxed/simple;
	bh=yiJFaJgdWIpSzq4I1bh4NFNS0sS3mumsKHKQMWi9Duw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBbm7n3IICYM/Pf9J6+ZEDxMNumO6ejeCg4/15MYUMDRlD3aMiO24Z0FfFXvxzUNdMjhCU8tKV032ZeILvDgOqclmFhnbBwLzEyV59P+x7sH5Rbsf85rq8xQsTI5Hcm0lE8UMm1PgEP8fjPHnLXSvgBOFgNcgyF1FlJzspt7dr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=opkiiNOE; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-375daa47685so14255875ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 20:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1719889332; x=1720494132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z5wro2DPQQzDm4JEbFr9RFX4ZrKb+KLG6vY37L6bP9Y=;
        b=opkiiNOE6G/+ZxDBex22KOc3oTB0pSYB7lJfPDnTQc16jMbCY81GKcS5sNUI4BgVwb
         o7VkuUq+B/oXK/1YjvPZnPRSoEK7+Yrj/ij+4udZwSAAcveIYl9W4jtuCEiCbH9+WfkR
         4f2SxYVJhFRF7gICy/UG09xXuDXJXuqaP3FwDaiX6rQMYM0WjIG6Mn+2BSqrMe3dRk0G
         aE3omH3f9AsaAThh+5RaEEy3yf+rnOq5BrN9f064V58bZ2Gi5Z5cDImjEC02V13NKWmj
         PV/LHColcl3zbJDA/E/XNfuYaxn/P178CCQtm24f92k/V0k9bukr3uoLS/2FNqH7Cqko
         72Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719889332; x=1720494132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z5wro2DPQQzDm4JEbFr9RFX4ZrKb+KLG6vY37L6bP9Y=;
        b=i815k+8lSmO8eVYRMh+HkdgKMKfMhyb/nU4qKrEcTn6uk3eni+3HZXGo/JFM9NK4No
         VVDu5I2rGm6v+MsBAmDL9ch4uYRViGs25vvmNk1fOLGaLPZjn6a89SzXL3Abu8hLv2pX
         jZINpS+beD9T0zmGaRaxQECrEEoJ25sslYc8slSKuztAjtZz01w8lXfxoUrWzqAVgI2f
         muUyojo4JSugWBix64aJVWJLQZOaXxG5dpphUfLeocu9FfEL16vTU2nsOhpfvdFUgVkJ
         a7a2s7zayaZSc8zW4dZNuyS9pn3z9i3onXzh4/cdVZYHeS2fqZra+blXQFdbMNASWIjd
         o8GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoG1054Qhn50Gtzy4Vl6s1EKJ3X7Vd/Ldain2dZHp3L43hqMpOX+JnlEiRDeSydc6s13/spkJr93m7eoyUOhWl/tJyfKoX60Pt/n47
X-Gm-Message-State: AOJu0Yw0C5csLoScTkkY9N+tBTHVDvotNa9vn/zBNKpVBW8q8h7O/0Qc
	I4J1kJKCf55D7tZgf8h1zgG++z9dDErnpmZJBROzxJJnG7+yUiPXcORk147WVTE=
X-Google-Smtp-Source: AGHT+IEpTMk59V3NV8KVvtbOMVVsa4fULF1zm0uglqoSp4Io1UgeVjGAy7FP7CAi425G0Y2cNLDt1A==
X-Received: by 2002:a92:c54b:0:b0:374:5a2d:178 with SMTP id e9e14a558f8ab-37cd07285b2mr89734205ab.2.1719889332060;
        Mon, 01 Jul 2024 20:02:12 -0700 (PDT)
Received: from fedora.smartx.com ([103.172.41.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8dbb2fsm4792904a12.31.2024.07.01.20.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 20:02:11 -0700 (PDT)
From: Haoqian He <haoqian.he@smartx.com>
To: Christoph Hellwig <hch@infradead.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: fengli@smartx.com
Subject: [PATCH 2/3] scsi: sd: remove scsi_disk field lbpvpd
Date: Mon,  1 Jul 2024 23:01:15 -0400
Message-ID: <20240702030118.2198570-3-haoqian.he@smartx.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240702030118.2198570-1-haoqian.he@smartx.com>
References: <20240702030118.2198570-1-haoqian.he@smartx.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The lbpme bit in scsi_disk can be used directly to indicate
if the logical unit supports logical block provisioning
management. The lbpvpd bit is no longer needed, so remove
this field from scsi_disk.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/scsi/sd.c | 8 ++++----
 drivers/scsi/sd.h | 1 -
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 44a19945b5b6..b49bab1d8610 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3306,8 +3306,10 @@ static void sd_read_app_tag_own(struct scsi_disk *sdkp, unsigned char *buffer)
 
 static unsigned int sd_discard_mode(struct scsi_disk *sdkp)
 {
-	if (!sdkp->lbpvpd)
-		/* Disable discard if LBP VPD page not provided */
+	if (!sdkp->lbpme)
+		/* LBPME was not set means the logical unit
+		 * is fully provisioned, so disable discard.
+		 */
 		return SD_LBP_DISABLE;
 
 	/* LBP VPD page tells us what to use */
@@ -3430,7 +3432,6 @@ static void sd_read_block_provisioning(struct scsi_disk *sdkp)
 	struct scsi_vpd *vpd;
 
 	if (!sdkp->lbpme) {
-		sdkp->lbpvpd    = 0;
 		sdkp->lbpu      = 0;
 		sdkp->lbpws     = 0;
 		sdkp->lbpws10   = 0;
@@ -3445,7 +3446,6 @@ static void sd_read_block_provisioning(struct scsi_disk *sdkp)
 		return;
 	}
 
-	sdkp->lbpvpd	= 1;
 	sdkp->lbpu	= (vpd->data[5] >> 7) & 1; /* UNMAP */
 	sdkp->lbpws	= (vpd->data[5] >> 6) & 1; /* WRITE SAME(16) w/ UNMAP */
 	sdkp->lbpws10	= (vpd->data[5] >> 5) & 1; /* WRITE SAME(10) w/ UNMAP */
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 36382eca941c..ff9ff2655c25 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -146,7 +146,6 @@ struct scsi_disk {
 	unsigned	lbpu : 1;
 	unsigned	lbpws : 1;
 	unsigned	lbpws10 : 1;
-	unsigned	lbpvpd : 1;
 	unsigned	ws10 : 1;
 	unsigned	ws16 : 1;
 	unsigned	rc_basis: 2;
-- 
2.44.0


