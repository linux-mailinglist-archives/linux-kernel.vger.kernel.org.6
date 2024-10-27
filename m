Return-Path: <linux-kernel+bounces-383772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC699B200E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E767B20D33
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263F7187347;
	Sun, 27 Oct 2024 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Scns00Ou"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCF4184527
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059205; cv=none; b=LcThvGoTPsopFLXmxfGKYNH7Hx2fZme0slgmeTAIfAmrWzqsdceL7tTnLaR8WNlP7STVBV4fRNEendZ8eCeSJxd3FPpJakaSRvjHpnWSawDJWqDhGrCXVLA7eNTb7iBLl/i0LqSOH7mx5aIbYbArwhlyt6v1JOf+1TLTY1hyw08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059205; c=relaxed/simple;
	bh=BDc9SQH/7ipIybD+FB+/IPaRAq1zBn8OCwWLIm1LA3M=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X5ZvL2Xed+kfx1FU+Uf5rhMVs0HPSceMwB9gMY39/Zc6uuaDHBorQGpxmKt+qUt2+yR+NFAkdT/JutWtUlDO6lNUPNQop03dJzPrKWSIqCbPrZnXPamFECOgDJLN3dmXl7RJOnUytEap34qBUP8EVXWCKDgK95WnyPlkf019kvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Scns00Ou; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4315dfa3e0bso4250695e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730059202; x=1730664002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32/OJX77QzfcPQ0HvpkF+bqERxGXoeV6PeRkVjO1W/I=;
        b=Scns00OuAOmyWY/H+WTkg6ClJWXbolzJ10EbItuBCQoTS9kwGslUtqCJmnLzGDnpic
         6ZYhbLXEnhi79u1Isq2Pu72jGjAYXPdc3siG5QBBA5kGVidk+OZ+3+BA3bTUaAIhmOdj
         s4a1xXaA2SkN+kI28mZGV9xzH8L5oxLWs/HAolSug3deAxSB6qolEpwYf/GcNkWJw5BS
         MI0ljvP5so+P+dyj6AV8GHaOwVmTiZ0/c/SHNBq4D64DuhUUwGsyRcxlm16G9wQXnBnu
         us6Uwt4QlOxNp6J3DQU9sXVcqfypVOr2WxnmZqxW1ICSYnfn8cdfBPQgiPiW03OKLta/
         In2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730059202; x=1730664002;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32/OJX77QzfcPQ0HvpkF+bqERxGXoeV6PeRkVjO1W/I=;
        b=DbKU51YSonuBbC/6de6OH8ZrT6RxfCCxBstQEtSYAYVqjNICUOhPhkj/RaeaD0Qx4b
         v2C3E6GDKEbEh/B2YuJctYidTP98hXFASfkuTuxviVI6Z44dEFge0nX3t3xVpcGMjK5X
         gUCjpKXfzZYIlC7RD33DssjENK+mb4/JQpoDPhZAU/1eoPBA7uf9JaYy29F479hlAFwL
         IcP8ROBJmEEvhey40AwhK7xGuetId+c86hfWdVQptTggvd7lZ0dpWBwBFdcjHXiVmr7E
         uNM01e5WXi+AV8bf8S/z755oSub8/3gZdXE8dyF7r38YgIiMXx2V6VIKnbF3Z9TDSQrC
         Hw2w==
X-Forwarded-Encrypted: i=1; AJvYcCUJ8H4s9MIORIhRAuz84ArT9OYR0BODH/Nghhk7aLRMG64IvOI49nBW3DOVPq2xz2nixNO5rkAZ7VELv0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTonFDNloLuJM005NQFk7jRgZG+jMAfdM1Qa5iPKPj01ro7OCu
	puA8ZCGNidXwPRncEvrpQUKtxc6SHNTrj8FiRMKvDNjdw+oDW1NeBko5jEnK5dM=
X-Google-Smtp-Source: AGHT+IGfqlf/6p5wAoYNymTQnzp8QuSdGR2Arh0BQMxhoKUhDQVHbla9xIqcp976cFbcKvl5ArUS1Q==
X-Received: by 2002:a05:6000:2a3:b0:37c:f388:cd48 with SMTP id ffacd0b85a97d-380611a4f13mr2206527f8f.8.1730059201849;
        Sun, 27 Oct 2024 13:00:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b6f838sm7506639f8f.83.2024.10.27.12.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 13:00:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Tomasz Figa <tomasz.figa@gmail.com>, Will Deacon <will@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Markuss Broks <markuss.broks@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>, 
 Maksym Holovach <nergzd@nergzd723.xyz>
In-Reply-To: <20241026-exynos9810-v3-6-b89de9441ea8@gmail.com>
References: <20241026-exynos9810-v3-0-b89de9441ea8@gmail.com>
 <20241026-exynos9810-v3-6-b89de9441ea8@gmail.com>
Subject: Re: (subset) [PATCH v3 06/10] dt-bindings: arm: samsung: Document
 Exynos9810 and starlte board binding
Message-Id: <173005919993.11546.7756823592016380803.b4-ty@linaro.org>
Date: Sun, 27 Oct 2024 20:59:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 26 Oct 2024 23:32:37 +0300, Markuss Broks wrote:
> Add the compatibles for Exynos9810 SoC and samsung,starlte board to the
> list of boards. Samsung Galaxy S9 (SM-G960F, codenamed starlte)
> is a mobile phone, released in 2018.
> 
> 

Applied, thanks!

[06/10] dt-bindings: arm: samsung: Document Exynos9810 and starlte board binding
        https://git.kernel.org/krzk/linux/c/0a4907eea61d1b7d602a817f6c1de31609c48367

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


