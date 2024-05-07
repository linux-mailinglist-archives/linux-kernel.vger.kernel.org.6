Return-Path: <linux-kernel+bounces-171281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD5F8BE222
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09CD31C23673
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8677E788;
	Tue,  7 May 2024 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b="pqXfNRDR"
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070221EB39
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085070; cv=pass; b=szr4ykmtXP89O7WHTU2Uvw+ebbfL/DbNRHV+kL+F8hoiOfoNYw08GopAyPW3glHykqmBJz9OiDQS3GeLXbMyi3QRvcltUSBPV3N0ajoXU28JED4wV84jQ9BseBAfs+fqkP8EEM7bV6nMa6w8Jylgu3fzdz9TdvcWgSaKDBPBeWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085070; c=relaxed/simple;
	bh=bs+h8XBwWTekscegq5DgAwV/n02OCwwakDqEuTkElAA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KFzFFIcf8tyexW6+xBRfiJMyTtlw8KDvI5lYrRRqH7mmL+cRiRRsStQQCARK+A/IBR02KnYXcKppReVJ0gczgUFpoa2QDCjx7tu9pyYn+qP9e961CC9KnOY8aiwFTHzz5aTBzD/FiRY6++8tu4MYrkYmYPEUFWp5OGEWxgRxjrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com; spf=pass smtp.mailfrom=bursov.com; dkim=pass (1024-bit key) header.d=bursov.com header.i=vitaly@bursov.com header.b=pqXfNRDR; arc=pass smtp.client-ip=136.143.169.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bursov.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bursov.com
Delivered-To: vitaly@bursov.com
ARC-Seal: i=1; a=rsa-sha256; t=1715084145; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=kwVJ+N1mjKd6Co/P0zGuK5KQd/aoxmUeGKS+d2meh6+yVidMcN2HfEY43ZR96cJJSt8MOFzmYqTQ0GPIsFPIpeqc3AU7Nq6ypOPdRzJKSKe1fgVSCvsN3qr8LYZKk2CuH1P2nyk4JzhMZPHNiDehEvooeLQZTLL4jL9+OCQL7yA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1715084145; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=AlUlR02UFXlJEerPpMyC2hkxwpJ7T7Z0GszKEfkWHbk=; 
	b=jqADz9Z2E1Mtx2NS6NLeMdLzIEFJ2PcXqzFO9j6q+ACDAk0qVu4UPYsMa0o8Eqpr7kQ420uOC4d/MVF7HPz8UJOf55ZMRUPtWKQe1u7gn875ZitK3YB7K7a3NDyX5iUtVNgINOTou+eicFU420XWBcHwOs0mQhuKUnfyyYDgnJY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=bursov.com;
	spf=pass  smtp.mailfrom=vitaly@bursov.com;
	dmarc=pass header.from=<vitaly@bursov.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1715084145;
	s=zoho; d=bursov.com; i=vitaly@bursov.com;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To:Cc;
	bh=AlUlR02UFXlJEerPpMyC2hkxwpJ7T7Z0GszKEfkWHbk=;
	b=pqXfNRDRw1Rpm4pvBwrV29vB/We/8YAqmq9V6uEsm2K2BGq8jV+pU5PbQxj+XY/P
	YdSP1oIKE6cVGWFYOJaeBd+JvJ0McFo41m62SjXYaxM/CT65Jl+g/ZTQ5FmasZttjVs
	rhb6WzDNXntkLqOqaroXJp0F8Nvokyp4x6GAfJVc=
Received: by mx.zoho.eu with SMTPS id 1715084143194878.4481998596577;
	Tue, 7 May 2024 14:15:43 +0200 (CEST)
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
Subject: [PATCH v5 2/3] sched/debug: dump domains' level
Date: Tue,  7 May 2024 15:15:32 +0300
Message-Id: <371eb783614dd9263cbcc91c9a560adcabe6e539.1715083479.git.vitaly@bursov.com>
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

Knowing domain's level exactly can be useful when setting
relax_domain_level or cpuset.sched_relax_domain_level

Usage:
cat /debug/sched/domains/cpu0/domain1/level
to dump cpu0 domain1's level.

SDM macro is not used because sd->level is int and
it would hide the type mismatch between int and u32.

Signed-off-by: Vitalii Bursov <vitaly@bursov.com>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/sched/debug.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a5834d..c1eb9a1afd13 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -425,6 +425,7 @@ static void register_sd(struct sched_domain *sd, struct dentry *parent)
 
 	debugfs_create_file("flags", 0444, parent, &sd->flags, &sd_flags_fops);
 	debugfs_create_file("groups_flags", 0444, parent, &sd->groups->flags, &sd_flags_fops);
+	debugfs_create_u32("level", 0444, parent, (u32 *)&sd->level);
 }
 
 void update_sched_domain_debugfs(void)
-- 
2.20.1


