Return-Path: <linux-kernel+bounces-422252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BF79D9676
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 12:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BF5288DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 11:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E7D1CEE96;
	Tue, 26 Nov 2024 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/kneQym"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44609193064
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732621762; cv=none; b=BF1waS/L0gudZNNHvvhq4s7CegYP2HsVrZOx9wvuWioUq8IC18cmfj3gPY76lpJypu0q3zKeb/2tXclcLU8Itn1iF2uirUghKUOtDLIKap4jWLwvwD3uDQgI/itkPn3MyUAHx1K4aicLTYR61+Xp+7Bwl8o8eNrRyuUZw1Z9BLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732621762; c=relaxed/simple;
	bh=UGw0zzCTxmWhjk2Kr7lUkghqevSUdxS2ujFgteFo7bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZjCRdq1Wbg7XSuyyrt7s6Y8T+YkcxeZ3Ct5r5mT3+gDEIiItHV1tOkeaKeGCtwr1+ck2QiAkzsdkYYIKzaeS0FlPGZqo/PPrNwHdXF6AO/LIS4VTuyVPwbL7+BrOR8jq4BvbgFXw7Ct0qSi0kgnG7DX7vMHLKLqitmGfXbz9hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u/kneQym; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53de771c5ebso1687083e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 03:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732621757; x=1733226557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qbQUZzbSmChhIBAFL2qH1RGbuk5eGQ4M+u90/hV2Yco=;
        b=u/kneQym9SNLuY38M0eMt+LwbmDISko6PJAUxodZ4o+ZyMEyEXNrEB5htcPL76FP5g
         yNEKs15e0xgUG93NbHOaRLM3AEwQP8BU1RaU4UUwgXvjcBuLYTMV68MucNjUDQCmsxEj
         LM5SutlkYMgVR82ooMhKHsO2HRiOFx9vaOAHwzI5syudolkhpPzGgRZjMWo0yG3k3pUk
         FKZ6784j1bFAq8Q49UMZvW/SBecLohZqLiQOkHFwGpuFKmQo9o45+6amsGZiDvjYnOOt
         dUm9OVcxcmGYYZZhtf5dAemWEtNWPWxVPVPtid3PsIVnBhtVXALoSFeh0t2PjEoP6ofb
         2bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732621757; x=1733226557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbQUZzbSmChhIBAFL2qH1RGbuk5eGQ4M+u90/hV2Yco=;
        b=UhK1LI2xCrQD7DVglFRDDJJJm5BLeN18RpZfjsvwSXs7QOk+5HFY1f5CUB8U21YtUg
         UXhVevHxFu67EQMoklwZpXC7qQImzgpHEZkNaId0fJL3oLbTAUN2V35OqHQBMqF0And0
         dWXPo6kjagguPzxffy0FlhQ/vTKtU0su5sFUopkd51LXFFx2QXMuFvB26Q+8uQ3kkBvr
         yvIOFIvOn4K6JTDkLIUHug/wx0KY94Wyzm7M0MwIUNhhzDVapixbiPn9wcqfyyIw1T99
         5plQZK0JauehEKzBRh7smixe2rVCJJa0TfPME6Ho7do9STdmny9xD+69ivE3cIT3c6Q2
         gxIA==
X-Forwarded-Encrypted: i=1; AJvYcCU8WEoF7T0oBmhhroMgULPLXQtsm6ti88JmJ7NMUVSpCNbBW+UrP+iOkfMco8CuDcK+b58DRpSDKLJJ7sQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaWCSeD6OjPCMDmeRIyNMuTsyOqJ/YPIaj+O2aMjDi4vhqVtK1
	dG2Kv97HHP3BTZA7qfug9x0RmxPx2BSPjWd8rJc2SFuf2PglKCm0pAy8lC0MVSA=
X-Gm-Gg: ASbGncsvIHuRdIJF44dXg0vx8DFYrI/iooduiVdcONLAFScxb+5cuQC/sJNZ6a9XkX8
	40PROXG+TcSFTTUkWhJ87pkfJKGB/uWM8E4JEaZXwtaWr89kIw8fhJG0ppSBb+z5p22jubZ2eXE
	Znwg6q4cIJ+5TKMkWJBt44190/eYHmUlER2mOF6oisJQCpesoh8e+L5BRjPDPkL3rjbGvoff4uE
	6N6vQxrlm2zRiuavZW1ftBElAiTq1RUEXuZKnEe52zhk03Rps9kMdxYnM7fEKBHXVl1IS/ZAgcp
	bvhiTiCkfvUM9IrH5V6m2ku2aSxxLQ==
X-Google-Smtp-Source: AGHT+IHASf7kbq6ptV3Ip32BjIMPh2Df4iR7dpz+DS9GMEkuPq44nPlThPmRMDSlE/KTqC3KTABcig==
X-Received: by 2002:a05:6512:b17:b0:539:905c:15ab with SMTP id 2adb3069b0e04-53dd3992d93mr9289024e87.32.1732621757253;
        Tue, 26 Nov 2024 03:49:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2481424sm1996842e87.133.2024.11.26.03.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 03:49:16 -0800 (PST)
Date: Tue, 26 Nov 2024 13:49:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8650: Add 'global' interrupt to
 the PCIe RC nodes
Message-ID: <vhyqpnparlikqpzltdi6suo4emt7ezyawgz6neyjssznlm7ank@pt7cryux7jbp>
References: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
 <20241126-topic-sm8x50-pcie-global-irq-v1-3-4049cfccd073@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126-topic-sm8x50-pcie-global-irq-v1-3-4049cfccd073@linaro.org>

On Tue, Nov 26, 2024 at 11:22:51AM +0100, Neil Armstrong wrote:
> Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> to the host CPUs. This interrupt can be used by the device driver to
> identify events such as PCIe link specific events, safety events, etc...
> 
> Hence, add it to the PCIe RC node along with the existing MSI interrupts.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

