Return-Path: <linux-kernel+bounces-426150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9C99DEF8A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DE9728150E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D745114D283;
	Sat, 30 Nov 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mgeNYV37"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AFB13E898
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732959032; cv=none; b=WwSzHvMa3fkrIo4bnul/23xdYQGbO9dlfrcVlECCQAvwxBLTJ1iyuXO/Yocqzq7L1lIzeT52iq/sMcK5kMxnxoZ4nlaeyGItBqkPmHx53n6FAz+JHQtv/QMoGG6iYv8NN/xb54ftgsCbU46ZtpUBLQ98HoTgqCTNhIknx/BhiCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732959032; c=relaxed/simple;
	bh=VnqZi1TsO1FPsnBTESSdEDcUvqmw4CbZV3ZGQni0V6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hDEYmrd60wlfUABtnQkFAYK+OZAAT/ot7tndzyDnpcOhoZf/cb5AM89R1IH6iLoGuK82wRmJ9VF/sGDk5o10ZitUTxPvvn4NEWF2m0osEJ/SCrVFHXroaRrH7VM6Uxa0gD2HRlvgjvce/oWoxEVdpMJG93EF2v96KVUw3Mkl1qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mgeNYV37; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-434941aac88so2199215e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732959027; x=1733563827; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aSstUc1Wh9CSedtF7A9Ll+6/DyseBx0SUsRCOow0YjU=;
        b=mgeNYV37BVCCsQzWfVbVGEdIAI3lxHf3v2CaPTJ2/abFaUVKfnEMTuQWCVZBXyPsZH
         G02kXQWydbLBX02FN6ybgczEQf+1lFBx6ywqYfyXUI+ePdSr63nuinbLT5wBYlOHf8V5
         iglIeEJK23OUqchkpBiUf+ewIHbMzakedXJI7W6TzV36BiLsaWzBPyOddNToMKVPH8Yd
         p21yTn9vUJKUsXq+O+IZuninSX8W/NHU9YL3DHIyZQ89jg5zTzGpV/fUGO4+L3ii1w9C
         cgbkzBHfzFsv7EETyDhh3aygQdMmWpqD4iLaHGzN8j1cX8wB4CVIDypSl6HAx9Nkh3NE
         PvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732959027; x=1733563827;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aSstUc1Wh9CSedtF7A9Ll+6/DyseBx0SUsRCOow0YjU=;
        b=L6bSuO44sQtLu6dIHvdrSwWZCYh6eYtnfhG4rsatMGZN59tEAw8H78dIy14Eg4Snga
         GJKat/HDaUliQzQrTa+vFFnBvupt2GDrHq+4RSlT7hpPzmI4554lovU9HiL2IBv87UYv
         e/PP4RoT9uv2MaQHbyb9tNML6KUUCHRxoVFqStExdqVL6fPXfwEVe2GxqXJ7F4de4Vv/
         CmvjqYRV9GjXwugjGeerLN5jFyQRxIcR9EEmrqREDIkGpRMHH/0WCITt43G+WkZIE8rQ
         kuWGPMXFJTsy38PTR4EfEq+XK7Uot0APSw4JyiqaFduCt/rCONRXUFdiyoUcvUa3YakJ
         TgCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmEDS8YYfidcJMkCr6YglaqCS/7GY2pWYxJEoSih8gP1GfXL6vBxqeUYID6iAtwkqCvH5w02xVXYVIsYI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/QtwCDZVLqUOfpNUFOUQuHzij397+sJSgWSXl6+ddnb5De2ok
	ZPp/IyjST8qwfjPJ9486B9j5FVKWWiSXxsR1pDROqFdqXVaRllxj2QRSxmd3P4M=
X-Gm-Gg: ASbGncsv6Dql5C2wfkq3XuuuQn/eWrqT6cdzj8ajlMX8OxXGfP9Lg025PcuLVVqflAm
	uv6E1hEiXDr4w0yavOIyqycBKzIxvivXK+MWVexalCIjrz000MZHhzgIt+YiR6E5moNUVNBDmby
	OXKg2BrukMDbbVa0H6aNQrH/ZdvsfAAJ8FimE34DpNE2sCm1zeaC4OkyYj6f+6YCjCdQBi/aiwF
	AdNix0Xll1hh2CWuB64NPKl9w/f4zhN7gD45mKuZOPgEJkN8mX60LJOvKsxd/0CYmlf
X-Google-Smtp-Source: AGHT+IH/UGqX2dinsUhhz7NjeiG8Vbk0BgLbFfX2bfz3Cqhe7D/C5PpxiV58R64JHn6oI4sLBnb5qQ==
X-Received: by 2002:a5d:588f:0:b0:382:5066:3257 with SMTP id ffacd0b85a97d-385c6eba56fmr5117474f8f.4.1732959027372;
        Sat, 30 Nov 2024 01:30:27 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385dec66e0esm4102388f8f.43.2024.11.30.01.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 01:30:26 -0800 (PST)
Message-ID: <b89d2669-80d3-4c32-9db0-bd5759c31aa9@linaro.org>
Date: Sat, 30 Nov 2024 10:30:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 24/31] arm64: dts: qcom: qcm2290: move board clocks to
 qcm2290.dtsi file
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: Leo Yan <leo.yan@linux.dev>, Joseph Gates <jgates@squareup.com>,
 Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
 Stephan Gerhold <stephan@gerhold.net>, Zac Crosby <zac@squareup.com>,
 =?UTF-8?Q?Bastian_K=C3=B6cher?= <git@kchr.de>,
 Andy Gross <andy.gross@linaro.org>, Jeremy McNicoll <jeremymc@redhat.com>,
 Rohit Agarwal <quic_rohiagar@quicinc.com>,
 Melody Olvera <quic_molvera@quicinc.com>,
 Bhupesh Sharma <bhupesh.sharma@linaro.org>,
 cros-qcom-dts-watchers@chromium.org, Stephen Boyd <swboyd@chromium.org>,
 Rajendra Nayak <quic_rjendra@quicinc.com>,
 Martin Botka <martin.botka@somainline.org>,
 Jonathan Marek <jonathan@marek.ca>, Vinod Koul <vkoul@kernel.org>,
 Tengfei Fan <quic_tengfan@quicinc.com>,
 Fenglin Wu <quic_fenglinw@quicinc.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Abel Vesa
 <abel.vesa@linaro.org>, Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Sibi Sankar <quic_sibis@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Jun Nie <jun.nie@linaro.org>,
 James Willcox <jwillcox@squareup.com>, Max Chen <mchen@squareup.com>,
 Vincent Knecht <vincent.knecht@mailoo.org>, Benjamin Li <benl@squareup.com>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
 <20241130-fix-board-clocks-v2-24-b9a35858657e@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241130-fix-board-clocks-v2-24-b9a35858657e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/11/2024 02:44, Dmitry Baryshkov wrote:
> QCM2290 is one of the platforms where board-level clocks (XO, sleep)
> definitions are split between the SoC dtsi file and the board file.
> This is not optimal, as the clocks are a part of the SoC + PMICs design.
> Frequencies are common for the whole set of devices using the same SoC.
> Remove the split and move frequencies to the SoC DTSI file.
> 
> Suggested-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcm2290.dtsi    | 1 +
>  arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 4 ----
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
Nacked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

