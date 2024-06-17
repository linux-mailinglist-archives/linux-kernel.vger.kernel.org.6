Return-Path: <linux-kernel+bounces-217009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CF490A99E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 11:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD411C23A79
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483FC190480;
	Mon, 17 Jun 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k29iR5bS"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04690190053
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718616780; cv=none; b=MZPhF7uCeBaswSIhXMGH8QYyDZUWjr5qRXWg+LEFY7hjf1h3n2teNfqF1idMTUJVz/JrBA1X0AmihOl59a2o2NYhZRo7BYPwCV6aHnuQux00rpprAh5XLwh/uQ82QunDcNl0JbZngdoMSVGl6QN2Y7fRw8NJQI8c8k2UTdoKkNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718616780; c=relaxed/simple;
	bh=90EEYM5lX6TrnFkNQUuXvDKTQnTRsJ7IvRd7zGe9k9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hh5v+4k/2DznKBu4ZGaAdhgLct6DmsHFXgcNJXw/VdPCl7QGUnZok9JvRzp8Q8XSoVCvhOCCnc/Hpouc6ZUtnd/v25i/Eom/l24y4BFhYpOHVhuZyoQfUZ5t9tzcBoNIE+eWe1hYjLQw843UfVt8BHjIfsvMWfmEuyRApxJQgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k29iR5bS; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52c82101407so6957959e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 02:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718616777; x=1719221577; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V2tSIulfQ3VPc0Vxc7eUpTkVfS5QrdmZJwbCCL4IUjs=;
        b=k29iR5bSi09tdaJ2I+71i+xpjvAwSCdRSK1Yb2PUWwjkpRFCKppVGUrj9Obwa5V9EX
         lrGHHxJlJ2v2x221/bauaeI1KCAh+FloDOSeKOrNpDFGZPMySybKV3ZAQ0ASLrYHeveS
         1bT6EVX0A68g0RASnTveIX2QHQO9IJjrI6K5W0ZYkBNAYYUGwZaTYGMO39QGEIcYs5P6
         KN1B9/N9I9qdf2g/KN+eXt3IyJwue/AkAmAUU+wxIWr0m3lpSiTicufy1nVXBMQwJQlp
         +AuDI5GfdjDu8/9+7wsequDJLnMtJHcIHrqVw2ILTiMWj5kI24UcxtwaqyQTwZQbZjNs
         6Vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718616777; x=1719221577;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2tSIulfQ3VPc0Vxc7eUpTkVfS5QrdmZJwbCCL4IUjs=;
        b=dDv6+81DvV6GTCwEcEoLKaQ0gHWCms7B2e9d/BzjQV6S19XGpkKyEtqPpgDy3wnIs6
         RI9MeY/BAtxL7R1s0uGR7JpMlSBPvTSCKT6GjXBxnBvv9w2hAPlJjoh5/5n2pHe7i2iB
         HV5SK49LTf+22WTSqYpZtVrDwIiNE4x9j47y2jlOGEZV3INBnSPuWYEM1raMBYW6m4ej
         D/qVtOh8lQBuuTdJKQ3YXo4bYL68+KA3376u1pYmiMEjgFzGfqqCFeilvMUymPd9JCHN
         RqMx1RFVLRw9x49bgewqEG28/Ex6yBO1tILxZPZVTLwmOHscESm8quUb2GS2vZRV091c
         u3MA==
X-Forwarded-Encrypted: i=1; AJvYcCUgt57Y4t0mBHZxmv9Jq+sifd8qEqX8tk6Nl4cFZLhTxM8znIEoaRJFl38xpLyPUMF8aKJtaOgwoqDd+dy+KR1NrvXZKTyBBWjAazkn
X-Gm-Message-State: AOJu0Yx4ize8OCdGJrM1gmiL5sliXT5D0lIwo5WFC9MJ+xs9BpXQ5nap
	THGFxzYLViLZTcULCdoBrDgyqi8CHyrL1rs6KBPrCnkjsUEHeWgT38wKEymUGvY=
X-Google-Smtp-Source: AGHT+IFGDOxz4MRAnf0R1ne10CyalMCg7L1It9gMFaVleUN7Lna53Yza3KApyi6aV7u0UhvfcuqLLg==
X-Received: by 2002:a05:6512:1285:b0:52c:8811:42f7 with SMTP id 2adb3069b0e04-52ca6e67145mr9180415e87.19.1718616777147;
        Mon, 17 Jun 2024 02:32:57 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2888c2esm1195860e87.300.2024.06.17.02.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 02:32:56 -0700 (PDT)
Date: Mon, 17 Jun 2024 12:32:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Amit Pundir <amit.pundir@linaro.org>
Subject: Re: [PATCH v9 1/4] arm64: dts: qcom: sm8550-qrd: add the Wifi node
Message-ID: <m2ocalmjfiitgr2ziqtegll4gzs5l5hykgx57fzz2n7u45szje@faa2xxfmksm4>
References: <20240605122729.24283-1-brgl@bgdev.pl>
 <20240605122729.24283-2-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605122729.24283-2-brgl@bgdev.pl>

On Wed, Jun 05, 2024 at 02:27:26PM GMT, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Describe the ath12k WLAN on-board the WCN7850 module present on the
> board.
> 
> [Neil: authored the initial version of the change]
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Tested-by: Amit Pundir <amit.pundir@linaro.org>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8550-qrd.dts | 97 +++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/sm8550.dtsi    |  2 +-
>  2 files changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> index c55a818af935..c9d3c0549ab5 100644
> --- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
> @@ -1784,7 +1784,7 @@ pcie0: pcie@1c00000 {
>  
>  			status = "disabled";
>  
> -			pcie@0 {
> +			pcieport0: pcie@0 {

Ideally this should come as a separate commit, with proper Fixes tag,
changing all pcie ports at once.

>  				device_type = "pci";
>  				reg = <0x0 0x0 0x0 0x0 0x0>;
>  				bus-range = <0x01 0xff>;
> -- 
> 2.40.1
> 

-- 
With best wishes
Dmitry

