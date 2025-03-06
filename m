Return-Path: <linux-kernel+bounces-549090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 876C2A54D10
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C736E1888D41
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29281624DC;
	Thu,  6 Mar 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="But92eSO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F199155756
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 14:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741270252; cv=none; b=PEYm8zag7pFcjVZu8GT4deAe16iNsVwynDRhh2daBw/ap/AAWpKGmRrgIzV2oaO3ZZhM62mbicjm7I6UpwMIl2uwg3RGXX6G9MvzetE8lo9GYdfAKdiFdFoeBfsYU5MAwlTzIWhXJIcfim5/DnpjDz+HUiUAxicCFGHyDEsw0K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741270252; c=relaxed/simple;
	bh=xcnCm892YVWrZWbMShd7y4D6hSOZDUxmmffjBmaQwmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqF2eo+xtJuKKYEy5b/YDg3NuFgtAHmpj4VT72SIa2VUs+7G/qTnMZAwCcuxr5ZWFsZT7z0Djvm6vOimtwtY2kpv5pV3jMVPY3a0JWTHNrGaIQtEbZJNh8Eu6Tt1LcOEJckda3R7wNlVb4bv/bdESJLU830bStIqIwpuyE6uqCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=But92eSO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741270249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fsKE1JxR4r83PaPSyABYFCVJq9bgn0zVEf+tY5alCNY=;
	b=But92eSO1pRXl0/iiyyKPjy7fucwuvtZveWw5fL00Jv1dCMF6kohXlorWSWzSfNMBssiEB
	HEnSrukPXXk6+B2WvRWE/krgAwnISt1zA5mrB/Njf1HzqHZ/SCQwfpuLnQTE6UkgWfkVkN
	YZrmIAsQZX8E9rD9v456XYObpYit+B0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-VhrRhwMdNMGSGWbzW1aKFQ-1; Thu, 06 Mar 2025 09:10:43 -0500
X-MC-Unique: VhrRhwMdNMGSGWbzW1aKFQ-1
X-Mimecast-MFC-AGG-ID: VhrRhwMdNMGSGWbzW1aKFQ_1741270243
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7c3cca5d865so354687885a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 06:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741270241; x=1741875041;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsKE1JxR4r83PaPSyABYFCVJq9bgn0zVEf+tY5alCNY=;
        b=u/2Tt9q0oEHnbfZ7hqwUP7SPUB0Gcz97GKjKSK1yBH2owMfgNkF2Ug6PIS0UhD1EJf
         j0GZx5RwCr77rAYaoJSS/TZZ37T8vH1n9UjmxfIVIADVqlqtJw+rqK5XH7sQe4RSdaPd
         FPG+PVY0cS3wlWoaQ7xQvn/UrrRVQmotQLL0A0kn6aZMigAG96YCCo9D0IuEqjDtsKpD
         s38MnEc7RqcZ0NRSki7MC10QJfmLFjoB6lMZo2KmsreEBM7YPlUVVFyqU/TcLdLIQ2yr
         8tBY71PVit63gWgfV5Sk/MTFx/9kjMSpamngr+/fpmz4kShHyv56G4NIh2D/1ORjZGXf
         PpUg==
X-Gm-Message-State: AOJu0YxOdnzuvVGcdMeURBHOg9+gweas0iyOBcc9Az9KaDPRKFRtivdW
	LOZ/7BOVuCq8fDfkdk1Cu1OVeYN6OZ/tBGhuW57Bpxl32eKaLEyIhIQKyl2eXwZpb5339lqeDyx
	mrLyX36bpy4U8Y8xW20XDr7rEymQocwo/cMpnsvGPflpRD4JpZVaVDShjm6wCzpNLeWHWm2S/+L
	iCtz1tvRNo8J7Xmwldn3w14v7hJaDCU9E68NgmMhtt5IJVfLAZevs=
X-Gm-Gg: ASbGnctVwV5eO7VeIQcl2wo6SxbNb6H3YupQ2LTtpbJHdJwJ1ljF6P9Gjb3za46a4UF
	qX5ImsOhU76zfB2r6uixNoKmL+mbq+Uf+knVONUB9I5HpJM/gVMuH7uQJci+BrFAOKjr2LNW47A
	WBT1DPsEKiF/ov2baUjw1WlgsrUnFsNJAH4rMcTZLAUuaVx+qoZ2hgh9QeVCJvuuaIFBUSiq7Rq
	OpHYEwYbPFiz1P3yoVkA0kOCyLsLTC12IWnWpTW9Y3DMgGrJk+vXSDH11HlP0s/XOHEjD32a2Lc
	D68haw41WQdVCTj8hmtkYF1cIeuhyl6h0lb7b9KvL6mv/ZYvHm83WyoLCiYxbSFHeCEJMKHCoUQ
	CtOJe
X-Received: by 2002:a05:620a:1b96:b0:7b6:c324:d3a5 with SMTP id af79cd13be357-7c3e3a1c910mr432228785a.19.1741270241084;
        Thu, 06 Mar 2025 06:10:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdyD8P5f8M2e9rNo87PDZMvWDzY4ue5a2vKgh31vwHmBPocp18qKgVS97FsSXL2hbSExV6Mg==
X-Received: by 2002:a05:620a:1b96:b0:7b6:c324:d3a5 with SMTP id af79cd13be357-7c3e3a1c910mr432223185a.19.1741270240727;
        Thu, 06 Mar 2025 06:10:40 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-89-240-117-139.as13285.net. [89.240.117.139])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e551119fsm93658985a.108.2025.03.06.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 06:10:37 -0800 (PST)
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
Subject: [PATCH v2 1/8] sched/deadline: Ignore special tasks when rebuilding domains
Date: Thu,  6 Mar 2025 14:10:09 +0000
Message-ID: <20250306141016.268313-2-juri.lelli@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306141016.268313-1-juri.lelli@redhat.com>
References: <20250306141016.268313-1-juri.lelli@redhat.com>
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
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 38e4537790af..ab565a151355 100644
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


