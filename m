Return-Path: <linux-kernel+bounces-538673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CDE9A49BBC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 15:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0F9A18940AF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81D226B971;
	Fri, 28 Feb 2025 14:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9Xt0AQH"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DDF1AA1FA
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 14:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740752355; cv=none; b=jYrSS6ZLYw1jb5TAeE4mzYenRRr7lqY89hZUy/ElEi5Jy6bol7iECojzeNjAS8+xGuabGXBwX6okMoU3wLBFkogs0KgpEoa0W1EdiWg7Eu1VcQoIgdbFcrJoRO0DExthwV4AfyE6WKicrmPG3OWPTzBDCIvmw2wVVl3OCotBbTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740752355; c=relaxed/simple;
	bh=hR1IMY3yPlB5htj8BtoTtqh9s14Zv3oACegY47cPvDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+qS4ZdckOYB69HBebcZISfffNyfx6iSXXoQ7bvtJYjRgmjRtzR9CptFprhoCy9c4yawIoBFOP0Y86juHnGzHWlF/BTKEYKUcNZC3rZbFUJe8dvgbvrN4OeTggeioPGh1wYQr6aWu4J6ZuQ0r7+6qnve2aHn0dyihPSoDMIxSbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9Xt0AQH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-219f8263ae0so40207205ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 06:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740752353; x=1741357153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aoJDksZR6tO0VRWqVMeDuRMJYfUAl7CjDy1BbxZ4cR8=;
        b=S9Xt0AQHj/CLwXUr7rLOyAD6uGOq8+/4dvVGPvRD4fyDsGbaiwQHpeHUDr26DfYMs3
         HIBlVdM/axgNZo9mPPfxQ18Q1OX5XDaPBD1DpV7SXw4aMfWi5aJa/aB31e0s5R3RIcuO
         nlqEN07ib8iWPAXje3X3/TnZVSf3ufEEj3ZjdYTOIMvMVeedSLWatjySeNlPus6b5Swy
         3jIyy9hjZ00n21UNSNZy+HsAQTPq9haJrDCpPKhpckX3q7eB/qrueKguD5/oLVaZvJcp
         i2oXm7jitXrycMTTYkasN4c8biUKpHCyXR5tUrmogASGUljoI/Kl8YVDyN2Q7MfnAuOG
         5WPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740752353; x=1741357153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aoJDksZR6tO0VRWqVMeDuRMJYfUAl7CjDy1BbxZ4cR8=;
        b=Nti1IsMLMpjvA/YR55Uc0+XGXUzEqquI1QeCd15L9qtCc4iJtsG6ZsZ8rCd8mvgJnC
         wO5KoD0JOgpzQGXaVmvY5YKowmMYZEwFb0494KrctV0LeUVsyTQAbbE9h5Lgl9QQyasQ
         O9wllfVrNWyEryryPg/Bf4p6YFzioPLR5q4DXEcwL9z1qi9ZgQbGF8DVVY6DTvfNUmXq
         hfggnknL1GuPEp4fnYeSGwkeVsQiibjG+U9eZpzC9m9buYzD5ChMj8BNsl83c4Gs/384
         Xlcz3Ybwyycq5hBUf07DcsdwbGNth4GUvuACZJk7PLG+RCBBwJT1aVvQycHCbKTux+Sg
         HMJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdUpXKqbM00outv4U5O9P8eFNufw91eQpDIMiOwY6ISuosgAimhwnjkgkip8FybooDS475HufFC7qq32E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvZV4pxmhB8bnlOTSJ17KmKMVZCpjyCY+fsgI0oB3CDFOH3gIB
	JwkFSmsaS7YRfKoAuZMV9V9G6edzbw0CO45BBzu06r1mqX4u7sWP
X-Gm-Gg: ASbGncspVuDD4OeXQ0N9fJ083LwCnRS+yW117dGnJT7xM7qe6P3WKb9uktQDU5wUBc4
	qxAWvVCqgKIFpPwzw1Dg7/RhxIzipSIkaseBPkmMZBSfhkYL3oOmD+cnRGYCtyVqfsWYNEh8207
	klcuGRDTEy8cmhTsa9ehBRv73VQFTJy32MWy+nUJuac/OmqKuqIL51rD+uSDNIvV0cz/el3C58Q
	Boq0aYS+vQwSEcMh16TqlcCWuAa7JPmi/5MhWit8vfAc3i6WTDOtJMGZr6f+YmOO018J4NMM9d3
	96zYebdSpHffsBom5SkvQHj+nSePjPs=
X-Google-Smtp-Source: AGHT+IHFSmSa4md9rhHEOa50nd9mwN3EuatCTZt1vLAkmwAwsRiyM9/rO8rQZte7QK0f+7NJZz5kGw==
X-Received: by 2002:a17:902:cec1:b0:21f:592b:b4b6 with SMTP id d9443c01a7336-22369244244mr51845345ad.47.1740752353061;
        Fri, 28 Feb 2025 06:19:13 -0800 (PST)
Received: from eleanor-wkdl.. ([140.116.96.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f97d9sm33669745ad.62.2025.02.28.06.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 06:19:12 -0800 (PST)
From: Yu-Chun Lin <eleanor15x@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	visitorckw@gmail.com,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] mm/list_lru: Remove redundant NULL check before kfree()
Date: Fri, 28 Feb 2025 22:18:56 +0800
Message-ID: <20250228141856.730825-1-eleanor15x@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel's kfree() documentation states: "If @object is NULL, no
operation is performed." Remove checking for NULL before calling kfree().

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202502250720.9ueIb7Xh-lkp@intel.com/
Signed-off-by: Yu-Chun Lin <eleanor15x@gmail.com>
---
 mm/list_lru.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/list_lru.c b/mm/list_lru.c
index 7d69434c70e0..7c8fb17d9027 100644
--- a/mm/list_lru.c
+++ b/mm/list_lru.c
@@ -548,8 +548,7 @@ int memcg_list_lru_alloc(struct mem_cgroup *memcg, struct list_lru *lru,
 			}
 			xas_unlock_irqrestore(&xas, flags);
 		} while (xas_nomem(&xas, gfp));
-		if (mlru)
-			kfree(mlru);
+		kfree(mlru);
 	} while (pos != memcg && !css_is_dying(&pos->css));
 
 	return xas_error(&xas);
-- 
2.43.0


