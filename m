Return-Path: <linux-kernel+bounces-196685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DB718D5FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96350B22870
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B27C15625A;
	Fri, 31 May 2024 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="kqwInFuQ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDDB155A39
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 10:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152406; cv=none; b=dEkHf78fAmx//HyoWFEW7Oqv8hR2hhMoAmhr4/2Jw3CU5/zEQHw3+o2IAt98UhjZRwXKRkDnF5oONzmL98rrSxRc2T0VKcJCNquetyNMoeu4Yhkk3qzjY0+Dn8FZFcMg+YeGPXPnWtUGTdxYoCgcrmKhSp39eu/F+7CjESPWxto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152406; c=relaxed/simple;
	bh=fYVqmtB2kJ53SFLwXWgsKE9Cw+fbXDC//ZW5qRl0QvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y0Jj/NoZ/oaMMotkSpaSzdbsjytnVdg1M0kS2wCy8tM7gKwWXbsiBdKZEjzR8G1c4ICpXRzrLyqH8dxDJopwcz4WIn/DQTrCStSiMrCbe0gb7eqW83Xcol6t9KCfCSJMau2mi2VBANBIh3bo29B3kGshreJkxxCT6cHn3WAV/O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=kqwInFuQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6266ffdba8so154950666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 03:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1717152403; x=1717757203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WMWnkmBtFZXXX3I47gpNP4mWpXGqK4R1nikBku4RkBk=;
        b=kqwInFuQ/ZdWOLwrrblgMRYPtJrXTz1vO7yVLMx/ZY30bxvxHBX7qDoq7+5crOpGgU
         tiZ80LtgjQHgFTuBWkMUmrIntAyHU+3TuvINmArRX9YC7rCxrC0wc5uA8DqXuU5KBp1f
         CtIWDt7JhlRd4ArK298gja8zxBj6OCZQNBw9GeWjFb2F9FYvQjhdAm6VXEsDowTb8EA+
         R2sLjs96FpGYoUGovLn1on/qJSOX+wreLgONiwllSJz1pASzL7KTFeWfaA9DvAzvRDFZ
         QgajIIO/DcuIlJ2ZG8Ezc6o3iT574C+OPIPF/9d085vhY76d2uZ8OSqRpeqfQGV+lIGb
         C+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717152403; x=1717757203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WMWnkmBtFZXXX3I47gpNP4mWpXGqK4R1nikBku4RkBk=;
        b=VSOFbcot8FDyevi3KaWvVnpjfdtv+GsqT8AGMEvpy6eluuh4YOKC8naXQHvHVnAl2b
         +T+BLIflwjfwOxqBqXMF+hrwxuC4I8F90IeQVtpwwIpfLj0f8qzCdzJ3DJf6lKg2MyZl
         +jzx3WH5aayo7F7iI/+QwbIUxB7RfG9xzWPEWXAz4FzB8E/lAihtXSgEywbvY9C2Op/e
         Nlk+6049GM3e3DWKHj3i1QODj1UPWFutr99o31jce6U+ikf6x2jGzbEWu4XroH9Nuww8
         PVgx1o2DlOU1TtXjtmXKG5dRM0N8QlyKcZOfiWTUykmvOe+dxnkHn1wUSKp370FJ25UA
         BMIw==
X-Forwarded-Encrypted: i=1; AJvYcCVb6FSznIE4HLA/Ln9FDQq7cLSrlFoihhOY4lf/Eg9sx3CJrAMgI41zjHtJ8DNiKCYG6DqvdTHJltZzJMMeOJv96J9NhzOHPQrqukBq
X-Gm-Message-State: AOJu0YwwQpf/73Nhibuh9AgUIBJV8IPEAMezW/tnKPqKR03mhwuMapCZ
	68E4703E2y2jnqYDFKBxaf4c0zeDDONne+gKf7m6F8uvu9fKOA7tp7g828RKCU+QEzLqKVJ+386
	gHvo=
X-Google-Smtp-Source: AGHT+IHwz8F4YsOxCoVyVgxPSwfloqZY14sdnu2nUYWH+snrNLWB7uClqMFZJyHAj9wrQ4oqtxQn1g==
X-Received: by 2002:a17:907:6183:b0:a5a:88ac:fbbe with SMTP id a640c23a62f3a-a6820be9589mr98501966b.46.1717152403391;
        Fri, 31 May 2024 03:46:43 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-160.dynamic.mnet-online.de. [82.135.80.160])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67eb6214efsm72928666b.220.2024.05.31.03.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 03:46:43 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Oded Gabbay <ogabbay@kernel.org>,
	Tomer Tayar <ttayar@habana.ai>,
	Ofir Bitton <obitton@habana.ai>,
	Farah Kassabri <fkassabri@habana.ai>,
	Dani Liberman <dliberman@habana.ai>,
	Dafna Hirschfeld <dhirschfeld@habana.ai>,
	Koby Elbaz <kelbaz@habana.ai>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] accel/habanalabs/gaudi2: Use kvfree() for memory allocated with kvcalloc()
Date: Fri, 31 May 2024 12:46:22 +0200
Message-ID: <20240531104622.564778-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kvfree() to fix the following Coccinelle/coccicheck warning reported
by kfree_mismatch.cocci:

	WARNING kvmalloc is used to allocate this memory at line 10398

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index fa1c4feb9f89..8024047962ec 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -10489,7 +10489,7 @@ static int gaudi2_memset_device_memory(struct hl_device *hdev, u64 addr, u64 siz
 				(u64 *)(lin_dma_pkts_arr), DEBUGFS_WRITE64);
 	WREG32(sob_addr, 0);
 
-	kfree(lin_dma_pkts_arr);
+	kvfree(lin_dma_pkts_arr);
 
 	return rc;
 }
-- 
2.45.1


