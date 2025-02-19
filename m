Return-Path: <linux-kernel+bounces-521556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13071A3BF4B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086EE17AADE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2B31EA7D3;
	Wed, 19 Feb 2025 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="puggIPaD"
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229D71E105E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 12:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969728; cv=none; b=Vv/kddhEGM+e3HZ86uWrqUwV0xC29baSIUZMyy75OWf1l4UIPKVWlFDmi9qts/txAamgYYdEAI8za6qMUHGyZmqwBQ/socV7+K6ARbxrB+ySqfe/Yh0S2xlUdde+0Y6+2Z4oesITx+RWWnfRTzXqA5IGecqa9j1MjWiQ5f7XJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969728; c=relaxed/simple;
	bh=fFIYLXNBz1MM5embpcrhfGnzXnBdURECfv9OqMSfnzU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PxayfiUyVeFeauew5U7k1UQx5s3SHX3ur3SQ7rAnKT11mWrkBPtGls1ADKujt2Lq8+5YmpZ1NT4I82myADfvR+LYl+Wlb/Uw0La8l520SlJUXiIZEJlnqJA/ZSbxAEQQSZsE4Y3/s/81t2nCWOuniCjGWhCH8A0rhm/YDsHQjAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=puggIPaD; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-472122713b6so2062781cf.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 04:55:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739969726; x=1740574526; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7YUdzPTU5Iko7aCXfJSsz5dql12Uf+IrFzpZdHRgdU8=;
        b=puggIPaDOFuC6wpID/M/7gEe/Z1/ceAw0+POMUwZ3jV2CPGopqQ3ZKoHCMGfygZdve
         P3h4AiV3sMnI/LQakDmt/+yzH1HgoTZksRblYMomd3GVQlKnXvTgAEfDRxClUKnQgYKX
         65MaABxl+alBv6RGXdO68VS7eGs/6hLDJ8ELHpaqkp7OZ6gff6XuUUvQbi3y2/fX3CSM
         eAdsM64hi+XDgousYhp8W90mJLqo3DbbY9p1rq7DTXdQ1TLXJ7S0iUD7JDskkIFT1+vz
         Yg31YAGHeZxXatYhGTccPDy4W61NwULyNmPx9DS8rJ7u0Q2DJQl4/1atYpaSYQO6YW6w
         RNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739969726; x=1740574526;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7YUdzPTU5Iko7aCXfJSsz5dql12Uf+IrFzpZdHRgdU8=;
        b=WGoZgIvWruJNcZARi0FWvrZvMrurOeV4WQx90Oo1wJjgK/tNtspG4si8v9QtUpMfES
         xi/YYR5GP+Jo7u0MXfUhvMIbwbgK53e1anuukkXEyh12a0h53sq/uWAOPXWJZO6SYWzN
         wXRmRHBcSFuMbq7LvQHvyIiXBQAepnAM57qA94HIobyml/FyVgwhfXWt3NkfVG90lS5A
         y3DQdJzNaLdqcUggeHW1TUAPdOF4kuXkY3RLQgkwzWUoI+1Ccgx4TGcAxhCzZS+EENLV
         G31DOvmR1Su9g3JfNWQ6ZBYwhnA88jocVADLA514h+hJW+3VKT1tkjUDagdQGUZQh7Cv
         zH4Q==
X-Gm-Message-State: AOJu0Yzp3L72QYcwtWuq6wgPpR21jlq4M3TD2FrLc8AddXCeMCIbYYoZ
	CvDpKB56FjRYOXOWCP7h3SUIS/KW7WtcFCK6ifX0qNNDPxcfWeFu2Jt+X7tSx//tN7L/I6LRKi2
	JvTSA4IG5qQ==
X-Google-Smtp-Source: AGHT+IG0ns5nRStl3VDzgavz9xgdRpxxPRrJVPqRH5qI0hbuahKzldTVylLbTV5mj9RUd10avPjH3KelSJkCoA==
X-Received: from qtbex15.prod.google.com ([2002:a05:622a:518f:b0:472:45b:1ff4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1924:b0:471:ac12:1c3e with SMTP id d75a77b69052e-471dbcbff0emr198639941cf.10.1739969725983;
 Wed, 19 Feb 2025 04:55:25 -0800 (PST)
Date: Wed, 19 Feb 2025 12:55:18 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250219125522.2535263-1-edumazet@google.com>
Subject: [PATCH V2 0/4] posix-timers: Reduce spinlock contention
From: Eric Dumazet <edumazet@google.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall <bsegall@google.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We had incidents involving gazillions of concurrent posix timers.

In this series, I am reducing hash_lock contention in posix_timer_add(),
and fix a possible race.

v2: Initialize timer->it_id and timer->it_signal to non zero values
v1: https://lore.kernel.org/lkml/20250214135911.2037402-1-edumazet@google.com/

Eric Dumazet (4):
  posix-timers: Make next_posix_timer_id an atomic_t
  posix-timers: Initialise timer->it_id in posix_timer_add()
  posix-timers: Initialise timer->it_signal in posix_timer_add()
  posix-timers: Use RCU in posix_timer_add()

 include/linux/sched/signal.h |  2 +-
 kernel/time/posix-timers.c   | 54 ++++++++++++++++++++++++++----------
 2 files changed, 41 insertions(+), 15 deletions(-)

-- 
2.48.1.601.g30ceb7b040-goog


