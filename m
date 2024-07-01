Return-Path: <linux-kernel+bounces-236953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD9F91E906
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D832849B7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 19:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005FC17166D;
	Mon,  1 Jul 2024 19:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k7w3CaWh"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B5A17108C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719863892; cv=none; b=LJKTW3utZZFxjBGa+oYGstU6JF++KrClYyoW3vOe4vC+ULfox40tf39JHVcA8bKkJV+F7hlSUzysVZcOsGQRxtj+A8oD7SZCss9KqR0pAEcLh9Qs3Bx5cWT/+00qLN98APrpmOb1UZ00aA6GluzYD/EKeRYXOR8ukWvfdEBkglw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719863892; c=relaxed/simple;
	bh=i1WM4kmIfmDHPI5dw7j2QdeDu+pN70xb5vkqTT4Klio=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tDaXelH9TKg1Vw81oWPwzMebDMGp89XWPeVhKIoiZy8y8DTCYGUVjVsEu1sfLJX2HGCZESOy7kv9QfDGqjAe1RN/iQ8g6eCQeseRc4A8JPorz3/UW1GEg6s+/CNFtZbvXfYFbJmKyVCwD2Df/dIVzdPb8Loc5Q+iFXnxlkLeKqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k7w3CaWh; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7068613e4d2so2900500b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 12:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719863889; x=1720468689; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MMO2KKUa8/8PW1hug4/vwJix22ScHjcmOPyPA73iWX4=;
        b=k7w3CaWhvv+L8yZDE5/eQgrqkbG/rwjjPeOzvT6xVjTVUwXMqrCfT8wo6zMePw1RGK
         Fou0imwoYIoZgTH0jE2PwkOozeWPuPp5Nf7DDqphbtirONKGA65Qmbe5tfgXVvHjIcuR
         nfmtO+G8cw3z/dZMpRtMnjkJSwDnn7m7HFwMTix6LQ+vjbXj8MNcjYy9yvVyDqj3Hcn4
         GYAbiZOu8fW2dA3eCOWusNlqKyl/a79kBeh9a09KJcEiAAnc1+rOL/fefWgLMIPauyiB
         RX7V4jbcY9VJZwGov+I+k1XQPt7w5LHERBr3mBh/Sv1gnrB/aXOGextKURzu2n+laarX
         WnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719863889; x=1720468689;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MMO2KKUa8/8PW1hug4/vwJix22ScHjcmOPyPA73iWX4=;
        b=qUwTGOGMLLXMeJlDadny+SEyZpY5TTjIc9Qdnn2+gGrh7HLi4oE+s1dFzbh+b+gcuB
         kk4k7UiClAbUXvVnPbNkaXslyKEeJp5eOapi99gELrtc4lgQvNd0FTVho5shlyQxySCV
         mGBk4QP5rtT73TD7oeTxKlYy6FM3nrtMBy83aawryGICPZx5jWWCPUefsZ2RtxkuGiJl
         KSRqqjjKfXe0LMI3P53Y2iHsQG+Pg/mIIbWT7O2g/GZq6d13DQFtPJkl332uXkT9wE2M
         cbENJlbUKy7QX2SZRDJBZPr+iWKC49Xy+g8r9Sylq9mrnCtg/sPmog7pOEqWapF/q37U
         HOBA==
X-Forwarded-Encrypted: i=1; AJvYcCWpeP+MpyXQ3QjJD0/TYbN0BS7GdbQtyEJBd3i+J777/HMoIOnET6KgLLTUVD/F+4boWd6cX6bplNX6vbMtsbI8cSz7NhUUTcQHy1/H
X-Gm-Message-State: AOJu0Yz0CG3XZKkE7IZgWzS8wYMnKRXhT5chL9aHLl8xWpN4Oc2Uttsq
	3IreBg3vd52xTsx27B7Muy1S91Cx8L8x2F7gXvJdhgnH/1ETkLmiDnbQBwA/Cx/ugONba+yCZUc
	oEPzu+pw4ig==
X-Google-Smtp-Source: AGHT+IHReH8MOWTtus6bvZ9IiV9dzMjmSS3I/s0f4LPu18gpADTm0fop6yxvqbOXiivfQbvbcjpBGN3Z6yyMCQ==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6a00:1889:b0:706:2a35:66e3 with SMTP
 id d2e1a72fcca58-70aaaf9d74emr528990b3a.6.1719863889424; Mon, 01 Jul 2024
 12:58:09 -0700 (PDT)
Date: Mon,  1 Jul 2024 19:57:53 +0000
In-Reply-To: <20240701195758.1045917-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240701195758.1045917-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240701195758.1045917-4-ipylypiv@google.com>
Subject: [PATCH v4 3/8] ata: libata-scsi: Honour the D_SENSE bit for CK_COND=1
 and no error
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

SAT-5 revision 8 specification removed the text about the ANSI INCITS
431-2007 compliance which was requiring SCSI/ATA Translation (SAT) to
return descriptor format sense data for the ATA PASS-THROUGH commands
regardless of the setting of the D_SENSE bit.

Let's honour the D_SENSE bit for CK_COND=1 commands that had no error.
Kernel already honours the D_SENSE bit when creating the sense buffer
for commands that had an error.

SAT-5 revision 7
================

12.2.2.8 Fixed format sense data

Table 212 shows the fields returned in the fixed format sense data
(see SPC-5) for ATA PASS-THROUGH commands. SATLs compliant with ANSI
INCITS 431-2007, SCSI/ATA Translation (SAT) return descriptor format
sense data for the ATA PASS-THROUGH commands regardless of the setting
of the D_SENSE bit.

SAT-5 revision 8
================

12.2.2.8 Fixed format sense data

Table 211 shows the fields returned in the fixed format sense data
(see SPC-5) for ATA PASS-THROUGH commands.

Cc: stable@vger.kernel.org # 4.19+
Reported-by: Niklas Cassel <cassel@kernel.org>
Closes: https://lore.kernel.org/linux-ide/Zn1WUhmLglM4iais@ryzen.lan
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 26b1263f5c7c..ace6b009e7ff 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -941,11 +941,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 				   &sense_key, &asc, &ascq);
 		ata_scsi_set_sense(qc->dev, cmd, sense_key, asc, ascq);
 	} else {
-		/*
-		 * ATA PASS-THROUGH INFORMATION AVAILABLE
-		 * Always in descriptor format sense.
-		 */
-		scsi_build_sense(cmd, 1, RECOVERED_ERROR, 0, 0x1D);
+		/* ATA PASS-THROUGH INFORMATION AVAILABLE */
+		ata_scsi_set_sense(qc->dev, cmd, RECOVERED_ERROR, 0, 0x1D);
 	}
 }
 
-- 
2.45.2.803.g4e1b14247a-goog


