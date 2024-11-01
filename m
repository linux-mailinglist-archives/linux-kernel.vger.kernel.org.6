Return-Path: <linux-kernel+bounces-391495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33F69B87DA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FB921C21696
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 00:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA09A7404E;
	Fri,  1 Nov 2024 00:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="JcTWJlvl"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D45381B9
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 00:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422164; cv=none; b=JNFRgf0KwRAqh1lmDP8kw2H1/GPaAofYyW2XWWormFsWUh8uksA8Z9wWynZspSrfKnvG42Ykuquqwx85VzqG34RXmryBB+9GXbNsKlRLI2O+UnIMoECnHtl/uBvgLk6A4ylQOGykT0OFq4N3se3Kv5SJeHq5iIcWKCVaGkrPGEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422164; c=relaxed/simple;
	bh=yc3wnUgFEAEEiEFhgZgC741hzb7w+J/HyVmirOX1Re0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=esz6IyO4SY270p7/+e4W8LLylytpw7dsOWj6+MhawAatRI8XbhyYKQTooI7+ivzB4gxmK37wNB/DnsYMZJ6smvpjfQ/d1UzvJIMzbfSoPjlsyYBJ7B28rFbautcpHT5iIv1NnjCUfaQSGMnGGKcwRZRV+CXCj0PyvVgCK/rnWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=JcTWJlvl; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-72041ff06a0so1236244b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730422158; x=1731026958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9Y5L1+xzJ293SL11vPNvlx36v2lWJ4xwPuQoBWQt1Y=;
        b=JcTWJlvl4+eJYmm+B0NfCqhhH7XXPvVSMmuLaJTewOP6oxSmrj0Z1eh5czdRDT0wxY
         WVUWVvGZIObFD/uWaUC0NaQm/v99Yg5QuwOL6jK59oZOzQS6z6u1YNQ2vXARgMlxoSOu
         2Vey8I1hdv/n0uFbyXHoQMoQjwIpm4Wq2G6jI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730422158; x=1731026958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9Y5L1+xzJ293SL11vPNvlx36v2lWJ4xwPuQoBWQt1Y=;
        b=Ilr2cX+5vTfOwYmZW0R5wR//CEdeUjGTmZTEHnYiG71D6SY/rNBwMdqWdn4PvS/f43
         z5OUVUunqm3nOUg66TnV7H0bV0dS0DUepaHNwEZpFour4ev4PZufTaZxqQx9n+CfMYwW
         PVBUYfUkjbOl4oaYSUWTeR/ffciPF6WNGQhQ93KceVuFa0Buurl8U3jQrTGwI4tIn7HQ
         XJfRLVwvNiBeucxyBYj9oIar5xqh4BdGXWjpuZibuaCMyRwgs+h5RyqKddgxIB3phf/7
         TZsiJNO7dA1ijIidcdpQMC7EyMwu1lb8C3jLsWcZRKq7zqxgn19vAGaOYRxS8Vhuyr3a
         jRFw==
X-Forwarded-Encrypted: i=1; AJvYcCVKN3BHcHYCHFWIx7j1ZcziarEbvm7CzAFPXgXdiL+AkPV1vbF0/dCoF+a0SWIQiXfth84oT+g4DrWr73Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV3Datd1NdubxQrBwecBBFadpvbe5RNvKZrubq3daUZOujBo7U
	vCAVJIWkrKpNCeUx+ZY1ZaRzFcmG2HAasVCefTL9BZxqF82Q7TPnK4IqzBdCQjY=
X-Google-Smtp-Source: AGHT+IExFtUEKMxFPR3RDSeM+CYyDqc3EqcQkSw+upklvNK8Ev/Io2BBe9ENsYMa2l8I0ymq9DRciA==
X-Received: by 2002:a05:6a21:e590:b0:1d9:2bed:c7d8 with SMTP id adf61e73a8af0-1dba55285d1mr2006068637.43.1730422157774;
        Thu, 31 Oct 2024 17:49:17 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee45a12c27sm1585365a12.93.2024.10.31.17.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 17:49:17 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
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
Subject: [PATCH net-next v3 3/7] net: Add control functions for irq suspension
Date: Fri,  1 Nov 2024 00:48:30 +0000
Message-Id: <20241101004846.32532-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241101004846.32532-1-jdamato@fastly.com>
References: <20241101004846.32532-1-jdamato@fastly.com>
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
---
 v1 -> v2:
   - Added a comment to napi_resume_irqs.

 include/net/busy_poll.h |  3 +++
 net/core/dev.c          | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

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
index a388303b26b9..143b3e690169 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6512,6 +6512,45 @@ void napi_busy_loop(unsigned int napi_id,
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
+EXPORT_SYMBOL(napi_suspend_irqs);
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
+EXPORT_SYMBOL(napi_resume_irqs);
+
 #endif /* CONFIG_NET_RX_BUSY_POLL */
 
 static void __napi_hash_add_with_id(struct napi_struct *napi,
-- 
2.25.1


