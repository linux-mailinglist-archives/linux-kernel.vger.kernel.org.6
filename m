Return-Path: <linux-kernel+bounces-373548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4449A58B0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 03:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E9C7B22059
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 01:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD2845005;
	Mon, 21 Oct 2024 01:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="lZ7Rwt1I"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42C93EA9A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 01:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729475636; cv=none; b=qALCHyVm34v2M3ulNeJngAsA3ZqWXyjFLENXikJa5h2jMKgz8gVU1jh9K1K1rrmlrz0ezFJ+vgc0C/kDwzXpBP+HyLBzkVM9tAgYEywxxXwxpmAZOqAOY2yhwvltpI4FBb7ywjgsWVoIPK5eEq05FLbd0U7VkYYEM0p1cQXELUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729475636; c=relaxed/simple;
	bh=j/xq+NkIfYdhz94qa/CP8OLzI/XZjv3RfYV1I/panlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H/FCQhr2di83Plywnh6mD6wd6QrnvDjoSP9HcJ4JYNc5YGWQiuKVMVeZVDvjIhF0QduCTVWz0dKfh+YGU/eFxL2dDSUpB806+AWbpKe4ELeVsBW3a9gYVMznPxbB6XNlbjapTBcVT7iNgwmMKGAKknmdhbvIVAJnVQc7aSDiPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=lZ7Rwt1I; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c77459558so33158265ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 18:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1729475634; x=1730080434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UTXGBPwWb2UjgB4YRsP1U7o6ISppA/AhjO8WcV0ADKY=;
        b=lZ7Rwt1Ijr1N+kRYA6bsUYdYehqVJbTHzS1U9g6IC33+L5oDDi03q4w3XR/AUg4Mmz
         M6xTrSLhCRhkykHAavaZYBHYM3b/eUehrtup1kMswrPAf8LbP+ySDuYu/MxDXPltwqEb
         fLrEFUaEy8IjLdMcdemTtnxVxouL70tvGLgo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729475634; x=1730080434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UTXGBPwWb2UjgB4YRsP1U7o6ISppA/AhjO8WcV0ADKY=;
        b=JBTGW9B0hMVpKEs0UrmtPm4V/TSmaxAg3gNOG6AJ6S1fvTcwgC9icRbm0yD4ueFrbe
         yBVCMPIdyeAjzlrTFK8e4Nykr+HJbc3aAKxEW8UsETHbmOn7EY4hx4OMhj0M6AT2M+Qz
         StEzJP+1RBRFu+3uSqtpmJqQzsW7cc9J/7XvMi7bohF1DxFKJglyzTVpL2wO/H6ytVZq
         GMZjRfJJkq3GfZQVs+YSfumBem+zOjXBUegHOub/LNBRK45Q7mGmKFusI1k/BU+cZNDn
         m8M+63jgdV1M3UpFgngFGlQ4BH12yPzvR9plb4kdiP6+BqrKLo2FDeXUSpK5+aqWAsjA
         hDPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHVHpRmuO0GsVffTdR5rZYxpBM4Al3ZvlSm3moZUuFiFwj8bkTzwajpZEAovfGoSKlPvDa9b/ytztpjUU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6yeUGEiYk9cKyizoSi8UB+Bpi9zQcf5kj7idyX/wxUq6mDv3C
	xppHkkb6y1D75qd+mc0j0Raub08m4Nhphu0q9poQewFrkq3N3BHMPEyxL8Tshk0=
X-Google-Smtp-Source: AGHT+IHwIA2NfupKP85DHpqMkbeTwP0qaJp0Gh7HUU0pAgnV6BG8mMO/V6AL9FsCCHPaR3ALMNsp4g==
X-Received: by 2002:a17:902:da8f:b0:20c:c18f:c3a0 with SMTP id d9443c01a7336-20e5a728241mr140048925ad.7.1729475634077;
        Sun, 20 Oct 2024 18:53:54 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee650bsm15859985ad.34.2024.10.20.18.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 18:53:53 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: namangulati@google.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	sdf@fomichev.me,
	peter@typeblog.net,
	m2shafiei@uwaterloo.ca,
	bjorn@rivosinc.com,
	hch@infradead.org,
	willy@infradead.org,
	willemdebruijn.kernel@gmail.com,
	skhawaja@google.com,
	kuba@kernel.org,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v2 2/6] net: Suspend softirq when prefer_busy_poll is set
Date: Mon, 21 Oct 2024 01:52:57 +0000
Message-Id: <20241021015311.95468-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241021015311.95468-1-jdamato@fastly.com>
References: <20241021015311.95468-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

When NAPI_F_PREFER_BUSY_POLL is set during busy_poll_stop and the
irq_suspend_timeout sysfs is nonzero, this timeout is used to defer
softirq scheduling, potentially longer than gro_flush_timeout. This can
be used to effectively suspend softirq processing during the time it
takes for an application to process data and return to the next
busy-poll.

The call to napi->poll in busy_poll_stop might lead to an invocation of
napi_complete_done, but the prefer-busy flag is still set at that time,
so the same logic is used to defer softirq scheduling for
irq_suspend_timeout.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
---
 net/core/dev.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 68d0b16c2f2c..a388303b26b9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6235,7 +6235,12 @@ bool napi_complete_done(struct napi_struct *n, int work_done)
 			timeout = napi_get_gro_flush_timeout(n);
 		n->defer_hard_irqs_count = napi_get_defer_hard_irqs(n);
 	}
-	if (n->defer_hard_irqs_count > 0) {
+	if (napi_prefer_busy_poll(n)) {
+		timeout = napi_get_irq_suspend_timeout(n);
+		if (timeout)
+			ret = false;
+	}
+	if (ret && n->defer_hard_irqs_count > 0) {
 		n->defer_hard_irqs_count--;
 		timeout = napi_get_gro_flush_timeout(n);
 		if (timeout)
@@ -6371,9 +6376,13 @@ static void busy_poll_stop(struct napi_struct *napi, void *have_poll_lock,
 	bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
 
 	if (flags & NAPI_F_PREFER_BUSY_POLL) {
-		napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
-		timeout = napi_get_gro_flush_timeout(napi);
-		if (napi->defer_hard_irqs_count && timeout) {
+		timeout = napi_get_irq_suspend_timeout(napi);
+		if (!timeout) {
+			napi->defer_hard_irqs_count = napi_get_defer_hard_irqs(napi);
+			if (napi->defer_hard_irqs_count)
+				timeout = napi_get_gro_flush_timeout(napi);
+		}
+		if (timeout) {
 			hrtimer_start(&napi->timer, ns_to_ktime(timeout), HRTIMER_MODE_REL_PINNED);
 			skip_schedule = true;
 		}
-- 
2.25.1


