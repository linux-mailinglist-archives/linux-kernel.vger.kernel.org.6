Return-Path: <linux-kernel+bounces-227319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F87A914F57
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEE68283A96
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 13:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA28142640;
	Mon, 24 Jun 2024 13:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/7c5BSw"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0435C1411C8
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719237464; cv=none; b=aDwCaUyp/epGDGfB3/4M9h2C0ys7bC9wtYc8MBydpyP0Y5PaYu9M/TEfbLmkudNAre6hUdcr1mW9z8tRkkaOL0FVjsshSA9mpwwStHkg/eB3WAp5h6iH7FjGaCIM30CJMV0Tuq1gI14Z1tLfb5lNSXYHo5JZwzHuCMNFcAsXlwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719237464; c=relaxed/simple;
	bh=GFIi6zv2aihNbVR53CK6RvA6zLzaLwbCY3qxAG56vbE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oB6djadQYRUZGtbCrgPWoepAjSlfAKSKSc6MGPb1Ejkd1OBhhxruSb/C49+jps2JsVSYrUt4CSeCl95b0c893hlpmWtBF5ox+boYi7z/cLDKUHIIl1gAhRJ6A9laipYMyd4Rq+3vOHLzUu0iY9kCIqisS0HfMlfjlV8ucHRN7s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=I/7c5BSw; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d106e69a2so3965213a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 06:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719237461; x=1719842261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IHD4jJpcuG4tMgpp91267iJ5OoLxZWbXVFw4XaeFi2c=;
        b=I/7c5BSwfn9ObTM+7DhxM5SwCs/sfajtsRjao/ThsS4aOUnlVS3Opzuxh7vep/otNS
         kqhTSPtZLV8d0AmIJDRdSBmLrqEHbxDNRj/iQiJwWfo9wohdbtemYStZn505XqxZ4zv0
         cEvP4xCBnmZUCUZPRn1DuaV11xJS2GORfOPJG6+APLHpDfgQiofxyinYJ+Anqh7pI0DY
         /tuoEgZi55VVE6yqUes4Qf/izCjgCDY/ckcQ81sGSrfuw35nADZ1dDYlb6tiFyMCziqU
         muhv0EcTMnXbs8UxwZkqdGlHeCdZ5zusDpelTHpluSGIvB24i+T6+WbmrCdFPtswH4ST
         z/RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719237461; x=1719842261;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IHD4jJpcuG4tMgpp91267iJ5OoLxZWbXVFw4XaeFi2c=;
        b=t2s+0TimXDQlqHAgJ709d3xq3f9IwjEnkEy8ThObZ7CMfz3eEvqcXfKXP/LrbM0whS
         GJrRdjRM3lsYPewYRhI8fG7S89K7WDJw9glb/smeNZ2zbRU6lVtwupqh3MebarDV2RJZ
         xqP0AKiSSy9x6ogsZvJWbDAob/7kHpzjyYPx+FOqfSOF4Nrj86UtrsiUv6wGlDdT1u8f
         f7kkJIFErdRHq61PoQ6n+2sp9DJcAGzIKMgvILfZZjIl5gMxQtKpicyVTS5ynT+civ5s
         +LPcGvP5Q3AH9zgWxFqIT8/5Ueu9jfejzUZZEbGXI2v0C5GRE8CrPY6Hse3J7SX6KKHk
         yYmg==
X-Forwarded-Encrypted: i=1; AJvYcCV4OH7JMPde2krPoeEqZzgr+m5uwWvSGTxFucYfKXtE5fZvwGPd07DA5reuROiFTW6QkcGc5+JOtoJXfrYIC6ydzjFy7amujydc0SMC
X-Gm-Message-State: AOJu0Ywhoz/LjUNf8DMT49beRqgNSMjDwm9yWW2WZTN01ATMTPltPx+2
	sH10Bj7lLjfIp31zIsrY1bP9H0TQxFojUDP01TmtZqQO0EwmOo8xRbZRGIVbD64=
X-Google-Smtp-Source: AGHT+IGpGmgITj2Vbxhko8ZELCw5TU4oWE8gTzKLF+hMftNzpJ304FkSkyvJfotXe68/KgaWnf31Rg==
X-Received: by 2002:a50:875e:0:b0:57d:4692:ba54 with SMTP id 4fb4d7f45d1cf-57d4692bb51mr4569953a12.6.1719237461074;
        Mon, 24 Jun 2024 06:57:41 -0700 (PDT)
Received: from ?IPV6:2a00:f41:c03:9198:7df:6a16:3e8e:ed7b? ([2a00:f41:c03:9198:7df:6a16:3e8e:ed7b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d66b04378sm405692a12.38.2024.06.24.06.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jun 2024 06:57:40 -0700 (PDT)
Message-ID: <f5ef4e3c-66e8-4833-86bb-c38658b923ae@linaro.org>
Date: Mon, 24 Jun 2024 15:57:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] arm64: dts: qcom: x1e80100: Add gpu support
To: Akhil P Oommen <quic_akhilpo@quicinc.com>,
 freedreno <freedreno@lists.freedesktop.org>,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robdclark@gmail.com>, Bjorn Andersson <andersson@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240623110753.141400-1-quic_akhilpo@quicinc.com>
 <20240623110753.141400-4-quic_akhilpo@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240623110753.141400-4-quic_akhilpo@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/23/24 13:06, Akhil P Oommen wrote:
> Add the necessary dt nodes for gpu support in X1E80100.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---

[...]

> +
> +				opp-1100000000 {
> +					opp-hz = /bits/ 64 <1100000000>;
> +					opp-level = <RPMH_REGULATOR_LEVEL_TURBO_L1>;
> +					opp-peak-kBps = <16500000>;

No speedbins?

Konrad

