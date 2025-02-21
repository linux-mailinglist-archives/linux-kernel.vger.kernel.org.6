Return-Path: <linux-kernel+bounces-525510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BDCA3F0C0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36079188A1E7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271E72054FB;
	Fri, 21 Feb 2025 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MUibJIx4"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333C92054E9
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130808; cv=none; b=C3LVvW3dZoXGLNy/rrUcpwElb/u4iN2Ag9gsqyyHdYiD3EzbWXeJdJdwd08RcFJYTwM+kNgiOQL7q2vHE+5bArQVzmN9dfi4MjwWtm1lxX+aI00IccvjqogyD6NGHE8Jz1FykV7UShOf4gvPAYrQYvRHGjwgkbRI801wZrIwJgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130808; c=relaxed/simple;
	bh=aCg3ZHdCI8MVwshZm6i0nWyuXLOfe87XpUBdrYVXXFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qPFOWUWG0VUOnounI+X30qlRakFuLYJiyx18GmFNXRGeuhWdf2sxv0IZzluVAKWyHPAwmt/2RjzJUDpTvxcQpNPfL59hvFVZc+s8AHeiQLA1iukA5DzFdChYlcnAKyfv6naWERO9dsGxFFIi/Fz6SdIMzrLVyGIEc/o0FI9vcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MUibJIx4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220bff984a0so36182505ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 01:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740130806; x=1740735606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X/8bmw52gxKP9HlvW7ud00ppVmPtFMCISSlcsi1PIXo=;
        b=MUibJIx4FpsKCytg7GSXiEnPivH0oZ6RMcW6Tken9Nrkm9gJnrayCO1lgQlQVUdFwI
         XZvnzKylwTwagap2sZS9IOejaO7CT45CYI92k/b+GPrC72VK90xvoQoailgnQdfZLosm
         rUBBe6/WJ5lzS+BUsA+MJPi3OIU0F3+7KgCgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130806; x=1740735606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X/8bmw52gxKP9HlvW7ud00ppVmPtFMCISSlcsi1PIXo=;
        b=D4Cbvi2CPttwIQtXUdL/zfCqrvfk1/xV5llpNWcMFK0C59EC3BXyrig14FJsYwVIRR
         UYlUbnQc0MrTtV7jYHWJb7T8T+qYaqxq2h88BSC/BWPhBU5OdQYlB5Y5DmuezRl7e5vD
         oPkKfsHnqUXpwt2QfneYnmLZY06C+H9C10QWwSgwRVCgpHxRargHFJ3g/tC/ByhAHkGT
         3+85mXYw2PdNR7B6v05bEql7WN48sMsuMUSvEuPJK9DJRn5O1lZdbIBFiSoNqsnv+lrj
         oeYHpHAt3TEP/vMqceaurtDbYQnvv3kS8WQ0aoZ3IQuLFPBUpZF4zT2PGS6f13SxBW3R
         edcw==
X-Forwarded-Encrypted: i=1; AJvYcCW6seP6Wo02EC2NX8P2QRMopDRw94PuXeVyQaLo3Swv/seuoCHAK95SHxCoP8zJ4jdP5Qrwg3ZFZ9S3rKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxElcGLk4Ts1Mk8wXJfsRG3N7U3vz+MdHFj+D1kXD/4gBDqrUP3
	rndNvr4FqqLBoJkQsVLtB7M13Eq5EEwaFYHPjKOsepWyGKawM7cmcu82Wyonuw==
X-Gm-Gg: ASbGncuZGokbjAtEniIHO4OXIS90xiujwVSmy3oY/qv3ROyqO1zTgIVrGhLrn82imvj
	4HmuSxC9vMlenamaE9c4054w5YGP1uIVQSHg57s4EmHJMJsyqFlLyF3yKPIgRM62PWUVHZw3+xg
	LVVFEHZYn4FkULEKg5PjlH21OG7lrvBjAMvMNEJo/dC0ygN189NBrzjf3KyFrlDaDeesvZEnsse
	H6u29lsdEvYNcxlBuonra8Uf3w9q4Q8JWQjJYKzbtDn08MG06KWEej/39Nxwh8FP51m3+06vUFj
	1nFrKxX07Ha98yJCCpPxm8iUkY4=
X-Google-Smtp-Source: AGHT+IFiDsUOFrogVCXhwG7jE5UhzUG2HXzmhm8iuLxdnK1gwrZ2PnYz7hKVVRLeqXubsVEuTmgEmg==
X-Received: by 2002:a05:6a00:c89:b0:730:91fc:f9c9 with SMTP id d2e1a72fcca58-73426d6b971mr4177006b3a.16.1740130806309;
        Fri, 21 Feb 2025 01:40:06 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:f987:e1e:3dbb:2191])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73242568aaasm15111670b3a.41.2025.02.21.01.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 01:40:06 -0800 (PST)
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
Subject: [PATCH v7 15/17] zram: do not leak page on recompress_store error path
Date: Fri, 21 Feb 2025 18:38:08 +0900
Message-ID: <20250221093832.1949691-16-senozhatsky@chromium.org>
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

Ensure the page used for local object data is freed
on error out path.

Fixes: 3f909a60cec1 ("zram: rework recompress target selection strategy")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 47ccda207bf3..48639a48ddb8 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2022,7 +2022,7 @@ static ssize_t recompress_store(struct device *dev,
 	struct zram_pp_slot *pps;
 	u32 mode = 0, threshold = 0;
 	u32 prio, prio_max;
-	struct page *page;
+	struct page *page = NULL;
 	ssize_t ret;
 
 	prio = ZRAM_SECONDARY_COMP;
@@ -2166,9 +2166,9 @@ static ssize_t recompress_store(struct device *dev,
 		cond_resched();
 	}
 
-	__free_page(page);
-
 release_init_lock:
+	if (page)
+		__free_page(page);
 	release_pp_ctl(zram, ctl);
 	atomic_set(&zram->pp_in_progress, 0);
 	up_read(&zram->init_lock);
-- 
2.48.1.601.g30ceb7b040-goog


