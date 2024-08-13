Return-Path: <linux-kernel+bounces-285490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2279950E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 22:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3FF9CB2642A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 20:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A5961A706E;
	Tue, 13 Aug 2024 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOmAAx+1"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B811A7069
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 20:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723582080; cv=none; b=bx5Kaf8ra5K2v8/lbkFuL62uqgvNYRT/joOi8o1KA9EsjvZT0Zpmnqw0Zda6jiu8mdRMPRZ/uitGVrfcnGxw7XXDn8pkEY01QcqT3vZOObSuZmLl+N08K+RFBn6fN/qBtzIn88v3apzgQJXpPPQJjFaP5It4QmqhDbMRkfPsmdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723582080; c=relaxed/simple;
	bh=jUZ3GBO033wal/6XTVBPTFuNeWp5VVLyaFBWVIzsCNA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CK4fQmzzhOqH4aeVbw1JHLcBFnNK/BWI5FjCIIgby/nRnzufIEGE8IXTgrEWvfBNnHZP6HZTnQYZRfNymK8npQlWtdEifIHK3m1vbq8c/xurL3s+gkGh/lTLIlu+20702KS0n6h2qXKErzkmfYXUFx2vruzvrT7dNqjtfJuX1X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOmAAx+1; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-6c8f99fef10so6730395a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 13:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723582078; x=1724186878; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7PkbmuKxOROTjGI4E3wXgUmmHtkXl9USrDaeWbBH7v4=;
        b=sOmAAx+1JAaLfKbZj5vBhe91KEoAQqTsCJ9F7LJqF1OtzySYtV7OkdWWFV/wOiKZfC
         idlpsvmGal55I8X2qeX4wZKsWcKpVP/WD09eqZ3Jb73RLaQ7QSoGoCM7p9NItle2jtyD
         9JIEoeD6wpFgLRRyRcIRaRVbFyCQgr10J8POseXlBPNZ8Pr1SYpGKEXN0q5UN6j0pZNK
         DPyv0VcvUMwBiz752PYmldKjiuyuHF+p9XFhkwTpRMNapqTDAl90JxQpbGzdz+Ni398q
         OLPv3UflzPi/0U3ZFbvx5YJG1cEjcAVjljUfuCPyEBk2wBxHuBb2I290mMaIDEyMHpuR
         egsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723582078; x=1724186878;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7PkbmuKxOROTjGI4E3wXgUmmHtkXl9USrDaeWbBH7v4=;
        b=sia6M8rrCP8cTa6Ktr59Q9geGo0cMW7D62j/5sOFAUao8Vhyq9CMhS+ODDVvvlUPIC
         N62o+bxHwBOHxignpjgFSDt19Plk5FJty1bXf51ZLR0vKVZZt8lKw59/1b0zGL/00kgw
         S0CEXuZARKjUq/E7ju1q76nqbC62wxwZf2AYwpN7Heb2lzGcjJsm0/+PmCUgwuR8feNv
         vrUAD9iO1sR3z/a/vZeZD2OjprqWSyMYGjBcK5xCoIFmtArENbE9TIlBCHJPum3+x0Uc
         VffGM244o7rP2DMXKfSBN+wPXvBJ/dlo9VZ4fMH5Nn9M4TBiVSZElcum06MzD9jtmdFQ
         Y+xA==
X-Forwarded-Encrypted: i=1; AJvYcCUjlynVFhcrS2Yg999NBD6zw/WuMzBpM9hksI1WgThb2MfUsQvlNcg9Ahd/TlpgjyWv3A7yRPDVJqQOai9djt2TnpeJYE7S5Lr5tNXm
X-Gm-Message-State: AOJu0YySpMuQ/1wz/abi4++HXEYpj/bGX1/BBTRtVNOAVJoDgV+TjhvM
	r2qGcTeHZa0QzmF+EwCk7G37pS7R9SI3WvePIdY0pkGPzCEBFX4kGj1br1BWuxkvLXvmo+IZzfK
	Bq5K11ABEdQ==
X-Google-Smtp-Source: AGHT+IHAciPzqd2lPyRlBVSYjYEEfNedI8L6N+K0qntudc/ZA3AgPVxsZZlT71exmwJpvjWHZeV3opJ32aRJGw==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:6a02:58d:b0:6ea:a4f3:14a3 with SMTP
 id 41be03b00d2f7-7c6a56d0242mr754a12.4.1723582078235; Tue, 13 Aug 2024
 13:47:58 -0700 (PDT)
Date: Tue, 13 Aug 2024 20:47:13 +0000
In-Reply-To: <20240813204716.842811-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240813204716.842811-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Message-ID: <20240813204716.842811-4-kinseyho@google.com>
Subject: [PATCH mm-unstable v2 3/5] mm: increment gen # before restarting traversal
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

The generation number in struct mem_cgroup_reclaim_iter should be
incremented on every round-trip. Currently, it is possible for a
concurrent reclaimer to jump in at the end of the hierarchy, causing a
traversal restart (resetting the iteration position) without
incrementing the generation number.

By resetting the position without incrementing the generation, it's
possible for another ongoing mem_cgroup_iter() thread to walk the tree
twice.

Move the traversal restart such that the generation number is
incremented before the restart.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
---
 mm/memcontrol.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 1688aae3b1b4..937b7efc41ca 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1036,7 +1036,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		root = root_mem_cgroup;
 
 	rcu_read_lock();
-
+restart:
 	if (reclaim) {
 		struct mem_cgroup_per_node *mz;
 
@@ -1063,14 +1063,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 	for (;;) {
 		css = css_next_descendant_pre(css, &root->css);
 		if (!css) {
-			/*
-			 * Reclaimers share the hierarchy walk, and a
-			 * new one might jump in right at the end of
-			 * the hierarchy - make sure they see at least
-			 * one group and restart from the beginning.
-			 */
-			if (!prev)
-				continue;
 			break;
 		}
 
@@ -1093,8 +1085,18 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		 */
 		(void)cmpxchg(&iter->position, pos, memcg);
 
-		if (!memcg)
+		if (!memcg) {
 			iter->generation++;
+
+			/*
+			 * Reclaimers share the hierarchy walk, and a
+			 * new one might jump in right at the end of
+			 * the hierarchy - make sure they see at least
+			 * one group and restart from the beginning.
+			 */
+			if (!prev)
+				goto restart;
+		}
 	}
 
 out_unlock:
-- 
2.46.0.76.ge559c4bf1a-goog


