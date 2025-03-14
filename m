Return-Path: <linux-kernel+bounces-561148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE41CA60E14
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0B617DA04
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD48E1DF982;
	Fri, 14 Mar 2025 10:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4LLF7Kl"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448341EE03D
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946481; cv=none; b=ksJssYWY5+i03T42fNQ0ApIZ+4nNWrRWVMoFOkrX4WsqF8PDM5hf4PqVIJHl1Tl6bHm82Ip/DovSUbuKrLxlMYKahyCGP2e57NQWHh3/HIovwb5NQmBlmke3VlAn3QRUhLd08Cv/DXaHKlXTcHMk8BV/Nuep4Wczqw/o8kwXZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946481; c=relaxed/simple;
	bh=h4YozQ9gdqsEHLD3bmeEiZAm4g7uaJtsWIOuL/f+7v8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TMFKhXQ4w2WTZDgE0d61UoSq/KcDllvLovSzqa/Rre8AHV5mHe6uO+Ag9lFR6yrjTzxMP0W9r10miDGq5oPyM1jZUojWTERBCD0MdNQzjL6L7lea/tufFhp+uyiclIYWEVmtsBjlXO8wV4Yxz4zk3WhghUsC89ZIvb/xeBakFDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L4LLF7Kl; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bef9b04adso19708621fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946477; x=1742551277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NUgcdMszcZT79fuSYG7PG9+8zG6HmJmlZyIf7W0iDLk=;
        b=L4LLF7KllS1/yVTaI9zFkk/f3iw9JcSsVWCyaLXNu6oc1CM12tkYIt0LCVF/BIHw9s
         L0mTkNqUpLBR5VHaiN+r9YY6Hu2v6sC2rr1f1XbP5BE+VjXYd5S66n8LbQYuahlNNIcP
         8IUNKVgpmfMhcPKpOa7kyxC3n74WmYBnN3fLlM5bH5uE3th3m1YgnxWWm21wqoyMnFEG
         k+wn0GGgVjcIjBhuH6TSOXI6KyWZdmHqXatuSVsj+BP9Nn+3D55PS3DK4e5Y4a/6HY6e
         RkH/Zp2adzeCJwIj4yH1wozlarNgyBWrpReQGjJt+WhvemGfgMM+fcJ6MMVHysX/sN+G
         sk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946477; x=1742551277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUgcdMszcZT79fuSYG7PG9+8zG6HmJmlZyIf7W0iDLk=;
        b=G9aTjROUHX0khazypgjVJ7hf8R311yJFpj4ACG37N4LlyHBfHkeH+NBkytGWvEOZpW
         JDP8A0xxiyAkTrjNNuZLewsU3Aev0LSR3At6XRmUVGR0BkqGrL+ZwShfqNwTHfogpwXv
         hV84fgKCagB1GQ8TrlGIzKL2Sec9DzYa98xvMwibAsYbZPABhbEusDsaSqIu45nWIVuI
         rbZII3YPm8z39ny8ClCLBG2NxijEWy65qNbXdMVyRHg8qRDU+fNUBybPv+36L28jkme4
         9ghf/F9HRn4ZsiPFoEbY9RHJC7xhtkbpmFKS8qFNAJWJts4/RP/8P16Z4/IvbVaKYEKy
         vZFw==
X-Forwarded-Encrypted: i=1; AJvYcCXLSbaFkcM61b2tAe+hNleVamlNKdsSkKLODN/m2+9wNjQh87eBm+UIVtPqw9eA1Iw0eTMK1pBbNIhMLI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC/e3n5pvq4ApD2ddLLQalCIP+5LN5h3iiWIPzPAsPKK3KhYOG
	S+zXGzbFX4hnV+VqsjmpCtMt85AV1V8iptB/xlKThPuIumHIt08iV33oplZH/p4=
X-Gm-Gg: ASbGncuas6BiNqkxRuDtiphrogJT4zzshj+41UKdjoy2I/ULMvUzFMfYFGpCK25H6V/
	H+vvask6JwrSdr2Aqm4qev/AHaurn7VJxwKzEwzMH8tLHlQ5vxrOdON1SNSdcHnwmcgXB3VdaGK
	uOWpfc9Vo9zC+tlg6oJ4U80kaXZHtiUeLtUPOSES/LSFprMG9/VYB2vODGSM8ECnyOscFULvE/4
	DajYNtWuy56PnhS4jKk5/n+fO773mi+pDdtJOEnRFgV2lGcV4VZpk5LMdR7+ZhuUhBSRDnCxE1Z
	X4Fl48RRWAVEBFaNhfH5Fbix5VjxgzCyQOd/SDYMmpPBy8vpcYw8u2uULrZUQGryxt5CF9bacD/
	/tyuxXPXK7bzEPCKqSnU=
X-Google-Smtp-Source: AGHT+IFr9G0sLdjjGzAEmSADvTJYSJ3/q7bZeLPAORPr3YpjeuD+P4b+VCcMRGSP60Xi47buAS1RYQ==
X-Received: by 2002:a05:6512:23a9:b0:549:8d07:ff0d with SMTP id 2adb3069b0e04-549c3987fa1mr605518e87.45.1741946477176;
        Fri, 14 Mar 2025 03:01:17 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30c3f0ea468sm5168221fa.41.2025.03.14.03.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:01:15 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-pm@vger.kernel.org
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Anup Patel <anup@brainfault.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] pmdomain/cpuidle-psci: Improve domain-idlestate statistics
Date: Fri, 14 Mar 2025 11:00:54 +0100
Message-ID: <20250314100103.1294715-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series improves and extends the support for domain-idlestates statistic
for genpd and the cpuidle-psci-domain. More information is available in each
commit message.

Please help to review and test!

Kind regards
Ulf Hansson

Ulf Hansson (4):
  pmdomain: core: Add genpd helper to correct the usage/rejected
    counters
  cpuidle: psci: Move the per CPU variable domain_state to a struct
  cpuidle: psci: Correct the domain-idlestate statistics in debugfs
  pmdomain: core: Add residency reflection for domain-idlestates to
    debugfs

 drivers/cpuidle/cpuidle-psci-domain.c |  2 +-
 drivers/cpuidle/cpuidle-psci.c        | 40 ++++++++++++-----
 drivers/cpuidle/cpuidle-psci.h        |  4 +-
 drivers/pmdomain/core.c               | 65 +++++++++++++++++++++++++--
 drivers/pmdomain/governor.c           |  2 +
 include/linux/pm_domain.h             | 10 +++++
 6 files changed, 106 insertions(+), 17 deletions(-)

-- 
2.43.0


