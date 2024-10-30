Return-Path: <linux-kernel+bounces-389434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1310A9B6D17
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 20:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD79C1F22520
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 19:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2583E1D0DE2;
	Wed, 30 Oct 2024 19:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VVQJ7KvG"
Received: from mail-pl1-f225.google.com (mail-pl1-f225.google.com [209.85.214.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347CC1D0DC7
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 19:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730317790; cv=none; b=bMr4iKLV8mT9YdtOLP8XqI9GIttkrAOLdmDmWa1Wwfi0uS+vSLmC5FuGp4B9YEdDLKXm2gnPIRokj0CYwQk12wo7uS7mqdS1JtV2H/F0TAxhVfbzD+zXD70fnm7EXRk7wIzFm6o8FnsehUtIwqwXTSuNGCyo6wXNncVlbcyPHec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730317790; c=relaxed/simple;
	bh=z3nAQNKQ8EPpdG3q4GCW/62oF7r6Z6P5c1Z3MZCXaUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PgIRNc8/UTeIexxJP7ropWthB7mCqw5A4BUj7fzz8V3YM3sMF/qWyskDUybpBUZ9uaHD37Q47qxrykvWc0cp3pgz6Jlf6DDHcURLXvlOyvb7I8znvgB4jXqpRSGhWWcY3uGaaTVURk1V8tQOFudfYPjyCnYBM/st3b+MKex4Aow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VVQJ7KvG; arc=none smtp.client-ip=209.85.214.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pl1-f225.google.com with SMTP id d9443c01a7336-20cb8954ec9so292875ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 12:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730317787; x=1730922587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tf88+MjxuRscGCJUWSV+JgU09beZteKvue7KtOwrEjg=;
        b=VVQJ7KvGMBD1Wro1zIlFaE8BvmX8Xb8SiwGERTAuPdHUq98T0lScSTP9gnR0luvJ83
         msEk3uhKPC/ngTIbZYwr0TFANwV/G2b4ungTKXqafj1JjIvQUNcbvXg27il3WEDuYmh8
         VZ44lWJ/AHScivxdoxibl3W7ZVsnT4+CRWm7TJ1KSfjuAqUM+10yW98zyorJRladHDgx
         JjOuyJxJh7FJxU28kjQwtUoXqsPwNgI9M8KoneOUWDFLZ3GRvWKBALYSaiSnFVby5zBi
         0mTAF43HM2Czrf36o9OiVpnhcWA+6z2LtCBPKQ+Ly4sVdxMQMIS5HoC3Ikh0CvX4IE5T
         m2fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730317787; x=1730922587;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tf88+MjxuRscGCJUWSV+JgU09beZteKvue7KtOwrEjg=;
        b=KXD36/fRneNcpxEbZEJYjvDwFAMG4I+xkNoro1viDK4p9SUaawMM6+K7KOdb5of6nT
         bKmZI/8ektidSeOkcsWQIGPgSl3J3wTyAWSmyd2qXOpXwbeIwAm5y79GIBfs1xYYoXCE
         jZfbPydpD9w5wCqB041x05cO6qCKH0e9KrB7RN/Z/nljAei0bm19f2GFsTYM9Q2EV/iN
         35jXi/bX6vmEE5gEtyEpXwXgxy/P/YGlXVFdfE3arXVedcm4KOjrXfhCKIQuvcIysLKv
         qkYv3J3Jbd6kJlUlL+jU7NkOc3oJ9cZH7FlvqxKmoCbuCpRpOFu5n2w58lin1iJXTuDM
         ThFA==
X-Forwarded-Encrypted: i=1; AJvYcCW0/1bOBd6IuBdQzbq6zwNMCt99NtN9+q+hR6uZt5A31yhmZdGha1AWWB9FwOaAIGkV0CMy009PRkyo9qA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDaXol2/I6u17FkwYNUGsslqTk+jKePnKEIfj3OdRWilw2CV9p
	cEUtFnCwtE5C8Jdeo4bRH8EYCV72G3U3qT215C7UWkUERDfT9hB0zgO9GWhORtj6f/e4q/c5cxU
	ZTtxgEerzrDpkjwkkjUYyLAggcUYu1yNT
X-Google-Smtp-Source: AGHT+IETNzhIkOf8KTWkuTtJrYxBj0S2i61ZJQx3allXNo1WvRZ6unG74zcMz+NV+mVUoPFel0OULMpYhN/X
X-Received: by 2002:a17:902:ce8d:b0:20c:e2ff:4a4c with SMTP id d9443c01a7336-210c68a0613mr95265475ad.3.1730317787384;
        Wed, 30 Oct 2024 12:49:47 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-210bbff74a2sm4963625ad.127.2024.10.30.12.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 12:49:47 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id D062E3406B0;
	Wed, 30 Oct 2024 13:49:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id C44A7E40BBB; Wed, 30 Oct 2024 13:49:16 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Tal Gilboa <talgi@nvidia.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dim: make dim_calc_stats() inputs const pointers
Date: Wed, 30 Oct 2024 13:49:07 -0600
Message-ID: <20241030194914.3268865-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make the start and end arguments to dim_calc_stats() const pointers
to clarify that the function does not modify their values.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/dim.h | 3 ++-
 lib/dim/dim.c       | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index 1b581ff25a15..84579a50ae7f 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -349,11 +349,12 @@ void dim_park_tired(struct dim *dim);
  *
  * Calculate the delta between two samples (in data rates).
  * Takes into consideration counter wrap-around.
  * Returned boolean indicates whether curr_stats are reliable.
  */
-bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
+bool dim_calc_stats(const struct dim_sample *start,
+		    const struct dim_sample *end,
 		    struct dim_stats *curr_stats);
 
 /**
  *	dim_update_sample - set a sample's fields with given values
  *	@event_ctr: number of events to set
diff --git a/lib/dim/dim.c b/lib/dim/dim.c
index 83b65ac74d73..97c3d084ebf0 100644
--- a/lib/dim/dim.c
+++ b/lib/dim/dim.c
@@ -52,11 +52,12 @@ void dim_park_tired(struct dim *dim)
 	dim->steps_left   = 0;
 	dim->tune_state   = DIM_PARKING_TIRED;
 }
 EXPORT_SYMBOL(dim_park_tired);
 
-bool dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
+bool dim_calc_stats(const struct dim_sample *start,
+		    const struct dim_sample *end,
 		    struct dim_stats *curr_stats)
 {
 	/* u32 holds up to 71 minutes, should be enough */
 	u32 delta_us = ktime_us_delta(end->time, start->time);
 	u32 npkts = BIT_GAP(BITS_PER_TYPE(u32), end->pkt_ctr, start->pkt_ctr);
-- 
2.45.2


