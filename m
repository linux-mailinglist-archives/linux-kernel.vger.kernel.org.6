Return-Path: <linux-kernel+bounces-295339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8FE9599D2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5621C2084C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 11:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB972140F8;
	Wed, 21 Aug 2024 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Si8srhhu"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2543D2140EE
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724235969; cv=none; b=lAsTfDd3DfHqJf309MtH0f6qjXEB+WCwZHQZq5yXM/+P1X+WizfpPnz7iJ1jNpB3m9/gvbkYdhb3JHKzPxa6eQviRLZzWWqIX1U429CZabKD3wjfZwJExp+V1tX4QsH3AB/jbBP8A+Z0cT4dY7Z6PS9ezBvz4vkmCmNvPnL94sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724235969; c=relaxed/simple;
	bh=EP1yi2pd8hzm/WofOdN7duGfAzgqL716j09t0RLjKgw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DsgUkGCOvypItkziUUvc0kotPZZ10HmFMES7UhXZl4xbUCjXi5kxKCBOaLOv/iLzXh4kPXU5LzrOqlMbIlm7WsN+U6EcwXu82nVv1Cankb+cU3BNr0D+tq/ycjhFn6ytxicAZtfhegQas/LWJ9maB/hrvOzJfCVr54eYSbtw7J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Si8srhhu; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a7aa74d1ab8so2870766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 03:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724235966; x=1724840766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr3fWsg1+KHj57spoBkvDMc7FLWUNMPanVJOyFPAj14=;
        b=Si8srhhuoBoWfTrantoAQLc1xDEH+wl9VAIMocGuWg+rTiuxYXMmLfu0y7+XGO85jS
         zz4r5QMuxzMrg/yi5xNIttLsmK7YeG9twduYRWVgeNvOW4Jip31els2KgD9JbfT5H6sg
         kE+bFwPf8v92jdBe7+bxKxpv7yTdCJ5IPmOYhsQEs9BA7E0ZNOOdgQZ5li94cEL1Noqa
         NPgQs4k8B5g49YiritREH8BzNzp0qU4rgSHk832YzzXtkCB+uiORTEdbSP6JYbbSSksZ
         c0pLqJSnh+QlU3kUQBohpyBO4P/QXd3JzxLXDOkSS24PG/rji8BlHYKLeiE1zBzPyqOe
         LLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724235966; x=1724840766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lr3fWsg1+KHj57spoBkvDMc7FLWUNMPanVJOyFPAj14=;
        b=j0JuvCfNDs0/ClfsAZOtRv54H0kT+Yx9+tac0n6v1BS55bkW8YU5SjgZ2uzieotULa
         84Wu/LGdyW2iC8TSY0J8wl1VLseDIazjau4o8Z/sVOpbjKWORGNnhZkR0+D6k9xVDCXl
         xVqJ/D0FOevV+bBL8uCNxZlTKxVm5MpQ4aXKCtJgfSiPHJ2IJQJmcN8NcDJDoHK1oqn/
         zewGjjkWFajOXniV2I3OTLGBAD1/DPWWPVFYITPltY4kuPW4ZKvB2Acgp2+pKXHRdRd4
         TFPb9PyZJsR8MrOzzep5tngfRNL5xeNiPJ13wHhS8RqR9BV53nnzT+XmOUbOfJlpeNvr
         rLXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWk8L+vyUpZ5cSJ44gKmR8A+yf8n6EidJiqIiWA3nNJHJnme35mHOsF6lfjK08aRNkM218peeifUAzmL5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2rc6g8UzdmyamQFy7sw/qhg+e5GtgZ9uEOFu7bq1wBWfuUFWC
	bhoGXPw670ZRSM8Tms7Km6EnEXxUmQuiJDFbU4f4Txr/tr1Gl/RjMwLyjvBHh2o=
X-Google-Smtp-Source: AGHT+IFE9DDiTWfHEqN6SuGGKYnmlDYPMOyf2r32jVYUDs1QI2EmwGPFKQJxc/gUX9mm8Yke/5LOZA==
X-Received: by 2002:a17:907:2da5:b0:a7a:a5ed:43c3 with SMTP id a640c23a62f3a-a866f10a0bbmr67188366b.2.1724235966210;
        Wed, 21 Aug 2024 03:26:06 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c68f2sm879613166b.2.2024.08.21.03.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 03:26:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] qcom: MAINTAINERS: add linux-msm IRC on OFTC
Date: Wed, 21 Aug 2024 12:26:02 +0200
Message-ID: <20240821102602.134216-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm SoC community gathers in #linux-msm channel on OFTC, so mention
it in the maintainer entries.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7cb909ffa1d..8b8dc4be96e4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2776,6 +2776,7 @@ F:	arch/arm64/boot/dts/qcom/sdm845-cheza*
 
 ARM/QUALCOMM MAILING LIST
 L:	linux-arm-msm@vger.kernel.org
+C:	irc://irc.oftc.net/linux-msm
 F:	Documentation/devicetree/bindings/*/qcom*
 F:	Documentation/devicetree/bindings/soc/qcom/
 F:	arch/arm/boot/dts/qcom/
@@ -2817,6 +2818,7 @@ M:	Bjorn Andersson <andersson@kernel.org>
 M:	Konrad Dybcio <konradybcio@kernel.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+C:	irc://irc.oftc.net/linux-msm
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git
 F:	Documentation/devicetree/bindings/arm/qcom-soc.yaml
 F:	Documentation/devicetree/bindings/arm/qcom.yaml
@@ -18156,6 +18158,7 @@ PIN CONTROLLER - QUALCOMM
 M:	Bjorn Andersson <andersson@kernel.org>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+C:	irc://irc.oftc.net/linux-msm
 F:	Documentation/devicetree/bindings/pinctrl/qcom,*
 F:	drivers/pinctrl/qcom/
 
-- 
2.43.0


