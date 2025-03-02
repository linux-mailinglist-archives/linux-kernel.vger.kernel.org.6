Return-Path: <linux-kernel+bounces-540783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B62E8A4B4D9
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 22:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06813AF49C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 21:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9041EEA2A;
	Sun,  2 Mar 2025 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x8/KE57r"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C4E1EC01B
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740949549; cv=none; b=WFj+5RD6jDWiL5jUNiPIqV9deYiJm8yYa81IaKU7M1UJPGlfJvPmNL2YR0+Hs6T1iegIwAvp96XIE/guIlGEKG417qqO67V5vfz/p5eOIRnWMYDJU9iw2K75UD9RNb+dGAt+8thSoiY3JEF5ptlx0pGUyziY6ZiyZLtUaIKRS8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740949549; c=relaxed/simple;
	bh=egzu3f8lxE3MWip7YazBJRQ/Ydi5ZEOEpxWi6oXJGI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+ilQT4JEmZJkVnsg/HmtgM7kAQOkRGzzGxLCKKBKUXrveri4ZNMo+jZwbty3LhA8pMdvi9ugeY2ZopAOtUFwGwb0TRKnn8mLbtCC6cpGrDop6Ny+Mxj9+UDu2iSwHR57yjHs+z1tTUtuCwTSlHg1gL8Z0oHRVA72Y/aLn7WGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x8/KE57r; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-390e88caa4dso1589322f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 13:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740949546; x=1741554346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/6kLY6RaSrrdr4jkNO3fwWS6bRx5SKAp4IQp7qj4jQ=;
        b=x8/KE57rN+dpFpOi3u7+mbScwuaxA+hwCtyW6zTLht/V74r3GsCWjEBOi77qR5aGJQ
         iIFJf3TO45DPcJvaxtjBJIFKwkaCxyZaUBnFLxPGrDjTzDe7UHJJ3or6ASbEcpJUhZsn
         aJclIP4b33Ep2QMleNem6VsrXKatyfsRmRR9+E77zDugWJ8eizQxwUjw/vr9HD8Up2v/
         XbgxlaIFHzo4ERE8ZXsgW99CtwrKsClfbt3lu+RGaRW51FCXrLicqCdMzrw9CzkJ/ip6
         Tzn5gCu2DElHJYtv7jYU8YidO3z6IQVMtneLO4ddzjiMfAstVeS4lhQ5YHLY6tX3TCQx
         F0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740949546; x=1741554346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/6kLY6RaSrrdr4jkNO3fwWS6bRx5SKAp4IQp7qj4jQ=;
        b=igf9A28HXKY47SW2Iacz7uvqSfB+j445BA2mpRLe1hiDuPe/CQlHOCce6EdZAWIgOG
         A/jEO9Do7m8XTOwuF6nAKXCtKXL33wfd3IslEmQCtG7oD5ZPOXjgItmONeno8GHcbX8O
         ySXMKzFNtu7XSNQkHY3MeFI1mx5zhXCUT9Bj2bn7u/rXmRqFdmcL/w1l2E1LZX6Kn8Pl
         9z5QlOpqanjNQZnx6c3m3Kn31U1kUzAtMM5L+2HMbzXjyPA6m8lbU0Y/l3D7orSH8ZeY
         Dz3+LOkaYepVHlOQGS3wRnLZdIj14sUON3Nl9bBu0i4TppDzNH1sL5HMNKg5IFoSkmSk
         Q0KA==
X-Forwarded-Encrypted: i=1; AJvYcCW80Os1ALkOuotDvp1jS0ATHGCGrlvSMR4QbbpS/z0DT4wb7UUd1pRNDB1wFjb4kTDn6RvxoCa+NmLmhd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjVZz+uXfCfdKkzEEWbXFWp6/I0gHXmMz0hwT7Hvn9fx3UZSZE
	b5M3yLUV6K9PL45QRT6IzKda4wFrpWv0OIMp/34rqv2ZJ/2tGEMEgcN3wCxvhzk=
X-Gm-Gg: ASbGncuHBP50mr9dNHfA0uCvosoFMr8e9a9asWinv6h0VzeH1Aih/dZmAbraODjOsi2
	cCacp/XBBg0kewoRBLLLCogRMxAA9xjDhwsCDcvQB+fvOYZeMhAdlMA6KEmR9C4+TcYBmGV1uJQ
	6ycRAhf8qK60sRk1Dk8quwx++5OmUEWrGm+jL0bWZg4FS9lPVx3SfKfuztdhnGTQFMIAcB/ORyC
	RVUbibQUqakKXKYzWNz0Zrx9eSoEtakT0No2DdbQQJFhOWTS+y/s9yyizofQIevoOYWTn6oZ5jU
	AurJ37ASBpn/o9qTFCuPMOU7ueaGQUd268KMFs7a38XnXlIv6z7E
X-Google-Smtp-Source: AGHT+IGBqyShoxMkIc7PsWPTrDt9QVABYrNclde3OourMlt6pgA0mXf4zgm+/3ZLXolqMJNWsmmiRw==
X-Received: by 2002:a05:6000:1ac9:b0:390:ea2f:92a5 with SMTP id ffacd0b85a97d-390ec9bbfefmr9763940f8f.31.1740949545859;
        Sun, 02 Mar 2025 13:05:45 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:cbb1:d64:4932:5446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e485e045sm12480923f8f.99.2025.03.02.13.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 13:05:44 -0800 (PST)
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
	pierre.gondois@arm.com,
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	christian.loehle@arm.com,
	luis.machado@arm.com,
	qperret@google.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/7 v5] energy model: Add a get previous state function
Date: Sun,  2 Mar 2025 22:05:34 +0100
Message-ID: <20250302210539.1563190-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250302210539.1563190-1-vincent.guittot@linaro.org>
References: <20250302210539.1563190-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of parsing the entire EM table everytime, add a function to get the
previous state.

Will be used in the scheduler feec() function.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/energy_model.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 78318d49276d..551e243b9c43 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -216,6 +216,26 @@ em_pd_get_efficient_state(struct em_perf_state *table,
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
@@ -362,6 +382,18 @@ static inline struct em_perf_domain *em_pd_get(struct device *dev)
 {
 	return NULL;
 }
+static inline int
+em_pd_get_efficient_state(struct em_perf_state *table,
+			  struct em_perf_domain *pd, unsigned long max_util)
+{
+	return 0;
+}
+static inline int
+em_pd_get_previous_state(struct em_perf_state *table,
+			 struct em_perf_domain *pd, int idx)
+{
+	return -1;
+}
 static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 			unsigned long max_util, unsigned long sum_util,
 			unsigned long allowed_cpu_cap)
-- 
2.43.0


