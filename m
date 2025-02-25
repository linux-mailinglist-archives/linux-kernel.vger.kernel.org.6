Return-Path: <linux-kernel+bounces-530443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAF1A43383
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:18:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B193A7B0C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8A7244198;
	Tue, 25 Feb 2025 03:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obRRyPuy"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC4A243951
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740453487; cv=none; b=Gkwhc1uKJIiY7Kg3IZ9BxKce7ZKXvbTNZDiSwLQjOSxIWwOETwmtbiPm2KV0PTW0xoGTJi/gtSTqzD3yxl5T8gp6lMiJA4DtjhCuERTjupQ3uNCZBTcopMsPs2/mkk4NYriWq6ZG5B/4RHu5X2ck9Dr7JxZoq5WusG7hEZKpLDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740453487; c=relaxed/simple;
	bh=Lk2sDUojjLMRgc3OCHI0a2fa7aBit4SzOSXMyEYms3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AiVhkuOOnicJQVGQyhb+hCyWWyt3GhVZ3yR7m+CzSS+SSP41OmTmhUFs6WMO8g7fNbfuWj4EBlqZGapKnNZaenyl+7ll0sSkP0SE4a/V7yNzCg9htZdcOP/SPlxdXFgKka+FvKMVmStfTyZcpVm3kd4brbo9Au0lr5w8AyqShnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=obRRyPuy; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-545284eac3bso5014107e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740453484; x=1741058284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FCZchhqLX8uUjPFWnCBXbymsSao+hh9E/o3hFTKGn1Q=;
        b=obRRyPuyxMzg3R0wMKzDyNeo7zC7PmHRewimtRijcpCGBHb7bwuTrEfjUaBrz+YqIL
         49XoCdWnrmGPCKjouenqJeCLjPERJNnae4B2AcnBQd/tInufoMrhWDujc/paHXlu4WTe
         jBdJavuYdST3R23VXfKNkHpMHlTrhT8KQY307eTBAn2tO7Fufn1M8lwHUxzJrHFuw++l
         694p3i+EJsaBBkeh2QRgYPVem1q0oKyL+RWX+0W1sde//E9ttP2AtfAKhgqe8SwHDkeM
         EiyMzx9tfKDxJ9jtdCeQuOgF+Ua46aswr9houPEggImIQnCKytNZ5kNbDH3RRlQWihVG
         hkMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740453484; x=1741058284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FCZchhqLX8uUjPFWnCBXbymsSao+hh9E/o3hFTKGn1Q=;
        b=lt5GLuQ052y7IzJzSCfv0c9znlJFY8/CmX6EctPGLA8stlZr56USLz8y2bdqopO2SR
         3/F7zPJi43nGdwkM5QfUXekUtDzw7iIs2jVebPuFASvlrIWn6FuttIltbLROycPUzhMn
         9ZO8TUuYALn7/aIRBqZCmGap9nt8kTYcfiq2Ua9Mif6m41SFdGLYa411uWF8Fa8HL5D2
         V27PXKrLOP8iqa1Ez6YKHcFQeFSaudaaQJIpGY7iKzYR+CmHT2FeTxzbV7b3HpjHfckx
         WrIhk4riM4UxKDSgjxpUPaVMPXw65ZTwNpkt3szZLLLODPbCmo6D4vj6foSHdJJWmFGl
         8sXg==
X-Forwarded-Encrypted: i=1; AJvYcCWCuwPZASTvkSdJHqu07lKfOZJJeQW7IvyKuVCEQ+xSwj1ZJv+lS/71gfc1fhkRYbu6Gwp5Y/O5Odv3W70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBqRRmF49wd1EmocaEKZd3wCgTyC6YHe4FvSJ/u9CU6go0ounu
	qSLVtWSbrILp1Fkc5ljygVpoSy78c+zNKDf5fVJIuxQSigmB1JPZAIHKLV1jUYE=
X-Gm-Gg: ASbGncukTvpiWw0FeDdmiRgNvyv9ggMqFnYgA9rHufpIQdTJbhfM/8JiaXYG+bg4Nd/
	205ltq4m449Jt0MOw2BJk2DsdJfsPMNQxJhy9tOmpC6xuSnTUY/YXs08aoUj2T/75NmBwyu9hzt
	kWR23tov0WspYqeGnfCaNgzHlLpcSYB/1zafvdnyBbxQnolIwz5tr980O+6T7q7Tlg8QnXq+r0j
	QsbtM5yiR0YcpjrDaOIpxhr3JGzEKsJaLyekF3KdWusRsNElrbx5P9dkdRLEYmH75BkaI+Vg6u/
	obKcM7cfEvepQWOjMVIIQxb24E+FNyFhhf1XnPIWiqiOx1UQpFtUc7iHk8BuBIEnZNEc3feQuC2
	BXU3ZFg==
X-Google-Smtp-Source: AGHT+IFxB2QxizMw9nvjOf5qWvU6eGEcTycsMPv7lmMYbeJIpZO5aid9mAqXGRvFMkad/0CFLKqMhQ==
X-Received: by 2002:a05:6512:e97:b0:545:c1e:6603 with SMTP id 2adb3069b0e04-54838f7ad45mr5175824e87.50.1740453483664;
        Mon, 24 Feb 2025 19:18:03 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-548514fa0c4sm60528e87.225.2025.02.24.19.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:18:02 -0800 (PST)
Date: Tue, 25 Feb 2025 05:17:59 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Luca Weiss <luca@lucaweiss.eu>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/4] dt-bindings: display: panel: Add Himax HX83112B
Message-ID: <wo7ws3nfpniavprg55e3qchgxj4v7shra526ag7nuab57s2lxz@n6jef2ljd46t>
References: <20250222-fp3-display-v1-0-ccd812e16952@lucaweiss.eu>
 <20250222-fp3-display-v1-2-ccd812e16952@lucaweiss.eu>
 <77wat26ggsfqwssgt5wfq6yz6w3ccqz3pmn727a4aphqv4ljhx@vrzneg2rvzfj>
 <8b67cea3-82f7-47f8-b026-fd26cfbf94b4@lucaweiss.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b67cea3-82f7-47f8-b026-fd26cfbf94b4@lucaweiss.eu>

On Mon, Feb 24, 2025 at 09:40:23PM +0100, Luca Weiss wrote:
> On 23-02-2025 7:25 p.m., Dmitry Baryshkov wrote:
> > On Sat, Feb 22, 2025 at 06:58:05PM +0100, Luca Weiss wrote:
> > > Himax HX83112B is a display driver IC used to drive LCD DSI panels.
> > > Describe it and the Fairphone 3 panel from DJN using it.
> > > 
> > > Signed-off-by: Luca Weiss <luca@lucaweiss.eu>
> > > ---
> > >   .../bindings/display/panel/himax,hx83112b.yaml     | 75 ++++++++++++++++++++++
> > >   1 file changed, 75 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml
> > > new file mode 100644
> > > index 0000000000000000000000000000000000000000..e6bd4b33d40be98e479d84617aea6d2af0df70e4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/panel/himax,hx83112b.yaml
> > > @@ -0,0 +1,75 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/panel/himax,hx83112b.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Himax HX83112B-based DSI display panels
> > > +
> > > +maintainers:
> > > +  - Luca Weiss <luca@lucaweiss.eu>
> > > +
> > > +description:
> > > +  The Himax HX83112B is a generic DSI Panel IC used to control
> > > +  LCD panels.
> > > +
> > > +allOf:
> > > +  - $ref: panel-common.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    contains:
> > > +      const: djn,fairphone-fp3-panel
> > 
> > Would you know a better name or ID for a panel?
> 
> Initially no, as mentioned on the cover letter.
> 
> But I dug a bit more in some other documents and found this number now:
> "98-03057-6598B-I"
> 
> This also somewhat matches the format of the Fairphone 4 panel from DJN:
> ("djn,9a-3r063-1102b").
> 
> So I'll change the compatible to "djn,98-03057-6598b-i" in the next
> revision.

Thanks!

> 
> Regards
> Luca
> 
> > 
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  iovcc-supply:
> > > +    description: I/O voltage rail
> > > +
> > > +  vsn-supply:
> > > +    description: Positive source voltage rail
> > > +
> > > +  vsp-supply:
> > > +    description: Negative source voltage rail
> > > +
> > > +  port: true
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - reset-gpios
> > > +  - iovcc-supply
> > > +  - vsn-supply
> > > +  - vsp-supply
> > > +  - port
> > > +
> > > +unevaluatedProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/gpio/gpio.h>
> > > +
> > > +    dsi {
> > > +        #address-cells = <1>;
> > > +        #size-cells = <0>;
> > > +
> > > +        panel@0 {
> > > +            compatible = "djn,fairphone-fp3-panel";
> > > +            reg = <0>;
> > > +
> > > +            reset-gpios = <&tlmm 61 GPIO_ACTIVE_LOW>;
> > > +
> > > +            iovcc-supply = <&pm8953_l6>;
> > > +            vsn-supply = <&pmi632_lcdb_ncp>;
> > > +            vsp-supply = <&pmi632_lcdb_ldo>;
> > > +
> > > +            port {
> > > +                panel_in_0: endpoint {
> > > +                    remote-endpoint = <&dsi0_out>;
> > > +                };
> > > +            };
> > > +        };
> > > +    };
> > > +
> > > +...
> > > 
> > > -- 
> > > 2.48.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry

