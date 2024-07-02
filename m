Return-Path: <linux-kernel+bounces-237179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AEF91ED1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748861F21450
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 02:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403D947F7F;
	Tue,  2 Jul 2024 02:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bRg7OFZm"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFF85A4E9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888473; cv=none; b=Z2T+yNmZgWy6h9Yz4zmOHXV5YAnq2ZQKnld0D3F+TevLYDkkP8zGI0T0oCZ76ePGc+B4Ml7Wif+fWeXiz1ISzHDKUDPOOXLIKMoKdZXVoldDYSbXMUh+vnR92veuAkBDG9NG+3Mt3d+iVRDo9wtCCbfg4YghG1y23FO927CjpcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888473; c=relaxed/simple;
	bh=armYVp6bALgwlq3EStO19rEjX4MhF4wYcg/Vy9Y+1tk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HIzj264QzHCrSDIVI1jdbt7NkhD0rvcJoO1DajQroOFlUDVMPLUxuRDOr1JeYCmcMagbnjpd2hHCrYbQndciNl7DEfo4Q8iA56xTbfuVWfj5/oqNKWlJbQTnTJvlYRxNfUJ8YSdeZKeRCqTi3RljJDcml+R9xni5BHpMUrtGxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bRg7OFZm; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-70667ccb623so2867377b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 19:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719888470; x=1720493270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuQ8E2r4ig1tVpjaudUDpj4znPX45jR9JD1FPJMHy0c=;
        b=bRg7OFZmffSqCswrGWe0AU1LRYEKjnQQGM9hIYF+L6zlczUS1b8QTENjMbyySA2mzu
         /+OGySHjhOFbPNmR1DHFxH+WPaN2zxWarwS7PjTuxKhHiyVTRFvkjOQYR4o9tOzH3/fG
         tC0oi146ZOL4YvR9XUJmmgUtRUMY2Ciq7TaSHH8yzH3GYCPHgZts99E7DJVOCj9fQT1f
         KZ8ZMRrGNXoUzv5CoK598TL0e/EVmHfp3tWxtg/TGl1gd4LjVnm80QNgg9152yV+3bb5
         HnjrhfFUEHJHgNUx1P9/Tm6vkmHHMdOYPuNciztMKlFwRwKkZ/GvY+gqqcZ5OM1KmguQ
         1UqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719888470; x=1720493270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FuQ8E2r4ig1tVpjaudUDpj4znPX45jR9JD1FPJMHy0c=;
        b=nHdabZwWC5d48EXAJTca4S1igqjKSdiBvGKYGkvpz8SamvElwTcextSP/QCLP1xDNh
         EdsF/MNL+3xTL/9ysFs5UWyRhRea+2WOQtDs2zP+GxW6gTJNoKzv++LfOwUNhf3rhk/n
         mV9xUfvIpiGJnLMuj4jQ8jWS/c7dCZeGC45ha/MC4l6MJIGabjArhnAV9+5wenyk5Rez
         BV9EPxUywBr2vvUuBh0icGTGiSKeuRcqR74zimzrYE0Np1ugrynspkg1nbKPjaPInCtx
         nmDJsIHM/Tcc/B2Iw9Hfczqv5lJ4YZHt4WHGXMyyWr2JBxCnXiN6vrEI+HJiJdTzI53/
         oOmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr1mpyjhbJ/KXJrT53K/W5mj/XzXFMct+DkugIjL1VIep1hAdms+fn+mJ0uWzmqBXF4/FbzriXO7E2I5tjNPDYa0/IhrcK+xZ1dhoF
X-Gm-Message-State: AOJu0YzN6nO8hBUHSiqlK9CpiwmVtapGu3sz0yK9ILO6FbS0grw76UCz
	IJLEYSrfIhyCXADdV142E6+oQv2Fzdp67HldgeFHTwwi+eQJHBdgQDUYcAHC3JX5QttNJA1EVwj
	TvJX2/kxT0g==
X-Google-Smtp-Source: AGHT+IH+lL6r5VzGA0HxS1DdbBK4xw6ZsH2Sc+qAySIDyF6GkpVg26LKJoL3DppsDXBiRCJiVxykE5vl471l4w==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6a00:1255:b0:706:6b52:43a7 with SMTP
 id d2e1a72fcca58-70aaaf0e3c0mr296701b3a.3.1719888470043; Mon, 01 Jul 2024
 19:47:50 -0700 (PDT)
Date: Tue,  2 Jul 2024 02:47:34 +0000
In-Reply-To: <20240702024735.1152293-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240702024735.1152293-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702024735.1152293-7-ipylypiv@google.com>
Subject: [PATCH v5 6/7] ata: libata-core: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

ATA_QCFLAG_RTF_FILLED is not specific to ahci and can be used generally
to check if qc->result_tf contains valid data.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libahci.c     | 12 ++----------
 drivers/ata/libata-core.c |  8 ++++++++
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 83431aae74d8..fdfa7b266218 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2075,13 +2075,6 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
 	struct ahci_port_priv *pp = qc->ap->private_data;
 	u8 *rx_fis = pp->rx_fis;
 
-	/*
-	 * rtf may already be filled (e.g. for successful NCQ commands).
-	 * If that is the case, we have nothing to do.
-	 */
-	if (qc->flags & ATA_QCFLAG_RTF_FILLED)
-		return;
-
 	if (pp->fbs_enabled)
 		rx_fis += qc->dev->link->pmp * AHCI_RX_FIS_SZ;
 
@@ -2095,7 +2088,6 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
 	    !(qc->flags & ATA_QCFLAG_EH)) {
 		ata_tf_from_fis(rx_fis + RX_FIS_PIO_SETUP, &qc->result_tf);
 		qc->result_tf.status = (rx_fis + RX_FIS_PIO_SETUP)[15];
-		qc->flags |= ATA_QCFLAG_RTF_FILLED;
 		return;
 	}
 
@@ -2118,12 +2110,10 @@ static void ahci_qc_fill_rtf(struct ata_queued_cmd *qc)
 		 */
 		qc->result_tf.status = fis[2];
 		qc->result_tf.error = fis[3];
-		qc->flags |= ATA_QCFLAG_RTF_FILLED;
 		return;
 	}
 
 	ata_tf_from_fis(rx_fis + RX_FIS_D2H_REG, &qc->result_tf);
-	qc->flags |= ATA_QCFLAG_RTF_FILLED;
 }
 
 static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
@@ -2158,6 +2148,7 @@ static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
 			if (qc && ata_is_ncq(qc->tf.protocol)) {
 				qc->result_tf.status = status;
 				qc->result_tf.error = error;
+				qc->result_tf.flags = qc->tf.flags;
 				qc->flags |= ATA_QCFLAG_RTF_FILLED;
 			}
 			done_mask &= ~(1ULL << tag);
@@ -2182,6 +2173,7 @@ static void ahci_qc_ncq_fill_rtf(struct ata_port *ap, u64 done_mask)
 			fis += RX_FIS_SDB;
 			qc->result_tf.status = fis[2];
 			qc->result_tf.error = fis[3];
+			qc->result_tf.flags = qc->tf.flags;
 			qc->flags |= ATA_QCFLAG_RTF_FILLED;
 		}
 		done_mask &= ~(1ULL << tag);
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 74b59b78d278..949662bc50e4 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4800,8 +4800,16 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
 {
 	struct ata_port *ap = qc->ap;
 
+	/*
+	 * rtf may already be filled (e.g. for successful NCQ commands).
+	 * If that is the case, we have nothing to do.
+	 */
+	if (qc->flags & ATA_QCFLAG_RTF_FILLED)
+		return;
+
 	qc->result_tf.flags = qc->tf.flags;
 	ap->ops->qc_fill_rtf(qc);
+	qc->flags |= ATA_QCFLAG_RTF_FILLED;
 }
 
 static void ata_verify_xfer(struct ata_queued_cmd *qc)
-- 
2.45.2.803.g4e1b14247a-goog


