Return-Path: <linux-kernel+bounces-406703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 919D49C6275
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 225F21F227FA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87AA219E57;
	Tue, 12 Nov 2024 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWixwCvn"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEAA219E4A
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442876; cv=none; b=FIw3EHjzBZI6gqx/b1XVJfbhDcJ4E0178hTy2mAgjw0udvFzGf7P4PHixHkdNq5enEl+AEUxpuH9CYTtdIp8eDvVIGNj8uj0KsFZSwnqawTL8198EHuXYnnhx6eAeeFv1nOHiNqian8mG2DOgI2u/wvy239e13kYd4iMjGAOkno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442876; c=relaxed/simple;
	bh=K2w+PlHPlo9o1IZR67+Lm+A6U2fwgx/nWa6HGBhLAmY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a3UHWLOYGC6RkEHxGbBQCAMEmSIjlGCzwo3vcUaqlrPdRDYox8KAAvYlbsWt8ptGTwsSp/0TGrxd/VxRLQ0rANuZbRU+qllGBeHsn6JX4Bp/sq6P4e1TnC+QVweoS0HmKFXnt9biOCmfzDpgnlvPTQ23j1XBmlDPDpePTRmQhaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LWixwCvn; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso4587048b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731442874; x=1732047674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dbiGSlNTgDwTJN5h/RN4sB+oarsdMT2KJU6Z+wI74rg=;
        b=LWixwCvnENQ6zsAHNJmnw8ZcPBsjBSNAq+pI95e1GMziCxNAHaVVj11SI03dgVbs5S
         eaipkgwHu9Gd3IKogWdKJfCdfDwG+w7vOOFtYBYjMrmhtn7e/YQ+OEny+J12eOE8JjNJ
         d6ClJGgxOHrHQqY6Z+jRRfNUZacXHmczvtQm8U4ouGFm86BRCp9wNdYt+3ZZNqQEwqan
         pcnwaUKsqUGbgZJE4EkIDID0SrmRCFBIGK/iYv3ObgXlsiyWsGRqrpskO6UeU9rYpEjr
         8uflZsxRHEqxzBhaB1B/mnDlFGh50mnQkwXS1NaFu9ycUjW3+/9QSFvNXAJxBknbkGPd
         Yvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731442874; x=1732047674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbiGSlNTgDwTJN5h/RN4sB+oarsdMT2KJU6Z+wI74rg=;
        b=q8+r0Lo05Yqa5wHkOwjeb9n+RG3ZUysfMDhj6Fvh2XIg/qDwA0iz7xaViQR0Dp7Ycv
         Rcshn/OMItp6A/HCtvHx+eyyA5wsD9UbnbRIZRL1j8rIzyKegliyvWMQNSSaIBrf+M4R
         YVJnbSUpxA0PaX0vbAkDT1zt1LK1wd/qZQ6r/cEpZwyXIzvLvDiG/1jilcsxQEaHhxiq
         hSGy9efMFyUQcs6kR/5gSjA98JFwhLxnQEDAI3vvZwOo/qNbxxfqSz5s/46VZdAoCJs9
         Dnd/6XXukJTV2rSx7KdPRistTK31clsy8Busxc0pzsOOrjk1iyIV6/a80lKCHQQce6JS
         cVlw==
X-Forwarded-Encrypted: i=1; AJvYcCVl6kkOkXNt9RWIsrCItAl5pQrzNbH7EWBQhZxmqBpGw7VmeOUsHyLndAnx2DHJNEmbo7mIoOndtCTbXyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrJJ4b642GtQ8PDWULTpvsLxM3frtCpt4L1hCmluO0KxAs4PPZ
	jehPelqifanxsnIFf1mncob2QZOgT8ilnp1q6HH+LdbuXTFrhhBY
X-Google-Smtp-Source: AGHT+IF8s8LMQCn97/AHb0IzllQNTPrQ7bwyT2+wh2XqWtjaQWOr6zVDI2pD+uQRuslwgRmTZ3zkmQ==
X-Received: by 2002:a05:6a00:14d3:b0:71d:ee1b:c854 with SMTP id d2e1a72fcca58-724132a134dmr24661188b3a.9.1731442874123;
        Tue, 12 Nov 2024 12:21:14 -0800 (PST)
Received: from purva-IdeaPad-Gaming-3-15IHU6.lan ([2409:40c0:23d:98b3:efff:2469:dece:37c7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a571besm11589098b3a.194.2024.11.12.12.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 12:21:13 -0800 (PST)
From: Suraj Sonawane <surajsonawane0215@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org,
	Suraj Sonawane <surajsonawane0215@gmail.com>
Subject: [PATCH] regulator: aat2870-regulator: replace division condition with direct comparison
Date: Wed, 13 Nov 2024 01:50:41 +0530
Message-Id: <20241112202041.16980-1-surajsonawane0215@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue detected by the Smatch tool:

drivers/regulator/aat2870-regulator.c:142 aat2870_get_regulator() warn:
replace divide condition '(id - 1) / 2' with '(id - 1) >= 2'

The division '(id - 1) / 2' was used to check if the regulator ID
is greater than or equal to 2, which can be confusing and less
readable. Replacing it with '(id - 1) >= 2' makes the code clearer
by directly comparing the regulator ID. This change also removes
reliance on integer division, which could be harder to understand
and may introduce subtle bugs.

Signed-off-by: Suraj Sonawane <surajsonawane0215@gmail.com>
---
 drivers/regulator/aat2870-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/aat2870-regulator.c b/drivers/regulator/aat2870-regulator.c
index 970d86f2b..b48d2987a 100644
--- a/drivers/regulator/aat2870-regulator.c
+++ b/drivers/regulator/aat2870-regulator.c
@@ -139,7 +139,7 @@ static struct aat2870_regulator *aat2870_get_regulator(int id)
 	ri->enable_shift = id - AAT2870_ID_LDOA;
 	ri->enable_mask = 0x1 << ri->enable_shift;
 
-	ri->voltage_addr = (id - AAT2870_ID_LDOA) / 2 ?
+	ri->voltage_addr = (id - AAT2870_ID_LDOA) >= 2 ?
 			   AAT2870_LDO_CD : AAT2870_LDO_AB;
 	ri->voltage_shift = (id - AAT2870_ID_LDOA) % 2 ? 0 : 4;
 	ri->voltage_mask = 0xF << ri->voltage_shift;
-- 
2.34.1


