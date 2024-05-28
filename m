Return-Path: <linux-kernel+bounces-191810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 356A38D1474
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 08:34:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588831C21C80
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B561161FD7;
	Tue, 28 May 2024 06:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YkRlREF9"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2388A53368
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 06:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716878063; cv=none; b=fw15DmSpbZrfwitGOG6sDl/ukzFsp5NRop70rSHA0ke8KN7PEg1s2g6isZkzb3O91Dss9KAl/jH5HLy0r7CdJy2HvemnuDX+MeLXRGUrPNVDegZzbJC8RcDbLQzXMUZvE6sjawEBCwsJCLW1FheJak8Z+6FflL5gcNHRMD/iyb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716878063; c=relaxed/simple;
	bh=aHDF7D/CSvhtZKfyUS9a6/b72x6IQtyqDuWm+LYK/5g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4jkzZSnTWdx1RyH30eEI5ircBEw3p4UiP/FVdVkDrpytRUWrZ29OsXV9wMtLkKaIZx4cONOkByz48kwxX5e8+ENkRfmNYb93VwEQzcFL+TML/lAA5bM2DnqlAhousfVSldP/tmJJmLQWbBIzAwbpNlJpz6cHp1+LXKJu8fwcZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YkRlREF9; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a6265d3c488so65272566b.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 23:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716878060; x=1717482860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yWHXKgV8HPEyeVyV0U4ldBfI6C4Z/BqLFrufXVr+cAQ=;
        b=YkRlREF9MuaE+8j+TA+y+2cg+XxdbyV9nNoWEq28CVALrQN242he8NvjurqET5gOSK
         iLnJ8PJEK0RSYahJ0ocXmVPfoIWquHDch8hMZN1ZUR5aLIVIAAsywK+eShKTBFhZXkl2
         Mg8eo/R0zjc/Kt6rjMfr965ZJJlf7H7T6FLqZchiqIZwZlur8X8dghRafCrBXcBixnlH
         w71eW8WxvsHsy/JAtiAOqEu1hOn81J47w2X7SnyTh1pRDejP6uM4uEk/j2wbAnD1GxZM
         nsVgJbeYvI4CWYr/4IXUXo/7twa4tUklLLfdoQ7Yn6b2RqjZx0euuJ0qt/x0G+xmwlhB
         oWfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716878060; x=1717482860;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yWHXKgV8HPEyeVyV0U4ldBfI6C4Z/BqLFrufXVr+cAQ=;
        b=lJCJFS8aCXq5fgbNtECH7VYKFT79c+QccRM77lt9Bg6YQgOjHzEy7AZY5IHtyyosah
         rds5y3SqyHWuVOhd1CSuuASNQuPHyuIvIYz0fMkfpDQOTYsderEMDRfKBEhpj8Pg1OIE
         V031aeHqtz21WVw6PqnLEarqE4QkzmtQVozEwoRNYU9Jpd6CDqaMZ8pxKRGT4e3RMNtm
         3/EvXFF1zU2VLSOrbgdurllxJdJLnVU5udwLQ0AUYG1rdQB8FwtBEK5W0X5FIrC5mYSa
         V8iMRz5fkdk5tNOXuSwZlcpd6OLt1JhDBCqwLRSDfGcahPPi716Y/2Y/11KEdg8F8HdK
         QpUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfd8ibacMOJJcnZL4Dsn3jD7MZG03xN1+/lIZjXQoLDuUTjVJKtDDce/5+UgG2Nuie5dsd+1hspJF+ZVks9YrM3TmtF36l04q58NSN
X-Gm-Message-State: AOJu0Yx7WtS/ej3teo9nC3lZ6GU2ETkS9y34wyGkxdvHWf5TTgBce8a4
	AkfY4KCMCWto3OBYVQYmrVVcZF1Mdw2Y5iC/Jc1yZXbT5wU770LmvSTDU93XlX0=
X-Google-Smtp-Source: AGHT+IFqedIRbH3+ij+rn44LdEbQUE7dywHaYfPRlYPeRYDPjGPPAzUj6Ct/xAR3ZTKmwPTFPHkS0A==
X-Received: by 2002:a17:906:6a24:b0:a63:3e99:6565 with SMTP id a640c23a62f3a-a633e996aacmr174571666b.23.1716878060080;
        Mon, 27 May 2024 23:34:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626cc4fd41sm580924666b.137.2024.05.27.23.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 23:34:19 -0700 (PDT)
Message-ID: <ac2f4ba0-e48a-480e-98da-500041f564ac@linaro.org>
Date: Tue, 28 May 2024 08:34:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: defconfig: Modify number of usable 8250 uart ports
To: Bhavya Kapoor <b-kapoor@ti.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Udit Kumar <u-kumar1@ti.com>,
 =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Bjorn Andersson <quic_bjorande@quicinc.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>
References: <20240516095733.276807-1-b-kapoor@ti.com>
 <1d1c92f3-1692-40a1-aeb9-ef3e342e9bf6@app.fastmail.com>
 <9170a555-7cd3-4888-bad3-01b71c6f445e@ti.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <9170a555-7cd3-4888-bad3-01b71c6f445e@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/05/2024 08:26, Bhavya Kapoor wrote:
> Hi Arnd, our most boards have 6 uarts that can be used in the runtime
> 
> but overall our SoC has 12 uarts. And some of our customers have this
> 
> requirements that on their custom boards they use more than 8 uarts on their
> 
> boards. Thus, we need to enable this to 12 uarts.

defconfig is for boards in tree, for developers, not for customers.
Argument that some out-of-tree user has more uarts does not mean much
for defconfig. If they have some weird hardware, shall we enable it? Or
if they want DEBUG_KOBJECT? Or anything else?

You mistake kernel development defconfig with a distro or product config.

Best regards,
Krzysztof


