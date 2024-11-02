Return-Path: <linux-kernel+bounces-393427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 024FB9BA068
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 14:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF111F216A9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 13:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE67818A6DE;
	Sat,  2 Nov 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVXgTYXv"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFD81E515;
	Sat,  2 Nov 2024 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730553593; cv=none; b=X8V5XnWvWb398WsKPvhrvfwMfu3PPSyiws4/a5a936S/Q6Bqzk+dEqqadX+lLmsHxyJxZpdJclMpJ3mCGmQEtVMxzlzZtDAdoRt9d5eC20dtdbCO5xF13ffN/wSzvqTZxEURV4Pk2dFvyJYjIEiHJ09O5Vw8wi4cdCrZlcgP7bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730553593; c=relaxed/simple;
	bh=wED+x61Q79e/5l6rbyVFWTIAfDtFGCCoyUb99z2B7Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZSWhaeS1MJ4L1X6EbsgdyteugC14sKRkH3pe+jczNU/NwfS9j7gJgcuVFU7NYw7HGz/tko4esf/qa4Qvsukiey5v4uwtTpYrGfaatadiUo2iJcTUBlPoe3BhR1qSuxveEMhCeXIY3+RY1sylv8NmgTcqZzbFcZ/nMX6x3jdC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVXgTYXv; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d49a7207cso1800526f8f.0;
        Sat, 02 Nov 2024 06:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730553590; x=1731158390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VNjbsXYarx5Cwx6o4J5SX3gop3YfcIyS6mrYeI3nkXU=;
        b=XVXgTYXvbkck0OWQsDY6lsRU07MzPEV8FIzW53uNy9e0MG+Hu3SXTKOf54O7TTFzep
         9mzfu+mghFrIseUpSxY6CFuiraABJTuky7V3zbu3NgUcpyvqW01Ym6Ms8Evb4F/Etkg3
         gR2PEygyS+4IGRvSg0byPiXBIPJjxQ6V3B5JUxevY+fvgzifNvrbV4hdneb5Vf86ETtP
         ptu5yvLsX79LRv9Ti+xE+bVxvElYL3chjVjxOD9egYsvVmVq9tqdT0qjAttXqrinojuo
         MpgXUEQMX725QviaG+ExEVj0wjp3k97+u0ldmOacL482+ALW8eiz7ghGTddhqf46M67G
         0J2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730553590; x=1731158390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNjbsXYarx5Cwx6o4J5SX3gop3YfcIyS6mrYeI3nkXU=;
        b=azn12xW6DfbsfG16NwTxMWjSAC1XZA3zQfiM3lKxWJNDoiEixVFLUXrSnsX8yCIbIs
         N+dfnnk6pzW8JHUCe/OK5yS81kXScD8U+7hVk5uW68ic6CPzBHf2dP/IyhdbHInHxEDl
         MlcUBX+Q6ukTTK4flxPMsdm8oEBM1p7IdXHtQOrrGLt1DNa78fLmMeAtx0hx0AHKu4M/
         23TRdDC18e+DR9GaB5g84TwjovCWl/QkGPbFstVsIxyfDLlnOlzyDvntAC/kbU25wyHu
         nkSg3liT+nYhijoBiLn1lEaGSW0PwemknUTUeQJs/w1Pcfx+EPEYh9qA0Qi4+kF3TJ+g
         595g==
X-Forwarded-Encrypted: i=1; AJvYcCVtuAMLR5OxmJubICSHeBrS1EnXn/KOCujfD62jxMSB7JksdvM61hGFqHEsDdbAU4OrpngIUIke6U381z4XJw0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa1TT/P1CsXbaq8TpDmdgpMF6J2V1RYCNcaSMc0gqLsj/0bDx0
	O+g//HDzMRV3pQDu1+84h8KUwTVGTxz7y34N8orMr3dZYXoE8Kc8
X-Google-Smtp-Source: AGHT+IFA3OsiRXGZXVKSqPw3MLCq0HGxbGt3ziNHXqxTvyekoViaVoTfJ0TlFd4AfWDtziCYz6Z9rw==
X-Received: by 2002:a05:6000:1844:b0:37d:481e:8e29 with SMTP id ffacd0b85a97d-381c7a5e1b6mr5022463f8f.25.1730553589518;
        Sat, 02 Nov 2024 06:19:49 -0700 (PDT)
Received: from void.void ([31.210.180.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d4d82sm8109163f8f.45.2024.11.02.06.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 06:19:49 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH] sched/topology: Fix a typo
Date: Sat,  2 Nov 2024 15:19:29 +0200
Message-ID: <20241102131943.10103-1-algonell@gmail.com>
X-Mailer: git-send-email 2.47.0.170.g23d289d273.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo: borken -> broken.

Via codespell.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 kernel/sched/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 9748a4c8d668..a9f4fe81a14f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2337,7 +2337,7 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 
 		if (!cpumask_subset(sched_domain_span(child),
 				    sched_domain_span(sd))) {
-			pr_err("BUG: arch topology borken\n");
+			pr_err("BUG: arch topology broken\n");
 #ifdef CONFIG_SCHED_DEBUG
 			pr_err("     the %s domain not a subset of the %s domain\n",
 					child->name, sd->name);
-- 
2.47.0.170.g23d289d273.dirty


