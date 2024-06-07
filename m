Return-Path: <linux-kernel+bounces-206578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA05B900BA1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97051C21F70
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF42E19D075;
	Fri,  7 Jun 2024 17:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zaZOeBjV"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67C019CD13
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717783075; cv=none; b=bPNFWfIiijzCtRa8DKa0uxYgstpdn6v/bIX2/gcj6rzojRmla9ivX+nHCQsKp9c4HZGNCouow3uVslAs1VD7SW7jVtZq5ZylXeTJm4aAfrhT9ZUO3uY3IEzHVGBAVLtDdrZ+GKlggOs/QfnWLPw2TCZLUx7nkfE9SZFozVdmxHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717783075; c=relaxed/simple;
	bh=iAbPGXH/r5gL1hZgWkLgKCD1/WIGTyanOjQWhd5s0L4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TfE5M3MfGkzNAsvYJPSDbOzZSfnJ8b4X2boQRnUYwf1qxIgKVlxBcQXQRIwdFwpyJNu22FO0pHumPxQ129EKZHDm41UGx6adkm9KUUXEY/eqOojAmPjNIleY0sumqUVI/vw+SzcVGoEE4jONybFlZrj2M9cgp8LNv6VtK1Dolvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zaZOeBjV; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-62a083e617aso41160507b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 10:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717783073; x=1718387873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+1aQwu1iGrHhm3SengJCu2MFtSP+MYd6cSL40GeM53Y=;
        b=zaZOeBjV3FRTaOZGcExh1nORxNM9GASo6bSRwgEKeHlidel0IQxAfdhQmWJdsgFYce
         Q9kAPcM39ZhUhkan92MMVGqpuyBKIVlxKwFgOEHi2N37YBzmIMYUawdlbvI+zRFrSQ5W
         QBSraZN1ybITmMYV5QpiizboXcgpCbbYqNS2L1gUDBANQDzhmzoeTwj/4vIOce4llrUP
         w9wbwnc0GXULBzA1dFEtqaOwbOR7RkiKvreAcFnP+pofQN7Z+bxEYAaivuh3R0XLCvho
         fpKKbe4y6Xk8PeDk8+CzwEyeMR9XNOrlfyvaS3Hzg/O7zZxvDzbSx9KyiLLnjTlXJ+wH
         wlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717783073; x=1718387873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+1aQwu1iGrHhm3SengJCu2MFtSP+MYd6cSL40GeM53Y=;
        b=Jomuuz0LucQ/VyE6ntYDT0rEjVpdA3ziCPbVCgckntm56v01HcXDzkxYI92iWaEKVL
         97evNDRL5PvLllGrZC6kWY10+FNVe3Pcv33Oz65maJf5c+NOVOYDIb9yJY02yBArjpMA
         OiXQlc10bjcHN/DxAgDxBRnvomgqUczkP7fyUL9Qp/Yz+gbx5dLqUgnMQDUDJiBChKI3
         xaLuGw8XyAlQM4fMHECV5NsyeAe3vFqNCCEDfYGPzKgIvlMsqH7TW3gdnlcgWQkTSx76
         mPMIbUJibqKlGI125HLqfxrVSgYadjX1DH1ifEsh6Tus8ykGDtJ4EVofriGAIrOg3hBy
         H9fw==
X-Forwarded-Encrypted: i=1; AJvYcCV97uBco4tWRZUCH26rdEbYwft9Aix1d0lOfWIDWO9XmM3ZPX8L7k0B7Pp9+tD+CHX5X8wEm+5+8emjBwTdUszj3+vZkmo9WMSxyo11
X-Gm-Message-State: AOJu0YxS+OwguQQMet8JYjY45Nng2/hA17BMdiKFaJGVKy3vaYRcuL/1
	/aUEbpkuAfURHg/Q2WIJ1FNvf2pEOu90DGJ8joLzu6LAU9RNB6rO75E2neknznnMYoULVyUfV58
	t9DkQ6T5ADw==
X-Google-Smtp-Source: AGHT+IHp7YoVWlbDnzAYutrdvwxNbknx4DiQAHnpB/HfNYrXL6Srw00AbWWvHVrb7rZt95ERJDHNm49UM8p4ZQ==
X-Received: from tadamsjr.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:177c])
 (user=tadamsjr job=sendgmr) by 2002:a05:6902:1245:b0:dcb:e982:4e40 with SMTP
 id 3f1490d57ef6-dfaf66c5d0fmr801100276.12.1717783072744; Fri, 07 Jun 2024
 10:57:52 -0700 (PDT)
Date: Fri,  7 Jun 2024 17:57:43 +0000
In-Reply-To: <20240607175743.3986625-1-tadamsjr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240607175743.3986625-1-tadamsjr@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240607175743.3986625-4-tadamsjr@google.com>
Subject: [PATCH 3/3] scsi: pm8001: Update log level when reading config table
From: TJ Adams <tadamsjr@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, Terrence Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Terrence Adams <tadamsjr@google.com>

Reading the main config table occurs as a part of initialization in
pm80xx_chip_init(). Because of this it makes more sense to have it be a
part of the INIT logging.

Signed-off-by: Terrence Adams <tadamsjr@google.com>
---
 drivers/scsi/pm8001/pm80xx_hwi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index a52ae6841939..8fe886dc5e47 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -568,13 +568,13 @@ static void read_main_config_table(struct pm8001_hba_info *pm8001_ha)
 	pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version =
 		pm8001_mr32(address, MAIN_MPI_INACTIVE_FW_VERSION);
 
-	pm8001_dbg(pm8001_ha, DEV,
+	pm8001_dbg(pm8001_ha, INIT,
 		   "Main cfg table: sign:%x interface rev:%x fw_rev:%x\n",
 		   pm8001_ha->main_cfg_tbl.pm80xx_tbl.signature,
 		   pm8001_ha->main_cfg_tbl.pm80xx_tbl.interface_rev,
 		   pm8001_ha->main_cfg_tbl.pm80xx_tbl.firmware_rev);
 
-	pm8001_dbg(pm8001_ha, DEV,
+	pm8001_dbg(pm8001_ha, INIT,
 		   "table offset: gst:%x iq:%x oq:%x int vec:%x phy attr:%x\n",
 		   pm8001_ha->main_cfg_tbl.pm80xx_tbl.gst_offset,
 		   pm8001_ha->main_cfg_tbl.pm80xx_tbl.inbound_queue_offset,
@@ -582,7 +582,7 @@ static void read_main_config_table(struct pm8001_hba_info *pm8001_ha)
 		   pm8001_ha->main_cfg_tbl.pm80xx_tbl.int_vec_table_offset,
 		   pm8001_ha->main_cfg_tbl.pm80xx_tbl.phy_attr_table_offset);
 
-	pm8001_dbg(pm8001_ha, DEV,
+	pm8001_dbg(pm8001_ha, INIT,
 		   "Main cfg table; ila rev:%x Inactive fw rev:%x\n",
 		   pm8001_ha->main_cfg_tbl.pm80xx_tbl.ila_version,
 		   pm8001_ha->main_cfg_tbl.pm80xx_tbl.inc_fw_version);
-- 
2.45.2.505.gda0bf45e8d-goog


