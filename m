Return-Path: <linux-kernel+bounces-558738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17055A5EA37
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0BCB189ADFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 03:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AF378F2B;
	Thu, 13 Mar 2025 03:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="DSXE7eKy"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0247027468
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 03:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741837706; cv=none; b=UsFt4jgFg64l66rAYXPtqygKkBP1Mp+mEw0zIqL9rT2PAscnNatrjarqDLQSb2KBZvVqJSHr3wq4y1t7HHJA97VtWZ//1An+F3yT/zhTGls+JZpKuMh2MllGzsOe+9lyPbMaYXC2eGDZkoYeFA1bllNosqMgYhxZoDBWzaPsHSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741837706; c=relaxed/simple;
	bh=jkl7O9wJtyRG1jQXTjeAhTw/blwrRNX6xZTKK0ziTU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gfb2jDK47FTWrcoFOY6urPB5s63BQ0LmNasEB1aQCtDLbVQAmtW29PYggwqu2JcWX0DDhTbYcpEyyQ8GOnhIWHT4BoOrmS8Rsi6M9Yr/BN0zPWFfGoUkSzRXaoi2pLmdRlVbb4WAnMm73PfTZdoCsNnJpeWYxoQevaWkYudMTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=DSXE7eKy; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22403cbb47fso9979915ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 20:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741837703; x=1742442503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yFkhLOrOugcxeT1NkNYtdDdVlD9vOgxf/q0l13x2PvI=;
        b=DSXE7eKyO9h+52VF0XHxKrDJO7amnkwkmuxMxS1TvCFOoIyX9AxHpZU1wCkCM/a8dP
         f/MnANZKUOdi9F4U7W1UyrO9/LlG6T6cXK1URHIRer+F0REzlrlnILqvif1HMJeP0NSU
         MYc9qTwX04vf76Z6ibr0l3i0/PUWT45Gziq8Ilv4IUpajBXOlfnu+9G86ZDJEnDaAQ6e
         ge2UJTazUHZMx4yVP+8T7m1/JmU/CrmwChUy+TUZjhyUJTLbjLHxB5QdbhQU8zl/nz7T
         IgbahiTpG/zk4sB9W0DQcCLNfl4gNx9yBV3UIVOySrt4g3a4Vny61VamQfbt3FOQm+N4
         1V2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741837703; x=1742442503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yFkhLOrOugcxeT1NkNYtdDdVlD9vOgxf/q0l13x2PvI=;
        b=cNaVkzvoRyXlBZnXPA1HTqINQ6cuxW1L9vjOlkwjMRAxM88dVCHNHvFxCx0yRD1WQv
         6/X+0LQ4S0VddYs8WXntvbdtdH8GgWxI2nXaF52UGkOp206AkREGX1sHFEEX226ai/AL
         mf6+xaNUXRB+xAHTO07EUZvVS1nDgZWjookA6rKe97uoBkK61jmmX4UA0WVvDZ7Tu/rj
         B4xwh2gIv+4Ue05lMKAHAYSPipWLBNFm1iQx/T/C0WGGn9ZN+MsuNUIjSmdLVYaZBnVO
         RDIHcDwedrztJbJxJKcLYBQo1CXH8Kn+92yQCCEE0CXGK2nQstZFwL8eFe49p7IOVb2Y
         Be+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRcdHLG08uiq/gy7NKOQMMxZGecAqcLzM5ojoaWwv3gsY44zJZR2QBXTaKTJ6UaHUeFVCvKjBR1vybuN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysPs6Hu1oVoe7X+FMBWfipk8XnE4nmspC2Y6hC+uB5zHFOZDMW
	4VrDMm4rjglxTZ4NlmfIr3QndIxOiRtBXy2z0vTSG+Iy2EQ/0pWS0TsD2DEPwO9SzmAZXx4ncWX
	E
X-Gm-Gg: ASbGnctjljq9861PRH+gDlNWmqbQ0LlqoZ68O6yvsThoDKzOKpzsD4WQ63kA9DZsiXF
	4WT8fLnGtlPHjIki47deNRM2maQ0WryqStK3Z3mPo2oGID//F16rM9t97KzsSV5yKKnFUUpGHeh
	hTf8O9t+j9Uxc6rPH43eEsTiFxAqYi3t/AaPbTcFYQBbc0AbVuj3XMHIYNBmQ/UKKBjm5TKMTU3
	ZOmUWytZ1yf9PWii5at+ilfNVlxt8YbDtTZf8Ymglvwd69YA8PlUpVb43NmvccSEwDqtB98/1SA
	J4FzhMt7kwc1HgkY7cjrkRaC8HKEYJPGmtwbkQDG9lifEVwI0k32oapoJv0lBXluHtEcEwaBeys
	jzzY1
X-Google-Smtp-Source: AGHT+IHb8R6fInhQdJ0Z0KxYAmZL9TTX8Gbtcci8MLZpk/dPB1qvfzZaK2XFMIZCt5WZe3MmaWfAZQ==
X-Received: by 2002:a17:903:32c5:b0:224:249f:9734 with SMTP id d9443c01a7336-2242887ecd7mr351205205ad.4.1741837703151;
        Wed, 12 Mar 2025 20:48:23 -0700 (PDT)
Received: from n37-069-081.byted.org ([115.190.40.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68aa62csm3590615ad.92.2025.03.12.20.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 20:48:22 -0700 (PDT)
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
To: akpm@linux-foundation.org
Cc: mhocko@suse.com,
	hannes@cmpxchg.org,
	muchun.song@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Zhongkun He <hezhongkun.hzk@bytedance.com>
Subject: [PATCH V1] mm: vmscan: skip the file folios in proactive reclaim if swappiness is MAX
Date: Thu, 13 Mar 2025 11:48:12 +0800
Message-Id: <20250313034812.3910627-1-hezhongkun.hzk@bytedance.com>
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

Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
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


