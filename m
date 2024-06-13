Return-Path: <linux-kernel+bounces-213006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CBA9069BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 12:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68381C2136A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A87140381;
	Thu, 13 Jun 2024 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKih+lwo"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1011913D276
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 10:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718273601; cv=none; b=bB2f/DsaOPzRRK5p+A9uf3K3o6Bg9ATY3AGwPstUGR/Cs6cDNTKJq6IXA0b3O3RizyG1fpiORjfZHWEEfjcFCe26pt0g+JfnynzEduRUsOgsVBDJrRFqYF7p0Af9GZD20Blbo2zCe8LjsCf4mX05wkPQH1d3cK1AfP5DNBtMO2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718273601; c=relaxed/simple;
	bh=Jig0VbrF7vcRqgAzrjYh7+MqNViArZUDt8CaUtGL04U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zoly2cOKASeorWha15BPmwKnXap0jniLI1e7IWiLV0azbbLx956w1V6aPaa2JGHjRGC643O3KZYQa9jtvtaAO8wF1hmEh4JFxxZYopHvspal9XIv8BeL6slrHOKlADUWid7kMAEFyadEOCOvH2nJeNMfB7ltRvBSDkwZlfJl6PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gKih+lwo; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so8128641fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 03:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718273598; x=1718878398; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6UhTMrFvQBB8mfMQ4c+fd/Ifc6ucfhQNCFOCAgSgYQ0=;
        b=gKih+lwoYe9CzToEpk6oH9NrrUIyfwappEyPRKqMBA/OKcv9PKzVKTqm1/W0knRbc8
         LXZITLVa+HnJ25bW6hBqculEPpwfSEaF0ig/UDIlwpLqEkrqPJnhlRKwMmbv47dA9JbR
         On/5HFPo5lh+DIFdwmZA+GacbDcpmw4Ldx4AnpZoVeAAt+v3Ty3aMqPHeGkYDoJ/ADqj
         7asCTFBVGLiYQnC+ilLg/qKortdgde3LoyPkM0fKQ+z87wFAAHQuU3sGE+mmCyQTV7YF
         qgrrvnmlWIOvwxFAp/nzUd1OoDKXXUYOB+/XuKnMyvXLZM8YCbTAO4ribRiGH051sUK2
         sjdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718273598; x=1718878398;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6UhTMrFvQBB8mfMQ4c+fd/Ifc6ucfhQNCFOCAgSgYQ0=;
        b=sadSdly/G2SRnb/SVX5Qbvm7Kc4GHqy7i053yL7umUpqLLgXxlhTaVIqkiCVMJFYmA
         09Gnk3hbJRTrEBfiswRarBHQKREp6xdZOVkXLCxjc8PksH0xeU070HryBzin8kKsiMMx
         MTA/szccww8QWqS8dTIdFtqp/klnsrKczNSYdY211PmgoX6hCBA1uQQwDSXCHAMMN46Q
         KPXBpdQuznADS+JriiEWiee5CaoqSxb87CXIu4knYdnBZ0BvYSR9ETNzIeNVYCLrUhXW
         c9YDXwegD00zMBwrgKS1EhJYX/k4xFTWooGN6FeCj/JyQUjlIb+dJOp3a8M6KloHRGNS
         tbJA==
X-Forwarded-Encrypted: i=1; AJvYcCWrcMIwR5+o8cPSGtBNfi2xsunhcdxoIeNleY8lKb5BYXiV+ZSS+eTkS9N7ydbkEPe5O2nXDBvKRZ6LGEcKN9menak7QHEbrzZlQ8R2
X-Gm-Message-State: AOJu0YxruXy/B15ws9baHJSq3JaoR2IWVuZ1mEzKrS2iYhYxq5JOp8c/
	avR680xJTvZRcwb0avF5pyS2GCpXW6dssJ/4C+JYM4hN2TYwvVgqEuCoN/agKow=
X-Google-Smtp-Source: AGHT+IEqZFp6DfPOGQtW9vNfCAckczSMPw7RWxGa/vCjp53axsK6Fln9qoOgp1dvliTR80CJljmHPQ==
X-Received: by 2002:a2e:88d2:0:b0:2e2:2791:9842 with SMTP id 38308e7fff4ca-2ebfc9aa3dbmr23103601fa.44.1718273598106;
        Thu, 13 Jun 2024 03:13:18 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec05c9ac5bsm1561941fa.134.2024.06.13.03.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 03:13:17 -0700 (PDT)
Date: Thu, 13 Jun 2024 13:13:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Danila Tikhonov <danila@jiaxyga.com>, robdclark@gmail.com, 
	quic_abhinavk@quicinc.com, sean@poorly.run, marijn.suijten@somainline.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	quic_rmccann@quicinc.com, konrad.dybcio@linaro.org, neil.armstrong@linaro.org, 
	jonathan@marek.ca, swboyd@chromium.org, quic_khsieh@quicinc.com, 
	quic_jesszhan@quicinc.com, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] dt-bindings: display/msm: Add SM7150 DPU
Message-ID: <4xqa6u3jh6z7zdfaamxl3jpucfymznxmd3ezhihgfky62iifkc@bdslrxujahxc>
References: <20240612184336.11794-1-danila@jiaxyga.com>
 <20240612184336.11794-4-danila@jiaxyga.com>
 <0e7bd7f2-b445-4a59-b456-8d03af121a8e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e7bd7f2-b445-4a59-b456-8d03af121a8e@kernel.org>

On Thu, Jun 13, 2024 at 11:23:50AM +0200, Krzysztof Kozlowski wrote:
> On 12/06/2024 20:43, Danila Tikhonov wrote:
> > Document the DPU hardware found on the Qualcomm SM7150 platform.
> 
> In general, this should be before MDSS, because it defines fully the
> compatibles already used in the MDSS schema. For multi-binding devices
> it always starts with children and ends with parent/top schema.
> 
> > 
> > Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
> > ---
> >  .../bindings/display/msm/qcom,sm7150-dpu.yaml | 143 ++++++++++++++++++
> >  1 file changed, 143 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
> > new file mode 100644
> > index 0000000000000..1a44cad131a72
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/msm/qcom,sm7150-dpu.yaml
> > @@ -0,0 +1,143 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/msm/qcom,sm7150-dpu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm SM7150 Display DPU
> 
> What is DPU? Such acronyms should be explained in description or
> expanded here, if there is space.

Other bindings here use 'DPU', so probably we need to fix all of them at
the same time.

> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> > +
> > +maintainers:
> > +  - Danila Tikhonov <danila@jiaxyga.com>
> > +
> > +$ref: /schemas/display/msm/dpu-common.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,sm7150-dpu
> > +
> 
> 
> 
> Best regards,
> Krzysztof
> 

-- 
With best wishes
Dmitry

