Return-Path: <linux-kernel+bounces-561796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D685A6165E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 17:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224083A9AE3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AB920409F;
	Fri, 14 Mar 2025 16:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eabxVA/g"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6521202F9F
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 16:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741970183; cv=none; b=kCajIt81Ml2tezvJ5r+LvTDZjmfGW6zzmQaZM1223b2weE0PreLhP2r9zQA9xxIBqUXZk5tstG46Gv+MJMn5GfSwGhpiDtg5xN9mvgOhiOzaaZVE+RHUGcIqOBOIi3k2sCRW+mUeLKS/wiByLnTcsTdfYp8JfOPriLAUNRohzHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741970183; c=relaxed/simple;
	bh=egzu3f8lxE3MWip7YazBJRQ/Ydi5ZEOEpxWi6oXJGI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c8uduDA06PPCk06IS8vq9VWMP/tytNlw+a7Uy6ZgbFsqpR6Tx3Eg4KVTgHKKADnPL6ik3siMb9ir+76A8HdTvFyMhg/cs0trhqotNBifS0PnoX1WgyYOkpOQKQRjAczBKEG7mHSNEqm+NFOWpvQyEz8JLeFQkqGkfXS2krVIoro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eabxVA/g; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43cfe574976so14996505e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 09:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741970180; x=1742574980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w/6kLY6RaSrrdr4jkNO3fwWS6bRx5SKAp4IQp7qj4jQ=;
        b=eabxVA/gmnQDF4KoZfAYVd9bWc6BZoUHt3I8c11iJwJR7Bv/ujx3AMPCtJCQ+5+jYK
         Z4hXxsI15oE3QSt2BLyIpEw5EmsO9k7XZbuoCmouN/cXrd6ai2pYlsEthRVxG26qvwos
         DsLmaXCJSEPC8hfQVo0t4dP5/g5dZo3f791+Xs+kHZGyryHG6NvKTIWLhaYJ/tpycSuL
         Fr8gzdOUiNv1EXIxlcuCIqI33CScGTF9zQVoar3QKmVXZo6mLp8QkhN85tFNyn0OfC4/
         dlEnzS7SR5IeMPzr6u0+Sm0fbThkM0bb57gVCwyZ81kGQtpOEeWoms+LCqA70xSZn5nW
         6q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741970180; x=1742574980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w/6kLY6RaSrrdr4jkNO3fwWS6bRx5SKAp4IQp7qj4jQ=;
        b=RtWkwKKN/TbNI7VRWGqlDH3Z0L2Mm63yK3DxaNFy3r2lGbUa/zwNQmTVKhKBE2vXsI
         dnxEJFzt+1Cg2JzkxZuGp9Wj4SZR5r/GpWvvHaLWHZ5zpf+MdOKlenSUSkah8E500qk5
         G+o5y7LQ4Nsnm85A7CWccEPC5Gm7xOvxHV+XYM6y8l3InKpNZIBp5gAAsq/P8gIZbNPd
         a/Whg1SKBKZhpYIJHM2reoVUtmUU/t9i6vUlSPaXkRJerQljZFJXSJokV1O4ByNPPCme
         UDeDt/NLr2RIfmWX8CxLsqN+kS9gdiqQ9xTLNYKDj1geqNmAASkEpRbQwvS7BbVkTqAB
         IXag==
X-Forwarded-Encrypted: i=1; AJvYcCU+lagNEpAe/AHD2Lt4M5WluB4stpu7zGvJ5mYupBR/RwwOyQlY8+rczSt0JTEFf6FSEqmSHah+B+Mt3P0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXh15OXoW1fd2Nro4T+KOto0qfSAFOPCFIbHUP3AMpX/N/+9BU
	dKJPvPWPClewX6jWjgbbgdI+CYypNsKyRkMIou9iOIxbt/LFQrh8ZDac61DBZbo=
X-Gm-Gg: ASbGnctjLKDF0DbeGV7iKxGJLIVfZYcQ1ML3JlYq6OSkCki+swICxb4bolNGwTVYuiq
	jp6R7wTB6oPXpj/T9Ok9mOoQE3PAHbsZI+/WTZnjAxFmvxQs3qzeQP8rYGJF3TcnT226P+T/cPG
	b3gxklqNyHQ6+YLHp4nWxU29mWY/fp8rPWQ4AMDq4DHDDaSw5hEsOg2xaEbj+9IH05Xcd39q5eR
	NJVEkhQ9AbYc9DCPyNHRuqWBsJdTgPNrJmJ68UHdyWXo2pxrzsGCejE5Z9O43m+NYewLQbdlpRH
	JChUihQ51voHx5iu/uu/qZ1HgPkXe0disQtEboedU0tlr8iNNd5f
X-Google-Smtp-Source: AGHT+IEV5DUzPeCkEeC9h7wBBBLB5i5/n4hnN8kMBJ9SLzM4h33dmBc6TU7P/qqC7lTt7+ZNMbfk0Q==
X-Received: by 2002:a5d:5f4c:0:b0:391:10c5:d1a8 with SMTP id ffacd0b85a97d-3971d135f73mr4233147f8f.6.1741970179972;
        Fri, 14 Mar 2025 09:36:19 -0700 (PDT)
Received: from vingu-cube.. ([2a01:e0a:f:6020:329b:9a6:20f4:3754])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cd78sm6072925f8f.78.2025.03.14.09.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 09:36:18 -0700 (PDT)
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
Subject: [PATCH 2/7 v6] energy model: Add a get previous state function
Date: Fri, 14 Mar 2025 17:36:09 +0100
Message-ID: <20250314163614.1356125-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250314163614.1356125-1-vincent.guittot@linaro.org>
References: <20250314163614.1356125-1-vincent.guittot@linaro.org>
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


