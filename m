Return-Path: <linux-kernel+bounces-446743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF169F28A4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9DB188618A
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CB61547E4;
	Mon, 16 Dec 2024 03:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0M3sZ+4"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391EA1BBBD7
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 03:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734318747; cv=none; b=Sbr2pQksbIM1621ArXRKQr87NXusgXNzlHD3yc4eU9DYP1jTaOYaLteU1lnh2f0p+GJKdpxXEXMHyl888kmlQhFkMNJe9X3NhxGErnjrv8DdjJopZN46jeF4Wd3Kf5e8yVogdWFIaYsoWeVk4sHUeeWdub1e4Wnf/Ga7fJXG+Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734318747; c=relaxed/simple;
	bh=tw/sZ6xyV0Pw2jZXspaHJWiWfZ9xSORxU2ivpIey0fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjyuU763bCXB2me+TQL7xZ1X/JLvdyF1TEUO1X3F4YvefNQDIwzCR085tV/nrg5Y5ienHE0hqCHqrcNTAatpRY+8iSvlo50zJyQkOTty0MyUlMP/tFdYK1FcD6/005dPTH4Cq2YiKbc/IyZ2GpAYhPWi1XwA21S02ekWztG4IfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q0M3sZ+4; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-725dc290c00so3556415b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 19:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734318745; x=1734923545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K16k0CtGst/uGn1z/pOeYRcdvDetSUcyUB4347UZ9Ic=;
        b=Q0M3sZ+4JJaOdUD1yurVJpg+DkL1NHgM2OO7Fagg9LL6mj9bdXTzGDCK8FzpaGi8eD
         i6dCeDqqkPduHTGslPZWxAQyzOxMDTNxRtEWSXFj+PxlrXiZKcmIEx0/p9MRcnD4ocgw
         8mD3ap/YhPOKQkl7w7zYIGBwhtI6W/aLbjiXCNk+l9Y3BpE8bf4HeDJ+PqraR4BhT8hm
         seqeRTfp1QM+NjmNDJIb7dWkFQ7Gk+C27HoWknZ1vSzT3FdF3Ogc1VlNVg/rfXp6Pflq
         G2dySHek9Yun9mkTEv7dssCTzl/BrBPml6qfIyknPOpUcAwMUjP2k6++CQ6xGD1d1+9R
         kPRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734318745; x=1734923545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K16k0CtGst/uGn1z/pOeYRcdvDetSUcyUB4347UZ9Ic=;
        b=wURhqimjLMGYVsvJ4Pe/Q2XVbTzC4rcLX3HzOmsQzTb+xSRrxwBaUq7KTqv0slXqFm
         hrgXBh3OZ0YWYIBCxt9Sn87ocHMUEhZ01KRWgkHfSemplo3xgFhBVcCv2AbzDq++b3iA
         XImw5WLwm+HqTqEoR7PbGpbf2WvEeAstssin4Eu4Fhkuc64ZNgB1rwURZh2s3vT41luA
         3dd/nAB0kISZgqZ/k1RJZ6JZrOMLP1MejaFHFuXfbA/Zt7qfEK7J9U09hmAn1QgCAhBR
         bavQkBmk9Lo+ucTW5F1AAFnTNml0ySxiuZde7lHe7RJLxjma5nwYSHM+jbnyA0h/vPdr
         Bi3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUM9OVLzN/Cnq/6MiOEZGKhHLz3hcYfjh2A2ftp82kRrgjgW66XafL5E2Av7+qcddmrcD+YcNniqhFJUx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlLOENCVDberXv/lLf0YFbNZH1a3kuTgk7mp/N6S7e6eeQzl3V
	E04z32+i7bUFuamwwXqhJqmmedC4fnuVfVY+gibrGyg9INqSWFiU
X-Gm-Gg: ASbGncvOK98IlRRA4RA5aIz7BnKrltlUgRtdYsnrS149h742DVXs77F0RVUhMFujfsL
	osn7/3mHB/xdSnefSfsUpJM2noIj2NOY/Pe8ComGs9k1MXSuuOJvegSR18A3fEVsztWsPWxO/w+
	LQEER1n7f3SzeGjKhpXwqtLNNrmX09GDAWpxVg/R3Rz69hFNOepUIJApllyCKspKbhFOMFaHuDt
	Co9uH+P1/kM5SLFwEdM3Uv8akSHeeTa2EUUeOmdUYx2fomnuKCaS/lESwJgAZYISC+MWQyE46qi
	1MDoXjhOuQ12
X-Google-Smtp-Source: AGHT+IGCDjtPx3t6cmLqhK9W8kHDOpUk/3/BG6YGZkhjZpTzZqklF78LRMOz3NhFsVDK0VClUQmyQQ==
X-Received: by 2002:a05:6a20:a11c:b0:1e1:e1c0:1c05 with SMTP id adf61e73a8af0-1e1e1c0202amr15348954637.9.1734318745406;
        Sun, 15 Dec 2024 19:12:25 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5ac8766sm3186322a12.33.2024.12.15.19.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 19:12:25 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org,
	arighi@nvidia.com
Cc: kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>
Subject: [PATCH v5 4/6] sched_ext: Add time helpers for BPF schedulers
Date: Mon, 16 Dec 2024 12:11:42 +0900
Message-ID: <20241216031144.98097-5-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216031144.98097-1-changwoo@igalia.com>
References: <20241216031144.98097-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following functions are added for BPF schedulers:
- vtime_delta(after, before)
- vtime_after(a, b)
- vtime_before(a, b)
- vtime_after_eq(a, b)
- vtime_before_eq(a, b)
- vtime_in_range(a, b, c)
- vtime_in_range_open(a, b, c)

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 tools/sched_ext/include/scx/common.bpf.h | 94 ++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 79f0798a5350..923bbf57e4f1 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -408,6 +408,100 @@ static __always_inline const struct cpumask *cast_mask(struct bpf_cpumask *mask)
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;
 
+/*
+ * Time helpers, most of which are from jiffies.h.
+ */
+
+/**
+ * vtime_delta - Calculate the delta between new and old time stamp
+ * @after: first comparable as u64
+ * @before: second comparable as u64
+ *
+ * Return: the time difference, which is >= 0
+ */
+static inline s64 vtime_delta(u64 after, u64 before)
+{
+	return (s64)(after - before) > 0 ? : 0;
+}
+
+/**
+ * vtime_after - returns true if the time a is after time b.
+ * @a: first comparable as u64
+ * @b: second comparable as u64
+ *
+ * Do this with "<0" and ">=0" to only test the sign of the result. A
+ * good compiler would generate better code (and a really good compiler
+ * wouldn't care). Gcc is currently neither.
+ *
+ * Return: %true is time a is after time b, otherwise %false.
+ */
+static inline bool vtime_after(u64 a, u64 b)
+{
+	 return (s64)(b - a) < 0;
+}
+
+/**
+ * vtime_before - returns true if the time a is before time b.
+ * @a: first comparable as u64
+ * @b: second comparable as u64
+ *
+ * Return: %true is time a is before time b, otherwise %false.
+ */
+static inline bool vtime_before(u64 a, u64 b)
+{
+	return vtime_after(b, a);
+}
+
+/**
+ * vtime_after_eq - returns true if the time a is after or the same as time b.
+ * @a: first comparable as u64
+ * @b: second comparable as u64
+ *
+ * Return: %true is time a is after or the same as time b, otherwise %false.
+ */
+static inline bool vtime_after_eq(u64 a, u64 b)
+{
+	 return (s64)(a - b) >= 0;
+}
+
+/**
+ * vtime_before_eq - returns true if the time a is before or the same as time b.
+ * @a: first comparable as u64
+ * @b: second comparable as u64
+ *
+ * Return: %true is time a is before or the same as time b, otherwise %false.
+ */
+static inline bool vtime_before_eq(u64 a, u64 b)
+{
+	return vtime_after_eq(b, a);
+}
+
+/**
+ * vtime_in_range - Calculate whether a is in the range of [b, c].
+ * @a: time to test
+ * @b: beginning of the range
+ * @c: end of the range
+ *
+ * Return: %true is time a is in the range [b, c], otherwise %false.
+ */
+static inline bool vtime_in_range(u64 a, u64 b, u64 c)
+{
+	return vtime_after_eq(a, b) && vtime_before_eq(a, c);
+}
+
+/**
+ * vtime_in_range_open - Calculate whether a is in the range of [b, c).
+ * @a: time to test
+ * @b: beginning of the range
+ * @c: end of the range
+ *
+ * Return: %true is time a is in the range [b, c), otherwise %false.
+ */
+static inline bool vtime_in_range_open(u64 a, u64 b, u64 c)
+{
+	return vtime_after_eq(a, b) && vtime_before(a, c);
+}
+
 
 /*
  * Other helpers
-- 
2.47.1


