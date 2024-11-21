Return-Path: <linux-kernel+bounces-417401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D4A9D5394
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 20:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A4BE283EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 19:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A9C81C879E;
	Thu, 21 Nov 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/Kpp21V"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA481C461C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732218561; cv=none; b=uYC3oCvJGAcHR0EZ1vb8UquZ0mapwBLWHIr4BykTlgfRMwjg8MYOY1QGvvmQVbKqtqH/ftaYkKSVLv2Bo2Va4gyUxDKaxKBC8iwIyGX4MyB8SKSRXrm3wiDDsw4RCnfpTl7V1+XaXnBcNyJwKY37b6ljwpvjlZMTrT26u6vrGnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732218561; c=relaxed/simple;
	bh=/EhwlAowUPBNCPPUkYBxaERl2CCDs7Vetj3wrmlCrDQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qxJUXN/v5t9y4piZtMkHPqkD8S6+S+nfhIMbX90gCk4xdamHDlqtcN/NaY+9rIA6Y6Ox2IbLIUdmPlZwRfv6bnxR0Vhi/WdCoEi5B9rukUANny6XXkrp+a3RiR7Tc0CM4622do+d3GznBL3S5zGWIYEvPr4B9wiQBPQrVg8pbp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/Kpp21V; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tadamsjr.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eae6aba72fso25308927b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 11:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732218559; x=1732823359; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FlTVGm5qa99OPyjgK2sYE6lFf2Ldqoi0UzDo7GJSevQ=;
        b=i/Kpp21VAn51ZqhFYF7Cjncw62474OtRtoADBZybA2vu4KJKFbuHjNPnKRWFVJyJTD
         3oi81O6JEzL6EYC25sGd8tlur6uagkkqq+yGKfbMdg4jV9h1W9/ENHx5zqDc94xN7pAo
         HYQsKjIB5RVBQUjII8LSTWffEmQAhZEvL8dKIQTGQf/XRAGsPx+rRmPJMl/YbxI3PQcx
         1hdP6G7fAyUZvqtgnSdAVjvUvOroXezjkpbpalofx/uB74EIOv0LOhWuUktp1PB89o34
         Q1Ij+O8U3lHzJc2bgo0BmWYK8jdecupw7t26906HnNHh0noFNIKxKEOCA3P4x+lQ9s4B
         e1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732218559; x=1732823359;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FlTVGm5qa99OPyjgK2sYE6lFf2Ldqoi0UzDo7GJSevQ=;
        b=q3Hs6pfwXcpj4ZpAlVs9wUfeflaBlKSz/B+4OlW3TQuCoWLLuEmlc7amYuNztmy9YU
         guV9uQznSzqfqeM3JoKB+UHLN8s7Fcx92iZJFhp4sHevwqX//fJ1NfU0aN8NCyZBiCTl
         cfkevfhCjvcHQOcOvsD5y8of9D0sCbe4AeeypqMiGQxdFLH7ILVv+7Nxqc2B3xwYLNYh
         eWwly5WPK2FylaWbw47/DQGmp94NgXlyUo2LsdJ0hfGS+YQDoy06JrPXAoYJB2RXhP0Y
         7lXLY+cdKPqfCzdc0ziyccZ0La+lqBi1RxqSLu6pVjcN5AzvLvQr1qpicmu4ecyqF0XZ
         twQA==
X-Forwarded-Encrypted: i=1; AJvYcCWDoQ/N0l9Ji4M5Mh6TJCgTV/Ir/oFdZkhmRszmVF1CcSXdsMCMtCTHLc0oRD+dw1XD0+gqUujFEkXDMZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8XUy7gcPsOYbXiAeMFzc4i3iL2JTTr+vZZDCi8wxtoVGGmuMq
	JEPO3U5n3NfXfAwPZo18MY4yiRg7shW0Im86u2NQs/99zp0QFp512ECIgHk3tn5XirvZWhQqpLU
	LFQT8E9iqjQ==
X-Google-Smtp-Source: AGHT+IGJd7/uvd/MveJMgVETHnva4G0+/AAqBaP8ft/tMr6ZWbYv/L2EZ60cfLxbRKbHYVPTXuL+MmRYVE48xQ==
X-Received: from tadamsjr.c.googlers.com ([fda3:e722:ac3:cc00:13f:f798:ac1c:499f])
 (user=tadamsjr job=sendgmr) by 2002:a05:690c:288d:b0:62c:ea0b:a447 with SMTP
 id 00721157ae682-6eee08a96cemr2517b3.2.1732218559215; Thu, 21 Nov 2024
 11:49:19 -0800 (PST)
Date: Thu, 21 Nov 2024 11:49:15 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241121194915.3039073-1-tadamsjr@google.com>
Subject: [PATCH] scsi: pm80xx: Do not use libsas port id
From: TJ Adams <tadamsjr@google.com>
To: Jack Wang <jinpu.wang@cloud.ionos.com>, 
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>, 
	"Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>, Terrence Adams <tadamsjr@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Igor Pylypiv <ipylypiv@google.com>

libsas port ids can differ from the controller's port ids.
Using libsas port id to index pm8001_ha->port array is a bug.

Remove sas_find_local_port_id(). We can use pm8001_ha->phy[phy_id].port
to get the port id.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
Signed-off-by: Terrence Adams <tadamsjr@google.com>
---
 drivers/scsi/pm8001/pm8001_sas.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
index ee2da8e49d4c..061b57b1cc7a 100644
--- a/drivers/scsi/pm8001/pm8001_sas.c
+++ b/drivers/scsi/pm8001/pm8001_sas.c
@@ -374,23 +374,6 @@ static int pm8001_task_prep_ssp(struct pm8001_hba_info *pm8001_ha,
 	return PM8001_CHIP_DISP->ssp_io_req(pm8001_ha, ccb);
 }
 
- /* Find the local port id that's attached to this device */
-static int sas_find_local_port_id(struct domain_device *dev)
-{
-	struct domain_device *pdev = dev->parent;
-
-	/* Directly attached device */
-	if (!pdev)
-		return dev->port->id;
-	while (pdev) {
-		struct domain_device *pdev_p = pdev->parent;
-		if (!pdev_p)
-			return pdev->port->id;
-		pdev = pdev->parent;
-	}
-	return 0;
-}
-
 #define DEV_IS_GONE(pm8001_dev)	\
 	((!pm8001_dev || (pm8001_dev->dev_type == SAS_PHY_UNUSED)))
 
@@ -463,10 +446,10 @@ int pm8001_queue_command(struct sas_task *task, gfp_t gfp_flags)
 	spin_lock_irqsave(&pm8001_ha->lock, flags);
 
 	pm8001_dev = dev->lldd_dev;
-	port = &pm8001_ha->port[sas_find_local_port_id(dev)];
+	port = pm8001_ha->phy[pm8001_dev->attached_phy].port;
 
 	if (!internal_abort &&
-	    (DEV_IS_GONE(pm8001_dev) || !port->port_attached)) {
+	    (DEV_IS_GONE(pm8001_dev) || !port || !port->port_attached)) {
 		ts->resp = SAS_TASK_UNDELIVERED;
 		ts->stat = SAS_PHY_DOWN;
 		if (sas_protocol_ata(task_proto)) {
-- 
2.47.0.371.ga323438b13-goog


