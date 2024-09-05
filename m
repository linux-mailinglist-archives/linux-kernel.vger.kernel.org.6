Return-Path: <linux-kernel+bounces-316145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7571C96CBC7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 02:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294751F27858
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 00:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7CD8C13D;
	Thu,  5 Sep 2024 00:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGwvOgz2"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B993A8F58
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 00:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496312; cv=none; b=LD00j1Pv2OWWmZUi61VNv1Q9BeueMyKgqPWLTPryf1gbyY+O0/sIIzhpYNnsXao3VDHtW9lRgFxF6nJJeYL+lDeHVWs8cFdn+KhuXP1HdjaUn1/QN2XHZl+tz/6c6B4D8Unx31MjSzapueWx2RHK/K7D2I1lMYMduoMxKcyEFj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496312; c=relaxed/simple;
	bh=fk2/lGT/4GsriM/5ZGMKLoZ8zzkgaZL8fCE8hrnHHzY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MwUa8ASrMrsZc4/AobLU2hSra3syEAJfLuZauxB0mne31R4j41sH6Aeeh2NKIzAIM29R2Id71USbtYYz8/ZFJ/wXcH2bXk8u5smBtJRaEBffdkgwA1QOTYfVabdT5smzB3WuKxlK6UjLxow6bLgjEmCg6Ph4naKhsHdxKMG/hXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGwvOgz2; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-7cd98f27becso285541a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 17:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725496310; x=1726101110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqTDHTCRiwsvIU2qvmmvg5mPCxzlppgliuAtX0a739I=;
        b=hGwvOgz2Okmct2aS5wPnYk+3JMzJDdVKq9LpGVZbThH/5uzZVGOnjnNea4TDiU6css
         yufw96/rt124h8rgD8cbFQNAK8UjxF2fW7ImIE/iybSA6L+7aE6W0rxjotuTD/yvicGH
         6XMgNdWGvWQQDL2hheChL1N4p72iHSkqCZw9Dc68+VgQEYQ+Z79eoPYFD49JaVyJPTZ+
         kzrzmTuLLNh8/GyaqYigqpEWUJ3yI2GbcR/EEVk3vboZo9xRte+kIQuXelckWsm2EHRY
         yaBeWTLw0D6wYjXXOKe06uGpnWpLXJMYIQzxdGZkYqbjsowslDz4WB2ewOGzP2souVfh
         HYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725496310; x=1726101110;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sqTDHTCRiwsvIU2qvmmvg5mPCxzlppgliuAtX0a739I=;
        b=ZA3dGjwVdo9HDPiOohQbD6tSZ5+W//6RJXMG2iRXNZAl8hSUzuq8iCOYAu9WlcgxfL
         1W7ldb2xGlOe4Jqe+/zMAoigh0j+UNSLZd4fokNMVS1pa68uB7y990XFVDWMjToQzl5t
         S3giMdqK0pQLi9KDLE/VYU3sBayDtjDfewkJkzUh+jdbpT/C573QE3wRaFDEQNEq7+X+
         tDABj3GeFaTyJyEnkX4jy6dUGRJ1AnTa4/VyJUVnk7h3+uRi0c3ev+61RrpIk5m7k3Kl
         dz1llBNcxhUyn8BYM9hWKD1wub6kXFMm34zpqyGd4tVypH5DgGoeVH3+eyeDTNP+eEy5
         xeOg==
X-Forwarded-Encrypted: i=1; AJvYcCVLhQ4wXach1u4QV4eEkB2KX8PbP9Aff5o3pfjKqcds7S4kZTdZspMTvxrG1QhdcJ6R1xtWVP948Y0WLe8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy275t70sM+8R30/QqOPCRUUD4OXfVYs93uoLbBSKMctrWejpEx
	nm6sOqUv6WZCvEmSYnRq8Zfd+cfOLMXxkdNRP3uTemX6r2P1hqeSoe5jeFLraSR47rnWGwMMcCG
	X7nCC8ZcYMQ==
X-Google-Smtp-Source: AGHT+IEOy0bHsy4chODc/dIKYmpQwZgXe72gHtWSiqNJNS/vQMmLAYyUUqkUY8wRavMe2EY8pkrILzNoQwJIVw==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a63:e34e:0:b0:6ea:d240:23b0 with SMTP id
 41be03b00d2f7-7d4c1019e5emr56861a12.4.1725496309928; Wed, 04 Sep 2024
 17:31:49 -0700 (PDT)
Date: Thu,  5 Sep 2024 00:30:51 +0000
In-Reply-To: <20240905003058.1859929-1-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240905003058.1859929-1-kinseyho@google.com>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Message-ID: <20240905003058.1859929-3-kinseyho@google.com>
Subject: [PATCH mm-unstable v4 2/5] mm: don't hold css->refcnt during traversal
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, mkoutny@suse.com, 
	"T . J . Mercier" <tjmercier@google.com>, Hugh Dickins <hughd@google.com>, Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

To obtain the pointer to the next memcg position, mem_cgroup_iter()
currently holds css->refcnt during memcg traversal only to put
css->refcnt at the end of the routine. This isn't necessary as an
rcu_read_lock is already held throughout the function. The use of
the RCU read lock with css_next_descendant_pre() guarantees that
sibling linkage is safe without holding a ref on the passed-in @css.

Remove css->refcnt usage during traversal by leveraging RCU.

Signed-off-by: Kinsey Ho <kinseyho@google.com>
Reviewed-by: T.J. Mercier <tjmercier@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Michal Koutn=C3=BD <mkoutny@suse.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Tejun Heo <tj@kernel.org>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Zefan Li <lizefan.x@bytedance.com>
Cc: Hugh Dickins <hughd@google.com>
---
 mm/memcontrol.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index dbc1d43a5c4c..cdd324812b55 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1015,20 +1015,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup=
 *root,
 		else if (reclaim->generation !=3D iter->generation)
 			goto out_unlock;
=20
-		while (1) {
-			pos =3D READ_ONCE(iter->position);
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
+		pos =3D READ_ONCE(iter->position);
 	} else if (prev) {
 		pos =3D prev;
 	}
@@ -1069,9 +1056,6 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup =
*root,
 		 */
 		(void)cmpxchg(&iter->position, pos, memcg);
=20
-		if (pos)
-			css_put(&pos->css);
-
 		if (!memcg)
 			iter->generation++;
 	}
--=20
2.46.0.469.g59c65b2a67-goog


