Return-Path: <linux-kernel+bounces-554749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D3BA59BF0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:05:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5CC1889F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C08D23099F;
	Mon, 10 Mar 2025 17:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d+Pznmcd"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A745230BFE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741626304; cv=none; b=fjXAN6NKtX4mbdu1tBapZDYtb164Ga5Saz1KCHXWQWw5N/VQjT6d2NZvn7aOhRGpVMIe81eqIrEoO6YKOBDUPMlvWeq/nrxY/BzIpnia0KScGLq4hDXRVztjjNY/8NTqti/iPBHrr27HVSQyB35sXOq3uJbqg5sz7RYpvCTSaME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741626304; c=relaxed/simple;
	bh=ulHvHm4ifWHwuLhPFEPjoFTZbkUUcsP0tD9oetZXMyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEYZW+c1CalYYcOvw19H66pPW44MiflZpMWiWRPnVi8aq9uls2WUWlvbHD2zf4bsdPEoxPDnZE9tB3ufcBUDTdsrS5QEoKdaiNVc7RiZ3TupKMJWry2rF9yFaP2KCJKNbSBkV4eUXj4qm01JqsAL6m+iNFZjr2uoANBWxkDXySQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d+Pznmcd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-390f5f48eafso2251850f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1741626301; x=1742231101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1XVXoywLqfki7vGasTJjryB1AUnkPOTgHHVt4Rbtn8=;
        b=d+Pznmcdu5P5tPyaVb4IQXu5YGVsjmjlbUUr1WnmCgc3vtb+Cv02A+Gcxs/bC3PRQx
         T49ZbG5HDQtpErOFgyXQzw+d3IKisFQFvT2R9IjyUwimuwORnmPX02r0/Dry+vadL0gO
         n0aNh5LQw7jQh6puW9DA085Wi+lWgwerbvffzTX6tjfsEsIF82aeuVCm4Z6lySgGAagf
         ht6GsZM+8iUCb/6Qq6ibxkoOWsSbrbclJwsGgPsZILq4e5ZwXpxOLLSLzKvZHMXy8BAn
         vQIvh2dZ0gtdI8fDtJrjIVgbG0PdOXCWwgi8nTKx0hL2gou8udwy8n5hnb39rIoQwBYW
         SS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741626301; x=1742231101;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+1XVXoywLqfki7vGasTJjryB1AUnkPOTgHHVt4Rbtn8=;
        b=pEJ0gYRW1qZ/a4Ca5ciNw5Enjb9V/1By629QIvuYKwBCxzvphsETiSJAkUoJ3iG2eJ
         c3nJd9h2mAkrnq8lbzB2xxTEX589fROvH0lCxMTLyAbJayrpl9qFfC5k5Qkxbpw+hX1X
         i3cwUgN+1tfhWDg3RC3c1a8rpOgOz5U2nX+QCb38y67ZzM0pPC9DcwvbHVlDrTe4SJke
         f3220iM8QOSOEIytdBPNMQBpluM6dcAMG6445Qu8nskJx6Uz82Z7ZlfL7Tg4ZNWHQtdN
         u6yAHfCcGz8xl/NmpENUGl2Ihj6NEeSOMChFf0FVrRFhU7o0Z7HdFPAnx4kmOo41BlnF
         PWZg==
X-Forwarded-Encrypted: i=1; AJvYcCUxFoow/KfueYLxMEETrRt5Gl7eMkJChkPa0djG1x08T1ur8aQauJx4c62mAmDeYlMPaUxCXetmMS5Z4Dg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4DmXjAvDpVmimGPMtf7iKYISDvvGu1td49A140d8rzZwatWTf
	+lg6FHdmW1C5Wpk8UHJ9mV5EId+on+SyrnbI0bbsb6KU57KaGYMpp+m7TSC9aqnk7+XRsib4Z4r
	VOno=
X-Gm-Gg: ASbGnctS0VfGHLj4N+I13F22nlFelT3icGLYVHrhWehGwHpKRQjsPpFqCcgSCxftofO
	6jdIusifQqrv+IX7q/uj2LHUcR73umPQl465r8M9xPfUlt4M9Cdn/crA/y+/kZz9y6wS219+6tA
	rumMFiMXkKVEb35Zw+oPZOs9FoMI86M1a7ovAEnxNf4OIhWAl2QHcxI28Wvv7Gh4PYnetGyreeQ
	7IqoaSjNaWfNOkm10yIr3GyKtqmW7TLo2ITVDfuoRGEsQNzokxfbIi//suBDLUXnmO+4ZduVJKr
	0vmFOoM/RjlUxyVAELYh9enKBQluJ/8mDcg06mgtEfwHC0w=
X-Google-Smtp-Source: AGHT+IHLhYt01Kb6d2mIiq9FHtyIMTPc4IjBIT5jTxdQZOVbxaPzcSdfaEEgUiXUP6+NCd78rpobVw==
X-Received: by 2002:a05:6000:186b:b0:391:231b:8e0d with SMTP id ffacd0b85a97d-39132dc5632mr12134770f8f.39.1741626300723;
        Mon, 10 Mar 2025 10:05:00 -0700 (PDT)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfba679sm15302514f8f.8.2025.03.10.10.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 10:05:00 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: Peter Zijlstra <peterz@infradead.org>,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Frederic Weisbecker <fweisbecker@suse.com>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Subject: [PATCH v2 02/10] sched: Remove unneeed macro wrap
Date: Mon, 10 Mar 2025 18:04:34 +0100
Message-ID: <20250310170442.504716-3-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170442.504716-1-mkoutny@suse.com>
References: <20250310170442.504716-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rt_entity_is_task has split definitions based on CONFIG_RT_GROUP_SCHED,
therefore we can use it always. No functional change intended.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/sched/rt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 3116745be304b..17b1fd0bac1d9 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1257,11 +1257,9 @@ static void __delist_rt_entity(struct sched_rt_entity *rt_se, struct rt_prio_arr
 static inline struct sched_statistics *
 __schedstats_from_rt_se(struct sched_rt_entity *rt_se)
 {
-#ifdef CONFIG_RT_GROUP_SCHED
 	/* schedstats is not supported for rt group. */
 	if (!rt_entity_is_task(rt_se))
 		return NULL;
-#endif
 
 	return &rt_task_of(rt_se)->stats;
 }
-- 
2.48.1


