Return-Path: <linux-kernel+bounces-264987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDF193EAE7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0535C2819F1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 02:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9642B9C5;
	Mon, 29 Jul 2024 02:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFGRZgjN"
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32388250EC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 02:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722218565; cv=none; b=OFqSeavP4m1fFTQN5dH3H+kwg1mm4+MrwrrecHw1I37cJV4fkmCZvvNH3bAwNitHopi4n4Q4j7tr01ypQko2KG8qE+1tWW2mtEg0I4l+d6zLeNwhnoqdeLJDy8t6idFM2Pq5A9CQSKOrJDEQI+tqinSdEmErcaH2yH8NSvtZXTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722218565; c=relaxed/simple;
	bh=/xGNDtu2D35RXoKYz69yySxs+ul291ZvtNldF4dR864=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRtyz7pvBcZCLkbS+JZvCMbQX8OoR6mDXHUJhsYBRKeTU6aumOX0QtOLOmewM9ioKE5oYXKa79jeQazhy+a5/rHLnEc1CTlTQR42bLtw6WGLZn9II6ZT3/Ncr3amezKztmiJOdIjRiCBGkxoADm/5akeCKbdOToaCcpank/iyI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFGRZgjN; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3db1270da60so2185228b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 19:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722218562; x=1722823362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w0Xs54xhNptzJ7kEs2W7vD9Vy/50H6OFe/81vEtsNLU=;
        b=QFGRZgjNhJgLSmyUlNGRyfW/2jG5T3zD5NWX1fWJBEOfc6TasiyTGpNdhz70hB5+tC
         vawvkf83Z/4F8685y5RG3cAIeBZT09t0iv+sCCpMs7I9qcuf0djpqXb4Hxu5S05tU5+7
         aOF5gHW+v/VYyiwIEjwOZNT6f5zWReMVxU5s5NXPWqct5Gmb+9LvONyoKK0gp6It0Arv
         Aw2u4z33RnLC1PuflAXhl66+lQ7GEicXNZ9+DH8zNv/9xAn191LgKS9uj5YPBEcqrptk
         YlKSboZsq97jBqAlzu4JJm5JM9X7xqlNlZpChiNCSB7ZDn7Qm/8XXyanbBGYc1W/teLz
         YnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722218562; x=1722823362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w0Xs54xhNptzJ7kEs2W7vD9Vy/50H6OFe/81vEtsNLU=;
        b=ib80q3YITlp2OX1Pa40QeX3ovT5V4GCngBpYdsohA4v+o1AajKBwlkQLPRlWaaL/Yu
         arf8ERng9qYzzDlEYkkRgihAiVH8R8oDTQkw38bSlfH8aYi1+eqR+9hw0p0yWQ2xGVUf
         JgOtcO+lLFXiCnWkVR6pnt2SemS4Ld1qMQp1CRXjt9xgkPt7o9cZ1Q89TAefZrPX55k0
         dGYm79+zslWWYV+/9CqjCg5vsjOrA49jH98SV71N8lHJj9TjhTnHy0tSLhqE/OLd7tP8
         FxjdQ+UagBQGdELFxmgOOvR/P37FcCpLqNjIJtXFKnHMBDmBQfrOgGnU2ZgQA3zeac+E
         exXA==
X-Forwarded-Encrypted: i=1; AJvYcCVrZ2eFE3Ejea6y3IPPQ3rI5KWxcpkY84OJ36LY91o6xiInV1BsrXSkNUAp9TebooxYjmMMghGXXcUUAnkh0MqAcS4Dw4FewdMdVzta
X-Gm-Message-State: AOJu0Yyf82Osq4AdOgjh3EC0awl0HF+dG6WXD63Qo1Kw37vy1pqnWm4e
	DKUN0g9v6Cc5Rf0fqEl5/3GauqaMitIrLi2iSQEGL9fr+PDNz6eI
X-Google-Smtp-Source: AGHT+IEEQ3h5PiPfvkL2+Trqbvmnj1O3vhpxd50O8OTo03Q8+SBGPKRJeszyw8lTwBb8pQUA6mEIAg==
X-Received: by 2002:a05:6808:130b:b0:3db:18c8:feb3 with SMTP id 5614622812f47-3db23ac024bmr8836380b6e.20.1722218562080;
        Sun, 28 Jul 2024 19:02:42 -0700 (PDT)
Received: from localhost.localdomain ([2407:7000:8942:5500:aaa1:59ff:fe57:eb97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead71592bsm5840176b3a.86.2024.07.28.19.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jul 2024 19:02:41 -0700 (PDT)
From: Barry Song <21cnbao@gmail.com>
To: yosryahmed@google.com
Cc: 21cnbao@gmail.com,
	akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	hannes@cmpxchg.org,
	hughd@google.com,
	kaleshsingh@google.com,
	kasong@tencent.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mhocko@suse.com,
	minchan@kernel.org,
	nphamcs@gmail.com,
	ryan.roberts@arm.com,
	senozhatsky@chromium.org,
	shakeel.butt@linux.dev,
	shy828301@gmail.com,
	surenb@google.com,
	v-songbaohua@oppo.com,
	willy@infradead.org,
	xiang@kernel.org,
	ying.huang@intel.com
Subject: Re: [PATCH v5 2/4] mm: Introduce mem_cgroup_swapin_uncharge_swap_nr() helper for large folios swap-in
Date: Mon, 29 Jul 2024 14:02:22 +1200
Message-Id: <20240729020222.36389-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJD7tkbho1a6pwZq82aHBa8BpXijqVopde3k-RnageOtdO32pw@mail.gmail.com>
References: <CAJD7tkbho1a6pwZq82aHBa8BpXijqVopde3k-RnageOtdO32pw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, Jul 27, 2024 at 4:31 AM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> On Fri, Jul 26, 2024 at 2:47 AM Barry Song <21cnbao@gmail.com> wrote:
> >
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > With large folios swap-in, we might need to uncharge multiple entries
> > all together, it is better to introduce a helper for that.
> >
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  include/linux/memcontrol.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 1b79760af685..55958cbce61b 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -684,6 +684,14 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
> >                                   gfp_t gfp, swp_entry_t entry);
> >  void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
> >
> > +static inline void mem_cgroup_swapin_uncharge_swap_nr(swp_entry_t entry, int nr)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < nr; i++, entry.val++)
> > +               mem_cgroup_swapin_uncharge_swap(entry);
>
> mem_cgroup_swapin_uncharge_swap() calls mem_cgroup_uncharge_swap()
> which already takes in nr_pages, but we currently only pass 1. Would
> it be better if we just make mem_cgroup_swapin_uncharge_swap() take in
> nr_pages as well and pass it along to mem_cgroup_uncharge_swap(),
> instead of calling it in a loop?
>
> This would batch the page counter, stats updates, and refcount updates
> in mem_cgroup_uncharge_swap(). You may be able to observe a bit of a
> performance gain with this.

Good suggestion. I'll send the v6 version below after waiting for some
comments on the other patches.

From 92dfbf300fd51b427d2a6833226d1b777e0b5fee Mon Sep 17 00:00:00 2001
From: Barry Song <v-songbaohua@oppo.com>
Date: Fri, 26 Jul 2024 14:33:54 +1200
Subject: [PATCH v6 2/4] mm: Introduce mem_cgroup_swapin_uncharge_swap_nr()
 helper for large folios swap-in

With large folios swap-in, we might need to uncharge multiple entries
all together, it is better to introduce a helper for that.

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---
 include/linux/memcontrol.h | 10 ++++++++--
 mm/memcontrol.c            |  7 ++++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 1b79760af685..f5dd1e34654a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -682,7 +682,8 @@ int mem_cgroup_hugetlb_try_charge(struct mem_cgroup *memcg, gfp_t gfp,
 
 int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 				  gfp_t gfp, swp_entry_t entry);
-void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry);
+
+void mem_cgroup_swapin_uncharge_swap_nr(swp_entry_t entry, unsigned int nr_pages);
 
 void __mem_cgroup_uncharge(struct folio *folio);
 
@@ -1181,7 +1182,7 @@ static inline int mem_cgroup_swapin_charge_folio(struct folio *folio,
 	return 0;
 }
 
-static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
+static inline void mem_cgroup_swapin_uncharge_swap_nr(swp_entry_t entry, int nr)
 {
 }
 
@@ -1796,6 +1797,11 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
 
 #endif /* CONFIG_MEMCG */
 
+static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
+{
+	mem_cgroup_swapin_uncharge_swap_nr(entry, 1);
+}
+
 #if defined(CONFIG_MEMCG) && defined(CONFIG_ZSWAP)
 bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
 void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index eb92c21615eb..25657d6a133f 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4573,14 +4573,15 @@ int mem_cgroup_swapin_charge_folio(struct folio *folio, struct mm_struct *mm,
 
 /*
  * mem_cgroup_swapin_uncharge_swap - uncharge swap slot
- * @entry: swap entry for which the page is charged
+ * @entry: the first swap entry for which the pages are charged
+ * @nr_pages: number of pages which will be uncharged
  *
  * Call this function after successfully adding the charged page to swapcache.
  *
  * Note: This function assumes the page for which swap slot is being uncharged
  * is order 0 page.
  */
-void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
+void mem_cgroup_swapin_uncharge_swap_nr(swp_entry_t entry, unsigned int nr_pages)
 {
 	/*
 	 * Cgroup1's unified memory+swap counter has been charged with the
@@ -4600,7 +4601,7 @@ void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
 		 * let's not wait for it.  The page already received a
 		 * memory+swap charge, drop the swap entry duplicate.
 		 */
-		mem_cgroup_uncharge_swap(entry, 1);
+		mem_cgroup_uncharge_swap(entry, nr_pages);
 	}
 }
 
-- 
2.34.1

>
> > +}
> > +
> >  void __mem_cgroup_uncharge(struct folio *folio);
> >
> >  /**
> > @@ -1185,6 +1193,10 @@ static inline void mem_cgroup_swapin_uncharge_swap(swp_entry_t entry)
> >  {
> >  }
> >
> > +static inline void mem_cgroup_swapin_uncharge_swap_nr(swp_entry_t entry, int nr)
> > +{
> > +}
> > +
> >  static inline void mem_cgroup_uncharge(struct folio *folio)
> >  {
> >  }
> > --
> > 2.34.1
> >

