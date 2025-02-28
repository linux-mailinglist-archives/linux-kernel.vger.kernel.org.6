Return-Path: <linux-kernel+bounces-538595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA783A49AB7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 14:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AD881898606
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D13726E16F;
	Fri, 28 Feb 2025 13:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A8NX+VS4"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F7B26D5A2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 13:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740750009; cv=none; b=lmenhuOifAFAJExzd0O3IS0p/WXdNdfkdUILrkSyPt0GtDZdMsrH+lOJcUgi/9d6YM5P+zBA3swva8fqwOFqO9/b5GyKcDUCExH9kM/ui3U3P/fdaq1PLsgRzg5nBv4eclVA1YxaMWzvxjuKeXqfw75lLeClMcLXrv2VlF/Fyb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740750009; c=relaxed/simple;
	bh=BIANFdS2G59gFgyF18cu7TQxo7ed8WKfM/z9xd5aqyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2oJj+AKB+lHeOjvYKi7WqxTMUArrEmhUS0jTS59vtHNF1ufbry1ogzjjZnEZICnTe7C7vaPXm6xJwpg0+sSwgIvQHoBqfFMF+aCHdWMMOkj4zqwD2saG+aMw2O/b6y5whLkb3LUMrB0gAdtYhNR1S7rYPhL7chhe0ki1TJgiAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A8NX+VS4; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4398e839cd4so20330185e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 05:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740750006; x=1741354806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0f9s7NROJ8fq5WoWUVEhIJcFKUOaWVTVNLDozZ75KA=;
        b=A8NX+VS4JyZb+BjzJLYURfNfTDLMnFAG1GvBBDqggdDI1oHMlOJLPnkL2v8DANDElv
         MoErqzx9WhZ/T3bkJaEHKLZqJQbvVbleoLNQvTqWFeMoVBfRoEkLLS0I/fO801rwPpAD
         rSjP6EN3eeF5WtoH01d3NVQzciySjSX8SgYWzpCIMAH1pY/whH95QR58iKORn38qFtGa
         j/AWUw4p+U34cIPCnXuR9IKJBVrsK8bKOSysJzRDKVrAjhxGuNu6DMU/jMpjDkf8HvHV
         2TVphlNbSEhjbmcBUYd3T/RjUstcBr2xLQtUF8MEtB4s56DDOEqJuU37l+vu0EP13yCN
         Qz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740750006; x=1741354806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0f9s7NROJ8fq5WoWUVEhIJcFKUOaWVTVNLDozZ75KA=;
        b=BrdecRdKyLJCaIUhIRcCwsK15TR9Jq6xQx+UNEQqWyLt0t+7U5KJklEryWVMg8P6PP
         N7YSSXIede4ey800jclg86tFTxkt8zJQvsvJiS5VSLH2FZPnELtYwzlh27SqZX60NUf+
         fDHA8WbFX7XF41fAr8o0GNdhoGVjZdoJn7Xj1GmYhsaIUcjy0WXnFf2AyjaTDZtM7y8U
         8Ax//5hDTYdwYcLkR6KIqNdtNpcaNrZNcAN5Y+S4BP8gG0euEbpHxkp3+nY7oDUOyhD6
         NPsGdWWzACP5vTpOzvk9xEQITYIQpVgQuOEf0k81S5fmJvxxR9ogOjPIXfg3D+sdLLG0
         IzCg==
X-Forwarded-Encrypted: i=1; AJvYcCUPwxYmdjWhfzw4+b7zRE3MAez5LQth8pH2RwVX9NVq+Lag3Is48cVhulL1ix5CADN6CNLWQWHX0SToyi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbRjWwTHrkxEcbc0xXZq06L5g+QmbPWDoZ2FtwEFKItbO6Oq8a
	VT5n/wYiT4FaFiyu8nf8XAkHE9KLRPEqjcqIpT0CnGHzloDe5+YjyKQKNhszTaU=
X-Gm-Gg: ASbGncs9dq2NSE9LhRLKEGnMGWkEl3NnlMtkaooI6sa0aec9sNc7PAXEvMPdTJOlVBu
	zS7NE9Txbq7RcrTZR0UY+vp3IDqHCpW8lyNFof1A0fMaA2jbw2kjhGI+B693hiQNkHqw5nPL7sU
	VTUdTAjhy09cryf7N8UC7xNpukc/fzu5oa6CWuhj64wLDG/bMuSLtsCenXYQRcNfJ6zLO7xa5qg
	VCOyHefl7iL5UU6r2HZ5DceMwwtnG0eaUDwgLgUQ5qSxGsyuxNagcBHv5vDTbWd+nIPkNH39i2P
	/+yD0AfD9DYCsnmBA/kzt2Ua0rxdOZlD6g==
X-Google-Smtp-Source: AGHT+IFhgqPKyxi/6XA1Evr5XU3hym4zZCuFuOCuZ2Y8cdmfrSJZbM8SIUokKRqMnUfbdWNpgZ/v+g==
X-Received: by 2002:a05:600c:5594:b0:439:8605:6d7c with SMTP id 5b1f17b1804b1-43af790fa9emr60491555e9.0.1740750006276;
        Fri, 28 Feb 2025 05:40:06 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:d4b:473f:a962:e9e2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43b73717171sm55984405e9.18.2025.02.28.05.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 05:40:05 -0800 (PST)
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
Subject: [PATCH 2/7 v3] energy model: Add a get previous state function
Date: Fri, 28 Feb 2025 14:39:55 +0100
Message-ID: <20250228134000.1226665-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250228134000.1226665-1-vincent.guittot@linaro.org>
References: <20250228134000.1226665-1-vincent.guittot@linaro.org>
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
 include/linux/energy_model.h | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index 78318d49276d..967650726619 100644
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
@@ -362,6 +382,19 @@ static inline struct em_perf_domain *em_pd_get(struct device *dev)
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


