Return-Path: <linux-kernel+bounces-223921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 173F1911A80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C66C22815AD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC05913B5B3;
	Fri, 21 Jun 2024 05:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsKyTF1/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4BB16B732
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948543; cv=none; b=GrWi8cQIc+HBpsTLbTt9JzSATEEAgSxUxYVbo8gPWmHNCptY8bpfqpk0tcSpNNg+KiwjuqLmelmGm80JW1943UkY5pFGeDxAtxr3Hlt/wQ/dlpjjiTSZThEMoK19A924M3Ag643VrfMsSKFH6Z0TpSvwx4pvr09zPER4musDg90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948543; c=relaxed/simple;
	bh=Aj59HBvyuIXaYaW1di/3HOtWKFIv4GVuFVxywiNiDA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clXw2LsGJTNKDlEq7kJTP8JF43mbInAMXcZ1MBeDQDzOJObkkcQ5MUEXv3wJmPPitsxCDKOx9yBNzMrhQ2pYb4mrqFtIC2+VLRh1H1X/EHL4K5pqdq5KAH3lSC7ezalKMezNBGHgsUTWMz22O5teTxj5xM0RLDTzeUPRVCfBgNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsKyTF1/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEAEC4AF07;
	Fri, 21 Jun 2024 05:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718948542;
	bh=Aj59HBvyuIXaYaW1di/3HOtWKFIv4GVuFVxywiNiDA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EsKyTF1/bKjYshawlayijtDnP8TUPAZKDtD/Mh/KT6Qq+EEO2S0IMoRSTTzJEp6WC
	 rP1rbJdiN/rO43GsAOREos0OE0VzeKq9mxgnIr9xFw7ZVhj7pzSyzr6JDu7wmazDBE
	 m8dwTE+C2Jn8TGnK9a1VrQHMluBY35EUgoAJKifG2p8UTdMFjLU4NvH4v9LT+ayQoK
	 G0nwEdswmMNrjjmAz/ob2PsABybafsKanTwqe6OWhN6IkJQvNEl02+twpanS7M8zRm
	 6Y4lxyxLowIGC/YcvclDu1cpRRheNG0WyDbEusaKHHJU/rHddJ0Vu17098evnuFyRQ
	 t5biyiMG26RoA==
From: alexs@kernel.org
To: Vitaly Wool <vitaly.wool@konsulko.com>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	minchan@kernel.org,
	willy@infradead.org,
	senozhatsky@chromium.org,
	david@redhat.com,
	42.hyeyoo@gmail.com
Cc: Alex Shi <alexs@kernel.org>
Subject: [PATCH 06/15] mm/z3fold: use zpdesc in free_z3fold_page
Date: Fri, 21 Jun 2024 13:46:46 +0800
Message-ID: <20240621054658.1220796-7-alexs@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621054658.1220796-1-alexs@kernel.org>
References: <20240621054658.1220796-1-alexs@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Shi <alexs@kernel.org>

Convert page to zpdesc in free_z3fold_page and introduce new helper
zpdesc_lock/unlock. this patch could saves about 10kbytes on object
file size.

Signed-off-by: Alex Shi <alexs@kernel.org>
---
 mm/z3fold.c | 10 ++++++----
 mm/zpdesc.h | 10 ++++++++++
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/mm/z3fold.c b/mm/z3fold.c
index cd1332243c62..c3c740b42052 100644
--- a/mm/z3fold.c
+++ b/mm/z3fold.c
@@ -351,12 +351,14 @@ static struct z3fold_header *init_z3fold_page(struct page *page, bool headless,
 /* Resets the struct page fields and frees the page */
 static void free_z3fold_page(struct page *page, bool headless)
 {
+	struct zpdesc *zpdesc = page_zpdesc(page);
+
 	if (!headless) {
-		lock_page(page);
-		__ClearPageMovable(page);
-		unlock_page(page);
+		zpdesc_lock(zpdesc);
+		__ClearPageMovable(zpdesc_page(zpdesc));
+		zpdesc_unlock(zpdesc);
 	}
-	__free_page(page);
+	__free_page(zpdesc_page(zpdesc));
 }
 
 /* Helper function to build the index */
diff --git a/mm/zpdesc.h b/mm/zpdesc.h
index 7fde29645331..06cfd33de330 100644
--- a/mm/zpdesc.h
+++ b/mm/zpdesc.h
@@ -58,4 +58,14 @@ static inline void zpdesc_put(struct zpdesc *zpdesc)
 	folio_put(zpdesc_folio(zpdesc));
 }
 
+static inline void zpdesc_lock(struct zpdesc *zpdesc)
+{
+	folio_lock(zpdesc_folio(zpdesc));
+}
+
+static inline void zpdesc_unlock(struct zpdesc *zpdesc)
+{
+	folio_unlock(zpdesc_folio(zpdesc));
+}
+
 #endif
-- 
2.43.0


