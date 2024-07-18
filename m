Return-Path: <linux-kernel+bounces-256725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47CBF935291
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 22:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B031C20E01
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 20:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97EEE14389A;
	Thu, 18 Jul 2024 20:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y4XVzMaf"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EA275808
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 20:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721336261; cv=none; b=ccBbsP1VvUOc0DYH0+fiAaVaWhMmE6cISzdcOywflsi5V5Qw4LpehUe7YL6mdnfesCh/r7VuriXI8jxYUCysU4v1O6RUaiBc0o+fpoxoVXXKGxewDXH8V7hVyaAzBhuKvzCMrM+itCpQiGDqj0Ll5hLITemDKQSTemyjYikdr64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721336261; c=relaxed/simple;
	bh=tAbWfIQ4v/HuPHVEJge1CzK9VejlF4IPKDtclv3TUFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZLMUyvmYkGGrv/XX4qVKxTgM7O1a/xJ92kWKyVLkklBSduARBEfJ/8Qqnx8z1euhgyXwf3tld/arBGHtyKK+McbDJEx/eg7WUFgxeYtHlE4HPBwa9SehlDYJ+sbspb/1M+aIZEdETHrl9unETwHG0JiQVpnTEaYlIy8wLWX+54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y4XVzMaf; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ea79e689eso1409630e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721336257; x=1721941057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jt4qMEVwM35lFX7t2weYvu2/XW9ujOBzqearuBlFYJA=;
        b=y4XVzMaftnfDmsaFWC/eRYFOQlpYCVih7cFAF/CzvCNJ3v36njPSVyMvo9FvF1T8ar
         cMKEhO483mkwIjssRRHobgutyOHboFlE3jNIqk4XE9U/qzmYZbAG0iqrLeQBtXPNEhyd
         lbsfnx8ZsETqA1lZvAqsBxS6+G+vRXyfPxx3PI7D+cXnCd4MsADerlM0nw8C9Azipv1L
         /WnnQe+OBHtzypMYileVh8ciAGebHhW4Ypo9oLMKox7ABLYexmsgLHVCggXI/J3mcsLf
         8uR2qfgYGeNG9IMFpjm8a+44zQhBKs4ebZWM+XUqNLvlibA1YDVGij1sG84OECnDuToh
         nuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721336257; x=1721941057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jt4qMEVwM35lFX7t2weYvu2/XW9ujOBzqearuBlFYJA=;
        b=JrPbkD42fyCHWhKrjj7hhh+/sVrAPXR6M4eJPzrU09riZpurGMdvbBR+isDZrVcC4C
         LB+Y6iJRPTmVUgCQhDp2Miv5mlksOHOIeRnSBp3Vz2WM7fTvhJkZ6l+3gePZXIKtWjrk
         pBE/xpl12ee/XgWX85VMN1+sNmNNTFkqTs10rAISPBbMt+DGdKyl76zkKtPnpYvYk+N6
         D/U0dQNBGCVHyjC8caz/1jV96LMpgNdZu7yByoDy+5jy6F4blrXxez6Q5MFfvoNnHFNE
         1QiJJbKUIKGuiPHkY7gIGiUwpzbL3uiqOpNMBGsl2/vkxUrAwe9wwdaM7Yp4pXbqZ/I0
         h8EA==
X-Forwarded-Encrypted: i=1; AJvYcCVHGz3k4lTU5fdzNf1UgDGeEKMcgrKv4q9TVhJpOve6m8wfY63wyOXrUZyucirMUHbhRtr8JtroJ80hn3ZCibuvzfkTJ6ZmiKA1wJ8k
X-Gm-Message-State: AOJu0YyS5bUO66e/KoUUeMQ1W2DjZUZGLdEY3xZxyOiIdwytqNN9TJ9A
	TeVLRKrJ4/oEfjHpGZDAxx+MoMTtEAbcqXoiSyfg2OgJ8h+kHbRpKdGYMG6gBiA=
X-Google-Smtp-Source: AGHT+IFOEhmrc8/7gP/gyY2lxQaJjz0l0DPkZEGt1Jaui5UPWhGGxU9XXD2bP5LA9cGX048zWkpoOA==
X-Received: by 2002:a05:6512:10c2:b0:52c:8342:6699 with SMTP id 2adb3069b0e04-52ee5453fd4mr6044046e87.55.1721336257180;
        Thu, 18 Jul 2024 13:57:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef07a044dsm196680e87.285.2024.07.18.13.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 13:57:36 -0700 (PDT)
Date: Thu, 18 Jul 2024 23:57:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Patrick Wildt <patrick@blueri.se>, Kalle Valo <kvalo@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Steev Klimaszewski <steev@kali.org>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Johan Hovold <johan+linaro@kernel.org>, "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>
Subject: Re: [PATCH 0/2] arm64: dts: qcom: x1e80100-yoga: add wifi
 calibration variant
Message-ID: <gb5ykva2z2kkn4w4xnpbpkfthglifkygsbwplmqmd53hlxpqlg@gv7qknl3uuob>
References: <ZpV6o8JUJWg9lZFE@windev.fritz.box>
 <d44fdc0b-b4a7-4f36-9961-c5c042ed43df@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d44fdc0b-b4a7-4f36-9961-c5c042ed43df@quicinc.com>

On Thu, Jul 18, 2024 at 07:40:13AM GMT, Jeff Johnson wrote:
> On 7/15/2024 12:38 PM, Patrick Wildt wrote:
> > This series adds the missing calibration variant devicetree property
> > which is needed to load the calibration data and use the ath12k wifi
> > on the Lenovo Yoga Slim 7x.
> > 
> > Patrick Wildt (2):
> >   dt-bindings: net: wireless: add ath12k pcie bindings
> >   arm64: dts: qcom: x1e80100-yoga: add wifi calibration variant
> > 
> >  .../net/wireless/qcom,ath12k-pci.yaml         | 59 +++++++++++++++++++
> >  .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts  |  9 +++
> >  arch/arm64/boot/dts/qcom/x1e80100.dtsi        | 10 ++++
> >  3 files changed, 78 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-pci.yaml
> > 
> 
> +ath12k mailing list.
> 
> Qualcomm expects, on x86 and Qualcomm-based ARM devices, that this information
> come from ACPI.

Unfortunately we can not use ACPI on Qualcomm-based ARM devices. They
all are manually converted to DT. 

> 
> That support is currently under review:
> https://lore.kernel.org/all/20240717111023.78798-1-quic_lingbok@quicinc.com/
> 
> /jeff

-- 
With best wishes
Dmitry

