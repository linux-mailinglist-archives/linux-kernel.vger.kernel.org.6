Return-Path: <linux-kernel+bounces-436825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FDE9E8B65
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C0E21885B47
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1A71547E3;
	Mon,  9 Dec 2024 06:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXEIq4Wq"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2A443146
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733724952; cv=none; b=YM+/8MUF2N0Cmi7eC1BVugJrDNMtTlfI+AqGSt9s+TJEM7JI5rGBmTlzsIVCAfWZXr6s6ZEQ9MmAM6XSN/nQ1XljYOrS5tG61yE0s9dqpm+tGFayj0kjOMkICUGzBwqQSWzuASVnEmumVk7GboA7CR9LRmx9z+Iaor0INA1FiLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733724952; c=relaxed/simple;
	bh=Txl962X9D9KxVCAHDq5L6m6huEZFNRDOQ99W8Ng9mX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUpK5A71seUyk1r4gvMCAAYYPWucoEkYheK/fRhU60aWMPFXZso8Rz36JzyLsQ9l0tJZOZX7hRBC0M5B1ikQMVPqWSly7Ihau//KZ8Bp0QKEOAlcTOvF8xFt3cNYoN9bgKuVuSK7MNkge7qPaaAe/DrEHPr+yKlZHKt8wkBnfro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXEIq4Wq; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3eb5a870158so188762b6e.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 22:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733724949; x=1734329749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pnNhPvtjjeA0SELvFx04GxV15CCO7vm1wX4v8xLLeWc=;
        b=BXEIq4WqU1bIv2ndIXzVSWUo0LNa6CKXV1b5kbYFG4HwEdF2uAEdYtMLBQIZy7LbAo
         JeCrHnFM8lkvhzjurHgdwyBIEk+5YOHSeCVLNltM1lo0A0ekplF5NqOmuR34tkYYsLdB
         M3JUIG45eC5CFK10dFeGTuKjScesNm1LuOu3S7RKJlASZdY11w0VaxkRgb/umnG6i803
         qTvH9e/THZHstghWupxrMwu2cYe/b+Sn1UaLmN8X/NfjDE1vPC/9YwY7/Lfh+JxS1Fq8
         c2NBp0FFMoz/3Gx3eTjO/rCvHbgqpmHaA72N+BshhybNvcq40urGsBxoa3bwkRvdLDG2
         t6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733724949; x=1734329749;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnNhPvtjjeA0SELvFx04GxV15CCO7vm1wX4v8xLLeWc=;
        b=wu1WFIrySYt+iLO5KTuAKKOgoahTVmI1GolhDvxckJGQAqACgpTOcNBfjdpnLn2+Fi
         jQgs/8ggv9pZ4loOigZyFF90xHPN9VH288vqqhlKvk1fPqzJAqYkzfx3Zcn1U1NJ/N7C
         rDnycqNw3BUxMKsKYlgRjLxt1OQFiW/Lq2IyNUeEexU2S6ut5YF6mqhwH6NSw88ezGtM
         0/kSZXf9k30FZQV25pn21j2HeTUEmV4xBEykJx4LgxCsJ2SHHuo0Xx7KuLkbJQ08Xgkd
         2mKM/KApioaxHDdbw3EJeyIjVAmC0LjAwHxv1Y8+x9ll31OGs2qMaQJDMxwysQjde5cd
         R/tw==
X-Forwarded-Encrypted: i=1; AJvYcCUeqbJxOos308sULarIhuZ9e0MflwGo6UMMjhXEt2Dtz3sRwLeiu6Em8OiU8BCXZjeSU2pY5vSjpuJi3qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN2rIx8iSNIC9e41b2TWoVUiklRLEYmJMfFWU1p7lpwmxYiZmK
	UvqRS/7SIaaafQVraQmlDNHd1yyP79BO+LTLk0uOEY/99JJSsfBS
X-Gm-Gg: ASbGncvpP0IDpjOpYawirwZ7SegNRBHD6TiX71fMIer6sreGuI2MUkYTIfot6zgrfYF
	UctORNxLVaIXyog3qnB+SjFNh5PR5134374PTeiGGMGbqx2XnxGGcGoOSv09pgqqDyj4yzR33qa
	NMSkHRl2Gs5iaRZo39N0aE0y4U8qErEFlCjINzXAkEFtveyK75QhYC4LNaXowu4kdQ6Z1mFWoYY
	HnWXgsx1VNef+uCEQVOEGV1EaXvkekxL9WasoUjbJzyNdUFQXnIEVnB/DDcZnhEzqRlMKDg+oLY
	7hEG8w==
X-Google-Smtp-Source: AGHT+IH0QB16al2MNtCP5J2c9l7nsN7n/OZFeMIS2zGWlp/k5mAHTZrWnn52QUb6jrJW8/Jmsl2a9A==
X-Received: by 2002:a05:6808:124b:b0:3ea:5809:2835 with SMTP id 5614622812f47-3eb19ce7e2fmr10726413b6e.21.1733724949528;
        Sun, 08 Dec 2024 22:15:49 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd416536dbsm2054166a12.16.2024.12.08.22.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 22:15:49 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/6] sched_ext: Relocate scx_enabled() related code
Date: Mon,  9 Dec 2024 15:15:26 +0900
Message-ID: <20241209061531.257531-2-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209061531.257531-1-changwoo@igalia.com>
References: <20241209061531.257531-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_enabled() will be used in scx_rq_clock_update/stale() in the
following patch, so relocate the scx_enabled() related code to the
proper location.

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/sched.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 76f5f53a645f..440ecedf871b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1717,6 +1717,19 @@ struct rq_flags {
 
 extern struct balance_callback balance_push_callback;
 
+#ifdef CONFIG_SCHED_CLASS_EXT
+extern const struct sched_class ext_sched_class;
+
+DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);	/* SCX BPF scheduler loaded */
+DECLARE_STATIC_KEY_FALSE(__scx_switched_all);	/* all fair class tasks on SCX */
+
+#define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
+#define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
+#else /* !CONFIG_SCHED_CLASS_EXT */
+#define scx_enabled()		false
+#define scx_switched_all()	false
+#endif /* !CONFIG_SCHED_CLASS_EXT */
+
 /*
  * Lockdep annotation that avoids accidental unlocks; it's like a
  * sticky/continuous lockdep_assert_held().
@@ -2505,19 +2518,6 @@ extern const struct sched_class rt_sched_class;
 extern const struct sched_class fair_sched_class;
 extern const struct sched_class idle_sched_class;
 
-#ifdef CONFIG_SCHED_CLASS_EXT
-extern const struct sched_class ext_sched_class;
-
-DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);	/* SCX BPF scheduler loaded */
-DECLARE_STATIC_KEY_FALSE(__scx_switched_all);	/* all fair class tasks on SCX */
-
-#define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
-#define scx_switched_all()	static_branch_unlikely(&__scx_switched_all)
-#else /* !CONFIG_SCHED_CLASS_EXT */
-#define scx_enabled()		false
-#define scx_switched_all()	false
-#endif /* !CONFIG_SCHED_CLASS_EXT */
-
 /*
  * Iterate only active classes. SCX can take over all fair tasks or be
  * completely disabled. If the former, skip fair. If the latter, skip SCX.
-- 
2.47.1


