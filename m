Return-Path: <linux-kernel+bounces-315133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCC996BE67
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748241F24117
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20A21DA314;
	Wed,  4 Sep 2024 13:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZEJFMCVi"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FEB1DA10F
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725456319; cv=none; b=WC/PKvm1djvFMwVxykJfvDFgg7dUx9DCfQ/NszNjTh0xVaLN+HxDaUgjTPKBM94gvPjDPbPa7Iu5yzdARLPrCfq/MetDQgQ0R+igq4irrNeGNsGOUfbYo2TMz5nj/AORAyx1ZqgfMnssaSTKfIt/sK7OtClFNQh2AIC03SI9D08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725456319; c=relaxed/simple;
	bh=lUHRhX9XC9fid7bK5peUhG1lZWv1daGrfzSvhVwFqcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KeWsJJqoayM/K797Pii36zk5x9t8swQ4P4fTYBSHzpWP0PEra5e+WQDjl9EQd+Dij2gd8HMSaV4F1fRyKe4W31JGPOnFGdJZUfHVaM18wRtm2RR5+GtpMrt2rXhHD544IgieQWyI5tqnNOVeTsx/++KiN1An/H8WvtvrQkko5aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZEJFMCVi; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20573eb852aso5247925ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725456317; x=1726061117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIs7MeinccseyjglpvttZenxTG40vvELLgrx+T/yVvc=;
        b=ZEJFMCViEDHbt1YyUNDDLPQoWJAzMoaJfAY6UuutZ004b9as3AFL/YID/d8dr3beuo
         AQDSksXr5jSYNWd6RRFtTs6nIv08KVnNgiV0a/rV3mkLoHgr1TryvbTEj6awAOJUlqfi
         9ABKaGUdnSzzlZil2F6decvTBJDj7V2t6UVkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725456317; x=1726061117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIs7MeinccseyjglpvttZenxTG40vvELLgrx+T/yVvc=;
        b=wulg5tIY64z6KAccvbHlwJN0aKimlCFTflLZLTcTxL2ZxnMtffAjytDVPMf5OAqWuT
         aWTQPdXsQK2XwAtAngk8/VRe2y3n6Ky68S82z/3EKYM8qwdwkRiJcVyr2446x/T0DXe+
         RgHeZ04QtKc6zBoHR07tI3G/4D9yFrHbrl8TJjte5md8Z/4+Nf8XUlBy377To2nMCA/+
         mdhKTzliHSjTcPY8LnCndmOfSmfehyzAVq+ppauGqw3lHuWNEdGfqSXX5nn4Opbc5SaD
         QM/d97wNFn5HvWYawscqqm0JEUhnkI/v0A8NWgCkTeqA4cKYVUe6umuKrNc9kNhiHYPJ
         cFRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDkvZlKx7JM66I3myIYoMvBhOocMsF36vlU0r8JxyIFW3x1SNKT7aslYAGttv5IRPyY54mzzQ4SupAsMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd2kFxYbJLQutk9e/hyId8xNm0p9X+hGSsTxrBm4jJiJ2IlH4G
	FSE8w8mDRE4293sxhMQK0btKvY96sG50JrPCJwm7ARV+3ekNabesD76bhPWe+g==
X-Google-Smtp-Source: AGHT+IERVgWhVCAuZsrsR3gmDMnf4CmrbR/HweyKQX8nGmOOyQPKMPzjm6YZWkK8KhvQN/oXoHzt3A==
X-Received: by 2002:a17:903:283:b0:205:76c1:3742 with SMTP id d9443c01a7336-206b7d00d3amr38467745ad.3.1725456316924;
        Wed, 04 Sep 2024 06:25:16 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:4132:a2a2:35bc:acba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea54e7bsm13479215ad.183.2024.09.04.06.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 06:25:16 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC PATCH 1/3] zram: introduce ZRAM_PP_SLOT flag
Date: Wed,  4 Sep 2024 22:24:53 +0900
Message-ID: <20240904132508.2000743-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240904132508.2000743-1-senozhatsky@chromium.org>
References: <20240904132508.2000743-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag will indicate that the slot was selected as
a candidate slot for post-processing (pp) and was assigned
to a pp group.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 3 +++
 drivers/block/zram/zram_drv.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 1f1bf175a6c3..c91fdf399d1b 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1368,6 +1368,9 @@ static void zram_free_page(struct zram *zram, size_t index)
 		goto out;
 	}
 
+	if (zram_test_flag(zram, index, ZRAM_PP_SLOT))
+		zram_clear_flag(zram, index, ZRAM_PP_SLOT);
+
 	handle = zram_get_handle(zram, index);
 	if (!handle)
 		return;
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index b976824ead67..e0578b3542ce 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -50,6 +50,7 @@ enum zram_pageflags {
 	ZRAM_SAME,	/* Page consists the same element */
 	ZRAM_WB,	/* page is stored on backing_device */
 	ZRAM_UNDER_WB,	/* page is under writeback */
+	ZRAM_PP_SLOT,	/* Selected for post-processing */
 	ZRAM_HUGE,	/* Incompressible page */
 	ZRAM_IDLE,	/* not accessed page since last idle marking */
 	ZRAM_INCOMPRESSIBLE, /* none of the algorithms could compress it */
-- 
2.46.0.469.g59c65b2a67-goog


