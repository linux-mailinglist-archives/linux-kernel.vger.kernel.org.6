Return-Path: <linux-kernel+bounces-239236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D491B925846
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 12:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FEB6B28887
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A50D15B54E;
	Wed,  3 Jul 2024 10:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PCQNec1U"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6758142E73
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720002047; cv=none; b=KYgFV94o7v5M6wvgxlzRqriduKfiiZLZ6AnWD8fA+wqmVr5yJ51vH1ECcI79X0rhH4bQJnMdKq9fgPtFu/yHfolt7IgwwW56G4DdO4nQ39uiu39TFArMrCi8rAYdYL8ZoYJ9TQGt4eQwq2AUllrejMNzDwqNyNbWYt5OoPp6AVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720002047; c=relaxed/simple;
	bh=qcsPx+KivTw8iXF20LmIfeCsQUVmqptPLE0ZJ87n+Oo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVkdEPNu6wL10+8l2Oe9J6GERSXwroRZCo18hPxQZpsf0QV3DfiApfjZezMmB/6CaPZ/UvvnHo9cvVcV+D5NSLoWBnshAM5puAk63LHtTCXtj2NUN1x1kRFidM1ny3t3T8pkJE7OuWTlV60/73DWdTU50uMnc5y3VdFI8VfO1kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PCQNec1U; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52e8b27f493so3762702e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 03:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720002044; x=1720606844; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5taOoR0Y0Dzy5R91jQuwaJ5ffdU02FaiXhjYh/HF6lg=;
        b=PCQNec1UbPxb/gZ2TwexLDHbWahmaCbZCRQn7/z2o4wdSDUytLhJT8lZKOwplGQ0th
         Im/Q0rty1Tb+T9i0U2rauvfwVUDnFV7RyaJMrCtwxNWgQLSWR1HilXiJGP2BqoqVwHOc
         GKP1LG1wYNF5TARylXRj0oDhH7nae1wzulxJlJn+GjNpKZ0jL+4lCNORPdcZaiaak+/A
         zRamFlkwWQDF6DgDtuyU1xZlnxz8ZOxEh/iznxg1JX+d7q9zi8hWLQJ0UeN03ptPAGwl
         1mhXsd31XO720gRBmF0+r/v2xcJKKOV9c66poCk9UgCEMxA20zqSW72qc4OsDg2ZWR8i
         /euw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720002044; x=1720606844;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5taOoR0Y0Dzy5R91jQuwaJ5ffdU02FaiXhjYh/HF6lg=;
        b=TobpBc4WW7slj97tp1TzzeSjuFBRpmtYHOU++dhUYREDBCOv9Zbm4mXL+mWbPS8X/D
         afx0z6pFCBcfLynKdwzQ4xElRf6uOEaYrAAieEcN4TG51op3Sjiu3SsHxWGz/gQDiMuT
         jdqOpi+SVhP+ixPqrs0IzD+pFvDP8wss2BrgREkMxDbzobcJ/0X82eUhIoCsafvGjCbU
         6czM2MvCIXlHu16ItKUWwmuV4KoFq26wwBQbMcvFxCmM7XjNg1jqnnwFtSjkxp/674Nv
         JRRy1VTjJn/QQGkkQQ4DgO1D7KRvQMC4mgbqyyLmsQHy4P7qDoY5Li+Ich5HIW9tkZtZ
         4H5A==
X-Forwarded-Encrypted: i=1; AJvYcCVHiFmCinPsYnTds9HHZxR7JKOCtVaMOQi+aXXP7JfwJ0mK1/Kqc2NsOpEnpBw5nmnH9bwj+uEcIwB0TZ1KLw5/iDterxJPDTVAqGDp
X-Gm-Message-State: AOJu0YypFDe8fZsCJuraXRR+V4N1ss8qFVzdEvoGcB06nQDQRUejSmU2
	fU+U3NfbpOjw9zNCrMSWLN8HYSqifE98+sP1JMqAtEHbuKqOTuULyHOEQXxnuKA=
X-Google-Smtp-Source: AGHT+IGKIa0XD0fcaWip5lmRN/9aY2Ecb7ckydCu8fEYpC2X6R4ZAPqT/yNSktLHY44OcKucRamHqg==
X-Received: by 2002:a05:6512:3124:b0:52e:9ac6:1fa9 with SMTP id 2adb3069b0e04-52e9ac620cdmr298939e87.25.1720002044092;
        Wed, 03 Jul 2024 03:20:44 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab0b81fsm2094616e87.46.2024.07.03.03.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 03:20:43 -0700 (PDT)
Date: Wed, 3 Jul 2024 13:20:42 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, 
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v2 5/6] clk: qcom: Add camera clock controller driver for
 SM8150
Message-ID: <xbe7kmaxhfwy26qzxrmwgiijaaiap4kdkruaxjs6ymihaw5taf@hvj57wyncfea>
References: <20240702-camcc-support-sm8150-v2-0-4baf54ec7333@quicinc.com>
 <20240702-camcc-support-sm8150-v2-5-4baf54ec7333@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702-camcc-support-sm8150-v2-5-4baf54ec7333@quicinc.com>

On Tue, Jul 02, 2024 at 09:20:43PM GMT, Satya Priya Kakitapalli wrote:
> Add support for the camera clock controller for camera clients
> to be able to request for camcc clocks on SM8150 platform.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  drivers/clk/qcom/Kconfig        |    9 +
>  drivers/clk/qcom/Makefile       |    1 +
>  drivers/clk/qcom/camcc-sm8150.c | 2159 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 2169 insertions(+)

The patch mostly LGTM, several quesitons:

- There are no cam_cc_sleep_clk and no cam_cc_xo_clk_src. Why?
- Why is cam_cc_gdsc_clk not modelled in the clock framework?
- I see that most if not all RCG clocks use rcg2_shared ops instead of
  using simple rcg2 ops, could you please clarify that?
- RETAIN_FF_ENABLE has been used for GDSCs for sc7280, sc8280xp, sm8550,
  sm8650 and x1e8 platforms. Should it really be set for sm8150? If so,
  should it also be added to other camcc drivers (if so, for which
  platforms)?

-- 
With best wishes
Dmitry

