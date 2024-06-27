Return-Path: <linux-kernel+bounces-231628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA39919AFA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ED7C1C21446
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B2E194A76;
	Wed, 26 Jun 2024 23:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fd5cMyQh"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB645194A44
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443075; cv=none; b=qQ50txH5UVragRtG0WHBdRIGQOTmMIl2390V3WtiX6SfTq4J9FQnpo2H0rdaB92t26y1h9kgrk67mpMeGL1IbapbRML3a4eVQewIlQdrTNdsonVtU9YBZTJ/I88yCCFJ/nr1WDSQqgUf8KYHCIRPdJePCCfmn3fCsyCX3fbjfFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443075; c=relaxed/simple;
	bh=bVYP/yh9H60FMAxPtcm0Q5OLzE/o5Ocz16UtfVNPa4U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eNL4PcD8McWUNCaCO7QZZvNUXKRFT63yz0se1tInvkdg6zGogfUzhY2+IjLk6Il0pkIRhWEQUObwki35fM1QIGkC4bB5jkJiYDFjmT9WaCHU/gTv0WYJF1iaaaJynghyOgYXm9bWKxZYpzO4Hw0PbhNjaPzuFnYg4uZXTjcttFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fd5cMyQh; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e033554101bso2317820276.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719443073; x=1720047873; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TktkKoidPCE335Y52c+z5B8f/TUhLrrbeBqorbEFGO4=;
        b=fd5cMyQhfvZ/Uhp1HdtqM3KHl4H0XLxRdEvI+VSfv2VxmKyynKF59gkJQwnFgiLw+a
         McS2IqGXQp2A3iXZ2wTnACOZf5mkWxBvRAwbm8gP7kYXlE4r6o84miIYRwinvJ41gxte
         gVqyESHOb4ZUKO+IUvPpFF+dm5F0yrGr7plV5ySl/NAR/joGzJCaFBDtn0tGjtvu4/R8
         a/LYn0lXdDHHHsonRBNkCcL0vQvSlN4hqqxD9eOYw4poSsKzWdHmGJfZJcu3azPBiIgf
         EUZ9At8dO5K8jogKYvUbbTAgjbxVEABiKv5Conl5jJfY9+1vSJFuc4rE7/Pgf/JhJCnZ
         j3xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719443073; x=1720047873;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TktkKoidPCE335Y52c+z5B8f/TUhLrrbeBqorbEFGO4=;
        b=WhmhJKLA7HMy9m6X7BCmIsWk1uLtvjbCVFps8xd73WF2h2DQxpxz1m2zaH0pFG2BGh
         vhZcGvKy46yP4v0GN41tC51FZHqioB0c3H1TAadgMR7TcAStVGwHw/FgsVZI7rLBnMhX
         lenDFXM7qFQMET+cRMifrKnOf/Q9YHP9UWFnmupUHrgO8/AKly5kCIJ/SZOOaxtKtGve
         BTrt3foyog5b1KrK980LovL9cr95gkJYVW2u++/wTSjknTP4NNmzvby2TUfXceToxlRR
         TEljBMP5PQ6fsvDTl9JoWINpK/rXYzq1aeZqSBn/ehtIW+GU45MffPCXOAwDyug4Bs0g
         oqyw==
X-Forwarded-Encrypted: i=1; AJvYcCX3LxohiUHM6qeQAOb6/rH9lXvKHgynEYPn0BLkSETibuaxrqFtV9MkCVx7osP6M//0+fFLR4UbIIIlgRE9xQkKqxGGO6kdFtjCFwNH
X-Gm-Message-State: AOJu0Yw0vMo0ee9BUneJWtbN+rLuG+GayyAVwyLSTuDwjY3WnCYrlFRx
	fIuFlEp5q4+F+f7msaCXowjgcLK8IJd4OrUTq+F+xnTL0f8mUC6C7ZcpqyrkD+lj18WduTbQaym
	aZRRwWk2MhQ==
X-Google-Smtp-Source: AGHT+IEb4we7BM5x93dwmclinIUkfoKE9eA0csWjhO9wldRsT+EUgld1jSbloaZMyQXtxOZFolUe7L1HRqV/XA==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1109:b0:e03:3683:e67f with SMTP
 id 3f1490d57ef6-e033683e751mr4888276.5.1719443072715; Wed, 26 Jun 2024
 16:04:32 -0700 (PDT)
Date: Wed, 26 Jun 2024 23:04:10 +0000
In-Reply-To: <20240626230411.3471543-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626230411.3471543-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240626230411.3471543-6-ipylypiv@google.com>
Subject: [PATCH v3 5/6] ata: libata: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()
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
 drivers/ata/libahci.c     | 10 ----------
 drivers/ata/libata-core.c |  8 ++++++++
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 83431aae74d8..0728d445e531 100644
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
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index e1bf8a19b3c8..a9fc3ec9300f 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -4801,8 +4801,16 @@ static void fill_result_tf(struct ata_queued_cmd *qc)
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


