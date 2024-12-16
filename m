Return-Path: <linux-kernel+bounces-446740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 598489F289B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 04:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B3757A151D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 03:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC57215667D;
	Mon, 16 Dec 2024 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibza3E0G"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F4C15443F
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 03:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734318736; cv=none; b=Ha3aCwcCdA6N0oustlnCqffsCJO2JJM0dQxMbgBstmlp1nJUPjeNiR1nIjsNhUNigpg7GeVmpRM2UNQ6FOJH3XG6Hm5f1Ze+N1yBANAFyIG1mqt7OVxs/dOicT19Qf581zzeJFRehYXh295RYq4YcrruXt+uptlz0S2Iyt1qAe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734318736; c=relaxed/simple;
	bh=TlSqGNDpjyEQ/sAS+WG9j8ZbPrrXCvTJG01tJ8bLoZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqdOc9ZquQLia4/rsACFeWSwt5sxO/t5RZh549oqPfVSYontike66F7u8Qpy+eS9Fit2P0oTgosPFYRLyeajzesHsyjeD01RYb39HoDGxhQfzAXwrqTsNFylfvxrZv1lHFmMXnHGG3rvWm/jjeUHjAio7J6lkYtAor9PvBVoLuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibza3E0G; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-728f1e66418so2947941b3a.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 19:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734318734; x=1734923534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ot9Lx1zg/XLL07layOuusQRDG2mU5e3t2AM5FahhmOs=;
        b=ibza3E0Gq21eowbZhy5dedKMhxeKt7mkHSvViGitZqCqBGh5l+L71BTjTxDcj0SQtv
         jLfcD9phyA8vTLjJxbQIJwrxNR5Ww1pKFYBeaVh1H6pgJRpH9OaA4hf37nKpH4SCRxqi
         KWjciwEyGdaA9xy1xuCynz3ITG9DeC6N6BDVZ5x8F21juWIqBHpEApwgkMKLrEfNAFg0
         rDEVQK4dRs+8VA71SABFYIvkDI909yQtiPI8D4bTw1h8LsnIrLWYxy4r6zHo+QSpcEVq
         d3AGQsLGgMw2Ct2HZmSySjJdQ2ZwFl3eS4w+g93efOPM4Zf2JbpTFKZyfz0pQ1pFW8yt
         cCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734318734; x=1734923534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ot9Lx1zg/XLL07layOuusQRDG2mU5e3t2AM5FahhmOs=;
        b=UqEO1ms+bMtlrmytky+dKKCz1rF00TgpeG0zOZRc3vAjFFSDDGw3Ly4bcvo4P7nCew
         XsmlJA5RzFVgKX8qTBcBAlSgwiWhmtNmKOV51X6baLA7T9n9A6xH0pUB1/Ce8O3mw24l
         APpaY2tbthB+0g6sampBkG5Q4cKAn7JIQ0KtMM8bzOTmZZusyu7bOeiDvBTf9S9lQriC
         yKfRRlGKh2k62Z+w1FuA033kSuF3XZCDDTuCGIAh34xdcHnMQ+S3LDm4saG9NqYoDO0V
         RIW0yGpXjJjj4yJ3wE3DGKhFKfJkM9fXH8rsvaHBbFhGNLUPQWYgmDahcfWZWz74zwM0
         t5dw==
X-Forwarded-Encrypted: i=1; AJvYcCUIkfk8Hs7qKrExiBtLudhV3XtADVJo+jNepgFIFnvSu7/LMK+LrKrp0HLxTk87MazUmaoo3H7UqddiucE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3dvZ5Jn+E6z6LB6lgEudNKk4+xb8MIUnzKONNnmNc91TJXDY8
	sAAlSepLTLI/gKv1dy3kbk/trUcEQdRPSzXWMcuKE2DgOQ1ig1cx
X-Gm-Gg: ASbGncsC/Rk128hg+T6/GHTUd5UArVCOQNiNUB7lnWwxNG2L9GTEA1+S5ZGFB7FPZfZ
	3VKuNr6EEn9MfRzsIVs/qcZnLZNHbYaItRSgBwcTSiUqkA5boSKv/pqEh6WQMeBZsIfp9Os35T6
	HtA5Dx2Xxtj+8dOUCpaiEhJmHtB7993wjQ5xIvNf3sLXOjijVEuLWBv+vXjVl8T1TWgaKWOJ5g2
	3H2QatcWObyIcq4cX9rW0/Qt/kSUC4m9TSt0UaDzwKAiQdUXKfR0neLsIC2eojdm1Vr6wT9oZN/
	435185yKKcUN
X-Google-Smtp-Source: AGHT+IHNx85mGuRO8sIyUEFNPYeaTTw/FfXisv47Rm+pEH6iUsyoE+CZn8BvV/+JU0FIxkCuyAewqg==
X-Received: by 2002:a05:6a20:3947:b0:1d9:3acf:8bdc with SMTP id adf61e73a8af0-1e1dfe6b5abmr18064863637.46.1734318734119;
        Sun, 15 Dec 2024 19:12:14 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72925e6e8b1sm2172394b3a.139.2024.12.15.19.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 19:12:13 -0800 (PST)
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
Subject: [PATCH v5 1/6] sched_ext: Relocate scx_enabled() related code
Date: Mon, 16 Dec 2024 12:11:39 +0900
Message-ID: <20241216031144.98097-2-changwoo@igalia.com>
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

scx_enabled() will be used in scx_rq_clock_update/invalidate()
in the following patch, so relocate the scx_enabled() related code
to the proper location.

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


