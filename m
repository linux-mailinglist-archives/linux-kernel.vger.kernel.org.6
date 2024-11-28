Return-Path: <linux-kernel+bounces-425058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E3C9DBCF5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 21:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96931647F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 20:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF611C32E5;
	Thu, 28 Nov 2024 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kGBruBCr"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08A71C2DA2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732826414; cv=none; b=Lr/YDXbu+lKNClNOgvPbGBPVN83QUIFp/l8WtfD6zakmtrAK0tLjEJRvwxcaWimXP5p7TdUmlGB7q27REY2uTs7p6WIUH03vLcWJrh66Qv47GE0lbsTMhapOV+SYndhoctdCWBcM5yeEw2N+6WaqJgHtDTlkZoSz+3b0uu0FevM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732826414; c=relaxed/simple;
	bh=j3gU30II2/wJHQtwPH7ZDMKKCj7DiVdiela1aCY84jE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fYvBPQu/oR8GZaIEBnnDda9WzDwrhHcsMhFkI+MRsNFMFVcnhUXVnvlkMIuD52UU/7kO/ohbrPMQSuWwI6Ll8yhLObu2JbEAISXk8VkyXWZqcRs7gBOKQkpeHolnsnoae1Bl26F7EwHgwpHtm+OiQxY8fjaUQIq9GmP/+pOMZpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kGBruBCr; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jsperbeck.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2152b7d22caso5660765ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732826412; x=1733431212; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pGk8bO659Gdwu4si5LtMHbyU77sFm+9rlypvNi4hI1U=;
        b=kGBruBCrers14qF0vK7hBqKtjAhM8f1SPGZbWGLWfd6lQelzzovQhV7TzIl1gRS+zp
         kMfXHmDdyuOsGP7sQm/MKi/uiR6Pxi+W54wgZaazDPAYB/djju2WCIAd43PKdYd699l0
         w+/tsuI3kP6zsJxCyvnRDs3vxNw78dVN7TIPw3LfHD1Ci3j5fcv3baXn/DT4EvhZgcuK
         P7mEfKWVnmnFwy2sAaZ93pdTqUc5iaTQH82zqk+55kRPPDGApuzKJrTipUx5n+EQ2j+t
         9nAWeuo/yxntVYiXUNbQ2dCj+nOEEQf+FXA6LNMEMRGIYxoxAeQHQAjpMi3gh+w6Ax6S
         8xAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732826412; x=1733431212;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pGk8bO659Gdwu4si5LtMHbyU77sFm+9rlypvNi4hI1U=;
        b=foSzbLzBduQ9YhpgHFua/s0uE6biY0ktBxnbVEgveqy4oOokFwQqLN4zOn0htGmgvG
         r/5dmVYfuLtIPJVuJ0nmsXL4ZkG+M7xYBX+3AfSaxQwo9jv9u8iN2dJRq+2NixgibwUH
         sowuTTkzBu69veSWlPFt0HdOaLHedRURWMhV6aTeEY8kqg3x6RKTFVShFZaFi3bHpZI4
         W8eeWIjqp07csiTcWswm5YvNG+PT2/WWZaOdV5uQ+Y9oVxG8Md09HKq34Rs5f6ihlc3G
         rgX4rpc1+mzS3gWpwePteiihy1qi3FSL2CJ1w8GOolvZU4kEfssFqfN/OwjiJbizwgXW
         Lrkg==
X-Forwarded-Encrypted: i=1; AJvYcCWnE7gYT6t2OL6JvwW5fz9bVAK3Jiry6ObMbm+hss//zBxlDYG3qeIlE0Cc/hIP59xYfBXK1jih0m9Egy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNT7VY8uCmTksu6EBvaF96eLdwojSjmdqqhglyi7I80atPcWZ/
	qmUc/wNf98jM58utQQOi2kW1gBgSl9CAFhXvTTDvZWoVzqxA1Xa+AyMCUDi27J41XOWbd9kQQJb
	2Bt4YCtffAE1Qyg==
X-Google-Smtp-Source: AGHT+IFDox9vopnXYUEG8CG2I5eMAAIE/yxMUeakJhOILWCxtW68hh+uiFnnogv2HA6ltR7OQxaASLO5KmJUslU=
X-Received: from plxe8.prod.google.com ([2002:a17:902:ef48:b0:212:2d10:e55])
 (user=jsperbeck job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:dacf:b0:211:fb9c:b1ce with SMTP id d9443c01a7336-215010967dfmr104811145ad.17.1732826412132;
 Thu, 28 Nov 2024 12:40:12 -0800 (PST)
Date: Thu, 28 Nov 2024 12:39:59 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241128203959.726527-1-jsperbeck@google.com>
Subject: [PATCH] mm: memcg: declare do_memsw_account inline
From: John Sperbeck <jsperbeck@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, John Sperbeck <jsperbeck@google.com>
Content-Type: text/plain; charset="UTF-8"

In commit 66d60c428b23 ("mm: memcg: move legacy memcg event code
into memcontrol-v1.c"), the static do_memsw_account() function was
moved from a .c file to a .h file.  Unfortunately, the traditional
inline keyword wasn't added.  If a file (e.g., a unit test) includes
the .h file, but doesn't refer to do_memsw_account(), it will get a
warning like:

mm/memcontrol-v1.h:41:13: warning: unused function 'do_memsw_account' [-Wunused-function]
   41 | static bool do_memsw_account(void)
      |             ^~~~~~~~~~~~~~~~

Fixes: 66d60c428b23 ("mm: memcg: move legacy memcg event code into memcontrol-v1.c")
Signed-off-by: John Sperbeck <jsperbeck@google.com>
---
 mm/memcontrol-v1.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
index 0e3b82951d91..144d71b65907 100644
--- a/mm/memcontrol-v1.h
+++ b/mm/memcontrol-v1.h
@@ -38,7 +38,7 @@ void mem_cgroup_id_put_many(struct mem_cgroup *memcg, unsigned int n);
 	     iter = mem_cgroup_iter(NULL, iter, NULL))
 
 /* Whether legacy memory+swap accounting is active */
-static bool do_memsw_account(void)
+static inline bool do_memsw_account(void)
 {
 	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
 }
-- 
2.47.0.338.g60cca15819-goog


