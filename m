Return-Path: <linux-kernel+bounces-298405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E878295C6D5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E6311F27502
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764B4136E2E;
	Fri, 23 Aug 2024 07:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B8wNaoWa"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD13D13C9D9
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398973; cv=none; b=A+EzJEbGc0F+06TTLHO0ggNoXUmB14I8cFY0+c9oBPrX1Oyblz6+YDdb8CiYNFdIgGiJC/vu8KHknQ0IZHu/BYomldfbkHF+oqSfrQZobmiLPtu5AYL/LRS1Xyxxlm5DPr8Qb4a8ni7sZK8Ekh2THE3jDKNvixDI332HNqD/YLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398973; c=relaxed/simple;
	bh=YGXtqEXLuxTj4L3nv5xoL1tlsMlz54zSjodhYy2ZDYU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uVAbYngKu8/6v0FT3rvPIKkwrU8UiS30Cmc5/ok2GpQsQvrSDauFvK32sT+kPiaNbJ5w9MS93aZbit2DA6UcFST4iqRR2Vrg/8XDbsSOlgAm+nd/lgY3Qn44QEIGEdgDQb1ou9amynXQdrfY/soS5/H9sAMPz3o1aFDChr2DNTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=B8wNaoWa; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3718cea0693so65860f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724398970; x=1725003770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UWGduNs2rm5qHwk5ddptW98pyWVss8YO6iqSSyBnt4g=;
        b=B8wNaoWaChJZqjZs6iIfk0GfkKdl4ey+3gV5rzJmztnF2NPSMqnHXcGNs+qUYFCz6b
         /RClRLwQ96MJqklUXpX7SfLEsxAvFARJ2XN/wulzVOjHT4ryyL/7lmXPKtYbe4vHQpdo
         JMXwqglPt/oO6d0mkDKZiIRoem0kkjvdT/7q9r5EcjMV30ASK+6QQjjAPVPU+EdK4CcE
         AnRl1s3QGs2VphwDNT1mNvhcaCtE0WmmOqFOr8FgbWN8728HGBmXtsJDbRMu/loY7Z8m
         UzZCcW9MdfJdubSVmkA0BCyJ5ZYN4IURggTtqqKcDdRw18voUf5iI8FYNLxUwATydPEP
         LsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724398970; x=1725003770;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UWGduNs2rm5qHwk5ddptW98pyWVss8YO6iqSSyBnt4g=;
        b=FMAE57uiWq5YO1afJtoul5sCaFAa2GtNP2JYtQBqLm26tqICMiaLoFa1Al/rYwK4hR
         BlNrs/tXpktLfVPj36SlKGdMgoEjTdO0nom9HtMZLYs+cp6Xb3FnTNI82vgDO/AJIuVP
         E6Gp9Ob+DkxGwLOF3aIUAD1vRPuB0BSFnbpVY9UFu3wlb06k2ByZZkj1TB2K0O6sWv/y
         Jm5FexKdIP2xdiJmXoAjlPk+Pgvp8qNxyFwEmGYZfSb1QjvV1sOjw3ahMVmpFBaYk7iM
         du9vFo61vYOdNLmTQX/sD5EKaFvuQ/MJMhKf2oL8Bqr4OpN0c+mTQPkm6XLT6XPlKZfZ
         wbvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqY8DVg2jl9hB2J1f8qzZvqHxTPmZ2bc6ctFwktcoM6revia0XFpCYan3RA9ODzYcYdMWsmoozox9l24k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM3EIEsAbmFzzrgHlSbJI+VEgpe/4zlWx22G5Cgqs+3gvgXLoh
	xV6ldr9Rxwq3XJd+Mbow62KTzQwbmiJUwnW3vwGJ85om2zloJJb1iBtok6IiKfM=
X-Google-Smtp-Source: AGHT+IEJ93sKDaOo1SXjMAhBtHW9HFDHMZTFcxKf9M1sLtwwW1Yaqmgrgefwkq+7vfKzhnmdv6BhWw==
X-Received: by 2002:a5d:6daf:0:b0:362:4aac:8697 with SMTP id ffacd0b85a97d-373117c3298mr510253f8f.0.1724398970151;
        Fri, 23 Aug 2024 00:42:50 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081ff63esm3485541f8f.87.2024.08.23.00.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 00:42:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sunyeal Hong <sunyeal.hong@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240821232652.1077701-2-sunyeal.hong@samsung.com>
References: <20240821232652.1077701-1-sunyeal.hong@samsung.com>
 <CGME20240821232656epcas2p3c59f98d2bd185b8258096bf1597d75eb@epcas2p3.samsung.com>
 <20240821232652.1077701-2-sunyeal.hong@samsung.com>
Subject: Re: (subset) [PATCH v9 1/4] dt-bindings: clock: add ExynosAuto
 v920 SoC CMU bindings
Message-Id: <172439896878.16898.16710163487615295552.b4-ty@linaro.org>
Date: Fri, 23 Aug 2024 09:42:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Thu, 22 Aug 2024 08:26:49 +0900, Sunyeal Hong wrote:
> Add dt-schema for ExynosAuto v920 SoC clock controller.
> Add device tree clock binding definitions for below CMU blocks.
> 
> - CMU_TOP
> - CMU_PERIC0/1
> - CMU_MISC
> - CMU_HSI0/1
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: clock: add ExynosAuto v920 SoC CMU bindings
      https://git.kernel.org/krzk/linux/c/997daa8de64ccbb4dc68d250510893597d485de4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


