Return-Path: <linux-kernel+bounces-289918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C45F4954D53
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5951F22DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C1D1BA868;
	Fri, 16 Aug 2024 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E5yX+3ch"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA15817
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820956; cv=none; b=qQSiFVFaTimg/xErh38DjX4Hm6GRHtLSJLIgRHS+wEcDTzbx97X/8O3PfX9J+NGJPIjbYklDfNCwCVzJj0cnSo1WjozckE163TMfIF6jIt7ab4CY982RMGm1fSCawnFpm/hbFvSXVf7+XHcMKLTHwnK659W3xlrYryCSWnqXyCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820956; c=relaxed/simple;
	bh=IPYRS+wlZv7NhDT1X+YeVlOf8QM90aRrnLKsajcqnbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=baC2ThwJ/5O3Na4hzAJEzI7Csbv04bnbbSCMyieqcpWKrEFZqhaD+ejLtOYCJ8B3n5+jzyAG0AOqtcpr09iXGfrDwCtPc/3tHSkBy3hQgBxOqnRY6bqsz682nHN2sTDRk5D+vgu3cHvC7FYNIjuTRExpgwGs9KUmMLbFa0m7pfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E5yX+3ch; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so14548255e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723820953; x=1724425753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Y/2/2QPjp2CCrGuI9Ms5NRey/T6m/cyuOy2EaBJqus=;
        b=E5yX+3chdsCvQDfujrvic+QE8aUGpI4B1J73pEKkrP22nwpIq32HNQLvbaJgf9jUSl
         g8v/WUDoQECmB8J5sT0MffuKxLIwmDEKbpA41GDbFuT+hIaRvzUNuL38yqx0hqnFvBxJ
         9lTzPuDmqdNfBbk+bhFlz5cAgZLQhUe+xqhFqdBVl1qU+pEtNAtC+Cn+STIwEUi/8EC6
         qpU9/xKYi2Oaeer1T4hK5NRa2nRFSIUWhaW1DydTp0n1yMJXH2Md1aJ6nhAqKueRDtJQ
         3m0IL1J4Vu6afO6DN9YlMdnaB2xbiIUJ/qcZXfQ6zkm15a1yzWtTRW9sro5fVxmrU71Q
         /7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723820953; x=1724425753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Y/2/2QPjp2CCrGuI9Ms5NRey/T6m/cyuOy2EaBJqus=;
        b=eroFrkaiTpgp9GYi8OcVKPoTAdwZzXBvg04LcUSDHa2AVO3Zrt+KaQ/lFiO0xbsgGB
         6PjjxwpDa022XJYY1aB1r75VtcIQNY4Ggs9/LQdRR8qo4tlubHuxK2w8zaPtYHLVeVWr
         euFg4x0ZmbToHuGYZ+ATy7aoTgfj/RBqiGsGB1dP4zw+ZkoIXp+vW0HymCZBv6FFLOhS
         2le2+RbwJba+k0I31EAqpGJBBSylitkJheOJtr2G3ssSaLTLAUpvjDyWyZfdvI4TtDE/
         Qdpx9swGihbRXZh/p1mPLgHMOq33A3bU+L27tMAA40aytxoYZRIzIm8St8t8kRhTNThO
         qSOw==
X-Forwarded-Encrypted: i=1; AJvYcCWZvKgfX+rwkRx+ULVNv7o6ZHElHFLgwhLM6cIQpzU+VeLDIxwNmZfk5uEVnR2609NtNTIm2MgrFlRmK8qxYfSB/qrg5JkbVzQW0Z/D
X-Gm-Message-State: AOJu0Yz5IBSx/ODPqY06CcdCWmmn4lihmw4jYltNyr73dkGwiRPxsLD0
	W1+OvtXDwG7gqOeAcsfB0hv46jYYin3AZOaDVPN+NTQ6SR2jHLh7bOiSFcwVxMI=
X-Google-Smtp-Source: AGHT+IEGE7qid6bcOUge2vf5VRQJCQr3Rw2VNcuneDurrGavxMp9Iq5a+wqkSQwkgJJSGl/zhKx/UA==
X-Received: by 2002:a05:600c:310f:b0:426:5b21:97fa with SMTP id 5b1f17b1804b1-429ed7e432cmr25613225e9.29.1723820953137;
        Fri, 16 Aug 2024 08:09:13 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed648f3fsm24984675e9.6.2024.08.16.08.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 08:09:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] clocksource/drivers/arm_arch_timer: Simplify with scoped for each OF child loop
Date: Fri, 16 Aug 2024 17:09:08 +0200
Message-ID: <20240816150908.142142-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use scoped for_each_available_child_of_node_scoped() when iterating over
device nodes to make code a bit simpler.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/clocksource/arm_arch_timer.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index aeafc74181f0..03733101e231 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1594,7 +1594,6 @@ static int __init arch_timer_mem_of_init(struct device_node *np)
 {
 	struct arch_timer_mem *timer_mem;
 	struct arch_timer_mem_frame *frame;
-	struct device_node *frame_node;
 	struct resource res;
 	int ret = -EINVAL;
 	u32 rate;
@@ -1608,33 +1607,29 @@ static int __init arch_timer_mem_of_init(struct device_node *np)
 	timer_mem->cntctlbase = res.start;
 	timer_mem->size = resource_size(&res);
 
-	for_each_available_child_of_node(np, frame_node) {
+	for_each_available_child_of_node_scoped(np, frame_node) {
 		u32 n;
 		struct arch_timer_mem_frame *frame;
 
 		if (of_property_read_u32(frame_node, "frame-number", &n)) {
 			pr_err(FW_BUG "Missing frame-number.\n");
-			of_node_put(frame_node);
 			goto out;
 		}
 		if (n >= ARCH_TIMER_MEM_MAX_FRAMES) {
 			pr_err(FW_BUG "Wrong frame-number, only 0-%u are permitted.\n",
 			       ARCH_TIMER_MEM_MAX_FRAMES - 1);
-			of_node_put(frame_node);
 			goto out;
 		}
 		frame = &timer_mem->frame[n];
 
 		if (frame->valid) {
 			pr_err(FW_BUG "Duplicated frame-number.\n");
-			of_node_put(frame_node);
 			goto out;
 		}
 
-		if (of_address_to_resource(frame_node, 0, &res)) {
-			of_node_put(frame_node);
+		if (of_address_to_resource(frame_node, 0, &res))
 			goto out;
-		}
+
 		frame->cntbase = res.start;
 		frame->size = resource_size(&res);
 
-- 
2.43.0


