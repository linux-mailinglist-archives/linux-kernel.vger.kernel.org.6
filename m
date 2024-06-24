Return-Path: <linux-kernel+bounces-228011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 596F19159AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:14:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135082824F7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43C51A38D4;
	Mon, 24 Jun 2024 22:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PCTXrJ4+"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9441A2FD7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267163; cv=none; b=egMV8/ds2bDfzDUIlFmqPbOrnHZsP76KjTqgVE5vQX9Szr4Zu+J67uQJNWIwicYEWCHdGr4oZDyDsM5YSiEH04Awho+nXutTzXgNlhkrvaOHfFxdqiwiKeVDT0EeOwSId8LwUt01TXTeC0JBgFx5AQDYsCNJfDtt2l0aK2UyJKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267163; c=relaxed/simple;
	bh=pfz7uu+jOOwMjwmY/w6sU4kNgauq6UsTyFTXS6nG/Ww=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fvK4LHPKAjhEo5F+5YNCGtMM3QmYX5wFnMx5X+ldCGZDVcuXQCxzvbUppJD5n93VrrxagVM1NlVXsdDXLxEk52pwNHKn9PMGB8RwPul1H1nb5tdlUt1ed59t/74nA6ewRMuVfCmrjPLNPInjAqmtYnAhGubpdFPIubWHpUZip3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PCTXrJ4+; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-63bf44b87d4so55163487b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719267161; x=1719871961; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PD3uQGUFz5zxx7acHrfAbDYiKppPlFoCwrVRy3QI4Ug=;
        b=PCTXrJ4+c3s1wYTJ0jMJH4fTwET79Uc9+6+YyBtiSPJgLwGpHxF+0yhgh+Eah7FLKH
         KOisIfdMC82DaUkW0+v6+VVP50+xLmkmphu8+JZA8FueYtbnFZndRTAj0y26pzY/a59G
         Fy126dxHyAFHRU7DlAOgrY0A8kr/diZFlFDCwzXTbby4FRPHcJQzjtrg0K3hpuyEt/CU
         a9lwZ1APRIkREOw7+/gaEc26/SZghVK6Im+lW8ev0pKACC1mbif6/s04ALG/t+oyZgmP
         ZiWyjVbL9h0XY7rgU0rVs6VdRgtwfscv4gYrHazLDZ/A4Ef/nJEFQVqLj2YuxAvetdRU
         CHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267161; x=1719871961;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PD3uQGUFz5zxx7acHrfAbDYiKppPlFoCwrVRy3QI4Ug=;
        b=w+eQBOJAdJRvZsxjbOX2YLvRK7B1Gn9Z8aZdcNM2kU+xk0EOV5SFViz+mOez+AuPEo
         95LFE0fckZkmzhwiwtN4RPFUTRZgoJcMQXNgftk2BllCPdOUVsScZzfbjFDKGq5S+bW2
         YfGPAfSBCwFSezlzzxh/gB6IrtLB8Ey3vdSFMpMoZd9IEYXoTzKjrnYWOpDO98NBHRIG
         hbKSbZAbee9QwreQ1p1tLvMyAdGgDNM+Y3IqyNe790hsWxi8MhJjAlDGjXr52Mi+YAOA
         x4QM45WA97A8eNL933lZPnjbV2fZU8TV7KkpyDQr+EwY9V53XW+pz7w8utbMF6tuiwNv
         vUpA==
X-Forwarded-Encrypted: i=1; AJvYcCWdrv2zSbK3/Bm9akDzCdHcXBYLdhUFGUanIAVhDZ9qItZej/fYbRTETHDtQ2XoF+23agNfL6WRz2DoEscnnBOmRLUCEJvjCOUw9Z85
X-Gm-Message-State: AOJu0Yzw07OrblCc2w37xsTh4bhq+ClarRmojzCKMEUYvKIB7h4mwIjG
	oemNF1d4zwJm/Nti+3/V3kvZ3emL4NrklQMC6dCmgvSQUqmBd07+4NiOvMCC/Lf1oT6+lQ6mbeu
	qdajpno0XHg==
X-Google-Smtp-Source: AGHT+IG855a4XCLpwisoxKNjnI+nzvVm5c+AAl7kfh4POpZN1c2KNve/pvrtKYJHgwmNI/LedE7U9ADzvsbazw==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a81:9208:0:b0:631:4588:4acc with SMTP id
 00721157ae682-64242491f26mr370887b3.0.1719267160788; Mon, 24 Jun 2024
 15:12:40 -0700 (PDT)
Date: Mon, 24 Jun 2024 22:12:10 +0000
In-Reply-To: <20240624221211.2593736-1-ipylypiv@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240624221211.2593736-1-ipylypiv@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624221211.2593736-7-ipylypiv@google.com>
Subject: [PATCH v2 6/6] ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before
 using result_tf
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

qc->result_tf contents are only valid when the ATA_QCFLAG_RTF_FILLED flag
is set. The ATA_QCFLAG_RTF_FILLED flag should be always set for commands
that failed or for commands that have the ATA_QCFLAG_RESULT_TF flag set.

For ATA errors and ATA PASS-THROUGH commands the ATA_QCFLAG_RTF_FILLED
flag should be always set. Added WARN_ON_ONCE() checks to generate
a warning when ATA_QCFLAG_RTF_FILLED is not set and libata needs to
generate sense data.

Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
---
 drivers/ata/libata-scsi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index e5669a296d81..7a8a08692ce9 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -246,6 +246,9 @@ static void ata_scsi_set_passthru_sense_fields(struct ata_queued_cmd *qc)
 	struct ata_taskfile *tf = &qc->result_tf;
 	unsigned char *sb = cmd->sense_buffer;
 
+	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
+		return;
+
 	if ((sb[0] & 0x7f) >= 0x72) {
 		unsigned char *desc;
 		u8 len;
@@ -928,6 +931,9 @@ static void ata_gen_passthru_sense(struct ata_queued_cmd *qc)
 	unsigned char *sb = cmd->sense_buffer;
 	u8 sense_key, asc, ascq;
 
+	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
+		return;
+
 	/*
 	 * Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
@@ -971,6 +977,10 @@ static void ata_gen_ata_sense(struct ata_queued_cmd *qc)
 		ata_scsi_set_sense(dev, cmd, NOT_READY, 0x04, 0x21);
 		return;
 	}
+
+	if (WARN_ON_ONCE(!(qc->flags & ATA_QCFLAG_RTF_FILLED)))
+		return;
+
 	/* Use ata_to_sense_error() to map status register bits
 	 * onto sense key, asc & ascq.
 	 */
-- 
2.45.2.741.gdbec12cfda-goog


