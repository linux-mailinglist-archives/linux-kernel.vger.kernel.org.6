Return-Path: <linux-kernel+bounces-245629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25ADE92B52B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 12:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB48E1F23E12
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 10:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E88156F3B;
	Tue,  9 Jul 2024 10:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yj+7QbJm"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF2815697A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520733; cv=none; b=Sw/ivfAmKoTNcn3+c6zt+DR+N/IgNbdEUBq/44ZMW6h8lNv60wlCfgq6L1OIXucWtz2D1yXqSnz033PaAQmNJDQFYOM0xlvur+dA6oli3C327qYtDGlt8jVPf41MgBk74s9aojk9npiHkg5Nq4A1wj8l9XTasmlbAeXq80zNNgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520733; c=relaxed/simple;
	bh=EoSR0aXO2+/z3Iwpc6wgpC/ugmvAjQBUjo7PHJ3kGsY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ijRDSh1xNa4ILkHhkpPLQ48Kg7zSU8+XWQ/K1KnVCd1CZqz/CCRU/7wIXODYELEj2IoykhhC2Z7u2F+78oLwjkUXKo21TKVP3C+mK+zVL3ucoH3y5rK2FSoWoJh5yTGv5Lk7cIejn2t263j7hTZ9xgIL4swS8Tx12tIeEk4pta8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yj+7QbJm; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eeb1051360so14785281fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720520730; x=1721125530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwCSgjxT2tK3otzDQLFuNSIFcwYyO+N34TvcAykwDTc=;
        b=yj+7QbJmnaBwMJsJqTe4qDXZjXjNVaPQJc39KaYSB0hqlDgzlaJTigvvkcNuz75Y4e
         fK7AYDBYQNBj2c6duHNiiKtIEg/ezSW/LQoH4dYtsfeOKFifPQsLycmEofRH33RpsROO
         kpvTV6+TiDGjjHbWbvDi9zP3u4jbkJ812+BGgXGHw9vwmh0v0y+e+0G7CQWANw9WJLX7
         wa3mESvF8gjYtLIn4J8YbXpGO/r1PH79BvswPsZcIzTcUbId4innnzXeRIl5pz8HtSLA
         MiRG7jGupAW9+KckvWyUDvCchcquA+FwYupxCGy//fSR4iI4NszsPLY6o8rJS8mTj8Rj
         9p9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520730; x=1721125530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DwCSgjxT2tK3otzDQLFuNSIFcwYyO+N34TvcAykwDTc=;
        b=JtmWU1T/cdDpBUL7vyoMVAkVmqWCFHijoaj8hd8dQzlIro5akSJUGo0ofjTHDt+xkX
         mnd04qEIH9rpf8B2KAt3ep4jl/WtygMxXgHp7mKuxuObReXFrQZ17a2FYBZUsvldk1B0
         ALUCwFBkuOhVFQxDbNbxc+5ZXX+uPNyNYD9BI3Qy2ZVyDIQlf0zMb48P5F81ITsZ8BiQ
         mI9FdcrxBtH9tVq1llv5HyDZq8ig7Iz1qD66mnAcDmRSSMp8rgwd/5/LTd/rx56IMfRd
         bd/Ui4qWEKwcn53n9n8hMeFgE9iuMye8FFcGwIat7IAFICS2utmCA1bij0xdI/mI2bbb
         3/dg==
X-Forwarded-Encrypted: i=1; AJvYcCXWaXeP9RRwnsO7yEiFvFCsOrLnCsUm8P8A+ljeWkaux369oFWxILOdmrdekygpQOjy7se3o0Eg1QOa9YfGN+KUFTyty8qWZx5okF69
X-Gm-Message-State: AOJu0YzSe5S3dl3bnuf+VOVJhnZ/2XhqVWwhV4kFuFRr0Afo5GsD7Gex
	V1Kwvci46nrQqd2pJ7Pb4iIwoA6RlFUyl2Np1WogQDum0wb0c3kYOW+/EYqXJmg=
X-Google-Smtp-Source: AGHT+IHXJH3xjv9MTkIQQxNiMOAgiLbTh1Pv7hSzmS2GYQq3dC5IRHiDgUXWiz4o/lttBs7kCUQaWQ==
X-Received: by 2002:a05:651c:198b:b0:2ed:5c34:4082 with SMTP id 38308e7fff4ca-2eeb30ba0abmr20555151fa.8.1720520730294;
        Tue, 09 Jul 2024 03:25:30 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f741553sm33954285e9.40.2024.07.09.03.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 03:25:29 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: akpm@linux-foundation.org,
	robh@kernel.org,
	suzuki.poulose@arm.com
Cc: linux-perf-users@vger.kernel.org,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Kees Cook <kees@kernel.org>,
	Matt Ranostay <matt@ranostay.sg>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Mao Jinlong <quic_jinlmao@quicinc.com>,
	Hao Zhang <quic_hazha@quicinc.com>,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: arm: Update James Clark's email address
Date: Tue,  9 Jul 2024 11:25:11 +0100
Message-Id: <20240709102512.31212-3-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709102512.31212-1-james.clark@linaro.org>
References: <20240709102512.31212-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My new address is james.clark@linaro.org

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../devicetree/bindings/arm/arm,coresight-dummy-sink.yaml       | 2 +-
 .../devicetree/bindings/arm/arm,coresight-dummy-source.yaml     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
index c960c8e0a9a5..08b89b62c505 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-sink.yaml
@@ -30,7 +30,7 @@ description: |
 maintainers:
   - Mike Leach <mike.leach@linaro.org>
   - Suzuki K Poulose <suzuki.poulose@arm.com>
-  - James Clark <james.clark@arm.com>
+  - James Clark <james.clark@linaro.org>
   - Mao Jinlong <quic_jinlmao@quicinc.com>
   - Hao Zhang <quic_hazha@quicinc.com>
 
diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
index 6745b4cc8f1c..d50a60368e27 100644
--- a/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
+++ b/Documentation/devicetree/bindings/arm/arm,coresight-dummy-source.yaml
@@ -29,7 +29,7 @@ description: |
 maintainers:
   - Mike Leach <mike.leach@linaro.org>
   - Suzuki K Poulose <suzuki.poulose@arm.com>
-  - James Clark <james.clark@arm.com>
+  - James Clark <james.clark@linaro.org>
   - Mao Jinlong <quic_jinlmao@quicinc.com>
   - Hao Zhang <quic_hazha@quicinc.com>
 
-- 
2.34.1


