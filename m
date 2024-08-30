Return-Path: <linux-kernel+bounces-308506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C95965DE2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48D3EB23614
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE0C17B4F6;
	Fri, 30 Aug 2024 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnTjAowH"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C04129D19
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012256; cv=none; b=beOZzaRnmyrGj2tby1OYXAAZ84rD8BU9qPl/rh9gjWt0UatBk935Jv7rCBxxc+q2jKywIfMFHcJi4iGt0YPY/vZYU0HQYYUW9Ng1uU5LJ534pPe5Z4xQA4uaCAfRiLb4mAc1pKnRHvEa8s1Z59GAoWs6giLlRox0RGTxOP9zT/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012256; c=relaxed/simple;
	bh=rB5RQoOEvZgZP+NkbrNvUyrH/QmtFkl8k1kEu/UtBHE=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=caszlrscT4C/rNV8ZeDzg3PdrFjAZX21JE0v4FQIxzUz/cQcwRaDB68QBY7VOC5HmED0F4lAvCjY2GwjXkkMFA/jc0eWfpnQ5vyejBJSlJSozAkHr+8GnAAejPmcoQ68YPDSqw2efZg7jBVh3aKXCwxxzhzqflFxBsjU8peqodw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnTjAowH; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-39d2cea1239so6488595ab.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 03:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725012254; x=1725617054; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3lZ9Hn/+qhJZklOxutGWnGoGesi1GdFiMvyIIRsd9s4=;
        b=wnTjAowHTlVPpq8BiM9fvpO+XwgwjSzb/rPhLXCtrj4yYqUOB3BwCOJHXCObNsHg/+
         CBG2DZ2PKk6PfMW2KzcIGERWrujCNN/ESjcVTlENOmCMXlwvy0DuKlGsM+/ajh9YzVho
         yZc/Y4frLr+YomzXgK3CFEoqj2uPDJyYq7WOO2NRdpBwFygOsRubcPHIAWRO84BniFu6
         rPuecBYUYG7uwInY6PLpE4j152rv+eVwBqalQI824jNzXofKzv5xSljTv91Um5zJaov+
         iHO3oX6t754C0DGVQK7do6DlLsSYV/LsxaOQbFAhUbflJZvKgQkDy6ajod2CZ5ubb8ch
         TfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012254; x=1725617054;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3lZ9Hn/+qhJZklOxutGWnGoGesi1GdFiMvyIIRsd9s4=;
        b=Q7IrYGzPCKIdo9L7XPOsPcYm4aJB3uMBwMpAFqpOj405b4falhJuXH/d5bPRGl51FI
         LyiuOM3okIFYrFcOvoXCZ2l178nU8ymbug1folnZylXJ34KStZ4D0ryOYiOUSBGZVsE/
         F3gLv9oiuQ7uRe74KtPsqNENc5Qe9Cd4VbgxMipCG3G/g5IVE80oBSJNCBnf0i60uA6Q
         4g5pH/tHMqN5cL4t+xsgpgL81HVogAkV9qEnwfbPr+m9mcvCr+h4BGkI179JBZ2p7ePM
         NEMWU0oCrWHxfRrXqMOfo9QwD8aJSZZCyC1o7Il/qNfol1XpXCJvy+JTRf5t51ecK1CP
         t3QQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9dekJ6xHblyyNB58Pyg7HU9p7vSZiek3uRu1Wl4mKQOsORv051pZpRPcp1j5O5PewPyZUYToyf+Y5sUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxvcdyhTvWa9ZZFCnFvw2FpLPVBfHEtD+OEphdwoUyIOJk7DYt
	Un1jGzUfPFu0T1hZX3Yrl5wXT7fmKT+VNvOe2QyPd6hLEmGa5H2ettErepXA0O0l5QK5Ed5Cq4X
	UbQ==
X-Google-Smtp-Source: AGHT+IFHoSWzOOyn/+aRzsSVpFBM0RLJuqHCe/Z7Zw6PGRR+A0tTUlzRXDP9DWiAX4B3kTu48B1vIQ==
X-Received: by 2002:a05:6e02:178f:b0:39d:47cf:2c7f with SMTP id e9e14a558f8ab-39f3788c68bmr64439415ab.24.1725012254489;
        Fri, 30 Aug 2024 03:04:14 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d22e774c6fsm2618822a12.35.2024.08.30.03.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:04:13 -0700 (PDT)
Date: Fri, 30 Aug 2024 03:04:01 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Kinsey Ho <kinseyho@google.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
    Yosry Ahmed <yosryahmed@google.com>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
    Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
    Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, 
    mkoutny@suse.com, baolin.wang@linux.alibaba.com, tjmercier@google.com, 
    hughd@google.com
Subject: Re: [PATCH mm-unstable v3 4/5] mm: restart if multiple traversals
 raced
In-Reply-To: <20240827230753.2073580-5-kinseyho@google.com>
Message-ID: <56d42242-37fe-b94f-d3cb-00673f1e5efb@google.com>
References: <20240827230753.2073580-1-kinseyho@google.com> <20240827230753.2073580-5-kinseyho@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 27 Aug 2024, Kinsey Ho wrote:

> Currently, if multiple reclaimers raced on the same position, the
> reclaimers which detect the race will still reclaim from the same memcg.
> Instead, the reclaimers which detect the race should move on to the next
> memcg in the hierarchy.
> 
> So, in the case where multiple traversals race, jump back to the start
> of the mem_cgroup_iter() function to find the next memcg in the
> hierarchy to reclaim from.
> 
> Signed-off-by: Kinsey Ho <kinseyho@google.com>

mm-unstable commit 954dd0848c61 needs the fix below to be merged in;
but the commit after it (the 5/5) then renames "memcg" to "next",
so that one has to be adjusted too.

[PATCH] mm: restart if multiple traversals raced: fix

mem_cgroup_iter() reset memcg to NULL before the goto restart, so that
goto out_unlock does not then return an ungotten memcg, causing oopses
on stale memcg in many places (often in memcg_rstat_updated()).

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/memcontrol.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6f66ac0ad4f0..dd82dd1e1f0a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1049,6 +1049,7 @@ struct mem_cgroup *mem_cgroup_iter(struct mem_cgroup *root,
 		if (cmpxchg(&iter->position, pos, memcg) != pos) {
 			if (css && css != &root->css)
 				css_put(css);
+			memcg = NULL;
 			goto restart;
 		}
 
-- 
2.35.3

