Return-Path: <linux-kernel+bounces-361097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAE999A362
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 14:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6898282227
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E00217902;
	Fri, 11 Oct 2024 12:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="cc3TZb/s"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51022217311
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728648464; cv=none; b=uvmyzgDqWgJF2vGFct9czZHwyEfFiPlvMhAN3P8aOgvRTUcLS1PTXFD7IkPZlrqQ/C0K5vI2weZ2gxOgh48s2dDshmBAQueiRQP4yoAYJiW5HiLXvBv/ttx/26cow/oK8mzIA10GE9F9FXtLWoHt11HzkoQExw0FjYNWXqkuxgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728648464; c=relaxed/simple;
	bh=SF1VrBVIUYVlGK8EW+BWjD8waL8T6j7uZViDZCsuV28=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RW40dwcwFWbFVhILurCpzptCh9elUDVX8Jj2o9VdIrrTBgHQjn+207kbP8MFNTjNIBTOOShfrClgrZO64SPpW0zQ2plMLvsHurMzA5X8/IhE1tidpTL+1AfqOxpC43sOIQUyHyQvKcN36Ly5vLbFsVKeKeIy7OoctIgFy+dwjMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=cc3TZb/s; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-431126967d6so16723835e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 05:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1728648461; x=1729253261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Al1zJR4+ZVpH1JbQFkIWa/uoqZRxnaZwnAqoh4d34IM=;
        b=cc3TZb/shSXedn7Hl2pQHf2xL6SVTfemW310awpbXDsSAiNibacWmWmhLmJF6BO0n7
         QJtCoNRPf3KMQ/37DQBQXvQoPFhuiLe2Gyi3npaT2pgtXs0kB1g+M0R9a+4+9XLSGetf
         PtzFwpcsQ4CVGD23sKeo0aQOVk3tPPi/WidVnHdVYy2RVvnvTcXFZGmD+Qb3ok+294Jl
         CQuNxmZq7lpJN0UDzdmFAhniew/HH5Lg6oypF6VSUS3EDM0sITy+U+3mw1b/8UYGmX3s
         iGb+/j7uk95tPYGi1R7U/XJatYFtQ7gggVajEpBuz961yIkiCgpcy8Ljp5do6HUZJwWj
         TQow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728648461; x=1729253261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Al1zJR4+ZVpH1JbQFkIWa/uoqZRxnaZwnAqoh4d34IM=;
        b=kALgWTUfkssF42czye/7GdxQXCpGrqL1RPWxnaRoG089hvLfM1lRkfTwhfjLyydRCt
         7LW16J8ka4fvexFzd+JFq4JeK6UeCextLPfVqWE0asuwmjBvBdX/Ires+QefJdJpdhSK
         jC4Xs28m6k81xfqUEA5mrLydGajXBajNPCIq1q+0/9vg3G+xWFwZLj0YAkGifEqbF/id
         lJI7Jdgm9LMY2TmrqrW7U18AbcdgvrjDHQ5sIvtwXk1OnOiU9i8QBhvXMnRpKGkYHVBs
         iSH+O/2A3OfDWrEyP8w6dceOKNmb2PBb4YVSkQhyLKBK/z29lwkbDCJdOhyKwQIOBiaF
         BCnQ==
X-Gm-Message-State: AOJu0YxgDZnHbcCP6IC091aYSRbwWlJCQN1bGGvgbBbOm8Rih2EzRy/b
	IotNVLD+gRYiJnderoy+GdjAqlEm+v8xETWu82PGIsxJ772jo/5+HujMLMCbyMI=
X-Google-Smtp-Source: AGHT+IEE5Py2nNm8l22l9+7wDPQ3SVtWve+Jv5RgOHbELCq+J5dilgxxm8KuJJzcQBPXjSaoSaW9pA==
X-Received: by 2002:a05:600c:3b0f:b0:42c:bcc8:5877 with SMTP id 5b1f17b1804b1-4311dee7281mr21889985e9.13.1728648460522;
        Fri, 11 Oct 2024 05:07:40 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac1:2880:f0::179:225])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430ccf1f696sm73098755e9.5.2024.10.11.05.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 05:07:40 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	linux-mm@kvack.org
Subject: [PATCH] mm/page_alloc: Let GFP_ATOMIC order-0 allocs access highatomic reserves
Date: Fri, 11 Oct 2024 13:07:37 +0100
Message-Id: <20241011120737.3300370-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

Under memory pressure it's possible for GFP_ATOMIC order-0 allocations
to fail even though free pages are available in the highatomic reserves.
GFP_ATOMIC allocations cannot trigger unreserve_highatomic_pageblock()
since it's only run from reclaim.

Given that such allocations will pass the watermarks in
__zone_watermark_unusable_free(), it makes sense to fallback to
highatomic reserves the same way that ALLOC_OOM can.

This fixes order-0 page allocation failures observed on Cloudflare's
fleet when handling network packets:

  kswapd1: page allocation failure: order:0, mode:0x820(GFP_ATOMIC),
  nodemask=(null),cpuset=/,mems_allowed=0-7
  CPU: 10 PID: 696 Comm: kswapd1 Kdump: loaded Tainted: G           O 6.6.43-CUSTOM #1
  Hardware name: MACHINE
  Call Trace:
   <IRQ>
   dump_stack_lvl+0x3c/0x50
   warn_alloc+0x13a/0x1c0
   __alloc_pages_slowpath.constprop.0+0xc9d/0xd10
   __alloc_pages+0x327/0x340
   __napi_alloc_skb+0x16d/0x1f0
   bnxt_rx_page_skb+0x96/0x1b0 [bnxt_en]
   bnxt_rx_pkt+0x201/0x15e0 [bnxt_en]
   __bnxt_poll_work+0x156/0x2b0 [bnxt_en]
   bnxt_poll+0xd9/0x1c0 [bnxt_en]
   __napi_poll+0x2b/0x1b0
   bpf_trampoline_6442524138+0x7d/0x1000
   __napi_poll+0x5/0x1b0
   net_rx_action+0x342/0x740
   handle_softirqs+0xcf/0x2b0
   irq_exit_rcu+0x6c/0x90
   sysvec_apic_timer_interrupt+0x72/0x90
   </IRQ>

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: linux-mm@kvack.org
Link: https://lore.kernel.org/all/CAGis_TWzSu=P7QJmjD58WWiu3zjMTVKSzdOwWE8ORaGytzWJwQ@mail.gmail.com/
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8afab64814dc..0c4c359f5ba7 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2898,7 +2898,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			 * failing a high-order atomic allocation in the
 			 * future.
 			 */
-			if (!page && (alloc_flags & ALLOC_OOM))
+			if (!page && (alloc_flags & (ALLOC_OOM|ALLOC_NON_BLOCK)))
 				page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 
 			if (!page) {
-- 
2.34.1


