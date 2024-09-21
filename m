Return-Path: <linux-kernel+bounces-334926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9EF97DE67
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 20:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D48E1C20C4A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 18:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B95884D02;
	Sat, 21 Sep 2024 18:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yeoYbb2S"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B3E1F957
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726944756; cv=none; b=jjsjwQ3L5MErYVKshX0XYKf19+d6BsgqqG3aW+MwpQgFT4DrBLi6K/vR1JINocQZpPaPSB2xai9fsl5jrVKe5some6w968wBG30WtuG1ijsIDuVwmvRnnl7TZz0cwoHezEPLpaDtYdgEYEnF44nqpf6VaevXQZtEyiK+3g3QI+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726944756; c=relaxed/simple;
	bh=bS8qi5sb9l6qZWoXE7ybyqltpxGbc0CNIgBhoQKKvII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cApKf9ZDRJouYT5BuyGVk2duneRE8ML2KBjConnWCQfVwOovOEuNm66MVI01MJx2U9u1qYiTJMI6MnchoM7XrBshcCM2fkvqaIMPR4nRdJF2OP4TfDRXRrJD5XCo5jUSrW6T2jEDQXnRwnC+BjGQm3AWTQqsI4B3J5qSXut7dds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yeoYbb2S; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6d3f017f80eso23166117b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 11:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726944753; x=1727549553; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9YOWHzzVwKmpVXuH6tT4H74KWT1SKFzuJzeXObWQIF0=;
        b=yeoYbb2SxEMIkQaVolqPtiElSAVP/KEuGK9DusQtHrhMF41IK1mOa/JEj+lCZN4fxI
         6ThKBtLeT/Ur+NLXvsoIVH/Jh45qTGy27bXJxJt2Z3dEm8phUz474LQOGqpYG+/Q2Vn2
         Pb/edwpa/PxHiJm7y+haitROLsXYR8gWHt0DxURI6v7CfMKfOH9/89I7XZoZq+4WBKr3
         iHW0OY/yw9qrJXqAbz/k94k7utkGhq40YPuLa/W/orenjVAf1LvRhQy7/z7i//eiq2Vq
         m8vG3wkTedShrcyt0msHBe/gGZXsT1zM+jrDPfBjtdgMjLkOsSfhu5cHUmjohA7OOg7F
         HGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726944753; x=1727549553;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9YOWHzzVwKmpVXuH6tT4H74KWT1SKFzuJzeXObWQIF0=;
        b=ovuM4spHGrWr/V3IeDozbbSUCiPmLs01b/lrMD3wziMFaY7HbHcNKEDYBLqX+Udkfs
         C5NtUD5l21y1IMYY3t/wi7ox6zIu335z3/Mv5UOZhphSL7rsz9AXZ3KLPt3NFGKE1hYw
         +I5lR+Umd6mVovSEZo1PE48P8Uy8uf7B980I5UhT8eTgHHA+j53t6tpdZrbeJ6qtDVsZ
         JCS2T+h1XWkv2bdkSd3KI4Uz+8vZcDSZPM/o29F781mhKiZRXVGuDepG5TrOZlLwnq/Q
         VAnFvsJYpPNj8dlxxjmkIFhck+ngFNBR4PN7sHN57IhZF9A0rQbOReok2VTfLEsNx1tl
         ojZw==
X-Forwarded-Encrypted: i=1; AJvYcCX5VlK+bc3TxG1qNJEOMoQkttpPdZZf7N8u3jztOvb2JG/cQOvuGFP4717SnABf+onNiHrKem3PaknpB5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YywXJH5vweBOaa+RpgQSh33fXbH2JN6XN133fB2MUoPmYHTtuCD
	NOhmx0awq7IA9/VOVXL4JpMuUMQOjQzLSEb+anjsrrNFM+uB9HeKH6aaHkBQtJ1ckt2oAELDdnp
	OYrPCxQhtDzMNFeUGbJjX5lxuXizFlsIjrznCuA==
X-Google-Smtp-Source: AGHT+IG5tWL7XQk5lTl4IxHn8rt6ybrJDIlTwRt+uw8pRlg2OHh+fLMthOUKic2sFVqZrPqkaKCtAgCb23pQ48rnvJM=
X-Received: by 2002:a05:690c:48c4:b0:6db:a7d3:6410 with SMTP id
 00721157ae682-6dfeefe5f02mr62623227b3.44.1726944753473; Sat, 21 Sep 2024
 11:52:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912071437.1708969-1-quic_mahap@quicinc.com>
 <20240912071437.1708969-2-quic_mahap@quicinc.com> <78d9c6f9-5667-4ecf-92c9-73e9e4b9b424@kernel.org>
In-Reply-To: <78d9c6f9-5667-4ecf-92c9-73e9e4b9b424@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 21 Sep 2024 20:52:22 +0200
Message-ID: <CAA8EJppc7jUfVx7Fw=tBjWGdp7ULb2pbK9x-re+1bNq2kxMR4A@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: display/msm: Document MDSS on SA8775P
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mahadevan <quic_mahap@quicinc.com>, robdclark@gmail.com, quic_abhinavk@quicinc.com, 
	sean@poorly.run, marijn.suijten@somainline.org, airlied@gmail.com, 
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	swboyd@chromium.org, konrad.dybcio@linaro.org, danila@jiaxyga.com, 
	bigfoot@classfun.cn, neil.armstrong@linaro.org, mailingradian@gmail.com, 
	quic_jesszhan@quicinc.com, andersson@kernel.org, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_kalyant@quicinc.com, 
	quic_jmadiset@quicinc.com, quic_vpolimer@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 21 Sept 2024 at 20:23, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 12/09/2024 09:14, Mahadevan wrote:
> >
> > +        clocks = <&dispcc0 MDSS_DISP_CC_MDSS_AHB_CLK>,
> > +                 <&gcc GCC_DISP_HF_AXI_CLK>,
> > +                 <&dispcc0 MDSS_DISP_CC_MDSS_MDP_CLK>;
> > +
> > +        interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> > +        interrupt-controller;
> > +        #interrupt-cells = <1>;
> > +
> > +        iommus = <&apps_smmu 0x1000 0x402>;
> > +
> > +        #address-cells = <2>;
> > +        #size-cells = <2>;
> > +        ranges;
> > +
> > +        status = "disabled";
>
> Uh no, it cannot be disabled. What would be the point of it? Please
> reach to your colleagues for some internal review before posting (see
> also go/upstream in internal systems).

Rob, can we make it part of dt-validate maybe? Error out if schema
_examples_ have disabled nodes.

-- 
With best wishes
Dmitry

