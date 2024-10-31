Return-Path: <linux-kernel+bounces-390816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB17F9B7EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8086D2817AB
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF781BAEFC;
	Thu, 31 Oct 2024 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b8tmp2oQ"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6923B1A76B6
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389524; cv=none; b=AHXwuHabwfghdlxHujBR+Ui570cQ7RvfF0/9B17xReyyE8+kgmdD67gv6t5tCTEy6/nJpPOvgyLUjN8dinoBDm5/PKQ9ClkwSs+XNvqvjY+M7Azb0p3BERBo1rTiLfNJgC1nN7iOWV91hofFP4JjaXCGrn9v5nMZIyk6s7CDADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389524; c=relaxed/simple;
	bh=3u75LzPnKrNDl/BVl6NJAXra3N8m+B2RmxpwRW1RerI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsshBgABoCQyIC9eH/TJweAm6rSvYcuLfXvHTiapEmROvdSqE2QnjoxdussM24gHFS0XKZ5L90gHeJI2yS315vk1rs5Ovhf6eg/bUu9VuCfSl2DKb68Zkx2tcFDvps/GzIyPg8VPLL0C6f5C9ojkODVEHWULx9sBqiFlMB6aJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b8tmp2oQ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7ea68af2f62so882677a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 08:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730389521; x=1730994321; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BOoGhttfQtvlMa+UXQPz7SPltB1QLmMF2OeTTxNOI3c=;
        b=b8tmp2oQPiNwUa5iSnDSElm2A/6pKAlhK2P79zHBCVBtWelMLn0WbuzBZ/h4Z+mOHB
         4Ux8xhBpevxvNCe5+cbPCHsN7h3OfYJudeTVKXivt+6EpPcFs4bsJf9q5qRKsob962Kh
         GZDVNCYtKtdy+Z+NC6gjzRW8MQy7pppAcA4sgLUgZykPQzZg3mWk41Hnbf+IhNYFmx7V
         BWDIRKLh4IXvVvcyPoRPBrtPRfHbmhkoYcsSYExqO9oDTXbmE7SSsyi1RObs44BrtS2a
         WUVG2IDrMwb29F2MPoJDIf/08ox30WM3GyaOxcgqcoqy9A0U+gxfB3fU/vTfLk+a2BfL
         /SIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730389521; x=1730994321;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BOoGhttfQtvlMa+UXQPz7SPltB1QLmMF2OeTTxNOI3c=;
        b=G/xbYVvpIwULUOpLaml6/KxQqZpTiMwALLo6bPN0sijWR2kEcPRmy78BCK1eC0mtR5
         VswUN4YAG0pMMaWDf6gynm29LPDkUDSHUtk8vdUR5ZbFLyPhdZNj5b2qbJmQAEGFQAFF
         whfX6eBWgln6bhh+WH9z8D9WHko+S6dbnJxY/MhLXFPB6ylyCqTEr0NV0mOYaV6+FVtY
         6BjaVmT2sHe8BBGw3xJsWRd5R9kHXZXsYm/8xR6mpAzCUXT5izZXVzPKnZ255iiJ6iV5
         L7eQr8fyzVRqR6uyJPGs9+P4JBOtrKxjoNuA3LG98bqr+p/IiK1kkMRlw7cUVuKTEyZv
         6EsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4mXj5d/yu/JQKq03Zo5XBfzyDs0sm4fQl2gDoq9J+YsqgjaZgrX2L2e9EmeJKl22ltSAFaaG4PoJNnrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUZOpbfLHpyMtjpMWrWqS7VrmywNrYHjv9zzqdJLCoNzn+pO4c
	wr1Z5V9xt3wYxHnQ5PAKSuw5S9n1CPZ6QwzKMJziL0TVw+dMmlTor0F1ApASQ3yy94nLtCrdxva
	c6JAQlA1Jspl+oWarH6tmTg3VshFrk8S4pAgN4Q==
X-Google-Smtp-Source: AGHT+IHcxLkEWb9dNYC5CdCqGXRD19Sq4JmNNME9LJH3v4MFnNi0PYHHsu/lQBza6qn3U187V0PAD2C9O32PaH6U3AI=
X-Received: by 2002:a17:90b:1645:b0:2e2:9522:279e with SMTP id
 98e67ed59e1d1-2e94c51b6d1mr485841a91.31.1730389521603; Thu, 31 Oct 2024
 08:45:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-sar2130p-dt-v2-0-027364ca0e86@linaro.org>
 <20241030-sar2130p-dt-v2-1-027364ca0e86@linaro.org> <23i2t2jsnm4mcnaxlzk2x6gyipu3fexw3d452wxrxgyzewkdtg@l5bxqhzcrwsw>
In-Reply-To: <23i2t2jsnm4mcnaxlzk2x6gyipu3fexw3d452wxrxgyzewkdtg@l5bxqhzcrwsw>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 31 Oct 2024 17:45:14 +0200
Message-ID: <CAA8EJprsF7Wgb3zv1r9ZB4ngec0zPNeMjWOGkQDO63G3G9WYWQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: qcom-soc: extend to support
 SAR2130P platform
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krishna Kurapati <quic_kriskura@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 31 Oct 2024 at 10:13, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, Oct 30, 2024 at 01:50:54PM +0200, Dmitry Baryshkov wrote:
> > Extend the patterns in qcom-soc.yaml to support Qualcomm SAR2130P
> > platform.
> >
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/arm/qcom-soc.yaml | 4 ++--
>
> This should be squashed with next patch, adding SAR2130P. It's logically
> one change: you bring bindings for SA2130P.
>
>
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/qcom-soc.yaml b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> > index d0751a572af39eecbbd2f8323a6c3c94b3fdeeac..1add7267f541a24e82e0cec62af6f0c839aca267 100644
> > --- a/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> > +++ b/Documentation/devicetree/bindings/arm/qcom-soc.yaml
> > @@ -23,7 +23,7 @@ description: |
> >  select:
> >    properties:
> >      compatible:
> > -      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1e)[0-9]+.*$"
> > +      pattern: "^qcom,.*(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sar|sc|sd[amx]|sm|x1e)[0-9]+.*$"
>
> Instead:
> s/sa/sar?/

I'd prefer not to do this. I think the patterns are complex enough, so
I've redesigned them a bit.
I'll send a proposed patchset later today.

>
>
> >    required:
> >      - compatible
> >
> > @@ -31,7 +31,7 @@ properties:
> >    compatible:
> >      oneOf:
> >        # Preferred naming style for compatibles of SoC components:
> > -      - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sc|sd[amx]|sm|x1e)[0-9]+(pro)?-.*$"
> > +      - pattern: "^qcom,(apq|ipq|mdm|msm|qcm|qcs|q[dr]u|sa|sar|sc|sd[amx]|sm|x1e)[0-9]+(p|pro)?-.*$"
>
> This breaks patterns. p|pro should stay as before. 8775p is below:
>
> >        - pattern: "^qcom,(sa|sc)8[0-9]+[a-z][a-z]?-.*$"
>
> so this pattern could cover your sar, e.g. split:
> "^qcom,sc8[0-9]+[a-z][a-z]-.*$"
> "^qcom,sar?[0-9]+[a-z]-.*$"
>
> Best regards,
> Krzysztof
>


-- 
With best wishes
Dmitry

