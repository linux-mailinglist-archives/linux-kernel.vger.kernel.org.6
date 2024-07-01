Return-Path: <linux-kernel+bounces-236955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBC191E90A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05911F239ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD42172791;
	Mon,  1 Jul 2024 19:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qpno7nQs"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ACC171675
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863894; cv=none; b=Nz0XontH4lcDE5At6W29xQaKTWbaj8BKCJWjOHUKkInsttLHpQphsMAdJzBq2WSgdjTjGBXufQHh5ki36Jk/f6hK6KV/O9wzCa5KOvR8xp0pyy7slIUUIBUho/j4u3nHYpLcJVQM6P+jpbdWzvAxowBTzbCr8vTBqIZd0CuS0EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863894; c=relaxed/simple;
	bh=7GLjsJebG0QqRDF4wDvrP0SWART+au2lQFNxr/q73XA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DCGB6YiZEuFSTDpY/s1KXx3GHQG/Ae3EO/lNlKRgCIfIiLCXt/UnNYPKT3vXM4nU1xNUOzLjmtcGLEQ2KLBERoql3CW8uIv/Bucqncps8FXd5MdpKagLOf1EOeIxtYVcut65eRSOzt87rr//CAKn/aUGq1hxgmYVOkPz0MVtBPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qpno7nQs; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c30144b103so2750464a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863893; x=1720468693; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VOewcSvCbExIuuMYZcC7TibLRcnuMMvd64eAILBEvyc=;
        b=Qpno7nQsAARmXwMAoIgar9fPByTne+TBh8pEc7aHkd/I87vDI72+0BkNgLt2Y30moX
         hxuMYreIRPaTrR25PT5Lk5mNpWVhHxnM3K6tGVjDIkKIKggk8VfY9yR6A4cUE2JvzhWW
         cOIDl5HLkjF8BHE1indDaVENCM+CHayDyjNOGGKkVsy47PhV/C5J3eWZFM125oAW7Osb
         jxjpdPZEhtIsHtkU9lQ5SWyuS6kPGWxMSkBdh4y8nXkU57VdHpoYWWPc9lU9qheFRB0j
         QZys7ouoho03Gi/PIyxfdrMq6FXjsvnviUV/rTj+e6pciBT09uIpWK32UZjlxwCxOOP2
         XG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863893; x=1720468693;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VOewcSvCbExIuuMYZcC7TibLRcnuMMvd64eAILBEvyc=;
        b=DpDUFORw3SB06Nge3a8hPvlx+NRV/8pmasV6kl4JG27o+cwmraiobr4bbsB3PtnWnv
         exjLh3dvKS98lW0+07yVJCC3w0Vu49Vc6JFQS1xDy1VJNCoS8FsaK2elMikovoEeksQ5
         w26nNuejudwbKNvvFNqu/LXZW+NlUvGoJ5dTm8xbSj4Q/S9uAdmkEisgr47QZf7npGpc
         URRce7cpp5JxHxuQiT4RKQ6n+aptiVXq8GLvcBVaTgL8aLdOrFJe90sTdfJZxLqUOEyt
         9T18WDmEjIWFQQtHKAtsi+OVhdDZQoCu6BXPDXc49p8On2ibvTmDhvx78YSgr38jYdxh
         +yeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWguxNk6nOuxOYlzfQtjSh59XDWoeOGrBkzTnW78EbKIU8E+1ah5409dxrYWbAn/84w8KtIhEfJ6dSEGsgRs82rZPGYiE6F7yj9rNla
X-Gm-Message-State: AOJu0YwcRONHZ+/H9+xWYp46vqjQnGAAkhQ7ANWP7tzVRd3xHUGTVWmt
	aJRmhyHbDPEkXY4RfkknZItwp4QoO0s8Dr/nrs0wie6GiugK5svF9RTNsRwdMXxw9xtlZZFdPVQ
	V3sRFXpIUWg==
X-Google-Smtp-Source: AGHT+IHpFXS1KDK85fnPVcZoeeQnujmrZ567T9Vva1yNGkEdWyBDg0ywNSYuztiQHIu/rbX9opCql6t0Orb7MQ==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a17:90a:ea17:b0:2c8:3c85:3d1f with SMTP
 id 98e67ed59e1d1-2c9271558bcmr63919a91.0.1719863892611; Mon, 01 Jul 2024
 12:58:12 -0700 (PDT)
Date: Mon,  1 Jul 2024 19:57:55 +0000
In-Reply-To: <20240701195758.1045917-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701195758.1045917-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701195758.1045917-6-ipylypiv@google.com>
Subject: [PATCH v4 5/8] ata: libata-scsi: Do not pass ATA device id to ata_to_sense_error()
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

ATA device id is not used in ata_to_sense_error().

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index c11ae77d3ca6..92d75780fc3b 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -785,7 +785,6 @@ static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
 
 /**
  *	ata_to_sense_error - convert ATA error to SCSI error
- *	@id: ATA device number
  *	@drv_stat: value contained in ATA status register
  *	@drv_err: value contained in ATA error register
  *	@sk: the sense key we'll fill out
@@ -799,8 +798,8 @@ static void ata_qc_set_pc_nbytes(struct ata_queued_cmd *qc)
  *	LOCKING:
  *	spin_lock_irqsave(host lock)
  */
-static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
-			       u8 *asc, u8 *ascq)
+static void ata_to_sense_error(u8 drv_stat, u8 drv_err, u8 *sk, u8 *asc,
+			       u8 *ascq)
 {
 	int i;
 
@@ -934,7 +933,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	 */
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
+		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
@@ -973,7 +972,7 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	 */
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
+		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(dev, cmd, sense_key, asc, ascq);
 	} else {
-- 
2.45.2.803.g4e1b14247a-goog


