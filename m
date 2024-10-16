Return-Path: <linux-kernel+bounces-367717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E61F49A05CC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 245F11C217A7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5DB205E31;
	Wed, 16 Oct 2024 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FntViEVo"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A96B205E08
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729071692; cv=none; b=pcGtF4FoNuDSTDrebYVEWwASrUqNqau1LS6JB1o3VS6e1pe8R9aA1m/2riEaA4F/4IY6a/a8RWmCxD/rL2pMmITRXE6IkHDTqf7PF9y40Xf5nanO/fWek3JRiFjw1v1wSJnCHibOBKwQL9HuRTp0KMUcdpkw52j5viIK7eC97nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729071692; c=relaxed/simple;
	bh=sVZnqwpnk8S59BMYoaDVHb4o2JgmACO7+oCJTiW+8WI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oCg304dbbe61yDhA9HCnXwMDVyMJiEHROfRyd5Q+f3eNPLintMLrijRs0RKbnepDgNv0aXBrMDChyhgrTagnbqOTYjRkyV6e3m92rgZQwpYnecYQUekv/DqedyYGt5cA1tXbYRILojZ9p/VPsQTdngrV3u2eJGwaZwBpSgPhU5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FntViEVo; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4314a26002bso10830155e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729071688; x=1729676488; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n/eCP0XrWxjwVqv0id7P9/rEghAaXmJu6xIKtnmf1oA=;
        b=FntViEVoX9o0RFBOat2NryN0C1vRCNUZfYUgbM/DiZfpVbb4Q0rAa0yYaR1NtkY8gC
         R/z9aMnRHJ+utl630c0BDtUkN6w0ryjO3MlTCdG7kfhGhNgW86JkTK991SCoNxzmnmgr
         6RgF17JWnG4AVVAOMsM1JgFDpwpZHjFpXV1Hf/ORFpUX3c2TBWDDKSF6T4NapvzYPxRX
         HfAToAyfUxdD7f8RRy6j0oHbECxfoUUCff7cQCijTG5AdcMt113bhC8OmUqW9M2/zRew
         RlXbHjig7qo29N+bQHK4JPKNs/wCfGAq5Ff2Us6ri7rzqMoJmHC6Rxj0TsnkmPNkDUfm
         SJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729071688; x=1729676488;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n/eCP0XrWxjwVqv0id7P9/rEghAaXmJu6xIKtnmf1oA=;
        b=inSt3RDOwcO8eJDl0h8+CORaD4O2AfBnlRMRjjwaUwQNX0HHM02U54b7WGXHtQyB7Q
         Ed2TU+vNRkjpwum6lOexMhV+5x5Ad/+0RuRT3TLUGMpH1fplZt58oPxohLgTh9w7pRpx
         1HSCspleOMuTIU0mtcYvGzvqym79R93O2F5X/MPjDzQBpIefB5ImEHQL0pZfJKZOI1HC
         isE4CBtI3lphecz/cRN/OkDtPFpbuWhIXUMxs4oVhwnW8Is5pOaH0AUM6HjP/jevQXvo
         xmaLVFByyN/nESWRn2vnlt/Rv0ZKFoqtnVXcf3CmkP+zVn4hG58J8g/0CZQQq84sSYYf
         ymHQ==
X-Forwarded-Encrypted: i=1; AJvYcCULoq+Wej7iJguJi+Dqr6y6Pe8aVtdyA4g3edA4RCekC5qkg/6DS15gh1fWeoUv5aUHmMRJsZGwALgLjPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytgdX1/CVgB1IfEH1EtEHo7e0Oz3vslI9gc8czEyzu1oWmjpaC
	Y6lf+cQn8tVzqg/mZ8hJV4oUncFsGA41K9hGANWGp4llCj2UQQy1pMPdGdBGh8PWlNLPGpJ1Xr+
	7
X-Google-Smtp-Source: AGHT+IEYxpwMg04b4kVb9eSt7RVotoV1GH3NuOvLOI7E9t231bHLqlKRk0gJybhWsGhROLUbIc780Q==
X-Received: by 2002:a05:600c:1c14:b0:431:450b:32d8 with SMTP id 5b1f17b1804b1-4314a381ef0mr30630985e9.22.1729071688088;
        Wed, 16 Oct 2024 02:41:28 -0700 (PDT)
Received: from [127.0.1.1] ([2a05:6e02:10a5:e010:472a:1760:2b0d:11e9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56998fsm43654735e9.16.2024.10.16.02.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:41:27 -0700 (PDT)
From: Guillaume La Roque <glaroque@baylibre.com>
Subject: [PATCH v3 0/2] irqchip: Kconfig: Add module support for TI
 inta/intr
Date: Wed, 16 Oct 2024 11:41:08 +0200
Message-Id: <20241016-timodules-v3-0-fa71091ade98@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADSKD2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxNDA0Mz3ZLM3PyU0pzUYl1DcxNzcwMjQ9OUFAsloPqCotS0zAqwWdGxtbU
 Aj+qR/FsAAAA=
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 vishalm@ti.com, Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Kevin Hilman <khilman@baylibre.com>, 
 Guillaume La Roque <glaroque@baylibre.com>, 
 Nicolas Frayer <nfrayer@baylibre.com>
X-Mailer: b4 0.14.1

Added module support for TI interrupt aggregator and interrupt router
drivers. Default value for both drivers is ARCH_K3 and the interrupt
aggregator depends on ARCH_K3 as it contains 64 bit only ops.
Tested allmodconfig builds with ARCH=arm and ARCH=arm64.

Changes in v3:
- Add MODULE_LICENSE in drivers

Changes in v2:
- Added depends on ARCH_K3 for the interrupt aggregator driver as it
  uses
64 bit ops

Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
---
Nicolas Frayer (2):
      irqchip: Kconfig: module build support for the TI interrupt router driver
      irqchip: Kconfig: Added module build support for the TI interrupt aggregator

 arch/arm64/Kconfig.platforms      | 2 --
 drivers/irqchip/Kconfig           | 8 +++++---
 drivers/irqchip/irq-ti-sci-inta.c | 1 +
 drivers/irqchip/irq-ti-sci-intr.c | 1 +
 4 files changed, 7 insertions(+), 5 deletions(-)
---
base-commit: 2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2
change-id: 20241016-timodules-174770215dd8

Best regards,
-- 
Guillaume La Roque <glaroque@baylibre.com>


