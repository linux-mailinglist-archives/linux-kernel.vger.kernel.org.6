Return-Path: <linux-kernel+bounces-270867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC5994466D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 096761C21F8D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610E716DEAA;
	Thu,  1 Aug 2024 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OjAQA/3w"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDE016C856
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500515; cv=none; b=MVtPKIryydd3o3JNryOrQ2Qz6aFczuNuUunUus/cspYpK7NMIKD3T3TQP59u6hjInVZl+sllxwqkQI9nGbaXoUmo6Pte2lI1SSRxfoueBIPEEiRlTJKW8pej/JZHvY0luWxvs+ijl1mPQsy+c4eexen5hJRAr5UlYIEIDVqLFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500515; c=relaxed/simple;
	bh=UoQSyuIzYrJk4Fh/zjMGo2XwjtgAN5edcsp1gl8VrW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPHyeIvDMIeq+rWRRgf3UYAv6CYyC50k0e2KvqRaWFOOET2C9M2N9sPCcJSY8xTIZ5/hEetTsn0j/qQCRYschPTuIvw50ncUQgswLddFmQEcmPFV2GBfubv0wVketr5sKEGmaXI0cN1nR6sZU3mrUHpuw2GK9zsNdoIJIMXscUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OjAQA/3w; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52efa16aad9so9711883e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722500512; x=1723105312; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tQu81mOBzzOWipOlZKpoZPnN6w6xjj6nnqcvweSDhgA=;
        b=OjAQA/3wLDdWRK77nYoWsOnhvDtYCalWDNPWwmg9HYG0US5JU/cJPaLa94mQ+P3175
         1ta2Btuffkvs4SUOuQYFPJCU5kHwkFAeJ2Xeoz4zzWvsCGMnSPfkx2sd+vK6jYVe3CvZ
         /8Rymur7iOTia/PDRru/blzMt4tmI1t9C2+u/zY0oWhk+N96CbjE/NjEA8TpMaNWREsi
         79IDYCAysEDsfGN2WfIIPI5WwVEYXgXIp00AIxl4Kru0W4JnEGaNpsoAn/0ResxKjgln
         t/e1ez8sXLEstege+U1knxeZeSOO1pWg43zBlwjSMP4rWJGiqBZMHrzDWFtdRfFnFbNb
         PH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722500512; x=1723105312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQu81mOBzzOWipOlZKpoZPnN6w6xjj6nnqcvweSDhgA=;
        b=anWz507UoWQ8k0I6eU+4MwSj7ZBai+yHpJVRcoSumntmlHFR0QQMqFXXhEfmzD2Vm5
         CywzG7NIkGRaJ+CKqLOxFgYgShEs5fCX3PRoI35w/G38YahElopUslLB1U4yuJ5DnANs
         P1Jh/cBCDQmDV2nlw4+O+4gyKW8YUG2ZcOMHLSEHlHSudsV/bE3eWd6fZFLeI+4Uc+Mn
         e/iiqc7prfE5vDqhAshqbd89BceW+396yMCm6V1Ew15pve78R1GqDa+sdMo8PnjX9hC2
         NzaxcZn9wsYIr/0AmPc/Jyj4L2jL/c5H509MzJYL7I9SUQl1VcKn3NqnYAxXajTN0zrX
         SG5A==
X-Forwarded-Encrypted: i=1; AJvYcCXddM0lv65Z4uZdyI5D5WLG3eR1JI8FexH+XTBN7csmsrnNbOydB8utWv2EmupVY9mHqsXNFEq3l4RfM6bVb4sD66MXdP4Jb/DwWkEA
X-Gm-Message-State: AOJu0Yz1FNSHBAhbZNHVoynsqYCoXC8UbrVDOJaASIdcr5L//3p99xF8
	LL5pyHrXJ75eCotzpVqearqs2vIZTXW0Q0o1N7ChUXoMzIwfyvJxcj5DdKsqkPQ=
X-Google-Smtp-Source: AGHT+IGCjn18yTuRNfOwsOFNz0Fkpj4M64OUkHF6jkjiHZXaoXhEToRN+DzmYsOikMX79YcrO2lmHw==
X-Received: by 2002:a05:6512:110d:b0:52d:582e:410f with SMTP id 2adb3069b0e04-530b61ed210mr1013825e87.46.1722500512059;
        Thu, 01 Aug 2024 01:21:52 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530ad7faa08sm649248e87.214.2024.08.01.01.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 01:21:51 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:21:50 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Adam Skladowski <a39.skl@gmail.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Stephan Gerhold <stephan@gerhold.net>, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/8] ASoC: msm8916-wcd-analog: add pm8950 codec
Message-ID: <estrecxmj6im5wk5iy2eahcqf74mw6ydnvbpuselmrvb2paggc@u2dsyrn3wki2>
References: <20240731-msm8953-msm8976-asoc-v3-0-163f23c3a28d@gmail.com>
 <20240731-msm8953-msm8976-asoc-v3-3-163f23c3a28d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731-msm8953-msm8976-asoc-v3-3-163f23c3a28d@gmail.com>

On Wed, Jul 31, 2024 at 05:25:27PM GMT, Adam Skladowski wrote:
> Add regs overrides for PM8950 codec and implement matching reg overrides
> via compatible.
> 
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  sound/soc/codecs/msm8916-wcd-analog.c | 52 ++++++++++++++++++++++++++++++++---
>  1 file changed, 48 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

