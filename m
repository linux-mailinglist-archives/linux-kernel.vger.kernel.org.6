Return-Path: <linux-kernel+bounces-236956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6A091E90C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A01691C227C1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404DE17085E;
	Mon,  1 Jul 2024 19:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dP0eY8qm"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F2D172BAC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863897; cv=none; b=HxPDWnPMaWQiXFmJS+Xc1mz2hbSKLeEQwfCznLa/TjEGRYWsbez8Ko/TUuYdu4mUAllu3vPI5dY/QSNNvH3p88zhcbwwcAjZ45jxmppAUNlWntJfpiN6Riz0vIZsABrjFBfZGZh9NaAWhU3KKMpkx1vFmXV5zArgEYf7nxnbaxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863897; c=relaxed/simple;
	bh=jp/EJgN5EJlygiYPMBnOCCu6H23x0pk/OIZFHXKB2ls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QOit5LrKA6ohzMQP5sgvTfZdOzAnUqokHtOUywM30VCLmcggVKQVKy+uPX7O6e2oWQBAizOGmQvxz6ldDDFTezOwikVv0jWkhlcuRxw9FxOInb0CiYc17KJ86e81oG7f2DTNo+SpvDEjozVxbdG5/n9Qorc231zFUqpwxm26UGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dP0eY8qm; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c30144b103so2750482a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863895; x=1720468695; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hBcCivyF1P8rhgIjZ2/cBXkYOTDbZ96Cj7XNFUz4SOg=;
        b=dP0eY8qmyX0zBoQqbeaC1XpDKyeKn+jl6foQ8tPnjM9pt7MVvhy7Eak/7KLOPLcOJB
         PBDjS5mECuEcIw0lRzF/GZZwVcJldiQs12dfdBQxyJ3pogHvfvivE9NYwipDGayQaHE7
         P+0u7d7SoLv1yMZmKnn9xUso+8tC8QrD9XPszVji3nYkpQqHBbKtW7Om93+GKDpNyrMn
         PtZhCJMS1nBX7KUoiu2n7bO2KSMt1ywwqw2wOs7oBf0RjzApjAHUN4muS+AYIlwvr3ko
         gmiJdMWHOwd3G3kkH2Gkj6mh0wYb5+9gtT/GfFpkw0zOFNQHkOygGgdtqcaPZcFq2Bk3
         X98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863895; x=1720468695;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hBcCivyF1P8rhgIjZ2/cBXkYOTDbZ96Cj7XNFUz4SOg=;
        b=PR22RuIRlsEn82VvFFWzu2LbAKVkL04LCuT+rz/WAhz/XzFh7lH0k3Wpuk4SThMR7P
         8hutJlGkFogb26cqbM80Dqi4yM4LYSMCtEr3EXaDrCd7Aw3O2PiWu4ZcGdVHJ268pgyK
         LIAP4Slfsc9WS2qG3pbAUNzRKvRUq0zl8yM3R3gRy/7WGt8pJS92IeJUyFpKn5GGDdDy
         W574ZfdcfFAbk0MvYgIMLk+DL1aQzTh2cOvDWme127C1asMkxZfYE00YrlDS1cmXjVge
         EXei+lT01BsvO0yKnmzFjwgqnHez9m+f6XrIQWJCtnvu01pa2AVdYf5Gr0KhLSpltSnu
         iWfg==
X-Forwarded-Encrypted: i=1; AJvYcCVzsKB7er3dPjfGVLUbu4mDkwQB2s9fE0LVCkCG/FUAo3NfeiO2SstaFO8OgQTkAEhaSkQo3TolhUyPLj//pjoqw9o++HSKOzs4eFjl
X-Gm-Message-State: AOJu0YyzDOBEGLxmyQ7objNm5rRbN6HRapBKJ3Ec84qkdVAiAIFpAg57
	qGySuNwxxnhPY+fPw/tAz+sxoRAAuNqXT57BuBqCvBdkTdJ/0L0pdjNZGRVmTjqGl5elJP/4h5y
	RSl5l9Zd2Ag==
X-Google-Smtp-Source: AGHT+IEAmoCDVb1CCwTLs+zWio2dwxCB3f8jcfxMQ9ve8CmB/yMJcLgXLwiLFKAR65sY8QS/BAMdzTKNJ5TLng==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a17:90a:1543:b0:2c7:471d:172b with SMTP
 id 98e67ed59e1d1-2c92804c405mr63658a91.2.1719863894361; Mon, 01 Jul 2024
 12:58:14 -0700 (PDT)
Date: Mon,  1 Jul 2024 19:57:56 +0000
In-Reply-To: <20240701195758.1045917-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701195758.1045917-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701195758.1045917-7-ipylypiv@google.com>
Subject: [PATCH v4 6/8] ata: libata-core: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

ATA_QCFLAG_RTF_FILLED is not specific to ahci and can be used generally
to check if qc->result_tf contains valid data.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
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


