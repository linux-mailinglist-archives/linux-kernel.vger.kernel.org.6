Return-Path: <linux-kernel+bounces-215451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 182F09092E0
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 21:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78318B2582B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 19:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED541A3BA4;
	Fri, 14 Jun 2024 19:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O2mQf/Y+"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B5519CCE9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 19:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718392730; cv=none; b=FsU7gY+g9EHkTyadYKaOkIMSkb8o5Z0t2m2rtDEEASc4XuCYQ7m58dB11NkqOphdFY3hibS20kC4tZll+9RwtsDKwcYIKYFCariCuMN5AvtFkf7QGh4hffPg5nEPcNfy85B+pXBMCPYpx9S0ZnTD7mZhuBmE7cgpzL+OKxlh9U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718392730; c=relaxed/simple;
	bh=3kS79tYzgOf3yX79jAg0FWDEvMWZi/lcq/PdWyuqi8I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AUg4hmrsO3R2CLqbq1jNxlCdJlrRwbh6g2eBdx/2yBwqOrdfLgfIaPAlfYi3PpId0qDcjiVA5ne8kJ1stTybv5jAs8xr2k/vYkSqu0CDmZkWiwYQRSU5Wcce0lOoqRiMNyYUvE4AwSJtD53lMX0rhDqM2LicpKbzCF/ynCGdY3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O2mQf/Y+; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7043008f4beso2242453b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718392728; x=1718997528; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uSZdAXqO25TNI8nIM2+VeqTcUj08zaT02GPeczOjqik=;
        b=O2mQf/Y+D2lUQrc4fDYQ1m9Jw+6YyybiHQumEJnQPA45YiF/loJ/TjkogH26TBQE+N
         XN1OmuuZEr3mHwkMfcDWzIt8tJMxmfaDvsbzv5+3snOjPvYkHkEtwTrGFEtjISX5TNwm
         jxqCEULJrKwV9AX7Hi/uHlbmsd+9kTAYUHYXrHcBhwy6Lku5F3jrxNX75a2bLhmxQGTQ
         XsxNu0wZFxpBc9wcR8aWYO0gYkM15OBg+C4elO5e2tvv/ZMqv3Xzoq02LsoezwoJV+bl
         QVVU88ZLKqE76mEWJB3uQFs4KWbOVp16dkIT50Cj4nxLOrWkSScJTkZnQqXfgvoYDpJi
         NaAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718392728; x=1718997528;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSZdAXqO25TNI8nIM2+VeqTcUj08zaT02GPeczOjqik=;
        b=kV1gs9EhVKTo1UUpeWBMn3YqPWd2KpxWK5VQNWPDJRcbgyD0+98QGTpNJykuGkNi8P
         UcKEvkQvK1JOZggiVlNeN5Cj9M9w7Khyyf3ou0fY9fti7jcyF0oB5PRDn+ElUARcVYlW
         FnEdSOc9+ZZTjLPOnw6/9IGBfvMyw7syHCoM4bBRPLEoYzhxY2UXOiKldkj7S096ETXs
         b9Tcy5abk5UKVOO99XLhmuD1cEQ9De1uaEjv1E+Nst//UG+yux1A9O3hAEXVPTY0cdS5
         +iwME/oWNwyXfQxr6C9XnSbBFEl9xedpEGYdhrFj/hMMfXwLPhiLQKj3ylHM8OvoicIL
         XbKg==
X-Forwarded-Encrypted: i=1; AJvYcCU98UT25N68IA27mbmL9zbDnDGC8G/C0KvF2a2RDwDrMum3ONVWnjADACXMWflsvTaaq7e3o0SaisPgG2b1Wllmwiq3KoltR6DN/nW6
X-Gm-Message-State: AOJu0Yx58Qsi+8pjXe2t+smCs32ZanZbMivi07PFgnkWQytQrbPt4Qf/
	Fb7kora7KhGw6ILKnS7Cd+/8d1juo+Qpqc/h4YBMxfNU2E9gBAnZzi9BXOxZiuIDKrktPI9lcEh
	uQhkmeegX5Q==
X-Google-Smtp-Source: AGHT+IFdj24c8fzBtMzoKfG+48fuiFtXBqhb0JfTQ+EiejlPio658jL+zK7WceIb3isG3JKB/NWVMCK8RBbQDg==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6a00:1d85:b0:705:27de:74e7 with SMTP
 id d2e1a72fcca58-705d70f12b2mr58576b3a.1.1718392728230; Fri, 14 Jun 2024
 12:18:48 -0700 (PDT)
Date: Fri, 14 Jun 2024 19:18:32 +0000
In-Reply-To: <20240614191835.3056153-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240614191835.3056153-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240614191835.3056153-2-ipylypiv@google.com>
Subject: [PATCH v1 1/4] ata: libata: Remove redundant sense_buffer memsets
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

scsi_queue_rq() memsets sense_buffer before a command is dispatched.

Libata is not memsetting sense_buffer before setting sense data that
was obtained from a disk so there should be no reason to do a memset
for ATA PASS-THROUGH / ATAPI.

Memsetting the sense_buffer in ata_gen_passthru_sense() is erasing valid
sense data that was previously obtained from a disk. A follow-up patch
will modify ata_gen_passthru_sense() to stop generating sense data based
on ATA status register bits if a valid sense data is already present.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-eh.c   | 2 --
 drivers/ata/libata-scsi.c | 4 ----
 2 files changed, 6 deletions(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 214b935c2ced..b5e05efe73f6 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1479,8 +1479,6 @@ unsigned int atapi_eh_request_sense(struct ata_device *dev,
 	struct ata_port *ap = dev->link->ap;
 	struct ata_taskfile tf;
 
-	memset(sense_buf, 0, SCSI_SENSE_BUFFERSIZE);
-
 	/* initialize sense_buf with the error register,
 	 * for the case where they are -not- overwritten
 	 */
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index cdf29b178ddc..032cf11d0bcc 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -858,8 +858,6 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	unsigned char *desc = sb + 8;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
@@ -953,8 +951,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	u64 block;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	if (ata_dev_disabled(dev)) {
 		/* Device disabled after error recovery */
 		/* LOGICAL UNIT NOT READY, HARD RESET REQUIRED */
-- 
2.45.2.627.g7a2c4fd464-goog


