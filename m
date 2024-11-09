Return-Path: <linux-kernel+bounces-402660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24AEA9C2A35
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 06:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D889A284AAD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Nov 2024 05:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C12B145A1E;
	Sat,  9 Nov 2024 05:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="t/evmyu8"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FBE13E03E
	for <linux-kernel@vger.kernel.org>; Sat,  9 Nov 2024 05:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731128589; cv=none; b=u6hvAms/1FuE2NLhBSr4lB8aO3Q6jf8zmQrVqHshywAEnFGyb+RmS8Iae1JCT0Rjz8E2+/wh1BTfI7+obhWRnPgsc0zrI16bt8TYaOWRbEoSRl9/4ZBISx5A/m1wPq2UpiCcCnIl2Fw9AVL97urOMK4sCR+uGb7D3cXlbbfWSAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731128589; c=relaxed/simple;
	bh=7YkKWB/VoyUXO1lGGm/ESxIvFChf/k/+Rh3/h3kzr9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jqq71nN8XKhCiD0EEZ0gU2VB2vYMQ/y6YdhiGaYmHSU8Mwm9qOQOczuZ8H3lcFFKbgZ3RukJn0nkvhYQ2tTyaiLUGofhKB+eUK5TiWnaWizNyzeyMuCtnMR5BR0V5+asVDIZZoPttoBSqIfGKK1JkSdYCOQqY8/UiWf3zLLpq+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=t/evmyu8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cdb889222so31088555ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 21:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731128587; x=1731733387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HzDb2SxhUo/TAU2Mmq5phfYmvXMmtRzJHslebclKIo=;
        b=t/evmyu8G4ny8Jj6n3S6uWHTe17BFJZAhatSr6DDRc8Ln8hL4O8YtaDMM8ulvpLiN5
         q5oo7IOkdsp1eakLyNNeQyfN/M7HuPlGdM4/fjkCWddtoz9DDfUUeztN+pvZrwGu8yBE
         MSffHIoLcc9KMa/BQ44jQLGKXwJpciRdqdGDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731128587; x=1731733387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HzDb2SxhUo/TAU2Mmq5phfYmvXMmtRzJHslebclKIo=;
        b=IIn9H4P3gReH0v1dkQ6HRp51Cw4OgCTr5tGYdiRmfWcQywtK/t1fTGXayBqr4ZBr2f
         bBx0TFvB5ZlYGEgcWaCfjWLvb9wWQFO3u27/SNGyFQkZAyWGPEMehOGM9Oz4BxEozKH3
         R8kHFT8KquEFo6334Mhq8Rb/ztelH7b7cxr71KxajWrI2OX1EDPv6vsqyEjG8GaFWtMK
         WHT4FXBORvDXOxWCiRrRRfWp6gcr6B6pLwvZYiuAcxUk2FL6rthybM8vlsZXO75Fbukm
         DCZlKvOLCN2YMXs2VbwfP5hK/734w9v7hz5WljvIR1c+ZVoCZ8CrLt1Cxj+n5cCk6vo5
         3bAA==
X-Forwarded-Encrypted: i=1; AJvYcCUEVAghGz/yjeB37rVwjA8gZoxImEDpL3Po2gZ1DRi7jtNz7RZdrZNoEKItuSeF9jKy8FidX0g2PZ/ZiLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye9v9j4NBbQovzoZuhWWINeO65MS8tMRZpxutlgf14XzeJQL6z
	YQ6l0G4LbDNnJt200h9meEiZ3tV1wLVSLVsdBcB8I0MK/jid1fRzXfutXKOnQm8=
X-Google-Smtp-Source: AGHT+IHzB6H5fYYWLx9Q/0EgCmqqmoSLpb0RpBfHo0MP/hNXaD4wRBqJGO7LLl2PREd6yNCUXUCBSQ==
X-Received: by 2002:a17:903:234c:b0:20c:8907:90a with SMTP id d9443c01a7336-211834f3291mr77516525ad.5.1731128587405;
        Fri, 08 Nov 2024 21:03:07 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5853csm39182305ad.186.2024.11.08.21.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 21:03:06 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: corbet@lwn.net,
	hdanton@sina.com,
	bagasdotme@gmail.com,
	pabeni@redhat.com,
	namangulati@google.com,
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
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v9 2/6] net: Add control functions for irq suspension
Date: Sat,  9 Nov 2024 05:02:32 +0000
Message-Id: <20241109050245.191288-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241109050245.191288-1-jdamato@fastly.com>
References: <20241109050245.191288-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin Karsten <mkarsten@uwaterloo.ca>

The napi_suspend_irqs routine bootstraps irq suspension by elongating
the defer timeout to irq_suspend_timeout.

The napi_resume_irqs routine effectively cancels irq suspension by
forcing the napi to be scheduled immediately.

Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Joe Damato <jdamato@fastly.com>
Tested-by: Joe Damato <jdamato@fastly.com>
Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
---
 v8:
  - Drop unneeded exports as pointed out by Jakub.

 v7:
  - This is now patch 2 instead of patch 3; patch 2 from v6 was dropped.

 v1 -> v2:
   - Added a comment to napi_resume_irqs.

 include/net/busy_poll.h |  3 +++
 net/core/dev.c          | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
index f03040baaefd..c858270141bc 100644
--- a/include/net/busy_poll.h
+++ b/include/net/busy_poll.h
@@ -52,6 +52,9 @@ void napi_busy_loop_rcu(unsigned int napi_id,
 			bool (*loop_end)(void *, unsigned long),
 			void *loop_end_arg, bool prefer_busy_poll, u16 budget);
 
+void napi_suspend_irqs(unsigned int napi_id);
+void napi_resume_irqs(unsigned int napi_id);
+
 #else /* CONFIG_NET_RX_BUSY_POLL */
 static inline unsigned long net_busy_loop_on(void)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index 4d910872963f..13d00fc10f55 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6507,6 +6507,43 @@ void napi_busy_loop(unsigned int napi_id,
 }
 EXPORT_SYMBOL(napi_busy_loop);
 
+void napi_suspend_irqs(unsigned int napi_id)
+{
+	struct napi_struct *napi;
+
+	rcu_read_lock();
+	napi = napi_by_id(napi_id);
+	if (napi) {
+		unsigned long timeout = napi_get_irq_suspend_timeout(napi);
+
+		if (timeout)
+			hrtimer_start(&napi->timer, ns_to_ktime(timeout),
+				      HRTIMER_MODE_REL_PINNED);
+	}
+	rcu_read_unlock();
+}
+
+void napi_resume_irqs(unsigned int napi_id)
+{
+	struct napi_struct *napi;
+
+	rcu_read_lock();
+	napi = napi_by_id(napi_id);
+	if (napi) {
+		/* If irq_suspend_timeout is set to 0 between the call to
+		 * napi_suspend_irqs and now, the original value still
+		 * determines the safety timeout as intended and napi_watchdog
+		 * will resume irq processing.
+		 */
+		if (napi_get_irq_suspend_timeout(napi)) {
+			local_bh_disable();
+			napi_schedule(napi);
+			local_bh_enable();
+		}
+	}
+	rcu_read_unlock();
+}
+
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 static void __napi_hash_add_with_id(struct napi_struct *napi,
-- 
2.25.1


