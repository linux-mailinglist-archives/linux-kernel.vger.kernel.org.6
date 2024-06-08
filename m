Return-Path: <linux-kernel+bounces-207105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6574590126E
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 17:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FDE1C214F1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9903317A930;
	Sat,  8 Jun 2024 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiz+M2NH"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7651E888;
	Sat,  8 Jun 2024 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717862008; cv=none; b=Qp+iSsGwxGLpU3o7UYrDESJSuOnTKoCgmJvIW6f3SRsE+QoWU58YKN6nWxtlaTKNDuC9dLnAGZ9toCyJBB8BqfC1KTBN0UJiidjvOAcPiJyyac2kAR6G74+hPK2Z1uAZY5AujD9QPfL556qpO8PSiutj4R2X5nzswM8o3UdzgBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717862008; c=relaxed/simple;
	bh=vOVkuXFeGSuE1OvKskDxmGpY989Qbt/a1vEPJq4FUYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L2qV0WKUEXjM+HaJEfb/2AF3Sc6KBAQy8q5x+xUd15kIeE4PKqctKucM1cNzwuSURjcVqfe4idGM2jCCKrD8+zfk4p7L+ipPuhjvnbNlyfiObmn7vpoA8WdjZ8vyX9OuuYlaX5ooVfYBazIUQbfsShgobLMmevOi1dTbKiuAYU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eiz+M2NH; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7024d571d8eso2607609b3a.0;
        Sat, 08 Jun 2024 08:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717862006; x=1718466806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9VRrAeGIH91nbJ+l+6EogIiaTtVPhZdGtuhQM+K29k=;
        b=eiz+M2NHo0WXCoMozSdHeENCa3O0hSXFqlK1bZv2vP683i1Ng1JRrj/mNMmYd7xxni
         goF1n7Sf9YBN80rkzU3o/99giDHXT46818L0UTZC/l8sDCRPe/184iLJYah888IjtsLF
         7gK7eS4XndZQ9Z7ukwcsSj6N+99QQ+mQ6jCl5qVMrVivaMgH1pxRsWQtoMB5vR9au2kN
         fSnCRpP0GCRS50d/jKKnjsVxjZl2QNhimPqkIPwX54dXXxJcuM2PReBUL5DkibVlWmS2
         B5xlIASYI3ZptatUdRB/xrLeYp2opAP2eV+xuCzHSGqb54zK9OYURkuLD3KnmkFOv94L
         p8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717862006; x=1718466806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9VRrAeGIH91nbJ+l+6EogIiaTtVPhZdGtuhQM+K29k=;
        b=mLxw+1RbNXWi45j2Nk1y+G9Xv8LfTZjCPC+PDSNBSyHknMcZwttPdWvXbdbaE7h2Jw
         4iBdBaduC1YZti5OSQjqim3IH2LP6x93xwFtmGIcPkJWyswooVVnAt1MwsQp8rCIMxG1
         NwM2USYffmxHpCHrP/0WXqL7KAChPr5d5uiIOwVDDFYMaxQC1TivHVfhr5JJa9gXbLeS
         p9QEMu8MCAyCC5h6c9G2WeWPa1s69mPWYWbTnChhSURcMIaQGzHquNlIChrx0s1FzHsC
         F7/Uc9206kC5lhZ/eudL25+sB1lR5rrzIQpo620GCblg0TJbDRjKz2RJ+GqxPp+SH7CB
         05Jg==
X-Forwarded-Encrypted: i=1; AJvYcCW+nqQ/rrkL9cImhsmUVz2YZ1JbkPGNa4MaP7/pjCFLhhblctTjk9r1Mm0lrz0IW+vTfhjR5yAs2vDKewv9TMuxSGoyZ/jdgR6AHewk4DEc2K/vlYEmfVh+j7JSrlJGcd6xmFBSvqE1
X-Gm-Message-State: AOJu0YwMtfSs+WVpxxGstMdEiDkVwAHDqUfdOAWau1O9BOHTmQKDfeuY
	PY6fhhscBhM83TQsQJo9rcQ78vIeMl+m65R3ZpN4C0D47iXqiUvW
X-Google-Smtp-Source: AGHT+IFpTRsmPHwSEMhSYb9qhAwknvo0q5iq6AgwuXLmiBVIA78tWwc33X4OMQqkuR/sfFDPXkrUAA==
X-Received: by 2002:a05:6a00:1396:b0:6ed:de30:9e43 with SMTP id d2e1a72fcca58-7040c754e29mr7200418b3a.32.1717862005667;
        Sat, 08 Jun 2024 08:53:25 -0700 (PDT)
Received: from cbuild.srv.usb0.net (uw2.srv.usb0.net. [185.197.30.200])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd4d9d8fsm4335209b3a.149.2024.06.08.08.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jun 2024 08:53:25 -0700 (PDT)
From: Takero Funaki <flintglass@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>
Cc: Takero Funaki <flintglass@gmail.com>,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3]  mm: zswap: global shrinker fix and proactive shrink
Date: Sat,  8 Jun 2024 15:53:07 +0000
Message-ID: <20240608155316.451600-1-flintglass@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses two issues and introduces a minor improvement in
zswap global shrinker:

1. Fix the memcg iteration logic that breaks iteration on offline memcgs.
2. Fix the error path that aborts on expected error codes.
3. Add proactive shrinking at 91% full, for 90% accept threshold.

These patches need to be applied in this order to avoid potential loops
caused by the first issue. Patch 3 can be applied independently, but the
two issues must be resolved to ensure the shrinker can evict pages.

Previously, the zswap pool could be filled with old pages that the
shrinker failed to evict, leading to zswap rejecting new pages. With
this series applied, the shrinker will continue to evict pages until the
pool reaches the accept_thr_percent threshold proactively, as
documented, and maintain the pool to keep recent pages.

As a side effect of changes in the hysteresis logic, zswap will no
longer reject pages under the max pool limit.

With this series, reclaims smaller than the proative shrinking amount
finish instantly and trigger background shrinking. Admins can check if
new pages are buffered by zswap by monitoring the pool_limit_hit
counter. 

Changes since v0:
mm: zswap: fix global shrinker memcg iteration
- Drop and reacquire spinlock before skipping a memcg.
- Add some comment to clarify the locking mechanism.
mm: zswap: proactive shrinking before pool size limit is hit
- Remove unneeded check before scheduling work.
- Change shrink start threshold to accept_thr_percent + 1%.

Now it starts shrinking at accept_thr_percent + 1%. Previously, the
threshold was at the midpoint of 100% to accept_threshold.

If a workload needs 10% space to buffer the average reclaim amount, with
the previous patch, it required setting the accept_thr_percent to 80%.
For 50%, it became 0%, which is not acceptable and unclear for admins.
We can use the accept percent as the shrink threshold directly but that
sounds shrinker is called too frequently around the accept threshold.  I
added 1% as a minimum gap to the shrink threshold.

----

Takero Funaki (3):
  mm: zswap: fix global shrinker memcg iteration
  mm: zswap: fix global shrinker error handling logic
  mm: zswap: proactive shrinking before pool size limit is hit

 Documentation/admin-guide/mm/zswap.rst |  17 ++-
 mm/zswap.c                             | 172 ++++++++++++++++++-------
 2 files changed, 136 insertions(+), 53 deletions(-)

-- 
2.43.0


