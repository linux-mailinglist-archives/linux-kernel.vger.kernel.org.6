Return-Path: <linux-kernel+bounces-372307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC009A46F4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 21:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F35681F228A4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F86204026;
	Fri, 18 Oct 2024 19:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddpDHj7U"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F061802AB
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729279555; cv=none; b=qgLIqp79UT5EVTpHZj8jajfCim/jRxxBHRLskMCfHgkv/4zt5gRjfNiyFg+fqpqVafXxNeeApY8aEh+DmRTncxxtSvvZG0nsDPOJL3esoeYAkkxYptznFZwN/na+uDxFFYonexyKoDOERxbiZ2MhXR7hvP190qRUk0yvWNAzcCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729279555; c=relaxed/simple;
	bh=5VzPu4NTtS6U1JNq81nkr2afoaof/qk9rfeVj6RRBZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ak0duCQE0Pei5cqGJiQoOE/0wuKC2N9Q6vI1XfzTtx+6dBOZik6E8u0ShP0rbL/tk29bV1mUCoN4KqjQfOUmJoOInFLKXdiXI/yzrKnqbIom70p2Q4cObOGvhMbfjeLUhgQSEgy4edE3XWP2va/Nls6UMPYKkJZDwyBFsxlM3bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddpDHj7U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20ca7fc4484so18287835ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729279553; x=1729884353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r0anSA7wmrimpqHZPAHtNpFmhlM7GFXCjTHh2HcmL4E=;
        b=ddpDHj7UT1qDbWig79jxKbAsckFqCoeeLsprwjyAfr+KeWman8/XUWC06YeLE7lKkC
         9sSP00HsxmiXDDWmEx2ChyhWlMcUBYfdMGXbe+DqE6vScnHIgzWm0R/i71xjc+mlcNLc
         4qihtPHAHPK8ueN4DE7uI+wVlveyJC3GC0vzPV1UNmX7ICGhkAkgfTLCKEzay02mGUOp
         iK16xAa7QC0rqJ4KdwQqQNadDHEM5tVRNMQwt2Yaqu8Uvhqq9H4asoVaAyUyRZXKB78v
         D90U5QyEBns620Sfv3fleDSbZo8bMnNrPqnYU9I5/fI8bfZZbBVzujcRfEDbQPAn2eX0
         HGDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729279553; x=1729884353;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0anSA7wmrimpqHZPAHtNpFmhlM7GFXCjTHh2HcmL4E=;
        b=ELD9wCpBlL2pJb9YTs+t/phZqFsXYxhdJHNhjgmqeoxhmBY5kmvTZNvPNsJnhXex9S
         nf7hD6ZnwbapjWZg6JG7NWwVco1G7RP2Jw1tnS0zzOydoxa8g8CwzxoBBN0c9c15w5sL
         2c9iq8lj8GG6mlnIV0co2aMzrXUA6+OUna8kUGiGX61hZfRl2Ue1w2GVnnbnBTxYiARw
         KfR7WIpubweXmPwBnUdPH0UUAORGk7kBBOrwp1rzbeuu8y2Qce9XUK0jI8H6S0f2A6q2
         Tmu6qGqR+JnqAbv7Tm1/eLFAN1INN+u7zsEIs/h9Ru0I2BoFX/InpniB4VaBd3W9jXM1
         eVxg==
X-Forwarded-Encrypted: i=1; AJvYcCUCDRDkN1126mOeFANU79CypJP9laH6S9vS2fMM8lej4nFeUOCkb91541M56ao2TNACiF3j5RtoL3SbX34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2th3p5H6lQFvDQf2M28FZd47ZpOuyiX4m/5mnQqIoPZAth9th
	G+49Qpa0JjrqvDT91mstBJyRwGImf9UzaehZHI0wD/uLIegIV2IB
X-Google-Smtp-Source: AGHT+IH+gcFUNvQJGdCfiZUKmlscDlPE7FoZXrFol71E+UA5WwDV5CwQUWLGvQyUta2qroIk60kOWw==
X-Received: by 2002:a17:902:f552:b0:20b:7ec0:ee3e with SMTP id d9443c01a7336-20e5a79f505mr42301125ad.11.1729279552573;
        Fri, 18 Oct 2024 12:25:52 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([115.171.40.120])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e5a747769sm16284015ad.74.2024.10.18.12.25.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 18 Oct 2024 12:25:52 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH] mm, zswap: don't touch the XArray lock if there is no entry to free
Date: Sat, 19 Oct 2024 03:25:25 +0800
Message-ID: <20241018192525.95862-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

zswap_invalidation now already avoids touching the XArray if the whole
tree is empty, which is mostly beneficial only when zswap is disabled.
This commit takes it further by optimizing the case where zswap is
enabled.

To reduce lock overhead, we load the XArray value locklessly first
and keep the walk state. Only perform a locked erase if a entry is
found, thereby minimizing unnecessary XArray lock acquisitions.

Below tests are done with a 4G brd SWAP device with BLK_FEAT_SYNCHRONOUS
flag dropped to simulate fast SSD device, with zswap enabled and on a 32
core system:

Swapin of 4G mixed zero and 0x1 filled pages (avg of 12 test run):
Before:         After (-1.6%):
2315237 us      2277721 us

Swapin of 2G 0x1 filled pages (avg of 24 test run):
Before:         After (-0.5%):
4623561 us      4600406 us

Build linux kernel test with 2G memory cgroup limit (avg of 12 test
run, make -j32):
Before:         After (-0.2%):
1334.35s        1331.63s

Swapin of 2G 0x1 filled pages, but zswap disabled (avg of 24 test run):
Before:         After (+0.0%):
2513837 us      2514437 us

zswap enabled tests are a little bit faster, zswap disabled case are
identical.

Suggested-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Kairui Song <kasong@tencent.com>

---

A previous patch [1] has been Acked and now in mm-unstable, that is a
valid optimization on its own. This patch is Suggested-by Yosry during
discussion. This patch is for a bit different cases (zswap disabled vs
zswap enabled), so instead of a V2, I sent this as a incremental
optimization and also tested it a little bit differently.

Link:
https://lore.kernel.org/linux-mm/20241011171950.62684-1-ryncsn@gmail.com/ [1]

 mm/zswap.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index f6316b66fb23..a5ba80ac8861 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1641,12 +1641,21 @@ void zswap_invalidate(swp_entry_t swp)
 	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
 
+	XA_STATE(xas, tree, offset);
+
 	if (xa_empty(tree))
 		return;
 
-	entry = xa_erase(tree, offset);
-	if (entry)
+	rcu_read_lock();
+	entry = xas_load(&xas);
+	if (entry) {
+		xas_lock(&xas);
+		WARN_ON_ONCE(xas_reload(&xas) != entry);
+		xas_store(&xas, NULL);
+		xas_unlock(&xas);
 		zswap_entry_free(entry);
+	}
+	rcu_read_unlock();
 }
 
 int zswap_swapon(int type, unsigned long nr_pages)
-- 
2.47.0


