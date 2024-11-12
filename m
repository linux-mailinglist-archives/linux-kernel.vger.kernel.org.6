Return-Path: <linux-kernel+bounces-405003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F139C4BA2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8321F23E73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 01:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC26204956;
	Tue, 12 Nov 2024 01:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="PpLz7UjX"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE79204936
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 01:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374577; cv=none; b=dDzivqe2bMdzGtMDAMuxuTo6pN844mtrMQXSPQnpeePBV0nDQBCsQ33fYz9FMdnq1wiQq1qBTWYy/PF+MWXJqbPheGeK13GBQYD+tRMgx9bhm98EyQjncubikn8dN9kbY62xWNxfxksKmGAVD129JyqmIwY28iCR58DYODd8SnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374577; c=relaxed/simple;
	bh=IAndtTh0Zn0TdJLA0tgslqtGvIK+aWgCZ12flTQsde4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djeM1IO8Ee7Mmm3IkR7fYGBuKmKrSAMnu/jINkjfPXMI+mLJKyi0GZPigzmefvPrPzMS9DxelgcTWv6BubsekRN1h083CD82MuVnvcX0cPINEdc+6x9Twws3gdvmXOqgGh6De3Gu4WX/j0aNTGhn5PPxqh0pC1vb1xLyUgXJwT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=PpLz7UjX; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-8323b555a6aso282639239f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 17:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731374573; x=1731979373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cM99zmHPSekwqj60iOGSvREH7yo5u3cJBx2jfmZqs1E=;
        b=PpLz7UjXbUDzXj9XE8NFY1lcFPBWzE1LkcVejdjbHZVuzT6zc7b1htPZPPWvkY/eb7
         KGmgeSQ1Q6v5GWVMRqOEIOwu0OjyomlX2vysJ/h+t4QJ6X63lumiWEfg8REUrJzMEaZt
         xmrx7sY9RKOSxu/31mYKtB5VG6k1CbgwHp4jU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731374573; x=1731979373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cM99zmHPSekwqj60iOGSvREH7yo5u3cJBx2jfmZqs1E=;
        b=BMEpRUIaj2Kk2crlosCt5aKU3OqXAUbXOP9WISOrHh1sLCPlfT407Yt5V6b8UwmxNY
         kc19pkFfTfLQvLmU2YAkVdtpPi56c5D/SaVGYioWSescy81WF9jKzK96LtuDPij4KWCi
         MRAaOxYX0q1Ng1SVRMSnmqu0ufBNPUbAEAgy9l4ESjZaU06Umr4429brvxXIzMsMC6gg
         IPxzzpP/X0WWE2rcH6J8re42yoZS5RGDNMBxYn9ktUgL0xvxuG8nTJ6LxKLDmApnigU4
         TfPqoPSr4neM/lxfW8n9KWvXQcnJlTixCCUIqSAHd+X7xNxjkB00LtX1Eurmh9WI7Ym1
         kpqw==
X-Gm-Message-State: AOJu0Yzpq+WjbVqBVgCx+vEvL6iGVB7oEMND93Cx7miyNvDQnE/97J2A
	IpMB4hCliXp1SQyiO99tYHwxMK+6Rpy6KrOe+XommE6pr+/YGUlzSiNQJHldHTG0W4ZxrCUCPn3
	o
X-Google-Smtp-Source: AGHT+IEwVtl4mLuqIAZDvh2f34rMK6TX2rX/yUBHUcND4fga3+LcUGqjZuGgcATr3ou47u65Gg1IxQ==
X-Received: by 2002:a05:6602:148c:b0:83a:af81:f509 with SMTP id ca18e2360f4ac-83e032bab3fmr1641337839f.4.1731374572961;
        Mon, 11 Nov 2024 17:22:52 -0800 (PST)
Received: from joelboxx5.c.googlers.com.com (222.121.121.34.bc.googleusercontent.com. [34.121.121.222])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83e13558519sm155581139f.44.2024.11.11.17.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 17:22:52 -0800 (PST)
From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
To: linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>
Cc: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
	Aashish Sharma <shraash@google.com>,
	Vineeth Pillai <vineeth@bitbyteword.org>
Subject: [PATCH] sched/deadline: Do not start hrtick if its disabled for DL
Date: Tue, 12 Nov 2024 01:22:39 +0000
Message-ID: <20241112012240.1887813-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix an issue where high-resolution timers causes aggressive preemptions,
leading to increased idle times in CFS tasks (which are inside the DL
server). The problem was traced to improper usage of hrtick_enabled(),
which could start high-resolution ticks unexpectedly causing repeated
preemptions.

The fix replaces this call with hrtick_enabled_dl(), aligning it with
scheduler feature checks.

Reported-by: Aashish Sharma <shraash@google.com>
Reported-by: Vineeth Pillai <vineeth@bitbyteword.org>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index b216e6deeac4..d46502b9ce58 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2121,7 +2121,7 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
 	if (!p->dl_server)
 		set_next_task_dl(rq, p, true);
 
-	if (hrtick_enabled(rq))
+	if (hrtick_enabled_dl(rq))
 		start_hrtick_dl(rq, &p->dl);
 
 	return p;
-- 
2.47.0.277.g8800431eea-goog


