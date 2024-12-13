Return-Path: <linux-kernel+bounces-444224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF289F030B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE9B228440E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37610154433;
	Fri, 13 Dec 2024 03:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="GmUjXgpn"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05A342077
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060171; cv=none; b=RGEWKG+44xpl8i9yVmM/TSioYDMmeTcAXLr10RgU/YCi3SgQc8Pcw9y7CEV5q98I/ZWaAtN8J5/etfcGkAMbtlPI2ad032PMcQNBRpNTAlb+S5PGRk0MCaW2mP1CTXSuO3a9n9cnZtPrxpzZSIkdnHjbD+e/pDFeQgl+nK4aB8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060171; c=relaxed/simple;
	bh=MtB0mROcSpXaQd+kLVxPy3Q12xPN02ia9KfqhN8C7Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0T+kVxP3lM8Ibi+WviyfsmP0xZe5RvecWQ8hDhFp4SEg96GwshBouTfJUvCn4+h9IN9FKx/XBLYM3Kd5lDkO8tggs7Fj84MwazInhltg3dnhHU72HsXGBwtsKT4M85SeItUoKmbu6STS0UkJmelaFHoHqctgDU/GeTp77WaoKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=GmUjXgpn; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d89a727a19so23675786d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1734060169; x=1734664969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq3QSGCcIg8jrEPHQ+OcejvMIfKcnYcAG7J1U1mqBEk=;
        b=GmUjXgpnjryuHifrZyzas8533wPs3QHgx8gyyWScYZBYnnYa5925vWHF8lmJlN5A+F
         5TSKtTv25BAshtwIK2m5EZ8nzbfD7Pn5LuuCVRiccJotvAdsEIFrZAJt7/AROcWsNx0S
         TjFamRJbUdZJz/bOb432acdbcpznI8F0bKPXFMH2b/UGUJyngB+f/RfWkdNCZJU1WydR
         ba0gNGi22+S9t4BXT6SF5GTrZOU8DPzeCy4BgILkbBRZCgXcpmfddheBEeK2JeMuyb4f
         HNMMMXvLeLWoH4qVRWuDPLJ1xWJHMVCl+6JYrKNVZYOL6dLoPFF9m9yVj8NBfufxfG/N
         juxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734060169; x=1734664969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aq3QSGCcIg8jrEPHQ+OcejvMIfKcnYcAG7J1U1mqBEk=;
        b=UflRqjzi6lyHPrX0sdV2eL4YjRPu9vqSmhnXhdvg70hjrlp1jKUnAGE2kHBF8i1yYP
         j4rIhu9KsM8kopJ5m88KiRXynxlU00ASMC59RpZOd6qh0y3n1vXJOwo22/4MNG1s8MYO
         DUwQuKGEPkRTNMWinG+rZmGOAFQYScbaxERK8D6U/fwSIsXUHyoAg2b4SQ02HHmCxrod
         zSpxsU3MYOeJWV6TEuSowKP2lGETiQadV44RJTDNtcmBuUyEhn7wPcKgtuspI4UDCPce
         7iuwCT1so+fO+X2jvfOO7T3zC/T4I4rNgcau8FmltoNYOylLJ1cLeGGLzHzWtpj3xb8A
         aehw==
X-Forwarded-Encrypted: i=1; AJvYcCUb79f2mOVlrDdZVICIcUexPD9RtIrQoQ1ARwhpxvuCCesINWUyxGrkHYBlWDmQuayBpn32AYz2B09f+Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YweAkoPuOJGDAWhiSBBmL9Y7j+GZtY8vqkZwdJYCoIMTE/Nrtg7
	J4OwZ94c48BZEY54m0yz9T/4aY4L9ScTceBn7DTcR9blBGBINdgcarNA2wEyJQA=
X-Gm-Gg: ASbGnct7/CXvPRF2dxKZPBn5Mokst6ZdXc3opxFJx1+MLbVx7Rd/8q/9VxLoSnjQZ+p
	Nb0RYnGOYGNY0XByEJEvhKNGwii2ynT3No0S6DXGQ3GjaDWtwqv3/6mxtJ5PAOn8XwSObuQqwTz
	qyeLpmpmyeaPza5DlU5pSYmwTsMvmZOYXcb/QXpqHXYU68M5jJRDLGAkBcwCGmo1DUdFqo/fbbF
	GEagtYAoY62iY+RYw2pQJKl5bEwetpuQyz6aZlCpb0kom4ljcFlrZudf5Bp9CLLfgbNwUi1GFrN
	WcHUSxemq4J+ClMtTwfyCs47fZk=
X-Google-Smtp-Source: AGHT+IGnKBjuba9VJ7JKNVqRiU9SxPWK7rd6rwbBNA3r9Kt7mDm0a4h4RwaYTgB9nvl2mF18ShsKkg==
X-Received: by 2002:a05:6214:491:b0:6d9:ac3:e730 with SMTP id 6a1803df08f44-6db0f3ae28bmr59884676d6.5.1734060168712;
        Thu, 12 Dec 2024 19:22:48 -0800 (PST)
Received: from vinbuntup3.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da696d87sm88111736d6.40.2024.12.12.19.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:22:48 -0800 (PST)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	shraash@google.com,
	marcel.ziswiler@codethink.co.uk,
	i.maximets@ovn.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] sched/dlserver: fix dlserver time accounting
Date: Thu, 12 Dec 2024 22:22:37 -0500
Message-ID: <20241213032244.877029-2-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213032244.877029-1-vineeth@bitbyteword.org>
References: <20241213032244.877029-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dlserver time is accounted when:
- dlserver is active and the dlserver proxies the cfs task.
- dlserver is active but deferred and cfs task runs after being picked
  through the normal fair class pick.

dl_server_update is called in two places to make sure that both the
above times are accounted for. But it doesn't check if dlserver is
active or not. Now that we have this dl_server_active flag, we can
consolidate dl_server_update into one place and all we need to check is
whether dlserver is active or not. When dlserver is active there is only
two possible conditions:
- dlserver is deferred.
- cfs task is running on behalf of dlserver.

Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 kernel/sched/fair.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d80aaac4413..f5329672815b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1159,8 +1159,6 @@ static inline void update_curr_task(struct task_struct *p, s64 delta_exec)
 	trace_sched_stat_runtime(p, delta_exec);
 	account_group_exec_runtime(p, delta_exec);
 	cgroup_account_cputime(p, delta_exec);
-	if (p->dl_server)
-		dl_server_update(p->dl_server, delta_exec);
 }
 
 static inline bool did_preempt_short(struct cfs_rq *cfs_rq, struct sched_entity *curr)
@@ -1237,11 +1235,16 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		update_curr_task(p, delta_exec);
 
 		/*
-		 * Any fair task that runs outside of fair_server should
-		 * account against fair_server such that it can account for
-		 * this time and possibly avoid running this period.
+		 * If the fair_server is active, we need to account for the
+		 * fair_server time whether or not the task is running on
+		 * behalf of fair_server or not:
+		 *  - If the task is running on behalf of fair_server, we need
+		 *    to limit its time based on the assigned runtime.
+		 *  - Fair task that runs outside of fair_server should account
+		 *    against fair_server such that it can account for this time
+		 *    and possibly avoid running this period.
 		 */
-		if (p->dl_server != &rq->fair_server)
+		if (dl_server_active(&rq->fair_server))
 			dl_server_update(&rq->fair_server, delta_exec);
 	}
 
-- 
2.45.2


