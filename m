Return-Path: <linux-kernel+bounces-541681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2C9A4BFFE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:14:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9894B16EF44
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB0CC20E330;
	Mon,  3 Mar 2025 12:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxyuBo7o"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CBF20DD4E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 12:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004039; cv=none; b=WK8fuof1bGWXf0ytEcTkymtNcTQKpElkEU5ZEajMmE9kW0x0cjmMeX+5TNXVlwlWJyEswtrML/t27Q/N6afaFSWQyZqNL/x2sbVotqiZOCY3kp2g9TJsfBoENY3nryVDXNDw41GzhqeEGLYy5UpnAq4SxucQQ29xLaTAqhWcIrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004039; c=relaxed/simple;
	bh=1l2K5ENCvojaVHBmxEy6/eqJ3lSTgk5W23LVBI3DKgI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Sca6aopX3cmBcYf0Ty5To8O+DX1iLrDhwTofRqrz0YiD+jEgpJilM2SGIWORUxsMyxaukCFX894zrQyQOsuO4LDIU27dB4dUf+2FJ/8Gl0NNq7YrX70ITVqTMr9vFO7RARrawWOSinxsGn6pD8EcJfTFbHWfMgiFmaQEbX+oVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pxyuBo7o; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4394c0a58e7so30078655e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 04:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741004034; x=1741608834; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3XM/kMIL2XLwkwjwLCWrp4SEasAEO2v2SGHBA5kN3uY=;
        b=pxyuBo7ozcbzq/3t8FWNEA14flVNJwwOPycg3sjd+opi/bM1KLMffnZoJH1VgavG/C
         1ol/oDQftL04Hi/aGmP3aSxi4Edp/DSthSol2cvXnCr8DitmqaSUd3szYr0p+DBfOgiP
         WgMAIv/765vyaLgSITjWU+KYILpih88xn/bcR2rGeBuUQB5XqyzCyAFzgzXh7tq9Qk8B
         WkrkFmEviDdjrKRnkcVtf9xQzTizww55a5vegorJFoXOiFBHd5jz8Z5Lq137T8x7AGfM
         Exn5zjPA/l7TDioeR0nUOV9A+AoG8aXFfxuh1oIeMj49ErOVKcDsFefqavAivYL854M/
         3kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741004034; x=1741608834;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3XM/kMIL2XLwkwjwLCWrp4SEasAEO2v2SGHBA5kN3uY=;
        b=kOVQY3NcWoBVgs5rZXXpEG+Wj2N29lb7CXnO9mRjJwVORq2Gb7vT/A7i+VvfCS5/Pl
         9YweSPUH6qPBDBToQprVkXWwK38Z1FyVzzJJQt7RHqYjj1GoiT1oQUVNwLK6Ej04LQl3
         +FCmOCrzXmt87JShTEI8pC00xTj7Hxtlb1gX6vwSHQKaMp93t/fnRyiEAvadv6XhnzEJ
         o9Nd5yyov5QvcdaW/rZoZBtkaVLgXKuMqbMlZabrxbEwFP97vfDHUXhLi1Rf4pSslZCl
         DY9fHYSb3wrIfSCkNWdw2UGHhfJo8UPT9Ua1SIcCNyn1MoiihWkdr7Qc1EfJcW8h0jhi
         wdfA==
X-Forwarded-Encrypted: i=1; AJvYcCVjnm3BhjvGFmqyv29qj5lTzCyPo2GQEOJ7W73OPAHfCtopSLRmr2U5ot/KFdnKyVxN0V7O8MGH5OYVMWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3l5QenzpZyG5SE3Ac5CEgYRRNTRwqIweHo6NIUayhFTQVjUNA
	E79f5NReg9BmnI6iW+DEj6bS+mzSmh+6tWItl9ygMi8vnytrxaVn5YuL6kQQV9sUB0QXqPSDyA4
	h8r1txdFRWg==
X-Google-Smtp-Source: AGHT+IGYc3bDnw0zgL8aV6CcStUU7x4W8H3EWnZWGR+FbnL9xa0DOINfyPtYIKSdc9eErLJbdsTXinjHx6+yIQ==
X-Received: from wmbg14.prod.google.com ([2002:a05:600c:a40e:b0:439:9438:468b])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:511e:b0:439:9aca:3285 with SMTP id 5b1f17b1804b1-43ba66dfe1amr102550035e9.6.1741004022222;
 Mon, 03 Mar 2025 04:13:42 -0800 (PST)
Date: Mon, 03 Mar 2025 12:13:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOWcxWcC/32NTQ7CIBSEr9K8tRh+VNCV9zBdFHilxFoIGKJpu
 Lu0B3AzyTfJfLNCxuQxw61bIWHx2YelAT90YKZhcUi8bQyc8jPlXJI4ONRzME+yhcVIrheuzEl
 ZiVRB28WEo//szkffePL5HdJ3vyhsa//ZCiOMCEkZjloIpvXdheBmPJrwgr7W+gOR0x54swAAA A==
X-Change-Id: 20250227-pageblock-lockdep-9628c48d7e08
X-Mailer: b4 0.15-dev
Message-ID: <20250303-pageblock-lockdep-v2-1-3fc0c37e9532@google.com>
Subject: [PATCH v2] mm/page_alloc: Add lockdep assertion for pageblock type change
From: Brendan Jackman <jackmanb@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Oscar Salvador <osalvador@suse.de>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

Since the migratetype hygiene patches [0], the locking here is
a bit more formalised.

For other stuff, it's pretty obvious that it would be protected by the
zone lock. But it didn't seem totally self-evident that it should
protect the pageblock type. So it seems particularly helpful to have it
written in the code.

[0] https://lore.kernel.org/lkml/20240320180429.678181-3-hannes@cmpxchg.org/T/

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
Note Vlastimil Acked the first version, I did not carry his ack since
I've changed the diff. Not sure if I'm being overly pedantic there?

Changes in v2:
- Fixed missing in_mem_hotplug() setup for !CONFIG_MEMORY_HOTPLUG
- Expanded commit message to include a bit more rationale
- Link to v1: https://lore.kernel.org/r/20250227-pageblock-lockdep-v1-1-3701efb331bb@google.com
---
 include/linux/memory_hotplug.h | 5 +++++
 mm/memory_hotplug.c            | 5 +++++
 mm/page_alloc.c                | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index eaac5ae8c05c8ee2f2868d5bc1b04d1f68235b3f..508a1d074527a3349c1c9789ecf35d5ab08a5ba6 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -175,6 +175,7 @@ void put_online_mems(void);
 
 void mem_hotplug_begin(void);
 void mem_hotplug_done(void);
+bool in_mem_hotplug(void);
 
 /* See kswapd_is_running() */
 static inline void pgdat_kswapd_lock(pg_data_t *pgdat)
@@ -223,6 +224,10 @@ static inline void put_online_mems(void) {}
 
 static inline void mem_hotplug_begin(void) {}
 static inline void mem_hotplug_done(void) {}
+static inline bool in_mem_hotplug(void)
+{
+	return false;
+}
 
 static inline bool movable_node_is_enabled(void)
 {
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e3655f07dd6e33efb3e811cab07f240649487441..c44c2765b21f1e9e4b2d68abda9ac161fb2869ec 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -267,6 +267,11 @@ void mem_hotplug_done(void)
 	cpus_read_unlock();
 }
 
+bool in_mem_hotplug(void)
+{
+	return percpu_is_write_locked(&mem_hotplug_lock);
+}
+
 u64 max_mem_size = U64_MAX;
 
 /* add this memory to iomem resource */
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 579789600a3c7bfb7b0d847d51af702a9d4b139a..1ed21179676d05c66f77f9dbebf88e36bbe402e9 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -417,6 +417,10 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 
 void set_pageblock_migratetype(struct page *page, int migratetype)
 {
+	lockdep_assert_once(system_state == SYSTEM_BOOTING ||
+		in_mem_hotplug() ||
+		lockdep_is_held(&page_zone(page)->lock));
+
 	if (unlikely(page_group_by_mobility_disabled &&
 		     migratetype < MIGRATE_PCPTYPES))
 		migratetype = MIGRATE_UNMOVABLE;

---
base-commit: 83c34e70d8dd67525c2547e8c5ee1a4bf37ac06b
change-id: 20250227-pageblock-lockdep-9628c48d7e08

Best regards,
-- 
Brendan Jackman <jackmanb@google.com>


