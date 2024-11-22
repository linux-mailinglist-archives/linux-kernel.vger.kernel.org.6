Return-Path: <linux-kernel+bounces-418286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ADD9D5FD1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 14:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C94B23576
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4334E20326;
	Fri, 22 Nov 2024 13:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XAKatMsw"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C8B5223
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732282936; cv=none; b=KEQP9ExAKw7Ih1Z3B6g5bVYF1SBvKsQIPSL9MF4V/szqCQ3GAsPojrlHIDzQgcEW/CWRBT89guHUEUcFIv296uCoHJiT51UWKWzbtJ47YCf7u+7SNf7eNJ+uR8CjbPQkEPI6JeZL7ojVK2Q07Bxhj84Olx37bjwLr9H8/n0FCD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732282936; c=relaxed/simple;
	bh=vdClCEEENC+YN6w0HUYbAxBS1Vuzfwgoe0+fu0g0IhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JruK9lGHUWq9uS9xndRX72UEwZeFF0Za6S2aRGsP0xVmAwGOgBInHdrvb2iGJN7q//b749FTtidEB3LqhIV6vmMffP8WtIQZElM1S6ERVZyT4vDOdJx90uVvNd5JWYBoSOHnuCADx9mn8cgi1vlneqsMwlu3huusKEUrAOVxMPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XAKatMsw; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53dd8a528feso464001e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 05:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732282931; x=1732887731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kECXJ3tt3b+Rzl33FyQosajYwVB2nbctS6FkdLVf9NE=;
        b=XAKatMswPYgpfcjwAWgUkU/vadpk1wdRhDGRLOtABMKKRQbeL2s1m49bAwXS4hRhqs
         NfkdxPS0ed/0LxhgHMb7IsBbgk5DOfr8OSuQ3GUzA4ggTP3EE0oQjfmnuztcXe6bX4t6
         rXMdYDjcKEwbySMX6KlVU3QUeEDQkKRxbjwtbCiaWnv3AOMvHOBFZznwSgWlQV1/hLyk
         bvZAsZJNhv1lG18LDwPeMkKgY3GV/sDR81Mc9cdE++FxSCy5oCaoDDO1s7F/4Z7I1FMm
         Xzr7gqlkmt5FR3KgY1X//FUQ3sQ/i1tdKpSoU9Xev1yvNWI1R4Y3tOVATIJEcWZ5TbBR
         Skdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732282931; x=1732887731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kECXJ3tt3b+Rzl33FyQosajYwVB2nbctS6FkdLVf9NE=;
        b=GpJQvOQkSmb3prnX4Pzg4/4iAIXuPYoSkz8PzbKg466xX8KI3eMQCtLOGQfd5TYEdJ
         /SSuN7T+6iK3pWktCxOK8aLVL9v+Dh0pZQ8eYKWl1FAlEqys65bROXxasse2HsFcSZK+
         2yUalwwI6j0vGvXSoXXBFFf3bsao/wLgRkD6zDhAloroGKJ71SaiXWr1zaoybVfvp62Q
         FeAHfLLnKBe2EZeyx2wOp4F0ET7fxCmn75dke4BPWyiI0dm9R5zCIRiE75DrqZr9n0/i
         VbZNZ5M75qHHKi3xd2SvRzNmRcaw9eJwQvXq41KZUuIw8QEdsZMUwFThBV0nwGcdP1Si
         15zw==
X-Forwarded-Encrypted: i=1; AJvYcCWsOtMSomvFqKaMjLWNCj0Zj0q7tFLdKiArRsZ8p2vR9BPy9UmoNt4ho/CLPOU76dbJ/K0YV9L9WmWXR+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc37whp5M4h/zQ+KFSavuwlHV4FX090lGOan5COXGONNuHCS0N
	tZ3zQG1YGqURXSYD6No/7jr9s7AXlgpMKWLIMXOsAmPkC4KJhbKA79UWf3SJUCk=
X-Gm-Gg: ASbGnctfA846vKH4CnWwxjT+xeC8Vb/EUck6pSiuzalT9LT9XCiMHQThDgwEvHogan2
	AEAI3IaSJV4CBnKCqahcl/Y9YO/tVMTc6sO00pCdh5M738XrraB/ZoHY1i7oACaUziut8NcAjsy
	U9w9ja9gGexcF3ivNBhsIjXvOzVJ+ZR+lp1ruI9InAKBexeg48sPbQNL6eUyxLP3qvZ6Vqb6zac
	zYlNHiwB8Ot6bl9KYowX81cZPO+mrHDTbDny+UPFojoFM/QR93Fc21DtNZkatG8CNzTzujE5wKn
	zG7HOt2u1QwRsP/uwM4YueQ0
X-Google-Smtp-Source: AGHT+IGlUj819yfU1NglS9myUqpv0uFLKQ7u9TuPUIL1bbAcBAmi8sjSJvBKcWX+TVn+XB5jFJ905w==
X-Received: by 2002:a05:6512:3d22:b0:539:ed36:eb8f with SMTP id 2adb3069b0e04-53dd36a1498mr1694046e87.24.1732282931567;
        Fri, 22 Nov 2024 05:42:11 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2481e73sm376432e87.120.2024.11.22.05.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 05:42:11 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pm@vger.kernel.org
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] pmdomain: core: Fix a couple of memory-leaks
Date: Fri, 22 Nov 2024 14:42:01 +0100
Message-ID: <20241122134207.157283-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More information as available in the commit messages.

Ulf Hansson (2):
  pmdomain: core: Add missing put_device()
  pmdomain: core: Fix error path in pm_genpd_init() when ida alloc fails

 drivers/pmdomain/core.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

-- 
2.43.0


