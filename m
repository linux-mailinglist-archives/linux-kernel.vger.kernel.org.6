Return-Path: <linux-kernel+bounces-217766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB16A90B3F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794D328CD36
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B3E15ECFB;
	Mon, 17 Jun 2024 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGM9+vyw"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800315ECE0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718635312; cv=none; b=SMcYqABKwANXWNFTsjPMSC3nhBAAGzXmBakkBDKUnWLY4EWn/R8lVGxQSfNX/iB4sOhdj1k14dVolVlnmdkR2ZwMK+eJu+RaC8ZF/kCKUC/BR2gBxSgAqfau0WI8nQKq5lQ7jkAwiN/F44PeYQhjhZ/2gekU+qhyuVwjagaDQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718635312; c=relaxed/simple;
	bh=D0uG/F1rquD9j/tgu8XpSkKW0CgsYMnGbyRirrsrnsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bP4MoOvi4pm4fxA+RVzf7ZL3YWPBHZ/inIhKNpLmKYsnQ5MD7mUNWyQhxCnnETcrGEB4M7hMqXNbTCOKSMr09QsgfMdER37nQ84zp6oCg41fo0XCRlvN/ssUINVzlyS9mR/HL7ErYWlNRCDOeUa8CxHjnKEyrRc+Q+uHU/LkugE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WGM9+vyw; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1f44b594deeso41312075ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718635309; x=1719240109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Tb9ql9Key2zaR+IQJeo7On9ydITOd8hoL6sLepVlgY=;
        b=WGM9+vyw64nQDRnlmT83X3BavWWacvljrJ9GhgZ1y3ZRVqeQgMFMsILMoVEuQLseg8
         +RUs/WeaY7/IS3JSqTKIUkIzMxyA9XWYZfpL6UiGxGFIQ7npX/cX3gySnsZsfbQO7VPp
         yeefQLhyuGArvfInDIynw8wACAnH+wzKGsBfqS7M1Ozmu3w085FnuL18CgF28CJ2P3Jn
         7mzOzehLSkMXpoNrolrpCyp7xHbLcMuQsmlZMCMvUiFaOlTjL5Lvi9K7htjPd1Ka3YKO
         kmNtfNO3QYmljkwfLZRdgR+wY+GdZzN4UKLGK55fD4HYcQ78CjkcSYbb54Sz3joyoYNO
         EjCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718635309; x=1719240109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Tb9ql9Key2zaR+IQJeo7On9ydITOd8hoL6sLepVlgY=;
        b=d0or+W95+6F8OTwguF4/q1U2puONSI0XqSQ9PaeO7cNKUUfgUOcYNc0ZaSLUM1lVm2
         NePHg+FsZpGiGY88Ax3ktHrGPa9h0UdD2Av+aOaat8Ch3P1QkPonSpqinRWWGSDpQwBD
         4nk6FHSaNfsLC5k8I3lk5rnUz5oAJO61eEelxjF9uRjMUtYhAF0h3TjrSk9vFcJ45Jfx
         bEkIXY/Tang0DjGuXi1EHRwpS8CKtgEu0YqUKH/Xcb76L24qypM7PnvunnpUB+74u44/
         P1PGl4ce4/WlDs9b8yk4Mp2zmvNEDP6M2cGOUXv9bKQOag+CuMkYuVMW/kqT6iOVie6L
         XAkw==
X-Forwarded-Encrypted: i=1; AJvYcCVioFV8UkZzjMuRsh4r1/hD7OG/Vm4JI5HL1dneMl1jktSB/jYTBJuuomiEc3GFI0y3b2I6fwjavc01Sw9W9LchDbJg2KTawITrDVNr
X-Gm-Message-State: AOJu0Yyl+Sou8Fwk0QhP7TuBwdLSUVmrcioKpaCznk7DsarMncXIemRD
	i6Plxv54qaNT6UgM15Rnvo3vCaaRuq9DHas0K2jv+q+XOHcNMl86cthvKnl92Is=
X-Google-Smtp-Source: AGHT+IEmf39oVNc/A1nD73Ny6p2Cl2YYugmm0/bVmzsrkdWLmqjObFWN5+zXKksSeTd5xGX4xozfzg==
X-Received: by 2002:a17:902:6508:b0:1f7:21e2:6d9b with SMTP id d9443c01a7336-1f8625d4880mr92934795ad.24.1718635309309;
        Mon, 17 Jun 2024 07:41:49 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:e681:7328:24ae:62a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f53e80sm79448555ad.297.2024.06.17.07.41.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 07:41:48 -0700 (PDT)
Date: Mon, 17 Jun 2024 08:41:45 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: krzk@kernel.org, andersson@kernel.org, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com, imx@lists.linux.dev,
	kernel@pengutronix.de, krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, peng.fan@nxp.com, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org
Subject: Re: [PATCH v3 1/1] dt-bindings: remoteproc: imx_rproc: add minItems
 for power-domain
Message-ID: <ZnBLKV+RxX+CclRA@p14s>
References: <20240610151721.274424-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610151721.274424-1-Frank.Li@nxp.com>

On Mon, Jun 10, 2024 at 11:17:21AM -0400, Frank Li wrote:
> "fsl,imx8qxp-cm4" and "fsl,imx8qm-cm4" need minimum 2 power domains. Other
> platform doesn't require 'power-domain'.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v2 to v3
>     - only imx8qxp and imx8qm need power-domain, other platform don't need it.
>     - update commit message.
>     
>     Change from v1 to v2
>     - set minitem to 2 at top
>     - Add imx8qm compatible string also
>     - use not logic to handle difference compatible string restriction
>     - update commit message.
>     
>     pass dt_binding_check.
>     
>     make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j8  dt_binding_check DT_SCHEMA_FILES=fsl,imx-rproc.yaml
>       SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>       CHKDT   Documentation/devicetree/bindings
>       LINT    Documentation/devicetree/bindings
>       DTEX    Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.example.dts
>       DTC_CHK Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.example.dtb
> 
>  .../bindings/remoteproc/fsl,imx-rproc.yaml        | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>

Applied.

Thanks,
Mathieu

> diff --git a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> index df36e29d974ca..57d75acb0b5e5 100644
> --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> @@ -59,6 +59,7 @@ properties:
>      maxItems: 32
>  
>    power-domains:
> +    minItems: 2
>      maxItems: 8
>  
>    fsl,auto-boot:
> @@ -99,6 +100,20 @@ allOf:
>        properties:
>          fsl,iomuxc-gpr: false
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - fsl,imx8qxp-cm4
> +              - fsl,imx8qm-cm4
> +    then:
> +      required:
> +        - power-domains
> +    else:
> +      properties:
> +        power-domains: false
> +
>  additionalProperties: false
>  
>  examples:
> -- 
> 2.34.1
> 

