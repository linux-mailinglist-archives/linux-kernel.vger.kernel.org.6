Return-Path: <linux-kernel+bounces-268380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E25AC9423F2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 02:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 202131C22E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 00:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3582B748D;
	Wed, 31 Jul 2024 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYy20JAC"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146B28E7
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722386967; cv=none; b=mrD+/P/dWhWy+I7YDcsdjGhidQJ5c87TFN0LDOir6B6aDHqmpJPx5CoikWUZQvnzm1IRx3wYp4UU5koVSj3zy34O5wWh9W3EdT1ZiqzqTmNQUpCbOuvJlfSBWWQtvp4SJ+kXU+BH6662o9iywObSN7KXhkHeMQnLFJdjvd0v1fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722386967; c=relaxed/simple;
	bh=UZtlcR+Q0ZNh0gQLiKGf4UEajTLx3ddmbJkuC4aZo0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lITw01y066Ts/fZtiGofzY3yOiHZBlHAqYwL/fdc0BTYncWiMLaGQUUL5i89dDM4fitXVPm8SkYy9K+InXh2iNnL1ro0zDogPLxA+/K1c8pALxPLHGDo1SKlOwvjYfBGCwlz0KWATJu6LRxWiOlgplknPa4YdkgBbuCLO4JKaFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYy20JAC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70d23caf8ddso4564595b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 17:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722386965; x=1722991765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vzObc05aPc52UiOVMyTXImOoRUGXGrutktUE8jBFtBI=;
        b=bYy20JACeyDKN5pufWSC2tRG2T1Nb76G1d/aPACkFAN0C7wzhS0XvRGMc40cxGgYlL
         e9gEXX6wXg8qYxOK6k/Q9DkvnTQ9JhRlkCeljD7ABMr3QUiW6ho+oH7Sa4qiJhTjkQj1
         wlOGSyUxpk2kE/CK6Q43MtgQxW5rfthdPt85PaxZqfewCoGKqgUJDjv7mIQBAj1uhjAG
         wkFAiNcETe7MuTKCpRkFiJd4Q97I/Hc0CR13n6BAn87t6/xzJo+1OstMixkcM6kLSVJ9
         aaAYuV2LCgwIQIL4QE24d9dBfyPB+QlzCiii/d/bCkrh4RX8B41CE/rmWXFWgJ8EY8tN
         xisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722386965; x=1722991765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vzObc05aPc52UiOVMyTXImOoRUGXGrutktUE8jBFtBI=;
        b=Z0tBLMoFQzQCKIZY62TWxtOyl4/N/ugBdexPAI6olk11YahthpccedFsN1/j6JZ45k
         lvrm2y7ulZDX/pJRHcCcotG11ZMloAs7WgFSbnhTybpaqD6YVqgv2RIxxsiesEC9Si4G
         PRPSte1I3qGtm4thyN3V2jykGofU2dy/A3zeuehYlBZNJ62lHawvMZoZgYbGQANV59Vh
         IiBWLd1op42eHZ7wQBCHcRK7W6hw6F54QVLsR1ks4Ry+jjjOH0Bcw0Xi1gLW8aCDlx97
         FBLHeCmFLHzO6FOMSxj1IOVo0WUsRArThs5YjJyUmkFF9Eh/svU5LexPsW2r8EiR2ASu
         5OKA==
X-Forwarded-Encrypted: i=1; AJvYcCXKe9NQFfJbRzve1q85Ws/0vf0vjWq9/i4LQdXTNeeTHvZSLOhRgIWGq/DM5HeJrdwmQX2NM4MduPZyqr+gUIc5QL11HJXazyAp0SA3
X-Gm-Message-State: AOJu0YyKxJ8CHNImWH/eCRHL7cM+G9ouPDWNJfhKnHDVji2gItVn3iDU
	cWJ90lHWwvKaAvp0o4Il5upEHuHMmL7Sj48OqCJA4nA+iKqmenLzbtmgtQ==
X-Google-Smtp-Source: AGHT+IGs5mton0rDOBOv3LX32rVq+TkhuohKJ8C5I8UeYNXk4WRk9Y0rEBnc4Wg62q/x6Gx7QlPCTA==
X-Received: by 2002:a05:6a20:2449:b0:1c3:ce0f:bfb2 with SMTP id adf61e73a8af0-1c4a12c5cd6mr16248745637.23.1722386965288;
        Tue, 30 Jul 2024 17:49:25 -0700 (PDT)
Received: from localhost.localdomain (h101-111-009-128.hikari.itscom.jp. [101.111.9.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead8837edsm9344745b3a.148.2024.07.30.17.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 17:49:24 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] mm: zswap: fixes for global shrinker
Date: Wed, 31 Jul 2024 00:49:08 +0000
Message-ID: <20240731004918.33182-1-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses issues in the zswap global shrinker that could not
shrink stored pages. With this series, the shrinker continues to shrink
pages until it reaches the accept threshold more reliably, gives much
higher writeback when the zswap pool limit is hit.

v5 is additional cleanup on comments I missed in the last thread, and
adds Acked-by and Reviewed-by tags into the patch 1.
No behavioral changes have been made since v4:
https://lore.kernel.org/lkml/20240727230635.3170-1-flintglass@gmail.com/

Chnaged in v5:
- Cleaned up more comments (Yosry)

Changes in v4:
- Updated comments and commit logs to clarify expected behaviors (Yosry,
  Nhat)
- Merged duplicated spin_unlock() in if branches (Nhat)
- Renamed writeback attempts counter (Nhat, Chengming)

Changes in v3:
- Extract fixes for shrinker as a separate patch series.
- Fix comments and commit messages. (Chengming, Yosry)
- Drop logic to detect rare doubly advancing cursor. (Yosry)

Changes in v2:
mm: zswap: fix global shrinker memcg iteration:
- Change the loop style (Yosry, Nhat, Shakeel)
mm: zswap: fix global shrinker error handling logic:
- Change error code for no-writeback memcg. (Yosry)
- Use nr_scanned to check if lru is empty. (Yosry)

Changes in v1:
mm: zswap: fix global shrinker memcg iteration:
- Drop and reacquire spinlock before skipping a memcg.
- Add some comment to clarify the locking mechanism.

---

Takero Funaki (2):
  mm: zswap: fix global shrinker memcg iteration
  mm: zswap: fix global shrinker error handling logic

 mm/zswap.c | 106 ++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 76 insertions(+), 30 deletions(-)

-- 
2.43.0


