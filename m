Return-Path: <linux-kernel+bounces-543529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0ED0A4D6CF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:42:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E791742A1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DB71FC7F0;
	Tue,  4 Mar 2025 08:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S6/wU8aI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968141FC10E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741077712; cv=none; b=Z/ve5OuDjav7tTskTmZH7acuCUL12UAklFkWMczsCrteMWTnC2XEKGlv90AevTRfs1XVz1Fy+5/wSzemx5un7d5gCRFomwuiZPOJgrwrEP48cIPAdDiJnkDDAKjSW6Asu4HM7TUz++UkhVUv12Uc7NiGWDtM9Q7AFM/iRsOaFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741077712; c=relaxed/simple;
	bh=+tyAV4Hec65TSNaKqrd86BlyoB/UL+9or/H6GiAPaFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+tNeBCcePZw2bx5psoIIJ3zQK8okzp1lZV7qcPlbGOpfT11EtLZdQft+ACVbHLuRA8Svu5xF84E357YzcNmTWKM9BS4kFxQksFL30+G9aUoKBW9mS/NMRIF38CiKPIW97yliUOI6BBxw70ZRP2bzcq5O0VH7omDdHlo5/pUBwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S6/wU8aI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741077709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3+x8ZcbjsMBBC18OSg29VFMjfEWmgYEE5sP6YSqtFk=;
	b=S6/wU8aIJhgoFfzzB0vuy1DOxy1xtkH/LitEEJgWete+ZFM6SkCzMXP4d2cD+TZqqQVZ9+
	OWAgLGao4hAKGxXeXKbj/pffeE4nxLdlQVSHP0GLzbz8lP+Th6z8k8BcQ0DGcPiWiOZQ7G
	zkiGfu2Imd3WBue50yEhup9EJCXq+no=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-xFlAg8VXMXupdZf0-QhWVQ-1; Tue, 04 Mar 2025 03:41:38 -0500
X-MC-Unique: xFlAg8VXMXupdZf0-QhWVQ-1
X-Mimecast-MFC-AGG-ID: xFlAg8VXMXupdZf0-QhWVQ_1741077698
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7c0a3ff7e81so1167051485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:41:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741077694; x=1741682494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3+x8ZcbjsMBBC18OSg29VFMjfEWmgYEE5sP6YSqtFk=;
        b=Tho5me/XTlWI0W0jS/+E0PczDuypAmNHUU6Ks044ueEa6KAXFrEvN6KSLhuLvlf7Ne
         rupkaoOkvjC1Sg1BFyJCkQG5cU6ILb+MwjFdTVIP+ZwVWCADH5Ns6NtqDWo3zLFbdu2P
         c9uY/4HSMUr5SVw/X3W2UEjwaDIayMI+ETHPexr6n6Zns1TIOhCofqoAc6qFlXC463gF
         vwm+FCYwDNoe+3infDSgoEeLzNgflIPoBdzyE6kHTviCDejNM7EcKgcJifAlvPyylCYH
         v0Eq5rAM6BZ/NpsAhbeBeQ1Y9YSsVNENJB8IKRtvjWFLGDtGsHejBH7SbLok9VSk7HyD
         zOKA==
X-Gm-Message-State: AOJu0YzeqLNOhx1ZzzwcUP3wFnlhhOSp9dJy+5SK+v6L4jVOBSqOJA1E
	Mo1P57Gb0UrFSEp4DgNJzw0R8ksp2dSdvcZvW3WGalplCS49YMKTec/SJK/hzDt8RT6Z5ZVrA24
	eXxEPRbR+oQ0G0YvZ3OHC1Tz2UwhuJVABUaUmhzGJyaFhzyHsldOf+zvMym7dBd5oSmDEL3XKVR
	u/2PY43lHuoAtezmbfHlbzutYMpgiaqlKUe8LCpd0Bq/xbENt94hy4fg==
X-Gm-Gg: ASbGncuqkmCV2lQK6U5SZ+Q8K56n7oTeSIjGPIweaNzC2gx0cRUPqsDWzwUBzKXKg9L
	5KrNR8LOJ+kdH1GB14cguRQd2yKk/uWGT+cVMbP+Kam77sWFuYK1EASXZnbfdX++tkNbzlJuKZu
	+YXAJpbtDm3TV0HCoRVfl2mBWw98fi/IgKMpqVmrw2sWvOVFpXrPGTA3LHoa2Fls5wlPTm3p+9R
	I1VrlDGaQtwS5ItrbyrBRKjt3P3s+F2t67E6vOUmof0XREKvewPDSc8dlZINChfwRGVrhGrkSMy
	9lVIWlYJGE3yMeT+LS8bB51RL+vpLR9ezTyjn7KC6nx/4v4TAGF7yyDVWtgvHa/k4ZAe+vxjznO
	XP3gP
X-Received: by 2002:a05:620a:24cc:b0:7c0:a524:fb9c with SMTP id af79cd13be357-7c39c67e5demr2469796985a.47.1741077694109;
        Tue, 04 Mar 2025 00:41:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF36ZSWWjVDT1inIQxVAoHh+evvEzMmrsNt8O4ZQ99AjTkmT/HmwUmDBF2MKdn3vcE/w9gZ7Q==
X-Received: by 2002:a05:620a:24cc:b0:7c0:a524:fb9c with SMTP id af79cd13be357-7c39c67e5demr2469793185a.47.1741077693721;
        Tue, 04 Mar 2025 00:41:33 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c0a94fbbsm218395285a.1.2025.03.04.00.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 00:41:31 -0800 (PST)
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
Subject: [PATCH 5/5] sched/topology: Remove redundant dl_clear_root_domain call
Date: Tue,  4 Mar 2025 08:40:45 +0000
Message-ID: <20250304084045.62554-6-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304084045.62554-1-juri.lelli@redhat.com>
References: <20250304084045.62554-1-juri.lelli@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We completely clean and restore root domains bandwidth accounting after
every root domains change, so the dl_clear_root_domain() call in
partition_sched_domains_locked() is redundant.

Remove it.

Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/topology.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index bdfda0ef1bd9..c525e919f383 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2725,21 +2725,8 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 	for (i = 0; i < ndoms_cur; i++) {
 		for (j = 0; j < n && !new_topology; j++) {
 			if (cpumask_equal(doms_cur[i], doms_new[j]) &&
-			    dattrs_equal(dattr_cur, i, dattr_new, j)) {
-				struct root_domain *rd;
-
-				/*
-				 * This domain won't be destroyed and as such
-				 * its dl_bw->total_bw needs to be cleared.
-				 * Tasks contribution will be then recomputed
-				 * in function dl_update_tasks_root_domain(),
-				 * dl_servers contribution in function
-				 * dl_restore_server_root_domain().
-				 */
-				rd = cpu_rq(cpumask_any(doms_cur[i]))->rd;
-				dl_clear_root_domain(rd);
+			    dattrs_equal(dattr_cur, i, dattr_new, j))
 				goto match1;
-			}
 		}
 		/* No match - a current sched domain not in new doms_new[] */
 		detach_destroy_domains(doms_cur[i]);
-- 
2.48.1


