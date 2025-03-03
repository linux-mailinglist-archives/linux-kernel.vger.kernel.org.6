Return-Path: <linux-kernel+bounces-540891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31009A4B61A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 03:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9366C166389
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 02:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1180D165F1A;
	Mon,  3 Mar 2025 02:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kapbHxaS"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26923159596
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740968769; cv=none; b=Ufig/PQ9M9SLDJe+PT4ZB1z8FsIWiR9bjlGF2JNredW5G9I9g6JJmGt9odUhOOZLV7VDMt7gluAzuNHEYH2XmobLT4L6Ht7G2burf+kRpP3Bxe2Ssq+4h2i2xLvAzZuVKa84jUEtDGROYfEanAtPIoAhYQdu5mNU9q21kQ6r9AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740968769; c=relaxed/simple;
	bh=aFGLpXQ2zJikLhp0V/7S2kKJQjxoxLph0MK/8nTuEpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qnb8tERxm6bTxgUt1buXtnwVR+9PtzJxSGXvU/rhp6KOShuvKUf0iR1Cdt1ggaEWzgh+sYFTDMbIcY9IyMyK8HaxlbipmDY9Xx1dx6AVZ6N5i0ny8ioEjtyD0DoMazDnvDeeGT8VpgFGiV2xTMAVq4Ja8zygZKF5oqosqKTneZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kapbHxaS; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223480ea43aso97214455ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 18:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740968767; x=1741573567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqfsMunD7m+H43cqKfQWJpYb2LZblnvSJ7I+sWg0jpM=;
        b=kapbHxaST4JZ8fxG7saZcDPoMIAKzHHSAypTh4gYUbUSp45836zQ1UnA2J6hnnhJCF
         oqA+opmk0b1emeTOg4KZpXz1Yok94Jj2mwfP1/tBU2YgW9n+XZQa32DAlecYcDsPddSJ
         yslT6kSWnYSFREUmUZu5qNGcurFSUzC65irPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740968767; x=1741573567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uqfsMunD7m+H43cqKfQWJpYb2LZblnvSJ7I+sWg0jpM=;
        b=sHIA89N3ZSbPP9R3wO/zSc2ilHKRKmRM2KoLIhcg1nwvBr/5WYQ0/oFJVciSsJWNSf
         aXz5L/O2TvNQJMEpwTyG8b7NDXLF1H40jtasICKbv9d1dctHzDdCs6TyaJ5dH4lnobEN
         bIztyOtCLjOKMxjiJ0vrALCZomrQ+8XNVPS67Ym80q+UGTKx3sM6dJMQDnDXjNWrjgQi
         uda2jJ+MM9dZbxzN91B8S8lvAQC4YeaaLZoEHRlHcUacLSY4/8Cmy4fpnja8wX6lnjt/
         Ldt2mY3d/rYKvF0xnhDbh2bExhD/z74Bb7+v55nlcQxFNqQ61dvlne6PFZGk9kq43C4T
         MD9A==
X-Forwarded-Encrypted: i=1; AJvYcCUN0g9aMhqfbnZz/P25Gr5X1S2kP4640On/AMZIjMckUqaG9gj4Cyp5puDSRcMEg8q92QOr6UEkamjTYGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUwrPzW+mjCaeEdoHPt4oZYE4s7MeD7r7TfOdnYwqJE8BiRl9E
	xr89NGJAt2AI27WumfjrySuotZQ+YOcm2UqEeylHJaK2U9tIe/2Rq4JV7faH3w==
X-Gm-Gg: ASbGncu3feeZLqCTfDnbVnL/ZKksiq0zmab6KsTyer44OH2hiJhaKID9BcZ4lfa2WG0
	ca+uEqkFZVzaH/6J/te/55hRP4wX1G3AYQ+Oni2kP3gVFBlkvcGmQ/8XufekxHfwWRg8MRxL8AQ
	o3elVhkTr8zLmS4w5BIV6dfUFkTBKLrCRjJYnJjpCvpVXdYguRgXMES0PfvZHUH81z0mUY0tUY8
	srBg/lKYfaplUUBU/vEGzAjaTc8Jj+lY4abaWMdfpREfpX27GHdyiOJ3zFZ8lj4Y+xiVoyGEpz1
	EfkQoVv18D0jEZvdEYW9ZEex+wvcVnRb1VsWH8ivRTs1l1M=
X-Google-Smtp-Source: AGHT+IFee2geL4KKk2MpUs+7Jc0KaKLEfwBOxn21cLTIdP8Q7RgxcXKrybsQAiLxlVLTASPWxF9odg==
X-Received: by 2002:a05:6a00:b86:b0:730:8a0a:9ef9 with SMTP id d2e1a72fcca58-734ac3fffa7mr16371017b3a.22.1740968767388;
        Sun, 02 Mar 2025 18:26:07 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:1513:4f61:a4d3:b418])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736556c8dccsm787620b3a.100.2025.03.02.18.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 18:26:07 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v10 19/19] zram: add might_sleep to zcomp API
Date: Mon,  3 Mar 2025 11:03:28 +0900
Message-ID: <20250303022425.285971-20-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303022425.285971-1-senozhatsky@chromium.org>
References: <20250303022425.285971-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly state that zcomp compress/decompress must be
called from non-atomic context.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zcomp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/zram/zcomp.c b/drivers/block/zram/zcomp.c
index a1d627054bb1..d26a58c67e95 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -146,6 +146,7 @@ int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
 	};
 	int ret;
 
+	might_sleep();
 	ret = comp->ops->compress(comp->params, &zstrm->ctx, &req);
 	if (!ret)
 		*dst_len = req.dst_len;
@@ -162,6 +163,7 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
 		.dst_len = PAGE_SIZE,
 	};
 
+	might_sleep();
 	return comp->ops->decompress(comp->params, &zstrm->ctx, &req);
 }
 
-- 
2.48.1.711.g2feabab25a-goog


