Return-Path: <linux-kernel+bounces-512125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382AFA33467
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8681188A745
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4177E765;
	Thu, 13 Feb 2025 01:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="UNT2SuzR"
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614066FC3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409002; cv=none; b=u/q6isR5BB/jMp1Xi6t1cqv+oOtblIkByBvx6r9/dSs31/CRyqP5ergze9XkQEJ9EkI/DHUsoqgVVsYmZBOwYYto7WNdn53mQ6RdFMiDmBz3aWZTOM4C7mSASCFnrqHMYp/Ev0DHv2wfNZB2g/Ub2G4m8qITMr0iHyq85VuzGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409002; c=relaxed/simple;
	bh=fFvS8r+2jMRzhVVCVOscjrDYzDfYpe9YoD9l/vnYUKk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U88bOkVAbQx324em3yl6XALaufG87MsRjuHm+1dQqqyuv1V06AZNHAzIFbBkQJE4/AedW5AiBnDOeMV0airqBj6rasPWYXdKhmjupaDT+Bvtsowjm9F0/BU05c96c0NCKG3vBnyLIKstKrbq3bBQms9oLovRdlxJCYgBE9/GjDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=UNT2SuzR; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-21f8f3bd828so606945ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1739408999; x=1740013799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6lEHVr3W6APInv1drXj4r8z2ZhlFNN3qSpXoQZdDfIc=;
        b=UNT2SuzRBu8+0cIGjbn8lAK/jQgu+Wu+RUwnefbkQ+Shy7X/KgWz2AehRM7P+MCfbe
         F+LIxc5hWIboANVdUkncO3EVxR1Cn42TsBY2ftKTBgXkF7mXfdkCfUwidv7jZZBMIe97
         lR7TOgHxL0F0Cj6/Am39yQomMGargEioK2dGeAGTOxgIQfyhU+7N50UQxppRe2e4Q9ST
         idujTf7eP1TTENm8RhDZDr8O0fWV1S68VplJudzJzmgPeWtCRnXDzXs2J7vRBh9/17s8
         d/vCulJIPE0xEJKDgV2eEh4yOooZ2gJnV06P96q9j/zCaaUs+8DwepUVsricRBuFALI7
         p44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739408999; x=1740013799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6lEHVr3W6APInv1drXj4r8z2ZhlFNN3qSpXoQZdDfIc=;
        b=qO8P0Y9zv/t1oWGkptoJ3jwAlnC4SLwwBi3jvuW0OrQktrKkZpGAhpC2GQGxzVM5Vn
         goGO6cXzMVt89M3OxN/bj1tMlAOIwh2SnflVcsdOEjDGlgupU/zl8wi6oElFiemNcsJ+
         cZGNkDOrgtCczv1bYY9AMviCubLSZF3fqXV81xL0ly7MJwvkRNkYlrMgOPfFPkqxY0Jf
         Dt/zLPJOXxseA2Uhebelp346bDQBBzP32Y4G3Iq/lEvCaQXy0BtRb87sZvXmaYDfhpiO
         rwrTsLOzw6GCdW1NvWydR/bbuoZeSoS+UoLQzBWY9ALjKWl0UyW3qNGuTEYz378Fzw72
         AAhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIsXUBTMVLTPDkMBn4t+ZxVDBV2QUnHIPf1ha7hXV/2+j1PM4wTAHAVhAyF4z19y6mhNf/0zTM3U50JD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+W5JsOboaas71TmHPkoaQJ5mtoEdYDc7Lz3pacR0CpYNrDVW
	dFWZcsCCxx8ehGgiz2UayUvgC+LPJMriZjD+xyHf5/i1ZeF2JhBnHc0pmmukkJDrf4yC882STKR
	SqSczgmANAedQaGimKo+gz29vUT8ysQx1h4IbGRbsypFDOCzo
X-Gm-Gg: ASbGncuJPfD+fM6AQNSR+/JDLt7KipR7TMPtJ71icvvKyqXHZV2wUBiVfFFol4gcrMK
	3i37rPrbQV03Z9nWImerBvv+eA/LRu9jL/M9TgOMxuqJKRoiaJDQpkReIPq4xrwr7y/R7CeJrZW
	V4wr3jac86HGxusYVWs4Lt/r5D+bse8a18zxCKcMR1shUCyzfpN+YCaiSnvCYrNEKbcncuSWPHK
	GasVMBBxKaSmS/c1g+UObrIhHh7+av1AW3c1riL9c/7ybBRws84BpojknG9iCfWcBEIFaTLZl5D
	W8vafIC5xL7tM82qbyDvLwk=
X-Google-Smtp-Source: AGHT+IGga4iLa/voNvhVVA3XMQq1F6Dvcpfeu03mzatdk47G4UcQP1RYPghKpXW8H/XZ9t2Pyd/qCCgRHM19
X-Received: by 2002:a17:903:234a:b0:21f:b7f5:ee58 with SMTP id d9443c01a7336-220bbf33c58mr31451305ad.4.1739408999533;
        Wed, 12 Feb 2025 17:09:59 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-220d5429559sm159495ad.112.2025.02.12.17.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 17:09:59 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id CDF103400F6;
	Wed, 12 Feb 2025 18:09:58 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C2AF6E416E5; Wed, 12 Feb 2025 18:09:28 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme/ioctl: add missing space in err message
Date: Wed, 12 Feb 2025 18:09:16 -0700
Message-ID: <20250213010917.3816029-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nvme_validate_passthru_nsid() logs an err message whose format string is
split over 2 lines. There is a missing space between the two pieces,
resulting in log lines like "... does not match nsid (1)of namespace".
Add the missing space between ")" and "of".

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Fixes: e7d4b5493a2d ("nvme: factor out a nvme_validate_passthru_nsid helper")
---
 drivers/nvme/host/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index e8930146847a..406c1592dd7c 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -281,11 +281,11 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 static bool nvme_validate_passthru_nsid(struct nvme_ctrl *ctrl,
 					struct nvme_ns *ns, __u32 nsid)
 {
 	if (ns && nsid != ns->head->ns_id) {
 		dev_err(ctrl->device,
-			"%s: nsid (%u) in cmd does not match nsid (%u)"
+			"%s: nsid (%u) in cmd does not match nsid (%u) "
 			"of namespace\n",
 			current->comm, nsid, ns->head->ns_id);
 		return false;
 	}
 
-- 
2.45.2


