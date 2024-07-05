Return-Path: <linux-kernel+bounces-241877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D490792809B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 04:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033E11C22AC5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 02:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C491C6A0;
	Fri,  5 Jul 2024 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="m5p1vOxu"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C76A31
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720147877; cv=none; b=H+rN8F8TOxaz4KzPgVk8uFYQyhhDHpOisPAnCT763UXhy0O0KvBqwjMn561XhiYmFl4FRvfYDSMhHTNzpYbDlsrIA9KZ3piiQ0Tt5oLDmB7I/u+0odkuM+QIRmhaZmDz1a8Zl8tQi7T+Gg60Lfwa6f0gHNwJOMlW+k7Vs09LZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720147877; c=relaxed/simple;
	bh=+SqwYfC1A5+GjnJofMmf059emLsqPccapLMwF9uYPag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ty/FSlfbOGtBIw6Xyq6M8XOe2yhUJ5+W+n2qX1xdq5Tbgx9D9T5IcW4lvkmx5xwsS43353INfO/KQVp16WpsrVbotQT82xuh+CDSO8XdYAZEp8qI+9uPSX0w0MiAwPOpJUBzq8zuACaE0sgo1+yPqmReIvq0mrvTiyU6BwmRbPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=m5p1vOxu; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 88A2F41338
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 02:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720147872;
	bh=9juZtiYe22wi4ot7/n0osuKqapdtykb5hL7YDbGZMZY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=m5p1vOxurbLMii7GU5/Yu01JV0MTOEXp8E7aaG7+ppvHBqP6jXv4s3pnNIVsKHqYw
	 k8U4wfaXQJlfPqXzkwg/DQLX/poFTBSVxjbH/6uym5fyOygcHnlHOjw5TbtaAm8du/
	 c0LVCxRDO7YXyCdDEoEYPV8wsDAVU4OM6Pgz0X3BGyEg2+7PwwELlB88vI6BIUBVK/
	 Auht4bCGTNJgLkfh35AfMOVjxCu8gPud571GCcK3p7J3P+zhSw9KAtHNTbzB5y6gax
	 orYfwQ+7z5CxXc+ajKMDORFw8r65w59i6atw0GFMewEmyUm6c/lWCav8bJKgZtln1W
	 +fK9SV5jx95hQ==
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-70afe6e2d7aso788967b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 19:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720147870; x=1720752670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9juZtiYe22wi4ot7/n0osuKqapdtykb5hL7YDbGZMZY=;
        b=rcZlQPC4q0R1zut7q//Zck4gMKb7R/oNDtFpC8UTkKIwvX6sBiVlobETkz/lBURDUu
         N45agc0lserZADLvjHQMOB5duE5ng4owL3fljb7PkUdx4dtFt4G/cK+h84IweSMmOaRy
         4qOnfJbyubLgLrBSno7sS9IehelaZJFyu7RJyQ7wuMHFpGaIITczzTD5fDpTiyhD3AKq
         AE3s/XRQw4X7jiToPrbdrbGhQjZyUId725ObYI5AdZOwQtvv7hPbA1vb2mdNCWqiP81Y
         ucxySOliLAIuKH/sxvbiQj8teEMAzX9nu3yPrjQ/3QpphFVIHLk4Pl7IKhdlF39Xlawg
         b7gQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGRcGqz8CR8p2ftxKRFlMGMz4KqOWgdC08Yjri8NdAKUsVML3eAhIjQwb6koeGvMnTiJZtZ/VSiQC7DJUZQ/LiidnGcNwqxsssDkHo
X-Gm-Message-State: AOJu0Yw32UrZ7yQBMKlTwqRXcgkgB4lFFnBiLZF5AxWEgBKEyoSJH9UX
	PGMAUrn8PxC1V1SSY/Hk2Yx9M4NeNSx74h1lQYiJJCeVN/NaZnzvINHYClIu1UO3ApSZc4dNDRQ
	I5Z2mZaoklgRkYRodhVftqHQ9Z2s8S3GZ5myV/+EF8gf1GE+ZqSuikghbRUHVd4t/Jg2F84aBvP
	Ng8g==
X-Received: by 2002:a05:6a00:178b:b0:706:5bf1:586f with SMTP id d2e1a72fcca58-70b007eea27mr3847127b3a.0.1720147870094;
        Thu, 04 Jul 2024 19:51:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDMonNXypqZZHFPjZZyJ8kX9T0YMXjkP88/cDPPt/fAW4LrZB7+keFASdssrTHu8rT8jF3jA==
X-Received: by 2002:a05:6a00:178b:b0:706:5bf1:586f with SMTP id d2e1a72fcca58-70b007eea27mr3847107b3a.0.1720147869696;
        Thu, 04 Jul 2024 19:51:09 -0700 (PDT)
Received: from chengendu.. (2001-b011-381c-18de-5dc6-a962-e026-019f.dynamic-ip6.hinet.net. [2001:b011:381c:18de:5dc6:a962:e026:19f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708029582fasm12926379b3a.88.2024.07.04.19.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 19:51:09 -0700 (PDT)
From: Chengen Du <chengen.du@canonical.com>
To: jhs@mojatatu.com
Cc: xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ozsh@nvidia.com,
	paulb@nvidia.com,
	marcelo.leitner@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chengen Du <chengen.du@canonical.com>,
	Gerald Yang <gerald.yang@canonical.com>
Subject: [PATCH net v2] net/sched: Fix UAF when resolving a clash
Date: Fri,  5 Jul 2024 10:50:56 +0800
Message-ID: <20240705025056.12712-1-chengen.du@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KASAN reports the following UAF:

 BUG: KASAN: slab-use-after-free in tcf_ct_flow_table_process_conn+0x12b/0x380 [act_ct]
 Read of size 1 at addr ffff888c07603600 by task handler130/6469

 Call Trace:
  <IRQ>
  dump_stack_lvl+0x48/0x70
  print_address_description.constprop.0+0x33/0x3d0
  print_report+0xc0/0x2b0
  kasan_report+0xd0/0x120
  __asan_load1+0x6c/0x80
  tcf_ct_flow_table_process_conn+0x12b/0x380 [act_ct]
  tcf_ct_act+0x886/0x1350 [act_ct]
  tcf_action_exec+0xf8/0x1f0
  fl_classify+0x355/0x360 [cls_flower]
  __tcf_classify+0x1fd/0x330
  tcf_classify+0x21c/0x3c0
  sch_handle_ingress.constprop.0+0x2c5/0x500
  __netif_receive_skb_core.constprop.0+0xb25/0x1510
  __netif_receive_skb_list_core+0x220/0x4c0
  netif_receive_skb_list_internal+0x446/0x620
  napi_complete_done+0x157/0x3d0
  gro_cell_poll+0xcf/0x100
  __napi_poll+0x65/0x310
  net_rx_action+0x30c/0x5c0
  __do_softirq+0x14f/0x491
  __irq_exit_rcu+0x82/0xc0
  irq_exit_rcu+0xe/0x20
  common_interrupt+0xa1/0xb0
  </IRQ>
  <TASK>
  asm_common_interrupt+0x27/0x40

 Allocated by task 6469:
  kasan_save_stack+0x38/0x70
  kasan_set_track+0x25/0x40
  kasan_save_alloc_info+0x1e/0x40
  __kasan_krealloc+0x133/0x190
  krealloc+0xaa/0x130
  nf_ct_ext_add+0xed/0x230 [nf_conntrack]
  tcf_ct_act+0x1095/0x1350 [act_ct]
  tcf_action_exec+0xf8/0x1f0
  fl_classify+0x355/0x360 [cls_flower]
  __tcf_classify+0x1fd/0x330
  tcf_classify+0x21c/0x3c0
  sch_handle_ingress.constprop.0+0x2c5/0x500
  __netif_receive_skb_core.constprop.0+0xb25/0x1510
  __netif_receive_skb_list_core+0x220/0x4c0
  netif_receive_skb_list_internal+0x446/0x620
  napi_complete_done+0x157/0x3d0
  gro_cell_poll+0xcf/0x100
  __napi_poll+0x65/0x310
  net_rx_action+0x30c/0x5c0
  __do_softirq+0x14f/0x491

 Freed by task 6469:
  kasan_save_stack+0x38/0x70
  kasan_set_track+0x25/0x40
  kasan_save_free_info+0x2b/0x60
  ____kasan_slab_free+0x180/0x1f0
  __kasan_slab_free+0x12/0x30
  slab_free_freelist_hook+0xd2/0x1a0
  __kmem_cache_free+0x1a2/0x2f0
  kfree+0x78/0x120
  nf_conntrack_free+0x74/0x130 [nf_conntrack]
  nf_ct_destroy+0xb2/0x140 [nf_conntrack]
  __nf_ct_resolve_clash+0x529/0x5d0 [nf_conntrack]
  nf_ct_resolve_clash+0xf6/0x490 [nf_conntrack]
  __nf_conntrack_confirm+0x2c6/0x770 [nf_conntrack]
  tcf_ct_act+0x12ad/0x1350 [act_ct]
  tcf_action_exec+0xf8/0x1f0
  fl_classify+0x355/0x360 [cls_flower]
  __tcf_classify+0x1fd/0x330
  tcf_classify+0x21c/0x3c0
  sch_handle_ingress.constprop.0+0x2c5/0x500
  __netif_receive_skb_core.constprop.0+0xb25/0x1510
  __netif_receive_skb_list_core+0x220/0x4c0
  netif_receive_skb_list_internal+0x446/0x620
  napi_complete_done+0x157/0x3d0
  gro_cell_poll+0xcf/0x100
  __napi_poll+0x65/0x310
  net_rx_action+0x30c/0x5c0
  __do_softirq+0x14f/0x491

The ct may be dropped if a clash has been resolved but is still passed to
the tcf_ct_flow_table_process_conn function for further usage. This issue
can be fixed by retrieving ct from skb again after confirming conntrack.

Fixes: 0cc254e5aa37 ("net/sched: act_ct: Offload connections with commit action")
Co-developed-by: Gerald Yang <gerald.yang@canonical.com>
Signed-off-by: Gerald Yang <gerald.yang@canonical.com>
Signed-off-by: Chengen Du <chengen.du@canonical.com>
---
 net/sched/act_ct.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 2a96d9c1db65..6f41796115e3 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1077,6 +1077,14 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		 */
 		if (nf_conntrack_confirm(skb) != NF_ACCEPT)
 			goto drop;
+
+		/* The ct may be dropped if a clash has been resolved,
+		 * so it's necessary to retrieve it from skb again to
+		 * prevent UAF.
+		 */
+		ct = nf_ct_get(skb, &ctinfo);
+		if (!ct)
+			goto drop;
 	}
 
 	if (!skip_add)
-- 
2.43.0


