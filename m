Return-Path: <linux-kernel+bounces-391026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A869B815E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70D451F25EEA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C381C1AC9;
	Thu, 31 Oct 2024 17:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WT74AqwS"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26B13A868
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396271; cv=none; b=ZBnBW9aR99u33wde3jJVLML+rVt4Ae3ALnUrFu7GglEvPW4fWPGSdfJaQzIO4f9TPRpEWMM9gsfQIITynyglmp1CCf5lT2Ow3fXXIzDokGFfMa3r7wEZzpnqcgFoW9OHxLObZjSmMnIXh7WbrEXzuN0TKBBM19HbWJpmabQiNbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396271; c=relaxed/simple;
	bh=4sXu8HvrmNTEWnjIBowrah7u8asTbv+L1Lm8apIdGq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fyQEKC0gqM/yR8sKn3coC34sU/ltssTIC7sfsA8lndGubCwtpCcubTEOwztRVZOCx14803huIhC43MnON1y/2yc+8fHm9utoQ7peZSdeDbumcpUEBcIdtF5Rni6rH0JB2/1xX0Qfzn5HXaQMjXpX+pCntnFNiyeQ4eI+eZ3+ito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WT74AqwS; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-539f6e1f756so1319041e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730396267; x=1731001067; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wvGN26v9h9TbcjLka9mTWi25+1w0LLwGx8pUqzN3ads=;
        b=WT74AqwSUi9S+t5vgUKUlJDFnhCGqst4KW+esiduxiYDGL+kiKF8fiIVRlP9NR9eSo
         d8tm8LPAevHLM/2W50W9cRiwEyi/6pV4ofYF3QnoUedsQQgTCaqHMpyXr8ljNfMLSs2h
         u/oaEv0rxACtSst3M6lyizvsf3TuykwywhrWdcVKGhkrgvqlAckDpklkm4duaPsZykpx
         sLKA78EcMKQ5tfUhBl59Myunl6Sm6FhiGPdM9K0pNx29oIooX0zhkpzL2dT7IoNcGpIU
         OZ/O2SKRhR6UZYaWLlZ3UeieUq+v415QhLlsLXm30K9E0xnv/JCO8cnY64RVGiZpgeh3
         9K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396267; x=1731001067;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wvGN26v9h9TbcjLka9mTWi25+1w0LLwGx8pUqzN3ads=;
        b=BA6hhLWeDoCclfVduN6qiswgEnXMVdY74EoN1OB+h5TzzkBOp0ISpimKnWC5GNYElt
         xMpwxL9lkw+7CC1ctxbrJsLp3OTCBTpr0agBKibSz1Zg3tsZ6V23qngdsSUI0J6YyhLB
         /a29x8vAxPPICCeVekdPD+p0bb2ZRf46sH5XqWpEz1Tl0Eloc0Q1hMlZz+ks1RAF9+l/
         I/YkLwkHY/HonITVHljGvkbzHhBMOdfxPCTpngA0dAc3GkzAzqH2XSYubo4TteCtVj0D
         xL6iqJTIhC8Ro3LhwNrM63FJh1Pu/C0phGT9o+d0w6/RhFW0O/BH6x6elQqBM74SdBjh
         Kqeg==
X-Forwarded-Encrypted: i=1; AJvYcCWhP+oY7Havgh5MY7W9Pavp+TEedfn5s9yh16mqDTUv03W3Q99kDxKz9Ua0ySH897ib2K8iyWFWCUCIpT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYrRKfuuI/vGv14Fcl8b50ds02/WezwRbwHo0kuC+RIFbAkfPs
	B+GBz7xiD1m4ZWMOnRlZW/EQfla5kl8TqOashm4gPbCS/Jkz/r8REJ8BCVzdtW0=
X-Google-Smtp-Source: AGHT+IFE9Tc/KwIa08fOm+rRk9qcX0N0CjkqJe28X/XFmYGijFLr3vURwiH/MupERjY9bYlHsddgIA==
X-Received: by 2002:a05:6512:3d94:b0:539:f754:ae15 with SMTP id 2adb3069b0e04-53b34a1908emr11541751e87.41.1730396267059;
        Thu, 31 Oct 2024 10:37:47 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bdcc3b9sm273696e87.223.2024.10.31.10.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:37:45 -0700 (PDT)
Date: Thu, 31 Oct 2024 19:37:43 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Wesley Cheng <quic_wcheng@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: qcom,dwc3: Add SAR2130P compatible
Message-ID: <gohuncowxxud4rilmr23q3zc6rnkoqpbkl6v4puiexegvzr3fm@2zt4olzo64bu>
References: <20241017-sar2130p-usb-v1-1-21e01264b70e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017-sar2130p-usb-v1-1-21e01264b70e@linaro.org>

On Thu, Oct 17, 2024 at 09:16:38PM +0300, Dmitry Baryshkov wrote:
> Document compatible for the Synopsys DWC3 USB Controller on SAR2130P
> platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Gracious ping, the patch has been acked by DT maintainers, but is still
not present in linux-next and got no other reviews.

> diff --git a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> index f7be056419307069c67b8f2d53bc88417a19b9ce..935e204b607bbd3bc9bfbdcd03519202197c9eb4 100644
> --- a/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/qcom,dwc3.yaml
> @@ -29,6 +29,7 @@ properties:
>            - qcom,qcs8300-dwc3
>            - qcom,qdu1000-dwc3
>            - qcom,sa8775p-dwc3
> +          - qcom,sar2130p-dwc3
>            - qcom,sc7180-dwc3
>            - qcom,sc7280-dwc3
>            - qcom,sc8180x-dwc3
> @@ -340,6 +341,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,qcm2290-dwc3
> +              - qcom,sar2130p-dwc3
>                - qcom,sc8180x-dwc3
>                - qcom,sc8180x-dwc3-mp
>                - qcom,sm6115-dwc3
> 
> ---
> base-commit: 7df1e7189cecb6965ce672e820a5ec6cf499b65b
> change-id: 20241017-sar2130p-usb-0e9ccdef61d6
> 
> Best regards,
> -- 
> Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 

-- 
With best wishes
Dmitry

