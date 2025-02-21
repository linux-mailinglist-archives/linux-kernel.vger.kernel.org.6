Return-Path: <linux-kernel+bounces-526759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F52A402BB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B61862962
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 22:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C0A255E5F;
	Fri, 21 Feb 2025 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HUVZcPA2"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B08204599
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 22:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740177107; cv=none; b=VuKvDCKmJ8HK+QsXj/ym9DibLXA3wS15hY5087psvrQTMmg57QsfMeXZ3jl1SHrnEFP5pKQMkPAZQJfvOfNoYKn5ZkOMeT0ASr8Zv9YvZh3+dMkZVBQh4OnfLq1QygIVwpOYVvmhzNu1yWnAalN9uWH77yYBaVDL7WNdxQ05lw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740177107; c=relaxed/simple;
	bh=/fYuZtpqwtnnGkN/fr/wmgCPg2VCEfWFjvPSN5XmwhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZALdyo9Caz18b5JTkoZheBgHQ3P/DZJ8wd8yjQmuuFRuRkLcWWvjC919gKMv4PuX+6PS8cGTNlGwIZyeL2g/GmRixc4itpYeh7f1EpDU3n0ifxu2h1AlRbcMLCQUlYUvOlJn1GxtVUb1OlULLgKDHZT87TZAjKrOvZvSiQHlHCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HUVZcPA2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22128b7d587so52439995ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 14:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740177105; x=1740781905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFE2Vkh4W4kK9IrN6erQ+4Og/P/7Lb06X2GD4vSsp54=;
        b=HUVZcPA2oOetOP64ebYeg+J4EsWRwNtHVqSHadIzPBw1aI2mQ0Ok8RAVIICafJNNan
         M07YTb/hle1rnmMDEpAxZzbAlg3vNxOOxtPurNNekXFc0oZLKIkP1t2ZroUJU/t43/uF
         BiZp6wLfZRI4E0Sv9sxJRqVVnbbxjCjHsjD94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740177105; x=1740781905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFE2Vkh4W4kK9IrN6erQ+4Og/P/7Lb06X2GD4vSsp54=;
        b=OwvNtxXxQJoz/9XC9mTYQro7SADHyBF7uaOKkxQRmMz55DKfhH616dLVUyeVBwNphs
         BkHfncxNK9g1eDTL5TakT/QsaXZ1Ry4ZQzUDhgD52g2HI/vw7/QpfO8Vwzd7uqsUXuqF
         7GXbrkgvolqjeEIygKx6Ov47ZOtP/Tby8Nxgt9nQJTgVzy5Y23gimKRC88zyNPPMlsnN
         ofUbkq7/jnXFoz/WbYvYHialZsgVkVGnjPI2l1IlFeZ+74/B1ZpthsbHP2qGadkpPWqJ
         ISH8QtNcRmbfdLYMP9KmOC4AHtCyiPwqXJb4qQ4wGx8oGoFUdRjnRAZ1c1wa46uUcEc1
         Ejiw==
X-Forwarded-Encrypted: i=1; AJvYcCXMoP2xNLLhkLecAdeKOyMPMVfg7aN780cmTquQl6qyuoE12FLwX51TWjQE6ssNFwb3JKx7YqwbFWNtL+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0+tSJWH5MbeLo+SmpNMv04MfQkB5ckCSMGDEi9QmoSoqS9O+Y
	LO0OwfhC+czGt1reHKIArET9lxn2GZP6pXha0Qya3ZQhiR6gDlaPdSsFcFvObg==
X-Gm-Gg: ASbGncv011O5dLw7hzeYolluiMtK4trqVCL3AxqSI8ElUoIEpkS3U5ANf3F7qB2d9U7
	TBjydMSic6XBVXw76G8gUM6jZXCe8ENUW5ZKwEJCOgo3E2+cifW523KQTyEO8gjjXSv1uW5TQN/
	FJJz29f9aKdm4Dxq32kySUXapZZatMWwAFXFButRR5b2SG2GkwwG596WV8iQE+64i1TznQHZDC1
	mmTGa6yd86yWjh2/fYBsjKAY8AgilEOpP48o8Tl1We1IBsgn3OuE93lZYLAfpqqmXpnG6zgyaww
	15n7BxYGX4Zj/23ZSrRfGLrPGL0=
X-Google-Smtp-Source: AGHT+IGOUS6jHqktZGGxZojaBlDO9HK4TxnHkyGnN8Mo5dF34H643X32/pKEEVPpk8gt15j52Rs5cA==
X-Received: by 2002:a17:902:d507:b0:220:c2bf:e8c6 with SMTP id d9443c01a7336-221a000add9mr82113705ad.53.1740177104772;
        Fri, 21 Feb 2025 14:31:44 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-7326abf096csm12468634b3a.170.2025.02.21.14.31.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 14:31:44 -0800 (PST)
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
Subject: [PATCH v8 17/17] zram: add might_sleep to zcomp API
Date: Sat, 22 Feb 2025 07:25:48 +0900
Message-ID: <20250221222958.2225035-18-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250221222958.2225035-1-senozhatsky@chromium.org>
References: <20250221222958.2225035-1-senozhatsky@chromium.org>
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


