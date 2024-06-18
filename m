Return-Path: <linux-kernel+bounces-219493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B8D90D369
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5192B1C24EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE37E1891A9;
	Tue, 18 Jun 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eSKB/c9U"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8073E157E99
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 13:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718717968; cv=none; b=GYEC5+P3i2c+9l6sfBR0CAbOFfwv0xi2cFh5Xe1ivOJuOvpfersBGtGHejplC5mhqHePwFYdF6ykqWbwbY/VPtn0OpWYF9++qjkBC3i/dGmH8i6WQcZDXm6FHv7EZKEtzEjQnrr8jaXvvQWfAP0C5DHAM6wjyWxwP3V0Ikz/hiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718717968; c=relaxed/simple;
	bh=xLAXHgMQMkC4I+6SWvyCbmbbIm7HDaAMMfOTtmQ/nKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TAkhVur6jNRxSUiQhK1gknTxCQN7Ww7Rs0+kGHbEipuAYq9tV4Jsl4HgMiMWNJDPJtCW+I4sXNJqQcDoXbb/4Qw7Iqryw3KJYdO6YrvwIzB3m4Qpr/3LIF1/aIDVR05FTZmzwLMjms8DcGZC8Jbqx2s4h6HMx5/VR6F9AuRqZrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eSKB/c9U; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eaa89464a3so61993061fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718717965; x=1719322765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mfLHtHo2sQWrIDeLma2mLPYSbPHcNNp3U2Fc5U176hY=;
        b=eSKB/c9UciQ1KYHO7/5WLG4cA4z7dPNQ34w6nMjEDzNH4X1CD5AsqE1ELyZTqbcmOV
         OptrMfU6U5vgCx9pTM6NtsMf2M1T9mnQP96FSCQSu3gw+9KpTPPgCW5zWphIXqHZTo3z
         boQ4LdZIuwxN/8yhkMKxv24BJEkopAJPZc0s1vaZU+jjip8iPgE32oYE6CPFbIwnFmOX
         EqtAJqTAX+qMrfimXz/x6TCKjjsVAUXcM3lH8Ivx+nsxYt6esROem8diriju3332+pPw
         XBn2McycLg76uJX5+rWeEEtDnRTRclPTcTkAuCmUOIHP6w5lF4JIm+Y+634tzIfux8Nz
         PWYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718717965; x=1719322765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfLHtHo2sQWrIDeLma2mLPYSbPHcNNp3U2Fc5U176hY=;
        b=lMfpdAQ7kbuCMIc0ciSmcclKMZshjSXCNg4OHzmFTWzWLD+NNPCDuW6UErhopnL83b
         Kzu56I0jPXFBAcUX43DcXYHsyzCgd7aPNL64onDFEunry8aK10/auVYqmRKW4bWgSASC
         HRFgQfd9cKFYdk6ejN2jennU7e+PXTTW7ZtflF8ZkImT3LCFxyOA2kbsqgPdGODVeB20
         1MmbVW/kGst/7lqDd27VsYu6PZ8uRHk0SZrig0sXSh+dmtWLM38HCdoqqDZd5gz6kQWS
         mx5+3fMvtWaniL9xVpMaCR2N4qAjVX9/nsEk/GyX6cK7BVZ9V8Zllwjx57Gc5YMrTMsA
         t5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3vzbsT5qVuIxTKV01agMWXGEbK4/rmWH7CMrjlsZbxCo6arAOAjTeisy9ITkEVpAG1pudV3PPfTmNJM7D+jhiYgXvbROyRT9Id1ym
X-Gm-Message-State: AOJu0YwdFOSOB6vI7bloZHDuoxIzo2Obe1Nt26REUYN7fYBZxb1l2GVE
	ocRM7gQphmQwZVkswPr069I0wVXH2YRb1cMO3mY0onhHZmK3Ybix4cSRwNO0lrA=
X-Google-Smtp-Source: AGHT+IEwNq+zW99nzMNycBgluvGbyDMFsWVRQh70vLvlD6Gm5mcZeMUN0UL3UL50UtI9BdJHThnIYA==
X-Received: by 2002:a2e:740a:0:b0:2eb:d6a7:feba with SMTP id 38308e7fff4ca-2ec0e5c6767mr85223051fa.16.1718717962711;
        Tue, 18 Jun 2024 06:39:22 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:4fb7:492b:2c94:7283? ([2a00:f41:9028:9df3:4fb7:492b:2c94:7283])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec09caf30esm15564321fa.62.2024.06.18.06.39.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 06:39:22 -0700 (PDT)
Message-ID: <737f8c75-6011-42bc-b9e4-87806bd270a9@linaro.org>
Date: Tue, 18 Jun 2024 15:39:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: dts: qcom: qdu1000: Add secure qfprom node
To: Komal Bajaj <quic_kbajaj@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240618092711.15037-1-quic_kbajaj@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240618092711.15037-1-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/18/24 11:27, Komal Bajaj wrote:
> Add secure qfprom node and also add properties for multi channel
> DDR. This is required for LLCC driver to pick the correct LLCC
> configuration.
> 
> Fixes: 6209038f131f ("arm64: dts: qcom: qdu1000: Add LLCC/system-cache-controller")
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

