Return-Path: <linux-kernel+bounces-249764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6C792EF86
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 21:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9BAC287948
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 19:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F302716EB6E;
	Thu, 11 Jul 2024 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dcg8rzW4"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA84C16B75D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 19:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720725604; cv=none; b=QlPFStYSBUySagdE6THrf2qmsiZDjCt70J3GrLje4ODzDr9XO+xgGvWkEWQj/5R7k2HI6Y4ZO5+583YCMN85XKPfpGiyj7tEZDD7VWfxpaC6rnuif8l05hGQIuOQXjO8+luOxmqRsGi0EsLCZrLkDY1G5jcVXhzvYOB4ompGPeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720725604; c=relaxed/simple;
	bh=zR0RnM4zVJ2SIUV2I8MOStgCX4eKGv041KChLuf3LwQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nt56XxDDOuUrI08l6v7i6UH/wgATrq32wLD38bKiUMa9B3WgY+KWlxcStgXq8actgB1uxmk7/bGVULGZXAYk+XSqqy/SyYlpuz8JiTQZl4szztEgKm9qZ2whpPg2PD8dikD5KtAYyLIAuQD96SaAbCmrnFhgY7CqwTEmB0XsS1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dcg8rzW4; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e03a92302d1so1969554276.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 12:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720725601; x=1721330401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y0IJBxGEZh8aIDvEw0KmFnuORNT4a0CNIuPo7E0B6UQ=;
        b=dcg8rzW4pm4jC0iiuqKFwzHcTtODMWLDuSf82IEnmoNsDeaDPWiiRWGFC6qDc/rxU0
         o3PI2+FDhv0uq2aMBBCFR4Gs739QH8WYh3rIpnfDMd/6qI7bgZ/3yIdjctVKLe+Fnece
         Bwk0KOgqJh/O9ypH4c1g1g2UYfpB5/E+Ln0j10okRxFfhcrylUuNRv+oN9ewcNR/Qv8L
         KzhIkB86jDwgagyuFF+IcwRlvVGm9neb3+KmE4dI9D5m+A2Kpg86mREOjx5RpESvNDVi
         g7tuzb9HdWJuIGcDqDj8XwVtuFYs2SaG/vB/8nZcNawMJB4eZls6NTaIyj8Bl93SEDq3
         cObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720725601; x=1721330401;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y0IJBxGEZh8aIDvEw0KmFnuORNT4a0CNIuPo7E0B6UQ=;
        b=hg3rzN7qAgb89uDcyjCAqdIcGudU5TBT/xojhwkfgiM8A3B5lRl56ZsinlPEGAcTQy
         SxuSlXcSlSMp7tmZ9BJsDpmOkFXm8pxgvz0prcM9KTe5S1kOIkCR4LZsfEqmXudlxX0K
         GxFFy+aNOV9MygYmE/NrUzzKkXY//IW2XLbC7RbSGM4b4+lMPa3yf4p9ar/IeWdec5Un
         p8sApCyyeeI3Y4D+qEIRJbHEtbo2+0eoiufwnXJa4U9Qxid1hSH4W3pqTwdRE82N9wB8
         uxrYj6GHtZMuzE8QDXn6SG9fvlil8DEc+i+1sAUDbDMMJ3nIpm8s9hEhmRl75QZV/K/F
         BdyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7iOLjQwCc5XpqfV2JWNtyJxtI4+k3ZFFa20mHY8hCT9PjdMISCoQND4grZuSk3Etmga6AEfHzyWJ2QTzOudCgxfbQHXFmS780kDxu
X-Gm-Message-State: AOJu0YxlNqh2kd9quKOoHV4uLrXcu6Bv65CJqN5wVrRB9uFbDcTXbVqC
	/udpWCQfNhl9JtZkwZ2zMvt8yMJO9qPsvVCrLqcfdu+mo1XR1/5iQClizSgtODLkAaJbcuTTzPx
	ERA==
X-Google-Smtp-Source: AGHT+IFl5/lwjZcmg0Gramun5B417BFKYSxf44G9wfJyYgQTaJof76xuc6ZiaGwXX8SHDS26hFf2arMicVw=
X-Received: from yuzhao2.bld.corp.google.com ([2a00:79e0:2e28:6:7f87:3390:5055:fce9])
 (user=yuzhao job=sendgmr) by 2002:a05:6902:2b0d:b0:e03:589b:cbe1 with SMTP id
 3f1490d57ef6-e041b070dfbmr748760276.7.1720725600922; Thu, 11 Jul 2024
 12:20:00 -0700 (PDT)
Date: Thu, 11 Jul 2024 13:19:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Message-ID: <20240711191957.939105-1-yuzhao@google.com>
Subject: [PATCH mm-unstable v1 1/2] mm/mglru: fix div-by-zero in vmpressure_calc_level()
From: Yu Zhao <yuzhao@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>, Wei Xu <weixugc@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

evict_folios() uses a second pass to reclaim folios that have gone
through page writeback and become clean before it finishes the first
pass, since folio_rotate_reclaimable() cannot handle those folios due
to the isolation.

The second pass tries to avoid potential double counting by deducting
scan_control->nr_scanned. However, this can result in underflow of
nr_scanned, under a condition where shrink_folio_list() does not
increment nr_scanned, i.e., when folio_trylock() fails.

The underflow can cause the divisor, i.e., scale=scanned+reclaimed in
vmpressure_calc_level(), to become zero, resulting in the following
crash:

  [exception RIP: vmpressure_work_fn+101]
  process_one_work at ffffffffa3313f2b

Since scan_control->nr_scanned has no established semantics, the
potential double counting has minimal risks. Therefore, fix the
problem by not deducting scan_control->nr_scanned in evict_folios().

Reported-by: Wei Xu <weixugc@google.com>
Fixes: 359a5e1416ca ("mm: multi-gen LRU: retry folios written back while isolated")
Cc: stable@vger.kernel.org
Signed-off-by: Yu Zhao <yuzhao@google.com>
---
 mm/vmscan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 0761f91b407f..6403038c776e 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4597,7 +4597,6 @@ static int evict_folios(struct lruvec *lruvec, struct scan_control *sc, int swap
 
 		/* retry folios that may have missed folio_rotate_reclaimable() */
 		list_move(&folio->lru, &clean);
-		sc->nr_scanned -= folio_nr_pages(folio);
 	}
 
 	spin_lock_irq(&lruvec->lru_lock);
-- 
2.45.2.993.g49e7a77208-goog


