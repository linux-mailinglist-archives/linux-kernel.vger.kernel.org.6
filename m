Return-Path: <linux-kernel+bounces-220592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9404B90E426
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893BD1C20A30
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 07:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B7E7580D;
	Wed, 19 Jun 2024 07:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="gxi7KgWK"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB6757F3
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 07:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718781304; cv=none; b=oyU+pP8WC++uWiRTFYT8EKWvJoKNWXDBFGQUXycmWTKxBlbwIYDId/rrsHKHYcWrF/kY20Q06riVmAHS1ZMa1Y5UY7aH9Bg2xxpTkkU6RpGvRnKV+HkV+ytr2GNXxuYg95+lpwRd6XGMPFzkFph+S5Dqww8RlKa8IH1snYyQwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718781304; c=relaxed/simple;
	bh=EX4t+3xm8l3Q1wykGkU1o3cyd8qUxK6piIGJGvSRg50=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=hAHzxc3Inw8jt1D4g/ZUbgLPKqzXHu18sFfRsFAwkIBwt/PapdfNCFXvSVeDheSCeaVZ46M5jjFbgAfldTQyVyG78CKst+3qib8XszhYKfQc0fHQMy5WNarAiAM7T0e+/+JfXEP9+uEbPmjQKCpznF80ihod43x7Pf+HnJLRIX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=gxi7KgWK; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f99555c922so3633756a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1718781301; x=1719386101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Skd7XFv1VpSVP5Nz+gUbCXLZPArGMYNgkzg+l7mFaqc=;
        b=gxi7KgWK6qDSkUAfI+kPq2oCgvqjkvWZf3yy8nEXVBF1BBtmdCPvaOCjIfluMztGyD
         nnDz8cjB8Vl6ISUV87GpmK8tS5wbcfLB2bYO72lBWA7B9NevnWovPAcxkxxasOiCo/r6
         0+n/lOf2Hpots67naguvbLoLQrt5FffjEvPSsoUrrtt7ara3FVKPwSrwMqiE6nr67vTD
         lj3IpKo5iT7gxzTXE1VViaJ94eOkfldtSYLhcNyYxp/C+cClqWlV8gyyJQmbi+2wDKjA
         HMCBtzSqThQag8dPfgSI2GxzTWrwJY40j51s+uTocZbNXjEeugRsMjCF1MWYxZcLnX5B
         a6vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718781301; x=1719386101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Skd7XFv1VpSVP5Nz+gUbCXLZPArGMYNgkzg+l7mFaqc=;
        b=u37dlj5uNq8UCRs2I4nZMgaQUYvsxe/OuPUmlESc615tCmXrnj71yISnvGuYX+AfIc
         5Ro6qVuguB4uBK2oX90Tevw5VzJhyBaciJCHgEaXqHzUKPZuurfrLrpdy9i6eUSamY9F
         w3WB61fNuX4Njiyc1EepllYNo/C9O/E1+orwWJSG55Fgbe0ShSDFaTaeTU0TtxEIjoGn
         7XHCs9ooJviqVekvKm+yHTU8H4nUG11YIRnMwr03tbZlFpeZmUkWh7URcVvRMo2S7gE7
         OIGER07esfLK36ZM3oMLjwuFcDquof3637yhtIG3Mzn8/pe0gbZrQU1SMsomHZMEeXzU
         hqOw==
X-Forwarded-Encrypted: i=1; AJvYcCVHVfj77avyr6zOC8sgD/ioPRkN+Srz/NNqKWvlCmSaAl5jTeyIWcV2wKfvfm2HvL3qoRH0mW1gJAe4FgABbdEPe0TkSmCpTEECbRHJ
X-Gm-Message-State: AOJu0YyMYVCkTPUSr1OXv0gNtKipaYNDR/6m96bFgOnu5Di4gDVpKCar
	gf6v17CtIiVU6AztAKR/hJek0XfussC06Eyr8SKZUiWs/tTAB4vDqhnDsg9g6DE=
X-Google-Smtp-Source: AGHT+IG7O3ICtniQOneaeIPZYCNZjjl4rvONDhxstG56u2rMRyHM9mj6qtwBBthgaCjatBgs0U0Zyw==
X-Received: by 2002:a9d:6296:0:b0:6f9:710e:65a1 with SMTP id 46e09a7af769-7007568bbd1mr1952243a34.28.1718781300665;
        Wed, 19 Jun 2024 00:15:00 -0700 (PDT)
Received: from localhost.localdomain.cc ([103.172.41.199])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6fedf2a74dcsm8993316a12.46.2024.06.19.00.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:15:00 -0700 (PDT)
From: Li Feng <fengli@smartx.com>
To: Christoph Hellwig <hch@infradead.org>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org (open list),
	linux-scsi@vger.kernel.org (open list:SCSI SUBSYSTEM),
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v2] scsi: sd: Keep the discard mode stable
Date: Wed, 19 Jun 2024 15:14:03 +0800
Message-ID: <20240619071412.140100-1-fengli@smartx.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a scenario where a large number of discard commands
are issued when the iscsi initiator connects to the target
and then performs a session rescan operation. There is a time
window, most of the commands are in UNMAP mode, and some
discard commands become WRITE SAME with UNMAP.

The discard mode has been negotiated during the SCSI probe. If
the mode is temporarily changed from UNMAP to WRITE SAME with
UNMAP, IO ERROR may occur because the target may not implement
WRITE SAME with UNMAP. Keep the discard mode stable to fix this
issue.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/scsi/sd.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index e01393ed4207..f628ca5ac0ac 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2621,8 +2621,6 @@ static int read_capacity_16(struct scsi_disk *sdkp, struct scsi_device *sdp,
 
 		if (buffer[14] & 0x40) /* LBPRZ */
 			sdkp->lbprz = 1;
-
-		sd_config_discard(sdkp, lim, SD_LBP_WS16);
 	}
 
 	sdkp->capacity = lba + 1;
@@ -3271,8 +3269,6 @@ static void sd_read_block_limits(struct scsi_disk *sdkp,
 		if (vpd->data[32] & 0x80)
 			sdkp->unmap_alignment =
 				get_unaligned_be32(&vpd->data[32]) & ~(1 << 31);
-
-		sd_config_discard(sdkp, lim, sd_discard_mode(sdkp));
 	}
 
  out:
@@ -3671,6 +3667,8 @@ static int sd_revalidate_disk(struct gendisk *disk)
 			sd_read_cpr(sdkp);
 		}
 
+		sd_config_discard(sdkp, &lim, sd_discard_mode(sdkp));
+
 		sd_print_capacity(sdkp, old_capacity);
 
 		sd_read_write_protect_flag(sdkp, buffer);
-- 
2.45.2


