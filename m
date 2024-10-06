Return-Path: <linux-kernel+bounces-352449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 304F9991F64
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 17:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F9C1F21EC0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 15:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED22180A6A;
	Sun,  6 Oct 2024 15:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D9052Klo"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7DA17D345
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 15:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728228663; cv=none; b=Ahk5osgz1/6jXWqIPW684i6FQVd3V4KwAWHsD0qXskgp1WeUuH/1wagAx139F7ye8Sd51icph/Bhr6erQEfeN8DNc7iXmrK7n0foCg2p6sIs0BKmPVvI4y1Qc4akFDe1ab7mv5JOJK863a+rrWLK1cqe2GtswqKpA6MzWs3ApCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728228663; c=relaxed/simple;
	bh=erRy1y6DhhNLxLmbX0MPP5rQSPnOxJr65raopGbn/jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dXNLLCHjUmO4Eb+ZTGw7VXnwAH4IwYG71SAFR5gyBVQChiPGjoS0HXJsxopoHwr7tLHb1yW7TOX5C5gX9dWoaCnetg5MtqsK6Nj8QqF8gKXtTLOEqzIPwaYYn7BuNsMGf0u4oixgW03PKMyix86DC1OpoAT7/GY4IS6gaFBLPgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D9052Klo; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5398e33155fso4519099e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 08:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728228660; x=1728833460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7TMEEqlSgL1dfZyYHelcPxHIJNxM8Us8dWe6PWlibc=;
        b=D9052KloMBUvcX9EsWW7HBCXS8S7lH4VRB/q/rdMqpEsQQrTQhIAmtMQ+K7k7CYouW
         vBAh1sLAQxByCLVUjFvH68dIEv40JlqRhtcatPqaGVP0Otca8YCGP/UwQZFcAxAsofvk
         isxGXIcOnavqJe3A14AXT9HoP2pWkzJPezwJle3u/vjVJI2trk1PSv1hu5wrOylrvfDo
         fLZ64GjETfYqjXSJwYNKKlyFJzMUiLaQRWM4x6UQh6o/aGUmj3Ds7VusTmSI67um28sE
         +0YZUK4uSmeSFL/EBfI5xVF1sJBPTrxRzAf9Neh3+UQli+iMd+aH1SVcgDc0h0FI4FPy
         VlhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728228660; x=1728833460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7TMEEqlSgL1dfZyYHelcPxHIJNxM8Us8dWe6PWlibc=;
        b=or5eBpW0xUbPOaR8N8STlA+GFNOkGwi8bAJR1xdxp/7kiRFLrp6Msxi5HWYbzQvd5x
         uHeuQ9DQqVqhL0H5v3dbhV4JygxdgOYdiDBzfgH9Vy5zW0D+Rs10xLUk/giY3evlc2Zb
         DALMk7HiRjbEFyIfvOzKlC+9mfqLll2oNGPXsGGoEJEJ6YHhYYbl5vzaOLUeqrYBi+um
         cB34dbaOuP0sR1JGZ5IG6VJGdf2yjkGqfTBxIhlL+bzRfPsvPtLF2ZmmBeuU+zJMNdyz
         /FKERi9KFXY4bNJcazkL+C3Vo8U1VQout19L+5Ay6UgKPDWmnSOLCsAUB1n2zE0aPSlj
         UAMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeViXK21y5oPRKsMrETB9PZMp/se5r7U4qY5qBqQywLdMkJQw2iLtcdIf3wK8ToD8i73JEPGMaWiU/v7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTkB5R/EFJmpay0y3zdlR5r6cx0oexcKZLvYQRUDX0fwYRXLM/
	KxhBxHxfbeVw2qfUMB34azj24iXwb5DR+PanHgTnkKiQ5vBJzaN6PVGG6+NmlQg=
X-Google-Smtp-Source: AGHT+IF7ACVC7HZGbcKBxEQyUtp+e5EN1rZXSjWwtyEKwdKBEfuWVUaUzhzkFcYwLgaVR/978B0VAg==
X-Received: by 2002:a05:6512:3c9f:b0:539:8f2d:a3bc with SMTP id 2adb3069b0e04-539ab9ec4c3mr4129183e87.49.1728228660095;
        Sun, 06 Oct 2024 08:31:00 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00-89ea-67f6-92cd-b49.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:89ea:67f6:92cd:b49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539aff1d0d3sm547835e87.135.2024.10.06.08.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 08:30:58 -0700 (PDT)
Date: Sun, 6 Oct 2024 18:30:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rajendra Nayak <quic_rjendra@quicinc.com>, 
	Sibi Sankar <quic_sibis@quicinc.com>, Johan Hovold <johan@kernel.org>, 
	Trilok Soni <quic_tsoni@quicinc.com>, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add Parade PS8830 Type-C
 retimer bindings
Message-ID: <rgmmvai43o3vkag3mtoqrye55vq7j3pbcjuakg7pnwfqgigc2e@uv6ehbht7xmh>
References: <20241004-x1e80100-ps8830-v2-0-5cd8008c8c40@linaro.org>
 <20241004-x1e80100-ps8830-v2-1-5cd8008c8c40@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-x1e80100-ps8830-v2-1-5cd8008c8c40@linaro.org>

On Fri, Oct 04, 2024 at 04:57:37PM GMT, Abel Vesa wrote:
> Document bindings for the Parade PS8830 Type-C retimer. This retimer is
> currently found on all boards featuring Qualcomm Snapdragon X Elite SoCs
> and it is needed to provide altmode muxing between DP and USB, but also
> connector orientation handling between.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  .../devicetree/bindings/usb/parade,ps8830.yaml     | 129 +++++++++++++++++++++
>  1 file changed, 129 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/parade,ps8830.yaml b/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..f6721d6eee26c6d4590a12c19791b3d47a8145f3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/parade,ps8830.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/parade,ps8830.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Parade PS8830 USB and DisplayPort Retimer
> +
> +maintainers:
> +  - Abel Vesa <abel.vesa@linaro.org>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - parade,ps8830
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: XO Clock
> +
> +  clock-names:
> +    items:
> +      - const: xo
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: power supply (1.07V)
> +
> +  vdd33-supply:
> +    description: power supply (3.3V)
> +
> +  vdd33-cap-supply:
> +    description: power supply (3.3V)
> +
> +  vddar-supply:
> +    description: power supply (1.07V)
> +
> +  vddat-supply:
> +    description: power supply (1.07V)
> +
> +  vddio-supply:
> +    description: power supply (1.2V or 1.8V)
> +
> +  orientation-switch: true
> +  retimer-switch: true
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Super Speed (SS) Output endpoint to the Type-C connector
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/$defs/port-base
> +        description: Super Speed (SS) Input endpoint from the Super-Speed PHY
> +        unevaluatedProperties: false

BTW: could you please also use usb/usb-switch.yaml for these ports ?
Maybe we should also add port@2 to that schema.

> +
> +      port@2:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Sideband Use (SBU) AUX lines endpoint to the Type-C connector for the purpose of
> +          handling altmode muxing and orientation switching.

-- 
With best wishes
Dmitry

