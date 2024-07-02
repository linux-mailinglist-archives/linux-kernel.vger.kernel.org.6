Return-Path: <linux-kernel+bounces-237195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E38EF91ED46
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FB7285CA4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 03:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A6217C72;
	Tue,  2 Jul 2024 03:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="zZGPYgax"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83AE179AF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 03:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719889328; cv=none; b=WH3LfZOMCmduYVvb444dmOD3qPuKgQuGzZ8bbWHuv0wV++FCUiqvM5ByY+HWlWioICOkXCOC6pbRU5lDr1pqa+C7z4bEYH3E3I8ismNh67qEDzYgDczWFl+4so2aY9IwaXgChvPChgMmqxRayg9Iy42WuPVL4AkRVP4gFYxGVdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719889328; c=relaxed/simple;
	bh=UCDnIvlbXHxWl6+e8JWZ0SNO53U4L0Z7h4tlBztH4UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EO3C02Acxmxl5VxDeZ6gWNLuu5X89O0YkVavaiIuubG2otbbGoPasedXcMA+/sK+Cp8tjkcCJyZCo/63ZWE7lr6qrOg/5sXG89O/ybevWNTiWGP7uzX/A1Ktwtu63g3NUuYqzmBXVobuARcqv0siuMnumI96xfHvef4QRI/AUmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=zZGPYgax; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3d562882f4cso2129734b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 20:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1719889325; x=1720494125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ch/9fGznoGin7U6AIXHdIml+kYt3GcqbmvGBGuHu5s=;
        b=zZGPYgaxE2Z6VL0Yz1OjdOMuiXYT9UMnziWmUaK9F36QwROACJqmHRgGMcF1Q9nlZ7
         NLFwkeQgNkladn/lRh6XHHy5VNdT51ATVpJPVhoQvi3tHcKY4XjtGYxv9aOpZATrk8SM
         342z2AGJCOE5Hr202r1fx2UT/NTJ3f3FRwdMCPShK0xBEfWE+3IJvxTIcY4U+q/fsl4S
         QbpNsgGP4Qv3apT2qNj5e+q6h8IUBs/w0Drg/YyIipxjKKkZeqLPtcMfiyyNO/9DpeGL
         z21TJcSK+dipfVlaMQ4x1YXw0J7m/WheCMcKZ6Qxcu/Rhz2y09HfFspmZiHzOXZ3w/iH
         4MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719889325; x=1720494125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Ch/9fGznoGin7U6AIXHdIml+kYt3GcqbmvGBGuHu5s=;
        b=Tkdcr9b4oZFUNBa5J7uzhGyXG/YeCJNucu4YnIS4pEG87CXF+Pe/K8ZOwlnmkbraxG
         L+3WJKLivvdYFFknfs0pAdnkGE/yzLx+pnEnyZ5ZWCd+ezWnQEcLFvTL/YpZfPXT+GwC
         M69VFHfjAg8ryTNuLf+28MS9KfJTQW/CfH0RbHK+PWH3ATeKlujjRqKGSD3uWAm32EV1
         UOsL2uFKoLlqeB5chfJwxfLbnYZA2yw0XaOTvHcnDnscUtp+IDHEC03KDvkRqBGMNBQc
         3v9vT6MYs6t1gb1sa4JHD27rPTxiQsjAmBcC8ikcpqjz3TzfFH/zUdYsi2LPwZYYT9DI
         uNfw==
X-Forwarded-Encrypted: i=1; AJvYcCUxEzzEYVhuJCe3qMIQGeg62KWjGae1UrpdHDJ5AR5MbKWaw+SY63qfAdEIgBs6rvbYV9RJFNQZzXeH7hLmG1XicY6v75eaXya7Zbt9
X-Gm-Message-State: AOJu0YymHbSBX9z1xsd242rsacr/OIG/6vt8ov8PauUOPKa1rSAfckcU
	iHGfYyxUBwfzax9zR9UV9EuHk6VH5/pN5iHwBJsquqdhN0LEtMDml3F67sZM5sk=
X-Google-Smtp-Source: AGHT+IE8j5Q1KWMxYedKMDkgJWz8EFzYcNYme7sBG3zoeLzjnHa41Q/99KbfcYc4l/efnsIjcK9n7Q==
X-Received: by 2002:a05:6808:1823:b0:3d6:9c05:1aff with SMTP id 5614622812f47-3d6b2b257e1mr12177786b6e.10.1719889324671;
        Mon, 01 Jul 2024 20:02:04 -0700 (PDT)
Received: from fedora.smartx.com ([103.172.41.200])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6a8dbb2fsm4792904a12.31.2024.07.01.20.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 20:02:04 -0700 (PDT)
From: Haoqian He <haoqian.he@smartx.com>
To: Christoph Hellwig <hch@infradead.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: fengli@smartx.com
Subject: [PATCH 1/3] scsi: sd: disable discard when set target full provisioning
Date: Mon,  1 Jul 2024 23:01:14 -0400
Message-ID: <20240702030118.2198570-2-haoqian.he@smartx.com>
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

When the target lun is set to full provisioning, the kernel
cannot perceive this change, so the kernel still thinks the
device supports the discard feature.

Discard will be disabled only after encountering a discard
IO error (a fully provisioned logical unit does not support
logical block provisioning management, so subsequent discard
IO will fail) or reconnection.

To fix this issue, we can disable device discard feature as
soon as possible during the iSCSI initiator rescanning session.

Specifically, we can reset lbpme bit 0 during the SCSI probe
if found the target lun does not support lbpm, then adjust the
discard mode to SD_LBP_DISABLE.

With this patch, the kernel can sync whether the target lun
supports logical block provisioning management after the iSCSI
initiator rescanning session, without IO error or reconnection.

Signed-off-by: Haoqian He <haoqian.he@smartx.com>
Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/scsi/sd.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 548c74ecc836..44a19945b5b6 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2709,6 +2709,9 @@ static int read_capacity_16(struct scsi_disk *sdkp, struct scsi_device *sdp,
 
 		if (buffer[14] & 0x40) /* LBPRZ */
 			sdkp->lbprz = 1;
+	} else {
+		sdkp->lbpme = 0;
+		sdkp->lbprz = 0;
 	}
 
 	sdkp->capacity = lba + 1;
@@ -3303,12 +3306,9 @@ static void sd_read_app_tag_own(struct scsi_disk *sdkp, unsigned char *buffer)
 
 static unsigned int sd_discard_mode(struct scsi_disk *sdkp)
 {
-	if (!sdkp->lbpvpd) {
-		/* LBP VPD page not provided */
-		if (sdkp->max_unmap_blocks)
-			return SD_LBP_UNMAP;
-		return SD_LBP_WS16;
-	}
+	if (!sdkp->lbpvpd)
+		/* Disable discard if LBP VPD page not provided */
+		return SD_LBP_DISABLE;
 
 	/* LBP VPD page tells us what to use */
 	if (sdkp->lbpu && sdkp->max_unmap_blocks)
@@ -3343,8 +3343,12 @@ static void sd_read_block_limits(struct scsi_disk *sdkp,
 
 		sdkp->max_ws_blocks = (u32)get_unaligned_be64(&vpd->data[36]);
 
-		if (!sdkp->lbpme)
+		if (!sdkp->lbpme) {
+			sdkp->max_unmap_blocks = 0;
+			sdkp->unmap_granularity = 0;
+			sdkp->unmap_alignment = 0;
 			goto config_atomic;
+		}
 
 		lba_count = get_unaligned_be32(&vpd->data[20]);
 		desc_count = get_unaligned_be32(&vpd->data[24]);
@@ -3425,8 +3429,13 @@ static void sd_read_block_provisioning(struct scsi_disk *sdkp)
 {
 	struct scsi_vpd *vpd;
 
-	if (sdkp->lbpme == 0)
+	if (!sdkp->lbpme) {
+		sdkp->lbpvpd    = 0;
+		sdkp->lbpu      = 0;
+		sdkp->lbpws     = 0;
+		sdkp->lbpws10   = 0;
 		return;
+	}
 
 	rcu_read_lock();
 	vpd = rcu_dereference(sdkp->device->vpd_pgb2);
-- 
2.44.0


