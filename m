Return-Path: <linux-kernel+bounces-426155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C349DEF99
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CABBF160175
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D082154457;
	Sat, 30 Nov 2024 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbdjNIg4"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733807080A
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732959112; cv=none; b=deA3N7xRUmg9zci7rocE93zG1Y1amWiyPbfZmdLJpoqCIY0vS+Qhg5nq3ueHVvZ/lw89EWDgjsmWbnvjlQQARuHK7x9S+xCFofQ6Yk2GkCC/CBlYonMo4LOB27n4hTW1AJp6Y8VBnusfVRfAKWal/ijQ6vBpNkVB+wimbhD8aos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732959112; c=relaxed/simple;
	bh=ffIlT5Uz8ZnLYQI7fgNZtTCBolYG1jjlQZ2syVeI5XU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4CQJLC2LT+XT9w9qvO8qciCcpHqukACzx23DsDqkzP5EX8eVFq/8f+SFBtpCCysQtvfGAGzS63zn3nXRWqM9sw3IkyKDiv0IZJuBFqWwVr54vM1E8KlBjaoDD7khVijG8nqmvF/dv+DPd4Xx9ctN9B/DjJ5z1jPb/g98l9/E0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fbdjNIg4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4349ec4708bso2202835e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732959109; x=1733563909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HjVGFy+yOa9hfrab3TqGsM+pv9WGWaTH6u49hY3F0tc=;
        b=fbdjNIg4pIUch6l7OWCB80LidEybqJlrVm9JbgpKCE5oIncteGJoN/2o5svbQ6Xj7s
         uv/tByI/ojv3RUP+iFcp5o4h3s3ueh2NA/kyEKGQfD77d8QfYETQdbOYHs7+IH12WrGj
         Pfre3JM3s84Clgte4ne1DxIF9MJlhnChpmeRpzxq7u07iVxvhvM/MBi4EeOzoBU9Qpx7
         PxoeQXM8/GND/r0VVpV131nRS7ZH2f3ZBV/sbptdiZQ0JjCxOiBmbfdIPkRNvgnFpkZ5
         jVODfBDlopiIf5mpGusSts4LK0RKxvlf6EnWC8Q3lFF5oLAkpDT3xowxWH1f/8ugIwU0
         UJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732959109; x=1733563909;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HjVGFy+yOa9hfrab3TqGsM+pv9WGWaTH6u49hY3F0tc=;
        b=FYtes6M0XYSU92r44ABw5IPd9bkGv+ceeD2529B84FzUAQmG4+ITo4kmbICnNCpD1c
         CRk/00NGFhWV1RPadZy5acPtyVnUkM5sKyBZSmlBBEVPKLfzkJfVOA4RUN0w7uG2q0ml
         p2c1lZp3BeWu44v65qscn8TaPgH2fpS0d8k3v+R9PmWkhL4ysC31+Tj337LoOU81pBnt
         I6coGeSK/b9lzHhDiRexBPwzAVfwpMX8YiBu/Sz0e5AjDmGaud7xVGm+wv9z1IPB+Jdv
         tHseY9GlbmAX2r3hZiKsprpEJV26oNuJurUbprFBveMcyZdlJ/s95iqUBqO0s471ldp4
         3oWg==
X-Forwarded-Encrypted: i=1; AJvYcCWANpKJ1FmXffdL4T5o1TYqis0pGvhDPY2rqDtUTwFp4fEf6MgzVjm8l8gGiy2QxAmPpMAQRe4a3H0l0ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUfFnMKC1XMhfOLtajci4/xDuymbkQqjA1UuumZdzBTvmQ7ewo
	SkQtCiUF3Vc+I5lRUwoYK4iRFKREwVaU/8MpVTXGnUAEy5GT31Rq0l1wGx6WaE0=
X-Gm-Gg: ASbGncvt8zPqnK9R8p/FyAh1T5sd4cIL2/yDFLkVXNh0MJPrr2FkCT3yM6DTgnGq34M
	OfKh6NXqR+2WsyaxKnrQaDvDtRK25kF2UXrjUQXcAOZR/5bco8ngHfjoFBXtWJnIhgNCm5d97QP
	Ag+K5lwZJewyL+4G5coB/IYgercxhZlk2O0fng4ZJXQXCHj3cBhSNuTAWBRWNcykaKOvlEn4nJK
	JQUPB8CIjEmnD3PauIVoNV0DTZjW5gS6pugwazHKBKb7E/Z8MLeg9eYaR/3t0VbDBoC
X-Google-Smtp-Source: AGHT+IHW+foD1SrmgqtpDGvLP+dderBdtVcABuGJVLciZi6z1iocSzIC3iz/dCHScVmy7HpNLO3LBw==
X-Received: by 2002:a05:6000:78e:b0:385:df17:214f with SMTP id ffacd0b85a97d-385df172381mr1854776f8f.9.1732959108969;
        Sat, 30 Nov 2024 01:31:48 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a7aesm6694397f8f.59.2024.11.30.01.31.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 01:31:48 -0800 (PST)
Message-ID: <6db88b93-fdf6-4927-aac1-5ea127dfd1f6@linaro.org>
Date: Sat, 30 Nov 2024 10:31:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/31] arm64: dts: qcom: sm6375: move board clocks to
 sm6375.dtsi file
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
 <20241130-fix-board-clocks-v2-27-b9a35858657e@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241130-fix-board-clocks-v2-27-b9a35858657e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/11/2024 02:44, Dmitry Baryshkov wrote:
> SM6375 platform has main XO clock definition split between the SoC dtsi
> file and the board file.
> This is not optimal, as the clocks are a part of the SoC + PMICs design.
> Frequencies are common for the whole set of devices using the same SoC.
> Remove the split and move frequencies to the SoC DTSI file.
> 
> Suggested-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---


Nacked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

