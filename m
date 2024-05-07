Return-Path: <linux-kernel+bounces-171280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2028BE220
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD90A28AC61
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6551515B13C;
	Tue,  7 May 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="ByO5uEb1"
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDEC15AAD7
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085067; cv=pass; b=vEj2On4ucnwmOLmYTjLI+1yw5NeRu2NxMfQQpTP4Jsm0ShISAkQcOonynuLC9xGDR0oGBwi7bivhuWvi8w5tDy0+d5CS9HqURn2e/641clNdl7vSF8RrfJHsjBzYTfToowLEuRBg0jyN5dDKChqlo9En5hXRQa132k37+b8lQYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085067; c=relaxed/simple;
	bh=6q30XqqIAVi2szTLHa69yYutLTZ79zT2WYETcCvxjFw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XyI+75yps+73fzL/MqvzTfDZqy9ymFCWQFFYoLC2HlrBMemkKqNBypNggqRBnXSn4+SXYSPbwnV+P5HZR67rNDBC5xT49RcDXkuONNFTQ2VGovLmRLyh7SnTzous9/xMk3S/DgUGuVE7z5SCJoNMsMUB373jwzPerEU0rwTQSog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=ByO5uEb1; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
Delivered-To: vitaly@bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1715084143; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=aNOOw+VmB7ew9ck5+vlGFbOhYVSxOjPxpgvJ97AeMQM2tIwcVCzUGxEaX1+CzaMh/2CQUWQ96W7RHDXrXT69O+p2vFu7+24w55F2FQV5xOkuCSWpARUEVFCfWoRiEc75B/pkYO2QJEziq9aL4kGWifL2IeC7a3+v+cwHDcY/5ec=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1715084143; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=Qf/DRn4qZUpiOJrkJT7ccKfXdyqNZ+DNd7d/2NT8FLA=; 
	b=U6Ac0+ebrQqfm8Fj7JYlxCNueu5GnB3iREIb8qmslq5u/OAefcZHXNhH7OHK5MPiT0bvrqo2Yr3Y1ysLZEZ5PxbnEgwQzuDgobkbR5FAMB5/odWkeV47phMgVspLI5cnOIivv0QWpFFgwLGuPDtlpBB4Atw2ynatDJO+UOq/Bp0=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1715084143;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=Qf/DRn4qZUpiOJrkJT7ccKfXdyqNZ+DNd7d/2NT8FLA=;
	b=ByO5uEb1Dhm5+QUTavnDcozXV4PjbQerVarNJ2uc6lpFYpIhBr1zY+MEhUbfYNIy
	dlSAFKIM8J6ivbUbSp4CRkvzr6TRMcJlX56BCzI39K2D1csGIQhjhc2HBLcETw6JAev
	ngIoz1boPT4B1PKMqw4FDek9fIpUu4pGqoXvP8z8=
Received: by mx.zoho.eu with SMTPS id 1715084141240732.6014896306322;
	Tue, 7 May 2024 14:15:41 +0200 (CEST)
From: Vitalii Bursov <vitaly@bursov.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-kernel@vger.kernel.org,
	Vitalii Bursov <vitaly@bursov.com>
Subject: [PATCH v5 1/3] sched/fair: allow disabling sched_balance_newidle with sched_relax_domain_level
Date: Tue,  7 May 2024 15:15:31 +0300
Message-Id: <eef8e350b35f81db444f0bda66fee72f6f7b5c54.1715083479.git.vitaly@bursov.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1715083479.git.vitaly@bursov.com>
References: <cover.1715083479.git.vitaly@bursov.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Change relax_domain_level checks so that it would be possible
to include or exclude all domains from newidle balancing.

This matches the behavior described in the documentation:
  -1   no request. use system default or follow request of others.
   0   no search.
   1   search siblings (hyperthreads in a core).

"2" enables levels 0 and 1, level_max excludes the last (level_max)
level, and level_max+1 includes all levels.

Fixes: 1d3504fcf560 ("sched, cpuset: customize sched domains, core")
Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 kernel/cgroup/cpuset.c  | 2 +-
 kernel/sched/topology.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index a10e4bd0c0c1..c12b9fdb22a4 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -2941,7 +2941,7 @@ bool current_cpuset_is_being_rebound(void)
 static int update_relax_domain_level(struct cpuset *cs, s64 val)
 {
 #ifdef CONFIG_SMP
-	if (val < -1 || val >= sched_domain_level_max)
+	if (val < -1 || val > sched_domain_level_max + 1)
 		return -EINVAL;
 #endif
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 1d6eefa4032e..a6994a1fcc90 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1474,7 +1474,7 @@ static void set_domain_attribute(struct sched_domain *sd,
 	} else
 		request = attr->relax_domain_level;
 
-	if (sd->level > request) {
+	if (sd->level >= request) {
 		/* Turn off idle balance on this domain: */
 		sd->flags &= ~(SD_BALANCE_WAKE|SD_BALANCE_NEWIDLE);
 	}
-- 
2.20.1


