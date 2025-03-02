Return-Path: <linux-kernel+bounces-540625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E988A4B2FE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:15:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 099723B2EE0
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 16:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD3E1EB5D9;
	Sun,  2 Mar 2025 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lbabW0H9"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6DB1EB1BF
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 16:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932020; cv=none; b=nSsFOLuePjtedZ9ic57EboXWxmpiyoXLUcnwYCbDYb5RVw52YkXTvRUE5F8abizDbbPTcu0R89WKQVDjbU73V0ge6brcAo7IV7BSmdXtbQpza9skC1zc3qq9ZrhDHNJWLezZK2Qx9JmQp3ZyFYNki3QS5WetOIlW+WRbbcV43Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932020; c=relaxed/simple;
	bh=AVs0Ojczs2C0TDloanPrJOxloY5r9ENCO5oTgFrQAcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZUAaBcoMWEPm6iNL77A9mvUZb2vDaQCmmo/gl0ZTqhEIJLtR2csT7wgGLNce9USukyuBJCIAHECPYYoF5a3DuAAkqahaQTWNM4ANOxOWLYZi9wYcGDXZdZMkmf2nhG9cyRqGVgfE27azR93jxBLn4KCYTbNlp1RyfDGb5M+Hdu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lbabW0H9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43994ef3872so23235815e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 08:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740932017; x=1741536817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K45XWNnUOn6Er5XZHpb+55lI3DiFvNPiXBbeHlptjoo=;
        b=lbabW0H9z7IGl5nzkUOcTI4gVSgwvYBdQH+rUK3lb+8Zxy+q1WOnO/Bj6Xe15FH8k1
         WGc0vM+FUmyDDfQ5reY18wyLi1QNQto5AVn9u1s3H+hC9W7TC/y9vWTrJCqLrgilOmeP
         qdKbecs9pWt24DNl363hsf/uzixq3ih4UTwzYk7xAZM6hDcOfPhxxbStEmIodd4yicOF
         LZn9Tj8sbH9eDL5OFxtN+XL9iEB2OEpCU149X96KGjch+HOrezT8KOM0m2cmO79SVDE2
         UyWrUN74Linp6P+DAO8W1Dn44nSRgGe1oeRCZ6Zbf1dohAwmeQqktpCIzJTrlZrZySWR
         47Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740932017; x=1741536817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K45XWNnUOn6Er5XZHpb+55lI3DiFvNPiXBbeHlptjoo=;
        b=oX8vofCAUG86R+5JkCxCx4bL91ZqM0Mx5k35G1shqfk0WaAISRCmHmp+uU0tyIDtR3
         UJ6oLA396A18d1k3+bTSlblLYnM6vB45qBtuQ+tZNTZPeTP1vIlQMmcVXoAebocQoafK
         AiEiJMH0kq5hbgj4mp3A4qhwL6g1NP2A/YETqL/QQ5XqP9cfjwM490KCt497ptREbVCZ
         pYR46kVo522Xp694zqcCBcf5Mw4/0/RuqPZJpynmJSrxkPo5eKKYwZjD4/BBnBoMupR2
         0lVo8NCjdM/Vgdg4ax1c6ezhsp/PH7feWHAsD9npCGJOWYD849R9K5OTZcQCJ7/jpoM7
         Qeig==
X-Forwarded-Encrypted: i=1; AJvYcCXml61L3kv6B46Ij5t1pY23B1WyHSOIbFATxvFJlV6thYsnOwD8rnsLOF2bTfa6txz6h6JZZuTsFxkCy/k=@vger.kernel.org
X-Gm-Message-State: AOJu0YytFzGqA6pdUfGDtxtoVkhrA2eU9tREJWSNATHPp0TCC0A1CSjP
	RgPcllGBppdlAYZ/wJAbemojbCabW/0xtQmLZWIoKEas3Vao0V4gX8dVWnooOCc=
X-Gm-Gg: ASbGncvow21JN0ZOC+3mC/uxDtUSezRHsHD0CqZn3c/XEJ9VbhNiSXNajKgJamLOUtS
	2lq+mTDkKFE9IYSbU3om5UycWzHkxsjQbwNwsHdY4KkCqHnj8Nvn8Qdw6bRyP9rWjJz9LTU3ISG
	ZOH+hbwicre/FzafgO1usQgZMOZRYwJQJQt0uyw/3aU1c2j4HGyPqaebC6tZ2mbD4wt4DAFNqZi
	aBTgoDLovHAI+o8VyGmvvoZDJOa6LgoYzCQOkGzULQaeG8mV2iW4AnobnT2zPfjwyO5opHoIDhs
	pLygSpvQ33o/jXjKTLXjn9FAHHogwft6O9cvZjozhuckZ8cbdNH6
X-Google-Smtp-Source: AGHT+IF8gIrmLbkZ0HcbA64fVvHOXkZrLd1NWZQbv+5hMoBo8OIAet/FvNNhQY0r7SC3xOA2BnNJ/g==
X-Received: by 2002:a05:600c:444d:b0:43b:8198:f6fc with SMTP id 5b1f17b1804b1-43ba66e6d07mr97553735e9.11.1740932017153;
        Sun, 02 Mar 2025 08:13:37 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:cbb1:d64:4932:5446])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bb767a977sm25530245e9.18.2025.03.02.08.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 08:13:35 -0800 (PST)
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
Subject: [PATCH 7/7 v4] sched/fair: Update overutilized detection
Date: Sun,  2 Mar 2025 17:13:21 +0100
Message-ID: <20250302161321.1476139-8-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250302161321.1476139-1-vincent.guittot@linaro.org>
References: <20250302161321.1476139-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checking uclamp_min is useless and counterproductive for overutilized state
as misfit can now happen without being in overutilized state

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 21bd62cf138c..c241d9d57a0c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6831,16 +6831,15 @@ static inline void hrtick_update(struct rq *rq)
 #ifdef CONFIG_SMP
 static inline bool cpu_overutilized(int cpu)
 {
-	unsigned long  rq_util_min, rq_util_max;
+	unsigned long rq_util_max;
 
 	if (!sched_energy_enabled())
 		return false;
 
-	rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
 	rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
 
 	/* Return true only if the utilization doesn't fit CPU's capacity */
-	return !util_fits_cpu(cpu_util_cfs(cpu), rq_util_min, rq_util_max, cpu);
+	return !util_fits_cpu(cpu_util_cfs(cpu), 0, rq_util_max, cpu);
 }
 
 /*
-- 
2.43.0


