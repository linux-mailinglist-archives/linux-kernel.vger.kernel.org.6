Return-Path: <linux-kernel+bounces-444222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D879F0309
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10698282E32
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 03:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9511C1534F7;
	Fri, 13 Dec 2024 03:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="m42JSR3e"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C7A39AEB
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 03:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734060126; cv=none; b=nY7OxufPAuSfeLSw5Nw04doCKJvODeSiL9jq9bzH8+iclzxRQUkPye2YIRm4SgezGBN56ImV608GyCwSKFbycUl9IAT5tDXwIGc9Mq6aQr3nF3XmA5+HW/xk/RdAUjv0tfz2XZssj9NNIpkbK/fLnJIFwXuvO7Fe5RCKDBaPlKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734060126; c=relaxed/simple;
	bh=MtB0mROcSpXaQd+kLVxPy3Q12xPN02ia9KfqhN8C7Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtgX02lz2p0y7xZW5FJ4z97GMALkvydj2AVKzag7WPIJXhIx4vY98tQHz0ZLOxc0bKce1uI6ESHA0Dn13lcjUqFWAH0PgsuqtNCYLlMFBphq0SZemA6XpMAxtRNCIJpMmQxAbvnVxvwBTXRZv90FYNq1cZwDUwf+M2cytuo7C2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=m42JSR3e; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6d884e8341bso10626326d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 19:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1734060122; x=1734664922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq3QSGCcIg8jrEPHQ+OcejvMIfKcnYcAG7J1U1mqBEk=;
        b=m42JSR3eXvPIw9q2lYCQjbS+d0b2DVamJrkzmKybTSh6xCrnqQ64jJHV/PCdcx7MC8
         hOcADV3cUXQbc49MzazEsq4fP6HtRD/kENjWeznClnXeMiOfMoVfHvRUoODco1sMXrPL
         aG/IUlVGsr0iIhTQE9XE2qeEJPIEYhcsY876lQyQJcdYytP2gkpFsbM/xSftidObQj0x
         D8QQkBk6taw+TsSh1uh5zhH2XcRTpecUQFzDEGknE4EWQ8JzSuW+3gC1qnP84OGAgKb/
         JISebnNu8xBi0Stt0A7dppFZuHh2dye5kMX0x46Nosw36sjMnEXlbrknBETWH/EBeHJ9
         vvGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734060122; x=1734664922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aq3QSGCcIg8jrEPHQ+OcejvMIfKcnYcAG7J1U1mqBEk=;
        b=aO9WbbPiRSEeJYg/fH76iaa8kW8JiOxd09GhVlGXyxWlop0ldKKX54g//iLD1fr2Dh
         DRUMFcX1YiUnwKjU2wSg11OaIUzQecs2w/La4FufNlDLHsdH2hk51Ksl/GZcqQPaaTgY
         mr0RMQfXzBgNa78EMRBDc28o/K8nTYKOM7vgZ7x9oiyHJde/9zNFHC/5P9qNGXbNYoXF
         DMC4qLp/17inZcDzlrtlQU9Io8V9onMzzek8TdDnJw+rvCv8V3yBD/FbFWyEEQORlqOv
         dKy70Rgt1crQ9SMG3XrjbVkRGmvMenKTJPA9ylNIbYDGT0KteTm5L4FRryUL2JOU+jva
         fFmA==
X-Forwarded-Encrypted: i=1; AJvYcCWxrjFkq795GJfqYzbiOEOhSpIULdykmJn9/fqZpVxnpgC+XTyhM8QMFYLCclxv42UcFipDjv+oyMdt43A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIyTlJbyBnHrZPZSORlsnrDoo+tAP0bw4mxCIbg2g5gU5tcspy
	hw5JZtsarQtVU0+qN7/+ttMIc0ylsXawirC0kRYNu3u+L8QZsIV/H0zLhO9Ht38=
X-Gm-Gg: ASbGnct52STUU9a7om9wIThLcMjcbC7Io7EzCHqQE1jnGkF3OsojB6JCGjD/uTr4f3z
	qeMOBbsSjBKjrqlN8a6rdlPZDlz46d6LZQr/BFwRGN7WySTvr5cTq8Q8gtAT3U+LOuZCwkMqCAX
	r6BwLIAw/tDLdNCj4FzP0qcr9bEzuoxTAI/EC/wjYrYFOReG/deGHKxJKecIxKsT/LzNulu1hOE
	AN+ddQpHwzSx4Phs2houtvooCnWeTg1DGp7lNPAvRnPeZja2oEigo13hy7oSZq0PmTWOsYNqgxB
	QwDUH2BvEtmkLpXdtLB8sAIyV/Y=
X-Google-Smtp-Source: AGHT+IF0KjOH64KK4cw9tAzDHgOb6hBMNFLyjnNW/LogldaLGJ3n6sZoHIkMkkWrZlqeh4scKdG0QQ==
X-Received: by 2002:a05:6214:27e8:b0:6d8:8cb0:b40d with SMTP id 6a1803df08f44-6dc96838cabmr18663966d6.39.1734060122402;
        Thu, 12 Dec 2024 19:22:02 -0800 (PST)
Received: from vinbuntup3.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46787a4c953sm28052941cf.8.2024.12.12.19.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:22:02 -0800 (PST)
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
Date: Thu, 12 Dec 2024 22:21:47 -0500
Message-ID: <20241213032155.876919-2-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213032155.876919-1-vineeth@bitbyteword.org>
References: <20241213032155.876919-1-vineeth@bitbyteword.org>
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


