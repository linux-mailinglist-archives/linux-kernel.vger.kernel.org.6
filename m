Return-Path: <linux-kernel+bounces-426148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E029DEF84
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 10:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10B452816AF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC5114A60F;
	Sat, 30 Nov 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJKgoUQx"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6648D14BF87
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 09:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732959010; cv=none; b=OaOhiIWU21hJUbp4Nl98xL6n9VHBbYuAWbUIqgH89BWM5PojwWc1hcgAdhayI/3Ah/z3sqkcjvkUv79gIrDxcRiYQ2ZMHdQFLIkmf8hGwqIrFBAMgTWFDF980VDHSYoCoZVEBxnOs4TxAsZtudx75IRKSLr2x7+wawKNKMmZ1FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732959010; c=relaxed/simple;
	bh=eUNHfRWuZm3AVnzBMgyWyYlUcxEuM9ymnkiOAxhTvtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BK4mxWM3HIhRFMqnKYlU5g/+4eIlSAz90StQ5YDonYk/vrNnrrIxf1bfMB+/8cdIWVpowkvN3CJxJt0uJQ+Tz5R/jA5DkqsJhn+WmeFZci8SbFKjY5qDavz9p2/rQoLlBtuFIP2897h6U1BKXdtxUlb6zz38WVnUbP6uFL3TBao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vJKgoUQx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a36b82b7so2210395e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732959007; x=1733563807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ba0qYYerkCmXlXri2Ce0vk4bIgp3JXMfLHQV9IvOdlc=;
        b=vJKgoUQx6seXpbn1kPf6m/KIQ4X5VD5i5vDpqr8F0kJ2PhQpSM5PlMaspB1n2Ha6SG
         lpb9sUiN22uYgCHJc8h7stzcsMzX/A0nyrL2tqTM5QCaAVBNebHNUQTg0RXUl7zMsLCl
         nbMLQb5nMn7e8MawvXBvr8YY2pr+qVq36PUHAmvbU7vjZ9KDtoEdT6H/qXqVdQIbht3n
         e3nLRzuXNeCrDuCGJt3RwWASnISRRIp78vekHmXmoY9vdH+018ReMwQ2e5uH0ZzR/oCI
         avrX7uQBRGLQTOlTByluGGIZNB9seG545VxJG74VsoMN8m01qD2CBWeR10gYdKyB6L4A
         NJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732959007; x=1733563807;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ba0qYYerkCmXlXri2Ce0vk4bIgp3JXMfLHQV9IvOdlc=;
        b=JiRTgabdqq4tkMNNFEMTupPQjp6K0MDgUX36tVZqD8tB/VJjFbLDSErSfpeu9zuTbx
         A7/IiO22eZLf7mgnK1XLS5YY9p93xt5+j2ttBnItaUCvnJ4/YRFOJqUI3RTwdu+67DSY
         dRJNk3TZusNlU3jo++4IDmslQPSc5UbkGCbBfbRDrqNmo4RWaw9ManNKarj91WQyoFqP
         fdfSNylqTsMiPOVa0kAJxHz50AR1cjTtZKrLM1Lo2OCJcdskoFIA4AdQsb29ErtV9YLa
         bxo5oQYq4c+MdBF9b1naRiSEBSJMy7jiYa4tIT4rZRi/WWXoOGxwPZz33br1y7fpw59s
         mzew==
X-Forwarded-Encrypted: i=1; AJvYcCWQJ4KB2WO4tKdC92QmB/IZzMSNVPt0i0u1TtQdNJSbIjvlzpvm8rr3rhcdw3+oWLQwcIWlhxPefhIQF2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmIZlP+v+bhtCan9Ay4qDTR5CjyMLxyySRztX16xhNZXdVm2La
	Bgjit8Usz2oPyA75EKjICm+HdlP61/QP9olv8YsQPPT0BxVQAxZttK8GXO1JLr4=
X-Gm-Gg: ASbGncuYMCCVEL4F6OsGXCCei8btmbXaX7RX1WS8yt4bUid8lMCFzyEIYqlXTkssEJC
	IkS4MSVNOzc31m+F4JE2vSSnkV32BcUFRKwZH4b1q9i7oCryN6AslYs3Q+2lIZUrI4m6S3429/L
	slkmiczoJeUyw7dJmg10A89IknlvYn/R+u9Ev3EqMLKvtd4Mf088qRvSdFEJVT7kCokJgbg509/
	lKO6mCKpTrhhnPjH5fkaV9fKUP8+Qy/Hl+rj1Fho03Hvsb2NnjVBG7hb0p2fM+veJiA
X-Google-Smtp-Source: AGHT+IEJ5qK3jx+pSHotyajCQpsPBRP5Hw+lOwFvDkTJ1WItY4YqI1c7QjlxT+f/0H7oAdyYFhc5+A==
X-Received: by 2002:a5d:588f:0:b0:382:5066:3257 with SMTP id ffacd0b85a97d-385c6eba56fmr5117126f8f.4.1732959006685;
        Sat, 30 Nov 2024 01:30:06 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.23])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e06c485fsm3179109f8f.83.2024.11.30.01.30.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 01:30:06 -0800 (PST)
Message-ID: <2cfcd4dd-6cc9-4a1d-81d1-6249cf54a8f3@linaro.org>
Date: Sat, 30 Nov 2024 10:30:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 22/31] arm64: dts: qcom: ipq5424: move board clocks to
 ipq5424.dtsi file
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
 <20241130-fix-board-clocks-v2-22-b9a35858657e@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20241130-fix-board-clocks-v2-22-b9a35858657e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/11/2024 02:44, Dmitry Baryshkov wrote:
> IPQ5424 is one of the platforms where board-level clocks (XO, sleep)
> definitions are split between the SoC dtsi file and the board file.
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

