Return-Path: <linux-kernel+bounces-369511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 279729A1E3E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603CD1C26A66
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 09:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58A21D89F7;
	Thu, 17 Oct 2024 09:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lFbfvjzu"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FA61D88C1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 09:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729157177; cv=none; b=KQtZ0U66V3n+Vm4f/pOOzrnPU0pOSoO0F5dT4Mb/R7cpqA6xbYqtL92aanS/AVA5KszQOt5VG3e71+92fkAw5Rkf+ubjQzTU/vdSBvEU2Hqw0nWL4Sjk9XEaSDt7So0iS/J1Ksyy40QjcDTW0N9q5MYys1/w/Y+scW02sPyrTGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729157177; c=relaxed/simple;
	bh=3LziUkpGNIhFW55U6jvI4l+L7hcBt5ps7U1v7+ZnWE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntHR08Empl7GqWOwpLHOw75JN4dXzvCN3zLym2CkVQwHbI/WW4h11o73aaLLPK1ChGPRyErYE8R30vHB30LKnPaJSB6jRPUllGNwe2v4PODt9Ww1pKRJrzjDBIBtHBkJVIj2ihSzvOYqR7SB/iI2fyd5kSapia4tDRNFo/kPTw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lFbfvjzu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d4ee8d15aso82398f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 02:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729157171; x=1729761971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKRTLaQgO/TM93Yyvkgu4VGnv97Xsi7IUB1bI/d1ppA=;
        b=lFbfvjzud7AeNEtMf07QbfItFsdr2hictm+jwqLUD/roLUfLzqsKH54d35ZcZFW7jm
         SugSo2+I7PpSc/6YAR/CojrFHGyc9uARbvFH1h7HzYXPZX4jAGhKvYgfPqdkrSxIDNDi
         UItMhZYmGrBsZo0N7oBa1WpB8SrEC5guZjHcCG2d2DXHH0yB/OJBnlrQ1M+XE28yc5/r
         7t4gp6Fpy7r55KeZmxP9joHQk8hUTT/hDwmh3tFYSZWOqt7YeYYyRXBGvIicrY0/dAAz
         mtQEO/F8X7AVGTIk4Tu8OEbQ7wwjkeoOr8PQilwtDCV0TeAsjllHuPd1xKHC6Iz8QAhc
         a7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729157171; x=1729761971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKRTLaQgO/TM93Yyvkgu4VGnv97Xsi7IUB1bI/d1ppA=;
        b=YaQjib3egvhIePVloc94BgtNM8ehlrWNvbUxaCfXp7HEYaIrISwYWIu2qEFWmofJNf
         vELhABm0J1bCR9oAY2yxVSY5NEEZGyTAGKs8OxHrNPsvcW+H6BgB2xovRHCOX6irUR+F
         Qman5+fWEZfODxjAbRadmpZwNDcKGSK0HOR72r3lpk8YT+vbaLzQhDihsmjw7AdAw4Sd
         KRRbNSGJxr5i+UfAnDI/yQ5OpYh3KXJuqpP9gpUNXG7q1OlQ/WAJAwBbchO67cJWf86/
         9f/esvQiRH63lMDeUErcccOeNO71HuOJNI06tZr6Tv5+2SsrQ85Ha38gWk3cufRcgqoD
         oEDw==
X-Forwarded-Encrypted: i=1; AJvYcCXtFJh2LO1pzIBnnv5KGVidJlJJ6idNbt1Y1s1cZqV4Jxfylpwh63L/YAwlZgnPUnNsjCQ4OBoxdhano20=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSuvtyv8zlVmK1YC+EXtBAuSfRg8RJ7xGPjp3ks0BFlp1z7gZb
	X1oZxPlafz7N2/tEQDE8KAA3bVaLK1ePMwhwH2HgVOSzqGi7Ujy6ge1/UAORh1M=
X-Google-Smtp-Source: AGHT+IH+1FFMQXSkaxdSxuGBb7V+JV0JImK9YzOxutCNXeTuZ9qFf9RlGrNqx2QrK3J03IFumUdDeg==
X-Received: by 2002:a05:6000:4024:b0:37d:50a3:f34d with SMTP id ffacd0b85a97d-37d9322e239mr801272f8f.0.1729157171549;
        Thu, 17 Oct 2024 02:26:11 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a173sm6612920f8f.15.2024.10.17.02.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 02:26:11 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: (subset) [PATCH v3 2/3] dt-bindings: pinctrl: samsung: add exynos990-wakeup-eint compatible
Date: Thu, 17 Oct 2024 11:26:08 +0200
Message-ID: <172915712848.42336.1934974031781144072.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016154838.64515-3-igor.belwon@mentallysanemainliners.org>
References: <20241016154838.64515-1-igor.belwon@mentallysanemainliners.org> <20241016154838.64515-3-igor.belwon@mentallysanemainliners.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 16 Oct 2024 17:48:37 +0200, Igor Belwon wrote:
> Add a dedicated compatible for the exynos990-wakeup-eint node.
> This SoC pin controller does not mux interrupts. It's compatible with
> Exynos 850's node, while also being compatible with the Exynos7
> fallback.
> 
> 

Applied, thanks!

[2/3] dt-bindings: pinctrl: samsung: add exynos990-wakeup-eint compatible
      https://git.kernel.org/pinctrl/samsung/c/e690012f4f924f4ef4e105427b04ea3d496c6a38

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

