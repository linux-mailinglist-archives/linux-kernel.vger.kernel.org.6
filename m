Return-Path: <linux-kernel+bounces-294338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737DC958C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 18:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3401F267B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB441C57A2;
	Tue, 20 Aug 2024 16:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="OYm/b04C"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FAA1C2332
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171814; cv=none; b=f/OhqY/OSSs0x8++mrfsuKqu+kaNi3Y2HnOBJga+RadB7LoLLHFoe/w4s8NPN5pLPUmZpwLbGCXr8d04JSVhGi6B8RnGoaB0ohU3RQ/yJjXk8IEKUyQsNNejGXprQlpx5WvjeAgmE+7ydS9x9jmlsnQeHII0ZEOhDQnzY0oCeQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171814; c=relaxed/simple;
	bh=9ZPSZBuNvWFZgZLOCmzGhftDorxtai3m2giRjex3pcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=as0KfUvf0VjXdXLPLwrK1klUl4KRblJvlRBoUU+N32lcsz/fw5dHJ8f0/8FtdzoUB9+WbEROAgzQ8sdNKD2rTB+7Xku+WSigJ9YAvXP1nroiAKqKCcQlJYXmD/Aw7pNAK1veCDdPEicsaRIJfjz+DpxJCKv4AE+OXybH+BerwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=OYm/b04C; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a8643235f99so163172266b.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171811; x=1724776611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9h5cxC5T/07ttsRJWHESo6Dab0VfuQh9Cth3dLGuihw=;
        b=OYm/b04CrUWrJrdjX1an4E8erpwS2OhGYQZkI6WK68VaOwmsESIYHq5xbTJGzlFKGX
         NsXyrOzuTP8zggrwTcWzP4ej1rOOneaPjb/nVsCdLwiJ/gi2jZv9ypuEtrmw99ELT455
         ljeDskts8uzbrDKuMxLP+7M0luwGiSt+VqA3Ei/4M1wuI5QACp7Xk6C/y/IkUo5Mztal
         aXSjKYLMtM+QJTuEZlTfM7uuQsJWTl4OUFEIPupjgcdSLHH3/srpjxVjNAxzWjYc0ZpY
         crJjifgsxSAZjBgFo0CWXUjNxbgQAKA4cLhF8NP2tPKhNEaoncfr7tk1WBbyZfgv9OWl
         0xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171811; x=1724776611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h5cxC5T/07ttsRJWHESo6Dab0VfuQh9Cth3dLGuihw=;
        b=Dy01LsCJk5aNe8vp6kiVIv8rsRH+wZFeW18F4AcNW4Lue9h8DJalyTZYUhEzN2gvAO
         OWdPolAqZZa7BjrwuSEWpE5D0QcRDeKao13PHzIf9D4+l2BBCCgjOwh1596i7pwQpsGG
         RvSC1MZgM8kjx51qrGw5joKnujX1eI6zAVuRhkqvnSnrux6++/DR2TPgP8xiI+uMiUF7
         bizPAATSl5rzgpL1kxZxfRkakRB6g0tnl0Hy+w2WMOezK7SN+7yutqrYThSvsqYoUkRt
         24Gw7aMklAp91oOvuUYenXLar+KL576nZLULqtktNmloLvKWiIm3LRaNnWzYF6h2dzqm
         0YNA==
X-Forwarded-Encrypted: i=1; AJvYcCW6jjLkyN/C0l3WyqB6n0KlE6YykYq78XKZ+jcMeXtBUUMBmCAUJTd/pryZXdSnUJnVQvBEKokC+qrnwC7qYw07OtNvd2ApgRbF2YA0
X-Gm-Message-State: AOJu0Yzvh4GsphTulx+eHYt6VdCFP4IgE1sJwtBGMFokX12yB+t2F/7F
	r0AtDLb673NvqYHFsrX+bcH+odddngCXnmWExDffeXTjd4Yjci+5Q+yFolGDVuI=
X-Google-Smtp-Source: AGHT+IG0xeJvN3XiOQlKOh7QN7lETQdxPtqwJVb6er+yMgBCCOTRa61cwW2df57Oc6uhYemybizG5Q==
X-Received: by 2002:a17:907:97d2:b0:a77:cdaa:88a3 with SMTP id a640c23a62f3a-a86479e45efmr210115366b.27.1724171811016;
        Tue, 20 Aug 2024 09:36:51 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:36:50 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 14/16] sched/schedutil: Ignore dvfs headroom when util is decaying
Date: Tue, 20 Aug 2024 17:35:10 +0100
Message-Id: <20240820163512.1096301-15-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
References: <20240820163512.1096301-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It means we're being idling or doing less work and are already running
at a higher value. No need to apply any dvfs headroom in this case.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/cpufreq_schedutil.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 318b09bc4ab1..4a1a8b353d51 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -9,6 +9,7 @@
 #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
 
 DEFINE_PER_CPU_READ_MOSTLY(unsigned long, response_time_mult);
+DEFINE_PER_CPU(unsigned long, last_update_util);
 
 struct sugov_tunables {
 	struct gov_attr_set	attr_set;
@@ -262,15 +263,19 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
  * Also take into accounting how long tasks have been waiting in runnable but
  * !running state. If it is high, it means we need higher DVFS headroom to
  * reduce it.
- *
- * XXX: Should we provide headroom when the util is decaying?
  */
 static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util,  int cpu)
 {
-	unsigned long update_headroom, waiting_headroom;
+	unsigned long update_headroom, waiting_headroom, prev_util;
 	struct rq *rq = cpu_rq(cpu);
 	u64 delay;
 
+	prev_util = per_cpu(last_update_util, cpu);
+	per_cpu(last_update_util, cpu) = util;
+
+	if (util < prev_util)
+		return util;
+
 	/*
 	 * What is the possible worst case scenario for updating util_avg, ctx
 	 * switch or TICK?
-- 
2.34.1


