Return-Path: <linux-kernel+bounces-382441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 150C69B0DC0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8070B2873E2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F50820EA28;
	Fri, 25 Oct 2024 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ttkvU98y"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B51720102B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 18:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729882216; cv=none; b=PW6fjjfVpV9mHJQBwI9DXq0YcEQhBRR8KI6Ejmj5HG6qIAsnZnchp6E3uVMI1741hFXvQJAVyg+2RA62aSW/4sb68CxeoI6I8+SyZSUx5CG9aWpZCt5WZObOHQVR7rcCmMiL82/mcMq7cyr1vSmov/HVEE+vYEsanOxdPutxN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729882216; c=relaxed/simple;
	bh=CGB6LxmT0WXhEjsf6xrepgUWVuXW/Zv1jXqqTyC2SJo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z4t1XKdp2R051YSMl0usjo6TU4IB6A9Xo8e+/WhHPkhC0DQwd59UMvUrvN7JrGDgpzM16Khj5/+oh6Ov5GnDT5Pbv7uuuZUr35q/HrXK0bbAqdHQ/TYFDaqRjHNzjKUAgQK9cO7B3F8BHytHjnHbofSv/nDsUJ3IRGkhT/+s3/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ttkvU98y; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20c8b0b0736so24970975ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 11:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729882214; x=1730487014; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=e0+NHsCuboH95g4yQb8qYWh0zFmSJiQuZvvpd/g2KQA=;
        b=ttkvU98yL+mcy3GYGZhq0+Z/f+Lsk2pqb6Njgzjmbvg9mKgNdx6YfHN+ccj+rhSVsV
         LxswnyskcCjxkksMDhHY2iDX6OIIxHlizrckEBmu2KPr9KVztq8emRMwkuX/7dim7jju
         XDw5+aY0PKBJkXBkQb2poLt0DizYYvVmqH5hTH7dyr2D9lAf+19n8e2Pir8IKBUngkUO
         QjYOBGcZSM4uCGtBFH2tIfbv+iNCtdC5aLtRo84qnl5mjzbCuvtWFg07dWjTnPFFQq4W
         h5/FqAcRhNxiCwFmS5IUVN+LtOX5oO8YU6srMEKPMGrVAjBK9Xi9YmoWMCPIkBQY8dwr
         oljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729882214; x=1730487014;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e0+NHsCuboH95g4yQb8qYWh0zFmSJiQuZvvpd/g2KQA=;
        b=MMfOuYpeN0hddBOBft0hzAEY3Lwn9KBuX663jAwW6t1m+7xC2H1StThh7j6j2PdZMc
         uAGhtpRbB6Io91e+ZpKjfG4uouPpJGGTLWj+M/X80SrQAP1fAkdLqOsUo43qm8oV3vPg
         X3oZu66CuWxTIhH3vc5Lc8lE/oIgYHxpjOOB4GRwOfC0uyW8kzsWPRgelFxuypUPRl+V
         PshHmu5mnqXctkrgQZFF9KMHmclo3s2x1qoxW4WNsg6RYNXO7LAaEPAeNXtNN4A2I7SD
         kbjAhcR4N/m/LGdK9E/B8BkHh7UK7Ffgfup0Ozlau4YtP2HSBz3r0j/Jy8EC2BPZFqPZ
         Z4Hg==
X-Forwarded-Encrypted: i=1; AJvYcCW3icW2wOa8x1/lIKqcDx2Aqxv/kQRj0ngv+u/fRBvChk12SoPKidrqfCXQuGRAg9duAhhQTrUUqETm3ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl6ZfXtmJCssy0RWqLoVzJz0gNyooaZ6/4JWIZfyY4G4SgqouH
	vCq1OdmSAEqW0RJBfVGdLRsMiahuyt40U5F9n8TkLqAZVBkiqP1aAFiLWckQiDClPxCvLPfPw87
	FMSJ0m6IrCQ==
X-Google-Smtp-Source: AGHT+IHm7qoXaMzwNAnNJmodVt+UDTG1/KMKRAhan8DuhRdo0c3Sn8G90KEAwU47YeMs5XVE86rIcoyZHC9Vww==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:ef:85c8:ac13:4138])
 (user=ipylypiv job=sendgmr) by 2002:a17:902:f544:b0:20c:ee32:75a6 with SMTP
 id d9443c01a7336-210c6731cdcmr2755ad.0.1729882213968; Fri, 25 Oct 2024
 11:50:13 -0700 (PDT)
Date: Fri, 25 Oct 2024 18:50:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241025185009.3278297-1-ipylypiv@google.com>
Subject: [PATCH v2] scsi: pm8001: Increase request sg length to support 4MiB requests
From: Igor Pylypiv <ipylypiv@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

Increasing the per-request size maximum to 4MiB (8192 sectors x 512 bytes)
runs into the per-device DMA scatter gather list limit (max_segments) for
users of the io vector system calls (e.g. readv and writev).

This change increases the max scatter gather list length to 1024 to enable
kernel to send 4MiB (1024 * 4KiB page size) requests.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---

Changes since v1:
- Added .max_sectors = 8192 to pm8001 scsi host template.
- Defined page size, sector size, and max I/O size to calculate max_sectors
  and sg_tablesize values.

 drivers/scsi/pm8001/pm8001_defs.h | 7 +++++--
 drivers/scsi/pm8001/pm8001_init.c | 1 +
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_defs.h b/drivers/scsi/pm8001/pm8001_defs.h
index 501b574239e8..7871e29a820a 100644
--- a/drivers/scsi/pm8001/pm8001_defs.h
+++ b/drivers/scsi/pm8001/pm8001_defs.h
@@ -92,8 +92,11 @@ enum port_type {
 #define	PM8001_MAX_MSIX_VEC	 64	/* max msi-x int for spcv/ve */
 #define	PM8001_RESERVE_SLOT	 8
 
-#define	CONFIG_SCSI_PM8001_MAX_DMA_SG	528
-#define PM8001_MAX_DMA_SG	CONFIG_SCSI_PM8001_MAX_DMA_SG
+#define PM8001_SECTOR_SIZE	512
+#define PM8001_PAGE_SIZE_4K	4096
+#define PM8001_MAX_IO_SIZE	(4 * 1024 * 1024)
+#define PM8001_MAX_DMA_SG	(PM8001_MAX_IO_SIZE / PM8001_PAGE_SIZE_4K)
+#define PM8001_MAX_SECTORS	(PM8001_MAX_IO_SIZE / PM8001_SECTOR_SIZE)
 
 enum memory_region_num {
 	AAP1 = 0x0, /* application acceleration processor */
diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 33e1eba62ca1..c87443b14ff7 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -117,6 +117,7 @@ static const struct scsi_host_template pm8001_sht = {
 	.scan_start		= pm8001_scan_start,
 	.can_queue		= 1,
 	.sg_tablesize		= PM8001_MAX_DMA_SG,
+	.max_sectors		= PM8001_MAX_SECTORS,
 	.shost_groups		= pm8001_host_groups,
 	.sdev_groups		= pm8001_sdev_groups,
 	.track_queue_depth	= 1,
-- 
2.47.0.163.g1226f6d8fa-goog


