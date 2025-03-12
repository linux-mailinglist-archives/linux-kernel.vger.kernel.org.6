Return-Path: <linux-kernel+bounces-557479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4CCA5D9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 10:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28CF1188FCEA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD98923BF96;
	Wed, 12 Mar 2025 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Pw6I3hMb"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D8D1DC991
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741772636; cv=none; b=Muwie44MVzF+fVyn4I8yBcCUkiJYfyjP9dod/y990PTCSWpj7Ursn/3gJeTPZ1HTx8Wg64P61tr+89VHD8wgcnuKqGSlY3+48KX5vkYQQrzBbiTIatDMh9cVEomgIyTAbNVtcYLys9jbMl17vPO44EcseAWd2MjXiKTVCE7Ih6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741772636; c=relaxed/simple;
	bh=slZsT0BvdD07D0Q3fJXrCwsAyx3qMEL9C0Njl1XyDTs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IifKv8/RXLYrbwRYbTU0H9hmVsg2vDuR/OguK9BJZGqZOyvKfG4H2PiLbVNEukBF1da67xOIZU/fxWJElhN7op3thgDVgS/s9NxDC9AgFzt6LU2pO1EXU2Al1aRs/oYhKI1Jf5A8skZJ/HJfJ4xLpcHE3uUXdf9iPpSYQAbVT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Pw6I3hMb; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-22548a28d0cso39273335ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741772633; x=1742377433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TNU1uf3Xcdk2nIEqeH1aNvJIrk3sUB0/KSxqYR74jWA=;
        b=Pw6I3hMbaZLk+5WylO+ps63d7i5TpdNwORv+747UAYAU5dUSRThUpxLY5ygaI8B53t
         +Y4hMRGGvcLzg1T5hifL5I3qsdaBk3fk12K7leaQ2X3dWDmaquQXaoIBdY5aV1jdgt8l
         +dxKa4EBAykbW9nY5QYJjPx0wKo18HY22RWzFpIIzrbjAtGlk9XaFgpxf0Lzd2V4vEQ5
         ZpwseB48Axy3UJaAdXX92k1DxuJQCdYkgJAlWIaPH9RRo3sQV/samMM6w1/VfQwzPhwH
         iSMsxazSCSAfzBze6fDMpR9ZzE+EklepdH30CSyuthbHZEs4z72UPRGtZXQ8s3i1ltBg
         C8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741772633; x=1742377433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TNU1uf3Xcdk2nIEqeH1aNvJIrk3sUB0/KSxqYR74jWA=;
        b=KdTp0tfOs029/92NlIvfIDrEhoKCNkcEXhGWKnL1J84UyV5U7XqnP1IduYGLIiaxkd
         lTobQrV1Yl0lqFWZMoycForPYQ+w8jrI52lKfgvndzoXetJRrz/eScEwKb378yZZTRGG
         cHhsH2X6jDe01l3ha4gSLv1mh6NLagKmmzNC/zYix0lU48oZNGdXB6joCX1jVDMzHz8v
         3LSoX4qzj82sNlXULX+cOwktpevmsf/coQjbdotV22/tAqmI42mkW0cVyiwqdBPNBjT7
         FSZDH1L6PfQFTQXwcBriIIAMu3fY/vuudlE8DMwSlDyeQ1ecGXCma+NIINQO37Th10Tg
         huqQ==
X-Forwarded-Encrypted: i=1; AJvYcCX597T28QgHDdGKzyJD5rgM3ybUMbnYL1P3xaYH2z1tLOHHieCiqgBoNtZz5kLXNrCUNAZOyyYlHPP8gac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtc4xh59n0OHMdj0HEfub3DUUciU1kwU3sxlscqIVXQSABvSdN
	0InhstkX8yzDwoCk+AdyzeUTMXbZCQdahRBcpA/vi1tIvX6ZwMpiJzohnYu4rBu57HniOSZdV8A
	AuGQ=
X-Gm-Gg: ASbGncv0i/5zf2tYV729y0gXtWmwdn9nh0tokvZhdsk/SwpV1ob1WEEJc3rImgu3Erb
	J+u4coO1uPHZkPTyK6Jykgv1trNEClq2FKVwPMKP8oYNDo2B7AMkaN0HravBZAI101dgVbJfhvN
	JM1/clKKXk8kTpu2GUuTtZ+MAkPqXSOJrvCPr/LbDEl6+KmWPgdh/J7CcN2s93cBL1SzxIC3mRm
	dDogOgTfvCSiGO80+rI0BYePh2VKIkTk1FxgbSTrDkzS69IM64ITo8uPXhIXaEd6eMHn3sTabb8
	vdu0TJhbwaeCtVcSfjFJKYdcBkrkBlwWSjQM9VDWv/rDnbgQwbZPN1iCjItD8zjZ21LVYA==
X-Google-Smtp-Source: AGHT+IG0oGR5a2aBQhaZI2O1e81Kva+mqhWN9j4apJrnH8Y8d5vEw+BhLhuII9ON1C9+OzxcWiN+bg==
X-Received: by 2002:a17:902:e802:b0:223:26da:4b6f with SMTP id d9443c01a7336-22428895abfmr334184225ad.14.1741772633587;
        Wed, 12 Mar 2025 02:43:53 -0700 (PDT)
Received: from n37-069-081.byted.org ([115.190.40.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7370073a7f6sm976453b3a.14.2025.03.12.02.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 02:43:52 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: akpm@linux-foundation.org
Cc: mhocko@suse.com,
	hannes@cmpxchg.org,
	muchun.song@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH] mm: vmscan: skip the file folios in proactive reclaim if swappiness is MAX
Date: Wed, 12 Mar 2025 17:43:37 +0800
Message-Id: <20250312094337.2296278-1-hezhongkun.hzk@bytedance.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With this patch 'commit <68cd9050d871> ("mm: add swappiness= arg to
memory.reclaim")', we can submit an additional swappiness=<val> argument
to memory.reclaim. It is very useful because we can dynamically adjust
the reclamation ratio based on the anonymous folios and file folios of
each cgroup. For example,when swappiness is set to 0, we only reclaim
from file pages.

However,we have also encountered a new issue: when swappiness is set to
the MAX_SWAPPINESS, it may still only reclaim file folios. This is due
to the knob of cache_trim_mode, which depends solely on the ratio of
inactive folios, regardless of whether there are a large number of cold
folios in anonymous folio list.

So, we hope to add a new control logic where proactive memory reclaim only
reclaims from anonymous folios when swappiness is set to MAX_SWAPPINESS.
For example, something like this:

echo "2M swappiness=200" > /sys/fs/cgroup/memory.reclaim

will perform reclaim on the rootcg with a swappiness setting of 200 (max
swappiness) regardless of the file folios. Users have a more comprehensive
view of the application's memory distribution because there are many
metrics available.

With this patch, the swappiness argument of memory.reclaim has a more
precise semantics: 0 means reclaiming only from file pages, while 200
means reclaiming just from anonymous pages.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
---
 mm/vmscan.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index c767d71c43d7..f4312b41e0e0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2438,6 +2438,16 @@ static void get_scan_count(struct lruvec *lruvec, struct scan_control *sc,
 		goto out;
 	}
 
+	/*
+	 * Do not bother scanning file folios if the memory reclaim
+	 * invoked by userspace through memory.reclaim and the
+	 * swappiness is MAX_SWAPPINESS.
+	 */
+	if (sc->proactive && (swappiness == MAX_SWAPPINESS)) {
+		scan_balance = SCAN_ANON;
+		goto out;
+	}
+
 	/*
 	 * Do not apply any pressure balancing cleverness when the
 	 * system is close to OOM, scan both anon and file equally
-- 
2.39.5


