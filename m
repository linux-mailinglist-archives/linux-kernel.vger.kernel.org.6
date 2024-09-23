Return-Path: <linux-kernel+bounces-335826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED38497EB3A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 14:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44E2281603
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 12:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC47198A31;
	Mon, 23 Sep 2024 12:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Svi4Ko5y"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F0C198838
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727093034; cv=none; b=F9EsdCmuJzpIPQfG2cpat2u8FD/bI/YgMs5+wNGnCDe1KSitO5e9iKu9dby9F2NwnDLXKJeSRx+QM8d4acWvhud0QG8NfVao0LLCnRdBnQ9GtGJoU9YNlXbJY4aIcc90GWIuYqVq3JWbpgy3MwNdrEDj10YDOoUdF1if6o5Be94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727093034; c=relaxed/simple;
	bh=2Vb2Cv2Dv37X/Ids8L19JvM6vzYR+tLqulzI/IrwbfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvcUg7Bfn5/RwfTK6SSqUq80RGqBoLpuCoctta8aLBWEmhh7CusXkwxFG6X2L8J6wJ4WAZkaoa//mgJZ7pENiH13bJkEjc5QDEw/Z6pMPoAZ1783JppOGrlELe8Tm6GIDPq+oK8AHUREAv8ZLlyuxeECMFazFkBUgY6YPxFidak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Svi4Ko5y; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6de14e0f050so30157157b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 05:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727093029; x=1727697829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDgplFVDTcPA7FhAL3SqKT1KaN8IQNqhOche9v7f6Is=;
        b=Svi4Ko5yL9sQy77l2QhUUkQQOXIuFQY1W9DUyf5XuYTt31g9UctACsEgr5/Vc6eKRW
         rL19ghvJ/Jzsb8CfyOj/XqltNuGMaakJce0+Q2FVU66i2d9o4/tyGOjf1KbcZXaLwQif
         2LMztd2IKgIFW48xIfkcHtZ0TuuEkaKTOYKxlBdXphZAfLgh/4hf5ES3RHtrPa+J3zPu
         dh4aJa0uOIo98pjSzqZfrjW6hzz+6I3FC+JeoDW30bl+m9JmmWxCE+qno5c+4G/R7aFd
         Zon2ti0zxs8HtWw1J2y4XU1UOWw1vB/Bg/LdoicpNFfYRmY1gUJoloGmXjl9U8Dl/4/b
         BL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727093029; x=1727697829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDgplFVDTcPA7FhAL3SqKT1KaN8IQNqhOche9v7f6Is=;
        b=Nwcw6fbl4qO09osiuWIHv2Z+e1z/EP/k1YNySIiQK4txbNt4I+yR0vv3Taimz/bWgY
         5ItGyDdnqnkT+/6hprE0asnv2su8hgvEQImiN3TmQVvqKKLPRb6uup/pMrbTndtZqlRs
         vDoPBQCIvVH5wHbMeVJAWbVAb5lY0amf580k/3xhGQAjwp4ZWTM9xOljvpTfQC41Q70i
         hn+5nmBne9FfRRhzewk29WKvHusibdpiQwl/zAo/EXobJdB/y0Wlc3RWym4AmkKyrujr
         gIF5gpI0zw8ml4SZ6lEUDQjCKWY3ctkBEh5zjkQ35gQ8apMLfbOsXLbes8qd025BgMIY
         A4TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU49l9PM/jSmO6CJl0ZpRSrVtbQQ5rqECKSMOdfJrMtYpiesGDmJ+CuXi4bo7wOCrygrLsGHrk2ijfNnLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGnFFsrP5bYkwmdZJXF6Md7I3j/2iXUi2VMx8hPb7L5CazkaD1
	X++517K+9wpjBPdVniGqN7eDgNtqMLD5SBpD+jRErfU9107gWKPF
X-Google-Smtp-Source: AGHT+IFE91qwRy5TXm8qvsiN6PSwuYu09R8ZNvZiypUYOO86nm2CbYAASmOi5MZ6YSjoP243bxN7Qg==
X-Received: by 2002:a05:690c:7086:b0:66a:ba89:d671 with SMTP id 00721157ae682-6dfeeed1dd1mr84975457b3.35.1727093028967;
        Mon, 23 Sep 2024 05:03:48 -0700 (PDT)
Received: from borker.localdomain ([2605:a601:90ad:5400:5953:ee4b:cc9a:dd36])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ddcd8ac3cesm28960767b3.78.2024.09.23.05.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 05:03:48 -0700 (PDT)
From: Parag W <parag.lkml@gmail.com>
To: hannes@cmpxchg.org
Cc: anna-maria@linutronix.de,
	frederic@kernel.org,
	linux-kernel@vger.kernel.org,
	peterz@infradead.org,
	pmenzel@molgen.mpg.de,
	regressions@lists.linux.dev,
	surenb@google.com,
	tglx@linutronix.de
Subject: Re: Error: psi: inconsistent task state! task=1:swapper/0 cpu=0 psi_flags=4 clear=0 set=4
Date: Mon, 23 Sep 2024 08:03:39 -0400
Message-ID: <20240923120339.11809-1-parag.lkml@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240922102047.GA437832@cmpxchg.org>
References: <20240922102047.GA437832@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FWIW, moving psi_enqueue to be after ->enqueue_task() in sched/core.c made no difference - I still get the inconsistent task state error. psi_dequeue() is already before ->dequeue_task() in line with uclamp.


diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b6cc1cf499d6..748143d2c218 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2012,16 +2012,16 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 	if (!(flags & ENQUEUE_NOCLOCK))
 		update_rq_clock(rq);
 
-	if (!(flags & ENQUEUE_RESTORE)) {
-		sched_info_enqueue(rq, p);
-		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
-	}
 
 	p->sched_class->enqueue_task(rq, p, flags);
 	/*
 	 * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
 	 * ->sched_delayed.
 	 */
+	if (!(flags & ENQUEUE_RESTORE)) {
+		sched_info_enqueue(rq, p);
+		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
+	}
 	uclamp_rq_inc(rq, p);
 
 	if (sched_core_enabled(rq))

