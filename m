Return-Path: <linux-kernel+bounces-426473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2209DF372
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 23:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2ADA1B216C0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 22:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D151AC423;
	Sat, 30 Nov 2024 22:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pNQpKRaV"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACFC1AA7B1
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 22:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733004057; cv=none; b=Ko7n1XINN6rh2XlN36Lac5vL0NdkOU8TkCQKudJrkR8Nhi2aMpzR8IEN87zVyk8VlHJd6gbRiQPLNkSiPGuLt6JJToAFjkdlnbvXknR11BwRRNWUc8ss+3ToZwQORfSza1WzDuXdxovxDvdFpGOydRuspL2YIzSii/mpeL7ZUyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733004057; c=relaxed/simple;
	bh=4jKUrEqb0qz1HZi2C+0lGSNoRJQgPPrXQ/svYUCrylo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dD3Avo7sZPZnF/J9dH6ZSQpZhkPMexIVSrGgN66swekuei+VyRTOdNjoEy8Gpbyt3qN3iQa5EQtH/38o0vFOxaRfwfT349l0XD34oZL/QbxHFFGPsU2+oM7H+OlUtLv2flrZ1yYHg5+3seWfN7LPR6lGnFA7BDNYlrqvmS1kfNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pNQpKRaV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d0bdeb0374so1605022a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 14:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733004053; x=1733608853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yXqltZOaXbaCylytu6cgEm/tOOiTm+pVQLO5Vzyc1Pg=;
        b=pNQpKRaVclih2iuG8liHPM4r6qVasScL758pFnRZfbM3TF0+CMtfqvkUD+fdmvZvsN
         F51RkJ/il8n2ngdPL4eIU6EyaW+3sveXLdPH11KSlxhOZ1y2YeT6sj3tHus55HtuguKd
         LiITcHIiyizmx1TDpCubKZpizZsSziAu1yzW7Cab48isy0iHjjp/xos4RzRF+JB4ICEq
         yxqmKTymB8Y7m07Hi1Lh4auAmRCUyj8FJS7Lh8xQbo+JfOmNvFvteMzaEmSiTtjxoq+2
         0JsZ93M6bDqt1XhiFTThxslaELeXapSx8nJPU+2Fnp/ewlpK5pik4CE8UdNdqbhcRubs
         8y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733004053; x=1733608853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yXqltZOaXbaCylytu6cgEm/tOOiTm+pVQLO5Vzyc1Pg=;
        b=FPkjzPhvbaej8QEs3mjiO5EDy/+WcIrHwBt4b+YWpkBMRtSPnCzxLsE/68LOK/nZtz
         r2jwvHSFXM72Zsr6/HHLQTdufHcgr2mPmQRhBMDHObTHPJVTbZUPfJ3sjE+jB4hkVLmD
         +lEu11fEptPtSUoa32up4IG3R4zjf945btyDwtGKFUu2PPmflGymsiclCQabCvhH7sM8
         GWaxbHnAXS2/xN3g9ei8m1YAgwE2KROMT1wACvclT1PBw99JNn0Fp1RWbOJxmhwmpX/3
         MVELxfxLindSSD1hu/0Yn/yVvONhG4gKqNJTRg36R1gj/R6a569F7fbQupQXf81VeMCJ
         0rQg==
X-Forwarded-Encrypted: i=1; AJvYcCWwwIYJ3qavAZAsmYKWid9OJKGn+9U4DgPdZ9L/K4RTc1vNfQEyy5uB2u7++jk5Zouim2hzY4MwFx/F9SE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtzRQP7g7n3R4BhcmDfktk/SWsgj+LyWpa6TNrFY2WumLlpGV9
	eJHyQ1ZusR7c+KMvD80Qepe6zhCVQSEC6ze6lNQBeKfsA+e9KCxUHdg8lgk+aJE=
X-Gm-Gg: ASbGncvHsoznZOtc7xC38lfAKurMgOXhXYRG1FelElHbUjDhUwSPMlCfCkg0Ni/dRtd
	OzbuV9L4mzL2cVnmzhoiPedQPU1o0qJoCtGTLNyzDtimKym7+U7rhZqihTOP2Ws95q1ygCn47QN
	MwNWrpQQHtWTx5tb4sg3gN2KkeVVySlZyHzsizGVUjf11RzbqgnjR5OwTeuN3gsixJBzTJPPbzm
	cUXYJuJXHe3M2wtzscNih46/FOUgAFgZIVSwWgPMKF3ojvE+4bnaqwNCRTRIYY=
X-Google-Smtp-Source: AGHT+IFKToM+82d0DNr5W/JKUGy7n/psVJX2ZAC/XLf6sSDmlW9mbYvjOVqCf5/YDUUWCaNBvDem8A==
X-Received: by 2002:a05:6402:13cc:b0:5d0:ceec:dedf with SMTP id 4fb4d7f45d1cf-5d0ceece155mr2621710a12.13.1733004053519;
        Sat, 30 Nov 2024 14:00:53 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d0c6a8e9b0sm1334131a12.41.2024.11.30.14.00.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Nov 2024 14:00:52 -0800 (PST)
Message-ID: <20e62ee5-719c-40c5-98ef-cdbceb1c5746@linaro.org>
Date: Sat, 30 Nov 2024 22:00:51 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] arm64: dts: qcom: add venus node for the qcs615
To: "Renjiang Han (QUIC)" <quic_renjiang@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20241125-add-venus-for-qcs615-v3-0-5a376b97a68e@quicinc.com>
 <20241125-add-venus-for-qcs615-v3-3-5a376b97a68e@quicinc.com>
 <55124ce8e15740d1a4a55733455ce27c@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <55124ce8e15740d1a4a55733455ce27c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/2024 08:50, Renjiang Han (QUIC) wrote:
> On Mon 11/25/2024 1:35 PM, Renjiang Han wrote:
>> Add venus node into devicetree for the qcs615 video.
> Forgot to add Reviewed-by, next version will add Reviewed-by: Bryan O'Donoghue<bryan.odonoghue@linaro.org>

You'll need to drop the video-encoder and video-decoder nodes per 
Krzysztof's feeback.

https://lore.kernel.org/linux-arm-msm/436145fd-d65f-44ec-b950-c434775187ca@kernel.org

You could do that with this series:

https://lore.kernel.org/linux-media/20241128-media-staging-24-11-25-rb3-hw-compat-string-v4-0-fd062b399374@linaro.org/T/#m55b26747af4692da928ec9b531c4288c4e45c4d2

And the following change to your resource structure.

static const struct venus_resources qcs615_res = {
+	.dec_nodename = "video-decoder",
+	.enc_nodename = "video-encoder",
};

---
bod

