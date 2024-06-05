Return-Path: <linux-kernel+bounces-203203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF618FD7D5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 22:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA4941C21C5B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE00115F3FB;
	Wed,  5 Jun 2024 20:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRv8mk+0"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245612E63;
	Wed,  5 Jun 2024 20:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717620736; cv=none; b=g5BBp85skSSlZMS4tp2EJSoY8bUF4rz9NyhgEXvrU1F4+a183PnFXh51hCobEsalakPfWDb1HvitAKQzP5VO33AZfMiW3seUa0HFjTWebZzrJ0S96UPlFLwZXjYEez32itf9G0Q2TWyevEpVvD3Y2N7XrsYUjsHs2v4teQlbntU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717620736; c=relaxed/simple;
	bh=T4X1hUyLpXP90M4wfsNZkBFYoIXVnKWnd66O2FMVaFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGprSj+VGYE6TdeSq0zDX5Ex2kxfVso9cY2guPvFfWSqdek6V1Fj2sbtbT/sR9NNSlOEC0/Z2nJ8HzfvMucD+onfo0SkKnYxrDgmEB6JX0/fA3OPt98gIQYeMPCimK+gZNOjQEgGC8Xf4t6COZY4QdUrfM+vKVDUi6LtgXRPwPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRv8mk+0; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52b94ad88cbso451859e87.0;
        Wed, 05 Jun 2024 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717620733; x=1718225533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntabvct72qGvPmbO5oeReuAlzSAK04HTOHOuuEcj1Pc=;
        b=kRv8mk+0/r5wAxizcAccSZqJutZv8hzRcxq50/YU+3NGxnVVdBB9htxcabhn1dexA+
         oD9sSPqflbUqYGsMH12pvBCSsB9YLf+pHOMuBEbArwz8KC6J4RHXm0R7KYeZji93GtSE
         V8A5qdcs89pyQEdcNICDD/OqWBnUIzjw0eTG3Ynsi74xs7PV44cWRsD0Yg3ZQa7aOdXy
         g/CpimZRa+Hwgj2yWQAHI8uNXCVURlBN9CbZNvw0RD+RCJgk/r0grZnCrHqYhFTXC8r/
         +WSHuc5HkHSFsJf/16aSPKnIpRL442laYdSczP71ShEgE1VyHJMv6p5gLwKuC55UaQ7S
         NPHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717620733; x=1718225533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ntabvct72qGvPmbO5oeReuAlzSAK04HTOHOuuEcj1Pc=;
        b=qpZWPOSGt1enT7Npo2sLqLXGRx7feFIogU4EVkLJgV+80azli0Odx9N8hQt9qwlhJ8
         QS4kkPck4uCZgYHcBUTq54Ls3H3UVYLQjjF8cS0qxEyTOPDpDefjmhdg/qKiKpfqdAxJ
         iIFgbJRaxoVu4nWLPdmoQnRug8RPYV5gKEhQUUGEhdrSj5lX9oAWlhyLMxjxOWOxF3/Q
         vzcFCMli2ASybh7PgsEUaDTvbqVObfmq90bmeiFmgMQsHe17OVqMfvtdUPU8zVYJXE1C
         sB0WQPuoXJfkoMVyEX7Q92d37cN5k6W3tQKPbyzO0EFqvREluT12rqlCCIpFvpCJzWYd
         Orfw==
X-Forwarded-Encrypted: i=1; AJvYcCXAGg6N7H+y+j2OTJmtN37Hj1gAyjh32natRpqCIbgvC8Kw+Glg31yZRgVeQ82uSWJ6g5FJlvF+Fhb01ibuquvn+xD1JSXtjcm+bVtkWFuztxmLve3S9cY/yXoR2zdRxC+t3Q/0bEMcFHOQNwIjH5bSYGfILBZLRTvzPRii8lQ0vGerzQ==
X-Gm-Message-State: AOJu0YzM8XL29GIu4xHaWuZDJgKNpWJqLD2oegt7pMBeZrQKe/el6ors
	R3b3i5gB+UzD9ucuNAYRRyiLxl9JNdFseFMRBN9WEHnYyxjjnco=
X-Google-Smtp-Source: AGHT+IFLsFZKV2UCEFoLeUQP6sDHDvqEj6Gdi7GN5knUg+e3+onFNbKTpZbrCaUvyEmzLhZLX0d6oQ==
X-Received: by 2002:ac2:5592:0:b0:52b:fb4:1283 with SMTP id 2adb3069b0e04-52bab4d8022mr2642243e87.15.1717620732936;
        Wed, 05 Jun 2024 13:52:12 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:5211:58fe:dfef:c48c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c71bb5affsm72265866b.147.2024.06.05.13.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 13:52:12 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 2/5] dt-bindings: clock: rk3128: Drop CLK_NR_CLKS
Date: Wed,  5 Jun 2024 22:52:00 +0200
Message-ID: <20240605205209.232005-2-knaerzche@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240605205209.232005-1-knaerzche@gmail.com>
References: <20240605205209.232005-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CLK_NR_CLKS should not be part of the binding. Let's drop it, since
the kernel code no longer uses it either.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 include/dt-bindings/clock/rk3128-cru.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/rk3128-cru.h b/include/dt-bindings/clock/rk3128-cru.h
index 1be455ba4985..420984fc2285 100644
--- a/include/dt-bindings/clock/rk3128-cru.h
+++ b/include/dt-bindings/clock/rk3128-cru.h
@@ -145,7 +145,6 @@
 #define HCLK_CRYPTO		476
 #define HCLK_PERI		478
 
-#define CLK_NR_CLKS		(HCLK_PERI + 1)
 
 /* soft-reset indices */
 #define SRST_CORE0_PO		0
-- 
2.45.2


