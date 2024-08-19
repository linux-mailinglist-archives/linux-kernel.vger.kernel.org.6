Return-Path: <linux-kernel+bounces-291947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A00E95693A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011F61F225D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 11:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF58A1662F4;
	Mon, 19 Aug 2024 11:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7aq35Ot"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4BE155301
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 11:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724066474; cv=none; b=UEZfIJj+SozSEQU8tYXGxnbARdbl1hVjPyTd8WgueKQSMabX6bH9owcsvFrpoB89ID/uUA4n5z7spTv+OYquKt64IlFrPxoMy9BPXllDFu2V0tGRFty8qa7iU4Z3bvgsTpKB04U2s9G84sgGRawAuQQLGGqHdsAYpejE0uifKnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724066474; c=relaxed/simple;
	bh=0VjnIf/hlDEndOs7nT0UPnY2vRrpoMRkfUmJ3fevleM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rwIX56eGmoo5QPMmCoyhY9iuuqDYnnhyJCYauSI7eVzKytDhhxmGp7LnA3GSOZ0OLrzkCjyQzI3YyXCnRTseFQmNrhuEYaLxXVZ0dUBungHH7VywRYbYqV3Mfrvmf9VJ+nIRNR38xsrBbmPdlQSU3evsWtbiDRFWAfUryTHpW5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7aq35Ot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43448C32782;
	Mon, 19 Aug 2024 11:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724066473;
	bh=0VjnIf/hlDEndOs7nT0UPnY2vRrpoMRkfUmJ3fevleM=;
	h=From:To:Cc:Subject:Date:From;
	b=B7aq35OtAYcOn3I1hv1gz/xT5z3jHJXmDN9MfBhjfyz1ItPp1HBYW074XwHrQhxDT
	 dVSA6h7ofBRZhg71JJ6LulsaBZQQ9aoPIWwhVuW314b4wevL7GyNXYRB8JqE44Sm9x
	 QCIMaiJyGq3pasNr53aLv03eMTMY1KVSSOSt5SWUSdRJZ15Um9jC/kompdKZ6Hx45S
	 YSnQ+UKQjj3WD0qal4qcsKlTf0xilEgYtywAXCQBR0VacuLa2QKZ6jtRZZ/CirwQxz
	 A7Zydp5eam9cpxEMypkRACfNPDNfwQtE2w2HWdg+PI+Gd7jVItHdFjE2BLBlZ1JWFh
	 9JcsgrDS3UAPw==
From: alexs@kernel.org
To: linux-kernel@vger.kernel.org (open list)
Cc: Alex Shi <alexs@kernel.org>,
	linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2] mm: skip less than check for MAX_NR_ZONES
Date: Mon, 19 Aug 2024 19:26:28 +0800
Message-ID: <20240819112628.372883-1-alexs@kernel.org>
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
index 7d79818dc065..7edc2b8a3414 100644
--- a/include/linux/page-flags-layout.h
+++ b/include/linux/page-flags-layout.h
@@ -14,7 +14,7 @@
  */
 #if MAX_NR_ZONES < 2
 #define ZONES_SHIFT 0
-#elif MAX_NR_ZONES <= 2
+#elif MAX_NR_ZONES == 2
 #define ZONES_SHIFT 1
 #elif MAX_NR_ZONES <= 4
 #define ZONES_SHIFT 2
-- 
2.43.0


