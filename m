Return-Path: <linux-kernel+bounces-439192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5FF9EAC0F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9551883A97
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC612080D2;
	Tue, 10 Dec 2024 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIoC2v5s"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0211DC9AA
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733822940; cv=none; b=Gv3FJZE02+5Z0w18ytCU2R+7DowssxZB1NO1EIcSjUd7hLYWW6XRbRaJSFbP+o9gPyu9uAjW0de51HfFdONpOhxCA4vI67GQPMIV498KzpKteW4TE0mR6FG9X2ZXyCgDFv/bXRaTcnC6a/IfIyOhXj5sEcS9cEW7djo2X8FKm3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733822940; c=relaxed/simple;
	bh=5jRc6pQ4lH2006E8Jucio0TlsQfCagjTsPiQDza+5vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HWQNlvVP0EBZKmFAoO9XfqnKWvpaJXJlmB15T+dBzbmH/5OFNTGCCNU8pp2C9h/XrGQciHEMdVVQFKitZHpLRZOerERgu2sG8umqEWGKxmaaLDzHVcitE92Qbo8MF/r2FleLyy1fd+23nWLMWHqe0335Z4fxscsH50Cu938khtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIoC2v5s; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725d9f57d90so1938387b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733822939; x=1734427739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3brNrtjgiFvI2dpljuY16w30F6KROwJEev3dmdE/vaQ=;
        b=cIoC2v5s3EFpTs1sr8kRLshn8cLicIKCHke4kMcJmx2K3Atr00p3T7VQHlsc9SqniL
         JRNWbqvF8YXbr+KfOOIIW3fLHWdJ4Z71R6f9uw9lhZ1hTCzCxhAafcG3y1dRUh8KIaEC
         xfrglA2Hh6kGv1Vn84IUlELg8DRza22XVgilOhfxbcNXrmvVke4umhWxXxl2FQ6zdqcw
         vRno/ACe6gnhL9TLM9+fGVKFDm28t6zTdcMewKAfuxqEFTy/qR465okW8Y/CWqTOR3B5
         32OWdIYhg2yBcT/S0FqZr0gI7/VPlR+556Q/BSidPNCpJAkK1ZoMyhjhnaihjLucIhbv
         rj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733822939; x=1734427739;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3brNrtjgiFvI2dpljuY16w30F6KROwJEev3dmdE/vaQ=;
        b=hjPHUTAUfk0CZF1E87xOZ8FWkVsQ8hAQHvl6mUtH9MnRz67+lgreYRIQIjcJiKcvDD
         LoOh0CB+bEgeCNVLA2zR24kLVRTcco8jyfmYJ6L78yUpwwJ0hVDEaneozSQ+IIPFqG53
         iSpVe6oooOQXEXqD/xnIEhlmz243COy8NG3LwTWAYS2GkK7Avk7bxOTwqV4Cn7wPfOZp
         pdrvd54Aq9hey4F/084JgzEOLGJdl4qcPRJqW3/TnONnBpUJzLfK8OLkZ0yK+ivJzHte
         RfM4RnOqhcBQx8NwwZtQ94vrvS9u+FjECvXdfH7Vqa/hvhbTJLuuD6gxtUIQm0+YrQpK
         t9ZA==
X-Forwarded-Encrypted: i=1; AJvYcCW4DDVi1cVR6i/iZnZ299pJnvEocOAIcYjE1EvgScgF3LOib6FlP7cfEYYM1kbCWQNn9RPiNT1v29w5tQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoInPRytGxPsN0cSXMBJYZa98qu54vabWWJQlZlXJTpGjLBneL
	QfnXU6qSVa4cNBAKgrFH2iIXQRigsHyCZmk+Q+RL1b8k4H7dAXqS
X-Gm-Gg: ASbGncuhrKkIbGXA3kLS0kHsyIs2Wlvb3cv3pDxpJ16GHjcjuezNFyDlori6zQAoH2/
	+lbUAJDhmtw5CmrgAvjKkx6j8m5jvdGv/fYI408KvN3hcJmNZoYad4b6uvHj/AF6ErYj+AeNkcP
	lGfQpsZd4OMv78sRAbN8TekWKSWE209L1TFu+Rqa7BfKtgnqbAtDX5lkHK3iaQFG98ru98cUUDv
	W9VFmS22YLwQ0ll4N3UyHiZpHaSkfUDADYcU9yNT1CkOrQfgC5RuWrxKAWxsoT9eV7zkGlSr5vx
	ousvmlZF
X-Google-Smtp-Source: AGHT+IERxmWetmXJHwNhsuCX8qmmQME1SODknBN8SZsyNFWK4dOwc3xcBmWd/o7//0CA+zx7t9zMBw==
X-Received: by 2002:a05:6a21:1518:b0:1e1:b8bf:8e80 with SMTP id adf61e73a8af0-1e1b8bf918amr2204728637.41.1733822938506;
        Tue, 10 Dec 2024 01:28:58 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([43.132.141.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd1568f26asm8750095a12.9.2024.12.10.01.28.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Dec 2024 01:28:58 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	"Huang, Ying" <ying.huang@linux.alibaba.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Barry Song <baohua@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 0/3] mm/swap_cgroup: remove global swap cgroup lock
Date: Tue, 10 Dec 2024 17:28:02 +0800
Message-ID: <20241210092805.87281-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.1
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

This series removes the global swap cgroup lock. The critical section of
this lock is very short but it's still a bottle neck for mass parallel
swap workloads.

Up to 10% performance gain for tmpfs build kernel test on a
48c96t system, and no regression for other cases:

Testing using 64G brd and build with build kernel with make -j96 in 1.5G
memory cgroup using 4k folios showed below improvement (10 test run):

Before this series:
Sys time: 10809.46 (stdev 80.831491)
Real time: 171.41 (stdev 1.239894)

After this commit:
Sys time: 9621.26 (stdev 34.620000), -10.42%
Real time: 160.00 (stdev 0.497814), -6.57%

With 64k folios and 2G memcg:
Before this series:
Sys time: 8231.99 (stdev 30.030994)
Real time: 143.57 (stdev 0.577394)

After this commit:
Sys time: 7403.47 (stdev 6.270000), -10.06%
Real time: 135.18 (stdev 0.605000), -5.84%

Sequential swapout of 8G 64k zero folios (24 test run):
Before this series:
5461409.12 us (stdev 183957.827084)

After this commit:
5420447.26 us (stdev 196419.240317)

Sequential swapin of 8G 4k zero folios (24 test run):
Before this series:
19736958.916667 us (stdev 189027.246676)

After this commit:
19662182.629630 us (stdev 172717.640614)

V1: https://lore.kernel.org/linux-mm/20241202184154.19321-1-ryncsn@gmail.com/
Updates:
- Collect Review and Ack.
- Use bit shift instead of a mixed usage of short and atomic for
  emulating 2 byte xchg [Chris Li]
- Merge patch 3 into patch 4 for simplicity [Roman Gushchin].
- Drop call of mem_cgroup_disabled instead in patch 1, also fix bot
  build error [Yosry Ahmed]
- Wrap the access of the atomic_t map with helpers properly, so the
  emulation can be dropped to use native 2 byte xchg once available.

Kairui Song (3):
  mm, memcontrol: avoid duplicated memcg enable check
  mm/swap_cgroup: remove swap_cgroup_cmpxchg
  mm, swap_cgroup: remove global swap cgroup lock

 include/linux/swap_cgroup.h |  2 -
 mm/memcontrol.c             |  2 +-
 mm/swap_cgroup.c            | 96 ++++++++++++++++---------------------
 3 files changed, 43 insertions(+), 57 deletions(-)

-- 
2.47.1


