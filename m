Return-Path: <linux-kernel+bounces-556858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDB6A5CF92
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 20:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F01EF1759D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 19:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A65E264612;
	Tue, 11 Mar 2025 19:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQG9Xq9E"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D39263F49
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 19:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721927; cv=none; b=MgoStfMnVFUDO6C3qDposz4jXRHYyii1uwhRYxNvnL//kuvSj0PCyc4jy2RnqCiAwFLEeju3kbzgi0HchxqHd10A/J6+a5KhyrznK2yfN6KwlP48XuQX2fPzl4MCgttqkPPy6Vat5+GXp+qJTURQqUoIGOGidNSnPcetNnhLFoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721927; c=relaxed/simple;
	bh=B1uh6rYksykV9cmassOV5zLeR8dCezQN4Xwwx+1rMT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urcg7fOOCokhV5zOEAZKilT66GXi1hu6x04SPgKWCs/HZnDmFcCU+te5tpMrg2LEuDxdIV0Erwo+WsHNuDKavErrP+1Cd/fnuSYJWgJIPT/d+sowuelnYNQRYtqNr6kRVvTZes1tR/LxqlkJDX67QIvAZPz63F5SVn9647r9jMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fQG9Xq9E; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cf861f936so2892895e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 12:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741721923; x=1742326723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hk8/jRHxFdOn9j6NilUq3fYq1U2KDGu3FX6e3aC3Pvk=;
        b=fQG9Xq9Ec3q3EaxbKAjirOsEhIOKcVuAn5acIoCjjGiTx+Y8KSrJipiaMMHh9M0+eK
         o6GH/s7IYsroeALZLhWzVpr0idJz2+Y2nQgsl05OoHgTIlPVD9c1I/d8GK3ZGu9YZFOd
         SPj9o1g3b1UubQpe05ysJN2Y2G7koucdyf3pPmDf7MR33LMHEdiUtElRb24GfMcwrmXE
         OM0LtjMwPErWkSAeevEDusdBLro8LRFlXJJ6XLC+TI4l8s+FLPvOfWFK7FeXvcFpftzC
         1jJoInrUv2PTnU6bIcbz6EW22l1OUIE/LZnFjW3ilqxfCpISG+TocmYh8DXB+hhZ0Iab
         lSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741721923; x=1742326723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hk8/jRHxFdOn9j6NilUq3fYq1U2KDGu3FX6e3aC3Pvk=;
        b=RqIMCRn3ns5TFUDNDW6SuaIxADqLAGmf8c73HFGESk60lLzihYPXTq/aYtTb8v49oH
         QEgjnTl11jxdjm2ZBnqiu8k5FMYg5s0/a18faj0h1MZ/zanL877iNUuEspxUca+fDfvp
         0RBUxlatxBiU/BkbLLS2rlS3hF9Zoivzg0x68Tn5kulav2b5e4JsklrFtfCw4RoyNkEp
         J9gVf6J2nM+e9iuQigD+mMOgGSvWiev3qr8+YcGUemZ4gvF+CdmFZZWbeM/bt8UWa8oK
         Z7pGHA4GRMr3ktvJoXzuAqcu3Csaw8NU/L4TYPMKcsb/xssxz+ZreItEHaz2WKqwviCY
         KIkA==
X-Forwarded-Encrypted: i=1; AJvYcCX9jF3UiSO4pY4HW7hXfsvAazC2GNV3aFCgA+jiRnfNkTlPz4OH7wg3yTib1YUFp0RduuTs17pFG5gdoOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFb94cn3qVN3m9FFpayb+IN684u+mKajWJnD39hiH68cxQ0WNC
	J0dZ+SC07WfzggI34+o/Nr+C9HG+w/qMufkIWIFWcmtCj7+g+727sJhY5yzXnTM=
X-Gm-Gg: ASbGnctyDgRMRcAP6DRrEAt87HFYlawqHZYae5J6GOdM+c3jgRO+OWHrYwJfghpqc0F
	hw9H1LqXuSsWrh0tzs+kgom5jve+7kxvXg27hCj+AN5nV7nLvKNjzPyRE83gTrjON9nO9SHZfRf
	vcywBhLIsSlzOg8N4n2hxAmK7d0HJ78DtqrbKFFH/EczZSUBM9K+oANF6s1Nh47JlcLO8SQrm16
	wgigGs5Bu0KtiqNYK5XeCGQx0uxSMIo+nUNT0+Iia287aVEu2zDn0l1IvdlTQ8cm3n2QBLlFRXQ
	JX+qm18bHhdc5HyL0u0w5wbERQdLy7c/XJ4pG8qbpMHvSzcZmISW9Adh8g==
X-Google-Smtp-Source: AGHT+IEEGrtv+WVqplhsyAIOJvjlmuBCpHGGUDzZq6EETtMUE4CHGK002+5IMzV1Oj/aRdFt9ZT1FA==
X-Received: by 2002:a05:600c:548c:b0:439:8294:2115 with SMTP id 5b1f17b1804b1-43d01c2b40bmr22475345e9.8.1741721922987;
        Tue, 11 Mar 2025 12:38:42 -0700 (PDT)
Received: from krzk-bin.. ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43cf892d380sm81727225e9.24.2025.03.11.12.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 12:38:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andre.draszik@linaro.org,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	kernel-team@android.com,
	jaewon02.kim@samsung.com,
	stable@vger.kernel.org
Subject: Re: (subset) [PATCH v4 1/4] pinctrl: samsung: add support for eint_fltcon_offset
Date: Tue, 11 Mar 2025 20:38:38 +0100
Message-ID: <174172189759.119514.8325135286672051459.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307-pinctrl-fltcon-suspend-v4-1-2d775e486036@linaro.org>
References: <20250307-pinctrl-fltcon-suspend-v4-0-2d775e486036@linaro.org> <20250307-pinctrl-fltcon-suspend-v4-1-2d775e486036@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 07 Mar 2025 10:29:05 +0000, Peter Griffin wrote:
> On gs101 SoC the fltcon0 (filter configuration 0) offset
> isn't at a fixed offset like previous SoCs as the fltcon1
> register only exists when there are more than 4 pins in the
> bank.
> 
> Add a eint_fltcon_offset and new GS101_PIN_BANK_EINT*
> macros that take an additional fltcon_offs variable.
> 
> [...]


Re-wrapped commit msg to match wrapping style.

Applied, thanks!

[1/4] pinctrl: samsung: add support for eint_fltcon_offset
      https://git.kernel.org/pinctrl/samsung/c/701d0e910955627734917c3587258aa7e73068bb

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

