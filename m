Return-Path: <linux-kernel+bounces-248922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D524D92E3E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 11:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89D5228199E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9065215748C;
	Thu, 11 Jul 2024 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GpAK8J1c"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFB4155CA5
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720691744; cv=none; b=BZXHD8dIOI3yj53iBQfZ0VCytsOfEG4UO+8d8eClIwr8j8kTjIbNg8Y3VJW0MQMExDLBjytu6nEnP4gJPF9MEQDcdczR7SZMat8KhKzX58yLPAT5mLIi3daMMpGZ5yolOA53S9BqwUN10lksUHUQPsJwknRZ/Rv7ZzHuEdLBlBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720691744; c=relaxed/simple;
	bh=yYWC/VveCTOiGUoQj5SkfspQMI1tcDAhWmZ6kBA+/YE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nP7eyz+xAZrMtJ7C0dSwpZyetztCJx1DOtI4LLvdR39nW9PevmPyZ14bNsmOC3p4GYh7YDJFj5fMlsucaV4MjEpIMxWSm2Olf+r9UjvlbtrXjDLRbGvpvsVwT+Z120p4hzBvzAbJzfD1E+dfOCpufNPdIuTVpwvCjZFtLlQXLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GpAK8J1c; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-58b0dddab8cso1245089a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 02:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720691741; x=1721296541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=maLqMD3ICvk1EK1NREQo247Hu1y1Wvub0TIIfxIt6Vw=;
        b=GpAK8J1c5wH9+cIkvnvEGOII0m9UX4IZ3OH/VRprbJ4K766BCRRlTvPNvYdYacZ4c/
         2qGPL1FxH+EWfaBw1Z5CXMKcJzVJ4JtrUfMTiLvCjhaSRL0L5ZCfgCPuYHpQI96sSUKt
         A7P2q1YeviwGBRtdOvTDEuwCqQnjkPRNqfSR3i21g+CDCrTIDFpBeXQnW92jPjuS5fmw
         CM7PsYWyLtFAqZju4zmnzsC4sSa019ugXpRu81sIfuFOgKra7oJ8MQbQIiu+9SSiLCGG
         nUd/yLZx/d7Xi9u/5dLOMuaXi6Lafau+/Vz0Dz1So8DaePQuuuQZSnAM2JIvWRFTp1WB
         /z8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720691741; x=1721296541;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maLqMD3ICvk1EK1NREQo247Hu1y1Wvub0TIIfxIt6Vw=;
        b=Nt9gG1gpSX0otx/2XGDu0QDgVgalQJNbHhe/kCEA4wjgYG0ew7on7Ukf10ZUh0ecB8
         PQJUy/Cge+EdVpvVGFC32tF3vzWxIHZS3pmBR4Snvsdl6AJ6Eubn+gX6kVowB9fBnThk
         1KG2v1TDkC4SmZXWJ51DXdhkwiPHzWR7fo9mRzzEsJnHipYCCSxjqauj7oauZk94Fc6T
         yQMkwT8zEYcvq1V0c+6ZJovVIfv4hp+6/WkKXgu/NH0VUKh0vr1ONlQpU5VuVgs1Umnb
         WrkZhJ3Svg+R1hWDgs5mmBBUyHhF5W8B7XkxPJvVXx2D/D076BcHzq1XFDa59/r9BoIt
         szGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1QzJKG/A/g/w/144fFqi2Rb6tYCSgi5UqlqG1XsE4lbm0SRHEjRhwHHc2lVfMCJ6iGqsa5uzD/5k6CVr7XWR1v29oLCUUzAWk/USa
X-Gm-Message-State: AOJu0YxtLckz793lQOdLVFREI5Nt2bETaWfWSTF/qMq1xrWyMpN56a8t
	I2OMMyRiGtLJU1XtDvfY9PjNzQRVcaX5hKsiUS+BmM1HgqE2CLcoil9PvqXmHo0=
X-Google-Smtp-Source: AGHT+IExGLqNXPyV85QLGJwuneesorCc1iI3eg2vhxQ8Am7jEngbHqpcbHnK1n/eI7Hqf5CY4Tsk9Q==
X-Received: by 2002:a05:6402:210f:b0:58b:6096:5554 with SMTP id 4fb4d7f45d1cf-594bcba7e40mr6465201a12.37.1720691740940;
        Thu, 11 Jul 2024 02:55:40 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bbe2cf93sm3251364a12.33.2024.07.11.02.55.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 02:55:40 -0700 (PDT)
Message-ID: <95a835e2-9fd9-467b-bd0a-8eeb80ddf678@linaro.org>
Date: Thu, 11 Jul 2024 11:55:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 8/8] arm64: dts: qcom: sm4450: add camera, display and
 gpu clock controller
To: Ajit Pandey <quic_ajipan@quicinc.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Vinod Koul <vkoul@kernel.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Taniya Das <quic_tdas@quicinc.com>, Jagadeesh Kona <quic_jkona@quicinc.com>,
 Imran Shaik <quic_imrashai@quicinc.com>,
 Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
References: <20240611133752.2192401-1-quic_ajipan@quicinc.com>
 <20240611133752.2192401-9-quic_ajipan@quicinc.com>
 <76f5e3c7-a90b-42d2-8169-e5e2211a14a1@linaro.org>
 <ba7d12d3-c582-45ec-beed-e81182fe3252@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ba7d12d3-c582-45ec-beed-e81182fe3252@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3.07.2024 11:16 AM, Ajit Pandey wrote:
> 
> 
> On 6/13/2024 1:11 PM, Konrad Dybcio wrote:
>>
>>
>> On 6/11/24 15:37, Ajit Pandey wrote:
>>> Add device node for camera, display and graphics clock controller on
>>> Qualcomm SM4450 platform.
>>>
>>> Signed-off-by: Ajit Pandey <quic_ajipan@quicinc.com>
>>> ---
>>
>> None of these nodes reference a power domain (which would usually be
>> CX/MX/MMCX). This way, the RPMhPDs will never be scaled.
>>
>> The current upstream implementation only allows one power domain to be
>> scaled, but that's better than none (see other DTs for recent SoCs).
>>
>> Konrad
> 
> SM4450 doesn't support MMCX and CX/MX domains will remain active so
> power-domains property is actually not required for SM4450 clock nodes.

It's not only about them being active.. some PLLs require e.g. MX to be
at a certain level, or the system will be unstable

Konrad

