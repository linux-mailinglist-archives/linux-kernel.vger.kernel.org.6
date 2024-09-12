Return-Path: <linux-kernel+bounces-326929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05868976EA7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB2E228679D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE0D14C5AF;
	Thu, 12 Sep 2024 16:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xhwaB4d/"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F72126C0E
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158348; cv=none; b=NAsIXsObobUmT/005r1AdYxauDGmxGVmVA7zaWjzp0Ezda6rT1B0U0hnPpXPfwjfgNzN14KfZsKaT3I5Dzfxp2yDlZwKkTU5IYuqCwp7IHZ2eH4xfyIDjyZCVvaWZaf+/Nm5o/SiT0niirQCEs48GXZlsCz2oueBaHL7cyC286I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158348; c=relaxed/simple;
	bh=elQpcKGYpob27gMaQ5smQ9bcEmPe2L9QQJC6Li0fA2Y=;
	h=Date:Subject:CC:From:To:Message-ID; b=gB4CVO2GSIprsWixuX0Rf8a/WLvYe7yeDu7OwNy57D7/F7GMWgIjooe5I5A4cTIJepBBw9bhkvjGBp/12b4wU3xq13Cm+5dNzWb23NTc8MP3Ui52vLQyUz4xW6ABkJoaDFCb6Ndhl03VQ8CoSOpxd/KF7wPIaBkDkOdeqA3Yvls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xhwaB4d/; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-6e7b121be30so918087a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726158345; x=1726763145; darn=vger.kernel.org;
        h=message-id:to:from:cc:subject:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4QILesIw2jO/jv8xws5YIjHNnjamw3bXH4diaHqXW30=;
        b=xhwaB4d/8ReD7tI+iKSUmxmc31xCrqMQD8+yC6gtrMw6brHOW4nvBgYRUhVY5pnS+S
         Lm4cjlC8XaDif+VbV74qhKqAXbeA3LmxIPJ7ypscNCu0iQ+YjBD5nSQqkdVT8IL4uMCT
         ch180NL9p5P8pf2/vYjnDI6UZT66rUJjLDWtsipycZd0RHgzlNMLPBXCZdwyVjCPBVU9
         ee0wXZfNHIxzWPFErU1+ex8maVPZrtytNnCyMcj/kd1+tLne/ej8YQywo86ZxbfMVz8P
         XnekbvjSYMoUX086KfSmFLr6ovzTjsmvwnyWbh72XrlcKLWHBqjrokAqidTunRFJrXI0
         rsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726158345; x=1726763145;
        h=message-id:to:from:cc:subject:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4QILesIw2jO/jv8xws5YIjHNnjamw3bXH4diaHqXW30=;
        b=MJGOHzCgkMUhnDUqOP3VkPexaB7+qeSsAw9nF0xHuip8vfBEnvxke6ba0V6AltnFy2
         fgHUSaUbCd6VW80RXRIKrXFo1H44WLBB7krSnwK/Bmlqzr7jGjF3V7/oMbSSKmRuHN2l
         BYZkP4kxlt05JGpw3oGeIqDuA0kOduXbaFyiyDbKM6jZxgSMBbqydK8T0VDeZUqEoSyH
         YZatOOHX2HB9MeAfvzD6yGU5mVD1+hsgyIxeucGL7/WyJePX7Ybgurl9tvOLZKhv3j2w
         P/DCEud+Dm4saYmcP3X/d7H0l7FW21JKupqA3qW91YFnowTqkxjfNtb8lMNywORyuUKI
         5jSg==
X-Forwarded-Encrypted: i=1; AJvYcCVliquHGLWUXNZdrIecXirGsH4cu3+TenrSC5vaB75BIhkFxQgXnz5FLyTnn8A+4IZyVja4z5rCdsqW00U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9wiT2nYsulgMcFbSrIxAI1LMsHUlK9HnH/sctReX9frQLDSIk
	JZ+FRSpuTMPkYZDWtEiWzuZTL9UsmK6baBMnizTS3PF56cPt1E+KdWqkk9H8qNxBDRM+uIyMDUT
	a
X-Google-Smtp-Source: AGHT+IEEf6iT3JV53GFjFR8pXoISHJUM3Kt/EUI8UQxiP6hXee0eeD1F6ANvQcR2UhfoNqUnoEFChQ==
X-Received: by 2002:a17:902:e804:b0:205:88bf:bfe9 with SMTP id d9443c01a7336-2076e348076mr42857005ad.15.1726158344810;
        Thu, 12 Sep 2024 09:25:44 -0700 (PDT)
Received: from localhost ([192.184.165.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076b0096e9sm16037235ad.254.2024.09.12.09.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 09:25:44 -0700 (PDT)
Date: Thu, 12 Sep 2024 09:25:44 -0700 (PDT)
X-Google-Original-Date: Thu, 12 Sep 2024 09:25:42 PDT (-0700)
Subject: [GIT PULL] RISC-V Fixes for 6.11-rc8
CC:         linux-riscv@lists.infradead.org,        linux-kernel@vger.kernel.org
From: Palmer Dabbelt <palmer@rivosinc.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <mhng-61f22aea-eea4-4ed5-a803-92fa9df853cd@palmer-ri-x1c9>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit 1ff95eb2bebda50c4c5406caaf201e0fcb24cc8f:

  riscv: Fix RISCV_ALTERNATIVE_EARLY (2024-09-03 07:57:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.11-rc8

for you to fetch changes up to 7c1e5b9690b0e14acead4ff98d8a6c40f2dff54b:

  riscv: Disable preemption while handling PR_RISCV_CTX_SW_FENCEI_OFF (2024-09-10 20:38:46 -0700)

----------------------------------------------------------------
RISC-V Fixes for 6.11-rc8

* Two fixes for smp_processor_id() calls in preemptible sections: one if
  the perf driver, and one in the fence.i prctl.

----------------------------------------------------------------
Alexandre Ghiti (1):
      drivers: perf: Fix smp_processor_id() use in preemptible code

Charlie Jenkins (1):
      riscv: Disable preemption while handling PR_RISCV_CTX_SW_FENCEI_OFF

 arch/riscv/mm/cacheflush.c   | 12 ++++++------
 drivers/perf/riscv_pmu_sbi.c |  7 ++++++-
 2 files changed, 12 insertions(+), 7 deletions(-)

