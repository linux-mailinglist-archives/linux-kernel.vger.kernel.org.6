Return-Path: <linux-kernel+bounces-364807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F069199D9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 00:12:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E018282AA5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 22:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5561D5AA8;
	Mon, 14 Oct 2024 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jR/LQBfg"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6361D220A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 22:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728943953; cv=none; b=eQetLo8YD5raCdS5tVkiUWTl50vBPfNe3+1+m1rEVdtTeXEBGmCTRtJcXsgQ/XQi2uQvAb/99PtXJP3fdYo+Ha1JhwDsdYQNBYcMTmo86TLagXigyWpJH7nn2oBzVcep8iW+M9fEXaos+609vJGLVcRLYSOezBkA+uc75hmWKsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728943953; c=relaxed/simple;
	bh=b+N9/Uo7/Kqo2aQov3hoyp3c4AZSyhZWymEZTP4AMIs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UOJtGhbRoOJEEh5MjNFrAomQbvIlcwFdIg9tuT4xquC9gxj6Uec4tfij+hYm1AkZ5/XvlM1kUbm+EM4D8KWmtHs1LbQH96yG0wAG1ze24S9djw686dENEGLXZ3EYkuSSrp5SaHNDioB4pg078eWCUByunAGnHmxQPDFajWIKy7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--weixugc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jR/LQBfg; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--weixugc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-20c8a799e8dso39995065ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 15:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728943951; x=1729548751; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=StVEPLlBONEMwFAfdA5SiN1ofT0Acong4DzVn1DhVfw=;
        b=jR/LQBfgCPOsSRnq9X4CPkQch2und2N0tULcL9b0NMT8eDbN5HWVdp2Yq7kmRzFVR9
         xL/2tMhoDNTvg1Q93d3LOq6/FwMNaI5B0DPS7L2irZKnbM1d/XI4SaO0aYlTYQvq784c
         cuTsoa2qUBY1OdhHRreHMFbgPA/7Vt4RXlLsMtBBEIUnEruFASit0XOMZHQH0b9+hHNo
         oJvqOtWqH7nS1za1OseQ7iT9BQMqf4T5v5k/tI7BrAmTYd9yyd4WMNPJnnSxwDQsH6LB
         d4NQhvoCFzdB409zr2fxylku0CjxBSQpgfBbyhNCPSHEGwFWHAgFe5o5aoKhzHuFjaWv
         Neww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728943951; x=1729548751;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=StVEPLlBONEMwFAfdA5SiN1ofT0Acong4DzVn1DhVfw=;
        b=LxV5Sjk1PnPMKXjkhC9iFwM1mMsSfME+bMF4k40YTgGdorX0575h8COxnk6pXRmZvS
         zi/qdrp8fT0nknET7Jj7nTzCaBG23+1UJFaQGjaP9nN2DkmQpIIP4A/kOW/hea97bs7y
         emlcu/Q9ENXTKTxdADPE7xLcLJ8OgmjMXL142EZ/dF0Nc1Y/Mxv9bhB3lDOBBqnK/E0g
         oamTSHOUjbt9ygMxwK9K2wqTOgG50Eg4Wo8DceCf5I3Qyq5V9oeAlKTkR6OJoZo7y67G
         COy+Us0PqK7d1ZzLoEcNmvXozlSUioz8TNL+aEyF63DpQprpbDl+TVi01HjkL+QSsNkQ
         whuw==
X-Forwarded-Encrypted: i=1; AJvYcCV3QwT1dkMrlIGjiZT91/tiHNQthamhk/m0aoQrdfoUcky3RRsaboC6N1qesNgO3qZVTVb4389zFS5/VcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwveCHeXiiyLWMLnLTCfkeIlpc/5GAtp9lTYwU3fvSfU8KlPzYL
	TrIHIzMcEIB5k8zWmTRK4CAk7JaaLUvUPoQEkgJGCrtqVHvJh4QE0iGI+PLJxQKTGizKGvGE5qB
	+6p7Xgw==
X-Google-Smtp-Source: AGHT+IGdWq3ur/1CLZxNkGUkotrxh2qaCJZVTMSVykoVMtaGwuXheZm8sohIFrC3G7BSLGKky9qVb6Inlz7W
X-Received: from monterey.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:641d])
 (user=weixugc job=sendgmr) by 2002:a17:902:c40b:b0:20b:7be8:8ed0 with SMTP id
 d9443c01a7336-20ca142a427mr560145ad.2.1728943950779; Mon, 14 Oct 2024
 15:12:30 -0700 (PDT)
Date: Mon, 14 Oct 2024 22:12:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Message-ID: <20241014221211.832591-1-weixugc@google.com>
Subject: [PATCH 1/2] mm/mglru: only clear kswapd_failures if reclaimable
From: Wei Xu <weixugc@google.com>
To: Yu Zhao <yuzhao@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"

lru_gen_shrink_node() unconditionally clears kswapd_failures, which
can prevent kswapd from sleeping and cause 100% kswapd cpu usage even
when kswapd repeatedly fails to make progress in reclaim.

Only clear kswap_failures in lru_gen_shrink_node() if reclaim makes
some progress, similar to shrink_node().

Fixes: e4dde56cd208 ("mm: multi-gen LRU: per-node lru_gen_folio lists")
Signed-off-by: Wei Xu <weixugc@google.com>
---
 mm/vmscan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 50dc06d55b1d..9d1e1c4e383d 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4970,8 +4970,8 @@ static void lru_gen_shrink_node(struct pglist_data *pgdat, struct scan_control *
 
 	blk_finish_plug(&plug);
 done:
-	/* kswapd should never fail */
-	pgdat->kswapd_failures = 0;
+	if (sc->nr_reclaimed > reclaimed)
+		pgdat->kswapd_failures = 0;
 }
 
 /******************************************************************************
-- 
2.47.0.rc1.288.g06298d1525-goog


