Return-Path: <linux-kernel+bounces-183471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D1C8C9974
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 09:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038FA1F20F74
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 07:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66E31C69C;
	Mon, 20 May 2024 07:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SIVHYJeh"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EB318C3B
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716190888; cv=none; b=ZDYomcbh1fqw8w9Ia05yu+QkAwfPxJRt1eHkPtrOouBCWjNBUIVHYxW4lInQ3wWjBx1FfYIsgeXu+gASZHZnUr/kHvKJYzM6zjgErehGd/1kFMlB0Cm9pxb8TiQJaHhH2k5zmRre801DWQxKsemznrVeukoUmxNfk2iMtUSIfR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716190888; c=relaxed/simple;
	bh=G5RDRHDp8bHkhePtdbNcRht+dyNZhXMGcqFPvB99Cuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWh2h25v+WbdNyGoPGM0GYjl52uR8/+ZzJ6VpO3NKNMU90A3NEPocyG1Xm7s2GIHi6kLFoBEbkt20rRhvsMb5LRfJ3IMfjlkfzulvs4nD84VjYd9W/cfUSGxJKi+/Q7vT/QkBqUbGETGD95Pe4M4rkZhas1Sbl1gXl1H7I6TuCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SIVHYJeh; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-572a93890d1so7692986a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716190885; x=1716795685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6A/avYP5YPpm971N8IK0uubu89NMozFIaDiylX6PsHQ=;
        b=SIVHYJehigN7Z+uGkDHc1JXmT3UA1QwdO0L4SKt5cjkYYu08ajuJUYcbokh6wQymlf
         tPn/YOSql7kMgbv9Zkn7+vXUGGGPOzgEuNZjI6j/j7Xl3F+VChveElSxgTUxnzMZKMy/
         qyMvMB5Jsw8xYWgnRzMl4et+c44SCilHajNjEPTtRxm1RjzRDkTyHv3cZel+7WsRxslU
         rFkcnpgrSN329zStFn9cK6YN+dUTB/aa/zC3p0Q1ethr6BW4KS5H6eYaXMFRs3KXOwjN
         76kAJGLny2od8PsfeV6Gdzq6dcdFRNUj1s9tC2iAmzLwyr82qu07fXYHhHJSBYnLbVG7
         wJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716190885; x=1716795685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6A/avYP5YPpm971N8IK0uubu89NMozFIaDiylX6PsHQ=;
        b=SAdZtRDYry4wXAQQvvsAJoi2alWk7g4gDGYxS+I6yjihIsdTHO+w7EBftbeA83nmvZ
         uurRTa6CJ9vXj5uSGCB2UJLXi3/iSc1Q3ku9pzOH9eLDvCS7AFtp1zmqBjGEAG+4i7wk
         5TGaoTzGKhon/FPvxTLtrW9x2R7zHNXvwQ1vP/+rhhPowngBUssou3By3I0GjwhdCWxH
         Q1gXLvVX4Fq0MSdC5MuWKUP1UVcfa1bt2MH/Ky75q1rKeJfZEcqP32qgbsUyPjWTR3N+
         ETZ5bkc1QbABkbksp8j2xUAb4IYWFeHIUNcPy5cumc5v2LlpYEWa7LpAIbwdlkCuN3cy
         fJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCWuvNJFFpq4VQdVNtBh66EETxb2YLzWDJ3MkO/00TiBPc0yWVJNOTujyD0yYJxhjb3J8kqawbPXPgjcp4l9mVlXJ93srYU2eM5+MYDp
X-Gm-Message-State: AOJu0YxpzWmUZcMaaV8bfBcgrvNwx5+dMhtjYNcniIgg3cv3IdO6UCvG
	VKrFFMa0uLVi8XGFCcR6od9tTzzyQpottHLjVba2QPYOiJE8uQn5WAS+RmNwVak=
X-Google-Smtp-Source: AGHT+IGaGv6w5Ejo+3PCQdIkO7sIlmQZTkHvXrWEWEQy4bzPDzHGkbybTDIi2J4UNNkyIEUhf7BVeg==
X-Received: by 2002:a17:906:4f83:b0:a59:ea34:fe0d with SMTP id a640c23a62f3a-a5a2d65ed4bmr2937020466b.47.1716190884722;
        Mon, 20 May 2024 00:41:24 -0700 (PDT)
Received: from krzk-bin.. ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a893a91b9sm754853166b.7.2024.05.20.00.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 00:41:24 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Arnd Bergmann <arnd@arndb.de>,
	Olof Johansson <olof@lixom.net>,
	arm@kernel.org,
	soc@kernel.org,
	Antoine Tenart <atenart@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] amazon: MAINTAINERS: change to odd fixes and Tsahee Zidenberg to CREDITS
Date: Mon, 20 May 2024 09:40:13 +0200
Message-ID: <20240520074013.9672-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240520074013.9672-1-krzysztof.kozlowski@linaro.org>
References: <20240520074013.9672-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Last email from Tsahee Zidenberg was in 2016 [1], so move Tsahee from
Amazon platform maintainers to credits (thank you for your contributions
and maintenance!).  Stale maintainer entries hide information whether
subsystem needs help, has a bus-factor or is even orphaned.

The Amazon platform still has active maintainer - Antoine Tenart -
however there was no maintenance activities coming from Antoine.  All
my patches from last 4 years related to Amazon remained unanswered - no
acks, no picks - so document the actual not active status of the
platform by changing it to Odd Fixes.

[1] https://lore.kernel.org/all/?q=f%3Atsahee%40annapurnalabs.com

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index ea84fb373310..bdf592e0bd25 100644
--- a/CREDITS
+++ b/CREDITS
@@ -4367,6 +4367,10 @@ N: Haojian Zhuang
 E: haojian.zhuang@gmail.com
 D: MMP support
 
+N: Tsahee Zidenberg
+E: tsahee@annapurnalabs.com
+D: Annapurna Labs Alpine Architecture
+
 N: Richard Zidlicky
 E: rz@linux-m68k.org, rdzidlic@geocities.com
 W: http://www.geocities.com/rdzidlic
diff --git a/MAINTAINERS b/MAINTAINERS
index 8193bd95c84c..3e1ce64801ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1958,10 +1958,9 @@ F:	drivers/soc/amlogic/
 N:	meson
 
 ARM/Annapurna Labs ALPINE ARCHITECTURE
-M:	Tsahee Zidenberg <tsahee@annapurnalabs.com>
 M:	Antoine Tenart <atenart@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-S:	Maintained
+S:	Odd Fixes
 F:	arch/arm/boot/dts/amazon/
 F:	arch/arm/mach-alpine/
 F:	arch/arm64/boot/dts/amazon/
-- 
2.43.0


