Return-Path: <linux-kernel+bounces-548638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2B6A54761
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7C1171E93
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4846C1F5845;
	Thu,  6 Mar 2025 10:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w++c08qH"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE29C19DF49
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255839; cv=none; b=RKV3UB8PzxhkT7UPw94SF3OZ51VsxOvM/NBojL/CGOXwgd1Paudwx+1EMUFc6ihOXjBgdTSTXzRqmYhJGEii1hTYSTdl55WAuASReONpv/h/Nn/y/EWvyHHrFS8if7X4msLat3ucCkgFMQSeiRLO2CUuPj0Sh0Bi+Jjt/THVW2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255839; c=relaxed/simple;
	bh=eYHRpoGMbEGwPMptizuEYfx9VxESUqNfPyr+BhppZYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=liu+rW7cw13ajCEiUVp84adI0rbGNN5fvXXDwETW8L5BFkn9qQRoU7Dq9fcgXCoqTVrdEpsE8VpdxWrdxJlRyrGf8R6yyNatpR78bABlpRI+3TdQVxxpTf/eNKJ8WyIjekHNPUc/L7kZ2uPYhlP/c3MAGpiuTXinWruTMiMHO+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=w++c08qH; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5452c29bacfso570906e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 02:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741255836; x=1741860636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8lXiXH7m4bW7beAtDaeOppbANkLDTvV0BWddr1dN36Q=;
        b=w++c08qHzu5asHISohwyZH16TnRlJQMrE5DyPs14ENnb7BJezhusMneceSxxZ5ppB3
         bhSw+JIyj4055Tc8jpbKq4g3R/ytCZYWBhfINvpCHsqiOprHD7o2gngSpn8TvrogJZvu
         pmHrlZfAzYFsB74k1u65q0DdpUVfr1RKFotOc9E1zR+1VpEFtMR89rdb6v1m1NK+TXOu
         uicjB0Sqc6n1jYGajTUN2q02c0f5YO1+A2VmrQhYa0UL6bw6yKP+CRdJcuS1Ed1u3tzH
         c/2CxJLBtIj3IgKjw+LsuBXxyZqZv8RCgto2nqqsOrufEZp2OWnBPiCiVBvKcyfs9RXv
         Q/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741255836; x=1741860636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lXiXH7m4bW7beAtDaeOppbANkLDTvV0BWddr1dN36Q=;
        b=bfUSAktKgMyVRbL39T2m4mzM8wo9muhb3QZMjI/sKVacGpt/5kHPvtj/d3j2KDMw7m
         9D8Zn/6k+GOQLat49wqaoV494sPQz9BU/8/8X6R59rlTgxUheUq6YPWdi1hGsUVrusvH
         ouaUhPvSd2oSPmAOKr7T2HKeR1ehbVKYwiL7VELuDMR1m6rhAuXVrOYA6xc2dxzt2g42
         BUwdA6X0qLUhD17xfkbQ82tFm1unhDetD2y+zjMU8ARBzjLR9U7RcbJUdKdxJK1wOgZt
         9WMT9tO9YBr4vHgNxwf/bvZnsOWeP4VZZBaQjAjXY4gDP3erru4q1HYGLedtWlDZqnQi
         2jfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrd5yanNWZa7yE+xN4JSMXcNSYnAlastuGmO5FBGvDyUhnjG6Rojw6rtyb9W2XmsnZirrbF7mCFFks+lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIPqTeMxT+/o3uuvWkwzF9o1e3tefF4Zyq2clXBclv3sg+QPkr
	rIa9f0JwFDEqIv/a8rgdbIDyZaapzM/TbUoEiIlKRFapcHJCDWNLKTyL5hJc0bc=
X-Gm-Gg: ASbGncs10UL1Dr9K8nEqoI7RGVbyed/WW4CC5EAGlzOMoBjosJ6kCHw9XDFZI6uCiJL
	/EnZKPOn6y1/Y/BXoTj7aPJQLS8AsRLvigx276iFNs/XyW7ISZfeeAyhGsuK0EiUsYQmkA9nqlU
	4c5xscb/EjOjMbIL6S15DJmH97BIqwSTy5JzuU/9cdenq0LExKdiuy/PLj0L32v9Px6A34EKqJv
	D7JQjIIIx5yGci0hTHKpB8Njm6adrvGOBOqwj3KII1C8DJr6lBKGNTRz5Jvmi6m//tQhRGhJ9zg
	pMr+/xw6A7AezsvbIyMdv2YnQH8BWiLQdfzim2noGjNGG4KxZSG96bQx+ow8B85OotbkGDdIZfq
	f4/EUoUvzc1H04MZWg2bVcRVX
X-Google-Smtp-Source: AGHT+IEGoBCXiFknPijPVAnfPhY1JmrMAFB6C3192/jP8Nr//KDRez0P/W0L5K/UXtmr5uC8I7tOXQ==
X-Received: by 2002:a05:6512:1094:b0:549:4e79:d4c0 with SMTP id 2adb3069b0e04-5497d383257mr2057776e87.53.1741255835620;
        Thu, 06 Mar 2025 02:10:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae580c5sm130034e87.70.2025.03.06.02.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 02:10:34 -0800 (PST)
Date: Thu, 6 Mar 2025 12:10:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v2 1/8] dt-bindings: clock: qcom,sm8450-videocc: Add MXC
 power domain
Message-ID: <mboqw4on22m24njo22r3xajjkgmyobynv5qdx4yhbblz5lekw5@xd6xkhlrh62w>
References: <20250306-videocc-pll-multi-pd-voting-v2-0-0cd00612bc0e@quicinc.com>
 <20250306-videocc-pll-multi-pd-voting-v2-1-0cd00612bc0e@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306-videocc-pll-multi-pd-voting-v2-1-0cd00612bc0e@quicinc.com>

On Thu, Mar 06, 2025 at 02:25:33PM +0530, Jagadeesh Kona wrote:
> To configure the video PLLs and enable the video GDSCs on SM8450,
> SM8475, SM8550 and SM8650 platforms, the MXC rail must be ON along
> with MMCX. Therefore, update the videocc bindings to include
> the MXC power domain on these platforms.
> 
> Fixes: 1e910b2ba0ed ("dt-bindings: clock: qcom: Add SM8450 video clock controller")
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> index 62714fa54db82491a7a108f7f18a253d737f8d61..737efc4b46564c1e475b02873d2dc124329fb775 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> @@ -32,9 +32,11 @@ properties:
>        - description: Video AHB clock from GCC
>  
>    power-domains:
> -    maxItems: 1
>      description:
> -      MMCX power domain.
> +      Power domains required for the clock controller to operate
> +    items:
> +      - description: MMCX power domain
> +      - description: MXC power domain
>  
>    required-opps:
>      maxItems: 1
> @@ -72,7 +74,8 @@ examples:
>        reg = <0x0aaf0000 0x10000>;
>        clocks = <&rpmhcc RPMH_CXO_CLK>,
>                 <&gcc GCC_VIDEO_AHB_CLK>;
> -      power-domains = <&rpmhpd RPMHPD_MMCX>;
> +      power-domains = <&rpmhpd RPMHPD_MMCX>,
> +                      <&rpmhpd RPMHPD_MXC>;
>        required-opps = <&rpmhpd_opp_low_svs>;

As pointed out by Vladimir, you probably also need a second entry in
required-opps.

>        #clock-cells = <1>;
>        #reset-cells = <1>;
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

