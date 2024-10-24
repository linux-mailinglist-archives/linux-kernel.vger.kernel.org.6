Return-Path: <linux-kernel+bounces-379037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09E259AD8DF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 02:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C00792842FF
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 00:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD5F28EC;
	Thu, 24 Oct 2024 00:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nw7UpTS4"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89AD19A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729728633; cv=none; b=aCaDlP48cE9Th3SHwZ+Hiftfc03NHuzEz0b74yKArSq6o1gdqDuVemHjZBsVHiNnka4k3fOzt4Od1XDlTBAxzuaFnmGodlkXE0qq77+DQhIw/nZv8cQ+VmC3VBaZsobVhZ1FAbulvvU4/UE4+FeT8z4pywz2Zt6cVfOgSmtylhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729728633; c=relaxed/simple;
	bh=pO8jRUQKiiRSyULkcGNzFxzb0R9zsBiicDm7NGwGtMI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bYBDrWpPG94CrjR2AAe3e1SFn7Y2AQtMTCwHPEBW4Fl0QTljDjvQybmjRMxVsgCG8w/R/1cqlqN/V54MZGYmnFNQ0m8OD/rsKSINo8zQhjgwtnGbre3Na842mIcvPmNzme+eNfZ4+rdkT6Ee8ubBlSmirL3igASSWTIUh961AAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nw7UpTS4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7ea7b3b056eso255680a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 17:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729728631; x=1730333431; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/0+RA+gT9wgHz1ORAVPSn3bBMedEidFe8UN+huLuIj8=;
        b=Nw7UpTS4+4OIh2h4akIl/nxMnNbnIb1e/EmIBZrfYu8GEPitxZVmdustcNPBMEXGEr
         aULM8Y9u5PNlmaOAVjHHiwCGvGgH98RmKoe4/NnSa1OJZNjEyd1S1gvDZWAy+xssz7tk
         EibnT3qGljU+vxPtbDh+CCMUuTsoWxHMH3aqXBUyXREszPgEueywU8DkEx3CMAMjkn/H
         h/QSePVMi161O2KkTDFL327u0SMBIRoM03BymjlRfWCzC/I66+t+/Ir7/zXmNouHD0E7
         Mt2DPvV0u4xXj9w+h3v+PkO8yqKjt1srO5cWz1wiLIN4cKUurzqieLhyN585D8saAznV
         t5+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729728631; x=1730333431;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/0+RA+gT9wgHz1ORAVPSn3bBMedEidFe8UN+huLuIj8=;
        b=BzctqisvqKErrmjnTNMDp9YLHwLjQ6X3TJG7QhZCxZTaeib97J+CIBSRDeKaurJlNA
         cmpNUcb6cUKpHSfZ11v/+kbeUuTKlZipW7tDE0It4BS6He/mRVUPq1cthUOV6f7XNf26
         ZpEmNXhAmLCAes82t59jdYGSJAV96c51EKVblvKHTH+FP7YP8In8BqX0n3eQBMBtXTde
         /npTfvFeiNuFc2khVQY2Fl+PgEPid7gG4fu0viWKO1HI1FGX0HJhXPHipbdP8tLjEKtW
         wcY8f/S7R2VxXVkqBtjuHM3V11cvYsJRPOIEEKtTJ40pP8pMB3SwQg7XAReMPkl4qEB+
         oC8g==
X-Forwarded-Encrypted: i=1; AJvYcCXqj4pl+14uWBN3aPudJDqYbgMnCeUjXUPJAEnfDPHzm/Dk0fjwN+/+sPhNH/ZjbGgJ8JuzMJQwhW5APsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZNKjkF0qYB8Cb8CSxC221HbmDNvpLsw+DNEGmW5DKcpDcYrR
	LMw4t3xeQN+RIpCpEBpPlsR00zgrdfrZ3Yy60EQ5NEtEI7xgPw8W39UQ5ZkaNR9A1QoYmQ8KQsr
	HO7dCKbSajw==
X-Google-Smtp-Source: AGHT+IHWiAPQ6dcAX3OI2ZAYiVWyHhqCivttd+HaZ0em72JPxSkhLuY2mR07AiySdAHahdhGtlSuBQ5RyCXMOA==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:ef:85c8:ac13:4138])
 (user=ipylypiv job=sendgmr) by 2002:a63:501f:0:b0:7e9:ff16:975e with SMTP id
 41be03b00d2f7-7edb373278emr10a12.6.1729728631055; Wed, 23 Oct 2024 17:10:31
 -0700 (PDT)
Date: Thu, 24 Oct 2024 00:10:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Message-ID: <20241024001026.1842458-1-ipylypiv@google.com>
Subject: [PATCH] scsi: pm8001: Increase request sg length to support 4MiB requests
From: Igor Pylypiv <ipylypiv@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

Increasing the per-request size maximum (max_sectors_kb) to 4096 KiB
runs into the per-device DMA scatter gather list limit (max_segments)
for users of the io vector system calls (e.g. readv and writev).

This change increases the max scatter gather list length to 1024 to
enable kernel to send 4MiB (1024 * 4KiB page size) requests.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/scsi/pm8001/pm8001_defs.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_defs.h b/drivers/scsi/pm8001/pm8001_defs.h
index 501b574239e8..f6e6fe3f4cd6 100644
--- a/drivers/scsi/pm8001/pm8001_defs.h
+++ b/drivers/scsi/pm8001/pm8001_defs.h
@@ -92,8 +92,7 @@ enum port_type {
 #define	PM8001_MAX_MSIX_VEC	 64	/* max msi-x int for spcv/ve */
 #define	PM8001_RESERVE_SLOT	 8
 
-#define	CONFIG_SCSI_PM8001_MAX_DMA_SG	528
-#define PM8001_MAX_DMA_SG	CONFIG_SCSI_PM8001_MAX_DMA_SG
+#define PM8001_MAX_DMA_SG	1024
 
 enum memory_region_num {
 	AAP1 = 0x0, /* application acceleration processor */
-- 
2.47.0.105.g07ac214952-goog


