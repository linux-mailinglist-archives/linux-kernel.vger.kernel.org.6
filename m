Return-Path: <linux-kernel+bounces-304102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738DE961A42
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 01:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30372284DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 23:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB37B1D4607;
	Tue, 27 Aug 2024 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luWYdgww"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7B11D4606
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 23:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724800303; cv=none; b=qti8FzIgLPfa2Qn0X+b6T3oEHS65+NlD+4CunfWzIF9xLfRjA4gaWr8THM76XO+J0SSV3brzLRWUR5ZY2oPfh8mk8gGH2EXDtD/xNeNIZwpGClfB3tapSNMciOCAPNQYmHWouPXhdzx+UBX+T0N77MO1ykWXkmW9LCCTs59xEsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724800303; c=relaxed/simple;
	bh=GqTjpb1jAON2eyIaaYCsAsTBYc3LGYMO9CEcIpbdfhI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f64PnqtB26AkWyD5B4GrNJriPL5kzE795UepVYwZjLocj71qrjYdVStJJy4m3Lro7Ord5njAqJE058hjGSHOg/9S0awzUwHcIhd3Kxat+IHlbvha07mpZTGU8LMWOJOlZhHLyUf4ryfwO3MkI7wN4uFvFCugiRdvFuNAgyibiBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=luWYdgww; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b46a237b48so127399927b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 16:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724800301; x=1725405101; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QXZSgIWrSh7o4TMYH5HXuFFT6CvWnPSrTikMMv9Xu6c=;
        b=luWYdgwwCtalmPcjYLmG12A7J1JyH9hd5BjKy6ix1RIRFsvB8fmqyTBGV/hbtf5GN0
         bpqruMsMwtW7Y+dvdLdKXC4R5A5LcSOoUOgvYFgTwnF/n8hesNz79ZREzZ1a1GH7ogBM
         XKt9/LyLJjg4UuvU9VXdYExxnv6SDg4lzx+Nw3sDb3tZzdIRyyrJYnNfgez1n4Pl3v/i
         rgQ0k6reNmGgwPYW2y4ZcV6zZ2TTjmaIkoU8D+T2WMTiNeWIlD3UI+vvhE57htyghBYg
         aUKwkJgEZMBB9YnFQKpEYpKEnIuJ3yFnHmtE1tpDLwLba71NSosomK4EnlCdKwYSl2o3
         Uetw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724800301; x=1725405101;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QXZSgIWrSh7o4TMYH5HXuFFT6CvWnPSrTikMMv9Xu6c=;
        b=AWN1/HpCCtjTcvv8LIZpFYN1mn+JFPQPYtcf8JTTYgCmZeasdAIkg2swvXBx1xfqIV
         EjAzE0n3JxE3yR6po/C5Yiq9Jj9PBfJmnVWuxP99NlonyPP3nbN6CWI5MtZcDPdZl6Tx
         Bmg21skeq/uroyqiNXwjk7VY0nnh5IVGLB/C1kzAcy6UsRgp+xhNzcKfwvDeq/VQ9OZu
         fwWN/JrG87VBtKi87+WiNFR8zb54jGkBJoKYfKT4SVPrmaH4EgRBrJBdauL+TcBjB6wF
         mVtfiTfiDPAKDVdRUa+AZzgtvhVWmYh3FsDme1mwZDz27z1BTkJHG17VUvFbuWoEMWnd
         Cjbw==
X-Forwarded-Encrypted: i=1; AJvYcCUE8hJdpPV7WbSmEWOnQ7k9YEGJUUEIn9FybyDbW2YHmToODSmQUDTM3S3zkrttuQ7sw0g/74W5QzMm9mM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqX1FcLagolorAaVJ2ltERVSsa6q0v3SJ12frKHNihnAjF7MQD
	JC/rsZsTKtA+smbZr7tvAuhSXbgFJEiMNi6RDttP5U3WrucTHtk1xNV1xrmXSfVxQbLimxovCRi
	1GPU6ZtYRmA==
X-Google-Smtp-Source: AGHT+IH/OEMHPdWupnXyjW/u5NZJ+Iwna53tKUi6hE4QApyk+GLsJI4xuXktR0o4bdU85PWSweUUV8sgsDuT4w==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a25:abad:0:b0:e11:69f2:e39 with SMTP id
 3f1490d57ef6-e1a4580c518mr380276.9.1724800300879; Tue, 27 Aug 2024 16:11:40
 -0700 (PDT)
Date: Tue, 27 Aug 2024 23:07:39 +0000
In-Reply-To: <20240827230753.2073580-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240827230753.2073580-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240827230753.2073580-3-kinseyho@google.com>
Subject: [PATCH mm-unstable v3 2/5] mm: don't hold css->refcnt during traversal
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

To obtain the pointer to the next memcg position, mem_cgroup_iter()
currently holds css->refcnt during memcg traversal only to put
css->refcnt at the end of the routine. This isn't necessary as an
rcu_read_lock is already held throughout the function. The use of
the RCU read lock with css_next_descendant_pre() guarantees that
sibling linkage is safe without holding a ref on the passed-in @css.

Remove css->refcnt usage during traversal by leveraging RCU.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 mm/memcontrol.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 35431035e782..67b1994377b7 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1013,20 +1013,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
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
+		pos = READ_ONCE(iter->position);
 	} else if (prev) {
 		pos = prev;
 	}
@@ -1067,9 +1054,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 */
 		(void)cmpxchg(&iter->position, pos, memcg);
 
-		if (pos)
-			css_put(&pos->css);
-
 		if (!memcg)
 			iter->generation++;
 	}
-- 
2.46.0.295.g3b9ea8a38a-goog


