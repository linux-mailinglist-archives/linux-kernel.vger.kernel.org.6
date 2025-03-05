Return-Path: <linux-kernel+bounces-547573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE0BA50AFB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 126581881FFA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40960253326;
	Wed,  5 Mar 2025 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RQVgtHsZ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59162512EB
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741201558; cv=none; b=qJWI26RjmNtqSSIfGEOCOaq8G7lAI7eacZifyY8RwzqjKPd8L3fEV/Hn+qUkkWrupSOJFo2vPPImT8dmSL5eYsAwLh8WZOU9bSsMFbRmTwI9ECrEf/5/xBQphYcScAo0HoEVetq3kiIs8pcE5QI0uFqykOvaLtU8Dz2ziFwC5Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741201558; c=relaxed/simple;
	bh=k657FxCWzDpdSCjqG1OpdeS9FGRaWIIzPSLgP8iEB8U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nZZdPkOCC7M4tV4OklJK0D58TooybnWTMkxLf6X6A8/5LxbktPdsNeh9Ei8yQO2oUaJICSj0MeUpSUy6TvqhAz1k88TaQ1zHIHRXecq766gRUluetCG7o69o141T0LCsqwOYAwCPP8n2Ld4FQuxrYuOq15UbH8vK0wpfuY3zGMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RQVgtHsZ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43bca8cabc8so3332795e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741201555; x=1741806355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXwlkhSlbVtwXogPWWcb08IskVMbUMqFwrxRMdg6+Ow=;
        b=RQVgtHsZDjG8c4C/5yd7aPX+D5oNCtBX3uN7//eE6rIs4/3W6U+inhwcriB7y+x9X3
         pHfw56hvP1FHgzRLyHBJ6VaxEL31PheSI34E3wVkg8qfU7xDpbg1kbNCPHi6ZZbMgsCK
         nlfz7S4D7FJSp856HeiKI5S8lF3yAWRxIQKhvKhP1Uhi+0sQXSKRgWptRlRUzXd6z6t0
         sUJyI8PKtF8g4kDdG2Bfl8EYzeN2sOzFpkHH0DUzc/9HlU9fxYb4fv2DolHvkmdkKX9V
         Bzsl4Efqh24PCYORYaMM6KP2HtM9bmgMLxYwjc/JeYQTvOnMaMzSsyGwaI8j0bpjaEjg
         bwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741201555; x=1741806355;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXwlkhSlbVtwXogPWWcb08IskVMbUMqFwrxRMdg6+Ow=;
        b=HxarpvvkHZXLe5rdL2/mNJiDpxI7vh4vNZzNm64xRB7+C33CUiCRETmaoOrbqXasu7
         cuU8krHRdI6ICoQbzwzGUWhRwz9gA9qJWXrC2FZpRZuQHXrCA1I35VcZOQADwhtZWN2L
         k5MYMmFkVQXGXdOM31Lh7VuQmHW+GULQ6SkwWU+9cGdlP8+mG6+C89aXh0hKxflt57yl
         y+xmGbKonveRDHLtjh3aF/91RIfvy4eCxB/8hVq8xPX7hroGZROFkK82NGuvPEspqH87
         HmPSdV8XqEjFrBeBq32urNft14CYkh/GZjsDp7tbhD6Vlq195Ay52REKILoQ+s2n2zSE
         ng5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpIKXpuYzPCheBwjzyJo5sCLVDpOkmbfErWS1984kKETaM8NoHwa2vhle4VEJHallS3HhS0eiRoqTH838=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT9OK7yMfbJ2l8bL5SGIW55+jNBREu5XJ2InVMbeuKouZqbHvh
	PjAhRBUFpOgNQsc+z7VHkkhkUzx8dQvm9527VTOhC4tCzkN57VDz8to6dqvz5w0=
X-Gm-Gg: ASbGncuw4hYulHAUU8ilIWypOGN2fLMIDMar20anmsqiSvMpNNDYAcT8an+iHObm8Il
	aBUSn4/HsmpN1Ijh38hw9nS4PKQedKYafQ4owiWU3niFCqnd0QzEp2tJgWZInYiTJaSZOwifbzQ
	XEj31Vixj5EBlFK2s1+kJDZAg0qm7rj9YICDJ5V+I6/UgPst0EnzUMPT/5i5izfc0NBTW+01Ecq
	9sg2JqKjWYLud+++3rSQKNh1Fmv8AzhF6QjqMm00AN5f9wRq+Xo9cv9wiG4y3OFP4MsgxhiCA/G
	SXvfYZaL9oVlFFZ2OKtsvtUO+WTQDXLWRJIKATTkVdT0nd+R9HfH3ayD+2Dq
X-Google-Smtp-Source: AGHT+IE3IjJeSMhwhYFQVkJODS8A0V92GzgNUXihhvb00RZvzc5AMKy+de2oOq6U0u17cQDNCmp+YA==
X-Received: by 2002:a5d:5391:0:b0:391:2886:d9bd with SMTP id ffacd0b85a97d-3912886dbaamr319116f8f.3.1741201553557;
        Wed, 05 Mar 2025 11:05:53 -0800 (PST)
Received: from [127.0.1.1] ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47965e8sm21491662f8f.1.2025.03.05.11.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:05:53 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
In-Reply-To: <20250301-exynos7870-v4-1-2925537f9b2a@disroot.org>
References: <20250301-exynos7870-v4-0-2925537f9b2a@disroot.org>
 <20250301-exynos7870-v4-1-2925537f9b2a@disroot.org>
Subject: Re: (subset) [PATCH v4 1/7] dt-bindings: soc: samsung: exynos-pmu:
 add exynos7870-pmu compatible
Message-Id: <174120155027.74217.562001377328469243.b4-ty@linaro.org>
Date: Wed, 05 Mar 2025 20:05:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 01 Mar 2025 01:16:49 +0530, Kaustabh Chakraborty wrote:
> Document the compatible string for the Exynos7870 PMU. It's compatible
> with the Exynos7 PMU design. It handles syscon reboot, syscon reboot mode,
> as well as other system control registers (i.e registers for the USB PHY).
> 
> 

Applied, thanks!

[1/7] dt-bindings: soc: samsung: exynos-pmu: add exynos7870-pmu compatible
      https://git.kernel.org/krzk/linux/c/bf869ecfb8d3d0fef07ed2752df93c977cc257b6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


