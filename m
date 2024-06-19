Return-Path: <linux-kernel+bounces-220725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D42090E647
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 10:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89DFD283EC9
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 08:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F75E7EF10;
	Wed, 19 Jun 2024 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vgXGH7rX"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8167D3E4
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718787055; cv=none; b=AjU6d8a5izeIS/Vq8JWT31EQNfcBzS8MhtVV5ajS1C5U3EdgoByg/BAayUKzUMq5uf0ID5FNo+3+ImxzqBXW6UVxwwsaud98FxmiCO3QjZEMZovbT+hMps53kMleGZ4UW/N+d2+x7y/6IhBLnTCZCHQsNy6R3ThdScf+iUQUm2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718787055; c=relaxed/simple;
	bh=X7o1c3TYSuCq5q1DybWKWIIdcYoHty2phjo0Ie4qcPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bivuBou7xy8RSKM+oTh49fp0cm8zrrbQebdO/IZdB66GzaSqVTGtLsrxy6Wf0QmPsvhzqXNlzQgfiHmFFpYYOvVX1WFeYziPGkVyr8rcJGSSMZ4CqKM+R7+Lj8uGSSVglJ5Pt3EUeuHW32CXO65CsV6JjKSOQozaug3wUzRIR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vgXGH7rX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4217990f997so45838955e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 01:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718787052; x=1719391852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XUIWJ32palMvTkwp4Jjn7mptyEJf6J1bH4hKXBn11CE=;
        b=vgXGH7rXWK4PDuHcAmvJoZ5tPZ84sXWKZhhElXM/tR1+LKZmcjH9gg8ujnrqjNxhlz
         MXQU0wNKB/n6iVCi8IOPaFDZi7HULdPWzkaIlB7DQbZCqYaG1yISW/7f8wCGmX3uCHea
         xuOIcFcg+2rymAUuGsUTSFvsXLjYbl5jf7YGPCYjfOA7hzGaZGPfbVExCe5sw7GTGzEc
         VhQgRkTwcu6cOy4JFavQWKGdeU46P/p3+N7lCnAlGHjQXzeV2/TXM/9xrjhCMQt5IIVv
         57Utr8eF7ihpuU5+Y7C9EMe8Ft0xqwaGciE62oR70hOvp4WH4JzMDrtZx5WBJWZZoLUC
         0IHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718787052; x=1719391852;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XUIWJ32palMvTkwp4Jjn7mptyEJf6J1bH4hKXBn11CE=;
        b=mdAUMWqOL6VoZQeQOxjnkezDXJZpmO2iVNtL+G5XN5BFXmxJiOkQMeRgztR+X31i5a
         30P2vD0F28Vsy9S7Btrurw3FNrVPpfppBJakm8spIqljhn5BNLwnw744rxbsSFGoKBH0
         cMHyl0pbkrn1Rj6S0/MXQTz2r93c54AH7GzKRdFvMer5/dDOyAlp+sMh2mcyV04xBwkx
         68ECIWZmcYGgYaE39A9W7x0mp+X1MduU5v7j3gnPyCzHQnDn47fOc08BGVtO0dlW1rR/
         TDdFCw94TwzskAcFzArEDC2HlG1eLFkabfDtqfHcnYEnGHLsWl0UWpRWb4HSy1wdkH2I
         KhjA==
X-Forwarded-Encrypted: i=1; AJvYcCXWcH6CtMT8Cm/UUK2B2nU0/nlJ64CeCdJypF749qNVM8rsP4rrUhQfNV6jZQxJEXRRsojKHyoFGbDptDgdGB4D0OEa4VSapTy6w//L
X-Gm-Message-State: AOJu0YwrLlqjj1CNtAfBYcrjUIEesRhPBp8kHeu0z5COKm9hsAuLSZyn
	IDnPP7P0rzKbipMfH+J8gjsoDJ9blji6pa9n7Xra060I1WZNa/Ty1lozdxMLK4w=
X-Google-Smtp-Source: AGHT+IHhHXRoQELw3jalDwH9FjoJBhvyyyppYgi8JksmI+OWBoElE4LAnzmAImeHTX1iy3NE4ZdZFw==
X-Received: by 2002:a05:600c:2ed2:b0:424:78c7:b4e0 with SMTP id 5b1f17b1804b1-42478c7b551mr5145295e9.8.1718787051662;
        Wed, 19 Jun 2024 01:50:51 -0700 (PDT)
Received: from ?IPV6:2a00:f41:9028:9df3:ea6c:d102:5e8f:d5a9? ([2a00:f41:9028:9df3:ea6c:d102:5e8f:d5a9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f641a6c1sm221661225e9.40.2024.06.19.01.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 01:50:51 -0700 (PDT)
Message-ID: <81ec895c-b0c7-4cd6-a1eb-ee3172ca5e2a@linaro.org>
Date: Wed, 19 Jun 2024 10:50:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm64: dts: qcom: qdu1000: Fix LLCC reg property
To: Komal Bajaj <quic_kbajaj@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>
References: <20240619061641.5261-1-quic_kbajaj@quicinc.com>
 <20240619061641.5261-2-quic_kbajaj@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240619061641.5261-2-quic_kbajaj@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/19/24 08:16, Komal Bajaj wrote:
> The LLCC binding and driver was corrected to handle the stride
> varying between platforms. Switch to the new format to ensure
> accesses are done in the right place.
> 
> Fixes: b0e0290bc47d ("arm64: dts: qcom: qdu1000: correct LLCC reg entries")
> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

