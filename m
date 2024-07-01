Return-Path: <linux-kernel+bounces-237030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C6091EA0C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 23:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6643B21495
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 21:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9066C17166C;
	Mon,  1 Jul 2024 21:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y02spQQa"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BE2171644
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 21:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719868431; cv=none; b=GXuU0UiP6CH1b68CmUWGc605tztahJyvTn2CzUrFBdOgMAO4Gnfx6jiC0TY43Q7bsTc3MCf92pcS99QVnsWCtOnCCdiRNOOWeDbita2noxKBgI3ef48p5WTBBf4TfG0v+FIA2/OtyEkpCxgQ8nIpUtM9n2YpF/j/to4XcSMVgZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719868431; c=relaxed/simple;
	bh=N9uOqUVYxAGpmBSqVCGR2aqU3MIpbs8kOF1uwgEsfQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WoNvQfhYFKkztVv/CS7/sy/D89ATUaO8FvaKOKM0+XcrDnq18CeqNWqXEf6S/yKrHIKQDuXGqaw0gfrfVUnOQIT7NC/SiWTFOtZc5+OVA3g9kPCrkWOJOu9vbm+SHRy0MdAEXHeCNTNghLyHqFisbS5KKrRE0x1jrBsKU1AmZpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y02spQQa; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52cd717ec07so4425023e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 14:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719868428; x=1720473228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ptVgN4YYQpEV6K7/5QCI7DKm+XnNleCgayxUZPXecLo=;
        b=y02spQQaNA0dbUWo+YMIEmzeEgyqqYyUkUGkvRCBfCRPx7/E7ZJiK2l6nit7SpeGuR
         Y7iPJOVaC0AHh8r48zLN66BOmN8gsE3288zBt6V8r7VBoO5cS9tD1Bv8wuGIdcWniglR
         BG6EstFIq36ZKl7DFAdzuTOsdTnao/DkOd4vZkJw4YC83OOrN6nKm2xqrEpbcKxb2O+9
         GCz6IzRFAd6VioER7NhcKiGidsm8Usdx84DeY4xLa1yewOqZvtI+jMm1tsaBKPmWx7ts
         4NSrSIG/J3mLUpmV6rGwC1XWQ6Y1T71/k5Ny6H5j+uDyE1JrDSSYH7Y50Kgjnu8vcOWS
         tuBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719868428; x=1720473228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptVgN4YYQpEV6K7/5QCI7DKm+XnNleCgayxUZPXecLo=;
        b=EHikc0XCs+AQRXV8T1WR7la888NWQjbC5M7Gso9BKHehEwXzKe5wgJoKzgmdwuWdZs
         w0dr0ly7PWiVJgohbRCHSPUF/1/2M9L1JBtWs+XnnY5LTtIX2h6cBYHNFsyUHFd/xS8W
         Sm4fOSFkzg5GbRLJvc703R4/k915Yv9AAWFw0BD55OxpqwYx75s1h2kj2IIJmwmbdhQI
         NgJil2cQrMmM7VcxOOx7V3yq02SAE6VAM20GAexwuZIBQlMohEUh1212vAZXl2JGWQ1T
         GUpY4jYhCm8fE8fYyqVUX+bstkOqJ2kKwSEYDSeuqAq6ogBAkDNLxmc0dF8dyLZ3ZQp4
         C2/A==
X-Forwarded-Encrypted: i=1; AJvYcCXML1gxicQd5iIwHkWQafwp6NmjT0jMdwWkgB+iaQzVmekVCQkMyEe3a3NuyLZabL3kfTu7e5GCH6gHeknx2F5hFlDcmeXHNr9E3LFE
X-Gm-Message-State: AOJu0YyECb6e2+1x3lQBFlSG77K24R00r6g9yVU5vdJkjbpePo++8eLE
	VlJ5/jSESPl2IhQyVizoUJuxTpQUkQjxCn3JTNAk9LjWstPpSE8fBdN8HHnElNQ=
X-Google-Smtp-Source: AGHT+IE+7PRGx08DXH7bHPZX83Ev55PRXCk/fMJ5OekuRsZQMTczkCluMwsrIcyAiP+bY+Xpuud/rQ==
X-Received: by 2002:a19:e010:0:b0:52c:d84b:eee6 with SMTP id 2adb3069b0e04-52e826932e5mr3754518e87.38.1719868428177;
        Mon, 01 Jul 2024 14:13:48 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7ab278c6sm1557144e87.157.2024.07.01.14.13.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 14:13:47 -0700 (PDT)
Date: Tue, 2 Jul 2024 00:13:46 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ARM: dts: qcom: apq8064: drop incorrect ranges from
 QFPROM
Message-ID: <65yya36amcxdvdob7impc3nlwkklzxbnsi2vpx3scbbjqxloty@y5tj256dtxvq>
References: <20240701062253.18149-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240701062253.18149-1-krzysztof.kozlowski@linaro.org>

On Mon, Jul 01, 2024 at 08:22:53AM GMT, Krzysztof Kozlowski wrote:
> There is no direct mapping between QFPROM children and parent/SoC MMIO
> bus, so 'ranges' property is not correct.  Pointed by dtbs_check:
> 
>   qcom-apq8064-cm-qs600.dtb: efuse@700000: Unevaluated properties are not allowed ('ranges' was unexpected)
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406292139.yqPYyUfi-lkp@intel.com/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

