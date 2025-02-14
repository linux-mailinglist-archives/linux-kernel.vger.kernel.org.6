Return-Path: <linux-kernel+bounces-515085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F319A35FAF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 14:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CE8188E56B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 13:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4235265CB1;
	Fri, 14 Feb 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iKdponA8"
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9C265625
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739541556; cv=none; b=c/ekXMDEMJ7slTs9ft2ln3N+HDuoJAd+AuoURBzhzV9lBE9ydRgVwgzI0Y/1TTMT4CV5obc1T0jBio4JrdeKotDQOyRbWCvCsixqeoapzbjGxAiHzCs/iG23tDA9CSx5P8bLad56nMjXfpqYAU/1v2Ap1SS8cGE9D3kuyruaBKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739541556; c=relaxed/simple;
	bh=c4hwPm5I+iGag5k57vo9RtkUDn2qEco9aG2ZzSyswBk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OppaEQ19SK0c43l5+TpjCJC8/X5yxEeUG1sVktluJgjxfjM3o0iKZmZ8EsEsOJsK1GypG3mIxYn3iTtvJwbw3frod/i1hulbwBn9KMDNg/yYA/mpY4EHubjRmmSvNaOHYVAbNSYigR99o6qPxmxfbZZgI7MoxbwDEWDX9Sy/4u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iKdponA8; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-471c9a003d7so27121211cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 05:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739541553; x=1740146353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FsJUg6tFTkRM0/Q5BqHPBoWfjSFSVcg/i86iZPbawaw=;
        b=iKdponA8T3jNkFW6XIzLV/XVS76a6lHLa6qCynLcfxZlgZU856O8uwGdEdWVz6gm12
         aockpmXrMYaZad86pXh+9X6E42PQfP5DnsnR3RtORaC92kmODNzHB1BvHpFOktJWQ0Sw
         t3XqNTwakxmKp7lXaJTsEf5qZMvUm4nmU+zKvaSlGtvUmAhjypzMmYJ7gSJzlrVx4hFE
         kWKJ5uqZ1jyaunc62r1MWJ5vdi9YPE/CbmUC7Uswlfd5cfi/ov0QGcKiQvhCYKF4hcyq
         WF0DW2Bl4LOduWgZqDRjDz3MaQ1uZ0HLEUm5zhd56xIsBrb1y/CMPDA2c2fe3COF0mau
         vtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739541553; x=1740146353;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FsJUg6tFTkRM0/Q5BqHPBoWfjSFSVcg/i86iZPbawaw=;
        b=jNPhxHH8ACvVjNBK28AYGcY6LkHtD1cOocmpxBGafQM8wzgWj5UOwXqC5E07aA1Rew
         E6rEf6OgIB7FaNSkVdLqxvoquTLu8mSjDfpIX31pZ1/gl7Bd0VQOX81j0/Wm0IZSuAbJ
         Z2ukP7LXgs02JCTTRfWcIaydiOGZgQ+aDGc62jVqvE4d1YNt73AezEQMQBkRLDEIDOFR
         U3yQt6T59pCek8Q/p5SEF7alQyWCKHj8sSHnU26rUjYSy1rbxSYq0J2cByRLWa4jIo4w
         les+ToXc6G80nPcOqBYPhMeCaQDCWuIh69iNv11vM/Icb56hpVw4c5crK1IZN/jjEsXr
         0yNw==
X-Gm-Message-State: AOJu0YxoisyUWYCp2ty6+ZoxZ4qrzVW8n6zPx4vLsouwgr/sWyEK5W0b
	tKp2afNOcUcZuxrrHl4I77otogS+fUpbXsXmwtGGxVLCtI/Xp2ybSFCr6n7Jy/iRlGkOxToIEuW
	3CEFEQzm1Ag==
X-Google-Smtp-Source: AGHT+IF0SW9cv4wdhw79cskfWrvEh1gegUQWimZPIDU2g9CBcGCoTv+56o1d7VmX0BwaFYzA2dL3onZo0FFcmA==
X-Received: from qtyf15.prod.google.com ([2002:a05:622a:114f:b0:471:c812:f7f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:242:b0:467:5ea8:83df with SMTP id d75a77b69052e-471b063f751mr168149501cf.30.1739541553575;
 Fri, 14 Feb 2025 05:59:13 -0800 (PST)
Date: Fri, 14 Feb 2025 13:59:09 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Message-ID: <20250214135911.2037402-1-edumazet@google.com>
Subject: [PATCH 0/2] posix-timers: Reduce spinlock contention
From: Eric Dumazet <edumazet@google.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Benjamin Segall <bsegall@google.com>, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

We had incidents involving gazillions of concurrent posix timers.

Benjamin Segall is planning to add a cond_resched() in exit_itimers()

In this small series, I am reducing hash_lock contention in posix_timer_add()

Eric Dumazet (2):
  posix-timers: Make next_posix_timer_id an atomic_t
  posix-timers: Use RCU in posix_timer_add()

 include/linux/sched/signal.h |  2 +-
 kernel/time/posix-timers.c   | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 5 deletions(-)

-- 
2.48.1.601.g30ceb7b040-goog


