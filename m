Return-Path: <linux-kernel+bounces-371259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B219A38B7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 10:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A34D91C21E81
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 08:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA6618E742;
	Fri, 18 Oct 2024 08:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VS6B8UE2"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148EC18EFD6
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 08:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729240721; cv=none; b=smloaIe7MDHAw8yzypdLsEobnrgitqJ2SqPmzXaKYgO8TxFfC6+NlhKpBFBTYvwGy7Ke+8muC2oLHSOWHgGj36ad2RbjS8GF624IcK7Lmv6U1eUPyAdxHBAt7HTNN2nJvhRQHV7CG7/HakB4WQN6J++Hj/eskAz3RxKtWNXKX2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729240721; c=relaxed/simple;
	bh=wB6rJgDXWyQmAI2cPIO2Bs8AyLymaUBqEb0titk5ToI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6fQqFw43avuiKbqofQrIM5qZHePSzJ2w76clSLun2mczgqwTtkzVO2nTnjXN1f1peKgmMLNEgY7L8PzVD4NreCbMkovxMSmn5kALIRsjCoGohQZCZJl1WtXQc7g/5ryKiAr+8UOV+JImP3S5RxzS3XuejE4uRpAk2QwS/F5Ncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VS6B8UE2; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f8490856so2207284e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 01:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729240717; x=1729845517; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UrD9uUISUicyV77FCZtIHadfgQC6lKYurkwJjq1HNE=;
        b=VS6B8UE2yJQB/j770cxZNF3J9A0Rijdbo55TMaEzF9kjxOzRL2fJB5dkyjv41n63v8
         yehFP+wA3UWXqKbqQBeg2n5i2HN9fOPSNmF5qia3CH7EOdotkgs92v15zctn9vV1RicM
         dDK/H5V3ZQk1bWeTLZnw9ji6FFaGglcx1kzF+pEinf/HDeItXGmZeiMQUEsAE2EzCjpA
         gUOp6+09GrkAUUaWr9P7w68WYWz0fVvXfSunMTDQJXquI4juCpWZTN8uZo5kblSd5pli
         Q7swVZpItnfTv+uJiKBGyIUDSrtwpRZKJcG1VYsIAzEp/yI42KJFCu9/EogprbTfbhC5
         usLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729240717; x=1729845517;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9UrD9uUISUicyV77FCZtIHadfgQC6lKYurkwJjq1HNE=;
        b=IfvCpBCUZA/VAfOBhIPm71TVB6cg82uHSQnmeK1yQAnsWcEa+1qG04/e9HcUHO6UJ8
         61VUrBPpChpfYwGjSwToRiOF3umJHKS8hhPDINJLT9B99i/t8wqMF5DZWOA/aXvqob3T
         sdI28EMRKvM46HIwUx8/M++nf7rQx1YsnMjV3tIRK1oD1cVHQNMTdoBMROj9ixRsoaUt
         ZlryPYXpFwE1Gl7PdBQPFyEaR4sBLVYZ1+42S/Un+v/fi+/V31PtRHc9HVJi9v+0hnXG
         vIYaoj6Y3f/SMMsTPXfg/vbMwT+94CMgwl2a2zIJ6srINPInBwzMyLxL6syg2b8VGtXm
         6K4g==
X-Forwarded-Encrypted: i=1; AJvYcCUKof/sLliyKJBIbIsQxu64QXUnLHjp6qQlNXX5r7gPQsSyALCPWFqJu51fxudt66CI7a5p9zGXlLIavVc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0E4T2soAsIgRenfvWreXGw6q7TybIpSyveDU3pnZJiyW5WaHy
	/1YbgDK5eZ5U5cZXV/14ZKdpht9yNUvSiLoPH3AQBtwzOG8j0I3LImDWtym1NMo=
X-Google-Smtp-Source: AGHT+IGmgQ9MMDeNrBBU/z3b8S19gtWOFXt5jhyrSbyAR1fhQxWW9GPqe1/RawVBBM8MqhrGoQEi4A==
X-Received: by 2002:a05:6512:12d6:b0:53a:aea:a9e1 with SMTP id 2adb3069b0e04-53a154f9c46mr819940e87.54.1729240717149;
        Fri, 18 Oct 2024 01:38:37 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a151f0c7csm158587e87.173.2024.10.18.01.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 01:38:36 -0700 (PDT)
Date: Fri, 18 Oct 2024 11:38:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl : qcom: document SAR2130P TLMM
Message-ID: <ecdp4bkbpkdprzfvrve4jlpirc63ruejr5cfm5tkqkq736p7wh@ibqjbq22nvve>
References: <20241017-sar2130p-tlmm-v1-0-8d8f0bd6f19a@linaro.org>
 <20241017-sar2130p-tlmm-v1-1-8d8f0bd6f19a@linaro.org>
 <u2yel7ych7esqlr732x6x424rxcolb22k6fgw5t6yyuurgneyf@5hnqyc3iqdvv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u2yel7ych7esqlr732x6x424rxcolb22k6fgw5t6yyuurgneyf@5hnqyc3iqdvv>

On Fri, Oct 18, 2024 at 08:49:09AM +0200, Krzysztof Kozlowski wrote:
> On Thu, Oct 17, 2024 at 07:15:45PM +0300, Dmitry Baryshkov wrote:
> > Add bindings for the pin controller (TLMM) present on the
> > Qualcomm SAR2130P platform.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  .../bindings/pinctrl/qcom,sar2130p-tlmm.yaml       | 138 +++++++++++++++++++++
> >  1 file changed, 138 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sar2130p-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sar2130p-tlmm.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..a8daa96936599e459c801b6685a42659271604ee
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sar2130p-tlmm.yaml
> > @@ -0,0 +1,138 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/pinctrl/qcom,sar2130p-tlmm.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Technologies, Inc. SAR2130P TLMM block
> > +
> > +maintainers:
> > +  - Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > +
> > +description:
> > +  Top Level Mode Multiplexer pin controller in Qualcomm SAR2130P SoC.
> > +
> > +allOf:
> > +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,sar2130p-tlmm
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  gpio-reserved-ranges:
> > +    minItems: 1
> > +    maxItems: 105
> > +
> > +  gpio-line-names:
> > +    maxItems: 156
> 
> Don't you have 210 GPIOs? At least reserved-ranges and pins pattern
> suggest it.

No. I will fix the pins pattern.

> 
> Best regards,
> Krzysztof
> 

-- 
With best wishes
Dmitry

