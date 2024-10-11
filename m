Return-Path: <linux-kernel+bounces-361561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899C899A9C3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1684E1F22AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 17:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805711BD519;
	Fri, 11 Oct 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbbY/Yng"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798071974EA
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728667208; cv=none; b=cxzEMGf4MCRCD2WCyG3YWmFPRh+Ni6mFYMPuVeZj9W8EmHwcZh7G6q0imrOlAeXUQApAslY1HHDhwwMKT71NFfP/46KKcQqXO+6OLSWF4kODsAdxGx4RcHnW2ZTlNidbg0dSeZC5+DcDKlil8trT29pgaHksSKZkCV5KqU4FXcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728667208; c=relaxed/simple;
	bh=ZK/djK/2RWS5PMWlAqdPIoowD3Slmk7IIKdZjfbRRlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C3AhdWsO1pnKJv/4gt2vZ43DSXOEHuBzWdJby/6Z0La6kreENmwV92CchkAx3iDLN5fPkHfajQAGdYWrAR9U+4ucK35hou4OUox78att98ChVeeaFg6E1P5VzQILAS5KLOgLX58xvVmvjQ8CBiBSbKR12Tw4FcYCUxdoiQ1heKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbbY/Yng; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c9978a221so16298415ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728667207; x=1729272007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YQYtUCIkke5YuOxMFaq1by907wGKV3qT5PaV1tICSB4=;
        b=hbbY/YngENUqy/FSYEbxhARtPF8I7gXl/mittco1eG/+f8VdGuponf5f+/7UWxcj2B
         PL13pHQLPYvrnpgB8rVjfR01LZFbOpUhowIqkMMHbBrvPxucQajO741tk//5Duqiocn1
         Bb4oR239Y+YOrtn8Sh1mT2xvUBHWk95AWHvtfFhGmaa+xJdIE25hD9bT6mLMbF0wb0zJ
         Yw3Uc1LQM9kkcwMU4zvYbIZdPvaItfHBJ9U045Y8sr3V/hdiTNMEO0OPjSRScXhESO8a
         Wbwta5cQAwnA0SiOn8ovdm6cIbHdUhSWWOou7eFLznW1m6juM7wslgJZu3rz+OojCNCO
         FxnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728667207; x=1729272007;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YQYtUCIkke5YuOxMFaq1by907wGKV3qT5PaV1tICSB4=;
        b=r5McPEFUDjVS3upbsG4Dewq0EmN4bD0qsbdffhsTh8tPajlZ63shdDLfeDiU932wIF
         h6Yb7JUA8ZfIInv/in9SyXJClojlXK4fuRZsZtWTBocwnYd175eiLkXkbVhV0mgnYNX9
         0yW5vGMg+q2FKHT9Hsh/chzC32o4uLmS8INfVDQOkmpahpMyR070i0PTxjBwiXBULaC4
         uPTOVlCw2VoQwDseBWKz+/HnAoX1kvTTMWJcp1o187QS+tnybqfBYhy5FVlNiAkUOcgW
         dvphC8ZSV1G95zzkUc1ToE3cjFZJyTY5KMI5XJPTBlLA9ZwLYZSlh723Ddlrf6EklP1o
         QPxg==
X-Forwarded-Encrypted: i=1; AJvYcCXyQYr9GftMXbVocrNoAYDWAOmo4+Ebxt67539zIt+VdYp1pno7UcGYcMrmnUHWxg2gZd4ALxwRH1tkZD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTIbYCsaFMEd6tW3gw620cHyqnsoLP2kmvc/kysQ3RMSL+yLuU
	vJYm35fxUTnO8nSOvYyhIojU2bAoqz8dq36epqG8SmTZ0MvWU+Ky
X-Google-Smtp-Source: AGHT+IHBsdoU7oMghfp0sELWyCGsJMkKemlLy3DN/8QD36ffs0C+vL7gZM9PkX65oj3sRxJ1slhUCw==
X-Received: by 2002:a17:902:e845:b0:20c:7409:bd00 with SMTP id d9443c01a7336-20ca1429a4cmr50379765ad.5.1728667206624;
        Fri, 11 Oct 2024 10:20:06 -0700 (PDT)
Received: from KASONG-MC4.tencent.com ([106.37.120.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8c348d6bsm25325705ad.287.2024.10.11.10.20.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 11 Oct 2024 10:20:06 -0700 (PDT)
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
Subject: [PATCH] mm/zswap: avoid touching XArray for unnecessary invalidation
Date: Sat, 12 Oct 2024 01:19:50 +0800
Message-ID: <20241011171950.62684-1-ryncsn@gmail.com>
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

zswap_invalidation simply calls xa_erase, which acquires the Xarray
lock first, then does a look up. This has a higher overhead even if
zswap is not used or the tree is empty.

So instead, do a very lightweight xa_empty check first, if there is
nothing to erase, don't touch the lock or the tree.

Using xa_empty rather than zswap_never_enabled is more helpful as it
cover both case where zswap wes never used or the particular range
doesn't have any zswap entry. And it's safe as the swap slot should
be currently pinned by caller with HAS_CACHE.

Sequential SWAP in/out tests with zswap disabled showed a minor
performance gain, SWAP in of zero page with zswap enabled also
showed a performance gain. (swapout is basically unchanged so
only test one case):

Swapout of 2G zero page using brd as SWAP, zswap disabled
(total time, 4 testrun, +0.1%):
Before: 1705013 us 1703119 us 1704335 us 1705848 us.
After:  1703579 us 1710640 us 1703625 us 1708699 us.

Swapin of 2G zero page using brd as SWAP, zswap disabled
(total time, 4 testrun, -3.5%):
Before: 1912312 us 1915692 us 1905837 us 1912706 us.
After:  1845354 us 1849691 us 1845868 us 1841828 us.

Swapin of 2G zero page using brd as SWAP, zswap enabled
(total time, 4 testrun, -3.3%):
Before: 1897994 us 1894681 us 1899982 us 1898333 us
After:  1835894 us 1834113 us 1832047 us 1833125 us

Swapin of 2G random page using brd as SWAP, zswap enabled
(total time, 4 testrun, -0.1%):
Before: 4519747 us 4431078 us 4430185 us 4439999 us
After:  4492176 us 4437796 us 4434612 us 4434289 us

And the performance is very slightly better or unchanged for
build kernel test with zswap enabled or disabled.

Build Linux Kernel with defconfig and -j32 in 1G memory cgroup,
using brd SWAP, zswap disabled (sys time in seconds, 6 testrun, -0.1%):
Before: 1648.83 1653.52 1666.34 1665.95 1663.06 1656.67
After:  1651.36 1661.89 1645.70 1657.45 1662.07 1652.83

Build Linux Kernel with defconfig and -j32 in 2G memory cgroup,
using brd SWAP zswap enabled (sys time in seconds, 6 testrun, -0.3%):
Before: 1240.25 1254.06 1246.77 1265.92 1244.23 1227.74
After:  1226.41 1218.21 1249.12 1249.13 1244.39 1233.01

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/zswap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/zswap.c b/mm/zswap.c
index 7f00cc918e7c..f6316b66fb23 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1641,6 +1641,9 @@ void zswap_invalidate(swp_entry_t swp)
 	struct xarray *tree = swap_zswap_tree(swp);
 	struct zswap_entry *entry;
 
+	if (xa_empty(tree))
+		return;
+
 	entry = xa_erase(tree, offset);
 	if (entry)
 		zswap_entry_free(entry);
-- 
2.47.0


