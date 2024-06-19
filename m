Return-Path: <linux-kernel+bounces-220994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A1B90EA76
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 14:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB42B237F7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 12:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D124E140395;
	Wed, 19 Jun 2024 12:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YeWOtK4t"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D5013E034
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 12:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798988; cv=none; b=G5t7O2a+ObDBHKJUtY5hSCIuuWmSAOhMUOl+6lTAfzxSJCOZs+p872zF54ZosB+7QjmpdOU++5964qgOoK3bP/E06qmF3oJXMR/oy6NwEr//b7be2s1njj/LDxSpMA+xvkdDfeJHJPNRnV+CPELomcS2tjaCdZeo4cxSTAWrDds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798988; c=relaxed/simple;
	bh=xavlI80GPdWRZ0p8Wl6NBE6+ijBGicpCiFVCMvmOY+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FeaqkDp9dHG+Qc1ddDMJcnFAsCqX8UqvtAqbdsRhD2PyWs1lEOTUtq8Wdg2ruUfUXLI+mQlSNCtvMZjup1EjUmoG97kmUjv8vuMFCS4O4RWYuiMgUhV2qsywo5MxKwFztJ6UL1hDRvKRSAWjokUqYJSJ1JzkhhqznJNIAveHNYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YeWOtK4t; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6e43dad8ecso137773066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 05:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1718798983; x=1719403783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ojJGbarIJ49aCusK8TQyHNsUYXaxQGLSM1fTmDeigGc=;
        b=YeWOtK4t9wJ4HQimSQcyJFVn/0FBR0b1wdNFrZ5KDOPD9zVXy7hqhhi1+5xFedewqo
         n1uYYZ5PoI6grbN9Ei6kWAITL2xm2g41K/sOhrbbTXuPdP3F9zQdkO8iDCJiqOqGZvzP
         UY2ZKIvX22ejx7AXrrCOoRCF9fNwVwGq1dl9K9JGzezP7MG4lxKGcYMegKd47RZd5ZSS
         DY8JCqtEhUdXTJi16Vp6VeHzvG2BtJa6oL11NzmbqZx+xKpeOKWtOHewapNzU2o6OiE2
         +G+SuizJ7DYYJQzRbG1pYUSEEb/jOfgnZxZDRq9OyAy3utZZXlIstniP3M202ul1X2uM
         QrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798983; x=1719403783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ojJGbarIJ49aCusK8TQyHNsUYXaxQGLSM1fTmDeigGc=;
        b=B+wpVX7o8VYmI+Z/6KlGvETIuhdqD6OZ48cp+f1RYH9S5KFymXtwHRDgsOMFisgq7n
         2Eusc46Q6SKUw/0Izk3NuI9lm3VTex5Kdn9Gs+A9NzoFKaUkeAKG9e7ZZCWtkNwuiyGX
         fh2NvznYVDJzwCnWrmytn9tQKSeV/mrqQe56dur1Sm8tiTxwA6OKa1C+BPq7IhuuQo5j
         uhsjafk9ZXvqhzUfPNPKtdusESp1xqGPFMcwVQIsbVdFhMG9Og9Y161lMfRjx8lEdb4u
         julLpXN73PoBCl9WpdS33Rn2KWdUeW1by0NkErwfj8Mm+uYkxUfTZAyEzirIcDeN+dqw
         kU1g==
X-Forwarded-Encrypted: i=1; AJvYcCWksk4QlAjxqUlLT5usB8OWI6zi0GaVh2RkMqItdYeWGh3loJXCS/YsBQzKiiK0HvfegVM/E8f6JZMzslQDCx1jE+BR+nCOUxy215Y8
X-Gm-Message-State: AOJu0YxpL7B5YWnCO0Xk3Wmvz1KWl/oofAxSm55szB8NxR73BGG4OtD0
	+kyAWwiyIXftgybxqCnzHFyaDhnhF9WuxTMHGR9wxXudgO8mzQ81uEatyoyYSXk=
X-Google-Smtp-Source: AGHT+IGyCeoCaSQqPKYdImlCdqNYvFr+oYfnK+iUXuPolWmC0vzy/4o65nQ6QO9Pq29gB/da09bipg==
X-Received: by 2002:a17:906:114d:b0:a6f:a2aa:a4c7 with SMTP id a640c23a62f3a-a6fa2aaa594mr159185566b.3.1718798983334;
        Wed, 19 Jun 2024 05:09:43 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.70])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da43fbsm659014066b.39.2024.06.19.05.09.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:09:42 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: ulf.hansson@linaro.org,
	wim@linux-watchdog.org,
	linux@roeck-us.net,
	rafael@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	geert+renesas@glider.be,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH RFC 0/3] watchdog: rzg2l_wdt: Enable properly the watchdog clocks and power domain
Date: Wed, 19 Jun 2024 15:09:17 +0300
Message-Id: <20240619120920.2703605-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Watchdog device available on RZ/G3S SoC is part of a software-controlled
power domain. The watchdog driver implements struct
watchdog_ops::restart() handler which is called in atomic context via
this call chain:

kernel_restart() ->
  machine_restart() ->
    do_kernel_restart() ->
      atomic_notifier_call_chain() ->
        watchdog_restart_notifier()
	  rzg2l_wdt_restart()

When the rzg2l_wdt_restart() is called it may happen that the watchdog
clocks to be disabled and the associated power domain to be off.
Accessing watchdog registers in this state leads to aborts and system
blocks.

To solve this issue the series proposes a new API called
dev_pm_genpd_resume_restart_dev() that is intended to be called in
scenarios like this. In this RFC series the
dev_pm_genpd_resume_restart_dev() checks if the system is in
SYSTEM_RESTART context and call dev_pm_genpd_resume(). I also wanted to
mark the device as a restart device with a new member in struct dev_pm_info
(similar to struct dev_pm_info::syscore) and check it in the newly
introduced API but then I told myself maybe it would be better to keep it
simpler for the moment.

Please let me know how do you consider this.

Along with it, series addresses the usage of clk_prepare_enable() in
rzg2l_wdt_restart() reported by Ulf Hansson at [1] and use the
dev_pm_genpd_resume_restart_dev() in rzg2l_wdt driver.

Please note that series is built on top of [1].

A similar approach (using directly the dev_pm_genpd_resume() function in
rzg2l_wdt was proposed at [2]). This series was posted separatelly to
avoid blocking the initial support for the RZ/G3S SoC.

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/all/20240531065723.1085423-1-claudiu.beznea.uj@bp.renesas.com/
[2] https://lore.kernel.org/all/20240410134044.2138310-10-claudiu.beznea.uj@bp.renesas.com/

Claudiu Beznea (3):
  pmdomain: core: Add a helper to power on the restart devices
  watchdog: rzg2l_wdt: Keep the clocks prepared
  watchdog: rzg2l_wdt: Power on the PM domain in rzg2l_wdt_restart()

 drivers/pmdomain/core.c      | 18 +++++++++++++++
 drivers/watchdog/rzg2l_wdt.c | 43 +++++++++++++++++++++++++++++++-----
 include/linux/pm_domain.h    |  2 ++
 3 files changed, 58 insertions(+), 5 deletions(-)

-- 
2.39.2


