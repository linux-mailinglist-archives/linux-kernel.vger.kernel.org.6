Return-Path: <linux-kernel+bounces-510585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E58A31F0F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 07:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988721689B3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 06:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90AA7203704;
	Wed, 12 Feb 2025 06:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bMMR/Bpn"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AE81FBC8C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 06:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342017; cv=none; b=iBE2wmwuq6lgVDHL660i0gNxeugN9Cs7vPWEGw2XzD/3R49EGmvqeXq2eDrFimgsZf11gb6E02565srC9lkCazaFTRLs025v04oz6nJ11AqCW7G7HBHa+ZpgDA3eih3H9ffcc0fR+FwUk7jWYahNWJih+Kpjmnu7yHfv9gOYH10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342017; c=relaxed/simple;
	bh=Ju/AXldQ4LXY+lfPObz58y+sBiIJtoWIokAHacy3FF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QT7yXYB2PB3yH6SLhly79yZY0DO6eWmua/OVWYSoX8iR6QsJBpLNbcTJSH+vM1ZXUG0bLuMfBc84kbuimuAjT6MMRrbhXtuKOGLH21acjFQESxkW8bKbpSGzIonOkwGQRHQs2NxCmY+dCbXa9U85gZrCmoWtf33ByxjcX0WS5o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bMMR/Bpn; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21f50895565so73732025ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 22:33:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739342013; x=1739946813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tBUgKAKzM6MxWLflFY2zWKudIzejP2AyvCz3ga5cMyM=;
        b=bMMR/BpnRmSel7rAAQNWTk4hXuR1wX4iTxJmtogsRU3FcPZn0Enc+VPExmK1kaMRNn
         7WpkkkcDTch/1bQ6Ta9J7mSJP/SbC9YmXIeBBRL4xTURGxLYQoa1FLiG5/9yUDxPj1y1
         VZlhcMfgS1UAX9M5gOBMusJYdSBI+UcBk1glI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739342013; x=1739946813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tBUgKAKzM6MxWLflFY2zWKudIzejP2AyvCz3ga5cMyM=;
        b=hrCXRTUjQyrHh7EHYrHdk+vplgvrFWehkh4iYzyzFLwwocK1T/Xu8iWpoYJPKOTuk2
         87Q9q9MfakQbHzn2CmwwwD2poj1ExWr9Pqw5YWqyzN+GlKbmSdRBvke6EjNv9VUVGz64
         srTvUb8KI9l8j5G2veUX6rc8X4TnAfWU2jVy2urnPW5P8pznrzmvet0X0Tce0cD0RWvQ
         eAS00P2Fc/1/aSDY2L/8L05WSdY3JIPjZueFLZl+Fnpc+zAoydwPdbT00sh2CMa0f+jO
         4qFeyPvlaVzmZJl/xS9Yb1vboFi1WeLy+43OVwqPgeuyzZpartApfaHy5/7Gmn5rc+nr
         AEew==
X-Forwarded-Encrypted: i=1; AJvYcCX+XktmhKBrWxZqE6u5hcNuOf+qias1aUf0teWTOzhEYQSv94oXvVn3xK/TDKY14wXqJNtdChgls0bkFfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAhcPJ0fHbYJ2s/8NJY+Ibdt8I4MNvw4IEC7xIS4U4uSId12cT
	tYf2M515YJUAye8YY7qAcIkIwwv6wQFM77WUU5hYWAi9fTg1t5J5ZmStI064og==
X-Gm-Gg: ASbGnctoU92pVpdfYZFNttc2/qokkbTWqJvyXuAlTA5K0M4rjDyr3pfSDu1m3PqH7l3
	SgLPyPyLcNdDkDC7/3I54fiJAZWm9Ti3IORoqJwMuBs7uHdgo8GiPaYXU0VzS8QFc4K1Vw4Vi/O
	c/N14OWOF8Vx3pbBeVhF3MxRsxG4zqNY55YDluMAe/uLvRmdF524SN7Dpkol2so6atVt5ulTrQH
	4r9hdFtAb5uI7has+JKHO8BGlxSjBJRs86KL2diXfdk1Jj7O2xzPk0Ecuh/81gdvCDk6M0MRQAB
	oD0Z+X9Sdkyr2apeqw==
X-Google-Smtp-Source: AGHT+IFlFIHAdO/k5TBM9JhT/XTZlmlIvZZXfAUmXRCed2AuW1r8OudMsiWeuA3jTbNKnlIXBGxP7A==
X-Received: by 2002:a05:6a21:3996:b0:1e1:afa9:d39b with SMTP id adf61e73a8af0-1ee5e530b58mr3670243637.7.1739342012925;
        Tue, 11 Feb 2025 22:33:32 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:69f5:6852:451e:8142])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73083999abasm5932358b3a.10.2025.02.11.22.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 22:33:32 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v5 18/18] zram: add might_sleep to zcomp API
Date: Wed, 12 Feb 2025 15:27:16 +0900
Message-ID: <20250212063153.179231-19-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212063153.179231-1-senozhatsky@chromium.org>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
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
index 61a9c3ed6f7a..217a77e09dc7 100644
--- a/drivers/block/zram/zcomp.c
+++ b/drivers/block/zram/zcomp.c
@@ -148,6 +148,7 @@ int zcomp_compress(struct zcomp *comp, struct zcomp_strm *zstrm,
 	};
 	int ret;
 
+	might_sleep();
 	ret = comp->ops->compress(comp->params, &zstrm->ctx, &req);
 	if (!ret)
 		*dst_len = req.dst_len;
@@ -164,6 +165,7 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
 		.dst_len = PAGE_SIZE,
 	};
 
+	might_sleep();
 	return comp->ops->decompress(comp->params, &zstrm->ctx, &req);
 }
 
-- 
2.48.1.502.g6dc24dfdaf-goog


