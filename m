Return-Path: <linux-kernel+bounces-432226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BB19E47E8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42E6D28101B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7A01F5415;
	Wed,  4 Dec 2024 22:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yHpxWdxC"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1938518E056
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733351618; cv=none; b=gov7K3U2h3QhMPLcECSDkBfPjN6JlOI7gwERFvDlfAQn16QCOt23FwJHa6+hntHqsBc84Vw6IK9YKQRKzHbbQdOqtIQMgaWONTIhFZGCJe6NCLmsNCJYfk+hSqE+nd9Qf0JkETQ3yPvz1ZFVARzcLJyP/5IxGJjEHjM0cnDogTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733351618; c=relaxed/simple;
	bh=db+eBbeeOwSwRMrB+GHo1wPKEqzB3v2TTN3uqBqJHZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joYLVpAnNtnJzT/WVibwYq43cgsyKqjbDclXSUVPJD7k3aZtbTNWWNnvo1Tn9B5gSw2NZnzTv+Bu2TDyI5H5fu/jw4LV02NUB3nW2OPoZcSsGlKGkcp1lrU3jCzoV1QwrjGrRm4jcxfNO8rfTuJcwBN49SS3PU8BJi06SEXvMk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yHpxWdxC; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53de92be287so321794e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:33:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733351615; x=1733956415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZA+/Ynbct9XmJ/pDgZLrlz4vByV1+ncrGt31MmPRsc=;
        b=yHpxWdxCKhFt8UvkEe6gcBgdkR5GuDHe2MXgs64CQoTIDiqEINp1+IS+75jyB8JVeA
         afCCTt0k6+RKH17QUILDfBw/eEAejkeXZxIegNkX4yJc9uNoqPkehmvutVj+j1DhiZIt
         9eWH2TwzDUX7MwtZWix0atNcx52WA5tdG4C777T9IHEr1r1yG1ZatiQ+aQnR9dWMH4EN
         Qmsl4qRaDyINAWJb32EcMDgQA8W5CznsVaOVCbijX8v6x2mTD0XjfTpowHYWTR/c38S+
         mMm5744XsH5V5fL+oosf+jw5hIkyRAQIOHrNWU9KFrQAKZX2JhRQOi7mJGjiZq28xPD+
         BNdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733351615; x=1733956415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ZA+/Ynbct9XmJ/pDgZLrlz4vByV1+ncrGt31MmPRsc=;
        b=dlxiSoRbEkTq3kMYhg8Xza/i34Nr9PY6qmAa5zbH3w6Okv4NhTwzP1rLAWxWsZv9oE
         HnYIO64QHr1w6IQSRA6hzE9A5hGR/VsKS+H6DI13Ctz5r3Lj/iDSRzK5PWawVHvUvTd7
         lE7lCxOWe4ATSDcockveLB3fkrWsk2n7k3Oxgiii/NgS9WFtaBaXkLyTc5QQd8ug/y68
         e11lnCCrsB+389Pp038nBcTXoVEZ8sU5/WnULxOHJyvu3CXfhKH8tsdjQ5KEVEABt6Pi
         a/aeXlqBlvwemsac6wJNXrqnPQohqFNG/63G77Edtdd70J+27cuEkT4jJuB/sXY6YrEY
         w2MQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4QJGFg0zrXZugBZYRKFytkjLkktN7/lcr+2Vq8BswVNdctbxouy/EwV66T+ytF2cNMpxMBi+uZssMOBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeNFcbKw0RB0BEWshm4FZBK8wy4hNFJFl+QntOpTJ/XiF9wLMx
	edx1nDqSLu5GcywwomkKHj6f8cvPbWxbD/jbLkcqMpETcd7EQJf91MKfMmsjv/I=
X-Gm-Gg: ASbGncv67fzkbw9DY9SNZ7b6+aWLIY2tTRon31exa2eqmF4w6537WtGDT/mA58zNADl
	DfmL2kqcxqkS0Zv9H3Mg+bR4Gt0WBjCJ+IVlQ0Ne+qPIbxhZcXxCswedbNcHIczuMmoZWHyw7UI
	OqfknJoBiFkiQMFEtxfMnXB5SUfOdDWaKwzcTTYBmgrvnDDa1hCpIYSBgO1NkThhESLRGAu9kKH
	JNdVIS/5CsLzdU5XHDKZYweDXNPrx9I2m0Lry0eANiseh9Kv4Or4Z0VzEcgXTxQZ6D4KP8/3Csl
	MnEYW1kEeWAqn1mi7FEOXWbQEVLbUg==
X-Google-Smtp-Source: AGHT+IGQS+X6xxLW7rENTxfs/AsPLqM9/viSn6e/WXTrVzgckr92jwEcQHj1cg2TaCS9ztS2W2MXkQ==
X-Received: by 2002:a05:6512:12c5:b0:53d:85dc:7c58 with SMTP id 2adb3069b0e04-53e12a3932amr6597198e87.50.1733351615312;
        Wed, 04 Dec 2024 14:33:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229bada0sm21317e87.168.2024.12.04.14.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 14:33:34 -0800 (PST)
Date: Thu, 5 Dec 2024 00:33:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Melody Olvera <quic_molvera@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/8] clk: qcom: Add support for GCC on SM8750
Message-ID: <s7kuwinorqu7i6sdhwqjftcawa65szzze2bhczgpmuqp4dkids@jsa6dthf3omj>
References: <20241204-sm8750_master_clks-v3-0-1a8f31a53a86@quicinc.com>
 <20241204-sm8750_master_clks-v3-6-1a8f31a53a86@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204-sm8750_master_clks-v3-6-1a8f31a53a86@quicinc.com>

On Wed, Dec 04, 2024 at 11:37:18AM -0800, Melody Olvera wrote:
> From: Taniya Das <quic_tdas@quicinc.com>
> 
> Add support for GCC for SM8750 platform.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig      |    9 +
>  drivers/clk/qcom/Makefile     |    1 +
>  drivers/clk/qcom/gcc-sm8750.c | 3274 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 3284 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

