Return-Path: <linux-kernel+bounces-265741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2E093F572
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B2C282F3C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8294A148829;
	Mon, 29 Jul 2024 12:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RA1Vd/YF"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AE5144D10
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722256276; cv=none; b=FVCZskR9BLwPi1jGK1urVqAXQQUq8MH9ZMLFYxrTEAn+/bIY2W798bzf5nwvJvK3fe16Z8ANITndG/wiEH39Cyi27QIpEqgUUNijsYPyCRXVybDV8TYDiXfHQpmJ550vJapEc0jEaXzhpL0a5hW9qA37N8nQ7+zflaVxtAqvvg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722256276; c=relaxed/simple;
	bh=1MJdqvR4l66CFymtTigURAQi+Ak55GLMbQ2E/5ReGDM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=M72PMt9IITMXMFlDSlp9JOnF3zjakDDB49fFGg7gqJYfjRZzGjivTeUhfxOwRHcS+11lOgVij9OvzgaH0NP9y4KWcq0I2yM+RV2WoB4m4lNZMNxhMOmXZB7ZhJSXxuevWKpQhi6XGFhUPeIy7y5UfOY3uvX8ePrm3asJdsd4fqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RA1Vd/YF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7a94478a4eso701302366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 05:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722256274; x=1722861074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aXEWCd7FqpXeUoPV5fLPpv01DhdKsxKfAinrkombeok=;
        b=RA1Vd/YFLsDhjZBh4ET3F2CyuWwWNz+nVsbtGY9VzzsPOqGIxYFBE4yg9ekUGV10OS
         DHALFcbESjfOHJTwAfyn3qiM3HSLbe1/Hyzzel3YmaZY403Zdee9aVruysamQx3DMC1l
         ta0cgLR3minX/JIB7JyKhcgIu0rfWcrW5wvMW8bkdyHMqI4GOTf5N5Eo5z0acMLAP6W8
         4p9DhWrCNfRrcVt/5O/4UtSGBxUEz/p1xnm9kUZOF6Df26uuLGEulyodywkpU40QH5Y6
         e1l/9cr5WgJkiDgG8IRGq0tl6Khxzn5yLT5pPh5i5w3N+qyYlx56LTqEHD4YcxWotjdK
         uZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722256274; x=1722861074;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aXEWCd7FqpXeUoPV5fLPpv01DhdKsxKfAinrkombeok=;
        b=g9HYaQOt1Hl8cky2mpGLzkR9fhODBiHloZzNd35WSWPTpqjjxRBBYFdj1OPtHtPLO5
         wxe6EZ7A//NxuZMhjLgYyhooUIUiX0+tWdEJe3JH+p93d+NJ1JRzYulRPIS0OJLblcYx
         aj2CQePpLC/5s9cskvLQEf8It2iyWMYA6Gi2y+2vb40eOVQ1TiTwAkICWX3wmCPwcHol
         rC8jroC631nPSidSSVT5F5zDtIloDXNhvSXHaHxFYf47lbx0nFywrl5tl8HeH206hGx1
         ECreDd/iHLrt2Bec8Ll9m84bWnhUow2gS5zBnnH4d3u8ecJiLAuRp4fhpvw1AMt4DS07
         DRfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL4T+15pvEOWHVox1EfSziHLcDp+uheEgqsqT86xNmvIxVUmPNW5x8FDZhiFmubAdlHe5LtO6vc6n654pVyqPSDg8PxoevspVgZWMz
X-Gm-Message-State: AOJu0YxDN8ql1xu/9KJO5Jtx2skpjlh/bKc/QqhbXVWWkpB69+vGp7e5
	7oRMrxROMW28Jm40+1eVXBw0lpx8Aigv9GJ4coIVBSn7a/qNmCTQ3jTEdlbMxiM=
X-Google-Smtp-Source: AGHT+IEcCCNjVqMjw+SlV2NGC1JBsZBQwl83wS/81hnJwhDhzkYKop8654LkJwHocVtqfIz4Gw4IXg==
X-Received: by 2002:a17:907:1c19:b0:a6f:e03a:99d with SMTP id a640c23a62f3a-a7d3f514a03mr869934766b.0.1722256273697;
        Mon, 29 Jul 2024 05:31:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab22ff1sm501973966b.35.2024.07.29.05.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 05:31:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 alim.akhtar@samsung.com, s.nawrocki@samsung.com, cw00.choi@samsung.com, 
 mturquette@baylibre.com, sboyd@kernel.org, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, tudor.ambarus@linaro.org, 
 andre.draszik@linaro.org, kernel-team@android.com, willmcvicker@google.com, 
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
In-Reply-To: <20240628223506.1237523-3-peter.griffin@linaro.org>
References: <20240628223506.1237523-1-peter.griffin@linaro.org>
 <20240628223506.1237523-3-peter.griffin@linaro.org>
Subject: Re: (subset) [PATCH v2 1/3] arm64: dts: exynos: gs101: add
 syscon-poweroff and syscon-reboot nodes
Message-Id: <172225627208.280610.7893124858038384866.b4-ty@linaro.org>
Date: Mon, 29 Jul 2024 14:31:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 28 Jun 2024 23:35:04 +0100, Peter Griffin wrote:
> Reboot of gs101 SoC can be handled by setting the
> bit(SWRESET_SYSTEM[1]) of SYSTEM_CONFIGURATION register(PMU + 0x3a00).
> 
> Poweroff of gs101 SoC can be handled by setting bit(DATA[8]) of
> PAD_CTRL_PWR_HOLD register (PMU + 0x3e9c).
> 
> Tested using "reboot" and "poweroff -p" commands.
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: exynos: gs101: add syscon-poweroff and syscon-reboot nodes
      https://git.kernel.org/krzk/linux/c/2d0c7ae784b487343b4813db9cb133ca51c674c3

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


