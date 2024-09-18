Return-Path: <linux-kernel+bounces-332412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E75B97B95F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 10:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A6B283FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 08:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E0A8175B;
	Wed, 18 Sep 2024 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FptwfknX"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B7814D6E6
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726648263; cv=none; b=sUpNxNXdQUn21H9GMcpophBlq61CdhdVaGo5/w9jVHFMmMcfudikuVCfiYBkQdmhBkXCRP/o+FNBg9Wj/mqg7LaOmMCaqwUZ4404tdsvRnwNNV9UGPhok6Wm85Fn6yIYi9n+TW3e9fIYB8sBwbuXFErrGsszSS7Gs2mwLPChr24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726648263; c=relaxed/simple;
	bh=4XwCjvnIvy6ZGT2LLU79u4yO2PGHwMN/K5RyVVrQhu8=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=ISwwbNfrTriEKeaBWv3Yb36JzVTtzNWP4clsLtzpo3VjKuyRbMuUT4OZn23pH4TFa9iNdb22XkdggQI4gUmFHdTTq6uWrE/EVKWUDB/tgkmaDbFce3cV9XDSon9EhGo9Bamqn7QbEazDXFckq24CeFmt9CxoZ5cqKheh1WRwWHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FptwfknX; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2057835395aso75762215ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 01:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726648261; x=1727253061; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CyxTWvDj5Px+CfEbEGBvYuVwclFVSVk44Npzy+aR5uI=;
        b=FptwfknX04kvIBmMDUzpr2/XDLowjfvk4IxnNZIorpu44W55nc6ahx+nrvNkJPq8JI
         mHDdhEglEekh7H8T7xdzvuGXRZ4vvN9ULU0D63UIxrU1dr21c9Sl5NAhD/PnjUGxfUtY
         wT3knZMLLaIAWayzAqU2Bhjly5J+juJwSTycIcijwjUfF1ro5Wkp/CXiDrFa2AA+9xOh
         lruYDAE84IXdJKwnBegjydAKM0qpf+0OeB/XpUVEQmmC5b7V3wbBa4nDXs1O6aUNLZJS
         EiWwwti9JA1KTpLYPT2taPe1xHN1/YbRAVAQXEKn2dLHmSt555H949WEWFmy2arqy8pj
         pc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726648261; x=1727253061;
        h=content-transfer-encoding:subject:from:to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyxTWvDj5Px+CfEbEGBvYuVwclFVSVk44Npzy+aR5uI=;
        b=qYRvT4gv9rqoTC7+wLUTVIjJs3VWaS0Jt1KuxmDmc20h/bX7WhAcYoRghnvmINEwfx
         5HySXlWIqwXK7TWOW3FYaO6YvJLzWneQ8xb6/ccRqZ7ZexcKgcmJH6W/GpbX3aEXvhOC
         pD0+KD+yCpWFdj8t45bJu83AbNJOS3XnomCK8jX6jsRe9WbFteOsHfm9Ap6erFvuSVYr
         phEaHDl78UmiImY0i17hZmuc7zI3/Uxb/mLGaHdKvuYbQC05t27aEs8LsaSoV22KJR+Z
         mbH9CvluwCWKcqk1aYP82Oeu5UIQLulQCWgVVLbK0OISj9enKq+LjYbn0Lqi8DPrCtxq
         qFHw==
X-Forwarded-Encrypted: i=1; AJvYcCV0UX4mzG3n93vAyi3+4ZGBsrFOw71dKLVgSyjyQZO8yPijcWKnKcjt4B/BbHYxu6FmDWYRgoXPEC9FTtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEzVQTkps8lwMiK2CVPVYe7u8hPfSEaOm9XDWi6lxYFcloMVPa
	7bZgBDoB+6dSCgYxXhCWcGYi3FYwRTt/6rQcD+v9kyY1qas42jyG
X-Google-Smtp-Source: AGHT+IEnxrWFTeGa/0islyr10dEZFHC3HRcPOVDFyg0UCgQcmJklbzvPcCYURzyXKn10ZumM0hjTGQ==
X-Received: by 2002:a17:902:dace:b0:205:3832:ecc4 with SMTP id d9443c01a7336-2076e369eb9mr312773695ad.28.1726648261054;
        Wed, 18 Sep 2024 01:31:01 -0700 (PDT)
Received: from [198.18.0.1] ([2a09:bac1:31c0:8::245:a6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794731611sm60650145ad.259.2024.09.18.01.30.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Sep 2024 01:31:00 -0700 (PDT)
Message-ID: <be57ed09-83d9-48a0-bfcc-d22ce39ad17d@gmail.com>
Date: Wed, 18 Sep 2024 16:30:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org
From: hupu <hupu.gm@gmail.com>
Subject: [PATCH] sched: Fix the comment error in the wait_task_inactive
 interface.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The previous comment was incorrect because "task_on_cpu" only care about
p->on_cpu and does not care whether the runqueue has changed or not,
especially on SMP systems. In addition, task_on_cpu returns true
instead of false when p is running on a CPU.

Signed-off-by: hupu<hupu.gm@gmail.com>
---
  kernel/sched/core.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f3951e4a55e5..05b231a18440 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2129,8 +2129,8 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
  		 * NOTE! Since we don't hold any locks, it's not
  		 * even sure that "rq" stays as the right runqueue!
  		 * But we don't care, since "task_on_cpu()" will
-		 * return false if the runqueue has changed and p
-		 * is actually now running somewhere else!
+		 * return true as long as p is running on a CPU,
+		 * regardless of any changes to the runqueue.
  		 */
  		while (task_on_cpu(rq, p)) {
  			if (!task_state_match(p, match_state))
-- 2.17.1


