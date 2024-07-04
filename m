Return-Path: <linux-kernel+bounces-240814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 480A6927323
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0653628240F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E271AAE04;
	Thu,  4 Jul 2024 09:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BqeXAgxq"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DF6748F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720085752; cv=none; b=Rpbo7nx5pvswgk5/BQ2VxzaNPXJ2PwGsaXn0EJHHjGGhH4tlw+ZwAfKi1tsuU90I39+xSCmlLd2FK50WKZsFWZtqnKkqYs7xfLNfGo2REVQSTrmCMRwlKuOvJiWoW9gXKrOH6ormm20naop3rmEtmbrYuD/4sp/3nLKRS/o8JpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720085752; c=relaxed/simple;
	bh=Oy7dKvHiGFYXx+I7lg+7RcbtYemeYKr5TDO40BXEiQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iUa4i5PVXxFMvFul8xVPsyTfEzc8iQdLt3F85X1JzjZ4UwDsictgLKfr2GBj7Z+HLH5+92xafvPNk4tPa+een1aESfa/cTHWlp1OdTWd9r3rZZBuYOSxtMkWWAWXaccv0iKna5Ps7mJHNxYG6nu3th2jrOAiabNfzpiUZe/3mLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BqeXAgxq; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0BB6041339
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 09:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1720085743;
	bh=wiJxNUkYycJsSDpu62b6poSEZxZfrfFCF631xd6P5LQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=BqeXAgxqcrdV45sk9xOM7lRosB1soHhpNIWWVM7GBGLNspO6K8ZhDvhcv7ytlM62Y
	 BikOrPveuJh9DIt2PRcvrwNIefEyRdb/4iwCMaQGTWL8bWeF2aXMXd+AMBHzUb/7Df
	 5RRrqmAf0/sEBkj8g2+ctslk9UsLOoYwC26Roq9Oz1WJE4CzHBB7XeEvmHFE1qUhTU
	 gVu7TIHe1pfKm2UNsMoP2hiW3vNV0s3eMnbXuTT7dNMVbm83sS956Z2aCKvn/TAMIk
	 nkQTCCj+aHA3sM4/cS5fiQrJAEfn0b5gSXwcnenaRagwdOgeV9syLV4ccfWhjIu05w
	 oqf5P/GsYRt8g==
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1faad2eb0a3so12530345ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 02:35:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720085733; x=1720690533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiJxNUkYycJsSDpu62b6poSEZxZfrfFCF631xd6P5LQ=;
        b=FUtJPEJ+TceGJIaiNeffb4yOG8W1gTCc0GGl/hewqKogYkt6Qs8F+DpeyGz2hrxIPL
         /wXgoLndfC0gjjpzlTOuRs+nik8D/gvHvV8oo2kcFqOW4rx+I0IAhtz2YKzd3N0UWy5v
         Xn+6NxYj7cT4lFEy0oMashAXBZ6VQ1+R7D++qXWm8nE/MTfHnb5vnnUqfwQflJtbuH6j
         FVk3J5zvFX1ix1Rtcc+DhzdSnCx/cNY/vbo1ng4YwtvJktiCA7n5c89OHNm+fTyhhIjF
         yyVhKohuCrnk4YiedLOUG9RPYqe9ZihdX/WGP8dyYZVBBXx/gXduV0ws6id/1FonQwPM
         EvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWHlByzIDQkWyAsQnFAiLbqA2lCxbw4dSrE+Zz+yuhAtx2BZlEt49DPCraAj3dVfeVyLKpfipu5xPG4inl1+V6/XDRDdqdYHvU7ICZ
X-Gm-Message-State: AOJu0YyNcMhYymwm5JionRkz8aRnrZ4u2k7XxiXpylzTNn7LvQLW37/p
	KuQtdUpQ1Za2RTaQIsPK/SWdC5bNa0scPONRb3KlKl3UbmbzrftdO6WHZOGzS7o1A2dSDMqdFUB
	E1Q5VE9ZY61oe1O9tcuh+nYTyfTNa8+uD2Yb4ljgyJEq/tnSH6KlnuWvaLztvQMzViDFl2jEmC5
	3lVQ==
X-Received: by 2002:a17:902:cecb:b0:1fb:2e1d:acdb with SMTP id d9443c01a7336-1fb37047770mr13990575ad.12.1720085733622;
        Thu, 04 Jul 2024 02:35:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOXt2HSyqcWAnEGOSShpHjEDdGJVAIPy5yyNQs45QakgMU34R+QMFUZG8sl5Weo2rhUKkcsg==
X-Received: by 2002:a17:902:cecb:b0:1fb:2e1d:acdb with SMTP id d9443c01a7336-1fb37047770mr13990185ad.12.1720085733186;
        Thu, 04 Jul 2024 02:35:33 -0700 (PDT)
Received: from chengendu.. (2001-b011-381c-3667-42c0-8e79-026a-04b5.dynamic-ip6.hinet.net. [2001:b011:381c:3667:42c0:8e79:26a:4b5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15992a0sm118498515ad.263.2024.07.04.02.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 02:35:32 -0700 (PDT)
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
Subject: [PATCH] net/sched: Fix UAF when resolving a clash
Date: Thu,  4 Jul 2024 17:34:58 +0800
Message-ID: <20240704093458.39198-1-chengen.du@canonical.com>
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
 net/sched/act_ct.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 2a96d9c1db65..079562f6ca71 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -1077,6 +1077,13 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 		 */
 		if (nf_conntrack_confirm(skb) != NF_ACCEPT)
 			goto drop;
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


