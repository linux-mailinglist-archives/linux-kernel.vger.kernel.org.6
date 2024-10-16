Return-Path: <linux-kernel+bounces-368852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483979A15A7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 00:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD060B25994
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 22:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4A81D358B;
	Wed, 16 Oct 2024 22:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RtWID5IZ"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD314EC47
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729116629; cv=none; b=j638Jsi87UOLIc5geguaCnR0ipC8lGXlaKITOmEJ9SvTWgFkyrYtRavTkLrS0Fvohpu+kmBID0jyAlT4jbZluY5g65duAJzmNIsZMFh1zKpITiT2A9OSwepMAcUH7Ku1TzuHZLI+gpoJColjjmjGkKk+GA2HxBI+X9ucwvYW63g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729116629; c=relaxed/simple;
	bh=CK4VWdudhelvUqm7tQcSDksX8X/WQLaJJkyq5R5klkc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ta0USdK6xj8PRyU9eQcmSql9dfcbuT5RRofPgLDB3hpbaslxhO4dFGysSb/GgGuE/ewQ6pZxhfYIPArmW1YX79telhzwFEbPycGVFGR4Ls4NBdhImCb8Wph3kdtqxJ/k3qhDCtr/Hnc2aECk17Yo1NRIj7KpgWlipQUBV875LHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RtWID5IZ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--salomondush.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e355f1ff4bso7850747b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729116626; x=1729721426; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lZiu62o/7045anfstaI8NvPpSySBajpQRHA6+l9nLho=;
        b=RtWID5IZ0DlE9TOfCCYB2GkhIn9GQmYf2Rl/qcLA/4amtTOpY0cTpHMqOU1jzHJ19v
         jtoot63ktb5wUKGzmrd2APnNLAkZnfm4n5SmJh8VqY65YlS96S6ByOtDzNT4iHJY+67Z
         CyzfNsJM2qIcrxaKPwb0f3Nbb/JxK/MGuF9uhfZOemTBH5creDmjppZQH5gZ2C3itUF2
         xCCulvoQg6aTU0n/ggY1e2Gp0Ch5TOgYjUCGOKLALorhYh/93chkYJ8o5AGKeG3ow4v9
         AM5widd+bSjlDgAE7xP0KzIB23bcZDkYgvLP9kS/Ul0Eo8cDo5n47H6S5mnzhorECzrZ
         6xdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729116626; x=1729721426;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lZiu62o/7045anfstaI8NvPpSySBajpQRHA6+l9nLho=;
        b=gD59Ln56gB8xm/kBdcXJMXo/CJ4DF2dM7xfGpdbpCR1ouBsTSEO668ZOqaaMKyilXR
         8l4VgwqVxNXR4S5n9KgdPH4z0uf1AqW2+muVGBNMEpNFX6iLVkSpzVj80KZH+9RBhd/W
         8U6PNX6ARL85H9qGFaX/RZfL8X3RTFu2l9wyTdj0ewQgolxfKNneF8x02JDmSt4S5s4+
         7CZi2QoigpcUPLp2tSLsHzXeMJ6YCp+pbJLvkhL4Io8cPA/2HGf2yXuc70s0XHHSvYMB
         aM8JseO2s1swfHqT3rRTItvw/xsIu2GR4D+A5etNt2BUqQeTyGiTRneUCB//r/ZPL3Yg
         64Pg==
X-Forwarded-Encrypted: i=1; AJvYcCX9gD8AQT9Kd4WrHCMabr790usH6dJ+cErPyN4lPd0mesrEhBbOjezC7+MbY/SjKsZcMNJQJ/N0ev5V4ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTOqlF33qZxeRjnCwY4PktVwcqYAT95uLqrNclrNsngfTPVCAV
	fuNoKqzDwavRlSgGd9cZKgOSoSGKEbEUb2UtutrEoBS6bwg55w1vCGhasMojR2bcEjEZlCV5uRb
	/bD7IeEFU0MCMbE8Aqu05kg==
X-Google-Smtp-Source: AGHT+IGg/WZICZ+4ereZN6UT2TjwtFXb6guAfrgRgmN/R8YLtp3gH1JMOCC01mgll8Igly/h9R5xKnWFqdXL9T4K6Q==
X-Received: from salomondush.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:3cf9])
 (user=salomondush job=sendgmr) by 2002:a05:690c:7207:b0:6db:afa4:75d3 with
 SMTP id 00721157ae682-6e3d41df5a9mr1412277b3.3.1729116626059; Wed, 16 Oct
 2024 15:10:26 -0700 (PDT)
Date: Wed, 16 Oct 2024 22:09:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241016220944.370539-1-salomondush@google.com>
Subject: [PATCH] scsi: pm80xx: Use module param to set pcs event log severity
From: Salomon Dushimirimana <salomondush@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Salomon Dushimirimana <salomondush@google.com>, Bhavesh Jashnani <bjashnani@google.com>
Content-Type: text/plain; charset="UTF-8"

The pm8006 driver sets pcs event log threshold very high which causes
most of the FW logs to not be captured. This adds a module parameter to
configure pcs event log severity with 3 (medium severity) as the
default.

Signed-off-by: Bhavesh Jashnani <bjashnani@google.com>
Signed-off-by: Salomon Dushimirimana <salomondush@google.com>
---
 drivers/scsi/pm8001/pm8001_init.c | 4 ++++
 drivers/scsi/pm8001/pm8001_sas.h  | 2 ++
 drivers/scsi/pm8001/pm80xx_hwi.c  | 3 ++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/pm8001/pm8001_init.c b/drivers/scsi/pm8001/pm8001_init.c
index 1e63cb6cd8e3..355aab0c982a 100644
--- a/drivers/scsi/pm8001/pm8001_init.c
+++ b/drivers/scsi/pm8001/pm8001_init.c
@@ -68,6 +68,10 @@ static bool pm8001_read_wwn = true;
 module_param_named(read_wwn, pm8001_read_wwn, bool, 0444);
 MODULE_PARM_DESC(zoned, "Get WWN from the controller. Default: true");
 
+uint pcs_event_log_severity = 0x03;
+module_param(pcs_event_log_severity, int, 0644);
+MODULE_PARM_DESC(pcs_event_log_severity, "PCS event log severity level");
+
 static struct scsi_transport_template *pm8001_stt;
 static int pm8001_init_ccb_tag(struct pm8001_hba_info *);
 
diff --git a/drivers/scsi/pm8001/pm8001_sas.h b/drivers/scsi/pm8001/pm8001_sas.h
index ced6721380a8..42c7b3f7afbf 100644
--- a/drivers/scsi/pm8001/pm8001_sas.h
+++ b/drivers/scsi/pm8001/pm8001_sas.h
@@ -96,6 +96,8 @@ extern struct list_head hba_list;
 extern const struct pm8001_dispatch pm8001_8001_dispatch;
 extern const struct pm8001_dispatch pm8001_80xx_dispatch;
 
+extern uint pcs_event_log_severity;
+
 struct pm8001_hba_info;
 struct pm8001_ccb_info;
 struct pm8001_device;
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 8fe886dc5e47..9b237a764d0b 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -763,7 +763,8 @@ static void init_default_table_values(struct pm8001_hba_info *pm8001_ha)
 		pm8001_ha->memoryMap.region[IOP].phys_addr_lo;
 	pm8001_ha->main_cfg_tbl.pm80xx_tbl.pcs_event_log_size		=
 							PM8001_EVENT_LOG_SIZE;
-	pm8001_ha->main_cfg_tbl.pm80xx_tbl.pcs_event_log_severity	= 0x01;
+	pm8001_ha->main_cfg_tbl.pm80xx_tbl.pcs_event_log_severity	=
+		pcs_event_log_severity;
 	pm8001_ha->main_cfg_tbl.pm80xx_tbl.fatal_err_interrupt		= 0x01;
 
 	/* Enable higher IQs and OQs, 32 to 63, bit 16 */
-- 
2.47.0.rc1.288.g06298d1525-goog


