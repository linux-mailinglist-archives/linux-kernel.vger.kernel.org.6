Return-Path: <linux-kernel+bounces-365206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B5999DEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 09:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6B2B239E1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 07:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AFE1D9A4F;
	Tue, 15 Oct 2024 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F8cgN/9m"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8893C18BBA8
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728975539; cv=none; b=Pfej2Wz8i7kt8kKEp3lgkxcCFdwREe9abvLvLBDHBvus3zq+lCF9DxgOR870Yq9RSzhBVvjJeqeQEE/hsz6X1jDgpQnc2UA/eLt+RZNUMoucZsOgsfOiyrVgGg+Pyquu524mvGoff3sCFT9tkJmBGKIZAap7awboJQZuKAjltWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728975539; c=relaxed/simple;
	bh=KHk7h72KzrixZPSmY652+q6BP2j77mrUbzaF1O99wYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxhQQfdi4zhqdKXzG3Szm/QaZ2xhiVJUGZIaiUQXrfANPNkxdJXFwCfFEjxFsEY9R83NQ1mR5o5IfCW6xINYo4VWc452/6j24EitGOxy9f83YnoA09fs3bSfATELo+zZqC5fS7X0qBxfwWs81efFQckF1cddojKWKSn5z8DJzHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F8cgN/9m; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43052b41f25so6241755e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 23:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728975536; x=1729580336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3HzKXKEZzBQaZD9201Kj/OtZlaySZJuU2J8G51Yt+4=;
        b=F8cgN/9m1dRLH3vLP+O6uolvVePR7dmhc/6wRzV1nmxMciJu0cqsnkn69PFDSbJnb7
         wgPHHwZTm62kQfI5pwqQEVnQfyqfckW7hNTTvGj9IPXRJlLKhGGK2tBQ1BsfZgel2ru7
         kJ7Oc/EYRcj9F7hnjzkzUkRhKhVni1ChMq2e6Z2Q9Mlnb+kagXrn0QQ5e1+N57JBR99N
         cTgKDIjDkXGs2odaNtWsIMISv929S/UmCzEh8BlPESiI6L1AtmpQz6LKmO7Ej3A7rt+z
         c52TD/kLSF66AKTlqId3NriCzP9D18mCeMqe735REoWZ3yMOJc1Rht0J3pSdv8tFFcyG
         eu3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728975536; x=1729580336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3HzKXKEZzBQaZD9201Kj/OtZlaySZJuU2J8G51Yt+4=;
        b=PGAqYR8ILILnbNylX+As4Hqc3HRhPFOx2AKrW5AQ45myHGSxh7mtTXuUD/1WhhSo8h
         edCf7FkgLG38Lwrewtxx7RyKhvnJhIrSLL5ZqOgDap+M1+F9oaWBBpCeupJ+MGoYiOZc
         Qv1S+ze3UnflVHKSFXb96rjpm4APERTkEnthUD1rSoFiv/NmBjIcty8NGXAGGdT/KdZH
         ihpK5i7Mc2YmDqkLKEzYKv9JH/Zk/u7FtE8WOJ8XylMvrYTv/UjChTsi+UBB65Fh12ea
         Rnuij0x8YbGkwz6gRYOCIlR85nWQqV93sDLMyu/KMDqIpaXrNbkvHU2O7YuQOFMSAfLV
         DkTA==
X-Forwarded-Encrypted: i=1; AJvYcCVH3/WO1HFbJvrAzZ57PjiKa0ULhGcF+5g9nLj1iuZEXgDhDxz6FhSuB9F/39UDz9fgRNpLelCEG0ZNhRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhOYUXE2aCr7YGCHpZ/qbE2GhFddtynmds3he7hVPI/ypCoDpa
	eDsskcbCt950tyOuW0x4hyjhUNr9nx5aLR7Bx5dD8rT0tobknq3aa++u5XhHEss=
X-Google-Smtp-Source: AGHT+IGX9LHy+IZRCrAjUc2HU360Y7NEiYtO23RbqSiqGuGi0FZJ8xxf+gyIM29W6+C5SNxGLJMF/w==
X-Received: by 2002:a05:600c:1c0b:b0:42c:ba6c:d9a7 with SMTP id 5b1f17b1804b1-4311df3b69dmr51933375e9.4.1728975535898;
        Mon, 14 Oct 2024 23:58:55 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f6c5d22sm8461645e9.40.2024.10.14.23.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 23:58:55 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Jaewon Kim <jaewon02.kim@samsung.com>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Igor Belwon <igor.belwon@mentallysanemainliners.org>
Subject: [PATCH 2/2] dt-bindings: pinctrl: samsung: Add missing constraint for Exynos8895 interrupts
Date: Tue, 15 Oct 2024 08:58:48 +0200
Message-ID: <20241015065848.29429-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015065848.29429-1-krzysztof.kozlowski@linaro.org>
References: <20241015065848.29429-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expect only one interrupt on Exynos8895 wake-up pin controller.

Fixes: e2d58d1e1c61 ("dt-bindings: pinctrl: samsung: add exynos8895-wakeup-eint compatible")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
---
 .../bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
index 49cb2b1a3d28..b7c2692f0ac3 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/samsung,pinctrl-wakeup-interrupt.yaml
@@ -103,6 +103,7 @@ allOf:
                 enum:
                   - samsung,exynos5433-wakeup-eint
                   - samsung,exynos7885-wakeup-eint
+                  - samsung,exynos8895-wakeup-eint
     then:
       properties:
         interrupts:
-- 
2.43.0


