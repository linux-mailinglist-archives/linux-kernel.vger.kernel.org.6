Return-Path: <linux-kernel+bounces-381075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6806F9AF9E4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92FC1281208
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F93719A297;
	Fri, 25 Oct 2024 06:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FDCQzeaj"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6164218C346
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729837453; cv=none; b=C9U17JBcom2xAv1WkuV4G7I6/PAfY+m0NVKpn24WNYDXwmbZAEG9/lVYAzxcQH3Qy7V0BVP9wcQEKLZrWTZPz9BtA020U9GW/0jql3spJzBp2Qm24tbZGa78/iEzHXaMk2cQsMDAwkvJH1HME+N6AYM5JGGQ0NBErHT5sWlvM8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729837453; c=relaxed/simple;
	bh=Dtmo5K08HFoyzCzvaJqKJiI2IxYH1seEW36tML8Cc4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXhlhjMBCvAx6fjbV0NfGwIRrJ76qSCc1DHHe18aL5TND1YTgKJq8mBwnOH+MnWFlL4lMPq+LlobXf0HCAzx1SjM8DKEeYd8JIwy//AAryKIVYSzYeHpJo7HZSkIo7x7q0KZL5E7mezEUGUiZ5RPuX5S+NhEsiZ9K+SFABfX2wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FDCQzeaj; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f53973fdso1400208e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729837449; x=1730442249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mmOluMnBeTWFpiyoaltYb/0n6IB+lT/bvEqrIoKWjjI=;
        b=FDCQzeajJvascincXMeENQdH7HeEg7McLDBc+xk6MMrWwJwnguZT035tiKxKNPryoz
         RjT/6YECaSJ4FEoaJkvVDECZLu19KIbQNrSRxY6Yjr041+blabwNxVRyQhG/QSy5Fg2X
         s4Y92krrYn9lH7OfpXYmk9D0AFTF5QeoewOEvO9YnlB/WeLHdH9LP5j3FGrMg5TkFs4Y
         m5CA3tKDERBCFsYKqNhstR6IJe7PkdOCoVd80aa6ADYyL9YqC6R4O+xCVNLU6oLIy8hb
         J1SD9Ah9eeFGT1KeRgr9G8HBjQH+0fS4qVa0tFHcha05IpUchH5wvKVsMGkWBA4n7SVY
         gwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729837449; x=1730442249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mmOluMnBeTWFpiyoaltYb/0n6IB+lT/bvEqrIoKWjjI=;
        b=NDxl1QqFh4GAEwfvbvsBNvc/qdh/wx1BOwXpWlhi+hrfh7Re/pyNy7l2xAZ384ar+g
         dFaJqx4byjPG5W03/F1zmgxx5TaRw/IelEkIuKCkWFUp5EOXQ5vAxcemZ+GnXNFeUFD0
         ySoQ7fCt8DHXIl4xw6kQoAJcg13UYaRSF7syxkJrrnfvEOEQkoxt550vu0KaxuRSo/eV
         BCv7XJsS3ArepGhgmwMGYaBUVZ9D1D1MK60h7euHNXqrY/S08xNzD5uEUdONnbbOrR+q
         Uhqnn4L7ICn4iFl615KpqfICoWQ+TLz6nIkbjL/h0LevMCIzjWwU5ZgcLOoGnxx0+OxD
         hdwA==
X-Forwarded-Encrypted: i=1; AJvYcCXIWQmjgas13v77yERyVVaBIDTR8Rs/MPPTFBECW8yn5C1CHvMF+k3KSNx2/pyDlfeVw9G4tvlfQUuKQG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzSGJBJ29ug8o2+H6bosz8Kr1VUJncKsmvxt58MymBIDgRLUln
	zB24aTqAG2ix272URrGhgol9A0URHYXHRBN6n+wa0Ml/lLXNIxhF/cFKQ+a9q5g=
X-Google-Smtp-Source: AGHT+IElCN9Fu+YyZ052tJMBnTOU1DDpjvH/+g33kxgxMsa+Vi3RsCc+XeJ62OlpLC+YdFrC9YW6PA==
X-Received: by 2002:a05:6512:b10:b0:53a:1b6:4624 with SMTP id 2adb3069b0e04-53b236a6986mr1605752e87.5.1729837449397;
        Thu, 24 Oct 2024 23:24:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e1f42e9sm67236e87.301.2024.10.24.23.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 23:24:07 -0700 (PDT)
Date: Fri, 25 Oct 2024 09:24:05 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Gabor Juhos <j4g8y7@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] clk: qcom: apss-ipq-pll: drop 'alpha_en_mask' from
 IPQ5018 PLL config
Message-ID: <yplfg55afv4vucpcxbkqsxmn44mzwr3tepbuvgtswhupx7fzfi@mwofp7v3uarm>
References: <20241021-alpha-mode-cleanup-v1-0-55df8ed73645@gmail.com>
 <20241021-alpha-mode-cleanup-v1-1-55df8ed73645@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021-alpha-mode-cleanup-v1-1-55df8ed73645@gmail.com>

On Mon, Oct 21, 2024 at 10:21:57PM +0200, Gabor Juhos wrote:
> Since neither 'alpha' nor 'alpha_hi' is defined in the configuration,
> those will be initialized with zero values  implicitly. By using zero
> alpha values, the output rate of the PLL will be the same whether
> alpha mode is enabled or not.
> 
> Remove the superfluous initialization of the 'alpha_en_mask' member
> to make it clear that enabling alpha mode is not required to get the
> desired output rate.
> 
> No functional changes, the initial rate of the PLL is the same both
> before and after the patch.

After going through DISPCC changes, I think the whole series is
incorrect: these PLL can change the rate (e.g. to facilitate CPU
frequency changes). Normally PLL ops do not check the alpha_en bit when
changing the rate, so the driver might try to set the PLL to the rate
which requires alpha value, while the alpha_en bit isn't set.

> 
> Tested on TP-Link Archer AX55 v1 (IPQ5018).
> 
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---
>  drivers/clk/qcom/apss-ipq-pll.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
> index e8632db2c542806e9527a22b54fe169e3e398a7a..dec2a5019cc77bf60142a86453883e336afc860f 100644
> --- a/drivers/clk/qcom/apss-ipq-pll.c
> +++ b/drivers/clk/qcom/apss-ipq-pll.c
> @@ -73,7 +73,6 @@ static const struct alpha_pll_config ipq5018_pll_config = {
>  	.main_output_mask = BIT(0),
>  	.aux_output_mask = BIT(1),
>  	.early_output_mask = BIT(3),
> -	.alpha_en_mask = BIT(24),
>  	.status_val = 0x3,
>  	.status_mask = GENMASK(10, 8),
>  	.lock_det = BIT(2),
> 
> -- 
> 2.47.0
> 

-- 
With best wishes
Dmitry

