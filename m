Return-Path: <linux-kernel+bounces-308840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B558296627F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 15:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21293286481
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 13:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DAF1B81C3;
	Fri, 30 Aug 2024 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DXWCcfjU"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986461B6524
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 13:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725023002; cv=none; b=ExlITIiJgAHiRS6Di67kfDzKYKYfOMFxSGIB5DOzCALVgKwTzbmRoad8CoLLMlhAColxI+CCLVFZqtOWUGkGm/gtdGLte3LcjXYKgaGcozhcIwLTQcZaIif20rUhZ7G4D/QpvRE8cqYqLgLcxGQYiUicHZX68kb7xWOxdWqy7mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725023002; c=relaxed/simple;
	bh=K1fPShadi9E5vUmcMt9lE2cliV+N/hB8gQUhdxIGaL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=izDws72qfjUPkqYvRiRMh1wuGFJF60U1G/Og0n1fiT42yt66fV+KmXabsJoQE85qGyxtFGy1aPEO+uYVyGz/iEzlHobS+Mmn47HgBAKWClLCwzJ4N2+aPhOoBk9e2DJytR8/TP37JpGnJK5fIADBATXVXlrN87ovKSTgPRsCAzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DXWCcfjU; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42bb7298bdeso19278715e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 06:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725022999; x=1725627799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzDEXFxbEwVnz1bNBEnZqyQC9wBiudp2iSYZq/SnOQk=;
        b=DXWCcfjUEBSh+NRTPqKXGuw+uDwZAfvWZ84MYzkvEPiSz20rj9sX7mJz5+gc0GLJsw
         30k1KAYJAPyTHTDyh405sW2H8/9PFBegErEj40C+QuDdxjd6KJ0/H5H4DQwCPFGSonua
         h5ejS+c24+vX/rbP0LlIpt6JdRnXonursr6uczy+CmQ8N8xjFa7rkeNTx33amrcf/+as
         rsIkbTbyGxBPcRjzuNDuB0eFPLSigTU0aGiy3M/LrQi/2repDMdbbs0sJHkHIxWe6uez
         zfC7tClCY/aQVZ/P8bk9bMFZeFQOLV3rZpWCsM+ZsaCI7yzcBOYNm6rZ97533GLXoBb1
         oi4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725022999; x=1725627799;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VzDEXFxbEwVnz1bNBEnZqyQC9wBiudp2iSYZq/SnOQk=;
        b=JGp9tiKz3Md8tJh5UrB+S7WpK5VtkL7392XQXJMaNIy5pyn79RuzAcMUWp5RLw7ONk
         4U/1CArbN7Q0Pbal4DogMwVRvBNp3ozeqmUyZ7qdcHWyt5HntWAhGU2DAiOOHcovCa2O
         oR3PrnvJ63xCidoNABcorsR9vBH2gFm3t4BS31DG4+hGB7mPvgNKoftyvCnEUJQAe4oS
         zQZGSaBOBte2OlkOyAK2K4VwNlda0QPNgmWhfDJnjpVpZsylugSFL7EL2LZ2k0FoPF2x
         amMIm5+LYg1J1cphY3iuwTUCc8rk5+9EaNjZz+nLeZqpyjLBeec8fRTc5jf7IbWRY4Xr
         IRcA==
X-Forwarded-Encrypted: i=1; AJvYcCV9cS9EQxHMb2ZXhPQYlSWnmPjeQh+DhmHHHYVqCKfKpfC2xeGH/nYdqzETIKPSTH2nLAeUewTGX/XJhTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK3fMSRTCa6Q3H/Idzeud93TiUik2aAXX2amFincyd4QTbKg79
	XjVLwzgxSHkSMrTGR/atMGkLTWHwJrcO62UWn53hjtVktQ4QL/IYiJJuL1UpZQM=
X-Google-Smtp-Source: AGHT+IFMJSNiRGZBIURpFxE4qN7vqdlat34iAKRWtJfMIFFxjsF/Q08a5RWNfKAfAhiKtI9BsnzEnQ==
X-Received: by 2002:a05:600c:1d8b:b0:42b:892a:3296 with SMTP id 5b1f17b1804b1-42bb020d4eemr52457355e9.37.1725022998709;
        Fri, 30 Aug 2024 06:03:18 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:3cfc:139d:f91:133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749efaf35asm3954076f8f.90.2024.08.30.06.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 06:03:18 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rafael.j.wysocki@intel.com,
	linux-kernel@vger.kernel.org
Cc: qyousef@layalina.io,
	hongyan.xia2@arm.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
Date: Fri, 30 Aug 2024 15:03:08 +0200
Message-Id: <20240830130309.2141697-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830130309.2141697-1-vincent.guittot@linaro.org>
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep looking for an energy efficient CPU even when the system is
overutilized and use the CPU returned by feec() if it has been able to find
one. Otherwise fallback to the default performance and spread mode of the
scheduler.
A system can become overutilized for a short time when workers of a
workqueue wake up for a short background work like vmstat update.
Continuing to look for a energy efficient CPU will prevent to break the
power packing of tasks.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2273eecf6086..e46af2416159 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8505,7 +8505,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 		    cpumask_test_cpu(cpu, p->cpus_ptr))
 			return cpu;
 
-		if (!is_rd_overutilized(this_rq()->rd)) {
+		if (sched_energy_enabled()) {
 			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
 			if (new_cpu >= 0)
 				return new_cpu;
-- 
2.34.1


