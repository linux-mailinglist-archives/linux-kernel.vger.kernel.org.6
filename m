Return-Path: <linux-kernel+bounces-209194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B86F8902E8C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3AE1F2235E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E317016F852;
	Tue, 11 Jun 2024 02:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PYhjMA6X"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB8EBA45
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718073923; cv=none; b=UtF3oLAO3lVyX3RdqZpJTj1cjTnQeUXGXCxflTjGGgvUCkEnJSZRonOfrsnO2QgJEPsNOZ7008UO1+hthlZhUpZGPF8BfOxDxHJn2ZKjNjvw9WJwCg1b0sAKxkUjFcLbJsCeQUedRvK1inOj+3K2qwAWCgUJmrLuWiS0e+jwSMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718073923; c=relaxed/simple;
	bh=RGhtpeDuLIP7MKbsA+5GYhZRtZLJbSKNWM9fPhCyP9s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Js3y5osdstdrnpIBqNIFrRQu2bD3N0FHP6QBowhmGH+COvUKRQDXS3NRcioiHjc0322JGeHpupOVsfqBl/lozUfU0OdwTK11tpsdWNdVQXGKzdLinYtMqSYVshMbV+U5tKDo4JXbfsJH60rXXBV7ewwAX/jdjtgbQICkFHhtwSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PYhjMA6X; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yosryahmed.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df7a6530373so9547465276.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718073921; x=1718678721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S76m/1rcjZ7HVm5h/HFj338IB29Gnxtti7cDrtc8pbk=;
        b=PYhjMA6X190puo36vR92dSF5LkMVtrXNOVSZO8D2K12HZPgopSXBI9UR2G1efJkMAY
         2CK8EeIiJaCeNcmnXLTayu95r4Wgg6DMD05snZrPqqRkfWMIzUoiYnbu2WQfXoYcm7wr
         IgluMzfld6l3IcoEEV6WrBKt47/KT1nRDYCydIz9ltbmt+SG1I3gYhUloFbBfpPmHYol
         UaOwCFWroFWMjmCw87w51J82/ww6lsS5QLmRgj+y4CdXNmbf63cS2/4pyi3xpEhgVJ7v
         KrNZTblMsiWoG1JAS8MTfAbCuUEzF18IPfTffIi6J/ieTdqRUrGZOpxBoi+5AMw6mJgz
         p+7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718073921; x=1718678721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S76m/1rcjZ7HVm5h/HFj338IB29Gnxtti7cDrtc8pbk=;
        b=NIcB4F1NWh0RbdCPjaZ/7gwC/vWpVayJKQG3bN5WnQOGU6feWb6Xbh8B1W6MdxwbwE
         Kg3xW1KB33Bfj0ckPTgFm3tDN99rmRXKEFyakDM5yJCneX9aQ83hVu/cJUap+hGsRvzG
         1jzWWOZB4ESDQKnWtinZ09pB+lts3k3eLkp+odO8haU7xVhlAsbBs9IOM1IgEnFEqDnk
         6WdyCCmI6Drby0YzkkJ/WYNzdYVhEuOY49iHW3M2AHLVmIyaumKX2LFytr6fqk5JsxPJ
         jPmraeMrFbQ5dOGWj4uFvJAxs2ARGY6pe605zgvbei7RWc9z7WCkdnKlPwzLGygFQeEe
         3BGg==
X-Forwarded-Encrypted: i=1; AJvYcCUUuddAdpuE6PzWARb72o1U/Hj+FUM3jpI0dAXDOEyG5Zi8U7EWjjE7wNqv+6vJFSWsBm1tAJouPVFTdym209oDfCspwSQk5J+zpDdI
X-Gm-Message-State: AOJu0Yxog5xeYuwzkUgRPyn6qBcdhEGwXHj+/ziqNHBycsgTKjK0PzHU
	PJo1HK577keJqRQve8cUeFaYF02Jqnu+CB1PsnrD5twE3kiGiKVLdmeo/UVFDsDWpfYWc1AhFeg
	cyq/QsyJKCRutcB7HDA==
X-Google-Smtp-Source: AGHT+IH5AQc+Bn7MfrfWCQXqQIKB8mEd8d/y+h/Fxfn5heT9g/iCYqCbw9tsru+N/kEoD61LHDAlNGuosVHNQIrd
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:29b4])
 (user=yosryahmed job=sendgmr) by 2002:a05:6902:70a:b0:dfb:230f:6c40 with SMTP
 id 3f1490d57ef6-dfd9fd42548mr435502276.4.1718073920696; Mon, 10 Jun 2024
 19:45:20 -0700 (PDT)
Date: Tue, 11 Jun 2024 02:45:15 +0000
In-Reply-To: <20240611024516.1375191-1-yosryahmed@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240611024516.1375191-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240611024516.1375191-2-yosryahmed@google.com>
Subject: [PATCH v3 2/3] mm: zswap: add zswap_never_enabled()
From: Yosry Ahmed <yosryahmed@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Barry Song <21cnbao@gmail.com>, 
	Chris Li <chrisl@kernel.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"

Add zswap_never_enabled() to skip the xarray lookup in zswap_load() if
zswap was never enabled on the system. It is implemented using static
branches for efficiency, as enabling zswap should be a rare event. This
could shave some cycles off zswap_load() when CONFIG_ZSWAP is used but
zswap is never enabled.

However, the real motivation behind this patch is two-fold:
- Incoming large folio swapin work will need to fallback to order-0
  folios if zswap was ever enabled, because any part of the folio could
  be in zswap, until proper handling of large folios with zswap is
  added.

- A warning and recovery attempt will be added in a following change in
  case the above was not done incorrectly. Zswap will fail the read if
  the folio is large and it was ever enabled.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
---
 mm/zswap.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index a8c8dd8cfe6f5..7fcd751e847d6 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -83,6 +83,7 @@ static bool zswap_pool_reached_full;
 static int zswap_setup(void);
 
 /* Enable/disable zswap */
+static DEFINE_STATIC_KEY_MAYBE(CONFIG_ZSWAP_DEFAULT_ON, zswap_ever_enabled);
 static bool zswap_enabled = IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
 static int zswap_enabled_param_set(const char *,
 				   const struct kernel_param *);
@@ -136,6 +137,11 @@ bool zswap_is_enabled(void)
 	return zswap_enabled;
 }
 
+static bool zswap_never_enabled(void)
+{
+	return !static_branch_maybe(CONFIG_ZSWAP_DEFAULT_ON, &zswap_ever_enabled);
+}
+
 /*********************************
 * data structures
 **********************************/
@@ -1557,6 +1563,9 @@ bool zswap_load(struct folio *folio)
 
 	VM_WARN_ON_ONCE(!folio_test_locked(folio));
 
+	if (zswap_never_enabled())
+		return false;
+
 	/*
 	 * When reading into the swapcache, invalidate our entry. The
 	 * swapcache can be the authoritative owner of the page and
@@ -1735,6 +1744,7 @@ static int zswap_setup(void)
 			zpool_get_type(pool->zpools[0]));
 		list_add(&pool->list, &zswap_pools);
 		zswap_has_pool = true;
+		static_branch_enable(&zswap_ever_enabled);
 	} else {
 		pr_err("pool creation failed\n");
 		zswap_enabled = false;
-- 
2.45.2.505.gda0bf45e8d-goog


