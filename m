Return-Path: <linux-kernel+bounces-261423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B2A93B722
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 21:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A45E1C23BD9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 19:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB1B1607BD;
	Wed, 24 Jul 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WqWtu9kA"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0B265E20
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 19:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721847740; cv=none; b=L8Qh6fA876qOPqgwTbce04MbbDWye8pB2vK42upt9g4La48ksj9wh+/AGtQWug3hn7GeOZcIdc+XCJ5Y9e89ElpbT0XZS6VaIOQNmWz86iTwriEnoLkCq+FUyLS1OPOBb2kFmAF2W0jd+ZR/gIqVx/rT27gF2hmEycTlEV9otDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721847740; c=relaxed/simple;
	bh=7rJm8RpW2VJvMWNbaQ/gBf2ewyUytGOxJVIZgDr+YmQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Hy45E7ImN+oluloD59Ponjyp/ww3MWitDnEyP5nsfu4B7YCZDnW1DzryB+sX8AUl7xCRBW+XbMg4qEpq5qHSLuEKBcpOgI+81tjUBh1S9vQ1oWwm5JxvEkcZ5Z/ca8CQGFtIwjt6ee8eTq8W3oiAz5URYFu7OjkdPYXhqjTsV+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WqWtu9kA; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kinseyho.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e08bc29c584so91546276.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721847738; x=1722452538; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/xqHzlmnvmA4mc0gG2MKsc72BaoN9Cca8ZYVFJCm0vo=;
        b=WqWtu9kA+V/Ys2OmdQH5g5QGztEBbaYpXa7wSjmEyyyyPAE1bcMZTe05ZAdiSgDqG1
         kec+rbE/+cHxXt9S9Fjof3EJj/DMn3kd0hTj9d45Zqd5f0sh8dswq8XY7hzxl40tSH8t
         sm1WfEI8ddQUEGtVoFbmQVWsRimKhL2/REgcYiB95K32tEd6IlSN0LsocQwPfswgU1st
         u/mLgYfDYegrSwxRNLeRoc89JjD5iPYMJYlQWlOnfdrTqHXmPcdOgYPhJ9TJ0OCidePf
         rV06C4lN2tb5ew9qBiSnO0JjkJNPbLm4Uwcx+Bvj7ucLf12tPOUbxDIVQ7pMF4YsMowJ
         kfhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721847738; x=1722452538;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/xqHzlmnvmA4mc0gG2MKsc72BaoN9Cca8ZYVFJCm0vo=;
        b=D6eUv4zVnDafX3BDlfxS2IGbH9guvGg5UpiWFbRjobnMrw+PZfzm2jrZobo78nKgL6
         hjqvQsgSbzL4R0+hVQkV3GvwaVAc+DPbJICl4cH5kgCYkTcAnDHbyCFlnT0pkoYnUtDt
         gj4womIsitFfCf2Co8qO067A7RXd19vm959TaKRdMLlBLhwGy/p3AKdNIFcHimbUc+jv
         6R0GuD2kn32NvZwKtt9QuJwUbBykDeloKrZSZ4n0swONc/YA7IC5Enn0CoQgSI6661yX
         Ec6bCMw/IrbwPDk1yb/H4jo1VYPiaa2zYgH1XIna8gDtFyRdD80JYDCv1ehbulKM0Jfq
         6P8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxqkMCAnSCgzl03znoQ0PknKffXKXnr9NR8juP+MYG2io4yTrk5oJmbBJsaJ87ClHNB/FxuNKOg1A72qYUkZSZ+/9Gdgi/ajrzUg16
X-Gm-Message-State: AOJu0Yy0yomIrEBODJ7zBYgNlZZbsXsBO21MGSovE/12rLAXswFoGLqs
	rjMiShdGOOdihpa6yB5pn0eZQz+0AWRaBLBg0/NQUVMsWNgOvSRFaSdXB/apB/5fSpCe1zHHmE4
	Qm5yiMnQ/jQ==
X-Google-Smtp-Source: AGHT+IHJfVbEtJxO61V9UPy4Vh/DvuL9qPuKIxDxcfTs5/S4QgOxgAUtmQ0vwobOLJaiV/CINzjdTA7g1RXpuQ==
X-Received: from kinseyct.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:46b])
 (user=kinseyho job=sendgmr) by 2002:a05:6902:1245:b0:e02:5b08:d3a with SMTP
 id 3f1490d57ef6-e0b22f0c922mr774276.0.1721847737866; Wed, 24 Jul 2024
 12:02:17 -0700 (PDT)
Date: Wed, 24 Jul 2024 19:02:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240724190214.1108049-1-kinseyho@google.com>
Subject: [PATCH mm-unstable v1 0/4] Improve mem_cgroup_iter()
From: Kinsey Ho <kinseyho@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Yosry Ahmed <yosryahmed@google.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Kinsey Ho <kinseyho@google.com>
Content-Type: text/plain; charset="UTF-8"

Incremental cgroup iteration is being used again [1], but incremental
cgroup iteration was introduced for cgroup v1. It hasn't been fully
maintained for many years. This patchset improves the reliability of
mem_cgroup_iter(), along with improving simplicity and code readability.

[1] https://lore.kernel.org/20240514202641.2821494-1-hannes@cmpxchg.org/

Kinsey Ho (4):
  mm: don't hold css->refcnt during traversal
  mm: increment gen # before restarting traversal
  mm: restart if multiple traversals raced
  mm: clean up mem_cgroup_iter()

 include/linux/memcontrol.h |  6 +--
 mm/memcontrol.c            | 84 +++++++++++++++-----------------------
 2 files changed, 37 insertions(+), 53 deletions(-)

-- 
2.45.2.1089.g2a221341d9-goog


