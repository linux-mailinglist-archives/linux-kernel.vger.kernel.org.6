Return-Path: <linux-kernel+bounces-282234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B62494E12D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 14:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF2221F21FB1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 12:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AC84655F;
	Sun, 11 Aug 2024 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gfNE+N/p"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53834CDEC
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723379598; cv=none; b=HbIF/ZotAeXJ0pcWl6gPSDm1XjhkxDdHoT+doVe02vge2nM4lIWULN5g32Edr7Zdae8YutNjveVKh9dsV12S85DozqzJP9EKAbtqCNxyCaDgp5S2SuOjTXUWutcJf6XtjVFl2Lve7AwcsDQuXEzYEA0tJ9EwgRyuNcHfmB2crJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723379598; c=relaxed/simple;
	bh=KvQ1j2JJhKF96Zmkv08TrmO02CogVrsd0R9+cWW63rI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tawfD4UUiTm9/XQaraQ7BA0ls52zUiQ0xNTjZJatrTT7qXDAMIvkKjpueBfSUSV1hdOP1SGXScgk4vShAyFCPcMVrgXsjxb7e68B08ttB04WnS7ZwP44cIP8GxZ0OyeT5bd/WDlWifo4aHEXTQVJlOH/9Dj7BHkuS0txiXSRDQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gfNE+N/p; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4280c55e488so19919185e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723379595; x=1723984395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNtzmsLAUjHUFGt4yFs0GHGAPibkEjTPl3+crio9j5w=;
        b=gfNE+N/pSKcZKawhhdtkcyydDQAKI+Is3tDnSSCGso6ONqYs6AIfSxNoDOC2XOERGL
         AGefp5odg+T2VYu8xpRjg8n61HaZd1LSsRTZEJGEK2yCxVhqCJP7zkz/njZF9eygN8Rm
         YSYkxcI9AboGXLKQJo+IPEJElrXB46PcE8DmgXDPFa/BLomtmqAEahbwur5ZmVDOQH29
         Pn/n1GYmjmCsxLnLKrImDjAOov6wHS+yGYjNAErHG0tBqTU/xvHH+eg8Jq1aj+FmD5GS
         mjUQJkxrO80vf75Sjy4lpVIPfVl7xvZ7ckwFFdPx+ImiCtx4hPjE8DYN5qRCaQvhGAiG
         MYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723379595; x=1723984395;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KNtzmsLAUjHUFGt4yFs0GHGAPibkEjTPl3+crio9j5w=;
        b=Wf5p3HnL7Qwkd1brSEZ6PQN/qHG4NH1/xCl4S7ObF07N/uO1wZAYO8DkbPmUjRRDQU
         DAg4RvObRi4KyPwtmJ+E0KpCdO3uovAZ5AgP0lw20lBFBpMMuv19+2W62ZtyLJy98j7o
         Ba7tOq3/5nyBlIDary9FFyuo5jwBAiAfDbbR6UYdj87blYdajhIfu/lCo4AVvOWtOVh3
         UAhXDCGZn76Z5Q0YtQdu4PUYye0M+BGc6lK788+pppNnYjx82foI0++VcOtFMesaQYsJ
         EIt3fkBq0LAZBrZJDL8dLUsypM7OC8QkGzZO2i1Z4CQ0qu7vL4OjMpXxy/THRekZq4ar
         f5qA==
X-Forwarded-Encrypted: i=1; AJvYcCV2Kc0pbTyWYmQiLPDyzGlfpWdDscRWMt2+yfB0TheCtb8M2BXgcXnysAwl5WeXKW75PyhGjd6nDRayvUsoaPT7iPZcqdQTqxbA0sk0
X-Gm-Message-State: AOJu0YxD56Hwr+pAXMUyARC3EzZy5szetrhh61a5+sQE6dxGox2g6IpV
	JIkMS38+s64MUNjSc+VHwuhjLyNcn1RK48X+uGEyjmVzkT1K2sCWpkY2A3r3wzc=
X-Google-Smtp-Source: AGHT+IHeSH545tLAiSGZ+Kn/6/EO8IxUAAyxi+TpJ3ZYcwH3qDLKt0hu9wEbSGGrBxFm7gQLt+Hfpw==
X-Received: by 2002:a05:600c:5122:b0:426:5cc7:82f with SMTP id 5b1f17b1804b1-429c3b0179cmr57662965e9.13.1723379594927;
        Sun, 11 Aug 2024 05:33:14 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4290c79f345sm148055605e9.39.2024.08.11.05.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Aug 2024 05:33:14 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chanho Park <chanho61.park@samsung.com>, 
 Tomasz Figa <tomasz.figa@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Kwanghoon Son <k.son@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240809-clk_dpum-v3-3-359decc30fe2@samsung.com>
References: <20240809-clk_dpum-v3-0-359decc30fe2@samsung.com>
 <CGME20240809115500epcas1p458405a51caf1af8e9d4e2f7130b82725@epcas1p4.samsung.com>
 <20240809-clk_dpum-v3-3-359decc30fe2@samsung.com>
Subject: Re: (subset) [PATCH v3 3/3] clk: samsung: exynosautov9: add dpum
 clock support
Message-Id: <172337959331.7186.15471838691665159109.b4-ty@linaro.org>
Date: Sun, 11 Aug 2024 14:33:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Fri, 09 Aug 2024 20:54:14 +0900, Kwanghoon Son wrote:
> Add dpum clock for exynosautov9.
> 
> 

Applied, thanks!

[3/3] clk: samsung: exynosautov9: add dpum clock support
      https://git.kernel.org/krzk/linux/c/ae07389413d41995a027aa5fb99938cd9201fb40

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


