Return-Path: <linux-kernel+bounces-304100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 459CC961A3E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783171C22DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74CC1D4179;
	Tue, 27 Aug 2024 23:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0TBbrvcL"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940D784A2F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800300; cv=none; b=Ii958PnCZv4fpRwIpdQEwKInhwsUQ98+7RJOt6rKkpDwUs/Kk5OHt41nn9nd1kQICqPGwbqPdwT2scRgi9CUJ2RHz05D+0x7yEpwh6fT0m4QhXhmBdLGymiUjBboXkHxPHBkAu/nmQtyWCOTvlUAKTl+rT12IAAAKno3Djzhywg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800300; c=relaxed/simple;
	bh=b819xJzDCg1+dk7jllpcdrwtTiyQMm4H+rcQN4p0pz0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fe1JENFx7oMsDQjniwZejbU+Ne6NdN+imcnlP/uyNYzVKyadNRTtVTIs9+6dol7WuTiDNDrErSKZ0/3UrBIMuKrNqzZ3u/bZRCX8FMn64dbEV4OdcTU191brLCy/1YGNdnLxM3BURe0tS2E408RKIn+tPY8+lS9AC+cbgiUainw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0TBbrvcL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6c3982a0c65so115910747b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724800297; x=1725405097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JRXP1C0L9voxT40sWvjxPogEtoEBvjhm/X4/q2n2W9c=;
        b=0TBbrvcLgOjCAtLQv8Qz4Ofg/uAgZXrl38JqWxA40eoX4ZbwnPC1D1grE9fnjgVKzP
         rMu2s2nqkPGWihNJKSZ0WS2cDXhBedJfOCrc0XsALCvRVbsMh2Xcsaxub96HApa6RBrC
         BMWj3OdUBmIaAGX1Jb4XzTIDihQq5GFtlmMX1IJ2AuftOJCQSQqXZ8CtxTW4nVzOohGF
         ltbf9hqhCwKtoTYG/c1HbkR42AhTB11qRz4d7buhfxyQiVdZHPaeZq6lPSvWf7hF/iwP
         O8lzZ0lz8FYkoyUnKjK5Ix9AotM2620Pg1OmarspWaxn3WGfVTM/OqrQtS4PkdmF1oLY
         9vAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800297; x=1725405097;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRXP1C0L9voxT40sWvjxPogEtoEBvjhm/X4/q2n2W9c=;
        b=uyiRpmji0+xUnonGY4WPRzq2q+PnuO9p3wwEgu7qW+TYI8kgA8xyL2PqUMDaLtFQ1r
         upGmh3iP4ZlZ4vci/TqCA3dFWbJy+nNXfHUXX18Chpsjhgd3lPx+/HhvzLrAyHtPQeh8
         tY3/OqIE5aH/An57qc+CTEUq9ixXXesnHMY1QSpMWlq9kx0H/TsrGS6b9fcjyhzF4flU
         f5GKxM2Ba40H8cTtwrG1ayzoT3wGvFdEpNOI6CPcqR3Q65UQLBZ0A4xqBVRLfuM4nL70
         fz+ABmby1rkVxfQ/T5+pCzQ0a9bba+6N+Cr4A1GgEG1FcHIuUie/aNtZvdx/rIOjpeNj
         cHEQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9NFctlzblJvSqwYWEtethzHlwKSuY+YUuDHXJrCcyYBPt47/neaUx6lc4ZmCcMPkW8qrN1tR20ulNiIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziI2cSr8Hc6/hwVAIrMyZaNIg0BQFT8JDVLi0c/BULYX193gjG
	/1Q5ANnRFT8oLYjhXxGXMO2CkcOfLPoM7lQYuSuU4xWHS0bspvIGdqFmggTAYB45dG3a1Gl5R3T
	XGlh+fzdd9A==
X-Google-Smtp-Source: AGHT+IGP8ZXcqFy3ObKj9gE3VPxOyLGlu672j0UH7tOda9KMrjA/lA/qb29hd5HzRIX/vZ1Z+4FIf+zXIg37dw==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:690c:6008:b0:62c:f6fd:5401 with SMTP
 id 00721157ae682-6d171a7c46dmr807b3.6.1724800297538; Tue, 27 Aug 2024
 16:11:37 -0700 (PDT)
Date: Tue, 27 Aug 2024 23:07:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827230753.2073580-1-kinseyho@google.com>
Subject: [PATCH mm-unstable v3 0/5] Improve mem_cgroup_iter()
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

Incremental cgroup iteration is being used again [1]. This patchset
improves the reliability of mem_cgroup_iter(). It also improves
simplicity and code readability.

[1] https://lore.kernel.org/20240514202641.2821494-1-hannes@cmpxchg.org/
---
v3: Removed __rcu tag from patch 2/5 which removes the need for
rcu_dereference(). This helps readability.
v2: https://lore.kernel.org/20240813204716.842811-1-kinseyho@google.com/
Add patch to clarify css sibling linkage is RCU protected. The
kernel build bot RCU sparse error from v1 has been ignored.
v1: https://lore.kernel.org/20240724190214.1108049-1-kinseyho@google.com/

Kinsey Ho (5):
  cgroup: clarify css sibling linkage is protected by cgroup_mutex or
    RCU
  mm: don't hold css->refcnt during traversal
  mm: increment gen # before restarting traversal
  mm: restart if multiple traversals raced
  mm: clean up mem_cgroup_iter()

 include/linux/cgroup-defs.h |  6 ++-
 include/linux/memcontrol.h  |  4 +-
 kernel/cgroup/cgroup.c      | 16 +++----
 mm/memcontrol.c             | 84 +++++++++++++++----------------------
 4 files changed, 50 insertions(+), 60 deletions(-)

-- 
2.46.0.295.g3b9ea8a38a-goog


