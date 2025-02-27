Return-Path: <linux-kernel+bounces-535595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CCA474E1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 05:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50E047A6103
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 04:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256D82356D8;
	Thu, 27 Feb 2025 04:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AdF/hgyR"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFE52356AF
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 04:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740631097; cv=none; b=Y6eyddfEPSH+A1ln5wpyptU/7GAOq6uhioM/uQ2k9zDNXrf/NSWFNuQxhtu4zO5w0z7BudN7qgP3fgX0+l/yQJL36+gPTol+2VKpTOAwKEUwCheN8uQdjJP0UachssABlUZ6XFiHuMY/8Hev6crOEa6j+NlbJnGJhkZ6QZxL6Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740631097; c=relaxed/simple;
	bh=MhFopNXFcyHEqtXEyxX8y89MHsiQeb/nSeCVI2a+aiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qn6zHPIy/8RbE/Yg+HR9LTBnmSUgcHXo0HjWn4Stx8CSMc3YtacWKJUgHAOTsYVHs5FKgIMw+RPmeFFPaRLo/827kLwJ2Y0dl3XnIViIlY+PN92ePOC3kF1bggW5XMFPsDc65Xv95I0ZNicn7qG7txcJ84CBuOHwjHesxLC11D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AdF/hgyR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-221206dbd7eso8474985ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 20:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740631095; x=1741235895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/ge7B6UGXcSd47ZURwKYcUmpuFGdMGIsEsj1cDYmyw=;
        b=AdF/hgyRgXkv7QfS5GJFAIkqnG0/U71bbtXoXiT6iMHiQe+cjRr5VYPHIh+NufIe+F
         CSTvtgZuQvaRnv5qVGQT0TR0/9Ud48P1V8ph5kpcFtU/bA+3CYuteKUpdCeNbHIzjOrF
         Pm+AgH8XSj0g6Am10C/nzyCBJq7LSUeIkyfDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740631095; x=1741235895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C/ge7B6UGXcSd47ZURwKYcUmpuFGdMGIsEsj1cDYmyw=;
        b=eWO0pKAmccYg8DYuiuXliqMIhpLo3Ih5uLlOQKqHdO+X4jAhXloeDz1+qU12Vg9L2m
         b/bJ7xRyO08YklGh2LkzPh1Xr99iMICIHG+ayzamRMOjf2L0yrzhtpldCnTqB4+qxZ4g
         H+NB7fdxxEGRqJtZ9CaaIpsm1Ivee45pXppL/K9Z03L9NVYOQ5p2j2T8CYbkGDnMZu/a
         BRImhfXqj0CdSLrf+e7J72yDfzIdt7OMaOlBu5/mIUw80Al3u7ly1wBig6MA4m60yXP2
         93SsZlmOYSKQ9qLACVlEPB57MkWW30W0n/H5XpReCWxTRlEWK0NojdVaVQ893KgAvkGD
         LEwg==
X-Forwarded-Encrypted: i=1; AJvYcCX8bZeBfmB6tZPS0FcHOQjSCSF1yAhAo3oXrs5je2fS6BbuTZ0fMahpEA6pmXnxCcF8LfdN36IFVGsZlFg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2oxCXD3/dnnZwiN0o1SBqnxT6SmUGPRsIkIOKL7fgvXw3LHDv
	jPkiOwDUqE+qbm/y33EZEVlwCn5niNcIRuqDF2ExXk/MNF1AIRkpmzU9PpNNx9JgLmChOSR0QAw
	=
X-Gm-Gg: ASbGncseV0XZPysjU0ZPyfiT+zOva1lKIsvU9VbfMhheiHiAPyTdB6O1BT4UCbc2z7N
	d2kIcFBZMMNEOcpXSE0Ymdfr7dTFe6UtE3zGASjpx+Laz2l8iR/KSWW1H5uX9PQ+hfnUoO0qxOX
	srL9YmRWGdRw1ULnBJTf5CS39Khw564H3lGW8AD3isdrAtQ3ea1I6dwCr4Qokk8f9VgkI0x5rwq
	Cu+32wFH0HTbGU1NWzhsIxDsBi/VCe+LorQe+z74yDpFmjGn3pcn3YHuM8oElIlfDW4EtVqHhAS
	JBa6YxiTtalrkJ6jo5JNKQ9F1Xt4
X-Google-Smtp-Source: AGHT+IEpXBKk19SHbSOiApwPW0gT/JlWHme806+0gknSxKLl1xCL+FuacjL88fnx4daEmXHOHQZArA==
X-Received: by 2002:a17:903:41c8:b0:223:47b4:aaf8 with SMTP id d9443c01a7336-22347b4ac28mr36091275ad.52.1740631095639;
        Wed, 26 Feb 2025 20:38:15 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a9c0:1bc1:74e3:3e31])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504e2291sm4941155ad.187.2025.02.26.20.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 20:38:15 -0800 (PST)
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
Subject: [PATCH v9 19/19] zram: add might_sleep to zcomp API
Date: Thu, 27 Feb 2025 13:35:37 +0900
Message-ID: <20250227043618.88380-20-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
In-Reply-To: <20250227043618.88380-1-senozhatsky@chromium.org>
References: <20250227043618.88380-1-senozhatsky@chromium.org>
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
2.48.1.658.g4767266eb4-goog


