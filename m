Return-Path: <linux-kernel+bounces-201782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B678FC31B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 07:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE8C1F24267
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 05:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCEA21C183;
	Wed,  5 Jun 2024 05:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7BXUwSV"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974A621C164
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 05:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717566584; cv=none; b=K+//QhnZNr7bBMbbuhVNnBVJsPExKp10AIStyF0NreteQA0wJk8FL4KyoeZ6yMDVAZq6U8Jwo8ye5qYeVYRlwn65YAEcrvwt8ruYjzprFLSflxDTDMm6tE6TLYIA9zGzgcCMo8ON5WFG8x+yApdOY7FszfJwB6tqgDfHgXnCBeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717566584; c=relaxed/simple;
	bh=Beh2wlkRe7Eug/7DYljw55OLT0VJDjN+N9ltnUnhZMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TwvJGFZ5mqaMevfCHdaUPGQ9SIDHvarM+Toy2PKJcQQPXV2Ro5ZaJBM3HtiL1qBjV/D2Yi+qI6IhN3CUYKyB8cEh4wmL0HPsoHeR+npOJesyDWljPwQrMUW6DxU16REMWkyqL9EPs3542jUuNQpFPz6Uuw63lp7zygnP+ne1bTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=F7BXUwSV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1f47f07acd3so16264525ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 22:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717566581; x=1718171381; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+dM5+k2xQ90bwK2u/6F8dSzOK+d/yGXOElnGPg/eOmg=;
        b=F7BXUwSVaWxsDPfg/N4kEFbQep/g/8n3NSjTTNKnhqQDepcUgdFONF7bAA98X465ve
         DuIwZsmpm9/aneSxDATZxIy3dlkZ0lS6xJQtWVCcADBEHfg4JfCusyYq1Yx6aYaHSb/J
         g1EohOWBBGqlRJgmqUpn2yfqaQtllX49SO2yMzN1sofMHpcvDOw/+0E+ZAA18zIpSy2x
         BZZj0dDqNs+efBeBbOno+6yMJxKYc1seXwqZLMSMhFb7mm/Sg8C7JPiam/q5mfrO8rqC
         QLZt0oAh8DpUmnxUuiLJN7sD6WKZIplTIqklnOlo94Rt2RBEHVuM/5ruogYdo3uqLLMz
         GOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717566581; x=1718171381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+dM5+k2xQ90bwK2u/6F8dSzOK+d/yGXOElnGPg/eOmg=;
        b=m9ehsKkBB2xJrMtgcvsMrmJ/oRe3fWYETKpKu4Y2qObqESdyian7FNSMRUa5fjALAW
         r75lckfN9Drq18JArDeaZe8clyWRaRUo+qA667PeHEo6r92VMBAZvK8WyLVn2+NBDgor
         KZX6SfPjJFN1eR0fjWyQvQzawJsQi8lA/EJk3qrpos6bxi5EEfOhusQrGFYR/LsJWWeZ
         oNuxnXvs9r1miMRU5ovOb4NUdxLmhCkKAP6qRaKfhSRrv1TkS30YaoOGznPKAIjQqBxP
         auG7T11KbF9TJsgeJWT6bAqThIUSN4S2E3oA7OyPSWst9/9pbA/4buO7g5TtlpQtj3/L
         21qA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ1YF7Q44bsFuqvLeuzc0KlP3l12YIrwKuFZEbtsFBlUn/eV19F5O1FFHbuitdDZdEvZ0a5n6bTaBFxtMFojU7CXDSO+bc1BGHHeC9
X-Gm-Message-State: AOJu0YwFhQ9S4zl+9Jz4bqgiAZCDIm9ocrTidFW269u+qizzQwHaQY+0
	MZPmBvP8+WkHDgLYQiR4EE3hK2jTC5aVcTdoS2hc2aYy+hOSA62JksX/Nc5rFQ==
X-Google-Smtp-Source: AGHT+IEZszKMxzYyviv9Fxic6NPR/A6OoNXaAaG1oAK0KQm8hWctUvTFoKzkoioIm4/mshFm531FvQ==
X-Received: by 2002:a17:902:db0a:b0:1f6:7ee8:8942 with SMTP id d9443c01a7336-1f6a5a290ffmr21801795ad.40.1717566580772;
        Tue, 04 Jun 2024 22:49:40 -0700 (PDT)
Received: from thinkpad ([120.60.137.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323ddac9sm95544525ad.173.2024.06.04.22.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 22:49:40 -0700 (PDT)
Date: Wed, 5 Jun 2024 11:19:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Rob Herring <robh@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Fix register maps items and add
 3.3V supply
Message-ID: <20240605054928.GB2417@thinkpad>
References: <20240604-x1e80100-pci-bindings-fix-v1-1-f4e20251b3d0@linaro.org>
 <20240604235806.GA1903493-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240604235806.GA1903493-robh@kernel.org>

On Tue, Jun 04, 2024 at 05:58:06PM -0600, Rob Herring wrote:
> On Tue, Jun 04, 2024 at 07:05:12PM +0300, Abel Vesa wrote:
> > All PCIe controllers found on X1E80100 have MHI register region and
> > VDDPE supplies. Add them to the schema as well.
> > 
> > Fixes: 692eadd51698 ("dt-bindings: PCI: qcom: Document the X1E80100 PCIe Controller")
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > This patchset fixes the following warning:
> > https://lore.kernel.org/all/171751454535.785265.18156799252281879515.robh@kernel.org/
> > 
> > Also fixes a MHI reg region warning that will be triggered by the following patch:
> > https://lore.kernel.org/all/20240604-x1e80100-dts-fixes-pcie6a-v2-1-0b4d8c6256e5@linaro.org/
> > ---
> >  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> > index 1074310a8e7a..7ceba32c4cf9 100644
> > --- a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> > +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
> > @@ -19,11 +19,10 @@ properties:
> >      const: qcom,pcie-x1e80100
> >  
> >    reg:
> > -    minItems: 5
> > +    minItems: 6
> >      maxItems: 6
> >  
> >    reg-names:
> > -    minItems: 5
> >      items:
> >        - const: parf # Qualcomm specific registers
> >        - const: dbi # DesignWare PCIe registers
> > @@ -71,6 +70,9 @@ properties:
> >        - const: pci # PCIe core reset
> >        - const: link_down # PCIe link down reset
> >  
> > +  vddpe-3v3-supply:
> > +    description: A phandle to the PCIe endpoint power supply
> 
> TBC, this is a rail on the host side provided to a card? If so, we have 
> standard properties for standard PCI voltage rails.

There is a 'vpcie3v3-supply' property and it should satisfy the requirement. But
'vddpe-3v3-supply' is already used on multiple Qcom SoCs. So changing the name
in dts warrants the driver to support both supplies for backwards compatibility,
but that should be fine.

> It is also preferred that you put them in a root port node rather than the
> host bridge.

Even though the resource split between root port and host bridge is not clear in
Qcom SoCs, I think from logical stand point it makes sense.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

