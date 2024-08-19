Return-Path: <linux-kernel+bounces-291378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F242956164
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 05:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5A041F223D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 03:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127C813BC18;
	Mon, 19 Aug 2024 03:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbhjmZm6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555AC45023
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 03:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724037237; cv=none; b=kIgIkxHucRVXpt0Xr/lgnOgehW51df0YeaSyzXEw9VX4zMluUv1SBydCdd2xYkrnnW/AFhTxin6O+/6ivyrnPk03KfJsrxzs5EnUOvbFzQqfss3Ob2wxNkymlSVc6HMXOqmSAzIx77ZOjM+O34gIEdKG2QxLJvdQrZucna/M3RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724037237; c=relaxed/simple;
	bh=UV23h9/RileAKvpnFwylnCK22FvOCaxLZvjBqnf+krs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B5CQ2/NP7WLaJAwFULO3+qophOCAqk0FM05lx9DpVOluC6zJ8QhKf4hkFrn8ODq58+wbO9V04fuv7MPNdkAyjT8n7SWZdldrE/t6igOdBCXSfpaXQ9aI+dPH8aU5tLmLqACecDtHJFTEq7rTzBfDkDuj6MpMGD8OJ4Gr7mqfBLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbhjmZm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C6BC32786;
	Mon, 19 Aug 2024 03:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724037237;
	bh=UV23h9/RileAKvpnFwylnCK22FvOCaxLZvjBqnf+krs=;
	h=From:To:Cc:Subject:Date:From;
	b=nbhjmZm6RNRN5qQMK+LaZNwNr2v2mj/onOsjh6GYA6cbVHtikLzBpHYk5yGjBdBUT
	 FwyiE0DvdrTHHRj+fpZ6EGJPlT1aEO+l8trKW3m1YleT7t0b1/NtoC5CTcibao+OMd
	 yunIus4HBS+CVb2/+onF42UjNPC8JGtqhptHY6E4jqfaNX3dIuYFClnenn9M5AJWtQ
	 4hzhQgNpobr/dUzf9jTylgHdfhirpDbaTi4awH0pHPMe1NHuDg2uhCkmmdZBaqZjvA
	 2Q/45IEyexkZLJuiA1mRywjYfrRvEaagu8levQMDF4ThEIzG0tjRzvYwHArHvaBFV4
	 8vt+IKnVgV8+A==
From: alexs@kernel.org
To: linux-kernel@vger.kernel.org (open list)
Cc: Alex Shi <alexs@kernel.org>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm: skip less than check for MAX_NR_ZONES
Date: Mon, 19 Aug 2024 11:19:11 +0800
Message-ID: <20240819031911.367900-1-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Remove unnecessary '<' check for ZONES_SHIFT assignment.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/page-flags-layout.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/page-flags-layout.h b/include/linux/page-flags-layout.h
index 7d79818dc065..7acf67c64d5a 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -14,7 +14,7 @@
  */
 #if MAX_NR_ZONES < 2
 #define ZONES_SHIFT 0
-#elif MAX_NR_ZONES <= 2
+#elif MAX_NR_ZONES = 2
 #define ZONES_SHIFT 1
 #elif MAX_NR_ZONES <= 4
 #define ZONES_SHIFT 2
-- 
2.43.0


