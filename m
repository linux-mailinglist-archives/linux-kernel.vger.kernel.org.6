Return-Path: <linux-kernel+bounces-347125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDAD398CE30
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99DB91F2356A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0846F194A75;
	Wed,  2 Oct 2024 07:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NFJATCPJ"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398731946B4
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727855765; cv=none; b=bVOfy3Pjtl71m8FcercRHXj/YnXYZUhYqcYNS8PiNWM2SOBvUOXM7oKsJ6KOsk/Tfi0b4Md+r1T8zGO+JqEfaW3ISuTpq65G/Vf6LlRQJcrKfJW4zybvNfrgu4dkiX8qsrcUUeSxTzUqfmxqPZ5euPvT9dx4P3Y16kBq6PoFgBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727855765; c=relaxed/simple;
	bh=QPtFPt6NYZzis4jUXMlkMukNzRyEbl1mxWcXb3SSyo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgoOHZiBD/E5ymn/xAypQbN5EGRfYabj8tz02Xo09EJjHep+pWg87hqsum7HlfXSe8e5M5TIgcLz678LLFjUekzVpIEKBUJoQcjwp+DaFwC6uOmzzT+we5nH4CUG71p6vozPwNHsiTB7VptoVIDpxskmiz8GYFzF3/bGxcoqYb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NFJATCPJ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb3c6c353so8711845e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 00:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727855761; x=1728460561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvQYpxRt+zIL1np82qu/5R6zXQ+gzTM+HqKYMpnVAmE=;
        b=NFJATCPJva5xJ6Mr0cOvRpI6fO0dngurIOaTkxW4O81a0yZKrQlKiehuexCTL4zMsx
         G3EQTwwWX9Act/9P6b2uxRmcEU9SOUNPFrvBB8JEP+reK/P97FDhu3WYYbSweU+KHX0Z
         x5HqKjfHJUz8ipPQ2RpzMh0++u+AYJVhCcQGmrAhuCAAymQ0Qhib7AH8alufM2ul1kkI
         fqrynek+je+yCe/5+XhHyAITEPPdW7oSF3eU3s28JJmTPTh5ylALRnX/0H7Irl4jMWCE
         btbhxPtL0pG4T6pVDKY1C1pJfFRFc2gJkMW46duDXPfuzLwdYsBw/FSso9dqgsFpcH28
         Kdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727855761; x=1728460561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvQYpxRt+zIL1np82qu/5R6zXQ+gzTM+HqKYMpnVAmE=;
        b=Wj4hSuymi6EauDoxCuvGj76KqD+gKDkncEqFsAgCzbcpmz5ftO8on3P5cjheFwBEDm
         BYRqLbPkWetZFKHsrY7lXkd+BtknHMO6eRxbBeC9ZNR9gZdankNpXcazxBv1+tsieAQ5
         fEHbXTUyfFe6Kb1EJMRKV4THFzBUXyHlCzMzzPGsYSLN6vRPll925E22igErEJYS0wA5
         wCmiaPBbVPhJZMECtJLb/411yXrGIzHRrOZlaOgcbb+ns99RdxaUetxE4CXel9aUK3Zt
         YTUpsXF8Oz7CyNgDf4D9YibNVXU+oOA+yYUXsK9+AtxUPS1ZzjARW+z0qLSpalMfvqGQ
         WdbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjJTFrY9AQQY+d3ZAjCmUGooo2J+PphKKuUMx0TPYJjLmXayzcaZN1RY4WRG267lK3cxMEoQ2+b1OEfR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmkJ2Zee5Fyx0n6wNPICevP/oqM/N2aFljyYM5Ho2beZmm7mdW
	ROw+YAgqz0iLC5ESJ2x7/SWgMZBoMN16j9KMIvcN/5Suxm5xhZfnnfn1xiDlRrY=
X-Google-Smtp-Source: AGHT+IEp+k6HsOdJMNwTyAoSoy06RFFW0zOrJ3MU1/yCtGGKvQXyJIrEpLa/tqt/YznVu0Nyw0zCdg==
X-Received: by 2002:a05:600c:3b87:b0:42c:baba:13cb with SMTP id 5b1f17b1804b1-42f777affd4mr6894775e9.2.1727855761506;
        Wed, 02 Oct 2024 00:56:01 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f7a01f52csm11176545e9.37.2024.10.02.00.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 00:56:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v5 05/10] pinctrl: samsung: Add exynos8895 SoC pinctrl configuration
Date: Wed,  2 Oct 2024 09:55:53 +0200
Message-ID: <172785575197.22593.7689853174509916691.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920154508.1618410-6-ivo.ivanov.ivanov1@gmail.com>
References: <20240920154508.1618410-1-ivo.ivanov.ivanov1@gmail.com> <20240920154508.1618410-6-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 20 Sep 2024 18:45:03 +0300, Ivaylo Ivanov wrote:
> Add support for the pin-controller found on the Exynos8895 SoC
> used in Samsung Galaxy S8 and S8 Plus phones.
> 
> It has a newly applied pinctrl register layer for FSYS0 with a
> different bank type offset that consists of the following bit
> fields:
> 
> [...]

Applied, thanks!

[05/10] pinctrl: samsung: Add exynos8895 SoC pinctrl configuration
        https://git.kernel.org/pinctrl/samsung/c/eed2e79221e2b4a1d1469aa522f658889cd640ee

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

