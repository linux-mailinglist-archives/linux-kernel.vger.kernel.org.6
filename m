Return-Path: <linux-kernel+bounces-231626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF763919AF6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 01:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A3AF281039
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238C91946CB;
	Wed, 26 Jun 2024 23:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3NyliBBX"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669E194157
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 23:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719443071; cv=none; b=rHigrRA/ugiA/qkKLD+oLleAK0muANDNi7dHbOEk8xnql1euEFC4zvC6DcQTB6LyBXgSFUW3O0i6Z+jCcygVn43v9dXN2BrRAWzPzlyCcODwNvcLrH8eaI4yq9Wji6SAGsv5brQvwoDSlC7YS16C8kGUPpltJ1EO+upNDO3VnXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719443071; c=relaxed/simple;
	bh=QOUE3m85wg/4GIuezGsx91HxmkwAowzlGh5n1SnE+jk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k5c+ec0RjiQb/53ZAZCYhNj6VCOhDLeVvndntLNgDbYgGqOsMzWjzKIMwmgfHX/18E/y1PyziSgFvynqmBYwdVuUV1VG2oRTfd0EiiPWwJ2AORKhNLhsCalRkpXSi6rV6YLy4fXh+3+1+Pmmd/2Up0nANEzAyqDSIoWtV1gNevE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3NyliBBX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1f9ec9aae70so62937015ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 16:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719443069; x=1720047869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WRuxhaMQ+1lW78nuyDa9Lm/q++gXoPPs3JwtC5y4GFo=;
        b=3NyliBBXP/fMKNHYsdd9Rjno6iYeRXJ9Q0JR8vH8xzdYYZbQo7ZIN4jVnXAQwNL5N0
         GXiVIpz1DUDINdc1ZHbfDtOQId92SmFdjl2FuR0fYCCm/rDcaFuiRUyjoPNUAlXM2vEP
         JhGTCoPf9gqLqZx4l9fupbIcFRdFn9FnPawUsw7OuTq4VgG2g7iKBnEgBk6QfksEQuYr
         Em132c68o7KwcGsJnYp3fnkh2MfiUKdnIkaGVu0FVwZ3+cj/+BRFSbWTKJVXtq+cXqbA
         bQitxYyTu1NuWXLXnYGpt4JYFkSGlYJOXKaBf2STv1TwhogdMyXt5XDjYjZ3ItjIGiom
         Or8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719443069; x=1720047869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRuxhaMQ+1lW78nuyDa9Lm/q++gXoPPs3JwtC5y4GFo=;
        b=BzWP0f+EB+y/80ETgqf7uQAtPwqcaCuHZFOjpg5Q37nrltuV099GtSQFUjnsk/TKi6
         EI0tunVg8u87C0ThzBtbI0dBNzVWNnelNhPgCqdXQrSNHSXlrYB/FVsDzyuX6XX0IvqB
         GooAUvlU22PApIBtPByN96LnpZ3TKw6rm98rKAFs8WyiI3wqhpxnwdqvNJ+tK+5oUV0x
         sEiTV7BN86yhJgtPuzri3bQp/AisWxY+orRrY7JXVc0U0SJOTblEGVs5It73WBFuw7O9
         QwcfQs0a908S647lf/+jPgX6+pEBni6sS7JcDR3k64OcdFji8+g4GUV6D+nyR60jCiVm
         dVZw==
X-Forwarded-Encrypted: i=1; AJvYcCWNPN2SnZo3blHJyl27nSpLA9etFtrkHICZr6Y1Yk0Ym6x2sFM1vfUuPgXymPhnzYNl7PhhiO29bB7S7T4S7t7XWr/VrFFAR14WeOK5
X-Gm-Message-State: AOJu0YxQWZASSOVp1twa7X7/EcqkBp85ve0IjzvPDn91zhhUcYAdDW16
	cLALEjmRJgtl+JSYROziud7t07edgvb5QeRat4MrSq+MHNnZSSCqUbFXudbrRh/ULr6PjMqM3u4
	u2gstHPexMA==
X-Google-Smtp-Source: AGHT+IEIAPNfqnBOOftySkpy/S1qLhtNZDiXS8lsXqrU0dYyZt2TBCiMdv15J5+VPG4DtZa7SQgsCmuWlH4hFA==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a17:902:c40c:b0:1fa:1be4:1e5c with SMTP
 id d9443c01a7336-1fa1be42246mr10318515ad.3.1719443069215; Wed, 26 Jun 2024
 16:04:29 -0700 (PDT)
Date: Wed, 26 Jun 2024 23:04:08 +0000
In-Reply-To: <20240626230411.3471543-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240626230411.3471543-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240626230411.3471543-4-ipylypiv@google.com>
Subject: [PATCH v3 3/6] ata: libata-scsi: Remove redundant sense_buffer memsets
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

SCSI layer clears sense_buffer in scsi_queue_rq() so there is no need for
libata to clear it again.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 26b1263f5c7c..6b6e35292620 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -926,11 +926,8 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 {
 	struct scsi_cmnd *cmd = qc->scsicmd;
 	struct ata_taskfile *tf = &qc->result_tf;
-	unsigned char *sb = cmd->sense_buffer;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
@@ -968,8 +965,6 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 	u64 block;
 	u8 sense_key, asc, ascq;
 
-	memset(sb, 0, SCSI_SENSE_BUFFERSIZE);
-
 	if (ata_dev_disabled(dev)) {
 		/* Device disabled after error recovery */
 		/* LOGICAL UNIT NOT READY, HARD RESET REQUIRED */
-- 
2.45.2.803.g4e1b14247a-goog


