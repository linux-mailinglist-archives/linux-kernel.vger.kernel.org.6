Return-Path: <linux-kernel+bounces-261424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9151393B723
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C22D51C23AC9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE1A16C686;
	Wed, 24 Jul 2024 19:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qIXZx/sC"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EAA16A95E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847742; cv=none; b=QY/tQXFFF07zrwKlhGJ7IWrRL0XdTggbd23eb1wAmEMuENsdKz9l4e3s5Sp+HyD4zVr9EAFzy1gekRQ3c7zN290m7bIlqjeuJhA09A5hajrHZgbfFqGSrZJK3tUwN4nnMrT6964SNcasXMOqOPzH15CcSk/iipt7Ci4V/SL7udw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847742; c=relaxed/simple;
	bh=dnIpnYFNL7tcZIOMfeqJiwj7BfmA8twPI/chQqFF0z0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bkEzVhtyTgTq3ymwlQyemQAs0KDZGyj+jJpl+oZUj65OSrxEluZqkKa9eo1q5yk7AEYrLD7A2P1vnxhc21RjW9v/3bHKHQ14Rqppy4i0WCR9muL9L6Fni1hly0I7vYEQWu3dicX1hi02DJLiPhBZiHKs1e/BJkcATGPaQYUlGh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qIXZx/sC; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7908626a4a6so1129814a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721847740; x=1722452540; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iLDZhQ0id4uDXJarhBRTOmxWLKOk3mwU62F8HwEfdow=;
        b=qIXZx/sCrPq2bQDUPrsl7BdTS28VE3ZfmFF1KDt3gnTIg8EVVTy41oCGqKV93s1gqK
         M2DM/EJnsK4kU4rlq7qnkiywnl7l3xwnZTK7PgSkygXfEJSTME5FE+kCmwjkYwr81WbK
         aChG5D+R/ti4ajsha7PwlOn5r0qlQ0+PnMbCuVLAt5FZVLwI62AHcZUq3poob/nd5rqU
         31wpGct5x8aWXT6+tfqdZQKwARa3LxmdI4fSMRzkA1jEEg3fouW3bBmYRZtP1dfpQ9Ue
         Kl9YnNf/RvN37rar8jFVBLuUNLZI+YzYP+8GEko9wlmGZnsQrTkHkif6aufEAubvEXq7
         k7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721847740; x=1722452540;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iLDZhQ0id4uDXJarhBRTOmxWLKOk3mwU62F8HwEfdow=;
        b=nYxaQpdkkEBueROQfSLiNPAPs1fH0zvChnZyfk7Y5TDPpp3UtPYQVXupy8iFQ1ZFQM
         5gVimbDxUJ2RpI+ZeqQpCv7ghn8opM63l59MBc01dnzG/1a0hMGPfyjYfAoePkg2q21w
         91eLslnHCkaLNoasC8jexxk+5ss/AM3lnXBwGhGY1XTLCj91IrEkIm01IXeVn+me7/uI
         /j7KKvU9TlkM92vs6lwX5UcNoIZB0E65bEvUNdjRifYHTSkcD3PmE5WEhTB4Q1TvRC21
         Wq4f4eLq7y+5NkvZNxisLIRpvuhFWFxk39ZGSkYJY7qaH/Ij5jLXbMLtflzZ1M38qJWE
         /g8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1bCMKw61MSY52fUFye3bq6wyKnTK2L82ATuzmNmWTQYFQh2p/VGWBebv6oXYmIYe/m/mdl1fQRwUbl+/vHbG6Sp+VC7ba5RNGrRoU
X-Gm-Message-State: AOJu0YzEwyoztnfsbOZ0nSJrZaOIj+qlKrk3p8KRbtpEMmM3VP5FncdF
	qZ3CRZT8X/dcLA3MXiFMt6m7z/fDMsQcCCtIUNNHI32u2ktZyPPG3QbOkim1N+l8CIJy8We6Gma
	vK7KVpBNNnQ==
X-Google-Smtp-Source: AGHT+IE2wliyUgg36eRbrdQG0eW2t+LBhnewXuB2szeGvK9iDIHirGHs2LzRSu2WcnyoQhiliA2iavEfWfM/Kg==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a17:90a:6b0a:b0:2c8:632:7efe with SMTP id
 98e67ed59e1d1-2cdb9661b65mr32367a91.4.1721847739514; Wed, 24 Jul 2024
 12:02:19 -0700 (PDT)
Date: Wed, 24 Jul 2024 19:02:11 +0000
In-Reply-To: <20240724190214.1108049-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240724190214.1108049-1-kinseyho@google.com>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240724190214.1108049-2-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 1/4] mm: don't hold css->refcnt during traversal
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

To obtain the pointer to the saved memcg position, mem_cgroup_iter()
currently holds css->refcnt during memcg traversal only to put
css->refcnt at the end of the routine. This isn't necessary as an
rcu_read_lock is already held throughout the function.

Remove css->refcnt usage during traversal by leveraging RCU.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 include/linux/memcontrol.h |  2 +-
 mm/memcontrol.c            | 18 +-----------------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 7e2eb091049a..4cbab85e2e56 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -75,7 +75,7 @@ struct lruvec_stats_percpu;
 struct lruvec_stats;
 
 struct mem_cgroup_reclaim_iter {
-	struct mem_cgroup *position;
+	struct mem_cgroup __rcu *position;
 	/* scan generation, increased every round-trip */
 	unsigned int generation;
 };
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 960371788687..062bfeee799c 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1019,20 +1019,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		else if (reclaim->generation != iter->generation)
 			goto out_unlock;
 
-		while (1) {
-			pos = READ_ONCE(iter->position);
-			if (!pos || css_tryget(&pos->css))
-				break;
-			/*
-			 * css reference reached zero, so iter->position will
-			 * be cleared by ->css_released. However, we should not
-			 * rely on this happening soon, because ->css_released
-			 * is called from a work queue, and by busy-waiting we
-			 * might block it. So we clear iter->position right
-			 * away.
-			 */
-			(void)cmpxchg(&iter->position, pos, NULL);
-		}
+		pos = rcu_dereference(iter->position);
 	} else if (prev) {
 		pos = prev;
 	}
@@ -1073,9 +1060,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 */
 		(void)cmpxchg(&iter->position, pos, memcg);
 
-		if (pos)
-			css_put(&pos->css);
-
 		if (!memcg)
 			iter->generation++;
 	}
-- 
2.45.2.1089.g2a221341d9-goog


