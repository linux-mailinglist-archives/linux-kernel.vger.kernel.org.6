Return-Path: <linux-kernel+bounces-368908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED0C9A1661
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 01:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E831C208F2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 23:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7AE1D54FD;
	Wed, 16 Oct 2024 23:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zF+b6LYA"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FDE1D279F
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 23:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729123152; cv=none; b=nG9HICdgBogzi120Fs7ZU++pME9O9pTnaKIROI0Nfmy49faM452Dx+LbIGCgW6Iqh+rh40+ytrUA9OzYvEL7Gl7Tc44vdnAlbLBu4FBOd/NpEiCRXS16R+x7V4Ez5EBIS1LuO5HVnGDDhiQCCov1zkTVgNMB26g4NYEL3bsZ/0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729123152; c=relaxed/simple;
	bh=qk8DnLKpYRGaZKadjcwmDcY8KlKCGiiMvvzSi7YcyCA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mebKEfSAOc0Pvkb6PSHb6/rwQHd4biY14dmuJeDHUvND7vBj5FLgUsM/zneyN6hfVhG+CMOoQiTb93WkrwTik4jpeN6jSI180eYAV9noB4GZt2NlO3wEl1o8mU6DWpMRMW0tNiL/VR5Y2hqlkAuDVfEyGXGMtIiK5P2IJ5v87aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zF+b6LYA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20bb39d97d1so3297105ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 16:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729123151; x=1729727951; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkQLWlX1qOuy/21sENmYkwKbiMRVyU21VpsG1rE2t1g=;
        b=zF+b6LYAL/eeAfIhocW9vAvd8j0mHelRomZWtdltTUQhpvbFOF6frO/25sHK1D/RIC
         h8WNDRd5HzOeP2d4wtEfEI/pRG7KsB6ynFF/yxDkr4H5O28qU46sHaNTwJzIBq34lF8p
         Z3VmJctoe0IOCGIVuWFHZTNHlndXcvL9YctHPOrt5W0imW+eqSrb7LzqHViSLLvSCJbe
         kIeqYKjVVk29++NOaIolQwVhvbxucJZmFk06ME1F+CNlb0UVyhn95nAs+u1G93YuiJ9U
         mW4qFZZry3RitZRIFQUy0ukllxZknwSvtxkDrKEQJ/BPoqaGHRydQCSibi38BKtF3NUO
         5wSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729123151; x=1729727951;
        h=mime-version:user-agent:message-id:date:subject:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KkQLWlX1qOuy/21sENmYkwKbiMRVyU21VpsG1rE2t1g=;
        b=bFe2ufX4ApQr6FBD6ZOMGDWLIL9XEVeQoOQDQm+uiEBb6BzFj6jPCbpB2bzX0lhIl3
         WhYiO4Y2LyQXnCBRIZj66f4UumDKuboxe8r5lxZepOk8vx4cuwuG1vvqNltKQOYFv2am
         rvgEIEwQAeYi46eJiCwtiPuy+YL29E/Nvv70mQMM9lVsEgQEB6gnFqDkq1AX63c9S4Op
         OMUDR2IWVWOIBfBiaclNOaH3FR8IsC5xdz41eJSXN+4MrgoPxqrOxxbr6E44kONhIDVM
         0QaU6GJkDZjvNGzRe3ruzn+EtyB90dC88Xxht3ditJbYpj39xI2MP+8aUDbr2k4F52CH
         rdOA==
X-Gm-Message-State: AOJu0YzxG2chEtgD1TQk0DVC6onUcraxQM5VUlMe2/FTcb5lVCwuw5CR
	OdqcEQg0f316kRzhIb4rAHZ1Y0WaoPf/CVlU0G/GBwmgvJH8EEYwVnqra7ACqQ==
X-Google-Smtp-Source: AGHT+IEq/Gh3YB8YAdnCgeZU74s7RWRkYJv5ZXZ8PJ4hXj5t573bmygw5UI4gWAMNif7ia7oN9JhWA==
X-Received: by 2002:a17:902:e951:b0:20b:96b6:9fc2 with SMTP id d9443c01a7336-20ca144e816mr280486905ad.10.1729123150613;
        Wed, 16 Oct 2024 16:59:10 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20d17f84e66sm34293235ad.18.2024.10.16.16.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 16:59:10 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: linux-kernel@vger.kernel.org, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Chris Metcalf
 <cmetcalf@ezchip.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] posix-cpu-timers: clear TICK_DEP_BIT_POSIX_TIMER on clone
Date: Wed, 16 Oct 2024 16:59:08 -0700
Message-ID: <xm264j5bd2gj.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

When we clone a new thread, we do not inherit its posix_cputimers, and
clear them with posix_cputimers_init. However, this does not clear the
tick dependency it creates in tsk->tick_dep_mask, and the handler does
not reach the code to clear the dependency if there were no timers to
begin with.

Thus if a thread has a cputimer running before cloneing/forking, that
hierarchy will prevent nohz_full unless they create a cputimer of their
own.

Process-wide timers do not have this problem because fork does not copy
signal_struct as a baseline, it creates one from scratch.

Fixes: b78783000d5c ("posix-cpu-timers: Migrate to use new tick dependency mask model")
Signed-off-by: Ben Segall <bsegall@google.com>
Cc: stable@vger.kernel.org
---
 kernel/fork.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index df8e4575ff01..b57cd63cfcd1 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2290,10 +2290,11 @@ __latent_entropy struct task_struct *copy_process(
 
 	task_io_accounting_init(&p->ioac);
 	acct_clear_integrals(p);
 
 	posix_cputimers_init(&p->posix_cputimers);
+	tick_dep_clear_task(p, TICK_DEP_BIT_POSIX_TIMER);
 
 	p->io_context = NULL;
 	audit_set_context(p, NULL);
 	cgroup_fork(p);
 	if (args->kthread) {
-- 
2.47.0.rc1.288.g06298d1525-goog

