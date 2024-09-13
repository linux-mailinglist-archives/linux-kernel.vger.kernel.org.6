Return-Path: <linux-kernel+bounces-328171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A028977FE6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 14:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B36C21F22811
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA6E1DA0EE;
	Fri, 13 Sep 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TfF+Julk"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACE31D932B
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 12:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726230667; cv=none; b=G4M46Z3Je8rvkpgKN+6qnhVup3bm3CPJYerU56C5JevyuLaR1BZh/Cn6Ua9NM6ox+m8lLKKBpDMIuF5G9Ec32Bc/RymwE/EYPWWAJw350ArcTFD5KTkrHcZ92WgP24lJMcvVi2GR0pE1F37QA6MMR1cp+v3iPA1ZmYlM/dOXDog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726230667; c=relaxed/simple;
	bh=UJOwm4FyG3ZNvKxMURItPhiS0ItFx/dXt5nE6xyFh3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ielX8ugUA5SKMfSrQ5CAbiXt/w8y3Cgul7IhHa0aeNQ0BRtw62Xx5Ae5ex2mABZ1ALs9xFLZfdSRLy6eG2tuje1rO0ApiFMyr3SEIP5nPQsjUTi9PSilgfnQ0xFvQ3mNJsXJW5yUbE8YwhrBj/vmCH/sfk+j6VXa8XaJj19VDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TfF+Julk; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f77be8ffecso25731431fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726230663; x=1726835463; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7lfIoqIzq7Oaxzbrg6+hyftX0grPutbfuzbJgM78HVI=;
        b=TfF+Julk6qxsoa3E1wqJPvs36aDWYWXNVf17IapDqDSFBWhq78TMh1mbNr9UEYccP3
         CZfPy31X3ZydlGyQ33madH4KvV8zaZ1+exPpjBHotMEcIdmkOZdmxNLD1l4JN2Mxagv/
         5upIU3OPfZQSMx0kd602s5AGt/G8OSbXrcWSa8JxbxzOGtQ4FpPSIplO095Lk7CAuHnE
         jCj3AIVfQqIeooybTQvKpC4dy+j+cXnnZ0HCz/iaLCcVFn4MN8qltIC48eRnI0VWwCw8
         S4MB4IpGjI3JDBB+V5MuIdwlITPmrdNHiKvtJ63fpUPbCOg0pIXYkcB8PUSnnU/2jr0w
         twCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726230663; x=1726835463;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7lfIoqIzq7Oaxzbrg6+hyftX0grPutbfuzbJgM78HVI=;
        b=Dm3VQ9jkGYoeJ8kxyQCdES2Svt3N2JmSPMuSp7X8QUPiaeC1kMOsy720hX+vMbT04P
         y5IigQQpV+/e5w1Twylv4lIeDO+1OLMXKnaqiIpiAuK5PiblF+zlcPVHfngEcPOsJXp1
         0OJ4cb3Cdt4Al6f3JYzCttOu/NMAuq4UGb0DMJSMn7zjRzw38FxnfyG0WS6cid73yAIP
         UeMK3o00UhdurbJvebL5QLPf/0RS723nMo9rGmSaOzpMaPXBPCdNtk5VeYOvD0kYwo63
         DMYwrMP2q5LEM1v/UsAFXcChRA49bna/OcvWazp2Qz4ezFpirHN2j0nplyx6SETX+4/L
         50jg==
X-Forwarded-Encrypted: i=1; AJvYcCU6GcS7Bf7SOL8OVG7+JaBk1xhWkjJMyCbTZuIQuSjIE3qVz/LMSxO94aMpADQtsKgvFIHiVQdjreZ11ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/vzAcrT0LO4b8ptmbkISh0HvvwMRcCqyp81ls+Gec18mq5vJn
	LgmmXNfFqvr1ijsET2r+9I2ulTvSduI7F3NJnII+b7rgfXEA5q1xw0J7DbbXeIE=
X-Google-Smtp-Source: AGHT+IEiDkYAB870ZBn/zctGJmdUhoUk4th5m2Zqgejglsbq0AUhxf7YU//dFZlelqKAMfIRGO7czQ==
X-Received: by 2002:a2e:619:0:b0:2f6:1da6:1c64 with SMTP id 38308e7fff4ca-2f787f437fdmr24587471fa.45.1726230661896;
        Fri, 13 Sep 2024 05:31:01 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f75c07c83dsm22040201fa.80.2024.09.13.05.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 05:31:01 -0700 (PDT)
Date: Fri, 13 Sep 2024 15:30:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org, 
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org, 
	quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, kw@linux.com, lpieralisi@kernel.org, 
	neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: PCI: qcom: Add OPP table for X1E80100
Message-ID: <tf4z475uqjenohdgqj4ltoty3j3gopxnbdhrrn6zo3ug5yuvyq@us2nysv2ggxh>
References: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
 <20240913083724.1217691-3-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913083724.1217691-3-quic_qianyu@quicinc.com>

On Fri, Sep 13, 2024 at 01:37:21AM GMT, Qiang Yu wrote:
> Add OPP table so that PCIe is able to adjust power domain performance
> state and ICC peak bw according to PCIe gen speed and link width.
> 
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> index a9db0a231563..e2d6719ca54d 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> @@ -70,6 +70,10 @@ properties:
>        - const: pci # PCIe core reset
>        - const: link_down # PCIe link down reset
>  
> +  operating-points-v2: true
> +  opp-table:
> +    type: object

I think these properties are generic enough and we might want to have
them for most if not all platforms. Maybe we should move them to
qcom,pcie-common.yaml?

Krzysztof, Mani, WDYT?

> +
>  allOf:
>    - $ref: qcom,pcie-common.yaml#
>  
> -- 
> 2.34.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

-- 
With best wishes
Dmitry

