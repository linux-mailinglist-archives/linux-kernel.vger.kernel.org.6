Return-Path: <linux-kernel+bounces-311778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E326968D8D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 20:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294631F243F2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 18:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 159AC1A3027;
	Mon,  2 Sep 2024 18:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVjkwj07"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE88149C50
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725302174; cv=none; b=EfKceJ0yiCEvEDkwG7G3xbKMRBkEnZOGPYZOMt9Y/4CUM3umTX+WmbmmitnsmC5GsaT5Fk3XVTXon0lzmMvK1SKu0EPv+wr/4lBM0zPQpnIl2fZA1DIy1LzFzXKqiXpvOZHxbAXBAwI/otHTIb3IO9I+5V+dsWcxcFb+7+wUrJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725302174; c=relaxed/simple;
	bh=+vGLb0NBivlHrGqyzlpN+7bAmaLuim5LpxbDnOVWUP8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVDRbzUeL9ZhXqGCRyR1E5W9cZpmpS4AvBUCblc/MTCe7W/9jjr3a7LtiEuMWhS0HWqqbsqboCap4blN6Bk2sVfzs4ejINy6bqbieshLD7W6S6BB6k1KPb/ztPnjDcyNddQP4rOYJtwK+lsmAQXohkYeaKB5RKpN/vDOQ5+Ce6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVjkwj07; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-68518bc1407so47468517b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 11:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725302172; x=1725906972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c6b1/h0FuC9amuMCH8KFFKz3TQuVjiCQzzcUoM8rgRE=;
        b=QVjkwj07e0c2+osm6LutTA2j7S6jR0/KBTwA5z+UoRokFNMub8ZOhPspbjA4Cv5bfG
         7p9iZ3iILZDLoq9g5K5oknzHRDKa0PniuPoD5qzDXHBJsw1PoHfzcKsa7H1nZ1MN9JVG
         JEmOaNm2wUQ5uTkSM+SXGW/Qnp+PfrPtnPdJJbhWM6Z0CBpgmJKUkLGhtYKonyBWjY8k
         9rOTtcbN/uQU6z1eMKrGIaHo2ImxEYZSwYXQLhIYQI8yZInnVg2zPlEuXCbwjM5+3Iyh
         2/LoagmLSdQjMscG9w7mgLk+ZtU8dFh4RcE7Rq15V7ZmWQBXkdG92Q4+sIUDkTcvoVoq
         HCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725302172; x=1725906972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6b1/h0FuC9amuMCH8KFFKz3TQuVjiCQzzcUoM8rgRE=;
        b=mEX26h04DwYNU0ITFshZ3BdMMvjZmvH8fknFwNtx6Ecb9ou+9vKKZWnqxCUtwai4SR
         e9upWcV4loJx6rHYZ2c+xwNG1nU3uSuUrDfZaH9HpYJwkSA1eJDj6J51KDypbzZ29QW5
         17RBKZG0iBU15bAcIl52VJxzS+3Ln2eRsrgynxJ+HYF6BZUnsGUwryCHbzIg9bWnmEIA
         NFNciAM3Ll/cPo9MIdMLGiFYB8glKft9qNUl5YZt5gXX6rPNmfIjPI2FP2PHU0KLpV+M
         dvBOI32sXTuTEbCUyqFGXIK8iybaD1azSEFkiKPt8MREyCnGL+iaVgSDAA/vU3ibBjGT
         6Trw==
X-Gm-Message-State: AOJu0YyZpRhr8VCMCDDUl9THbyXJZS012fhA2WL4QBkXfuvGQqo7hmOH
	nppKv/ZZveXSsS7Tdy9a3NRuQuecDKrgxFXVsIHd/z7UCabqOLvhRd8HiUbt
X-Google-Smtp-Source: AGHT+IHx/3wZs0gZigHGtsu0y0IHcC108ZGbzbxPPds1XQR8YzibuM/vucodvMrd+jUfX+bPH9pezA==
X-Received: by 2002:a05:690c:dca:b0:631:78a1:baf with SMTP id 00721157ae682-6d40ee58397mr131926667b3.6.1725302172052;
        Mon, 02 Sep 2024 11:36:12 -0700 (PDT)
Received: from localhost (c-71-203-131-184.hsd1.fl.comcast.net. [71.203.131.184])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6d52b49ba97sm9751667b3.107.2024.09.02.11.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 11:36:11 -0700 (PDT)
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
Subject: [PATCH v3 0/3] sched/topology: optimize topology_span_sane()
Date: Mon,  2 Sep 2024 11:36:04 -0700
Message-ID: <20240902183609.1683756-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
even when cpu != i. In such case, cpumask_equal() would always return
true, and we can proceed to the next iteration immediately.

Valentin Schneider shares on it:

  PKG can potentially hit that condition, and so can any
  sched_domain_mask_f that relies on the node masks...

  I'm thinking ideally we should have checks in place to
  ensure all node_to_cpumask_map[] masks are disjoint,
  then we could entirely skip the levels that use these
  masks in topology_span_sane(), but there's unfortunately
  no nice way to flag them... Also there would be cases
  where there's no real difference between PKG and NODE
  other than NODE is still based on a per-cpu cpumask and
  PKG isn't, so I don't see a nicer way to go about this.

v1: https://lore.kernel.org/lkml/ZrJk00cmVaUIAr4G@yury-ThinkPad/T/
v2: https://lkml.org/lkml/2024/8/7/1299
v3:
 - add topology_cpumask_equal() helper in #3;
 - re-use 'cpu' as an iterator int the for_each_cpu() loop;
 - add proper versioning for all patches.

Yury Norov (3):
  sched/topology: pre-compute topology_span_sane() loop params
  sched/topology: optimize topology_span_sane()
  sched/topology: reorganize topology_span_sane() checking order

 kernel/sched/topology.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

-- 
2.43.0


