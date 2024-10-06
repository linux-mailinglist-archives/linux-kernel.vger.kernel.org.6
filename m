Return-Path: <linux-kernel+bounces-352592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 184CC992131
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CE8AB21223
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5399916F265;
	Sun,  6 Oct 2024 20:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r4HrfYLr"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89D16EB56
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 20:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728246898; cv=none; b=OHeqmXeZMKSYFv8aDWuyPsZOwa6KshvKbnFfk4FQVHYv/S+j3VWxOb5LmBQiyMdmyku50SXkQq8KgqHvzg6hDl/YSVimQ5t2SWFSrgIL3pMBOh7Lvn2+SUkQHpvAzQT0o52jeVCYrq4/99TaQIywfMjhYq61AKl5kXUwivGxIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728246898; c=relaxed/simple;
	bh=BOB8z6S4m7Arz9F28cP4HWF7U8MzWTx6sOY/S8Q9Pc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Du+jmXIIzzdcFXY903thsoSm5smHmJrm9vc18D46pFWKO8FqyHIeS2m/8MS4QzNcf7tdQ9GZlMTKNS/Nr97h9CIPZT5IQJGTHAJ6GJncYeY3P7TeCOZX1gpp/K1HGZQQiqrWFTyiMmbT/MnAfUuB3P40Xe3wV2RmwN11RzBdXIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r4HrfYLr; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5389fbb28f3so3804444e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 13:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728246895; x=1728851695; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KsSwteNpIsR1xjaiiCzJ87ajABbsMquYMbxyKUsa7Z8=;
        b=r4HrfYLr5/n/cUPSDLZAr33lwWo/WPjuzqF9ZCXBb1ci7KC70ez3u+/WrQ8iArpX4n
         5UOLAh+koi4HzApZdeKlXArfVkVwGxZwiz0xmZSMgW12uQaFwszAdKZOHlaUZRRknsZ+
         94lNYRSyNaosOZitI2WSaJQ6gn0KKngxnqP14Cc8yvQ8JlHRGUKUyb/7EzKNrcuGlO4P
         Sfa4Ow/MH30E28tujsrshyv9ygKmGWt3ATN+RIZl6Z93n4Q6r8CutfEg5Shwo0aQcz9i
         MeDyGaxZjlZF9Kjw7eddv0isUUW0cmd5SoDqSe8DncpMVEXAEpwd8T2KfZMaK2i9VGbD
         Uw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728246895; x=1728851695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KsSwteNpIsR1xjaiiCzJ87ajABbsMquYMbxyKUsa7Z8=;
        b=H/RnMQRN2g1StJ5VIQYlXWUnSB49sIcGiJwmd25w48zpAdmD+NezkzIfHl6SVbl1QQ
         DUtX5N1t69yLk99dLKprOLBmMxug4Zif7/AZBAEh2PIMtDDAIrhnhItDyjuORj4DAf5l
         c1ZOU5Y3gSFi087MTV6wa9Z8CMhUbwQHKnsh79195rpcWPUJqdAkrnaAceWb+cVrNSD8
         ukUypNcdklw+KEMV8QkL6empR9HwnkriZ/n+jhGWGWf91yuvcmRq6SddUCSXnkN07Nvu
         +2kgSkeeKrs/qej9pfiACD4XsRrPMRoZ60VVgMXrWJQFRoaAxWDV6/kZuHZlmHD3hJFl
         TkEg==
X-Forwarded-Encrypted: i=1; AJvYcCXLUqzX5Vn4PHGN9aTfeQX0SiIlaIIxP/9WR78yz+UQVe5nwO8Da5D2NMEoosmF28ZKRL5V2tb5fHAe040=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy78Gi/chp5VvJNmLdcBXJYD2AnSmJV8rq/qM3bnBzr4zNOSuGo
	HXm/hJqMYq+cG4jPeX4/sn27NBSYBfOpPK8Z1lrZMTdzlkiDQFtwdZnpr52ByOM=
X-Google-Smtp-Source: AGHT+IEGpqKPZnYf+c49PCJtMCsHlNlfYiXoM0A4iU65uHRBMlYdcbTJgw/9IEtv/T0uzP6otOuyAg==
X-Received: by 2002:a05:6512:1056:b0:539:950b:139c with SMTP id 2adb3069b0e04-539a626196amr3816459e87.12.1728246895194;
        Sun, 06 Oct 2024 13:34:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec83b5sm612915e87.81.2024.10.06.13.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 13:34:54 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:34:52 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: linux-sound@vger.kernel.org, srinivas.kandagatla@linaro.org, 
	bgoswami@quicinc.com, lgirdwood@gmail.com, broonie@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org, 
	konrad.dybcio@linaro.org, perex@perex.cz, tiwai@suse.com, linux-arm-msm@vger.kernel.org, 
	alsa-devel@alsa-project.org, devicetree@vger.kernel.org, elder@linaro.org, 
	krzysztof.kozlowski@linaro.org, caleb.connolly@linaro.org, linux-kernel@vger.kernel.org, 
	a39.skl@gmail.com
Subject: Re: [PATCH v2 5/7] arm64: dts: qcom: sm4250: add LPASS LPI pin
 controller
Message-ID: <6siuxtimluikddn6seerbsyb2kkz6vncxfawleabotqcz4jy7e@ze53gesagjlb>
References: <20241002022015.867031-1-alexey.klimov@linaro.org>
 <20241002022015.867031-6-alexey.klimov@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002022015.867031-6-alexey.klimov@linaro.org>

On Wed, Oct 02, 2024 at 03:20:13AM GMT, Alexey Klimov wrote:
> Add the Low Power Audio SubSystem Low Power Island (LPASS LPI)
> pin controller device node required for audio subsystem on
> Qualcomm QRB4210 RB2.
> 
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm4250.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm4250.dtsi b/arch/arm64/boot/dts/qcom/sm4250.dtsi
> index c5add8f44fc0..37c0e963e739 100644
> --- a/arch/arm64/boot/dts/qcom/sm4250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm4250.dtsi
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2021, Iskren Chernev <iskren.chernev@gmail.com>
>   */
>  
> +#include <dt-bindings/sound/qcom,q6dsp-lpass-ports.h>
>  #include "sm6115.dtsi"
>  
>  &CPU0 {
> @@ -36,3 +37,18 @@ &CPU6 {
>  &CPU7 {
>  	compatible = "qcom,kryo240";
>  };
> +
> +&soc {
> +	lpass_tlmm: pinctrl@a7c0000 {

Please add the node to sm6115.dtsi and override the compat string here.

> +		compatible = "qcom,sm4250-lpass-lpi-pinctrl";
> +		reg = <0x0 0xa7c0000 0x0 0x20000>,
> +		      <0x0 0xa950000 0x0 0x10000>;

Please pad address to 8 hex digits: reg = <0x0 0x0a7c0000 0x0 0x20000>

> +
> +		clocks = <&q6afecc LPASS_HW_DCODEC_VOTE LPASS_CLK_ATTRIBUTE_COUPLE_NO>;
> +		clock-names = "audio";
> +
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		gpio-ranges = <&lpass_tlmm 0 0 26>;
> +	};
> +};
> -- 
> 2.45.2
> 

-- 
With best wishes
Dmitry

