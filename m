Return-Path: <linux-kernel+bounces-308837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5543296627D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871941C234DF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7584A1AF4E0;
	Fri, 30 Aug 2024 13:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rq66yXpY"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96501AD5D8
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725022998; cv=none; b=Y8scp/uMWr5hYftBUq7NO7NnH9Si+IrIdNncK7AtJ0iDBqPxHa2W6VUQCZ0e9UEaR8knv12aDOBdh2uDvggF9xOZHUP4weh7rgX11Mu3sBZQLnOTP8eV4xgR8gP2Wl0KNVJSjjcELI/P8wI+vLhxcYyOLIXRY4SJ/zybSLtOe88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725022998; c=relaxed/simple;
	bh=Jpc5j3N6ICS48R8vlUAWLFgq+QPIEAVfChN7GQm0/VY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jCB3i9SDxgrzGUjKFXm5XIZJFOoFLNv0+a0mRrqwXw/ZB4cX9GV0pAIRgLunGSCBCfKjLzuYkQmOIoeRt7a6r3Nv6meitbFjZUVY7f6jGJ0/PV+jOh4F+hDaWjIOG5/exzJuOhBRaFvuZz24T2aATwNMkNyaKWPtoSAyTucDugo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rq66yXpY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3718b5e9c4fso1060117f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725022995; x=1725627795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMwhKBhd7gDlMAyvQwSLcnndC8gEEBFIqZCsXkx4uYw=;
        b=rq66yXpY5CuWe1jLUiizPobgtB3CUg6RyH83GHxk5rIXnqvWZbsrbBGcrZLM/Qn36Q
         Gec46ZT+wDV5BtcxltjQDvZiJB+acJL6Ya1z+M8DqI1acsxBUKJaogfTFPUqiyBWVYh8
         xNYS4VwYh5YshJ/Wu2P1EYxbeb858DOuqsCi5w9ONpkYIWLV/bB91NSsukFJXJ792irM
         F7hyWmPNysm9GTJBCLbKpNXe9iL0oB6gxv2uOSPBgK38xHSbS8rY/IOiXifkej4mOg4f
         nO6e+4sLf0wMf6FK8V2gcZgeNAJVaSM1NgPn9J+Joy/QFH5ECLWF94nkPt6+HfrWmaLC
         v8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725022995; x=1725627795;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMwhKBhd7gDlMAyvQwSLcnndC8gEEBFIqZCsXkx4uYw=;
        b=tlCrdeQC1LRiCFiTM+ufp1s39dTySbvMoCUBw/Ip7KJx10/TApU+QbWtlBhdG/vpPs
         puqqTVAWqbDSxeTRLlzgv7hGEKoUHfhY1d2z/Ow7x108L7Pn77F/HMo1QE703OYZ7o/a
         gIY6e+7mEs2IB7Rp+ZUYbjzY4Si7EXhQzw6BksW4DmpZq0qjDWNdmpXKx8ytjXI4S2wY
         GS8TZ5iFkDAhG3eA6kCNtPdJp8buB05oUiz7SE4GMWdTIc5fpEE6JkAtT95qf/Oe5TKZ
         AV5dZ2JmQ3C4tTp43I/b2Y2yW99aM8SroHZZL3c/DZAZSPJv+0FuzF9M6zBArwaos1ND
         658g==
X-Forwarded-Encrypted: i=1; AJvYcCVrpc49UPQ5GfgfxL/oa1JPzb6x61eqVCSJgR/G4BcPjofgvA5F35VGCd+ARec9+5RyeCEGY7s/wJE5rN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhsrIfrT9kZ5ccd5SC/LK+t7xStsJFTzhcbdbwTzDg8t3jTUVA
	+bwNpjRR0f0RvWX8ZZllqwv2Wiq4qk43hfvpfOvI9NuSdNyyiXOuCAaOgdv42UI=
X-Google-Smtp-Source: AGHT+IEU5fdiuT7GBubhrCXOyK0/J8FkW898uX+vMq8PnXnsjzyXHC1beTDtqDQFj/gTl3N+dnk/rQ==
X-Received: by 2002:a05:6000:154f:b0:36d:2984:ef6b with SMTP id ffacd0b85a97d-3749b526f30mr5854050f8f.11.1725022995285;
        Fri, 30 Aug 2024 06:03:15 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:3cfc:139d:f91:133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efaf35asm3954076f8f.90.2024.08.30.06.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 06:03:14 -0700 (PDT)
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
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 1/5] sched/fair: Filter false overloaded_group case for EAS
Date: Fri, 30 Aug 2024 15:03:05 +0200
Message-Id: <20240830130309.2141697-2-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830130309.2141697-1-vincent.guittot@linaro.org>
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With EAS, a group should be set overloaded if at least 1 CPU in the group
is overutilized bit it can happen that a CPU is fully utilized by tasks
because of clamping the compute capacity of the CPU. In such case, the CPU
is not overutilized and as a result should not be set overloaded as well.

group_overloaded being a higher priority than group_misfit, such group can
be selected as the busiest group instead of a group with a mistfit task
and prevents load_balance to select the CPU with the misfit task to pull
the latter on a fitting CPU.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fea057b311f6..e67d6029b269 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9806,6 +9806,7 @@ struct sg_lb_stats {
 	enum group_type group_type;
 	unsigned int group_asym_packing;	/* Tasks should be moved to preferred CPU */
 	unsigned int group_smt_balance;		/* Task on busy SMT be moved */
+	unsigned long group_overutilized;	/* No CPU is overutilized in the group */
 	unsigned long group_misfit_task_load;	/* A CPU has a task too big for its capacity */
 #ifdef CONFIG_NUMA_BALANCING
 	unsigned int nr_numa_running;
@@ -10039,6 +10040,13 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 static inline bool
 group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
 {
+	/*
+	 * With EAS and uclamp, 1 CPU in the group must be overutilized to
+	 * consider the group overloaded.
+	 */
+	if (sched_energy_enabled() && !sgs->group_overutilized)
+		return false;
+
 	if (sgs->sum_nr_running <= sgs->group_weight)
 		return false;
 
@@ -10252,8 +10260,10 @@ static inline void update_sg_lb_stats(struct lb_env *env,
 		if (nr_running > 1)
 			*sg_overloaded = 1;
 
-		if (cpu_overutilized(i))
+		if (cpu_overutilized(i)) {
 			*sg_overutilized = 1;
+			sgs->group_overutilized = 1;
+		}
 
 #ifdef CONFIG_NUMA_BALANCING
 		sgs->nr_numa_running += rq->nr_numa_running;
-- 
2.34.1


