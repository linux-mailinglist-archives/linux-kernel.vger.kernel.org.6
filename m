Return-Path: <linux-kernel+bounces-423540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 609D79DA95E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 14:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F341CB24126
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 13:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FBA1FCFD9;
	Wed, 27 Nov 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jjlTojNI"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2769463
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 13:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732715584; cv=none; b=u78k0yoagmgD6UJGMthjTKxzg1OJhw/JPGPxp65TEf2/bOHolfaqCQgFqvLIS893HJkNQf2kd1WgfJ7fQJl7fWY3R4GjY0DQv+jCh+jp+NvbxfywAY4eBhFah1gQ9oc/TfkF/7t2d1EhFclZPuzSk+2AwbcOjkTiNemchcvi6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732715584; c=relaxed/simple;
	bh=4Cw79OlSsmeWvc5FvG9UqEOqdIJZu1hBHoIJTBQ2WY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tvv8SiYjsl+8YDwEidEApzTtlQK8Ci7tFxJJ74aaNcv3A5dd5b52V2/JMhJCVJYfGUA0Gyjek/DSSoUy1ttbhniVni7iXLDkGFmSkgypyua800Z5tJqvQrFjSSoG0g3RCUZCTljQ+VeS45numlpLyjC4RWpWzYrI+Ihh5BUv30U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jjlTojNI; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53df31ca44eso292592e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 05:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732715579; x=1733320379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C4TAQTX45KjbD07bV+ebD3Bm2L1TSD7dI4Xlh2Tdxk8=;
        b=jjlTojNIO+qNFCKQKQSqC/qDcfYbUDzhnbbmLIs5+NDriUQn5HY4m9ILS1SKSlqBvE
         qH2m8BHLwzfzVH7JFBcClX08/3LfpwnbdoOK4YlFGXgUHfdFE6oYVgmrGYmbk6kdvrTb
         po3gk8fYwpPUScdISpxnJpNmxhJuBfLLssN9ighsBtJHIv4ZaDxHk4WiQr2Me0vD2NXq
         ZQwqejJ3C2soZDSerXVr0fE2z18fAoC4JPgplL6M2P59fiToSLkzsc8kqCsP0u2F2b78
         Dj2D4FoP90w4TzJpSB2p9UA9jK9+kHKs8n4ToAUsCm8WZ6fvrtOu05tBhLdUaEyg34h4
         ZYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732715579; x=1733320379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4TAQTX45KjbD07bV+ebD3Bm2L1TSD7dI4Xlh2Tdxk8=;
        b=sws3iusieM0KQjD7oyd06KTl+473H0hJYxgA3xWdbRJgV9v+91COqfDPjh+PPMYVzC
         AZYO1dLyGJ1aJRixQsn+7hRoVcKh4ZpYB9f74GAevFKa0i5Uhsdqk9XEiiA3u71OtmvT
         b5xmdo9YIPDQ49+IeZ4s2Vq/C/YVT2Fy16WruOUu8KsERZvv07cXoHWlfh0MEELsF1s8
         0RUriDAE9b+kWxq+1Xdo2e+Y2zlNwSWR0JbC1ESpWAJFjg0n3UBrBbGvUTeETTCWuQIi
         HijMXlROAW6WmnXAXrJzBGH5oSc4Ts99BbY+1sFtAPPbW2bK/6N8MzxbiLwuBQectU0k
         n5Wg==
X-Forwarded-Encrypted: i=1; AJvYcCUdh+kjrb+M4WFDhx7w/rXtyw8eWIEfQrmwCa8PNZNinLtTGXOIs2BWPpd4z8g7ZX1gEXxRdYwSjSlQYwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHLZia2qZQqmOP+meaovWCPZktQw4pe+Puzz3g0Bz+harJijad
	8XNnamAOEcxr5axnVNjos8oYiHyrOKLQZNoO95UDXGNGa9yurOpCIa4ZW6vtoak=
X-Gm-Gg: ASbGncuxkd4hzc0zzIX5QYUifp/J0R2qrevxSI2v70TdCZFLVT6ddBYj7RbtX+o0xI9
	+2kNu4p7zUApQd+pZ8fXaLjgHgPB2rSHZWh5L0bd707bPhAoZfBkHXm/5C4HvdgHTNjUkJ6L4+c
	f+bBEjux3iTWlfRZv3Q4G6kBSFRAMBrxbIsh4qHX0d2lzMVET+gDQQI76eXisJKcZAN5+J/z5U/
	MLsbb8DpaBMzvBtWivxdYJYUDsN1b5od1prGIThrQ1E+NHG4Kb1N8vWm6Me1PLqQmPC9WcBF3Lg
	I5BvP4KWRjF+ZFcCGhTQIStUsFH8gw==
X-Google-Smtp-Source: AGHT+IGYADuFA26pMJrHLMzO1jvXPbYIAXbhv0Ob6Xw8c8Ir7HGjlq9gt3AUm5PCW3k8fSZi76WMOQ==
X-Received: by 2002:a05:6512:3c89:b0:53d:a2cb:349e with SMTP id 2adb3069b0e04-53df00c5ebamr1944019e87.4.1732715579361;
        Wed, 27 Nov 2024 05:52:59 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd24518d7sm2314321e87.80.2024.11.27.05.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 05:52:59 -0800 (PST)
Date: Wed, 27 Nov 2024 15:52:56 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/2] Enable Bluetooth on qcs6490-rb3gen2 board
Message-ID: <sntzr75d3by7ignomcrcsmzqdtbikonyuwj5niccuenoxndaxb@vhu5en6hetqx>
References: <20241127115107.11549-1-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241127115107.11549-1-quic_janathot@quicinc.com>

On Wed, Nov 27, 2024 at 05:21:05PM +0530, Janaki Ramaiah Thota wrote:
> - Patch 1/2 enable WCN6750 Bluetooth node for qcs6490-rb3gen2 board 
>   along with onchip PMU.
> - Patch 2/2 add qcom,wcn6750-pmu bindings.

- Bindings come before DT changes
- Driver changes should be separate, one patch per subtree (so one for
  BT, one for pwrseq).

> 
> Janaki Ramaiah Thota (2):
>   arm64: dts: qcom: qcs6490-rb3gen2: enable Bluetooth
>   regulator: dt-bindings: qcom,qca6390-pmu: document WCN6750
> 
>  .../bindings/regulator/qcom,qca6390-pmu.yaml  |  27 +++
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts  | 174 +++++++++++++++++-
>  drivers/bluetooth/hci_qca.c                   |   2 +-
>  drivers/power/sequencing/pwrseq-qcom-wcn.c    |  22 +++
>  4 files changed, 223 insertions(+), 2 deletions(-)
> 
> -- 

-- 
With best wishes
Dmitry

