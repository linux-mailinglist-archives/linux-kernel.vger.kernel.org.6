Return-Path: <linux-kernel+bounces-273661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72380946BF4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 04:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F0F1F21841
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 02:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8758BF3;
	Sun,  4 Aug 2024 02:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7Uhp7Mh"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C9623D2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 02:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722739255; cv=none; b=DZcat9eY0yVJarAe88umV9eZ5AquYIFMgVpGaMRtwMsLLD3nVSzzsaSzBXeMMm0wveBJ8D/uEx0KneLb1+37euCmxD5qMX8iVSGIQo9zxzjBPt0Fm/F9Hx9r6iAI38oDHZMjnCKybPx/6VvcbWmw7TBIrNQJfMeOesC/56Lcwgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722739255; c=relaxed/simple;
	bh=mctxP5jPQZ0IfahNX0j4xqjDWcNRknz328tBzU8JeeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/M3wm83x0BtEzih2AuBbMmWX/1erM7rRkpY/n4D0/U9pf591utujdDFi+IW7PI/AjlYTNtV5cWKeaGVcG3EHg2Q/gHb9KDcqZq2nouydYCnp+TK9NYcPwhQMKmLSIQxc5nnlMnm7IgwFdgUJoxQ9bSt9+I7CbiCakVZhXq+AlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7Uhp7Mh; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3db157cb959so6042092b6e.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Aug 2024 19:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722739253; x=1723344053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YciBn9+Ahqw+FR/2jP76c8VaNWirYdidZpsKjxgZZTM=;
        b=L7Uhp7MhQy4JzKSOTbXAE+qy60j2mQl+EvPDxJZUOfS9z76A1cAbjS06Lmw9FqhrUn
         LqMaA80i6esU+rqYgxm61PIawk4GQq+cZ5aODAecp9HlcMQkl+xA9T1OjxXyHOptkMDv
         ROwVtheHUahND/X6KvIVtu7h9yoDIB7cfN84tIazTXr+keD/uq/x8+3VmEVjVNvANPRQ
         z7eYghxYO8CWGrOUs4IKHCvoPWO+JpyEX7qkf8HWnrYpUiDFqqx58Eqp4Og9AhUnBByR
         g4fsGVyRFZjj8NajlJmu1WQFLnJpYTs6m6/X+Uji1YwrpYRizrIi8wVKvHuPovrhwxRL
         f1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722739253; x=1723344053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YciBn9+Ahqw+FR/2jP76c8VaNWirYdidZpsKjxgZZTM=;
        b=le0/g7LwQlqJ1QJfI7rsU9a65EuEgav5B0ftPht7nrJ9+/QmDjyQlWKDPJAjLrwBiM
         YfGHWLDbCQysoqnQnrj7vKDKkeQ6Kic0axokwWfJmOqZE/SQdzXHbKI4CbvVcont+j0V
         yN04ml70UcfJiPKgxXfR89c80eQSsGvazBcRSG2CQg3VeN6lW17g4VZJKNWwdfmJa4bE
         AaA0WcuXwJqQZws9yqO7bq8uFmIMz1OiMbpduxc37vqvgTMgvB004sFBzmnpnIN4466l
         XD1rrj5rxAet3Yslv6oZnbZk1C/rPqg8agiE5pmeej7magt+6iIzksfjKoTQSdjONSvl
         pHXg==
X-Gm-Message-State: AOJu0Yx783cOjPWWV2lHR1R6STPg0aNaFeM/lGB7pTqQP68dN4eyRf6O
	oiVXMxyiEQzaUqdk2c/1RH9Z0SNbh2/G/LXqNf48oeN5/g1c1iAF
X-Google-Smtp-Source: AGHT+IFbZJ1PJKF8JPKqGdY2ZtV1G2XI6nPA7lTcxu4Ss4yLDokGF/Uhcxf2g8s99P/W+TW3j/1+pA==
X-Received: by 2002:a05:6808:181e:b0:3d5:63a2:6064 with SMTP id 5614622812f47-3db5583081amr10838222b6e.39.1722739253312;
        Sat, 03 Aug 2024 19:40:53 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff58f5753dsm43314235ad.100.2024.08.03.19.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 19:40:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: void@manifault.com,
	peterz@infradead.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	mingo@redhat.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] sched_ext: Simplify scx_can_stop_tick() invocation in sched_can_stop_tick()
Date: Sat,  3 Aug 2024 16:40:08 -1000
Message-ID: <20240804024047.100355-2-tj@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240804024047.100355-1-tj@kernel.org>
References: <20240804024047.100355-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The way sched_can_stop_tick() used scx_can_stop_tick() was rather confusing
and the behavior wasn't ideal when SCX is enabled in partial mode. Simplify
it so that:

- scx_can_stop_tick() can say no if scx_enabled().

- CFS tests rq->cfs.nr_running > 1 instead of rq->nr_running.

This is easier to follow and leads to the correct answer whether SCX is
disabled, enabled in partial mode or all tasks are switched to SCX.

Peter, note that this is a bit different from your suggestion where
sched_can_stop_tick() unconditionally returns scx_can_stop_tick() iff
scx_switched_all(). The problem is that in partial mode, tick can be stopped
when there is only one SCX task even if the BPF scheduler didn't ask and
isn't ready for it.

Signed-off-by: Tejun Heo <tj@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 22f86d5e9231..7994118eee53 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1267,10 +1267,10 @@ bool sched_can_stop_tick(struct rq *rq)
 	 * left. For CFS, if there's more than one we need the tick for
 	 * involuntary preemption. For SCX, ask.
 	 */
-	if (!scx_switched_all() && rq->nr_running > 1)
+	if (scx_enabled() && !scx_can_stop_tick(rq))
 		return false;
 
-	if (scx_enabled() && !scx_can_stop_tick(rq))
+	if (rq->cfs.nr_running > 1)
 		return false;
 
 	/*
-- 
2.46.0


