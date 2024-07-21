Return-Path: <linux-kernel+bounces-258254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBD1938587
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 18:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 190B9B20CF2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 16:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A2F169AC5;
	Sun, 21 Jul 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HotPeicl"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0595B1662FD
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721580031; cv=none; b=d9yX5OY6WjG5Lqdm7LgJcfwnLh3zVwip4fbOwO6eIC9Qy9R6tc73u9iIICdF0Aw4NCDCvIwY6vGB2yOAzXRAmT6tcgn8TDlmwDfiDWHFhoat0A/R6gLH1Ly3zHSZ7faTJyNzLK6cKjdQkCpIX4vJ0CbdEyz0IPeAL9jYfYtY2uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721580031; c=relaxed/simple;
	bh=KHNYWd9qjw8w/6UQTauE2UXQTmDVc+cFnIzoPmIObxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KvPxYJgun8/8nFy++vrX9M/Pwqfsq55kiQoCYhHOY5+iN3W2cKLkUobsUiHRZQc+VjoP47SRj7aoxIYuSXnib0sY5tb8IJQ07w0UwG4KCdHx+rUeaX9dblZecvexeDPr2ooAn17uBiDasbyWvMk2sPUIDYbmV5iiXD3xdXpcOrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HotPeicl; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4266f535e82so24076685e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 09:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721580028; x=1722184828; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1neO0vY5BJtU2+Ta5W/SGMilSHd9JuLX8aCooapqSxY=;
        b=HotPeicl4WaV6w7oOkqL358qSjXvULKFm7GohCknVJJgz3pPkhbvXcDouiXWAUsMBZ
         3rWUgrWhpL6G9hsrIF3kVd78OW2+bDh/441o/wmT02qtluAzixQKMtVyu7VwOStpQSLZ
         kjcvD1Rpn767fOvQDxVhtpbEGc5OxxdkgnaXGhfqdN556zuUSO22jYOTXKqTTjCNwB+D
         G3XXZMvGU9WaeMkieH2vcnpGaGPrd2zJkC0qc8Om4kDYSXypaKE7HaCTrzXUvovAgS5P
         PCQJtjflx1ZSiqpJ110plD1YiuGVa/akLiHJPDn4sqJS2xzqp28iKA/yOvVbeHOXyoFx
         JAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721580028; x=1722184828;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1neO0vY5BJtU2+Ta5W/SGMilSHd9JuLX8aCooapqSxY=;
        b=hBZFzw50Qs+iPcnznZbVHvkzAwhLvQvkQ1FGSNVHrlv4gHJ1njtD8dsZYL9A/NmQTk
         EAt07FRoa/3QSCPbwjvPjEMrF116cQ/3c7q9xx4AIW6B4P15i//Vc4IpNuys/HjFVyiA
         0HT45Cjhs1DxfWUcby+LFGFqrd4IIr+WuToRdQMr2oi1hRTTTzY/7BGU/S4BB2u+8BN4
         i957eKjelFDDC2p3eTYRy++zSZF0h2mMuqo34OLNM8/WSI5D9BBZL1NAHG1yiQB21llL
         Zt/g9Zgciam/zTgsrUhrM3CQ/V60QUpm8Lb3lUwpo2F0OP57QZEvh9DugjdorJElNtED
         XI7g==
X-Forwarded-Encrypted: i=1; AJvYcCUmT74Sa/nhBnlAQ/qcF90pgbk+XO50vw/4LCjpAkL79w4hZjdIjCnR07L5g0kg1+irytwKETr/hdyD6ZNToUQTfSoFDS7j39ObCxW/
X-Gm-Message-State: AOJu0YwsmblT/wJB9HFKY0fxz0z6HTO6i76AigB3ngRuVeSG1KLMCDsu
	94WSYP7dohbfzGFtE1659X9+pcriPij1Ia/ij3dReu/q6olRAqFrMFp1/F9VkYc=
X-Google-Smtp-Source: AGHT+IFZHeWRrnvcP2zTS8aAtfNhxgGwHp3XmT2plebZCwdxD/aMAWQ9jlU7uPiBQVq8Eru08s5Bhw==
X-Received: by 2002:adf:a181:0:b0:362:7c2e:e9f7 with SMTP id ffacd0b85a97d-369bae48cacmr2516314f8f.32.1721580028502;
        Sun, 21 Jul 2024 09:40:28 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368785c58e7sm6398846f8f.0.2024.07.21.09.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 09:40:28 -0700 (PDT)
Date: Sun, 21 Jul 2024 19:40:26 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 2/3] firmware: qcom: scm: Allow QSEECOM on ThinkPad T14s
Message-ID: <Zp05+twrssUFUv+u@linaro.org>
References: <20240719-topic-t14s_upstream-v1-0-d7d97fdebb28@linaro.org>
 <20240719-topic-t14s_upstream-v1-2-d7d97fdebb28@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719-topic-t14s_upstream-v1-2-d7d97fdebb28@linaro.org>

On 24-07-19 22:16:37, Konrad Dybcio wrote:
> Add the aforementioned machine to the list to get e.g. efivars up.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  drivers/firmware/qcom/qcom_scm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
> index 00c379a3cceb..e60bef68401c 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -1724,6 +1724,7 @@ EXPORT_SYMBOL_GPL(qcom_scm_qseecom_app_send);
>   */
>  static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
>  	{ .compatible = "lenovo,flex-5g" },
> +	{ .compatible = "lenovo,thinkpad-t14s" },
>  	{ .compatible = "lenovo,thinkpad-x13s", },
>  	{ .compatible = "qcom,sc8180x-primus" },
>  	{ .compatible = "qcom,x1e80100-crd" },
> 
> -- 
> 2.45.2
> 

