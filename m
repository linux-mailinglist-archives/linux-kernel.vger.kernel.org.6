Return-Path: <linux-kernel+bounces-393692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6519E9BA41D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 06:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90411C20DCF
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 05:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5C415D5CA;
	Sun,  3 Nov 2024 05:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="SlZwHjrc"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F1515AAD9
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 05:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730611497; cv=none; b=iVSir40iKKpQ7a7expWuvnI4XVbswrEC2/xFDVcKLIzWqGVs0H2ubVZD5YP7jSN4E1pqSndw1wPFFO+NyZiiFOVpGIFf2QSs7xGwsogp3IlISSu1e7iOFn8fCGxMq/ag6/77KZRP5GJgiQi+4yjqNFQpzSaQ/nwOYYdYJVRftnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730611497; c=relaxed/simple;
	bh=tXmbRF7JGULYsZzWA5kM9IZCbzo0EHRzhvKrW+Ho9eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJZs0wJpY9Hk743ZvRBop4XVevAmnZTZ20VdEDg+fACOKfPFi4F311swj60j0qakiYqsnBJ6yyQsrPab1TYqQ8eTHWJQQsl5eBcSLZ2+2kPkg7EHIixEDhVrDZzNNq7+7ltbJ9T2cP5rWdEhgLHPUYYdJre6mJC53a5UUsEWZwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=SlZwHjrc; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7ee51d9ae30so1734057a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Nov 2024 22:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730611495; x=1731216295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHqyHgTj8Yctl5o5QmypsxoBptb79nPdd8vssXFP5EA=;
        b=SlZwHjrcaj7+vulCGRLuqsfUJ7ixUoiqyLDRMNAB7tDTdN34+utL2IPihTqCkBuYD2
         Q3rMho4bbBQIFAMKBJchTmO7c4E7GPuTgIIJMkKYzH5DG/eT4Ugg//tRpSPb62ZOnAjS
         qENn/qozNdG6LPKJGPSaYVXVX/+hl3U9pRgPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730611495; x=1731216295;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHqyHgTj8Yctl5o5QmypsxoBptb79nPdd8vssXFP5EA=;
        b=TaTpnMUIXg1qXCoqsSvjPIkw8aQedoVUQCL6JZUs3x3205L8VmXb7Z9bYM7axenw4i
         aEhfOhDci8wvyhZezyh6rPpfem48d8DvmQgHhflmYpaCD3AIcoCql0dBbR7LyKeF2m/c
         BPaxN+lrzvaio2YWompXUDyUXyZ5hmQVVnF3EmajlFTjLUL6s8DznonI32XUmDCFta4d
         EfZwIkVYCc/2tBM29YzYtsTUz3X6AJS0Q+MYPAb7ccictMAHnLgSTPRGatQk5iPrKRVb
         Zi4EbRdPcVfjIkN7iG9uwE39Kln8SRDzSOTAh8D3umt/BemrMT5UkFAR9Qlm9BefGLID
         l6Qg==
X-Forwarded-Encrypted: i=1; AJvYcCV+kS4ZYOOgEb5ofigXbrop6LBVouRb35lUr4++Hrn6pBUu8Ne3pnZ3Z6r+jp3p1WzEQkwsDi4HAV/+mwc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9K1U0kiKXsYG+KyKYXvNdB2oQ3P6PkIMDYyXjxGHWkr/nNmiu
	0pqvp/blmmsa5Yn8Yqa83q8Kot8C904KOWyM3NHX3jTKfw93cGhtWslx1KxqJHc=
X-Google-Smtp-Source: AGHT+IENywKvSiRm28xhWkoUEQdXaHm5KvA0KAcLepS71pu5DTuKIQu1baYegwQ40lDLoZPMPv7fvQ==
X-Received: by 2002:a17:90b:1f86:b0:2e2:d1c9:95c with SMTP id 98e67ed59e1d1-2e94c2b035bmr12820182a91.16.1730611494985;
        Sat, 02 Nov 2024 22:24:54 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93dac02acsm5896036a91.27.2024.11.02.22.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 22:24:54 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: hdanton@sina.com,
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
Subject: [PATCH net-next v5 3/7] net: Add control functions for irq suspension
Date: Sun,  3 Nov 2024 05:24:05 +0000
Message-Id: <20241103052421.518856-4-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241103052421.518856-1-jdamato@fastly.com>
References: <20241103052421.518856-1-jdamato@fastly.com>
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
index 51d88f758e2e..9d903ce0c2b0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6516,6 +6516,45 @@ void napi_busy_loop(unsigned int napi_id,
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


