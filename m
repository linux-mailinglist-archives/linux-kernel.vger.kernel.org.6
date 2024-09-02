Return-Path: <linux-kernel+bounces-311779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4D3968D8E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2B721F243E8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623A01C62B4;
	Mon,  2 Sep 2024 18:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aq0/jgC0"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7973B1AC
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302175; cv=none; b=AvPgvLw0LrHRNFFThWlJ52ny4pXAXhNsDjYJnhMogm70LeZfZnXfREAtyJqth1YVtsBhYkgBAvzt7ASCNNNZHmozN3jszsmnei1uoO6lXotyFAeiBcIWSTK3glVZQ7I9iK6+c7LtpiDobvKp0xRj71K0MvqxI1/ia1PHK+hl9SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302175; c=relaxed/simple;
	bh=fhf8WmY08QVVGMblvZuMnpvOp2GjY5jXRtZrrIc5Tj0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ji/Z3nc8hRWvyqfbvL2vHdluwYmFQHp9XrnmsMUTkATKwpqkrlBFJIjZoe0o2V/SvYNp+bDSuvAd+Qo//t84LCwTpf+UmMpQW/jsrmGJldZ8MdHD0RwzBjS0VR7WGNRbh58nKNI7Q8BrOSaOQFnGHiz7c9Z40pT80ZY1Q0CeXxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aq0/jgC0; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6b4412fac76so35630607b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725302173; x=1725906973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFb8yYHlbtqc71k+q1vVXsGuwhqBH0JTZbKgqgv4lxs=;
        b=aq0/jgC0vEL8DvQ/lVR9q4uvWzWtz4/BDAV8C96QKpohsQ7thbn+rOfQGVL8pSPqkW
         KBCW0BlCWL2Do8a6t5pqpZS/StbJ0EnmrTGbV4acuccQe+oGev/ytSsuSMgJPtlSuyzh
         MUIIC7WlZsXD2k7NrlbbuW6DW42pczrhEvXogJAQWjEDskKC5lDC1aE/uOBPx/nIFCeg
         UYMeXU3+5D5f8xui8L4nYmmKdpNlLdVA9ub1y3vVXM09RCLqmLj/Qr0x/5J4/RauHQjT
         DoJsusZWGefaEVbOUXxP6JBsBVWytsfSAFUG9XE3JvzsU+PZb9tCjLRuP8dgWtszH2lj
         LS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302173; x=1725906973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MFb8yYHlbtqc71k+q1vVXsGuwhqBH0JTZbKgqgv4lxs=;
        b=AYzI/xNwA496VmxvCJ1qvWmcnbinvug3bdxaXRdTEZxKhJCgxw3UFAARYfZaRVVoCG
         EHdjbuObQNWgxrLwOM7ZfN3tB6bpO8L4ryQzykgZONalL1/7mxjBbr1Wue566BAK2cWF
         GRXzrqNkuF9LsKLbpq4oPHlUJhpIaHVdIQI3YA9DpOVrGOR1PEnP24RaGGSOOUalzL8m
         qhA91SrmFmSHa/9dJzfz25pUGUCUD269XAq4R+RW02jeVVxlNCzcekHuWxWBEsZ7q85x
         hUBNnJzGKi/vKAxLdTFBQl/DZY5UunsM1fmFTHr40WOnPbkNWuBq/D9cn3l3KSBWMsCq
         JvIQ==
X-Gm-Message-State: AOJu0Yxml1GONNaQxHX77IpuR8vggpTb/l/uslwESOHLqK5b1S3E4s5q
	rWWVMPJktlxQROBcEn7A6kdDmkASL4iKKfcnEQT225K1RN3jPzxOoK9wBmFS
X-Google-Smtp-Source: AGHT+IFwrxSb0Xf8RylF/z03m3gS87dIiEIP9go27R9TEk+3nL0JfGeHbqolY/mEO+hNsJWM/svI0g==
X-Received: by 2002:a05:690c:6587:b0:6ab:e840:7f4d with SMTP id 00721157ae682-6d4104e5158mr97819507b3.46.1725302173253;
        Mon, 02 Sep 2024 11:36:13 -0700 (PDT)
Received: from localhost (c-71-203-131-184.hsd1.fl.comcast.net. [71.203.131.184])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d58b38ce9asm8667847b3.17.2024.09.02.11.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:36:12 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Yury Norov <yury.norov@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Leonardo Bras <leobras@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Subject: [PATCH v3 1/3] sched/topology: pre-compute topology_span_sane() loop params
Date: Mon,  2 Sep 2024 11:36:05 -0700
Message-ID: <20240902183609.1683756-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240902183609.1683756-1-yury.norov@gmail.com>
References: <20240902183609.1683756-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tl->mask() is called inside the loop with the same parameters more than
once. We can pre-calculate it. After that, 'cpu' doesn't have to keep its
value while running the loop iterations. We can drop the 'i' iterator,
and re-use 'cpu' in the for_each_cpu_from() loop.

Reviewed-by: Chen Yu <yu.c.chen@intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/topology.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 76504b776d03..ffbe3a28d2d4 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2353,27 +2353,30 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 static bool topology_span_sane(struct sched_domain_topology_level *tl,
 			      const struct cpumask *cpu_map, int cpu)
 {
-	int i = cpu + 1;
+	const struct cpumask *mi, *mc;
 
 	/* NUMA levels are allowed to overlap */
 	if (tl->flags & SDTL_OVERLAP)
 		return true;
 
+	mc = tl->mask(cpu++);
+
 	/*
 	 * Non-NUMA levels cannot partially overlap - they must be either
 	 * completely equal or completely disjoint. Otherwise we can end up
 	 * breaking the sched_group lists - i.e. a later get_group() pass
 	 * breaks the linking done for an earlier span.
 	 */
-	for_each_cpu_from(i, cpu_map) {
+	for_each_cpu_from(cpu, cpu_map) {
+		mi = tl->mask(cpu);
+
 		/*
 		 * We should 'and' all those masks with 'cpu_map' to exactly
 		 * match the topology we're about to build, but that can only
 		 * remove CPUs, which only lessens our ability to detect
 		 * overlaps
 		 */
-		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
-		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
+		if (!cpumask_equal(mc, mi) && cpumask_intersects(mc, mi))
 			return false;
 	}
 
-- 
2.43.0


