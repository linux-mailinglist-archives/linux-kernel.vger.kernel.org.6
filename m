Return-Path: <linux-kernel+bounces-560654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DC04A607C6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 04:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CB5A4607FA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 03:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7CC6F30F;
	Fri, 14 Mar 2025 03:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="awf1xZiU"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB662AEE1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741923243; cv=none; b=pv/3ZQr9vLOP9beuf6F6I94SQG4rbRIUhBpnNh3nN2H+pYn86fYt9P0q7ReDtV/Dqcd0rzO9JfOXiEn+31EzdVi3zSgf4iILypDzD/hFR+KX7VJNF14CHjReDr8JPD5C+5HmtQ8TVBc6f2ySl4RBb9fCwbG50taK94Q0B4kvL4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741923243; c=relaxed/simple;
	bh=EivQpi2O8pIN6Now3MfuLg4d7RWNWyh6CXbS/W4t9P0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ff4a4PJXp5e25r6uuoEwHz9lvvFpyPUzxTNx0ts+9b2dNbMwepD5Ue6z6bQiILdfA3WFW/zjW2kc5c6jZ0ymz284KSg5Zb49tr+MGQq7KeV+rKuIfx+oUkasIS8BB0tr3xlhE1dlfuQ74eG7shwcOdfKRdLwF3qF5qNtcudxln8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=awf1xZiU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2255003f4c6so30334735ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 20:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741923240; x=1742528040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IzLcC8Eyie0MxthBF09QbNl/508C79rEY+M+4zhfqEc=;
        b=awf1xZiUE2vqPOgVIKOeKqFvjzOHYp18OLJs/B6/fnvCnZZzXB4/jMmxPvckAuC7KN
         qmaC8/0sOKV7zRkZFp01FXiXPhwXbPQz3xfz7jN8iyIeC2j4F1FxHmd3JWntcayNc4nx
         VHCJyMCy6866NoskRoDtW6GOrMDoSQ9BFtuylCetcFaTRMsI0458ZPwmGAZd13YIaLyz
         hS0gnZat3X2qas17z6EXkdUOUa9jM5OOJ8KQFdVFXkUrwFUWOqwTf2I8msRXP5kDtbLV
         Gv91707csUCXZo+WgLiiNIEVSkNA896k1riIBH9XAkapoig39NMkJHi04KVGjc48uWim
         oMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741923240; x=1742528040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzLcC8Eyie0MxthBF09QbNl/508C79rEY+M+4zhfqEc=;
        b=hwqtqayo6exWuSFRwaY4C3tkRhTXFXdG+GZvkOGKKl21tBsgPu4O93km6XrZAj8oYE
         KqGlr7WCsF6k6eQDKZlYI6z89jGAoaySmqqP+tGYy1XcnXlDXx8Wqusdlmao2z+83KTA
         OnJhZZlRY2GQ3KPegdCipn2M/7q0P/pgYJ+3VXl616EQkne8NGN3e7tTr6YSnducN2VY
         jhkUQzhV6iGA5YCjUiEtireFHLCEE+V3sHYuKKEhuTYjOoV/DM7xt4Oo5alUl7ija2sl
         I69kII3fsyPMSjycAV/aZG7C/crkYfwK1Ee/yycPba6Xjr8ZjAx2o7HTTY3HFr08tu3R
         VfHg==
X-Forwarded-Encrypted: i=1; AJvYcCW8oAgYMIXT5vnhRueJfYKwTYWjIHewi/7cOV8xGvqyWK79gQtj3CVQoNOad5QzqbvxWHwR+oaCenHL1fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2foX2zH/ueuxHXLhWrceJq9qe5IjnZ+nwRifLSVsfYavuyh5U
	qZTZKMdjQYvA8givS2r6CfFyV3rbBmBL5yT45SZ4WoHYGVJiD5hU0WPY+7s4hzk=
X-Gm-Gg: ASbGncseQv9MjCMsO19aNsPs8sAeJjZU+pG9nstU2Vzns74X6PefkfsR44PxxijTFHk
	KFyapbdor7O+oEwYmapmi8CnamC41u/6LixckAxvSvtiP1g1mc8yB81//MQqM4qzD+OB12ZNjda
	DNJNr1dcaKZ5lltcBrRF1Lr6/E7BepLSmO1Hn7YG6Eksmu6xLe+uSEg76hyA2on2+N7Tzlm/8z7
	vfoK1MQu8WQu1vqlJ4coZ5r5p9bpqBZeBR/XQ06NuRsmdg+feWCIMy5titf4t7HQJbq86B4E05a
	e4h4RelLzNn/aZSvc/ExwuMCYzs/etQJRJUjo44ZBDYOKwkRN0WTumtzAbXXTBPpMldufw==
X-Google-Smtp-Source: AGHT+IHkTtLpiPRh154rWR23c7s/Wqh+tHJT7UX/rACxgzWzyRfgJ2LXZqS2mjILyRieWR053xia7g==
X-Received: by 2002:a17:902:e802:b0:216:3466:7414 with SMTP id d9443c01a7336-225e0b094dcmr14270625ad.44.1741923240169;
        Thu, 13 Mar 2025 20:34:00 -0700 (PDT)
Received: from n37-069-081.byted.org ([115.190.40.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbed72sm21295845ad.197.2025.03.13.20.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 20:33:59 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: akpm@linux-foundation.org
Cc: mhocko@suse.com,
	hannes@cmpxchg.org,
	muchun.song@linux.dev,
	yosry.ahmed@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH V2] mm: vmscan: skip the file folios in proactive reclaim if swappiness is MAX
Date: Fri, 14 Mar 2025 11:33:50 +0800
Message-Id: <20250314033350.1156370-1-hezhongkun.hzk@bytedance.com>
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
from file folios.

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
metrics available. For example, if we find that a certain cgroup has a
large number of inactive anon folios, we can reclaim only those and skip
file folios, because with the zram/zswap, the IO tradeoff that
cache_trim_mode is making doesn't hold - file refaults will cause IO,
whereas anon decompression will not.

With this patch, the swappiness argument of memory.reclaim has a more
precise semantics: 0 means reclaiming only from file pages, while 200
means reclaiming just from anonymous pages.

V1:
  Update Documentation/admin-guide/cgroup-v2.rst --from Andrew Morton
  Add more descriptions in the comment.   --from Johannes Weiner

V2:
  Add reviewed from Yosry Ahmed.

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
Reviewed-by: Yosry Ahmed <yosry.ahmed@linux.dev>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 Documentation/admin-guide/cgroup-v2.rst |  4 ++++
 mm/vmscan.c                             | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index cb1b4e759b7e..6a4487ead7e0 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1343,6 +1343,10 @@ The following nested keys are defined.
 	same semantics as vm.swappiness applied to memcg reclaim with
 	all the existing limitations and potential future extensions.
 
+	The swappiness have the range [0, 200], 0 means reclaiming only
+	from file folios, 200 (MAX_SWAPPINESS) means reclaiming just from
+	anonymous folios.
+
   memory.peak
 	A read-write single value file which exists on non-root cgroups.
 
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


