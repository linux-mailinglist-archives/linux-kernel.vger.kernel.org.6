Return-Path: <linux-kernel+bounces-445976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2099F1E15
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 11:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842E41887DA3
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Dec 2024 10:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A08188938;
	Sat, 14 Dec 2024 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tm5xx/Xs"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC0C1547C3
	for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 10:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734172815; cv=none; b=VTlPlYO9XF+ZwyTW0oqnJZ3ohBspaLJhv+Qs9AiuUo+k+uKgrTIgwPWlds/s4Sr8OpqK2PjjMMyyeF49+Z/d+so6M1pI/4qeaSCdJS45fg9ZHz9Gf+/B4eGlTh/fBEHWP+ip7oxYCKRFgD8dAeIRLoRQ3cw7xii2DRDWU0BOsCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734172815; c=relaxed/simple;
	bh=vLgZnBGevkb+s5SDd9vhGESHydnh2nVi8ggdWP6Lt3g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZnPIR8cZcAYCiuqSmQ2SqwZo/+uhU167n0ZWton5Ci+V+m7ScQvPrtyY1ELFumFygqG7bNe4Oh72/5yg6OICF6K1vZwdViOnrF9xpacX2rb5saTe23Jhk5Hcty1U+xGGzpOAGsSnKjSwHCs3pFDObW8wG8M8bvzLz2Faz1MsrsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tm5xx/Xs; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-38625aa01b3so256122f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 14 Dec 2024 02:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734172811; x=1734777611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NDdZ7criVQVdKqHwJ2Kal6Xww02rI16R8MBCBHunDE=;
        b=tm5xx/XsP9hRqdmUUExfR1RcORjh7kOXroscjmjbaHSs/GmCyANWf6aO2c7WiTg4U8
         KjfARbD9r59jMrK9W5BrhrTX2FZpyo66LO+I3PhKa4rUDP+eRp6VEp2kP/XMjWp8T5q0
         MUKnKf7uxfGOYjtoQjw0ZtxZTtZHR3sMCnvs/SULz/9jqCFh7fG7Nu96t9zAF44gGRnR
         Nl+vMHybbAcDIyszxFUhY6FlwxNhujiOomLTntwheU33Uay+dl2WANhzkHqgaM8pBeQc
         hQNlp0MAOZ7OOJrP+5dq3SdLqBPQKaxlBPpx1PyFrMLODYz7EyZnj44TS+tqVAbSdFUC
         Ddjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734172811; x=1734777611;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NDdZ7criVQVdKqHwJ2Kal6Xww02rI16R8MBCBHunDE=;
        b=vVvMr7gtzSfujg6czKGQWioyf+kI2ZLQ9eZoeZee95VwEsW4O9E68Fk/1MMjLsJHW9
         s0HCpEZbHM9Wj063e8zG5jKISMXth31grMYgJtxlEcL7pJPxnaylAFgxzPpmR6Nc5NPo
         zJX1QFt99ChVfVYxCC0CIxGpqugC7yTtIhsEduYlkwzFy9nJbvNd9ozwytF+9WZM2Dzy
         j+Was3v/HB/OmSLOL3yHHRwPbbxQFWXgESURj6wX8rIOR14OxGODovN79FZ5G0+CkMXz
         ViDGqckUmEIOyRppfn8WgyzIFjmhiux4vI3+pGJWbYGH6BPaGN5iSLoKjIgVhfLYUay0
         nfVw==
X-Forwarded-Encrypted: i=1; AJvYcCUn3WPeSL6MzyOgfZ/cp694/K7goTVJVT9JK9RAN4cj3q56JQjHTnACh7SyzhugJI2maG7es54laPync/I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4kKDHDbKR4SNIelc63DrktuDfx3L4PkNiZdfiO8UXU6WevL1M
	/r/hTLqOULmD0fqzWENQoHDyOZRsUXu20wWtP3JTyFsT8pS4d9RQ5mjwZoZtRz4=
X-Gm-Gg: ASbGncspvsXYXl79+45TIsKf7qaXn5Trchu5Mpj6slLjWB0PnxeK8K15v1yjuUf57tA
	+bJ85Bifd09+xmMl0hBtLzwl9RJgDhxk+JUuf9HzrRZmAMjRAq9+RZg6/NCziat45LsJk7g6kVw
	LFDq1tOXkpO2E0JjZyDkzVdMObWy1YeriCKT+CFnds+/ytsozwL3rHzad6Qxc7SSiHOZxF/WFIp
	GXPXt/61m2C/5PhP5axnfzElMHtO1tbP7n9WX8vjkVbuo/sXf1Y8gsC/N4DghLlLG3cffq6
X-Google-Smtp-Source: AGHT+IGr1iG8RISOHOiTTg35lGNZDL66gDIhEtHLO3gjjE3O+P7pn6cBHt0y4vmKD6qwOfGi/YuUXg==
X-Received: by 2002:a05:600c:5493:b0:435:192:63eb with SMTP id 5b1f17b1804b1-4362aa3a034mr19610635e9.3.1734172811452;
        Sat, 14 Dec 2024 02:40:11 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362557c357sm75366345e9.10.2024.12.14.02.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 02:40:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20241209-exynos990-cmu-v4-0-57f07080f9e4@mentallysanemainliners.org>
References: <20241209-exynos990-cmu-v4-0-57f07080f9e4@mentallysanemainliners.org>
Subject: Re: [PATCH v4 0/3] clk: samsung: Introduce Exynos990 clock support
Message-Id: <173417280888.20557.1392916695437038027.b4-ty@linaro.org>
Date: Sat, 14 Dec 2024 11:40:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 09 Dec 2024 15:45:20 +0100, Igor Belwon wrote:
> This patchset adds support for the Clock Management Unit found in the
> Exynos990 SoC. This CMU allows for clocking peripherals such as USB, UFS,
> MCT, et cetera.
> 
> Currently there are two blocks implemented, CMU_TOP which
> generates clocks for other blocks, and CMU_HSI0, which generates clocks
> for USB. More blocks will be added (hopefully soon), like HSI1 for UFS.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: Add Exynos990 SoC CMU bindings
      https://git.kernel.org/krzk/linux/c/5feae3e79dbe2d357b223fc48ae907ba0aedb271
[2/3] clk: samsung: clk-pll: Add support for pll_{0717x, 0718x, 0732x}
      https://git.kernel.org/krzk/linux/c/4a450ed26c580316d720154e7ffb5e9b4763a11a
[3/3] clk: samsung: Introduce Exynos990 clock controller driver
      https://git.kernel.org/krzk/linux/c/bdd03ebf721f70df1458a720b25998a489f63297

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


