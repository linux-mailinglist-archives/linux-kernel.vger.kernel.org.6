Return-Path: <linux-kernel+bounces-401075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FA49C15B0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 05:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31EA281A8A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 04:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726671D0DC0;
	Fri,  8 Nov 2024 04:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="iFoAc/vz"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D541D0143
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041676; cv=none; b=dLyL0B4O+BQXefoAXQX3i9FU82hNpxu3YLzB/1GkRZKgN7Sq1Z6YjQjYheaqFFg++DQ74xlwQdsu0COfz6o89wVNmSgw+85GlvKrywPyFqs/NhmzHHZQxWBQDYUfRPEwXtFOLGOg8mmryf4/GtDRmUjcmp4/JTQd2uS6y/NvN+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041676; c=relaxed/simple;
	bh=7YkKWB/VoyUXO1lGGm/ESxIvFChf/k/+Rh3/h3kzr9I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kd2H6EbQ3FB9+utDxBQ/KVQF4frHBd/AvSyjyCiqfY9iHl2g/rzBJV4t03wSq8QKiBZZSHa5ItaARhL27aNy6hIhBJaEaQJI9JEsGbkxwBmZz7zCOk1XAekFcd5SYs/cVBYDxSN6WDOrR3qe4D4DkSp0XBcRll6qfXQwLENkAIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=iFoAc/vz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e5130832aso1349991b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Nov 2024 20:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731041674; x=1731646474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7HzDb2SxhUo/TAU2Mmq5phfYmvXMmtRzJHslebclKIo=;
        b=iFoAc/vzXPWM7rGONNMVfuJZOBhaRmKILtBNHFE72yJI4VwwVg37CzoQNGcXopgaXx
         CxozVsqgqTJ5yhCIk4npVpzaX5xgRqu0kd7epVK9IhXXfPfunx6Pgjh/owCzn4ohgZCW
         HxIqgJmIHGVjS7Ry/ynM0eLiEkM4JbI8QMmhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731041674; x=1731646474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7HzDb2SxhUo/TAU2Mmq5phfYmvXMmtRzJHslebclKIo=;
        b=kB2VAE12yxEmWMK6R9POAcpVPQ0FHMXUiJhevnXzmtlRf4dV4B4qAe/LnqXqDdiNuS
         gqb9slZouVnQ5EI7Q4RYrc7AvQd0Ny92a0dsiBt/39YbCYepx0j49ypj2CQW4tC1ohHt
         YssIQLwI7w0DoMRw1DkkotD9HCcJxAbuOoYkt4k/iW437Nii4SXJeSy1ogbIqQ6GT4y9
         WCKR01UnA1hBWqSoiHhV86wuqBnwxzwTftJMuguWzMJSqk1yqrag+ZZt/yVFshD+3jgS
         H3VZp3GRWMHzXXWtfOi9CwtkBDn0h3TqNmIE1tqyp/hsu3/cmY776LtNo3hN3CyBAn8l
         3ILA==
X-Forwarded-Encrypted: i=1; AJvYcCUSa8T4IjH9k1txCakPmi95ql5+NUA6FqtfjqTPP2DKMV8LM4N/5Nr7SdHFtAq81zmHTiphe3vGcwTChM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRJhtjew22q9qQVNdZwr+UMyBMvudDVFoSZ/96hpS7PmCy81lM
	etJwuo/DoL5HlD0ekL1uRimwWB/a/qXFfXAZ7jocX4wHK7b+UbJb6sfLnMj10R0=
X-Google-Smtp-Source: AGHT+IEYoTYWD1MwcFzklk4B52PngXJWpvZ1zPtgDvh5khNNQq/roN1uxX9wyCPMvqH5KMcRkeoAFA==
X-Received: by 2002:a05:6a20:1591:b0:1db:e464:7b69 with SMTP id adf61e73a8af0-1dc229a402bmr2124072637.20.1731041674610;
        Thu, 07 Nov 2024 20:54:34 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7c76sm2697476b3a.48.2024.11.07.20.54.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 20:54:34 -0800 (PST)
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
Subject: [PATCH net-next v8 2/6] net: Add control functions for irq suspension
Date: Fri,  8 Nov 2024 04:53:24 +0000
Message-Id: <20241108045337.292905-3-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241108045337.292905-1-jdamato@fastly.com>
References: <20241108045337.292905-1-jdamato@fastly.com>
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


