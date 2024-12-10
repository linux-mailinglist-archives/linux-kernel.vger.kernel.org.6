Return-Path: <linux-kernel+bounces-439314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2CB9EAD86
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 11:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E2EC161FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934FD23DEA3;
	Tue, 10 Dec 2024 10:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lrh5JUcX"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C1D23DE9D
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 10:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733825030; cv=none; b=MN32wHEAHyIM6T9SXS0F5a59zD0+MTgwjyzbAJSJqH3bw+vMcCqq7oMOj9+1XenbIpdMYiQnFNBk6caP3stK2SeesjR8nEPaVrEYj5KekLG8YKSXRbe04W1yMM8Rt880fTYL4GgVZO2Dw0A18gccKQZDCFiyr5AbrGvB3rOUGMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733825030; c=relaxed/simple;
	bh=2NGaNIcyHT/EketuOy+zLUfHygTrUDmbTfcEm9KU0jM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1FTzpBLp0lGZe71Peh3lnr1ouu8vTTkit5TYXhxja0EBZorOqrxBBE/l67lOy1Ji4/qKo2tgVL7fdS5tNpOAXtpKz+S2vz4msYuYRLUNdZOfhxfax0NysDXkoH+StM9xjogUTSdxKgk5kzWef4ZLk8SPJaZ3T23B64B8XkU3Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lrh5JUcX; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53e3a5fa6aaso2866007e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 02:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733825026; x=1734429826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lW3VZV3IbhiRxa0/ywOK4fnntFU6GL/zecF0WLK1Tbc=;
        b=lrh5JUcXVISdmm70pOvCWF9/F03b72hl+EQ6Y2Yzi0FEYWrVwXgGlrLsei5mUMy7xx
         KdcjYWDK1MnHDXmHcyFsKyHhqWyMQ+p/9BITsEd3xDFf3FvTHIcudSxEU8Ez3ADkKeLw
         nGiaEP11mKsSajoCcTE4Yrj4qtdctEkhAt+SM/CgLbgV4e9J9oaGKzYer89aRE9W+BuP
         dm8t7OWwiO6JTrPHW23LmuI0HT4YabQbr3FZHOI5ZDIjECiAddex4lbg9PkQ9YP/hvl0
         XeinXdslyNW4Gg/bFm7FT08tQSKJauKP+1kqmxTZRXvZHK3ALodybJhj3DB1O6P23ZHu
         brKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733825026; x=1734429826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lW3VZV3IbhiRxa0/ywOK4fnntFU6GL/zecF0WLK1Tbc=;
        b=vPOGG7MPtqIYwEKH0CQQ7X9oGfOU7ND0/kp/HL6pHgQubU3oIlPw+I2+qhf1lEVzQR
         yQ9AQLirJYWw3Ob8vqD232JAu2mFAE34k8OdmWLbthvRO2wUesmcTEgMTXxV+HZSI/j0
         pa4gWyTPe0qO0G/wPBjCniCqOU4P6YdQ6guKRji8QjmS3g1CmnIU+BfYahDZBq2jKagC
         6Wzdv5PI9EOxvV4DRuBhaHZ5mxBMg1xSiBLGGt2j7yqqIXfRZT4NVGwOnu6rAsf64xgy
         OLYRe9nb8Ji2sCGP8ncaJ8ux+8FSRlFgCagqhntV+ebkxNcYi3ZkP1+33iw+am2mzCwH
         oGMA==
X-Forwarded-Encrypted: i=1; AJvYcCUmQKPkmLZ/X7wOKjnFErEYMluKyBSDz0NHzL6ygEso3p4wsoILku+UOcW8CVCArhAIgfpTfMN5Ga1jfsw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7l+Da+QXQWvZOT7PNJ2+ZT24OjXLYaEaflMP6NqWcm0I3NcNo
	WBCh2hoQNn2N3i4Ri11CfctL/xGL52RcrxC1a/qYdumHapps0+ReiLyBdurWDi0=
X-Gm-Gg: ASbGncsfJ0FQ5BPUj5MdjghqS1aifJbH/i/lfOYAiCA//D8ZzH3fngqBz6k1usElHoi
	fL/tsiUjJBP/lR+wWMJdaWaxxyuYOi5DSYn9tDiCfUdrNI+Ok3YLmpdNIWOh38o1EYeYMmEJ7Tk
	m3cbxT6LZeztsyuatNF4A8JU7D25Feh+bYHLNq5hE/LPcXLSzPoHjVQ7unanDZOWAwx7yNWnNSP
	a4j4rx8Wg+cRJGraf8oTmTXh819Y/0APyTbCMqUc9n5LB4sHekoVbpch6Ordch9CK71NxY4rmCJ
	kxW9wpDoBqA0PfrrV1DOXEM8YJrrqPUjPA==
X-Google-Smtp-Source: AGHT+IFLOuvQG3RQchQX/UAJ3ESoE2sy2dYx5qOOAsytWGp1Si3/uCS5tZiWqNTkcM2CJmX/hxkweA==
X-Received: by 2002:a05:6512:31d2:b0:540:1c67:fc2f with SMTP id 2adb3069b0e04-540251eb26fmr859248e87.14.1733825025971;
        Tue, 10 Dec 2024 02:03:45 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53ffa80edcdsm919958e87.169.2024.12.10.02.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 02:03:44 -0800 (PST)
Date: Tue, 10 Dec 2024 12:03:42 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Xiangxu Yin <quic_xiangxuy@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Fange Zhang <quic_fangez@quicinc.com>, Li Liu <quic_lliu6@quicinc.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add support for DisplayPort on the QCS615 RIDE
 platform
Message-ID: <ua7sstdak6b236pm2ovg4jqfvxkyn6b5sbopewmczzrdtezrln@mavmb45hsyrt>
References: <20241210-add-displayport-support-to-qcs615-devicetree-v1-0-02f84a92c44b@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210-add-displayport-support-to-qcs615-devicetree-v1-0-02f84a92c44b@quicinc.com>

On Tue, Dec 10, 2024 at 05:11:04PM +0800, Xiangxu Yin wrote:
> The patches include:
> 1.ADD DisplayPort controller and phy nodes to Qualcomm QCS615 dtsi file.
> 2.Add dp-connector, config hpd-gpios which used for Displayport hotplug detect.
> 3.Config lane mapping through data-lanes prop.
> 
> This patch series depends on below patch series:
> - dispcc
> https://lore.kernel.org/all/20241108-qcs615-mm-clockcontroller-v3-0-7d3b2d235fdf@quicinc.com/
> - dispcc dts
> https://lore.kernel.org/lkml/20241108-qcs615-mm-dt-nodes-v1-0-b2669cac0624@quicinc.com/
> - display
> https://lore.kernel.org/all/20241122-add-display-support-for-qcs615-platform-v3-0-35252e3a51fe@quicinc.com/


> - displayport driver
> https://lore.kernel.org/all/20241129-add-displayport-support-for-qcs615-platform-v1-0-09a4338d93ef@quicinc.com/

No, it doesn't. The DT and the driver can come up separately.

> 
> Signed-off-by: Xiangxu Yin <quic_xiangxuy@quicinc.com>
> 
> ---
> Xiangxu Yin (2):
>       arm64: dts: qcom: Add DisplayPort support for QCS615
>       arm64: dts: qcom: Enable DisplayPort on QCS615 RIDE platform
> 
>  arch/arm64/boot/dts/qcom/qcs615-ride.dts |  30 +++++++++
>  arch/arm64/boot/dts/qcom/qcs615.dtsi     | 107 ++++++++++++++++++++++++++++++-
>  2 files changed, 135 insertions(+), 2 deletions(-)
> ---
> base-commit: 68586ffc0ad47448d0c00a72ba61db66b127c23a
> change-id: 20241210-add-displayport-support-to-qcs615-devicetree-1575aa4e299d
> 
> Best regards,
> -- 
> xiangxuy <quic_xiangxuy@quicinc.com>
> 

-- 
With best wishes
Dmitry

