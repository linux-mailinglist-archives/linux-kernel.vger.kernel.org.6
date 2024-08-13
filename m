Return-Path: <linux-kernel+bounces-285197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E30950A70
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 18:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2B91C2341D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 16:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34051A2C37;
	Tue, 13 Aug 2024 16:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dUvmfI+e"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896E41A0B10
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723567096; cv=none; b=SdnTNvFUSV7wym7xK9uh6KkocEsezXY5SRK+O0/E14eidH1dg5z33C0Ss8eHCqB/8o2SCjDiiHz7slLLEJ7a0dd0TjqMt3ovW0gz0C1Wy5O/BqxPieAp7KU3xpi0oADTYs9syUzmCFoCfSNF5VMByaPs1cWanhcHZYqUE7tg/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723567096; c=relaxed/simple;
	bh=l4vfqpnoWKjzhKug8OFPpzvLUpKa1oTaPZqoQ2kGnM8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Kipu6L4HLw9QYr7Cw5Tq+4l3gr0HnmnDHd+Csizdwu6GErm6/nVkajeXyutt0zSQTUGYit6d1m/Os/iCOCEF/8lQTLLeAKXmD0yzVXDWSqItKgXngfi97Sq93X3Zl1YLmShNxOPgRUshkSEDFaOm8kbKJTZa+qNzthfndNg+Jc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dUvmfI+e; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-664916e5b40so507617b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 09:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723567093; x=1724171893; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R6SDifdhjqO17yC0HFRwUIHNeNat6a47KY3Ccl7msPA=;
        b=dUvmfI+eNjkExXBk1EV5NQ4TFDRx6fMz4ZQeSsjteaa1oOyD6XLvxGBpkDyUAKxoW7
         2iAM+EaQp/pLXK+xyjsAfqNsSb3GkWNza1jL4+CoU2qanZFWHinU35t6rgsxes0hdrS5
         lEiVmeLd6fbB7TC8/j3rNIeGuagh09Aa763sYMMeLOhWth3A+FJ1Z8RU/yltEpiIlsmD
         KpGYAKyVRbL3UGkprjeECoQWLABT8vwbGoeHPmYZMtItisatIO7oY6e9/e2fbF7O71Ky
         JMAtzfTQyQSE1YDRUsQLFupvuO2xM9R28gxvAA9wnWJ1YE9w3af8dpfNHmJdTySQZ+TB
         VsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723567093; x=1724171893;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R6SDifdhjqO17yC0HFRwUIHNeNat6a47KY3Ccl7msPA=;
        b=VF2pM/Tmjw3qztzT7MBzK/C8weDx3cTj7pe9LXPiYZqIpHByAHpr3CP5f8H2LVBRnF
         GKCh4L6g/PHBkU+c1UBZwCJ2xre1LTf0RGTa/zGZerHazZhZ9xK5CCKYEi2YNLBgz5PW
         H8ekR5LLJlu1CnFnh6clondAlLbV+1YUH+O7K4vFztgBp8QlJyjeHm5UX0Lev0dpz+y2
         107dP19qUexXfc0juBipqEXuCWat/1abOYURC80c3VdoXEDsN9MFnAy/jt/LIVhb5Yni
         wfsKnsXJuMeKiFbPblEpi812kgwU7iHbkf+DMs0Zwd2LvsXzjm/gqF3ECkj8kAfYSiG0
         o72g==
X-Forwarded-Encrypted: i=1; AJvYcCVoua1623S6dFlkA6mJHV1fSeP+zL7fg4IeucIrbR9axA8vNERyHwjCodGntQmDKWcR4RrKZtaQMUnzRSQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIZtFNawhIfy8fsbV+aGhf4N//YfPafvpwumwk0fU5lvahUt84
	Ho0NYmXdKupRGG81eePnOjOImiWXwplAZTySmP044tNEODFugvTmCKs5hrKvoKaPX8z6u+bSjUw
	2Z0cTPA==
X-Google-Smtp-Source: AGHT+IGcnXWZqgJ+ZR2B4X2Y8tCJ7S7CD9pQ8Z0L73phBV4+zSqxFBKdePQrELcLsgKcQMYnrvHZtZWB2mEG
X-Received: from yuanchu-desktop.svl.corp.google.com ([2620:15c:2a3:200:b50c:66e8:6532:a371])
 (user=yuanchu job=sendgmr) by 2002:a81:77c1:0:b0:648:2f1d:1329 with SMTP id
 00721157ae682-6ac707e5fc2mr93647b3.1.1723567093393; Tue, 13 Aug 2024 09:38:13
 -0700 (PDT)
Date: Tue, 13 Aug 2024 09:37:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813163759.742675-1-yuanchu@google.com>
Subject: [PATCH] mm: multi-gen LRU: ignore non-leaf pmd_young for force_scan=true
From: Yuanchu Xie <yuanchu@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Lance Yang <ioworker0@gmail.com>, 
	Huang Ying <ying.huang@intel.com>, Yu Zhao <yuzhao@google.com>
Cc: Yuanchu Xie <yuanchu@google.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

When non-leaf pmd accessed bits are available, MGLRU page table walks
can clear the non-leaf pmd accessed bit and ignore the accessed bit on
the pte if it's on a different node, skipping a generation update as
well. If another scan occurs on the same node as said skipped pte.
the non-leaf pmd accessed bit might remain cleared and the pte accessed
bits won't be checked. While this is sufficient for reclaim-driven
aging, where the goal is to select a reasonably cold page, the access
can be missed when aging proactively for workingset estimation of a
node/memcg.

In more detail, get_pfn_folio returns NULL if the folio's nid != node
under scanning, so the page table walk skips processing of said pte. Now
the pmd_young flag on this pmd is cleared, and if none of the pte's are
accessed before another scan occurs on the folio's node, the pmd_young
check fails and the pte accessed bit is skipped.

Since force_scan disables various other optimizations, we check
force_scan to ignore the non-leaf pmd accessed bit.

Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index cfa839284b92..4a112c2d1a64 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3476,7 +3476,7 @@ static void walk_pmd_range_locked(pud_t *pud, unsigned long addr, struct vm_area
 			goto next;
 
 		if (!pmd_trans_huge(pmd[i])) {
-			if (should_clear_pmd_young())
+			if (!walk->force_scan && should_clear_pmd_young())
 				pmdp_test_and_clear_young(vma, addr, pmd + i);
 			goto next;
 		}
@@ -3563,7 +3563,7 @@ static void walk_pmd_range(pud_t *pud, unsigned long start, unsigned long end,
 
 		walk->mm_stats[MM_NONLEAF_TOTAL]++;
 
-		if (should_clear_pmd_young()) {
+		if (!walk->force_scan && should_clear_pmd_young()) {
 			if (!pmd_young(val))
 				continue;
 
-- 
2.46.0.76.ge559c4bf1a-goog


