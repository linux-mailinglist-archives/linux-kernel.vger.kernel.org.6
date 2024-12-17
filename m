Return-Path: <linux-kernel+bounces-449554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD5A9F50B1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272B2188F97C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4831F8AC0;
	Tue, 17 Dec 2024 16:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qEMGk9tL"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A591F8AD2
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451656; cv=none; b=IYL2eWxQz+QjD17bXwq5UiJo+wPU2zz9zMzflLS0XWwPnAJC6sIJoMzMXLJoty5OJY9pvXEK63JWFfMqEXFiurn3Zri7P+kT3jlwWagcdrNZOoDvbNwfxrqRTt0ryXJq517tW4AGuleRwNyUZDd+cyoAE7VVULA2BqMrQSS6mAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451656; c=relaxed/simple;
	bh=R4MYYzVeN7Cvaqn4APzrKkIp071ZgTGaGp2aCy959UE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mx3+w2qIeplLVOoqkjWVHZVGYXm1TlF9R1NhxWhQb1WUbg7eDyLLMXAeQurSh4FIWFBkOBc2uYG/uJlkB7r7c7oWLE8FhdSrcIGxpAe5l63GAZZ3pOr6sXE3hWIfWByxaBGqPhNYNo6GjAmjqmOIXlIIr2nZnq1i+lATdZBA3Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qEMGk9tL; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434b3e32e9dso59846975e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734451653; x=1735056453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4bmSIu+L/EncSLSMEzPcE+L0bLtnlBnj/TGrULXeHU=;
        b=qEMGk9tLZ3C2EOjlOQ0H/WWZQW7/N2JSGxfptZcgjeVa1GMeEGZFr0m5g4MOC1K8v1
         bThk6ZnHvV05fXr1Dblyh+4+8M4nuLIdcnWn+T52OyZSg/mPSv0rOAU6fH/ryyECm4c0
         2/tWlphNi9150zsGCLgeBFSc9G3azhtfl630NOZry+IeELouLJwUQu3vt2Dx1KNizbar
         ojpDpGqQtXdUtbztnYzeS3JoayAdlZtxnQQ2iyNjZOX0Y5Sy4oMsO12dpGFVS/KIQgd6
         8v6PVTE9KOYccrc0OZz1WOW2zmYxBX5rz3p5Rf9yTa9dbytHYrTA4J0WYEbvHjVWbr71
         n5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734451653; x=1735056453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4bmSIu+L/EncSLSMEzPcE+L0bLtnlBnj/TGrULXeHU=;
        b=VrhmxRqeYZTY/VWzHP1n00EFHZY97DeaxaTAY9GuJDQOPG3v3eJz6ZX9I2h7R/rz3M
         iYq1FSH8wc7wfcJsFdc3l86kHHaqAzkWTwc/AU2EznYh53zpsTGXw0Hw03WtZcUVoNBV
         u74eFtPa4kj/OqwR9Yz5ubD3a31xBHucwYWHqBjcSKF3hfid3NxTJklqex2N9t32/QX6
         BwKc1JdbgppyoDBUh3LDh8E6MsK3cqQ0Q3dvNtvhs111meTPD7DXtwYrws6fBqPDXo7d
         Q8HsdYtGf0CnmIvNY1GPHvmj5UMMYeCH9ms9l1yGoQd4966Y4c4uLbNk0VSPPwCQmdLX
         lOEA==
X-Forwarded-Encrypted: i=1; AJvYcCXRDUwJVI5K3cH/j+4gEypZWR7mNZBazhdOTbRtYIIopUimLc9PZo0ngET95woHB0cZRqasS1ztevfkZkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPuHpph4z0VNpHksXDmKnqz19K1RbqVTKAmT90JIoBk67tvbeU
	bC+LMXFQaX0JqsDUpFUJn05/VGA0DsDQhCZjU7brECU65UGAEiJau4VMdtKq8IY=
X-Gm-Gg: ASbGncsFeRGCuJ033CoiHo7dnFoLce53DS+RjgmO/GE/ItgfE4O8SuzF8rYDNxV6Et0
	kXaVD18I9ARkatILuDl9COEcmI/Z6xmm0sdjooSwvm+y2AnKCcNwWwlKCjRP7Jo0EG0blk4TM+N
	K8g4PX0R7uZIhvyGBR4PB3GqBAhk6PxCo1LhFTv2Ny+SSF/FLvISaq/x2XZ52eKHJLov3IdCAOy
	NvpGfRzLmabVRODj0nxid22+Q4LXsgsqKb/sOHkw7sbHECNm9r92+0PVcCuJY+ZHw==
X-Google-Smtp-Source: AGHT+IELpAYJXDbMiY5rjliFvVtKAU3HzdADieoHqQn9XM30JARtXqfo8AI0d70QRKRvtNqvTCKDwA==
X-Received: by 2002:a05:600c:154b:b0:435:172:5052 with SMTP id 5b1f17b1804b1-4362aa113e3mr127928155e9.1.1734451652851;
        Tue, 17 Dec 2024 08:07:32 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:4e5f:e8c8:aade:2d1b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436257176a4sm176739435e9.38.2024.12.17.08.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 08:07:31 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com,
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	pierre.gondois@arm.com,
	christian.loehle@arm.com,
	qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/7 v2] energy model: Add a get previous state function
Date: Tue, 17 Dec 2024 17:07:15 +0100
Message-ID: <20241217160720.2397239-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217160720.2397239-1-vincent.guittot@linaro.org>
References: <20241217160720.2397239-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of parsing all EM table everytime, add a function to get the
previous state.

Will be used in the scheduler feec() function.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/energy_model.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 752e0b297582..26d0ff72feac 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -215,6 +215,26 @@ em_pd_get_efficient_state(struct em_perf_state *table,
 	return max_ps;
 }
 
+static inline int
+em_pd_get_previous_state(struct em_perf_state *table,
+			 struct em_perf_domain *pd, int idx)
+{
+	unsigned long pd_flags = pd->flags;
+	int min_ps = pd->min_perf_state;
+	struct em_perf_state *ps;
+	int i;
+
+	for (i = idx - 1; i >= min_ps; i--) {
+		ps = &table[i];
+		if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
+		    ps->flags & EM_PERF_STATE_INEFFICIENT)
+			continue;
+		return i;
+	}
+
+	return -1;
+}
+
 /**
  * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
  *		performance domain
@@ -361,6 +381,19 @@ static inline struct em_perf_domain *em_pd_get(struct device *dev)
 {
 	return NULL;
 }
+static inline int
+em_pd_get_efficient_state(struct em_perf_state *table,
+			  struct em_perf_domain *pd, unsigned long max_util)
+{
+	return 0;
+}
+
+static inline int
+em_pd_get_previous_state(struct em_perf_state *table, int nr_perf_states,
+			  int idx, unsigned long pd_flags)
+{
+	return -1;
+}
 static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 			unsigned long max_util, unsigned long sum_util,
 			unsigned long allowed_cpu_cap)
-- 
2.43.0


