Return-Path: <linux-kernel+bounces-514364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B66EA355F7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 05:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A26188F145
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 04:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837A1192598;
	Fri, 14 Feb 2025 04:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oXp5AZNn"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886C618A6B8
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 04:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508845; cv=none; b=joo+Ov4wmo0r3VFJA4A29T4U2z5U5xG8l0lNiMHZvBZ/45EpfXtL+uK+7H0cEyoESNmzlxB51i8NKVwG+Jezy/3A/INtfR80sCKotCV3d/KEVHAe7jLOJkpWp3wc9S/CcZDLqlAYx1W+Y/rJd6VF3wUNucLA417mrLOo8s3JEOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508845; c=relaxed/simple;
	bh=/fYuZtpqwtnnGkN/fr/wmgCPg2VCEfWFjvPSN5XmwhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MV12a9dPWedjXAtYWP8n1Hm+b3wRmwrGn8UnOrpsNF6kel2HEcvm9d3TGvJfk/G67qI58027ZiLECj3qcQNJV50dYuTQf3busXVoGivY6D8h6TOv7J4LWDGMdUIFtJQfaSb8D5b2C320UsviVn3WqlWCQ+WKrdEDiJyUg9Cyzhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oXp5AZNn; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-220e989edb6so16982035ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739508843; x=1740113643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFE2Vkh4W4kK9IrN6erQ+4Og/P/7Lb06X2GD4vSsp54=;
        b=oXp5AZNn6pp3J6fgWR20BpnTVFg21+zKe5IqVuw2yVPeLSnFv8glkI52C9zTGzPk6e
         aaiMtdLo2x7mpuob/UCS9qLPeXZwVfB84BGS9S6hwS8bvPP0Ztnh2Z8JxZ3ZOO2LZc3p
         +Agj4DmGfiZ5Xk3b8irV1AMMC/7b1JFI/3W9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739508843; x=1740113643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFE2Vkh4W4kK9IrN6erQ+4Og/P/7Lb06X2GD4vSsp54=;
        b=vnofGsdGsA4GvdyMNzlE2/OnyGKjQcenQ37M5sXMyCul5YNNkJgAa0qO51aC5zCUYi
         KCtyoGGeV8UbccIBU6G4gs9v9mAuCve0G5/XsgXqWLKw0z0ad9PXxbggCaC2RZ2ykK6p
         gfLl30NIRdhXjrIjuCKcr9KuCeBHk1642MC5EHLS1xc9gDdSm1wC/eukim2qfLfx0dIT
         dckCYedWZYurhm2xuS7JRI/LBJwQaiSbK5bZb5ef+1wIeQbcQPxfQ0ms/SE51eiEeJMp
         66LLfP3spJT0qDb9Vkt833qyu8PM6T+mtocLVM6NBOdyG7W3T8tA5eX7URfhacBk2gLr
         1t2A==
X-Forwarded-Encrypted: i=1; AJvYcCURCuWdrUvGfCUip3r/Fvn7P+w01cKmZGhXTrk41FzusRRR6yRotWWmkWNKOr45lR85WpU5tlKB3Xx2ZHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQsAyOWdZY7OjgCg9zXt0iKEjOyzCsCJUs9gi9GAJFgoWIOaAh
	BFUp/gIkEiMt+GeeioBtrmYH7O8582lwFMQziiPw5EahibNDE5Zk/k5pWMpqGg==
X-Gm-Gg: ASbGncswyb9nV6WCWx53p+ubX3IOeWOIG3Wm7QSUsv0n03vbxhTi3VTKU7TLTrMHeZf
	Rx5zXyuNx1dxpZkJakipA3ahuCNAFFuIcFk3kHcMnBR8n9Ob5YspMmqIRsHJqD27E59wuBbQ0sS
	yjKbvqlehEw0GeKVyN3mvUJZJPD0zkuEngjLl7oGYqVKD8LUJ0LxcedEZTXV9+6xjQjBPyn26CI
	jms68irZswq8GOiDQ96MIp0SzhROylsvXCmyHmnTIGF0oivUn9AAxEVZuRvl5sX7Bf3HIxMSMNA
	Z/J4fftBZQLeHIDKEA==
X-Google-Smtp-Source: AGHT+IEdA+mk+O5VEtAV37EuQ9q5WsoauseiUVXxS1yqw/ceGVJW5mSRJN4cdhO3tV9GqvV3fWIxjg==
X-Received: by 2002:a17:902:f550:b0:21e:ff3a:7593 with SMTP id d9443c01a7336-220d1ec17dbmr77579475ad.6.1739508842864;
        Thu, 13 Feb 2025 20:54:02 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:942d:9291:22aa:8126])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5349394sm20869245ad.49.2025.02.13.20.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 20:54:02 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yosry Ahmed <yosry.ahmed@linux.dev>,
	Hillf Danton <hdanton@sina.com>,
	Kairui Song <ryncsn@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH v6 17/17] zram: add might_sleep to zcomp API
Date: Fri, 14 Feb 2025 13:50:29 +0900
Message-ID: <20250214045208.1388854-18-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
In-Reply-To: <20250214045208.1388854-1-senozhatsky@chromium.org>
References: <20250214045208.1388854-1-senozhatsky@chromium.org>
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


