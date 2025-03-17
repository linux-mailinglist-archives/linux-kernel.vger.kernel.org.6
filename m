Return-Path: <linux-kernel+bounces-564893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 270D1A65C67
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1298617E5C6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05561DE2C3;
	Mon, 17 Mar 2025 18:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y9ZKP/U5"
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840DC1EA7C5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742235674; cv=none; b=TZr3o0LXexRldsCQrZEOF0DSwSKINMyZ5L3gppILTFWz96m9oL3uUg73AUi00QexvH0snVn5X9DO26tEZ52LXxl6ycDNKVqdjN/EyO70Lfnf5vij34oTpL76TcetaYDqmp3dvBWkM21aUV13hPX4qT+BaCN/Drjt2c+CXgbb9bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742235674; c=relaxed/simple;
	bh=fcBQRPadaqvVVbYfXwZ2gUBZXp+GUE0vMdVXkkNoPFU=;
	h=Date:Mime-Version:Message-ID:Subject:From:Cc:Content-Type; b=au22rGSUAn8HcadU+i5H7q5zVRgvHv8aIlSiz67HbS8rUuOZndhezNEEDurvGJGmA+mWlWbF9yKBBeP4Bn7LL0VcFLEWR+Q4xEo/Qz9vIGnXYzw107zc8Yv0XohpLdZCjnyaTk05YxpToVR0mSY6GcyC6sQB8JIIgA7lZzEl36Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y9ZKP/U5; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--czapiga.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-ac316d639c6so313874266b.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742235671; x=1742840471; darn=vger.kernel.org;
        h=cc:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=grGRorWL+jLsuZGg/lyAHTXsZEEu7pq9ykzvRuqzUW8=;
        b=y9ZKP/U5Vj6VnbRbvKFmnHFlvTmNoH4WFC5ksjRhlN2sLEqDRfYTPVVtKrhXZsj29s
         IYwnx2qEhu5xbMUpOBnR4pgVWk7nERis0b2JgznL7su4gaHLjgzFxM7eHEqEAlXzlcsw
         0eGw47mq90KpaBhcjYWVFJOQhywiMaGyCeKHx8RiI7Lu8wHYkziCONzeNPILWtm8BUxG
         u/5c3izQNk6DSjLt8x6qBT8+g049HY8s+Z1gHdVD/MUEE24xOsWsDcCJ9DfsSBN4Zl7G
         hGvh80WMc9BP3HkZOmI2/fPLVhNYmORvyBzbBF76DzhANKzZ7MGAJzJz/27k0ARgiKs6
         CppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742235671; x=1742840471;
        h=cc:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=grGRorWL+jLsuZGg/lyAHTXsZEEu7pq9ykzvRuqzUW8=;
        b=rnFGz00yn5qfmmqe2U16Fy2De2W7gS8pIGjrVZc1ztgrK6DX/NWtb7gpRLgqCuiHLv
         pILCTZhH6WjTq0g4kjT7Kx/UPVhHgEcektCcm/S1DvSXEJbQQL1TN4G4tw6KVtZanqUX
         mc6yQ7wmjtNi/YE7jmmpywJtA7STd8lzF10bm5/1XslmHMVvHgaK8hPNowZmIADfWloE
         lEHrJgdNOwc24Rn+0rCnaB/1G4HymVob0MtQ1lKIUpT/lMmLmOt1fmgqco2ncHuUI6xG
         KZf1DAcFyRZGmJZSks1ns+ioTupXM7/TjmRg9j4o5+149E/k5vVxLqT60OcZuDpLdW7x
         jUiA==
X-Forwarded-Encrypted: i=1; AJvYcCXvKugTcPBkdtS600W5nucit/hKiChi5m5EK9VQlTbpv5neHvIFdYku7VyktpssHf/rj9YcMfiy0SvPkwE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4FGV0UI113NLi4nHZUmBcdohvh0bYwJNvEgy3cOwV2ziO1/V6
	pniMo25DqI2x+gqLNrSQy+FsDAKQB69wJ7RQzu7c6RhTD5gu6dOupWySotiyCkNFC292akb4+a9
	ZE7XJAg==
X-Google-Smtp-Source: AGHT+IFXgf+FFKDS9FUIxfopm7ozpgUszu4+AGJgwJZ8ktIMjZA6fNUm7hPMKi6uBfRaB0VrSOJ8H3jAGuEy
X-Received: from ejw19.prod.google.com ([2002:a17:906:3293:b0:abf:6652:dba1])
 (user=czapiga job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:6a0a:b0:ac2:892f:439
 with SMTP id a640c23a62f3a-ac330444c7dmr1374537366b.37.1742235670887; Mon, 17
 Mar 2025 11:21:10 -0700 (PDT)
Date: Mon, 17 Mar 2025 18:21:06 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250317182107.2060739-1-czapiga@google.com>
Subject: [PATCH] mtd: spi-nor: xmc: add support for XM25QH128C and XM25QH256C
From: Jakub Czapiga <czapiga@google.com>
Cc: Jakub Czapiga <czapiga@google.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, 
	Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, 
	Vignesh Raghavendra <vigneshr@ti.com>, linux-mtd@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Both chips support SFDP (JESD216).
XM25QH128C only supports 3-bit Block-Protection with Top-Bottom
configuration bit.
XM25QH256C supports 4-bit Block-Protection with Top-Bottom configuration
bit on SR(6).

Signed-off-by: Jakub Czapiga <czapiga@google.com>
---
 drivers/mtd/spi-nor/xmc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/xmc.c b/drivers/mtd/spi-nor/xmc.c
index d5a06054b0dd..963a44c3909a 100644
--- a/drivers/mtd/spi-nor/xmc.c
+++ b/drivers/mtd/spi-nor/xmc.c
@@ -19,7 +19,17 @@ static const struct flash_info xmc_nor_parts[] = {
 		.name = "XM25QH128A",
 		.size = SZ_16M,
 		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
-	},
+	}, {
+		.id = SNOR_ID(0x20, 0x40, 0x18),
+		.name = "XM25QH128C",
+		.size = SZ_16M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB,
+	}, {
+		.id = SNOR_ID(0x20, 0x40, 0x19),
+		.name = "XM25QH256C",
+		.size = SZ_32M,
+		.flags = SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP | SPI_NOR_TB_SR_BIT6,
+	}
 };
 
 /* XMC (Wuhan Xinxin Semiconductor Manufacturing Corp.) */
-- 
2.49.0.rc1.451.g8f38331e32-goog


