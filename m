Return-Path: <linux-kernel+bounces-383224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9CE9B18AB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 16:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9842827BB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1826F18654;
	Sat, 26 Oct 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJlgHG3h"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673B318641
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729953911; cv=none; b=Ec5OZpril2PsPdLbySSWgorgq37sczUNZK8AztifYGzxKhIiH6pjLkx2TN9lCMf2M/hBJTjYrek/vcTbSJp9ko9Ss3/BShdcvSJktYCd6TL02yCx2zOW0Uc6KCjq7URGIELoYUht3X3h0SBr+oTgJb++Gfo67YFSew8ZWvN39Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729953911; c=relaxed/simple;
	bh=H5JCTWHzJDfFcAzAjGbw0AJ975PXVf9SASk8fDJqYR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzcAcjMSWcvi94Qp6jHZ5/3cNFQueymbGv1A2clll/HjZFycPoEMa/GMoN/rOMwR0dsoXkVFxwzBkObottOnfQhN5XN4TdJtCv31q++rsmxz3SlQwNPLkQw872q5BaFbrgaPLbnTuehFTAEIPF6XjvlpnSS5DjJ1e7kdUEdVUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VJlgHG3h; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so44419251fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 07:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729953907; x=1730558707; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=REkz7DRdRtxXTqGgy0w9BmyDW64v9/Nv/dpjM6jmtPU=;
        b=VJlgHG3h6N7pH2KX6QblE6rKXu8CJ/BtWYMOCW3MNatYzP9uH9PVV2XB7Mj0x6uJ2A
         Rv57RmWuQICVirYE5vFAKYqz2IGAz18ta8aIdCSA/EvO1DyeeC3/zFjHkeU6UT8BQuyG
         ba5l/qBpxUAbSjZb422AsgjQ8fIMMBLpuK3tZ8MDcjjmeb/DGzA+q4cCiKxa1CB8OYvI
         gF2Wi0ERZrC4JygmhYFvOHv7o3qM/1A/XMXDrSzS/l8qTGbeq5eQaJP/4A3bAJIyqKV0
         rWWzy+9Hhygxjwru3hsMpHtYN74adrkfeDcQHX6B5brBBgpMHyoja13ZKEo94rHZlCDD
         XRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729953907; x=1730558707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REkz7DRdRtxXTqGgy0w9BmyDW64v9/Nv/dpjM6jmtPU=;
        b=np8S9GpDZjeGyqcHsNQkvPH6JRWOmO8OuRX8dV+7jw9+n+HwzaQBHTqxrsrR3N6Ruh
         asm3uyBm3Az5R9cpfO47tFvaqd5O8jr12Q+G0g4Ik8UXat6OayUGj85iiEmQAwYAoJ1L
         FvPahMf0R2+wwPD7goDcXo14hJTRXpGNZHCBwFsBV5GJlY6tF8cK2gr2xt69kq4x+sib
         tXCDldzKfjgP4bbngRrZVcrN7/NzACN5Zw+nh+7DXur7+cZj4v/TRa/x3KyolYnlNgYp
         ZKNgn1DxHhfDH8/3hx8Az4wnR9Pz+fh60Jl7fWlzs129V4OLbdNOdhjrOTcA4ifE2YVy
         AZKg==
X-Forwarded-Encrypted: i=1; AJvYcCWyKZDwm/MQ+ZdFFmemdaHqoeTPKFEDa40IBq0LQEQnX28nx8ALcY9yOOyJMPKp+A58Mq9Y8QEwnIbItmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFGqHN9UiVC1EirgCYayChESxx40o2bwq07zBsEMxT31dI+sJC
	7OLlGaCdbZUrGmfhveBPE2SJDm4RoQZMc7LUJRFWHjmzJLOzbYreeMUqHGg8U10=
X-Google-Smtp-Source: AGHT+IHPWOGIFx2rtlDawJl7JbLkIfvVYS64wBwBCl27j5ZKAZ0b6Wd5JFsRRAEPbMvro9n7y/Sdaw==
X-Received: by 2002:a2e:5119:0:b0:2fb:8c9a:fe3f with SMTP id 38308e7fff4ca-2fcbdfc7509mr16228161fa.22.1729953907276;
        Sat, 26 Oct 2024 07:45:07 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fcb4507b90sm5698381fa.12.2024.10.26.07.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 07:45:05 -0700 (PDT)
Date: Sat, 26 Oct 2024 17:45:03 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Sibi Sankar <quic_sibis@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 1/3] dt-bindings: interconnect: Add EPSS L3 compatible
 for SA8775P
Message-ID: <7k2vnjop6xyshquqlbe22gm7o5empeluvsohfmq5ulnaas3keb@yzomhzi4w7vf>
References: <20241026123058.28258-1-quic_rlaggysh@quicinc.com>
 <20241026123058.28258-2-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241026123058.28258-2-quic_rlaggysh@quicinc.com>

On Sat, Oct 26, 2024 at 12:30:56PM +0000, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider binding on
> SA8775P SoCs.
> 
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
>  .../devicetree/bindings/interconnect/qcom,osm-l3.yaml         | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> index 21dae0b92819..042ca44c32ec 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
> @@ -34,6 +34,10 @@ properties:
>                - qcom,sm8250-epss-l3
>                - qcom,sm8350-epss-l3
>            - const: qcom,epss-l3
> +      - items:
> +          - enum:
> +              - qcom,sa8775p-epss-l3
> +          - const: qcom,epss-l3-perf

Why is it -perf? What's so different about it?

>  
>    reg:
>      maxItems: 1
> -- 
> 2.39.2
> 

-- 
With best wishes
Dmitry

