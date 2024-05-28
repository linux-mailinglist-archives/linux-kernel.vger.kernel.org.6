Return-Path: <linux-kernel+bounces-193006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E460C8D257F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B361C22B5A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6FA178CC3;
	Tue, 28 May 2024 20:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CDtU1yqR"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78269178398
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 20:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716926943; cv=none; b=aczshJqRBsudJZ4kZmy1lzNH51z8lhqiJfVfjs96BR5wxlT1MigoqyJqHN2y7QAgfkiRm9oO+lqiIA+9swTNLOxtxqxbAGqpxURb/wjDg4MWQ2SGsNmUj1XztZGYi4UO+jS8kEOsmMVa7r6A1NB7zzID0LCull9OFR7s2g8ZgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716926943; c=relaxed/simple;
	bh=+pgBMzMGOayWWzOwkArXusYvlixDsbV+Ps4Vic3yX6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRsne3pSGGV3IP7W3Pkq3IIjRLGWAxftAODLA4FTojTVYlIvObjlPQQPpyvmXhNrwYmJikd+8n9ardFsXBhn9PFGcGrvmN4QXptlipUwfId5A/w2/u9ngJkeBGblfjCH5RctYPwWqUs24Wvsc6cSPuoDO0m8G8kuvpR7Q9Zow/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CDtU1yqR; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f8eba8f25eso1067096b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 13:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716926942; x=1717531742; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xA96EipLEsw2OGrKZRs6fY4D8prbnQiUmnEE7uuFffo=;
        b=CDtU1yqRKiDbobdGyLNhWc1H1+kTS+c6nmWQdxUdTJ+6fv+zhjA7Ej9M/wNHslOR7R
         ybOZK6NsJx9WjH9v1oDh+K8PcbTSmxst+LMgGc3P1wgdPjXdx7/52xiQQBNVXkO54S6S
         5IpmCGEKA0IDgNQ71JqcBZtPwK6MlCO4+GDIskaud2IYpIBgB7/iCuiT5qNsus+hfw1S
         yf8Nrodz/jV4w9mNC8I1z9rjU6SVRp5+rqY9sr2PWAfODtrT5atPmNt2tnuO5rsNIXu9
         oCFKh0x4YkFl6YNUC/t7G17yPZnqpXZzmyL/3fe9pPPcqDnrbcVS3etQTboE/QpcIYCV
         tNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716926942; x=1717531742;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA96EipLEsw2OGrKZRs6fY4D8prbnQiUmnEE7uuFffo=;
        b=vitfp/0yr78ODxWpN9nNI2Ar6K1O27b22TRqHCvjBtplGMe+hT89f6mGBoVWwYeGoq
         lJDdAVTFJi8HByLcsuJdd0MEo8WWqf9dbhLWHDjK9wsjcjXsXN7aaJvMVQ6JekU1zMdx
         pZEZ2YezZA+KQFR5shBgEI9Vb8XFrG25P+bmkZjemAi7SNCxT4s4IT4agj7fESOmmwbK
         KK8EOaN0PXeFoopyHbORVeopNU/abxWYY+4M3eeF1fiI5PtdzCDpMCavL//rcIqsktsy
         PjZZpYPvSFMbD4mH96K6XrqFJ456pISG+e36RavuPAGoQi++J3VLB2xuNe5tnwKJbfgf
         IqCw==
X-Forwarded-Encrypted: i=1; AJvYcCXfDp/vthJ31Ce4UO8eKXPO2TzNxcQmQLGReCSTkJMPM313WehfmsdO3VR1swUfnFTJ5ycFAv+EqpHIKRn0fdgDHNsLDHp5afIXK6nr
X-Gm-Message-State: AOJu0YyxCuSEmkMDsBpHkU6fh9M6lIIzt0xd1krMo1ohiGmBsMusgjgh
	RmMpX+UOj1NgkmUAwWMLkecIPahiUzJxqQ7h242CGfGh5DedfYUR3QqAO1/ZLh4=
X-Google-Smtp-Source: AGHT+IFPVNyBNZy5PIGcWn6L7NKMnCn3b8L3Z1jh5Va5V2SFfi/lSDvuB1Ekq1vIgeuAW0XCfwjb8A==
X-Received: by 2002:a05:6a21:4987:b0:1a9:c4cc:721d with SMTP id adf61e73a8af0-1b212f64a6fmr13050339637.57.1716926941624;
        Tue, 28 May 2024 13:09:01 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:4c7:2691:aa4a:e6b7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f8fcbeb128sm6786029b3a.135.2024.05.28.13.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:09:01 -0700 (PDT)
Date: Tue, 28 May 2024 14:08:58 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v5 2/7] dt-bindings: remoteproc: Add compatibility for
 TEE support
Message-ID: <ZlY52iq2oVIi9I1k@p14s>
References: <20240521081001.2989417-1-arnaud.pouliquen@foss.st.com>
 <20240521081001.2989417-3-arnaud.pouliquen@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521081001.2989417-3-arnaud.pouliquen@foss.st.com>

On Tue, May 21, 2024 at 10:09:56AM +0200, Arnaud Pouliquen wrote:
> The "st,stm32mp1-m4-tee" compatible is utilized in a system configuration
> where the Cortex-M4 firmware is loaded by the Trusted execution Environment
> (TEE).
> For instance, this compatible is used in both the Linux and OP-TEE
> device-tree:
> - In OP-TEE, a node is defined in the device tree with the
>   st,stm32mp1-m4-tee to support signed remoteproc firmware.
>   Based on DT properties, OP-TEE authenticates, loads, starts, and stops
>   the firmware.

I don't see how firmware can be started and stopped.  Please rework.

> - On Linux, when the compatibility is set, the Cortex-M resets should not
>   be declared in the device tree.

This is a description of "what" is happening and not "why".

More comments to come shortly.

Thanks,
Mathieu

> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/remoteproc/st,stm32-rproc.yaml   | 51 ++++++++++++++++---
>  1 file changed, 43 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> index 370af61d8f28..36ea54016b76 100644
> --- a/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/st,stm32-rproc.yaml
> @@ -16,7 +16,12 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: st,stm32mp1-m4
> +    enum:
> +      - st,stm32mp1-m4
> +      - st,stm32mp1-m4-tee
> +    description:
> +      Use "st,stm32mp1-m4" for the Cortex-M4 coprocessor management by non-secure context
> +      Use "st,stm32mp1-m4-tee" for the Cortex-M4 coprocessor management by secure context
>  
>    reg:
>      description:
> @@ -142,21 +147,41 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - resets
>  
>  allOf:
>    - if:
>        properties:
> -        reset-names:
> -          not:
> -            contains:
> -              const: hold_boot
> +        compatible:
> +          contains:
> +            const: st,stm32mp1-m4
>      then:
> +      if:
> +        properties:
> +          reset-names:
> +            not:
> +              contains:
> +                const: hold_boot
> +      then:
> +        required:
> +          - st,syscfg-holdboot
> +      else:
> +        properties:
> +          st,syscfg-holdboot: false
> +        required:
> +          - reset-names
>        required:
> -        - st,syscfg-holdboot
> -    else:
> +        - resets
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: st,stm32mp1-m4-tee
> +    then:
>        properties:
>          st,syscfg-holdboot: false
> +        reset-names: false
> +        resets: false
>  
>  additionalProperties: false
>  
> @@ -188,5 +213,15 @@ examples:
>        st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
>        st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
>      };
> +  - |
> +    #include <dt-bindings/reset/stm32mp1-resets.h>
> +    m4@10000000 {
> +      compatible = "st,stm32mp1-m4-tee";
> +      reg = <0x10000000 0x40000>,
> +            <0x30000000 0x40000>,
> +            <0x38000000 0x10000>;
> +      st,syscfg-rsc-tbl = <&tamp 0x144 0xFFFFFFFF>;
> +      st,syscfg-m4-state = <&tamp 0x148 0xFFFFFFFF>;
> +    };
>  
>  ...
> -- 
> 2.25.1
> 

