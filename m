Return-Path: <linux-kernel+bounces-560368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9896A60336
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 22:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75B0519C3147
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 21:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0421F4E5D;
	Thu, 13 Mar 2025 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="cTYK3L2m"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F431F4C98
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 21:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741900024; cv=none; b=lJZKNPT/enYkId4SCIvjmf3ESXdR2mL8x9keQv8WbGaGptxovD9nQe3DxSJERoZKs+a1QgoXHCYObdKb0RBFAQ9RIIme5lWNpVMuAoeQb59coIRMKMURMjkxinhbI7hAwJ2kafzNPp3CvtFhHAgFuGmMSyv4IL0OAr3wyptwTWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741900024; c=relaxed/simple;
	bh=N5ZPnD9eg87YeBGPF64tK0I+Kg3TFtErGSzVYhPtzeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=spt8tB645wG3QOwDZ04Art98DXF7N79rUABtViHzbQdAO9BqYySZ4wtQZvRPNoWsdHaR8nPOMYf5L4ix0AkChQts/Bq9A7fzdtVEiVVlFETyUGRgXVXXsKl4LhOV2mxYuvoPVtLlpZSscOD+TDUWc6mu9SuQcojvJlTNqOV/v4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=cTYK3L2m; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7be6fdeee35so239369485a.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 14:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1741900021; x=1742504821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2esPX4cdQSzTzPsUwG+c+ZkpjEsRNEpWoM7zt95z5xg=;
        b=cTYK3L2maOz/3G3S7z0B0NYaoKGoWhMHNOGQ5jblhMRdYZC3bZhFr/bOZmBnznNrLz
         xUNk45+DVQpNX0U0wUeikxoMibSVY2IsmBN0iHqAiJKSGUrh+xAwA/duW48XVhIzJOuW
         /bHzygS7sESZ1MV9RMe0SNFIBzLbTmvMwIsutSXtUboMekUkyizB417EKHQPPrIkS6sl
         mWyggddvAJ+FZVqpe8Mp+p12sBMQKXjmGmNk5ahVJ1gPVHyeFV6sAdsOVQLkQl3kpHsO
         0Aggh9Sh4yAm1r5v+N0iIcYC77cBLluiiRPbWEupDlngOlUZ00MCt03o5OHlalJ+rxfm
         r5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741900021; x=1742504821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2esPX4cdQSzTzPsUwG+c+ZkpjEsRNEpWoM7zt95z5xg=;
        b=tWcThbL23yaeDE2yKSgRjlATnLxxRkk85/HbSs4BngFqqUXtSfoAOifDiVFC6tUWs2
         7UffsDC9TH4oblcxBQm2RshPw+3JfeAmWbu0oMk7hnWjQqATLnatMV/pTeMungRS7uC0
         G8HgVOy8lgo5T2arh3XkkmGAstSVB3KZSuxbilXe84RpV7QNthejzITg8gMxwPOcAZDI
         X2b3QG0dhR0WIwCrvwr4AyqLgPeQM9NRFP3nutnSoTQmSWrQ2W6GcRfd0df65OSz2x42
         FVLYwppLootdv9r3f04VV7pIICC9ZBqs6+6xbeTK9jEhpjgoYTNghkIq89+E60dXfL04
         MFog==
X-Forwarded-Encrypted: i=1; AJvYcCV8D4QXGwZKF9+zI4KCHHsJzbvMAGwRP1yx4+1RhonXgTB0rY/sXy+33DQVpsXZPp8OoZQgMBKoCYb0rBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU/pdgZEEGins687YTszP3twsiZxfr49HPJnz8LfTJhlCJqgte
	KF3kbQu5p72V0unkyfi8CIpMTO7u++GoKNy/X84wfVHg7vmtCSUHb9BRlDORii4=
X-Gm-Gg: ASbGncsSksZOSkVj2UtY/s+XXZXcT16ho0EEUdjU3IcXQqOr6cEXngBZCKhi/0QNIQA
	MG/gZHSBZl90DwC7z3y7iE9frjcaNCDTQfRsouO7TQjjVWzt+LNqvCjshyJQaCvyXO++3MzOIyS
	IfNW99EBPnxIWh+8grgMWWQL3LHRdXvAoL7NtanK55lh2/gAU8WEIZ/bQ+2HiI6Lzh9vr+2IWsx
	atxK7cKE5CC0AIOuXzs9RXI7PXQXk1AREmt2/KvQ/nuztff9+lu8nAw74sESohxW9LYFHxMfLxT
	eywlNJmsI+kuNeG+ZOfU9PP4u0gaX6LvUjs+Cv65enM=
X-Google-Smtp-Source: AGHT+IEDki5koJiqxSP81S0xIyeu1/cjXxLH4CEnBdYSjdRM2zBmEa/+ycr0rjzgyK/cpuSXIx1wnA==
X-Received: by 2002:a05:620a:24e:b0:7c5:4194:bbd3 with SMTP id af79cd13be357-7c579f96ff8mr167000285a.44.1741900021237;
        Thu, 13 Mar 2025 14:07:01 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c573d6fb1fsm142597585a.80.2025.03.13.14.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 14:06:59 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] mm: page_alloc: trace type pollution from compaction capturing
Date: Thu, 13 Mar 2025 17:05:33 -0400
Message-ID: <20250313210647.1314586-3-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313210647.1314586-1-hannes@cmpxchg.org>
References: <20250313210647.1314586-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the page allocator places pages of a certain migratetype into
blocks of another type, it has lasting effects on the ability to
compact and defragment down the line. For improving placement and
compaction, visibility into such events is crucial.

The most common case, allocator fallbacks, is already annotated, but
compaction capturing is also allowed to grab pages of a different
type. Extend the tracepoint to cover this case.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9b4a5e6dfee9..6f0404941886 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -614,6 +614,10 @@ compaction_capture(struct capture_control *capc, struct page *page,
 	    capc->cc->migratetype != MIGRATE_MOVABLE)
 		return false;
 
+	if (migratetype != capc->cc->migratetype)
+		trace_mm_page_alloc_extfrag(page, capc->cc->order, order,
+					    capc->cc->migratetype, migratetype);
+
 	capc->page = page;
 	return true;
 }
-- 
2.48.1


