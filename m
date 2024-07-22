Return-Path: <linux-kernel+bounces-258819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7437938D0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 12:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 156001C2438D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F3B16DC21;
	Mon, 22 Jul 2024 10:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FfJ64m9/"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740D316C695
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721642587; cv=none; b=eJtXlRTvQ5DWx8biOqhd/CxBMQ+QSf100GmqDhjroMQG5ypIewomgyjH65FZptCJJYW99R2p87xfk/ZT96amjug/f6ft3Nkzq48vJla5dg0Lo1eDJiv2kmxjepG69QK2d5YHJAtjgS4Z2P84eS7gfwJXCKbqUgJZe3XAigFsE+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721642587; c=relaxed/simple;
	bh=mc7VJ7p3yeW6pMnRfGC5n6Qmr81KJ5bceRZV04+XYAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vrmch6EgoL1FhhsQY5g67kVspqllWelkC30LLhP5f030VcWlxgT5NZhvGAqbc9+W0d70EYqwzZpuO9qvg9ObACD7TJru4/XYuR1dIX718HtnjzDF252LNy/oKwfew7S0EJ0fKNMmHHItWXTwLGxTRrpxlTR+wNSMv+h9kuJeZ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FfJ64m9/; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-367963ea053so2728620f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 03:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721642584; x=1722247384; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gCO3+bSJCB2sPow9UEmioT7r0U2bl9MSIRkmgJtQL98=;
        b=FfJ64m9//pS4LOas1EtjBzh0jxqMkqbsQL3rCsxwxAHQaLXBEUAi0XL4DwOSvBkWaQ
         tAmR3Hsw93Cf+52siyDssHd6ESWOi59jNbP+twkb6tqu56hvt701FA3GSa/EyNoT/5xC
         7EJu8EF5zEi5wGFuHaggxTGgXX9lNyNYWzPcyl7jjbOr61EMVbBU8NFBebMkmK9nRon8
         l/HQQWuvIPLFcBy5SRGrPhF7+4jxRTVL803+f8X4S3FEl6/7TuTLSQmky4n1jY4PSjH6
         HdHddXcom5dnuAEYPvgtCuk5bsCVK3J9nqcqyGEWPrnEMx4C66Sy/2OGvp7EHj2hOLkQ
         6Rxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721642584; x=1722247384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCO3+bSJCB2sPow9UEmioT7r0U2bl9MSIRkmgJtQL98=;
        b=JrDcvf4OO2vRQDFJGfB5Pc4eeoLz1PpCjOmQj4JmKSBOq6apkrV4JTthJshFqXdZ3W
         1zqSwouwjDuG1wkzpTyK7aB0Dr5rgoV/n1B6VB6fzH7ErSgPTmvyVOIsRv1LF/uKiTh4
         3QtJ02FS7dYcHL690W6aOQvPYuB2NXNsDTIp6NZdKMH2E3V0eh6vo37TRo5w9kdUOHWk
         TlT1dRE1vSxLZRnCJ571NkTXnaqquTou7J1rR6DCUjaQHAhNYxur95T87h9i0atX7gpA
         cS18XwC/zRVvYv9fFTquaQyjRG5F6NNBj137rLNns36cl9N63BLpTmdK4i50r9uw+qMN
         YLRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV19xtn0zGDaenKYkinAg5kZlJt0y+J7cKSz0bnH8LCNDFrm1p2gj5jEeqiWvAJ2izt07DA/hFY3ujjaMEhwiR8oCEU8qI7ibbgDZ38
X-Gm-Message-State: AOJu0YxUtaAlcwC8FwIrAQ0LFDYzeipv8OnrHFqcnUOw5SR7bzZ7NkR8
	XvnaTW/CxzODJY3wqvubyrtgU4ESY7dod9fWkabuLLAo5thg79jupR23YDipaqc=
X-Google-Smtp-Source: AGHT+IGPbJDhczF/OiFPT3bU5561kxK92Vr2PSXJdnkys2h+5HyYcPqc1LjrJAZpsvaysl8LS44TXA==
X-Received: by 2002:adf:e68a:0:b0:368:4910:8f43 with SMTP id ffacd0b85a97d-369bae3a608mr4528325f8f.3.1721642583780;
        Mon, 22 Jul 2024 03:03:03 -0700 (PDT)
Received: from linaro.org ([82.79.124.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3687868bc42sm8077050f8f.46.2024.07.22.03.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 03:03:03 -0700 (PDT)
Date: Mon, 22 Jul 2024 13:03:01 +0300
From: Abel Vesa <abel.vesa@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sibi Sankar <quic_sibis@quicinc.com>,
	Rajendra Nayak <quic_rjendra@quicinc.com>,
	Xilin Wu <wuxilin123@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/12] arm64: dts: qcom: x1e80100-qcp: fix up PCIe6a
 pinctrl node
Message-ID: <Zp4uVfQa+Bt026xV@linaro.org>
References: <20240722095459.27437-1-johan+linaro@kernel.org>
 <20240722095459.27437-3-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722095459.27437-3-johan+linaro@kernel.org>

On 24-07-22 11:54:49, Johan Hovold wrote:
> The PCIe6a pinctrl node appears to have been copied from the sc8280xp
> CRD dts, which has the NVMe on pcie2a and uses some funny indentation.
> 
> Fix up the node name to match the x1e80100 use and label and use only
> tabs for indentation.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Abel Vesa <abel.vesa@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
> index 212ed20b3369..86735f07fbb5 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
> @@ -665,7 +665,7 @@ nvme_reg_en: nvme-reg-en-state {
>  		bias-disable;
>  	};
>  
> -	pcie6a_default: pcie2a-default-state {
> +	pcie6a_default: pcie6a-default-state {
>  		clkreq-n-pins {
>  			pins = "gpio153";
>  			function = "pcie6a_clk";
> @@ -681,11 +681,11 @@ perst-n-pins {
>  		};
>  
>  		wake-n-pins {
> -		       pins = "gpio154";
> -		       function = "gpio";
> -		       drive-strength = <2>;
> -		       bias-pull-up;
> -	       };
> +			pins = "gpio154";
> +			function = "gpio";
> +			drive-strength = <2>;
> +			bias-pull-up;
> +		};
>  	};
>  };
>  
> -- 
> 2.44.2
> 

