Return-Path: <linux-kernel+bounces-237177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD3891ED17
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE69B1C2244D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 02:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723EE1A286;
	Tue,  2 Jul 2024 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HWDOynoi"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F04D347C2
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888469; cv=none; b=pt8sbVdU8wJSfm/p0zUfSG+ZWr7i+QO0XgWHRJ3jNj94Ci/uIK4dNh+dfAIWj1RdE8bsHojBgw543/tgJ3IQII4mCIAO/HtwWB/lwIsBfRERhnxDf2/6qh23IngypvJQ5S/H+0TEGEmRlyULqe992VUK6HqypPi7wUhYeemF2qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888469; c=relaxed/simple;
	bh=doFIBDqtTa5Mu/2uxDG8Al0PrGigMDt7dbzK5fiISpc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PrZEcH6+Xmnu27Ww09pzXEqKwkVAigNe3JZTGbfZ6NZWe7wI2689YxSoyzZutDvsoBY+fb7vF4a2kYX4I2xDDqQI+eSEawdLUQWXKzdaCaRnh8girY3ruWCIv7vQBuCcIwWSrCiflpZEbEYpmoZXYt4BwkN+uwwporYjSd4PBZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HWDOynoi; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-706698fe5b4so3408072b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 19:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719888467; x=1720493267; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vWYD3CFi0xqKyZt66+JpR9ECkv5q52fY5lPhimPSxvE=;
        b=HWDOynoiXExHm+o81NswJuT6jt4dLHJkGrzmV1J/1fgAlSlpzd1sJqH7A4I7ad4p2a
         XMpdTZGHTKo5/LENxLUsMgUvcByS1uLIt7ppT14U3+0b5LanWuF0CxVdc/3GSJz07iP4
         psxGwklnYhrRrfSNG/Dp0AGEvPgjXjNrJT7tvy/cDAjXx7xGlVmP3yB6IVfuayrh5o3M
         I9ZneRMpTICHUozu/qV/URgyBkRM7YPSn6XEZNb8bXlgxyjAX+gclQ2oIdio7TBU8+hP
         dd+Cvq84YidQbU6+90c+5sSmnLOJxXL37vDErB2EyZCsL2lM5gk31/qykiFi+vro3MV1
         8BQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719888467; x=1720493267;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vWYD3CFi0xqKyZt66+JpR9ECkv5q52fY5lPhimPSxvE=;
        b=HlR+CHrwUbsv/8O4GYH/uug/mnU9+AbXk3A50GcQWZA7MTr02CthfC4P1kURrLJB0y
         fjhOgsZoOtVjdYv1UwkoX7RTVKntwvbJZDfQ5OqSuYE1sxBk+hCfUCVWT4KS04RzkfW/
         ptGcMgcm5yd+u4zB1Cc0xWxEtsbD4sl2zrUeJULraxqZCmrxx6Vd4jayXWP4tLoAaCSB
         ZOlr5NK4NDB9YHRTGlbLX1XGx5hFLNz/LY2YEiFDQPjmcxUcsiREV1mOtyxjGjaJx7V7
         db22y/8bfuKRZn0Gy7sbARhf9v0sSVkP5i0UXmClS0oyetG0UbyZPP3fe/v4wtD3UBjJ
         KgGg==
X-Forwarded-Encrypted: i=1; AJvYcCU/fEoy1GF+v4QbVtzQrubiG4MVmZyMhwk1DKfAb/JLgYans+Elvy+znRPS+d+3pgCvA0lPuYhWBo9uOlQLUdDamtZaCYCzUMyg1pYH
X-Gm-Message-State: AOJu0YzqkaBpwtznaiiNxEwzfGc2qA1oTyhjX1Z4EC/hC+f1NS1TEdhP
	AHOmCoODqH5FfK5jPHmZYRf5DqH0aFzb6W+tWDqPIf6Xo3c3GGGJzT5xejO3oSkRlywMe5Gx8DN
	Mcn0HNvZ+QA==
X-Google-Smtp-Source: AGHT+IEnUZWAIySfE2wBFSt1tDNvCahMYriM4Y6yt/rtcfr0+yUwTcq1HyF/y24/NusyTaAevhRKjh5UEFw5Yw==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6a00:1304:b0:708:2033:63e with SMTP
 id d2e1a72fcca58-70aaaf6e482mr474635b3a.5.1719888466711; Mon, 01 Jul 2024
 19:47:46 -0700 (PDT)
Date: Tue,  2 Jul 2024 02:47:32 +0000
In-Reply-To: <20240702024735.1152293-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702024735.1152293-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702024735.1152293-5-ipylypiv@google.com>
Subject: [PATCH v5 4/7] ata: libata-scsi: Remove redundant sense_buffer memsets
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

SCSI layer clears sense_buffer in scsi_queue_rq() so there is no need for
libata to clear it again.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 076fbeadce01..145319874c1a 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -926,11 +926,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
-	unsigned char *sb = cmd->sense_buffer;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
@@ -965,8 +962,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	u64 block;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	if (ata_dev_disabled(dev)) {
 		/* Device disabled after error recovery */
 		/* LOGICAL UNIT NOT READY, HARD RESET REQUIRED */
-- 
2.45.2.803.g4e1b14247a-goog


