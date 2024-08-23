Return-Path: <linux-kernel+bounces-298480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB37095C7DE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 10:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C0AB1C20FF8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 08:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770F41428E3;
	Fri, 23 Aug 2024 08:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsnbQ1yQ"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA3913B2A9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724401053; cv=none; b=Wsjfs8lWZOBiA1Ujus/4pph66Pd+AfEzciElS95U99oyG+ub6UwFBGOVJKHWEr9DHscWTXvqBGFCpfrhMGZEyTRPnrOSwQGO5igE1YoSKdcBYpCwmEe2pMyriWE/RQX4rAIjKoSO1wBQcwOclINNGgICAVTp3sfdAEMpUZZrlAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724401053; c=relaxed/simple;
	bh=K4KUO9Fi+FVCRo8oAxF1Ljx2b1QiLIrL838Y19Tj2wA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=H9Ml0hdEytagKp9kUiKo4PylV4bThgOva7BD1ovCbgQEKONjt5zShkKDIM7eF0rptHd8cBUSZ9x4fv+TSZha5gOUg1a940KMwiofnNV1wCqPq0aZqhWpKEWDV92HlSiXdU+nWH8+NTQ9KE6Z0OwVFN+Ya0k7Fh9bw5XhC893LMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsnbQ1yQ; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-7141e20e31cso1476445b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 01:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724401052; x=1725005852; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q4meUh9G4mSFOgXfuhl9rvFncf3SSDfDwnMPR42S/Ms=;
        b=GsnbQ1yQW5vMCH1EOPEyRwAyyUV6emOoiftsKURHJ1emyLowcrBRpDtGM0gcyav8N7
         YFH0v7SEH0dAxcO2U7P2W/7AoRinbDz1m/DYajXA3kKoMIOnv668i4AIPHndn5ml6ZvN
         /jhEekZy1ZqQZZRyf8sV2p3KidVNINj3yqdPS9BHEfaexhjp914vTPFgVWudIDqTvoCV
         +Lg7a2wpHYyYwSPeE9I8+LYFsieyq64eeY3xBa7FZ5SDNQ8nvELgvCw62+OsG/9JG+ut
         jtUtDb9Myir3T+K/GrK5ZmBRGZVeQVVsuklsBVUy8d1RqasbPsgb/sZOxPpe214f5y+M
         VnBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724401052; x=1725005852;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4meUh9G4mSFOgXfuhl9rvFncf3SSDfDwnMPR42S/Ms=;
        b=Mio9iVISvxsoj6J+1hrCLGSiHXmtS9bwW/KLZhqekZ9aybi6HcsWbN6Ul5tbVxGhdL
         T1TJJk9TnqOOCBXZIuXNEL5BZQrAS3PSgxhYMK61Q4muF1233A5TluWKMA6xHdTkMTdf
         wINKNiXPizBgSQHzhR7DfcVvNO+NtV41ygxmrTp6zdGHQpb2fWJId17vU1edTq/j1bMe
         3qYgsAKaGZF4DLec0xtwbFdgc2QSA//rwr9Ldp/PVCjWW4EOXh4+BmA9Al6bk2Y7venn
         f/smrcPNQUAaVt50M+1HECuHEBv+1IvoE6eTL0TRTXPq+mMLQtSxOVFYbnnn2eHkzvVH
         zTQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKk+sz1kcACZvdWCfXejx6OkTZGEUxulxz71CJW8aH0701vLcDl8qK8wA5WRT5ixPPhcu/XGvLBoEcIco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOFaWifQp2sHRaK5H47e50B9Bia43NGz7UzuEml8lmKhaFPHB/
	/o7kiDRFMXDb2wjvlwvh2uYvm3tQ6QpWOGgUFqhbhlw+Yj1uP7rY
X-Google-Smtp-Source: AGHT+IE/KwmNp4OwJJNVOZFYYhE1SUs3F8dytk9m3bdX5Zf+owllAkQZFfNnT/WMfUCYhIbgZRL8Yw==
X-Received: by 2002:a05:6a00:992:b0:710:5a64:30d5 with SMTP id d2e1a72fcca58-71445735a7dmr1929036b3a.6.1724401051661;
        Fri, 23 Aug 2024 01:17:31 -0700 (PDT)
Received: from systemsresearch.io ([2a01:7e03::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434252726sm2518009b3a.66.2024.08.23.01.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:17:31 -0700 (PDT)
Date: Fri, 23 Aug 2024 08:17:29 +0000
From: Hao Li <haoli.tcs@gmail.com>
To: Liam.Howlett@oracle.com
Cc: akpm@linux-foundation.org, maple-tree@lists.infradead.org,
	haoli.tcs@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] maple_tree: simplify mas_wr_node_walk for improved
 readability
Message-ID: <20240823081729.GA23434@systemsresearch.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)

Refactor mas_wr_node_walk to make the code more clear and easier to
understand. The main changes are:

1. Replace the forward-iterating loop with a backward-iterating loop.
 This simplifies the logic for determining the correct range
 containing mas->index.

2. Eliminate the ternary operator.

The new implementation maintains the same functionality as before, but
with improved readability. The performance characteristics remain
essentially the same, as we cannot predict which interval mas->index
will fall into.

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---
 lib/maple_tree.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index fe1b01b29..0b3eb55d8 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2203,7 +2203,7 @@ static inline void mas_node_or_none(struct ma_state *mas,
 static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
-	unsigned char count, offset;
+	int idx;
 
 	if (unlikely(ma_is_dense(wr_mas->type))) {
 		wr_mas->r_max = wr_mas->r_min = mas->index;
@@ -2213,16 +2213,14 @@ static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
 
 	wr_mas->node = mas_mn(wr_mas->mas);
 	wr_mas->pivots = ma_pivots(wr_mas->node, wr_mas->type);
-	count = mas->end = ma_data_end(wr_mas->node, wr_mas->type,
+	mas->end = ma_data_end(wr_mas->node, wr_mas->type,
 				       wr_mas->pivots, mas->max);
-	offset = mas->offset;
-
-	while (offset < count && mas->index > wr_mas->pivots[offset])
-		offset++;
-
-	wr_mas->r_max = offset < count ? wr_mas->pivots[offset] : mas->max;
-	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, offset);
-	wr_mas->offset_end = mas->offset = offset;
+	wr_mas->r_max = mas->max;
+	idx = mas->end - 1;
+	while (idx >= mas->offset && wr_mas->pivots[idx] >= mas->index)
+		wr_mas->r_max = wr_mas->pivots[idx--];
+	wr_mas->offset_end = mas->offset = idx + 1;
+	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, mas->offset);
 }
 
 /*
-- 
2.21.0


