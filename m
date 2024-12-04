Return-Path: <linux-kernel+bounces-432228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5F59E47F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 23:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3591C284AA2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 22:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978231F709D;
	Wed,  4 Dec 2024 22:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fB4WuRcM"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70281F03E2
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733351783; cv=none; b=YDcwr/cEZjv9hRK3FiT7bPBndQLoXmIHkPaLu4h2wl+zlSB63YjuhMG84x1JVwqLu83O4XcmhqPa9akXhHC8zz5rd3lo8R1geBNW97hCFqX3HAbmCcnci8QEJYqzKnDzPa9RMCB4Idr76O4M3793D3eAKoz+LH+hAmvS4DPDXaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733351783; c=relaxed/simple;
	bh=8nyNe6nBOf2Dk/jqULA7hpqv08Qyov1aCsfLJP+e0ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBMy9/M6s/vpK7TKA4BgXltW2z18oVPCN/X4qXqXh+4BCkwlHcW1LymXEXsuiYhASqt0BHW5ToES12rvzg0XbiqnCRzOT1ns1TSyR+4bQkGjHDMiFjHXjy4gYLE/oihWQnOwDZDDgQ27PKhZmPzptxmrv0Ixeh2yyqq/9hQ8xYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fB4WuRcM; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53df1e063d8so467147e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 14:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733351778; x=1733956578; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+mmQIbMpMz7O0AOKTkxfl8dFrxJ33xOJobw0OfEwbNw=;
        b=fB4WuRcM3FIp3T0F7f5PzJzFKbU/bMYUYGPDay+g8J48QH0dCklAeeNTvHN3ZmW/Yd
         9C0xzANYRgGvyyjJxKgQzKq1mRnbNWxpkFdrKB/XVHomB0HhOZwlVfQnbgCrkgB3JFEJ
         JFgH0auMNwDgnydg/bUUCSk6vRZk07hwwJuYtnXfwkDqdQFMRB0O+5dfXToOQbH0DKxJ
         9qkDmYVDfxCj7Q0jrdONvImyT3Q6YJ/9Hi8R2DLDDWXhQBjbTkmZOz1S1/k7/gI7P7ek
         O7EkwK42zF/uvdRPRGogcgaflKYKCJ+qv1hj2asg5NwIITHtI2+Va7d6K/APbo0YKG6A
         cEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733351778; x=1733956578;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+mmQIbMpMz7O0AOKTkxfl8dFrxJ33xOJobw0OfEwbNw=;
        b=o51q2RiLyw1RL2CZd3SSlzsVxT7eXpc6WjNcn7H9HFUkCpDnVDp8FeG1NmDzSBKSDF
         DuRcU4y3ILgZifcwPFAKTbmIR4s3pcIdzRTV94Zg3+duNrCpm4exnz0DdJi4lIYJyySa
         mf19yDMpp8UYqZaIUgiwe7Q7BxULRVDGRN1qxTsBScoSkkDBqWh0c+m7pmYlmarwn7GY
         TLJO/t/1hor4Az4ue0uJ0MQKS5xRI9BZFLJlpr0LOwmc4tWU6gSOQNpn3qnTLW6k40HI
         cPEEXYl0lVIUwUUXVd8rQN9/yFBMQCQLwqmVXnDaucOzToroxtjDVZPOgraO2M5M735B
         D5BA==
X-Forwarded-Encrypted: i=1; AJvYcCW5GXryNi/cXaYNuB6OV9mUTKd8jOI3ggWbE8GzlG3Zr59i05uuZDlF0FA+mxq8JwKZWASjkoiuGYojFCI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2glWtU/7T3jRdiuN435LMFipJ9g8sEQmDgm/glFgAA9qGdXyT
	nAMJzac3c7KRD+MwACMOj9Rp0j8Q8mSpmBp5bpo2vZJd0OUsj6P94HGddb9eyec=
X-Gm-Gg: ASbGncvCP/lMU6ugqIS0USJgmRaxpdD5z1yix6aLwx3Z5uyNPB3fY/89o1DmaTTK+lt
	tKgaPhutRaESlFpiM069SWDjPoieeIni8JJoYBS01J9OIwY3MEGYuI+kRjG9msdZlo95Hnz93yo
	j7xnnRLq+sFSoTodxZU/P6otb/wCLsPSCUUiPEXhrJ5n7yoD/bwieYM8rNUaJvs4XTr+ls0ky55
	AgZjzKuDZoE+hXMW1N1+OBEkW0QnTHQibEFeE9l1LvnbcpmCVWhbPO95L0vNPcowmpkif4QjQMo
	/UrcDPBZ9cBi4/AU6JCBULJOc5fv3A==
X-Google-Smtp-Source: AGHT+IGuGoCD3puMElK86ZdB02YG7dUQkM6ohz8Me4tads6hOhrBog3l0JNlc1YxUZmWAvJj211T6g==
X-Received: by 2002:a05:6512:220d:b0:53d:d3c1:9fc4 with SMTP id 2adb3069b0e04-53e12a31944mr5017238e87.41.1733351778075;
        Wed, 04 Dec 2024 14:36:18 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229ca47esm21650e87.264.2024.12.04.14.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 14:36:16 -0800 (PST)
Date: Thu, 5 Dec 2024 00:36:14 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	broonie@kernel.or, andersson@kernel.org, konradybcio@kernel.org, 
	johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-spi@vger.kernel.org, 
	=quic_msavaliy@quicinc.com, quic_anupkulk@quicinc.com, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Subject: Re: [PATCH v1 1/7] dt-bindings: i2c: qcom,i2c-geni: Document DT
 properties for QUP firmware loading
Message-ID: <garuc5au5464xpmj3exlull4o2763xrkqubplde56xmyfhfhmn@cpd4bbt4dfyr>
References: <20241204150326.1470749-1-quic_vdadhani@quicinc.com>
 <20241204150326.1470749-2-quic_vdadhani@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204150326.1470749-2-quic_vdadhani@quicinc.com>

On Wed, Dec 04, 2024 at 08:33:20PM +0530, Viken Dadhaniya wrote:
> Document the 'qcom,load-firmware' and 'qcom,xfer-mode' properties to
> support SE(Serial Engine) firmware loading from the protocol driver and to
> select the data transfer mode, either GPI DMA (Generic Packet Interface)
> or non-GPI mode (PIO/CPU DMA).
> 
> I2C controller can operate in one of two modes based on the
> 'qcom,xfer-mode' property, and the firmware is loaded accordingly.
> 
> Co-developed-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Signed-off-by: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---
>  .../devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml   | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> index 9f66a3bb1f80..a26f34fce1bb 100644
> --- a/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> +++ b/Documentation/devicetree/bindings/i2c/qcom,i2c-geni-qcom.yaml
> @@ -66,6 +66,15 @@ properties:
>    required-opps:
>      maxItems: 1
>  
> +  qcom,load-firmware:
> +    type: boolean
> +    description: Optional property to load SE (serial engine) Firmware from protocol driver.
> +
> +  qcom,xfer-mode:
> +    description: Value 1,2 and 3 represents FIFO, CPU DMA and GSI DMA mode respectively.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [1, 2, 3]
> +
>  required:
>    - compatible
>    - interrupts
> @@ -142,5 +151,7 @@ examples:
>          interconnect-names = "qup-core", "qup-config", "qup-memory";
>          power-domains = <&rpmhpd SC7180_CX>;
>          required-opps = <&rpmhpd_opp_low_svs>;
> +        qcom,load-firmware;

please use instead:
firmware-name = "qcom/sc7180/qupv3.elf"

> +        qcom,xfer-mode = <1>;
>      };
>  ...
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

