Return-Path: <linux-kernel+bounces-316143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D484E96CBC3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A7571F27798
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1EA14C7D;
	Thu,  5 Sep 2024 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0zyGFcg2"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0C621
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 00:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496308; cv=none; b=iRq7aac78nXaexnzVb4bwcdfQiyhK5MGMoiwn6vYMjKodf07atdJ+p4oouYAL2h5vNTmIgCM9cPFP1c8y3yvL2E2ie+BDZxLexQXy7r2/NbwJto9L8tttGIcUz2wd/+sedQFFwbeWKQmY1JUnClSaL+Wg+/lb7cnDL0DeC5/jog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496308; c=relaxed/simple;
	bh=dZTE30XsT2qtq5FQUXzNfU44xsB9Bt9PuIDD2SYkgNk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ihc1Am7/PMsyMf7Cks4kdQo4hRw82lhWP4Brw3DSPPTadWGjMOjBEYW4kAE4TlMuiYgqyB5PsoRc8D0b5nBXXbyKkoWSTsgGcxSmcezFR/QmNtTBJp2mUd+MGVlNw8Hjzf/mnEToAQgXre4TntLimueGKW5MK9X+vxRz6pwZ+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0zyGFcg2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-20206086d92so2927865ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 17:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725496306; x=1726101106; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dCiOKpOFqlD6C2iCSSs7Lyoq3x0IlMR0Jw1jQQmJ13E=;
        b=0zyGFcg2TZ13LdNPT04Eb5mjJBWxR6VmvT162m+aKW9FKuJV51dGZJqjiqO0a3naPC
         2LZK8THd9fz75zrpJxvZe0kXrwwD0g08ZXHW/bxWbdpH6bYce6Ix4k4R6ChgtepETglN
         sKYx9sE1EhM1CHGw6N3zzSK5vwSiZ5jxVlNxiUFbH/Ryca2GbA+wlXB28+NBUj1l/2Ii
         4XoJ3VlxPr5s+dTc4HqsLZTEuZHnIVWHntgnZo8Rdy1EZGlwmA87hbiz6UCLlDS7mupi
         3teVE16QOhjWVBJvYh670mEl+kqjdVIPtfoDt9/Deg7Cj1ApoUYRq3uBC4NcLkvpjAPu
         vhKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725496306; x=1726101106;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dCiOKpOFqlD6C2iCSSs7Lyoq3x0IlMR0Jw1jQQmJ13E=;
        b=QINlFfOJZjuxiwY/zjNgfP9ZAeHnDqh7EEo+CyTwlI6oaQORbIf63Rc27rl5SjLaDa
         FtHACzJMzQdyetVVoUFwjZrh78+DWUB42+R+xVDtzEy6iyk1YjRCXsUKv0vnVBrYqQQK
         8QXBAPrCswGL9MIC2AbZec0G/Q5x5FWFmyeZ4sCg0iJXmI0Paf3hxmYKO9SKjvWkxdc0
         ng5wGwBetIjVI71vSczJiVyhYe63onh8A6sK5oFEOJ02F/PHNSCRnwHhJkQWdn77ivGt
         u8d7E13kUZEBLSvj3iZUbgvtf5czzb16WhevmNYR0GEV3DXeyz0uCw5OgKUXJHk2fbBB
         OLlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfoopsk/3/rYrU6GRDz7amjUQ+fIIY0IHrQoJB5bsFK2dvBF3LBMYPiZ6rTeWP2sv4RJP4FMEzUgOoo74=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+jt/Vf1PEPl4DIfazI5TRC88K93pILKGbP32b21GuVMTODryr
	aK1q7prJMuk+vzFRBe9Chk4WC31ZQ5jYM4Pw8f059JuU49A6xz4dqyZuOp3jvm/s5NtnnWq3kv3
	+lfC8hHY8gw==
X-Google-Smtp-Source: AGHT+IHGHiTuciDfvv/IhVf91ROgyhWylO6eINXSVTS1ZmC1WL6d+mazuFmoRnQz+5tklBVZyYGtt0yYpGER1A==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a17:902:e84b:b0:205:5550:f34f with SMTP
 id d9443c01a7336-2055550ff57mr10546555ad.6.1725496306005; Wed, 04 Sep 2024
 17:31:46 -0700 (PDT)
Date: Thu,  5 Sep 2024 00:30:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905003058.1859929-1-kinseyho@google.com>
Subject: [PATCH mm-unstable v4 0/5] Improve mem_cgroup_iter()
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	"T . J . Mercier" <tjmercier@google.com>, Hugh Dickins <hughd@google.com>, Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

Incremental cgroup iteration is being used again [1]. This patchset
improves the reliability of mem_cgroup_iter(). It also improves
simplicity and code readability.

[1] https://lore.kernel.org/20240514202641.2821494-1-hannes@cmpxchg.org/
---
v4: Fixed memcg restart bug reported by hughd in v3, patch 4/5
v3: https://lore.kernel.org/20240827230753.2073580-1-kinseyho@google.com/
Removed __rcu tag from patch 2/5 which removes the need for
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
 mm/memcontrol.c             | 84 ++++++++++++++++---------------------
 4 files changed, 51 insertions(+), 59 deletions(-)

-- 
2.46.0.469.g59c65b2a67-goog


