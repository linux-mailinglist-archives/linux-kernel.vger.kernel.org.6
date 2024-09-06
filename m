Return-Path: <linux-kernel+bounces-318148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC4396E8F7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 07:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7886B223C4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 05:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150588288F;
	Fri,  6 Sep 2024 05:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KJsES09U"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8F661FD8
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 05:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725599115; cv=none; b=FBPH4aAr4xvQzWqCUo/bjEcmZpnNOo3xCStEe6UmtzOZq/yjMTocmTaBh7sjjQcu4bXa/GCBzin3Cn3wv63bhXpp7JmgkuDe8qniaTFarNSHRn8tUrwuaKcGs5xxC/DgmdO10RK3+ZZBwZMD56jdRsIDgol7inJLzQ5Nl0ZDewY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725599115; c=relaxed/simple;
	bh=nAaQpHb8gg16TZ8BeUfauzOeCB3zw10BvWDjsyo0vcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B+rkWMeZKYMRVhzDpJo4zYKoVvUlIdU9JpXh/F+qsOcHoB4PxYVrT3Ketdr1ICpKQPuvx9dDN/06xFqBt4v4BxM4A4xU8sNqSJeuhiUwDDdPBFK8yYtpkPn9lDlHFMc0B+dko8LZwrLIeGnpast9bs5lR9dlLgIqwBGMHGFwP7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KJsES09U; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2068acc8a4fso17247315ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 22:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725599113; x=1726203913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WIvxM0titI1ClES09Gyw9hnmk8EQicnAm/fQgH/qdaA=;
        b=KJsES09UhbqjpuCG+UmDI9wUVivSNOVH64ic+8LR/lPaQY7ZzhXqV8ewb08nFhwR9r
         RGHoPfKUWlDojErr4ghL6l+tohnlPXIyy0mvXZpt6iguDhtJ4qBi4jXaEVkoexgqtTil
         tL+Llu99pq3qOA17twT+F5AfUMHlY9mdHuRDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725599113; x=1726203913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIvxM0titI1ClES09Gyw9hnmk8EQicnAm/fQgH/qdaA=;
        b=sbuP/ppnvao2UTb3X2S6a+i4LCOZ0PBjO6o43LmrJVOJcZK2E5pGc5Bd3KLVFmTfb+
         K5uL69Obf7JnrcVvtkWBrr+PEFg8oTVNPP2nprvPtUaCd3HzmxS+Rtxe3Gr8G6x6OBXa
         RADbahcE2UHmpw0lnGWkLxFOabdNmel6C8U5lCuwEyALebspI1j7ArPmCusI0ZgEXwTN
         Q1CeB6bfjpmiezWakiyH5gHp4s6HeXUmiQucs+Skc2zPeqVtRtj32kYP0cejs8GcS9z/
         PqgIEToTdz2Ig0ofOOub27KukMtR6r8PxSfE+znMnoA+J2CaH0RdouzIBqVYqTzzcpVh
         Cy0g==
X-Forwarded-Encrypted: i=1; AJvYcCVb4J94fbkwJ9jV79WiO9hEtfIWLXCsPokskECx5Ld9cBBTgL6Sz1P+nnMOO3tPcyiqha0KK0qsXfzvOJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwajNBx6as6c3xwPU/gWMvqHN1qdFum5GkPTu+vLZLAv4LAFEz+
	TkGdc6hfvShZ5Y5uZhbXFeHVdViw96MF9CKFoOkHE/1QxFlou9gBOr1Q2AmNMQ==
X-Google-Smtp-Source: AGHT+IFLlfU6VAXgq/SvZ0CkRdYpaZO6yjrKlWfWOAlw/cKXaL77v9ovuTqwOVPEst6vrRynmqqSEg==
X-Received: by 2002:a17:903:1cd:b0:205:920a:c57d with SMTP id d9443c01a7336-205920ac750mr150110675ad.18.1725599113355;
        Thu, 05 Sep 2024 22:05:13 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:8eb7:9f7e:1b0e:95db])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae90f3a2sm36252945ad.38.2024.09.05.22.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 22:05:13 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Chang <richardycc@google.com>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv1 1/3] zram: introduce ZRAM_PP_SLOT flag
Date: Fri,  6 Sep 2024 14:04:45 +0900
Message-ID: <20240906050501.2494686-2-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
In-Reply-To: <20240906050501.2494686-1-senozhatsky@chromium.org>
References: <20240906050501.2494686-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This flag will indicate that the slot was selected as
a candidate for post-processing (pp) and was assigned
to a pp bucket.

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


