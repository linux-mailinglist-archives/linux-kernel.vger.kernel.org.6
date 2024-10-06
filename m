Return-Path: <linux-kernel+bounces-352565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 457C89920CF
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 21:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D21C2815B7
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 19:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B764C18A936;
	Sun,  6 Oct 2024 19:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FrxE+a/K"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE3416E895
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728243716; cv=none; b=inrpxZJwLZig77gUV2kbkfoGIF42OpKmL2Fr2MBJP5aFRvYaT8GKZ52+b5wRR6njl4IaoE1yvXdfCLThGG+DYzRp68f+LVC4cJOCkHlQJ6VCC07cNjvn/rFIx3vHPGx1knHaAfIdH8KWYRXgoXQMl6TDYaqdzAroJVZLl2Kekt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728243716; c=relaxed/simple;
	bh=InDb0dkgQ3vKDGQcUS+MOjNktszFzkV7Qxp2mWF6+oM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNjB7scN9m+Twbj1aS1+5sboZ0ugMXFawG5MjywiHIsdrMQQrmpJ76xwNzTE8FFY6lTvEjo64VIR1BkT6NVNyb0/MxEKPMQQMkCJV3RCojQv3hZR/9ICjtMc1JOKuHAkYJRQFf3hXCRg9NpGeiDvfL3XjdLieO63RxdMOSVKLA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FrxE+a/K; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5399041167cso5576568e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 12:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728243712; x=1728848512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wFoqn5U3IFgkxMo0rRByuuyMGm0bprWMsEyD4suNSNs=;
        b=FrxE+a/KekqOw92dVZpXHbiXpyWyzx+etbH81mtCgxQntyu3xc45jxtlOAeayZ8EfT
         wsBsuWiy60GYdbtW1npulihPtgrfaLIh41sqKGklQAUKzNbb8tor5rO3+rf5tS3sGxzM
         A0K9WuwbA19Av5SxX33YE/uM1oitUShKkPIEXpt2NMROsFwRuTFcu2WHp7M+kr7ZhdOZ
         2J4zty6J2hg1qCCuqBTtJnJCToKJ36vn9SA4BpqNDNAnQCcYodBPomyqeTHd89DHJno7
         okKVfc7c7GMVU1mSivIUGoj4YgD4Yr5i0yUssfeYh2TeNcbydVdnGHzxH8Ne4Qq8GUh3
         Ju9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728243712; x=1728848512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wFoqn5U3IFgkxMo0rRByuuyMGm0bprWMsEyD4suNSNs=;
        b=teBcWFQBdvA6GdgCqLjRNMdGgdUagmx94gvedZbObHneRHVUBC+11ehp0abGPDrTL+
         8mAcBCGGxr08XoTCHDOXm/4lfus8kOGxgL9pqtGUDaK/aK/DwuwhfPyf3c99bE45xPIL
         t/v0GzSMWJhiwEBjVJtRTISCvfM4c4SVLnY2xuSZIJ2UHpZS1T3dKecnyh8LjZNZv3Kk
         cS1OolVvPibP7C/7K0g6zxLbz1dQCxrIISFr5GKtMaiE1M49ijYRIbdZuUWflolKvMOq
         8IaHz6BPhbh6xhPVULtK6XchWZ59HsO8XqcuWHKOxKRvCtPNkm1vWPTlc3zazKUdoSkF
         Rg6w==
X-Forwarded-Encrypted: i=1; AJvYcCV7z61x8d4ejTqpzaVphssQcpgy/53UtRw9/hnt2MtniYGD3zyAPCSBH203b1YPOy7unoA3tlIZGPu+AHc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqoaiVUZMTPmsm56thrRC2CjcBvlIAFelybcAkEXvKgx9Brqtf
	dW50RDH9/hs/hm4ucX/ebDzwJT0uGiBdd1J0Y+f+PDx+XnrHQFNmf1Nj50G4xzQ=
X-Google-Smtp-Source: AGHT+IGsFX5d2DcSS4LcFqeh11ecsOdYzYu01fp9p+KGuVf/+pKR366N1XRvSfc1JagbihHfqGil/w==
X-Received: by 2002:a05:6512:b07:b0:536:a7a4:c3d4 with SMTP id 2adb3069b0e04-539ab9cf1a9mr5906652e87.39.1728243712591;
        Sun, 06 Oct 2024 12:41:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d408sm594975e87.145.2024.10.06.12.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 12:41:52 -0700 (PDT)
Date: Sun, 6 Oct 2024 22:41:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Specify i2c1 clock
 frequency
Message-ID: <ykovxr6sf2uywgikeqm7inlfctgdwh5ctiag5vp5i3ctfx3mko@nanyz2yp2umo>
References: <20241004-i2c1-frequency-v1-1-77a359015d54@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-i2c1-frequency-v1-1-77a359015d54@oss.qualcomm.com>

On Fri, Oct 04, 2024 at 09:09:05PM GMT, Bjorn Andersson wrote:
> Per the binding, omitting the clock frequency from a Geni I2C controller
> node defaults the bus to 100Khz. But at least in Linux, a friendly info
> print highlights the lack of explicitly defined frequency in the
> DeviceTree.
> 
> Specify the frequency, to give it an explicit value, and to silence the
> log print in Linux.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

