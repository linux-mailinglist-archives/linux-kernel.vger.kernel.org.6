Return-Path: <linux-kernel+bounces-278436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DB994B041
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A26C4B258AB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562A51411EB;
	Wed,  7 Aug 2024 19:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxQfuSRu"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575CD163
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 19:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057529; cv=none; b=gWsRwnOFvIu8iwRYBpOUKwHCxOquy7iC8aZH+YB+NI2i9+JLTKJQUGqUdxCKYL8UFqTIEvbESsgUh7/pjfwBEQP8GxCfXXDyb5Obf1J4UPuXEKVdTzCCTBYael3K9d8fnrIX7KIKOIw8PqTb2EgUaEXy0TRIbB0TuWvtZ1YLK6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057529; c=relaxed/simple;
	bh=FWnhUIZpVQAmCLRbtqEwxnLE62v6ExBmGAUweSzvfI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s9qPeoCRUnZiC0Hm+CA36b0bq4UupU6LpomVtkQmCR+eVsg71jyrVyZGFxlE1A7L1JHpT5BLk0Mgargb04c4A3m/605RcmmH3XG0sFO3sMuCNTNmlJwSdz/T1YsFlZRCF8BEmCu+H6vDRkWzKp2iRWP7BwuQYIOgNJq77+esvMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KxQfuSRu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc49c0aaffso2341525ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 12:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723057527; x=1723662327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZZpSguhKndTNqfuBDO3+UfmG1238Delrv9OmAeqIOns=;
        b=KxQfuSRukt5c5Y7z7z/x67+r/bXDo4rotFrIaVTw79pMHvpChdH1gJXpDCRI5qSxA9
         ltCS5Y70TbpMyJZzthNe5ALvCoIkD69LlqMKDapypAQ4ntVh3MKw6HhnC/fjETXRBr4m
         GqEJFYpzO1SM2WBMfRuoFT6KvPxIaGRQmChBMZdDUFrTgThK4HYbWhqr509c+8eJbfn3
         aDSeMle8hAf6dX+4x+gJTccYXVSKHf848C2GfjQ5VlggIBHrkoMW+xYzg9IiIbBse0uZ
         KlOSwACCMGPcQFZiNQbcn5gK/O/+Y4wlzxHjrzdWJdwx49f5Tw7BxBkj32D7BA2oNGHm
         9jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057527; x=1723662327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZZpSguhKndTNqfuBDO3+UfmG1238Delrv9OmAeqIOns=;
        b=J9V5TTNEJfkIhIFkqAdXaItIJYfL1pOj3F86hIVHNiY4jlkvaFo2RXozQ1ywRzUY+o
         0FzEPVpUDnOZ2y/T0FhC2+2zqPExxBMrHQTWl5cAHKuP4oCB3or4IsZmGiHM9ZS3BuNh
         lu43r/qxXuKVT/HIPzpveBffwQyQbIFU4q0z6bg2nkWZF/pXfw2LFYQhKmPpNLr6uPlx
         4eGpfvBh8CaDP9bhZf7Bw7i6sWqlHXGEpS1yesxhsBvD2mn27WxaGf4eDOPZq+V3ieC0
         5MLSpIdL5BDEVRvVi7hnJzWDbLvY5phZyYI3N/MPld+CkSHC++v4ZmBnq4xF+jc6JmNW
         OnpQ==
X-Gm-Message-State: AOJu0YzVNAx1ZbVIBdd5iFWTqg7zjTB2fbrwobPHPImeHJzpuE9JCtNX
	rN/o36VJny4krOiMW8TtzsoWcsEEocd8brC+LSIE9uhWZ2NMFERMt02WKzuy
X-Google-Smtp-Source: AGHT+IEI6fLhWeZG4XqqXNcKB4lErks14hxU1d9nRm1sq5e5YJDaS+ZNOogSUplFesNsnl/YUq1uTA==
X-Received: by 2002:a17:902:da85:b0:1fb:a077:a846 with SMTP id d9443c01a7336-1ff57257ce7mr228229165ad.3.1723057527465;
        Wed, 07 Aug 2024 12:05:27 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1b374b3d9sm1945162a91.52.2024.08.07.12.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:05:26 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
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
Subject: [PATCH v2 0/2] sched/topology: optimize topology_span_sane()
Date: Wed,  7 Aug 2024 12:05:19 -0700
Message-ID: <20240807190522.432388-1-yury.norov@gmail.com>
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
v2:
 - defer initialization of 'mc' in patch #1 @Chen Yu;
 - more comments from Valentin Schneider.


Yury Norov (2):
  sched/topology: pre-compute topology_span_sane() loop params
  sched/topology: optimize topology_span_sane()

 kernel/sched/topology.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

-- 
2.43.0


