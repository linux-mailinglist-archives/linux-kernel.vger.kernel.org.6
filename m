Return-Path: <linux-kernel+bounces-228009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5839159AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3B19B245D8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65991A2FA7;
	Mon, 24 Jun 2024 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G7/ciOLH"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23E11A2C0A
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267159; cv=none; b=ROGCadjf/tXJkQ93Y426yvpWN8g61JbVnhsckQZC7mFjt5B68BTMEizbzP8BC91gD4k7tWT0eabi8NX1R1q+TksUtzDeqBV9IvbOIqb8mLG+QVpRrXmVGkkTG4U/q/8xJwKGIPkcuAvv9Mq0sjWko6Ixnqe7M9DOMFQAllTmjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267159; c=relaxed/simple;
	bh=4ci67SVFpkWmJkYCTkpx+ig9XBfHau+20YcfXOFnufI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KpaI6gag/R924WnGaI6elLwuBalXAjZzRRUN6akpexjNn5U6aONFMepB9qmdwB2rZs5wM9kyUw1G01goPfFlat2OaiyF2sUzI6Eyd9M+IngYAZuRkMoUj5JqUhOKFBNLBGrLBEYLO3GbZPjyRhRKF7vgFojhRoTeP6h3EuNLIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G7/ciOLH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f9db3192d8so28497905ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719267157; x=1719871957; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=am7s8zTwG1CQ1DLlONdgBD04NQU7cty5c4MreVuPbFc=;
        b=G7/ciOLH6m9StJN4nPtD4v+pJj9TGy3y8UqUf+YjvAuaE1ucF4ZbF508wSRz08VbtY
         jY3Kic/eXE5cVf1xdwQbXrB9EyZt0eA7r4ATWiQvjdBEpcZg7qkUrgsIzAjyMY3g79l1
         y5NWMYsB0ojXutD65UGhR5fnMThQtMNlyqijtfYecKVVm4n1JHrFnTNMKZa2sqwxYPMq
         vagRnBLNs2X1hle4lWy0ZJ2SYcX516zHJrzeKx8EXNM152soJwF71uyttmJPo14IZ3ft
         acwb2Zv3Lh6IS7H8PEomAIgSMq9U+noTOnL8bzbyel2/yEZEPHW6S73w9OanxDUVXCWx
         RQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267157; x=1719871957;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=am7s8zTwG1CQ1DLlONdgBD04NQU7cty5c4MreVuPbFc=;
        b=B2JCjmaUzyNzwA29dosi/pF4TkCOffjqXHMZCl7+zAKkhPRdiZqo0+1PzmYc2XxHpF
         K7ISWUj6RQPRTos4TUHQP9vqmG66w4R5cXUWwKcstV87G0a2leZRgDEUZvIvXIHIanE3
         Fc3sNctTieqtkKPqwMVMXv9c5/wc6/tT2/YF5n+PPm7a5O31CHo/8X24sA9oGHZDIuMP
         D8npD3ZAr+3Q9kzd52UMhQMyZeZ2Y2DH2WAdUvwLFi1nPuU4JbdywoUu6ztrHEaHJecd
         jTub8q9rIKGmpkwQjkRtm/3b7S4GykbyClv1ihjRxWxhmkozHGp8Er5FywIMlNxzykF1
         FN7g==
X-Forwarded-Encrypted: i=1; AJvYcCX2+8iw19V+wmZE+TIJs8T0Nr/NuQCbT3TPvj6kj0XHOCiS+zco7XHdkTboG8UqRwKofKKrWmCaOwCcxwitf97QU4/2tYrAaXcbIo3f
X-Gm-Message-State: AOJu0YzRgShOwNuQAjNrBg/0pwVa5O+BeRteEfuRrelk57RvZt7no7K5
	t4EarHtbLsUeaAVKBowgC81uzYyIf3iDAY2ax3vRSHUx3d/ErwvHTAVh5nC7vbky741AF8OCB6i
	sCC3bLQMoTg==
X-Google-Smtp-Source: AGHT+IGUdOx20r7NDEUvU1cytoPKAzBTVDx7VmCUnni5NL4Qq9RkQzd3oASNoeizoFcr889fkOjJmC0s/e4Cxw==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a17:902:eccb:b0:1f9:cc3c:9dc with SMTP id
 d9443c01a7336-1fa104968e4mr1692405ad.5.1719267157123; Mon, 24 Jun 2024
 15:12:37 -0700 (PDT)
Date: Mon, 24 Jun 2024 22:12:08 +0000
In-Reply-To: <20240624221211.2593736-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624221211.2593736-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624221211.2593736-5-ipylypiv@google.com>
Subject: [PATCH v2 4/6] ata: libata-scsi: Do not pass ATA device id to ata_to_sense_error()
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

ATA device id is not used in ata_to_sense_error().

Fixes: ff8072d589dc ("ata: libata: remove references to non-existing error_handler()")
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 1aeab6e1c8b3..e5669a296d81 100644
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
 
@@ -935,7 +934,7 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	 */
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
+		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
@@ -977,7 +976,7 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	 */
 	if (qc->err_mask ||
 	    tf->status & (ATA_BUSY | ATA_DF | ATA_ERR | ATA_DRQ)) {
-		ata_to_sense_error(qc->ap->print_id, tf->status, tf->error,
+		ata_to_sense_error(tf->status, tf->error,
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(dev, cmd, sense_key, asc, ascq);
 	} else {
-- 
2.45.2.741.gdbec12cfda-goog


