Return-Path: <linux-kernel+bounces-445339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15A79F14D2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8968F283292
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BC61E6311;
	Fri, 13 Dec 2024 18:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LuwtijXt"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ACC1E377E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734113982; cv=none; b=OGiH4+WvvoBQy6zkF/WvSpX6lfnUa8FE35eoalhm972YRjdHciz7jj58r1icVajiOoNovCtSEXPnz+axHZcso7dZ2IzKiTJaDXQMNopb6RpfKzyYXvLrzdMlmitq0hh2fNbI/f3SXBisbVS0rYpXYonJK1XnU3Yi20HyNFyB8C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734113982; c=relaxed/simple;
	bh=IXFSUo9E+OzDGGUDNTXnj4BxB8uJdqmPFLE01xbjzvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJPxW1sU+xYM7mBjre46cjF5YPoolToAA0wgWkWRFuzxhJ9qIKMZWBSxpdVlCZcz3TmkquisrBqLUswiJJdbP5iONnlYfpO4dPUV5KG9fGySID5VbaGhU6ZCRWfSOrFXrEf32/E3l07REb0S5wVOir38Mwi+p1644NGi+yyzgwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LuwtijXt; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa67f31a858so383132766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 10:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734113978; x=1734718778; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=twtqvRoan+eYnSO74DE1z5GWOoJn7U/yFtJVJQT99vU=;
        b=LuwtijXtu/TRtp8x3r3V33FBl+U2XY24OHV1c/q5xZEQNVUAWx0/XcHoyz7AgdfO+d
         XAw5FBiJkP64DW9W2Jo7harql/rFbt9X8oM+KvWxgUGB7I9rfT5xhZyH3sl4pM6D5iPU
         mwc4PnpD0mZm8PZRJrvlHstWEBlNAbiYpBCc7wT0uTuOQuurKsIFGJAyh35qzKCKYzdb
         U6esIPbmRThhXK9yU/D9QuaujiJZkttnMMOoJLfDq5R/i6PDaIBXeLHcZtaOFce5bRM0
         YBvkMoZ/Mch32Skz2fuJa+WFCTMBeBtv4Z1TWzDWztJqWsdWPZSItWXjsH+6kedfBVRZ
         o+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734113978; x=1734718778;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twtqvRoan+eYnSO74DE1z5GWOoJn7U/yFtJVJQT99vU=;
        b=RZWHl8Zmvi0RTs38kX0Z/A95wsEm3IDqKvQhIt0CbehCq3Q0X16a4tPPvC+3pttLXK
         neEAqoc5wMT4wU3VF8fFJuuF0n5YG3XKhW6fu+os4F9W8hFOA7ti6awc2WZTwao72mR4
         mu2IHZwTZuEcK2oVEFxm5YGWddrIqtNVxCTGZdL2XwZ7w9ggxEPd8tWB+1ApiI3Oaq2U
         94JUkt2wMzGPfJFdklWigql0qSlLXd8zb6gj3RXD2KKDeva4D3fxIdxI8L8ZkWQij/C4
         4qmp9QYsIC8Rryys3EWSJwcH8bQrIGT811k8xTa1RNqXQe/7wHzAkLJ2taRIyqml0gni
         rtTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx+F8G9Di+gZq0MewH0L96+Xz5e0kH/iE0UsHua7jFLGSIi8Rlgb6N08ecyqDTcrUdduJm7jdEXEpVGaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1lqXAMTinikSQnu6PokZOtCOjQPdCMwf1HHHQ1L4/e4zN8lzv
	JWz+QIC+h8Sj+r9lS3M719jM8/02Czg30TsEMtKPkA0g0LaGmleyV1Jyi9wkbdo=
X-Gm-Gg: ASbGncuwuMV/nRvO/lmjjK3Z8yRLHc12veYTOlEaH+6SJEAXBZXY+juc28L38q3EV4j
	GjhMrpjZfA7P18WE9ZmEhuG2JAUchRhDD3uXODTursXNq5voclfJUqZ1dd8hoIvdYggVJ9pcDuw
	6BwI3WTbVmqovgHgfLk5aoVLRptmLbSm+k+rvSm2if6BW7o+bFj08VEF2ZVNtPId29LKp522jBa
	EncjYCOfhz576JNP510+/irZAGH4iMQ7w6zH6a8wk1kszPA/ynLAQ3K0Q+qT8bubO14
X-Google-Smtp-Source: AGHT+IFInGnVF4NBCAH9r+c7HVFvAHAWd9NOi/wF6K5xsJ3aU4eMArDXdSpkJ1YVcIZmOno3oVCykA==
X-Received: by 2002:a17:907:9615:b0:aa6:5603:e03d with SMTP id a640c23a62f3a-aab77ed3aefmr369683966b.59.1734113978431;
        Fri, 13 Dec 2024 10:19:38 -0800 (PST)
Received: from linaro.org ([2a02:2454:ff21:ef80:79ff:3949:ffc2:a553])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab9638ac24sm286066b.137.2024.12.13.10.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 10:19:37 -0800 (PST)
Date: Fri, 13 Dec 2024 19:19:34 +0100
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH] Revert "power: sequencing: request the WLAN enable
 GPIO as-is"
Message-ID: <Z1x6ti2KaMdKS1Hn@linaro.org>
References: <20241203141251.11735-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203141251.11735-1-brgl@bgdev.pl>

On Tue, Dec 03, 2024 at 03:12:51PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> This reverts commit a9aaf1ff88a8cb99a1335c9eb76de637f0cf8c10.
> 
> With the changes recently merged into the PCI/pwrctrl/ we now have
> correct ordering between the pwrseq provider and the PCI-pwrctrl
> consumers. With that, the pwrseq WCN driver no longer needs to leave the
> GPIO state as-is and we can remove the workaround.
> 

Should probably revert commit d8b762070c3f ("power: sequencing:
qcom-wcn: set the wlan-enable GPIO to output") as well?

> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> index 682a9beac69eb..bb8c47280b7bc 100644
> --- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
> +++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
> @@ -379,7 +379,7 @@ static int pwrseq_qcom_wcn_probe(struct platform_device *pdev)
>  				     "Failed to get the Bluetooth enable GPIO\n");
>  
>  	ctx->wlan_gpio = devm_gpiod_get_optional(dev, "wlan-enable",
> -						 GPIOD_ASIS);
> +						 GPIOD_OUT_LOW);
>  	if (IS_ERR(ctx->wlan_gpio))
>  		return dev_err_probe(dev, PTR_ERR(ctx->wlan_gpio),
>  				     "Failed to get the WLAN enable GPIO\n");
> -- 
> 2.30.2
> 

I'm not sure why but applying this patch brings back the error I had
before. It does seem like setting wlan-enable GPIO happens early enough,
but maybe some timing is still wrong.

[   17.132161] <gpiod_set_value_cansleep(ctx->wlan_gpio, 1);>
[   17.480619] ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed with rc=134
[   17.491997] ath12k_pci 0004:01:00.0: pci device id mismatch: 0xffff 0x1107
[   17.492000] ath12k_pci 0004:01:00.0: failed to claim device: -5
[   17.492075] ath12k_pci 0004:01:00.0: probe with driver ath12k_pci failed with error -5

Any ideas/suggestions?

Thanks,
Stephan

