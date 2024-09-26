Return-Path: <linux-kernel+bounces-340485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB899873F9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACCA7281DA9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859551C6A5;
	Thu, 26 Sep 2024 12:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/zY+tjk"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247AF1BC4E
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355585; cv=none; b=E/a2h1Lhi81v8Quk5AQ/UK5psrS3KQHRaIIpd/kG9kH74/6ll7gunY1I7PYXE937Aqckk8r+YVOgkbITFDzOAlWAZTZ1+vnS4Qo7WxVKwvuEutyePG/M1hpEyKsajNC3blCI54tuXZSbHPAQs9Fnfc8pSTSwHZY13HS3K1IvZjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355585; c=relaxed/simple;
	bh=DkP0T2k2pm96b8ugmpQ9mEmyQTi/T2s+vr1nFNVL6ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjEyd2C0pJqoUPMhlDLD4tNwufZb9TWkUnQ+05Gg9ng7LkR/948gfs4Ei6V3EJV6hpDzbWzZ0DWf7R6Ij6xayMQyQev1gzLzfqCIj/mqn/hlfBNTQlZuXY60dy/QV9Wvux2lMz+bNMpWKtEnpojkJ7gCNdspQ6bwXyS//jjx4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i/zY+tjk; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53659867cbdso1561955e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727355582; x=1727960382; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mvD5VesI/aj5ylaTV7+TzQ4pLVD1SRNWc/3077REPN8=;
        b=i/zY+tjkwuXwf29Aa6oH/GDl7wtrR2TUR+BWRmI7Wv4bgH/n6NnG/xtDdwiXb3qF/5
         8tn7r/6uZ6Jkmw7Cu2wvpyRLGKRZyvMASLJ9LgLjCc8FnZJK9cmdxQxBNWj0DLMhxjaD
         vXk/T4FGxJ2PG92V1D0wTJZkFvLecgEdX6YTiUe+xhddoTKuwkmukqWRSCVxaj7nxI3U
         ubY/az9zm7P8xN+1pKZ1Ibc5BnQ0LPFheJDC55sr9a5ossfbOuH9wbW4g0p7nh5ivYW+
         +yZXdzXZxFROIg+ENYGoSvHyj2xEtEGAPVNZ2+wBesE4IdlIKOQYx541ase5xYZEGPP4
         kRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727355582; x=1727960382;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mvD5VesI/aj5ylaTV7+TzQ4pLVD1SRNWc/3077REPN8=;
        b=ebBjRm4rVmmFhoDCWOuWYJ4lGAVRZsnrPOImanaE1Un3xSS8tyxo2f1/IGJenyFxez
         A/NOyeBWu4sn+/C01gCw/RZKSqZiLdZsHhXLHMXe8ZVmbY3cws17GCmVYbcRo/dzlnk/
         jfh1I4VIbjXJ3KP+jR/Rvp0/fPKZXrCzBFq/4cAOrsO3f2QWIcx9eBEPkB4c4NbkZhxp
         QSFo6NE+zZyNdSHbsrtxfL/UXKtldv6AFBAGM/pTrEHtkmL956k2uWopWAz5Oe2Shyc5
         pQSStYA4+Z7qDkangr5tTW51Qih/5U3KNND9eo0k0okZRdbuG+xW/bK4VYau52uhQmn3
         0N4w==
X-Forwarded-Encrypted: i=1; AJvYcCX76i2VpKSVnK2E52PBBOsrmtGCpZzIN/YDFoFUbdokLqJmjpYwV9AW2LtJ850BTTJKPZn6rUA34gjkF0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL0DedQCx3U2UWwZlUGVVzhCxbt68fwpXbuPHpVR4veKNRbRb7
	SmUzMS4T7RkpzzxTPdo+tQcuEoljvbSYqejSSkdk54RNR9RlDln9GtoMnVBCRAs=
X-Google-Smtp-Source: AGHT+IHDWkduitjhzRm6lHTb8hOr4NlvZ7w8mBztIp0QiKdICcPR7Kr0FiZmnSQrsTJV08gYOhqOVg==
X-Received: by 2002:a05:6512:104c:b0:52c:d628:c77c with SMTP id 2adb3069b0e04-5387755cc25mr5494174e87.43.1727355582176;
        Thu, 26 Sep 2024 05:59:42 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a8640908sm798094e87.122.2024.09.26.05.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 05:59:41 -0700 (PDT)
Date: Thu, 26 Sep 2024 15:59:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Mahadevan <quic_mahap@quicinc.com>
Cc: robdclark@gmail.com, quic_abhinavk@quicinc.com, sean@poorly.run, 
	marijn.suijten@somainline.org, airlied@gmail.com, daniel@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, swboyd@chromium.org, 
	konrad.dybcio@linaro.org, danila@jiaxyga.com, bigfoot@classfun.cn, 
	neil.armstrong@linaro.org, mailingradian@gmail.com, quic_jesszhan@quicinc.com, 
	andersson@kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_kalyant@quicinc.com, quic_jmadiset@quicinc.com, quic_vpolimer@quicinc.com
Subject: Re: [PATCH v2 1/5] dt-bindings: display/msm: Document MDSS on SA8775P
Message-ID: <2vspsymfbsavcpnx3kuoqnhczuhvhqtdzdzp7qedbjl2ozvnz2@sf65rybvixps>
References: <20240926110137.2200158-1-quic_mahap@quicinc.com>
 <20240926110137.2200158-2-quic_mahap@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926110137.2200158-2-quic_mahap@quicinc.com>

On Thu, Sep 26, 2024 at 04:31:33PM GMT, Mahadevan wrote:
> Document the MDSS hardware found on the Qualcomm SA8775P platform.
> 
> Signed-off-by: Mahadevan <quic_mahap@quicinc.com>
> ---
> 
> [v2]
> - Use fake DISPCC nodes to avoid clock dependencies in dt-bindings. [Dmitry]
> - Update bindings by fixing dt_binding_check tool errors (update includes in example),
>   adding proper spacing and indentation in binding example, dropping unused labels,
>   dropping status disable, adding reset node. [Dmitry, Rob, Krzysztof]
> 
> ---
>  .../display/msm/qcom,sa8775p-mdss.yaml        | 239 ++++++++++++++++++
>  1 file changed, 239 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
> new file mode 100644
> index 000000000000..e610b66ffa9f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/msm/qcom,sa8775p-mdss.yaml
> @@ -0,0 +1,239 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/msm/qcom,sa8775p-mdss.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. SA87755P Display MDSS
> +
> +maintainers:
> +  - Mahadevan <quic_mahap@quicinc.com>
> +
> +description:
> +  SA8775P MSM Mobile Display Subsystem(MDSS), which encapsulates sub-blocks like
> +  DPU display controller, DP interfaces and EDP etc.
> +
> +$ref: /schemas/display/msm/mdss-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,sa8775p-mdss
> +
> +  clocks:
> +    items:
> +      - description: Display AHB
> +      - description: Display hf AXI
> +      - description: Display core
> +
> +  iommus:
> +    maxItems: 1
> +
> +  interconnects:
> +    maxItems: 3
> +
> +  interconnect-names:
> +    maxItems: 3
> +
> +patternProperties:
> +  "^display-controller@[0-9a-f]+$":
> +    type: object
> +    properties:
> +      compatible:
> +        const: qcom,sa8775p-dpu
> +
> +  "^displayport-controller@[0-9a-f]+$":
> +    type: object
> +    properties:
> +      compatible:
> +        items:
> +          - const: qcom,sa8775p-dp
> +
> +required:
> +  - compatible
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interconnect/qcom,icc.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,sa8775p-gcc.h>
> +    #include <dt-bindings/interconnect/qcom,sa8775p-rpmh.h>
> +    #include <dt-bindings/power/qcom,rpmhpd.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +    display-subsystem@ae00000 {
> +        compatible = "qcom,sa8775p-mdss";
> +        reg = <0 0x0ae00000 0 0x1000>;

0x0, not just 0, please. Here and alsmost everywhere else.

> +        reg-names = "mdss";

-- 
With best wishes
Dmitry

