Return-Path: <linux-kernel+bounces-442184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C0D9ED91E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 22:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1AA164819
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 21:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD5B1A2872;
	Wed, 11 Dec 2024 21:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0972Ano"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDE41D63CA
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733954155; cv=none; b=u8MaLeHQ14uGUca/mCYF0+S8tAeFHJn+90NwkNiTa/tpOPa+qXApNGIPbCQz9uxz47NmTLK17H/geEOUEGYzvTCJ069ycTu11j7rTrbAXsc6Yb/L70yJ0VYSDfw6ni6RJBKC8dBJDzm1HH9p0fpph9XrpXMb6qOIf7b9IJh7YFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733954155; c=relaxed/simple;
	bh=JjNDGyhZRcofBHcBLf7je5rl2TBTgB1GQVEGlYse7mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ODIL3epRQkf85rGQtLFeOtZM8+VW6aZ4T7/Dy+e4CnaAkBUVYTb67M2urHxw7hcLSoxeOzpNl3hAseOY1QyzGCuhyfIrNF6WuzxnLJ2W+Gof7zIb28pXYz2O0251eSQTgZrTzW/+HSxKybUabH240y5CN3yaekfdqzakwmu72Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y0972Ano; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3862a921123so4317790f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733954152; x=1734558952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fEL/ngtdEw8neicpLCHejnO5DowOyBjzk0ap1ZcfbTY=;
        b=y0972Anov0HOMt71WrAg4DFLKd8ucDNo8Fiu8pwjrX44xf8BCxJeFmbzU7BMy+Pvjl
         Y/c85nYA/K4YIZZwyD3ieyS1uuXb8Ux3oVgo5HyS/KHvll/RpkPbalOzCA3jEV5pB59p
         jDj0J/MkOjyUns87p9ca2tdmUCgH9zJ90rjzjXYzaiujU416PCCZAxWWufaveRLk6RAW
         Xi/yN0Manfv3+wH5dVqgIOqD575CLYoKSdkOl+haC5zy8MTQr05i30R1uL8MnYsH2eI1
         iGaev0x/emdQgEdF7cddeLewgoWaApTHG4B+QoSLdyvqD8TOarmxl1Ji6q7JOSlIckbq
         BRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733954152; x=1734558952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fEL/ngtdEw8neicpLCHejnO5DowOyBjzk0ap1ZcfbTY=;
        b=HP1qKUdK5MVBVanRDsZcfh6c14FPTBSZZT8RZjgalF13DJ4ThXxjK/UOyC9BNshvEu
         HluxO4JBkU4ay2+RpgDETciTWnHnikrGrxmHMyXCE+72T9vTEb+UEY68U9oqR8vJY0gH
         E1po7/BsKYWCSYj2IrnF0iij8IqXiRtEymCJ8UCA/qmLnmdLRQ2icx5IiERFbpRsa4xz
         LZsZYN2SOaMRMSs+ZdQV0Wl29QL5yEmMcf6Da1gfLjKvHQMtbUwSxMyyTadJV9pt5P0r
         +o0N9SZHGESpmec74dK+nzGuYoLNn4k3uNif96zzdg4LWimjmifiKJdWf4nrXJW7OKvq
         6DVg==
X-Forwarded-Encrypted: i=1; AJvYcCXYobRlrNyBGUAakzngPVyN7hGerKHFkSQ+p0NPBnYJ5JvQPos2YZ7nPx6SpyJ7pptdwdCjwm4ahDAa7GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaEmt1LxC3k4ZnWziI7sTQgzSxIXtkVJ74Hqi086NFxKqV+Ejd
	k/PzYPIP0jH3VbgHveT1bUHt3/owD2UHrgzmLfGbHjqM4hYc6/4I+jzQtwQS8hs=
X-Gm-Gg: ASbGnctW4qiQpQuhAkWYA3yGGICKAV+fI+eQb/Y1yfaJ1UOp92M9WAkm9ZYPhEPzvjI
	6V8tnFQHrfDvZk5iqakPTZ1XUCHmu1NmoucbJsUTYBsmKjYseV1ekkmzwCJSyXRFg8fop9LUQyJ
	jGnlPvA+GqJaLpnUdh4jZsS+5D/AWHHGSijf58SkywMGDDrLYpEAhUqUfOPUt/EjCN/EJJ1ygn0
	kE38abYOIf4AJV0PM4KrWg8ykJ4Ue7ZSIbb5cRvHNmokAMi2R+TVh6OIrKRvhQx6lU=
X-Google-Smtp-Source: AGHT+IGuZnMKThgf4eD8YAuWutLkKfQCQWNUHlMDV+U1hMo6NUpM8D0pvxDc/5kFCuDbLvPC0Vi7Uw==
X-Received: by 2002:a05:6000:4911:b0:385:df2c:91b5 with SMTP id ffacd0b85a97d-38787524a7amr999734f8f.0.1733954152175;
        Wed, 11 Dec 2024 13:55:52 -0800 (PST)
Received: from [192.168.0.27] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a5005sm2192808f8f.41.2024.12.11.13.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 13:55:51 -0800 (PST)
Message-ID: <86015568-a283-42f5-a8c0-6bfdf078bc91@linaro.org>
Date: Wed, 11 Dec 2024 21:55:49 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] media: qcom: camss: csid: Add v4l2 ctrl if TPG mode
 isn't disabled
To: Depeng Shao <quic_depengs@quicinc.com>, rfoss@kernel.org,
 todor.too@gmail.com, mchehab@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, vladimir.zapolskiy@linaro.org
Cc: quic_eberman@quicinc.com, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20241211140738.3835588-1-quic_depengs@quicinc.com>
 <20241211140738.3835588-12-quic_depengs@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241211140738.3835588-12-quic_depengs@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/2024 14:07, Depeng Shao wrote:
> There is no CSID TPG in some modern HW, so the v4l2 ctrl in CSID driver
> shouldn't be registered. Checking the supported TPG modes to indicate
> if the TPG HW is existing or not, and only register v4l2 ctrl for CSID
>   only when TPG HW is existing.
> 
> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
"media: qcom: camss: csid: Add v4l2 ctrl if TPG mode isn't disabled"

The double negation is confusing

->

"media: qcom: camss: csid: Only add TPG v4l2 ctrl if TPG hardware is 
available"

---
bod

