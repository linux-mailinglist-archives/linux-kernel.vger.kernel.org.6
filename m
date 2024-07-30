Return-Path: <linux-kernel+bounces-267218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC808940E84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8892855FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCD818FDD7;
	Tue, 30 Jul 2024 10:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SQrgTGaQ"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630E018E753
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333621; cv=none; b=eZA13ocv+HgfFIYzqyBsLZCstZwX7JFyini6wvQHgpaiBjSjmAiEv9BcCaKhDFFlactbuP2fCAuK5LJ5IndVBO5pdD5SjVmcFV09QgIb1MiSgir3Gade5FC6eZAJCaXKe6xFNwxi8Fcke7tuzYxHOyHqZn1yzAGHX6MM27h1VRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333621; c=relaxed/simple;
	bh=ui59s49kbSzOwwvEFQmgYxVMb+8J5SZQRA0nX9jtzyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYk27oa/NaPgZogCOMG+DZ9EpI9ITs7BGtafIIFN6QcQurJBoiY+48/NGM2qbmaZAQx9Jq2/mz4JYiIPO2/ESyhCQ3v4pZVgjz6gHVZb97UaIyF+q3XSa24eJ7AbvoUVCXr72uzNwJHI9AwlNth7LHB6Vg6QrDNyeoj38t7Nm+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SQrgTGaQ; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f040733086so50263251fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722333617; x=1722938417; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1NIt1Etrxc7iUD+v3tWQ2w7Bs1xfSMNhKNXoOLhNK3Y=;
        b=SQrgTGaQY80LD6vD6/o/UwRqy+/VsIotyKINhORmvLUr7fdqfJc37anjCVu9XYPzh4
         vS8jv8gUjkC7RTZy3q4uLmSzLZX9+PmerGqlW70H9V01jKmCHQHOiDmAVVmJh7KQOHrV
         NIbEiJz8jk4KeDgI/m+9Dn66dvKJTW0T6cpuRanwV2u/kDS40nH0wF3o8atyQjuDh21j
         nGvZ1VP94chdb+r0Sa5O+FgPbXmu28/oeHWRvWWC2CsMOwhP1Nc7cn2dN/vzpfw6qaIW
         GGXvwzOT02VvKAD6R8PrtWHxRy73nWhYQf+GlsBtm8FXx9oTlzqwbbjMtN/5lokbnbGy
         yIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722333617; x=1722938417;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1NIt1Etrxc7iUD+v3tWQ2w7Bs1xfSMNhKNXoOLhNK3Y=;
        b=QfTNyIHC8lNKGgybC4xJMP0/1lk4opVZUpNen8Gy4imKdzPKWWJVuGj3THMJ6jxVWq
         sbLLyVTE5y4mhQ4CkoMsTFp8uNUPbg5fVbqdLt+EE2LI5nL2/wEnU1E6x5xWu3ES4+6b
         pa45+qM021Sodp8keE3FzwiWkxldV9LrRP039BhnLr+vJjpEaVT1r+Zx1sQ2+roAriXS
         79W8DA9XY5SSQzZkSe49q/2FwS5TNA1prcapCGYKeXoIy1lOv1Ujv9JVu8pMtUVFwo0S
         Ze+XtW6y1YgP8+JFPubNAGa5c1yQBVaC6oE5EnHoEsgW9DkP2JO3xfMpIUCGwlovqDub
         9/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjYbjwaYR+oC341K7J1Tbp2lT6hZG3yyOgl1VIsW7IS/h06nqyOSIkkFB/t/tlp8CVFk1324taWeVy1hlOKmqxxIN9ntE9xDlpe9Nf
X-Gm-Message-State: AOJu0YwG1a3JM0Jnd0dI2zdDt6pIrCB5kqmhpFEIfSQ3lNURX33gt/B3
	LGrLHkWLJJ2UUavU53eyENTtzUK7YoVYrqprpeSFvQQ3wsZeqV4kQ3GvFxtKPm8=
X-Google-Smtp-Source: AGHT+IHY67PLRpoblhniT8LZ0mIR8njEuCwBotLAp/dSjdAekUYvjbCG2ekFkxI23FvMBZxtJ+naXA==
X-Received: by 2002:a2e:2201:0:b0:2ef:2b05:2ab3 with SMTP id 38308e7fff4ca-2f12edef6f0mr69578091fa.10.1722333617551;
        Tue, 30 Jul 2024 03:00:17 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff1f:b280:8303:a4e9:79c5:e939])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6339bcb3sm6939494a12.5.2024.07.30.03.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:00:17 -0700 (PDT)
Date: Tue, 30 Jul 2024 12:00:13 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Clark <robdclark@chromium.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: x1e80100-yoga: Update panel
 bindings
Message-ID: <Zqi5rUQqWa9wZCva@linaro.org>
References: <20240729205726.7923-1-robdclark@gmail.com>
 <20240729205726.7923-2-robdclark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240729205726.7923-2-robdclark@gmail.com>

On Mon, Jul 29, 2024 at 01:57:25PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Use the correct panel compatible, and wire up enable-gpio.  It is wired
> up in the same way as the x1e80100-crd.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> Reviewed-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Note that the power-source differs from the CRD.  Figured that out by
> diffing $debugfs/gpio.
> 
>  .../dts/qcom/x1e80100-lenovo-yoga-slim7x.dts    | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> index 70977e9fa266..6f8d52c368a4 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> +++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
> [...]
> @@ -669,6 +672,16 @@ &pcie6a_phy {
>  	status = "okay";
>  };
>  
> +&pmc8380_3_gpios {
> +	edp_bl_en: edp-bl-en-state {
> +		pins = "gpio4";
> +		function = "normal";
> +		power-source = <0>; /* 1.8V */

Hm, are you sure the firmware sets it like this?

power-source = <0> is typically VPH, i.e. the main battery supply
voltage or similar. This will definitely be higher than 1.8V. It seems a
bit odd to use a variable voltage source for a GPIO...

Thanks,
Stephan

