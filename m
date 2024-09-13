Return-Path: <linux-kernel+bounces-328273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E0B97814B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6181C21A90
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 13:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715511DB555;
	Fri, 13 Sep 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l/B65dM4"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CDA1B983E
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 13:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234601; cv=none; b=mqZU8V1aQB+HUhwRIu4VhPa9cyA3LgOQaYCHAoB1VyjCskVeadKkoFPTHMExQijIGgAk0lC8F7kEV6rc7PstWUkgtvFSWQZc3Y3664XEiaE34Mp2LbCC8C7Ynaw9YiDImV+b+2d7UtoM7OaY4yhLzfFPHQILR+xcx+ULcO9p50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234601; c=relaxed/simple;
	bh=gwqedYauqRzar7MyUCIVwmQgQHMRuUMD8QN6HVT/PRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UIsxOobrNRXZbI4HWAkk3NPFhDepEZxj4IUo/q7efaMtB9vs/tFbvZroSCFcNIom58ulVxb5xbTwubWx/l+JQFn9eTWZetFbPCrSGa/rihBA1HXHujwnmUwhcnivzzDwXC7BgVTGEXonBiM9nBjay3CAzIbtPeviCzSWXnKAY/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l/B65dM4; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6c5bcb8e8edso706419a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726234598; x=1726839398; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yV+qXor6MhUiKRp/uAsEkmn8ZDHW0/20wv7wV43QfmY=;
        b=l/B65dM4vZuyC+9GL++JH0LppWBKVS9zNSzpWPAHzpeXsdS4sjndbZzJWqdZYl/nLF
         g2krccT986RqciDROT68bKmNfubBEypjv+LSwZO05PbyJ4eSHg/OacmJ4zwZhZoYqXSL
         TSqwZ7M1w7TXosssXBlKWpKSCZOVPen5rwaeKwLmgVpMoLzKgsc9WflONsAfJQH9af88
         ne/EbhoP7xis2jrQ4VsuInzxkwibaPr2JMyX7vrMVIrh4pPrLDrUp407TvxbyhjcHghV
         pzOSTetUuITP4xQNxmRxefYaPTHHJShEE0C0bQg1oy1JKQl4ZZS5SE4FpfzvNYdu51nM
         0Dqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726234598; x=1726839398;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yV+qXor6MhUiKRp/uAsEkmn8ZDHW0/20wv7wV43QfmY=;
        b=MUDbiFnPM8VT1tLYt5UmkKysZjicx2fH8rPIyYWIZWJz4ygVSnJrxvyWZ8JJ6LkJCV
         XJqFOlUACLFVjr/3TgDVtOXm46BTehdLa1hQTY1svEhprhrPgWEdBuXEXG8BcoylT4hC
         cuwwCADHcEx+71SadtEhVBuc5jzCX4IHZADJSo7b0/xoRW63lG0/haHeYEjIlFiaB3P5
         2VEcDeifNQiIfO+dkuf7O/lApv5yJ8qhIgBKfyXKeq9ioKG2fuWVn/CUWc8OS48IDBU6
         Zn44XE8/BpBnT3HDxCozDOfwHtSPLSr+8NIoQMO+WTicUJ5mSQCPP/bx7YH6patnQcC6
         Vt3w==
X-Forwarded-Encrypted: i=1; AJvYcCVd87Nd7uKj3jgI3enDUyq8IyaAI+ixvd71gjFfaoP89LFDQQS+QZleEeDuaZj4fkqqdcOw1ZsOSFsieQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqXomPTS181s6HtcID2WeBYY3cEqOpbYlA/wEHyi8BAX00TC1G
	k4PobG6tJNwH7K1rJDS9zuPF3c/qyyQLzO9aaiZiHOaf5FLYb9wm1pNdfbWPmw==
X-Google-Smtp-Source: AGHT+IFcp2jTl5mrKJuFCPH6264r7HZB1RvFjZQoHrVr3k/nmvKN3GCesQlgt2QE0HCgz4564DsufA==
X-Received: by 2002:a05:6a21:6481:b0:1cf:539c:56f0 with SMTP id adf61e73a8af0-1d112eaf2eemr4459577637.47.1726234598009;
        Fri, 13 Sep 2024 06:36:38 -0700 (PDT)
Received: from thinkpad ([120.60.66.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7190909226fsm6286989b3a.98.2024.09.13.06.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 06:36:37 -0700 (PDT)
Date: Fri, 13 Sep 2024 19:06:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, kw@linux.com, lpieralisi@kernel.org,
	neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 2/5] dt-bindings: PCI: qcom: Add OPP table for X1E80100
Message-ID: <20240913133619.z7cc4whhpvs2uecb@thinkpad>
References: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
 <20240913083724.1217691-3-quic_qianyu@quicinc.com>
 <tf4z475uqjenohdgqj4ltoty3j3gopxnbdhrrn6zo3ug5yuvyq@us2nysv2ggxh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tf4z475uqjenohdgqj4ltoty3j3gopxnbdhrrn6zo3ug5yuvyq@us2nysv2ggxh>

On Fri, Sep 13, 2024 at 03:30:59PM +0300, Dmitry Baryshkov wrote:
> On Fri, Sep 13, 2024 at 01:37:21AM GMT, Qiang Yu wrote:
> > Add OPP table so that PCIe is able to adjust power domain performance
> > state and ICC peak bw according to PCIe gen speed and link width.
> > 
> > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> > index a9db0a231563..e2d6719ca54d 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> > @@ -70,6 +70,10 @@ properties:
> >        - const: pci # PCIe core reset
> >        - const: link_down # PCIe link down reset
> >  
> > +  operating-points-v2: true
> > +  opp-table:
> > +    type: object
> 
> I think these properties are generic enough and we might want to have
> them for most if not all platforms. Maybe we should move them to
> qcom,pcie-common.yaml?
> 

Agree. It should be moved to qcom,pcie-common.yaml.

- Mani

> Krzysztof, Mani, WDYT?
> 
> > +
> >  allOf:
> >    - $ref: qcom,pcie-common.yaml#
> >  
> > -- 
> > 2.34.1
> > 
> > 
> > -- 
> > linux-phy mailing list
> > linux-phy@lists.infradead.org
> > https://lists.infradead.org/mailman/listinfo/linux-phy
> 
> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்

