Return-Path: <linux-kernel+bounces-383140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2FD9B17B8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F453B21371
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 12:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54D5F1D47B3;
	Sat, 26 Oct 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AJ7fCEUB"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E0479C2
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729944116; cv=none; b=ZqDBnHhYoHumvc/MdbX8L42E7IOss3VjQO5em7eFa7n0ocbR1PNHc1v0eqaCIv6u/kZHNNY+DUyIXd9/B5ozBzc8uaHtbUVth1xozkUAh21+dOpM+ys2jsdhivVn9mF8KjJluY6V3fCy2ThaiV0X0l9H8Y+lN3UrDqo28Sby0ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729944116; c=relaxed/simple;
	bh=9GS99lzhdnNMT9LpV6PpxwW6BOkQ02qXLQl9hTQY1YU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LEcl5CulLotWD4Hh2CPUUU/v63Il3JN9dOfOt3sBhtpgOspEwa7QyAksxE1g/9o5nfy/0oCEj7iX5LNwG1SD2psDYiQlRYSsxEvid4JhtJOavsfUKeOkG+QZmRWyzYvrY2YuERCMELjOy+17L9E41/sxbYc+nAmkJR6jAQ4fboc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AJ7fCEUB; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5cb991f265aso462929a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 05:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729944113; x=1730548913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ivIAohcESshAYpEPq++t9hJfCpjXuscXbD6Im/FDokQ=;
        b=AJ7fCEUBY+Myvx40AIhxqe91LgbTR4xX1blA+VWJ3i3d76HHN8si2lfQA9xeWMWPzE
         JQcVIhDUCLqH2Tm/xTrmIxAbuY2bn2ccO6JzJdpjp/RJ+qDIt4UlX3wveWSLC0dYEyMD
         npQrjVpPy+HpUwVbg4bH3zc17oRzEZXHqgvmoEjMeLHn0ImmiQtAXv/k2rZHRUoCarJf
         LmBtzSh+aYkaThp+ZuR/EdTSJ9udJeagbcznlvfZRyt/cwXa2O8+FVQ5Yg866N6vmV0w
         y02UDKz2p1NGvt/9IhmjymwDzC5rAYZ5j5OUt0WPEpW8AMEo0/t2b56VPrqgBk4/+BWj
         ecQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729944113; x=1730548913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ivIAohcESshAYpEPq++t9hJfCpjXuscXbD6Im/FDokQ=;
        b=sckYhtkaCKTT1Ttav/WFR2IAf7iftGzMRIcViRqn02nyR6TKWYkYJ2l2wy10KZDhxe
         aZhAvSdS5qWMnaeEuNJKyEPfaPyx3j5CJq2PlP3JyvjV+B+LlsLo1nYhgtce0Q9TNyA2
         JnYrAjEmlW30g6vZooyNVA9z6e8GTYUykN746AHlrp2rsimQMU48iRql4RNx0tRY3TiM
         zQsrWGEp7We+BSsrZhP3k46fTyESn5y3Ltys0t3RGHdaA/bl+H4RgCRFOzhqdzDZQ9G/
         WgD5hxiwuRj25+dCzVOqZC1XP6GYXsKiHl3+MFWoqyuNS1R7HtLUEq1fxwZNUYow7wa4
         0IeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSZBg1bWbORhJgZV17ZCeCU6S5gGM9tgsvRZ+8HLYpzn/YKzk1CVqeK9t8x7R3sCiL9GsNOZPlqaGRC2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Br6mZy9rcZURrJYHQwSKHP4qukwMqfphGCoxqtL1SBAiHXsP
	42Xo6yW+nRDb12/uDBCx2H9Z2T8DsAkhR8+fPcw88jn9WocnyDC6+Vnxy0w2VVY=
X-Google-Smtp-Source: AGHT+IH1dsULDIYCbXnhWrr2hutsWuzTM/gAfeo0yzwyxxJYFFg4QA218/5byXKAvC9+SNM44aVSrA==
X-Received: by 2002:a05:6402:13d5:b0:5c9:7f8b:4fcf with SMTP id 4fb4d7f45d1cf-5cbbfa58bf5mr660881a12.6.1729944113136;
        Sat, 26 Oct 2024 05:01:53 -0700 (PDT)
Received: from krzk-bin.. ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb6319711sm1490421a12.66.2024.10.26.05.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 05:01:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v2 0/3] clk: samsung: Introduce Exynos8895 clock driver
Date: Sat, 26 Oct 2024 14:01:48 +0200
Message-ID: <172994382528.22240.15972019701074354702.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023090136.537395-1-ivo.ivanov.ivanov1@gmail.com>
References: <20241023090136.537395-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 23 Oct 2024 12:01:33 +0300, Ivaylo Ivanov wrote:
> Hey folks,
> 
> This patchset adds initial clock driver support for Exynos8895 SoC,
> which allows clocking peripherals like MCT, serial buses, MMC, UFS and
> PCIE. As platform support grows in the future, other blocks like APM
> will be added.
> 
> [...]

Applied, thanks!

[1/3] as well

[2/3] clk: samsung: clk-pll: Add support for pll_{1051x,1052x}
      https://git.kernel.org/krzk/linux/c/49fefe602d8fa7323b51ffc4891acf4a91dac193
[3/3] clk: samsung: Introduce Exynos8895 clock driver
      https://git.kernel.org/krzk/linux/c/c6e45979204d092770c55c0b2d1fce6cff8dedd6

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

