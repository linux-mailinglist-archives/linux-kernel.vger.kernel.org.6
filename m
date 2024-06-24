Return-Path: <linux-kernel+bounces-227100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 989DC91485E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18C76B22A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 11:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E2D139CE3;
	Mon, 24 Jun 2024 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Foc7599K"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD270137758
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719227959; cv=none; b=loiQM0lW/JmhNmMVSODIhi4BHaFpiZgFTXsV/PX+dfL4RlCfh3naKEb0SsTosLdAgvPHYhgl7G3wSZr7J0YE/e+y/SRyjV8DlUjggrexZEj9kQG/TKUSjInPKbOhApfqqQLTo8wbSvjSjKB1C4hwJCP+lpw/29ZPL6tymB325IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719227959; c=relaxed/simple;
	bh=SNjmBO0D7BMbAU+av75Fa70a2EPNGWDJQGrk+rencIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSltcTe9h1TJx9ifBBBZxsgN7U0opuKkbHuTESdKo1TDNtB+cePDup/Jf+CYp8imo84345+m8x1N3cF3SSQ9xOQK3ulAL4EWZmj6jP/X4NZwWkOJim7gV9x6L9+lhjzc1IbgnLU/vcWpQ2fYc8CssqzjMLGksfP4s/rXc7j44tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Foc7599K; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ec10324791so50158751fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 04:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719227955; x=1719832755; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=juf+woKCXf5btp37iLECpNl6oxMZVdudz2S5zzDkQL4=;
        b=Foc7599KDVlD65XqH4VHZtrcAa1i8g2FBFiT5tdVTRMSe8JBrhos02/2EBzXIwjJk3
         +xin/Lgmnzd/S6ZvG3iSrDTf1Jm1WQ5SoLUcc6DRha+A9ie8tj8gjjYhscS6z/FynLAC
         uD8Ev0xc3TWPV7Qxg0uN6GXKeAwTfO88IzrQbZUvsxlveAg2Fmseh8QtE32cHEDFAYv6
         Y7Cumx19tj8C4SXJnjVroseB51d3QIPF9B0xIahiK/6GFbhPGFUHiZEtaLZBP9TMyQtT
         pR9d6WNm3DaQgumDeBBypNQzaes62C+JHFKencwjXf3aL/TmCwmQBrmzuNnqeyvviug6
         +JYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719227955; x=1719832755;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=juf+woKCXf5btp37iLECpNl6oxMZVdudz2S5zzDkQL4=;
        b=Ha4D9xWwU2gQScB59oXvvptewr8xoXk4vInFL8RCEHL7jvgCGhX6oZum7TFqiS6MW5
         AY8NmQL/kblQx6JllAndbiUJafqL41+hqJA6ExCmH/c67AAqdR6Fgvg+g06T6qNWMPgJ
         gFr5esMsqqJLjRi9wJ545u23Oz+ORZcSQ///JJAhUymLU5F3c/hf1pnrZBI67KG3N+0p
         5KKINYvV99AmGuTJFAoG/LtP/xj3VvbbybmcpEnX1Tr4iERAWMU1vINzt5IYtCyfocgf
         4ZQq5uF2CAAEGt7EEunGxPakozzjQkZRtYU5lbBVLojz45YshG7bmGzKp5uHROzhqtUk
         UzQg==
X-Forwarded-Encrypted: i=1; AJvYcCUGKWI75RLNxxUpmTDYLEZF96vD+0XuC9rsHpqCPiClETgTXhQC0Qr7xvidaFq2QB+HYK0lhS/dUxlxH/wgGc7J582gebD73HoIOS2B
X-Gm-Message-State: AOJu0YxBT92YT/OVRkdz3JlJY+SDOfnkVLlwB+EVTrSLqC6D24rDGiAb
	VyXsNBZVEdljOmZX3bhCrA6akPxBuI/Tid+vECcgMSzvztc2wJxTxP4cWAx+HBwqinT0KPBBfHK
	DOT4=
X-Google-Smtp-Source: AGHT+IF2wreRxpMJJ/CsmZvrlVj+4xFYA1Wd/Ll3+2/tSINfml+I3xsXOm7U4JJn9hK5sN51EvHXFg==
X-Received: by 2002:a2e:97d1:0:b0:2ec:5488:ccaf with SMTP id 38308e7fff4ca-2ec5b2dd95dmr23710241fa.35.1719227955085;
        Mon, 24 Jun 2024 04:19:15 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4247d0c5492sm172102245e9.24.2024.06.24.04.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 04:19:14 -0700 (PDT)
Message-ID: <f45742f1-8bc5-4516-84b0-391352c4bd6d@linaro.org>
Date: Mon, 24 Jun 2024 12:19:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: x1e80100: add soundwire controller
 resets
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240624-x1e-swr-reset-v1-0-da326d0733d4@linaro.org>
 <20240624-x1e-swr-reset-v1-3-da326d0733d4@linaro.org>
 <pb25qgv6c2fb4vjby7yiqyorzqft7oyuucotw5267bshgvw3rg@4wry5qxoubhy>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <pb25qgv6c2fb4vjby7yiqyorzqft7oyuucotw5267bshgvw3rg@4wry5qxoubhy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/06/2024 12:09, Dmitry Baryshkov wrote:
> On Mon, Jun 24, 2024 at 11:55:32AM GMT, Srinivas Kandagatla wrote:
>> Soundwire controllers (WSA, WSA2, RX, TX) require reset lines to enable
>> switching clock control from hardware to software.
>>
>> Add them along with the reset control providers.
>>
>> Without this reset we might hit fifo under/over run when we try to write to
>> soundwire device registers.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 23 +++++++++++++++++++++++
>>   1 file changed, 23 insertions(+)
> 
> I doesn't look like this was tested against the bindings.
True, let me do that and send a new version.

--srini
> 

