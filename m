Return-Path: <linux-kernel+bounces-525512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB57DA3F0BA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:44:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80EE4422F4B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39DE205AA0;
	Fri, 21 Feb 2025 09:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nNMVdpmq"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D1C202F96
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130821; cv=none; b=pts7XC2xf35d4bYvU0YJicg+tzTx2Zfk2lLgEJCwlZhyfHy5kz/A0Lue8TrxCqyQLzJ+SEZ7Sc4R0lJIxCakeHRBGNgItKo4uZPHsx0QxhQW620DDNyS8JywZoGojYJwK+HGoV3y+7e86mMiFpkOXD+AcWSzamXHHSGw3CJP+4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130821; c=relaxed/simple;
	bh=/fYuZtpqwtnnGkN/fr/wmgCPg2VCEfWFjvPSN5XmwhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZGbYH9iyOyYw9rzCd2VFjIj1Ye5S1CO3md/o10uZ1sQX0yMtJNUyNQTmWOGrPp/1082o0JnzpxK31Vtrc6f7cMXLeOjjH7LDEA7CRZ/sPFDFbLDgX4LmNwLRA0DM2OKfE+CV2wRODaoKDUS44fq0wDnMR+9j5h3ZekVqV0j2haM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nNMVdpmq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22185cddbffso45291455ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130819; x=1740735619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFE2Vkh4W4kK9IrN6erQ+4Og/P/7Lb06X2GD4vSsp54=;
        b=nNMVdpmqFm3Jm4UREWBbyoGBDwA9+Y6jTMvr0C7AeCoqkkSQqqDrKJ/1kD9Oq9Il5p
         sokb3b28FTJDFjB2YA6Eij8LyxoYPWDax8GbaCqYOO2CyFX4o3YZCscn4HLljf3DRg+e
         6OJBPTTzDBZ9rYMQxNI8z71Tcbp8Meg8Njr2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130819; x=1740735619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFE2Vkh4W4kK9IrN6erQ+4Og/P/7Lb06X2GD4vSsp54=;
        b=Gc2j1gfXjdTfO0mNtHSj3aryylHSZh9N8gVnQQ21UZxqeUg2LBA1EqASW7VZazWKtS
         pQWu0Y8P2OtNH/ZX0p6wf61xqRgMwM4NIFVUJ4J809vGrooTCJRu8Rd+J7TpWu57uVWp
         UYzcl7gL0qbl2fCsS8yvFP+EB7dNj5MqulyR90XYbJfKkvDTKBjw1xiyJnQslt9zG+JH
         aALLLw3ewJBXEQaRXj6/VqOPL+t2o78zK9G/L4IgPOrgdZpJR0i5wRXS19mx31eKMx9i
         Rjv2RFN4ceThopJ9VWIYFl/pVa4yI19OYFpIanhAdO5RD91wVpXcNAMDxQ02ngFWyY2S
         mbEw==
X-Forwarded-Encrypted: i=1; AJvYcCVSAfwCmY85eE6jvqAM0EvTXSzk7eW8oSrv2rL2Er102RwDfMBl/GeoWjT4epYMMKWpEMlx9Ln0sThOD9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxpS8Iu9SFPu8G062DUBSCmrfQadY0czyoerYOUT/rdP2zNFBa
	H3hBjYAfd8mFt9R78fl5wLMbWg9u2gXcCANx6Fgs72mPveWYFHeMMdrGDiwY9g==
X-Gm-Gg: ASbGncsgmC45/WfP2z6yu6w7rSiMkabRmMhX/VcHxmFFUROFe9p+s1sy9YIhCwsq79b
	72rq84XpmkfJe31g/fGxMG44rXL8V4kaKjIiHrUf4GOw6jJ7CZN9KIj0OLnX/IwQWuaHuUvQEG0
	rK6HrpvVsKvB9vy/hjkoWej3165a5+TPFuxPapomlH7PPpgZOFFKKhewBCki1e1t9qrVW7ljmV0
	gj3kOHO2B89stpiYekZ71Tcj/E1p1VOwfIbS3BNqqCbU3wWxGBkfdmgxa+Hmy9P23TILm+9pnbx
	MvFEv2y3iqmOL+oDRqRF85zDemk=
X-Google-Smtp-Source: AGHT+IHaMrwpRWXBtbqLfO7E9WJyzm0Z3N+2WmGGSFh+bCgjQ+uCawv48dxk9E1SSvQ/nXFDOCUNQA==
X-Received: by 2002:a05:6a00:3a1e:b0:732:5875:eb95 with SMTP id d2e1a72fcca58-734140898f3mr13714952b3a.4.1740130819336;
        Fri, 21 Feb 2025 01:40:19 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-732425463ebsm15677215b3a.19.2025.02.21.01.40.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:40:19 -0800 (PST)
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
Subject: [PATCH v7 17/17] zram: add might_sleep to zcomp API
Date: Fri, 21 Feb 2025 18:38:10 +0900
Message-ID: <20250221093832.1949691-18-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221093832.1949691-1-senozhatsky@chromium.org>
References: <20250221093832.1949691-1-senozhatsky@chromium.org>
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
2.48.1.601.g30ceb7b040-goog


