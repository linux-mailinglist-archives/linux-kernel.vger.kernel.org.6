Return-Path: <linux-kernel+bounces-223530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8CE91148F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 23:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64E51F26B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A696C8286B;
	Thu, 20 Jun 2024 21:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qNBkoo3O"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7917D7711C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718918707; cv=none; b=ZZJ7sxypY4eHogeQDZTuRbodJqBfJpCgNx80xgbhdQSwxJUwiaTK04kFdg2+w8Q27GMtz1LklrCqdx6YLFBgIj3/hVxWiLm8ApvPFJ4Yx4dnm5K6xBdYHPAOgNAntuPqMjSywjDEiRMwClpptJnHQmm9dBZpiIQ8mEzQ1kCow4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718918707; c=relaxed/simple;
	bh=ox3gcw26ni9ljsaZIqowRX7P9R06L5ndgBrgi5HlKZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=geO7KZ99FuwRB2Sf7D+51uyVcoyb1LtRBA4BPPzyAFWFozeuvIgZ1rxPnh2LQt7IZm+KRH/R63uwfn2kRFk3JGclyQkOuTbfhOj8x0xc2JSeVHK4CX7C1RtK7sKdlkmQ9jRJZ4DaP3ByoZ1qovPrxZ5CpM/uVeEcSJRUojussAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qNBkoo3O; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e72224c395so14052781fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 14:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718918704; x=1719523504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tTKwbi/b5GESrqpWvwh5PU+yPG0ba6PdL71DBg8W+8o=;
        b=qNBkoo3OcxNYTWZDlZsZuCRpi3PbDcdxBmCO7Iy6LaOhXa3igHjo9s8GRoGo9zTo1k
         FHybG6Y1A1Q2/jZ19z3+xQfPbVYFw2GfhyLTbqQ9xu9efKhNRKgypCddRIspVb5sVRjK
         3kOVsYTNAkF8fhZxOtbv/Mq79/1gMYp30FHiWP6YYLi7MWs8CZa4U+7qxL4DPG/13YOC
         zMRKGFiraOksMHBinoXJSR4JfREoC+VBS2JmeomVAno+lek63M24aiCHGk/HwDZ41Jl7
         off8vjTxNR55jAJzooruW3NMAUBcYgiocZ66vMHrXdZFM7TOvDkuhY2TLXn9S5sPMHGB
         IXxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718918704; x=1719523504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTKwbi/b5GESrqpWvwh5PU+yPG0ba6PdL71DBg8W+8o=;
        b=itkwm8OFg1/7mL/1IxM6S4fIB29XSk6IogcH5IguXH93Islf8NlkQ1QgQwYHVGSLzl
         8+XuEQCB+VZT+Naa/3Xek3KRU4EjN2KDkPieC9b8UiGmmYVWYmsSHchsi8ZlqyBaNEua
         V54+h6wrL1W9UrjNaHVFtaI4ttyPm+CYTmQwPgWV48haISiA1/uwuWyfjQtBACubLzvU
         sK4EKaR5IX3GOgj8Q2DII2Gj9883InxX0R1unG8ZYNBd61ma8ikmHaR4PBHhTP1D+Kxc
         EOcJVuAvu9IWBRLkiMaoV81GPtOoVDH6f8LD1E2VtrYcwcUWlZk0i2p+0FBvH8w0TvWH
         w9sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjwfMQu5ChDGw5M6yw2IV7E3Sc+rD8+KD/Gas1qgEOx4uFqeXRFVbZhd+NRW9gGf89RgnQsfgCCV/ruXh1h0WuKtrBAARFtSCY9kJ2
X-Gm-Message-State: AOJu0YyLUeG9Oockax8mHtGUZbbT5cE8YSbeqtDql51+5ateIU8xxgw5
	gp8TQENqSvRVpOIU8bknRNMfN1DdypP7XT9XtPWURqRafZ+rNKrib8peVFiO4og=
X-Google-Smtp-Source: AGHT+IGiSIN0WJRAqp4hcSHBuq2slYqU7W2PNtbsiHycqkTy4GY6DsNbAAytLVe/Q4B31Eo9F/WhXQ==
X-Received: by 2002:a05:6512:a92:b0:52c:9a89:ecee with SMTP id 2adb3069b0e04-52ccaa92647mr5056240e87.52.1718918703539;
        Thu, 20 Jun 2024 14:25:03 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52cd63b48edsm2022e87.61.2024.06.20.14.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 14:25:03 -0700 (PDT)
Date: Fri, 21 Jun 2024 00:25:01 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 6/7] ARM: dts: qcom: msm8226: Hook up CPU cooling
Message-ID: <c2lknbesy7yamql6e2kwksmctjjodvzmksmvbophn7ze66n7vw@amb4kuy4qw7n>
References: <20240619-msm8226-cpufreq-v1-0-85143f5291d1@lucaweiss.eu>
 <20240619-msm8226-cpufreq-v1-6-85143f5291d1@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619-msm8226-cpufreq-v1-6-85143f5291d1@lucaweiss.eu>

On Wed, Jun 19, 2024 at 11:02:50PM GMT, Luca Weiss wrote:
> Add cooling-maps for the CPU thermal zones so the driver can actually do
> something when the CPU temperature rises too much.
> 
> Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

