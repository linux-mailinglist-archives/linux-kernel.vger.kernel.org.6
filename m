Return-Path: <linux-kernel+bounces-183298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 158908C9750
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 00:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9F86B20BE3
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 22:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786DE50276;
	Sun, 19 May 2024 22:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nwh7ei+X"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096E4FBFC
	for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 22:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716157854; cv=none; b=R3ERjlGwvbNRRrPxHfd0gZ8DBzzh8bQg/Jo9qsOQrkTh2xjjuEH0aK37Rx0phE75v/07X9xdlg7j87uVDMwxzi6z24Ho2hIFtFoqXUy3BRY7zfMf0WHR7LH1w+VTvwaRkzKC/hhVgXTVX4yyAI+4Yq9x3oPVIHEux052aCPSVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716157854; c=relaxed/simple;
	bh=n7sV21GrDno1oz9BZbF1N/dxXW4PbAC3h5mkKmR6jKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mP+z05nlsZlbINbH8nn2h0s0oVzJ+oAN3/pVvK/bQxSP7DAX3tQxP8w2cKIN/zBc3rncjjzkMPb0TLiY0MgeGrS0LOk6xBvv+w7bAqrMczlqMwzdigjrC7N5zCWcip1fhgkoG12niiCoHFQC0/79SrhIt0qCndAWhOxQ3aJCayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nwh7ei+X; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52192578b95so4285718e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 May 2024 15:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716157851; x=1716762651; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHblj1WkR9Gxv/WTlCLTyj7EGHA1VwykM/BT4nbq05c=;
        b=Nwh7ei+XHjKEt/zmuWzx37fNg5KEHEHL0G2l5O0iN9iIFUNUNbpbSt4GYqZ4jqi3nn
         rVrgyrRBY6I1qQNyCKz/ipLP6aAU3TBe11EQBu//hL3Rcz1JJvrou0wRp/0zlq+ADryM
         j/uXX20HS9yZl1OBM5eR3XpQIlPSuwdqY5QO66xq2JWu7bkY4h9emS/xNmqMeijlhQQU
         +gA10pIwXJPq0u9toEm6RSuWw/+Kp73RZHtA+FN2WS6oXTnsMBlImL5xGAfqymULoGm6
         +0VaPC/5aHoxEzw6fiKp9tg768iRuokpFT2Rity8Y9qubDWq6h6tApMWJRrHsRTx0N6B
         E17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716157851; x=1716762651;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHblj1WkR9Gxv/WTlCLTyj7EGHA1VwykM/BT4nbq05c=;
        b=aAe7ruIgPGSF8aMjlFXwgtgRdLnGhMl0QxqHHBNNz84xMGf9bqOVPlD/X5FqrzFt2X
         G9srH6Rgll5QpgLHHkezi31pYPE2oEMqNG57vwk7IAPT0VlBft5ukbLL6+i3jQvXCqWg
         kQap+I8eie6OWL2H9e00KF6Ax8+BUtn8CQVBeFeMSkkeik7f/5k9Y5+yQ9XlDP64ARS4
         vplo3h2gJCHcroTOOz+TpNBbnB8ZJgCGTryFQg+H4Z4Gj5xGpiUulAR7Oh9wh1sbLyOn
         YP7gOO5MqGJjBDx9IGSJx5SosjY7PA3D4Kxqiv2M933XwRA0S2/QXJhezqLsMU/hyXIv
         yxXw==
X-Forwarded-Encrypted: i=1; AJvYcCU1QHPcwIznhiz3dy7/Z4WOB5UhPUuFeO2Pi2NJOlHFsiMqnTkUg/m20MHJenr7kuw1LGPYobK751RSXrYmzKBX8H67ERuX3AJ9ak2E
X-Gm-Message-State: AOJu0YzewGbx82brlu7PX25UfCd+Gd+yNg7JFfKY3T/FJtN8LbFI6iEP
	VY1TD7eH6VzQmOtJ8lLQ/fpqA9+WdLyVwXD0Z1SILlhCG/P5iJT3KbXHjcOVDRc=
X-Google-Smtp-Source: AGHT+IH6ISab2GoZ62ixCmb9U8+Aj2V3McEjnnP8f8Av1TMQLFPgjxIoJBilpiTiA1xgXYvwktvjGQ==
X-Received: by 2002:ac2:4284:0:b0:521:e065:c6c5 with SMTP id 2adb3069b0e04-5220fa71b3bmr16664375e87.11.1716157851130;
        Sun, 19 May 2024 15:30:51 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::8a5])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d8811sm4061253e87.216.2024.05.19.15.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 15:30:50 -0700 (PDT)
Date: Mon, 20 May 2024 01:30:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: linux@treblig.org
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
	maarten.lankhorst@linux.intel.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] drm/bridge: analogix: remove unused struct
 'bridge_init'
Message-ID: <6tfxkc3foarpfuo6viwmsm4e2ujxjmhpqsku37d4ov6ppufpjr@byrbjs7srqri>
References: <20240517232427.230709-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240517232427.230709-1-linux@treblig.org>

On Sat, May 18, 2024 at 12:24:27AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'bridge_init' is unused, I think following:
> commit 6a1688ae8794 ("drm/bridge: ptn3460: Convert to I2C driver model")
> (which is where a git --follow finds it)
> Remove it.

Please rephrase the commit message following guidelines in
Documentation/process. Use Fixes tags if suitable.

> 
> Build tested.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index df9370e0ff23..1e03f3525a92 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -36,11 +36,6 @@
>  
>  static const bool verify_fast_training;
>  
> -struct bridge_init {
> -	struct i2c_client *client;
> -	struct device_node *node;
> -};
> -
>  static int analogix_dp_init_dp(struct analogix_dp_device *dp)
>  {
>  	int ret;
> -- 
> 2.45.1
> 

-- 
With best wishes
Dmitry

