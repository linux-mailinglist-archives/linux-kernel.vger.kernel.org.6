Return-Path: <linux-kernel+bounces-424689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E159DB81B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 13:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 557A3160E45
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 12:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BD01A0BC9;
	Thu, 28 Nov 2024 12:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tZOg6ewZ"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B652619DF99
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732798711; cv=none; b=eCgelORI3Ff86iuGk1C6qpVgpz3fpqih7aniZxYjlh7OAtg7a3b7qqDR70hJizLiNynM5oXl13xYguhsVo01nTCHCGWKlA8v+meVw8zT1bhVJIJOWExCsg042H2+Zm6As7QV7TPvqHR38CyC1wRXI6iIhVzd4/bMtES8EupZmyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732798711; c=relaxed/simple;
	bh=nRPqJYxOCjl7tvhVBCbxH0p8aaX2hLWTIe3ub8XhSEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StE6vUpGEDmFabVlDvrTEmnOrx6uYTObe51uSA/Ok5HOy6x7WvXDG3VcI5Ng3fVyR4qvYdFnHRKNCZhvQsH8cZtoXD3+wQkc3Tnj83M+sH9fmwiqdFd+q2eJqTF23VYWKU1AzATi1v6NxwBZctoWC+nuaJQaJUYOq5k2Wf2s708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tZOg6ewZ; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53df1e0641fso884192e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 04:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732798708; x=1733403508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pL1gpN62/B7uzf1v5jSEYWiebBaoTtCpETANPcVdDOo=;
        b=tZOg6ewZcV6e9ijZS2G1ziy/ZNEXdVMyxhYGCpMYtj4UiYUgi2Hl9KPv5aBslGeoVF
         IOx4B0zmWJUMPbggKSyOl8vM0KNDFGszu5lP1xxtCbZyWIXfu4qXcAyFS9PB9CbIlKHN
         PXwlWAV+oIEGWndfVkZoN9vSnVnJri+9HSd13LfnLCn6evtiwGjiPCMdFbvBE14K9R71
         CSOHQpu8UaPnhY/UpA2wcOxBK5PVypa0K7dpMzQoOmohBGQsrUr1R6H/7kXhxyv4GBSy
         h70vDdttaTa7TbbMa9e1Cv/rnJuZhCfbixwLlqtbI5UnRVTCYRsr6+fxS52C3kmX8sum
         0s2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732798708; x=1733403508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pL1gpN62/B7uzf1v5jSEYWiebBaoTtCpETANPcVdDOo=;
        b=mAcpHfEig8c6WxY85W5SokaxER/VSM32xnPvdMWew9jKlbDVubgssj8aXCVL46WNMj
         5fEoJ49E95h/zsAYnFZ3EdOAEZDMNr6l/bP43akFIvOXLmLWOG7FQCqymniu3TSDB5lT
         PG2UfS+Qmj8MSmtNgagwPopAdiz98Gp75Wt4+2gkFcsW4TWirBsVfINOu5EPCaBFNbk+
         i9KXXKvGOMUvxb8eUTBBhW3ej3yIdjfI50FhZvpaGvD7+h1ev0ak2udJj4HSaclx42ef
         3qMNx+6xEmOyDABkAyKOZECoSHTybXWl5oryyAFlnzMgPeNKKlFLr6z8HOxT8rZXrj2/
         ut7g==
X-Forwarded-Encrypted: i=1; AJvYcCXMagO/wf8tRKL8KqH4RZaNYCDt8j+szWyktqs0zbjcT2BKr2X5EjY6kArPReutfvZs72qguBPBCTB7yS4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx138dH7j9+HcVWrycMqTF1oLx75V4s4g2z3SUelUYB0k4BVqdL
	sj4cqVQTEMmz6FipW25WXGQM/fmE9nYawNRcNQE+8yYXJuRiaeTXwqpV9tZPURw=
X-Gm-Gg: ASbGncsohLlJSOWagZKVJ95e0QT43xOKsVVkHzvuz29ClrJORwANtTlu/+rL/tYYjog
	h2dI8aqZTiLvSsLyo8a+IR5BNAGGyWsLOU2XYiUL2whOTjDJdOq/LUlcFSq9zfeqkdGgC3PgCVH
	83y8JJ6oXfWUgSZCcC8YPPgcu4MxVeKHYqJUOgTEiBJ8j+X0vIB2v+JQzmYXx5LK15sFOFYBaHm
	GsLXOUDRjH3gls+kEEtuzW+l7e3JL0vsRGsXrOi+DMloypBpQw+KE0imLpgiJh+GflbcFjK9lFl
	135JBSCEF41ivZ97BKMKnl+yindXcA==
X-Google-Smtp-Source: AGHT+IECkq4RJ4Kyf5ZH00xXO2lbZry3yS9adckrC/jFJpC6Vz7bBgiKeaJmRerQcaQaVL3xVuFs3g==
X-Received: by 2002:a05:6512:3a8f:b0:53d:d572:98da with SMTP id 2adb3069b0e04-53df00dc973mr4003454e87.26.1732798707907;
        Thu, 28 Nov 2024 04:58:27 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64433f9sm171803e87.102.2024.11.28.04.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 04:58:26 -0800 (PST)
Date: Thu, 28 Nov 2024 14:58:24 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Cheng Jiang <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_bt@quicinc.com
Subject: Re: [PATCH v1 2/3] dt-bindings: net: Add QCA6698 Bluetooth
Message-ID: <jaq7tjdq4srboo7m4byfofdbigy5hyeeqwyrgh72t23xgwb65m@lz5yivskxbwd>
References: <20241128120922.3518582-1-quic_chejiang@quicinc.com>
 <20241128120922.3518582-3-quic_chejiang@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128120922.3518582-3-quic_chejiang@quicinc.com>

On Thu, Nov 28, 2024 at 08:09:21PM +0800, Cheng Jiang wrote:
> Add the compatible for the Bluetooth part of the Qualcomm QCA6698 chipset.

... 
And you have misssed to explain why do you need to add it and how it is
different from WCN6855.

> 
> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> ---
>  .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml   | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> index 7bb68311c..82105382a 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> @@ -18,6 +18,7 @@ properties:
>      enum:
>        - qcom,qca2066-bt
>        - qcom,qca6174-bt
> +      - qcom,qca6698-bt
>        - qcom,qca9377-bt
>        - qcom,wcn3988-bt
>        - qcom,wcn3990-bt
> @@ -170,6 +171,7 @@ allOf:
>            contains:
>              enum:
>                - qcom,wcn6855-bt
> +              - qcom,qca6698-bt
>      then:
>        required:
>          - vddrfacmn-supply
> -- 
> 2.25.1
> 

-- 
With best wishes
Dmitry

