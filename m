Return-Path: <linux-kernel+bounces-560029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 602A8A5FCDA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 18:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D39519C1860
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 17:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185D026A09F;
	Thu, 13 Mar 2025 17:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PUTzMvfb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1289615748F
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741885226; cv=none; b=rsLUA820fBBD4aXrrDgvabHZzZgnHsbTEFvzUojFyzTA3XJu8KWsjN5U23/aqNEA0RfFDXOyZR4IlucZPcY9Fa3cAsX7ZmGp3OTMlHdiLsOIc/G71Ke4lvcxFRreAMFQ5frUc3WLZrpjxzTe/8/nc5XODE8ocsy9W1BEfphEj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741885226; c=relaxed/simple;
	bh=hPgfIteAKRae6Xb9DtmO3KzHb+o6HvFeO+EvqotCUBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rq4R58fKqJ0HtmyE3iCmaUmJBmj9GMO6/tRV4fzsnqvtlk8uuZM7TmYyG2xaiVVA6/s+b6v8mcF/jcQEPHAvezaa1omrEcV3X3BYbSHaAoO64vYwJSKbI82J9iscJOyNVar0b/BTM7wDDXo2952rV9FKcac+4fF0nD0YHERJnIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PUTzMvfb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741885222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j8YjG5ItqH/53cxab3vJ+AAYA8I/sog4WfKqtRusAYQ=;
	b=PUTzMvfbcSCBI49oVy2UZHZ6gF0FU6i7brc4EztVNV96WEqfUXYoi2sQ2t8WrX+u6Pyje8
	h+80Jnkj6ceXpBaTpQQZE4gKqJssZgpCmAK1cNVWz+L3nztOZHEVT0HrdBzlX6Q7C06W9g
	Za66uExUV6ZZUYZ8HI28WHazy1G6kWI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-PXJzaSreOlGlPRH__s98Ug-1; Thu, 13 Mar 2025 13:00:21 -0400
X-MC-Unique: PXJzaSreOlGlPRH__s98Ug-1
X-Mimecast-MFC-AGG-ID: PXJzaSreOlGlPRH__s98Ug_1741885220
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-391459c0395so532991f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741885217; x=1742490017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8YjG5ItqH/53cxab3vJ+AAYA8I/sog4WfKqtRusAYQ=;
        b=APafp0CZ8g5AKjkbzlIJ9BlE2Z6144t7msTZSRGg0VZKfMvudEgMuo8f6yoDQuyyfP
         jNzKplTPp4ikRlRJrKB3gOdo0+ZBBwJkCcjEKLHOIIl2GpMkAyIkRMlCB5YC92hUX+Ym
         rc4WFiNrPNwpb7xUJ3kltc0No9rmcDY8HD0TAaP7OLCl7f/qgByg8wfMpiIpdQPtOsvV
         m9mH41EInBRvYLdfYB/0IIYxXrSEPephL06DkJIHJ3jx8VEKheQJHc680x0EAGBaq9QX
         l9YPwofXT1Drsetscq3GS3ILTBA9Tv4C1EQ/4Yb7oVoXkSqdJgHVc+3P8uryc6pmnMkL
         OREg==
X-Gm-Message-State: AOJu0YwLwZWYihf3X2XP6y6lzdjTF/ssuCsrzWa+wR59RM++vkI8g7EC
	7MEIzZlLybxSjNThRp2esyAFSTdWubssfHSYQrecnsltDb11vl8YjFqQtLRSjf+hubxinFlwocn
	Od89gnjbFYuDuN5jxmFHpwbSboTYJBN/KS1UVZqz2Md/53u4EBRH2JTEBAc/ox4bQvWOtgZuT2M
	g8q/dmreRuaO4wiSGtrsjTgd01B4wqHjQGWTY+2bv/eJog11Pd
X-Gm-Gg: ASbGncuAfUNROZbp4bC2kVc5vYY5WUMEOROqj1x6jic6Ok/Yx0K3c7z4BEpE2rNE6rx
	LYU1SiHMvEBigRI7r6kdiCID2HJvG3qvhd85QE1YhaDyCrJ2fYhS2oDOsNcADaXalyW50seWk3h
	K4/v/RvNriQtnnjuMMD+m2lYkebYOnHJuV6FR8pmoP2AwzqbPZxRn01rTFwNiXclHzK516AnyAJ
	UnNhe76N8oUfSHC+ulbvFmFprly63VvsxEPuFwhbF+M/2blZa2tn5X8pg8Ar3ul3gV/vj6i0EbF
	UbNxUrjmIcp0uJpyLyWgBnxMiKiz8VbgbY80Jau7FLw=
X-Received: by 2002:a05:6000:23c2:b0:391:122c:8ab with SMTP id ffacd0b85a97d-396c1c207bcmr188059f8f.22.1741885216935;
        Thu, 13 Mar 2025 10:00:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkUvqQ4kZQgkVidzMwhKp3X0BWVh24OqT8ruMci31YdZKf7dZODGUNpYgkn2DkAYcJwNHbWw==
X-Received: by 2002:a05:6000:23c2:b0:391:122c:8ab with SMTP id ffacd0b85a97d-396c1c207bcmr188002f8f.22.1741885216374;
        Thu, 13 Mar 2025 10:00:16 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.49.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d18a2aaa6sm25912475e9.25.2025.03.13.10.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 10:00:16 -0700 (PDT)
From: Juri Lelli <juri.lelli@redhat.com>
To: linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Qais Yousef <qyousef@layalina.io>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Phil Auld <pauld@redhat.com>,
	luca.abeni@santannapisa.it,
	tommaso.cucinotta@santannapisa.it,
	Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH v4 1/8] sched/deadline: Ignore special tasks when rebuilding domains
Date: Thu, 13 Mar 2025 18:00:04 +0100
Message-ID: <20250313170011.357208-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250313170011.357208-1-juri.lelli@redhat.com>
References: <20250313170011.357208-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SCHED_DEADLINE special tasks get a fake bandwidth that is only used to
make sure sleeping and priority inheritance 'work', but it is ignored
for runtime enforcement and admission control.

Be consistent with it also when rebuilding root domains.

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Tested-by: Waiman Long <longman@redhat.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ff4df16b5186..1a041c1fc0d1 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2956,7 +2956,7 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct dl_bw *dl_b;
 
 	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
-	if (!dl_task(p)) {
+	if (!dl_task(p) || dl_entity_is_special(&p->dl)) {
 		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 		return;
 	}
-- 
2.48.1


