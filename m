Return-Path: <linux-kernel+bounces-232634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1CC91AC1F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 18:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15CB32839E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301F2199393;
	Thu, 27 Jun 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MOlWlj+v"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B2198841
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719504047; cv=none; b=AQLX+6T3QKN8yG8VF4Wgrr1dj4uiDX0rmlbwK/GZZjorXUUzjMtYWiAjhQ2DqdLRWsPUxORTDcnDIrslTfN6kFbTe9d+ctHi+F3xhbgqwC4dLpY/d5F+TGDwEsDG1tmOvIXF81SU0loORHeoQGVQx8z6X6fzilgxCEJ2Zttv8rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719504047; c=relaxed/simple;
	bh=PjFxXhZBQ3YOoiLUbSULnSeyZ0B4n/ydFPCYsgkc8zo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lUaV/mlXrScxFsX3sPs3Ao+XsmcbTxLmX6afEa4Xo5m8DsFWZK3mo3FVNzOGhVIBLERVNrjUaIroTmy52CCeU4s17I+hXlFbNm3beKFIELQoI+vJQaiotXtcTOqDwB14n/LHI5fySeOiPteU3Jsw86YUkVL16pafg2NgZp7+dtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MOlWlj+v; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-64a5503e253so4324847b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719504045; x=1720108845; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wBmflmuG6b3QD/JJZqnH7ANZPZOxKvJMgQxIVX2Hods=;
        b=MOlWlj+vuZM/yO66VsaRHz2NPjKhDUxYl7A1MQ/udGGBEbI4DE1bpXg+H5snQ9ooHm
         +N+TtrWoA92Mdy3mNU48pQy28K+sF5fndaC+CVN9IygFKdq+HoixuMhH44iX5/+bxfWR
         9usaHmbTJIVawf3Zr/NhEMm0JDyKNSBIHxrmvYf3mtf/R0i0KaeH9MJBTFxA2SdMZMc8
         klvKJ+bsZprVi/uT//X8qOrsQjeCSlH5rqByVEQKJZ3NNUz1DjDII7LbM/k3Blf8IlD1
         nMhSMIJK/lRWJ+hYg6ov8ME0U3afFrlS5qjnGvmnIx+6jGIz+5iA5ZmyTGjo3ELhbrT6
         O33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719504045; x=1720108845;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBmflmuG6b3QD/JJZqnH7ANZPZOxKvJMgQxIVX2Hods=;
        b=udw/2gKUp6Rv0b1+PJo1PooCoqEK2wcBazev5MZ03VqkWCKvxpstN9OU8G/vgFB1c+
         3p8PwJFZe8aeA0U0yelenVz+/jnoXaelfWeHvQa7gcANTIMmTCIDxPl+huawpp8ZEkj7
         +qtWurh8bsx2p+wBGDklrB+Do85tAbMFG0x4J4ezei2gdBHKjKz45rQQtr9aDHhbA2p3
         0E+l6tBEFhQmTP3EiZgit3nhGSUz+Y6PF3wM/ylfUOBwGyTfdMxBri/QRxfBENXxRxR+
         khgz70npGwqfQt/euvrKaIvqwc2UZRVsspkqOb1MraTyCtbpiqJvuqJSg9GuQECOS21g
         MyPA==
X-Forwarded-Encrypted: i=1; AJvYcCX0ThiDLrSSkiPa6pNac1lTr5450PJKFYB0kAJ+x3Kk0IYjFnVvC9YezybhvCVGylqqSGTP4RUB51uzM3J5+Q4Gv3rMEQum4GwDfhhu
X-Gm-Message-State: AOJu0Yy18DPhv/6sL11VgfNOho5HJpEBDpskRh9KaMqf7nYTN/So7pC9
	gOyBioqdNPwLG6F1cBOpULN/Os8SfbvyDknsy7K0rI9hrc24kMPCIxQisDUaLVyfwlx+l9f61m/
	LZVohlpPV7A==
X-Google-Smtp-Source: AGHT+IHDjNCDNw6QyaA7/gjrlgQDqX4gJ2i7YlTKjmmref9WPz1DVGy8xHki9sjtZsutgW1R4w16b0ZCQJGUng==
X-Received: from tadamsjr.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:177c])
 (user=tadamsjr job=sendgmr) by 2002:a05:690c:6208:b0:630:28e3:2568 with SMTP
 id 00721157ae682-643aba464a1mr951317b3.3.1719504045006; Thu, 27 Jun 2024
 09:00:45 -0700 (PDT)
Date: Thu, 27 Jun 2024 15:59:24 +0000
In-Reply-To: <20240627155924.2361370-1-tadamsjr@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240627155924.2361370-1-tadamsjr@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240627155924.2361370-3-tadamsjr@google.com>
Subject: [PATCH v2 2/2] scsi: pm8001: Update log level when reading config table
From: TJ Adams <tadamsjr@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, Terrence Adams <tadamsjr@google.com>, 
	Jack Wang <jinpu.wang@ionos.com>
Content-Type: text/plain; charset="UTF-8"

From: Terrence Adams <tadamsjr@google.com>

Reading the main config table occurs as a part of initialization in
pm80xx_chip_init(). Because of this it makes more sense to have it be a
part of the INIT logging.

Signed-off-by: Terrence Adams <tadamsjr@google.com>
Acked-by: Jack Wang <jinpu.wang@ionos.com>
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
2.45.2.741.gdbec12cfda-goog


