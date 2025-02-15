Return-Path: <linux-kernel+bounces-516240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5C8A36E9C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 14:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D646C16D971
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 13:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7011DB15B;
	Sat, 15 Feb 2025 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wtRd1PZg"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E461C6FE4
	for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 13:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739626979; cv=none; b=Vrj/wOKHzTm/bZNZ/M1aVy7SL3WlWiNgdIHqR+Azu4199lLTtakwmx+1aw2AQABzM1SJaPFvpUzjoCjU7/txddKKRKhES9hwjX0LkmuND+bPPC5/7LdtAklIWCMG7+wOtHyPZSelxwLCrwUCRyiD5Gn1C1cr5cRnXYLFiekQr+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739626979; c=relaxed/simple;
	bh=B5G7i3ixrYG9/fNbWmw5bNg42KOUv3/6jvQJNxtOKiI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KDLBNvPWETNRSUURJZFKSd7xZViBXftSmjm8VAwHshyI078E6OmnCIrBBlO4b/uvga1h6lrB6bGnX+CkuwYi3ALPN/Toyb1EJNnnegtqK//B707PfMcPKuVZM0zYtgW74udoVv9SPjEeJ53CMl64RyRdTaWUcTxNYq5hS4+iM24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wtRd1PZg; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f333c5d35so119632f8f.0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2025 05:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739626975; x=1740231775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bzb9KoEVAxpceRAqAhOtXPFddy5YM0ujKSt02fGNR/I=;
        b=wtRd1PZgmsyreHIrgo3S84qyMn71Dx1kQ9tkOsJ/TsnRimIrn84ihavQ65v2BWfZWe
         8yqEcYXSnNVau1S8pz3e3ZZjfIM4qcwIbQX7E6syiiI9v2UBkLMR73yPav9eUrDjON0K
         AVLQUz78R6hBH2JWfOVoCQtpQvn9KTVKETFkNZ8GvssRGmtUjyQ/ZtDGIlMx0wk1+T/K
         uX0btv+slYZI5DK7pyg6SVKP8RN5uh3V+iOY343rDxsCEjtZT53ed1rRsXq3e9PW7ZJu
         Yg1pfVBOmhHdlJS+6mZarfJ3gAE0QB838HQL6gziTGAWO1MR8Ml7Nd6lcq5nQ0Q8URIi
         rJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739626975; x=1740231775;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bzb9KoEVAxpceRAqAhOtXPFddy5YM0ujKSt02fGNR/I=;
        b=lGu7BdQO7L9vNORywunGN1Bq79mG8kPd3ewijGDCAxly1bwaXIRCdhPL2RHJK+TYEM
         k5PNcn1rG8rhceaUU/fQ3uwqB82qVNbftJn+W5HB6OAxoEja+9dOeQxmKOG0QcBgtf7B
         0/+vDCDCYKi1x9OZ4LCys0HjMk+cq1L13aO6laWv8Z5/uyJqp9tfe7n1+zCKgehteu+6
         KPkbxsIeZq+VeysgmoXNusg7fgBRJtTNurV8va4hKDL2LM8a+Dgd/+tUXQ/SaV3VziwO
         wbjJIDh6PpB2JfqskUbcZ0C7x6c5Wa7r9c7fhgVlQsiZhz2hsEuhkaOW8xE1JkYCe1+u
         A11w==
X-Forwarded-Encrypted: i=1; AJvYcCXS1D+LlVhxP45s2+zBnnoTQ/ZsQxMJGmHkq9YRyKvXd5adI0Uh5pQTa/7U6LsJK6EUv7UdfAt6U/z4ZJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3AAZihgiLLLaibHl1zlO0cTO5O6hMYS9lSuHAqSe0fq9WRy21
	b2P/+Yr7TT7HxKAGpj9ZwpzzhqexfLdynZkTT9s5l/WMG7XMkY39M7rRWSMmAoQ=
X-Gm-Gg: ASbGncuBOasJQyJk5A6u6R42CfiiQl+J83cFY2jXfJY05o/rCInH5IsU8BTDmsfgQ62
	6BQlr5QfK7P58lYkDxoV63EGYtL/g+TZNBHOqi3UQXlZfSxB9SGxtIazlIQGZykc67GcpKdfbj3
	OhyN1KdPvDRuzbNBqqDdz08fHMNTqg7OruVIC9IoDM2sDYbPsRifnkumwm45/HSzNoavdFBM955
	Ht5H/HlvLQ9q4jo6YUax+ZjhrW6F3+F29ew4m43T3sSzl+4iQ3q5JgKUOzkxyTqcs0ZiTYGFv4R
	c0PbiSEIUH8Z4f49F6a5FsXJGrrJZOY=
X-Google-Smtp-Source: AGHT+IGDxXB1E+X6jTSdESQDd36Tzc/wr84k6EKAU8sGUlvYMhjz/DzYT3hbSvKe0KicE5yIGLmyJQ==
X-Received: by 2002:a05:600c:3ba5:b0:439:5a37:814e with SMTP id 5b1f17b1804b1-4396e78789emr14566145e9.7.1739626974755;
        Sat, 15 Feb 2025 05:42:54 -0800 (PST)
Received: from [127.0.1.1] ([178.197.218.144])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4396181026fsm69929005e9.18.2025.02.15.05.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 05:42:54 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzk@kernel.org, alim.akhtar@samsung.com, richardcochran@gmail.com, 
 Chenyuan Yang <chenyuan0y@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <20250212213518.69432-1-chenyuan0y@gmail.com>
References: <20250212213518.69432-1-chenyuan0y@gmail.com>
Subject: Re: [PATCH] soc: samsung: exynos-chipid: Add NULL pointer check in
 exynos_chipid_probe()
Message-Id: <173962697359.235665.7938168679485045244.b4-ty@linaro.org>
Date: Sat, 15 Feb 2025 14:42:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 12 Feb 2025 15:35:18 -0600, Chenyuan Yang wrote:
> soc_dev_attr->revision could be NULL, thus,
> a pointer check is added to prevent potential NULL pointer dereference.
> This is similar to the fix in commit 3027e7b15b02
> ("ice: Fix some null pointer dereference issues in ice_ptp.c").
> 
> This issue is found by our static analysis tool.
> 
> [...]

Applied, thanks!

[1/1] soc: samsung: exynos-chipid: Add NULL pointer check in exynos_chipid_probe()
      https://git.kernel.org/krzk/linux/c/c8222ef6cf29dd7cad21643228f96535cc02b327

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


