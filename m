Return-Path: <linux-kernel+bounces-253328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711E1931F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 06:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24961C20B74
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 04:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDF017C91;
	Tue, 16 Jul 2024 04:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E3hPXilY"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E2812E6D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 04:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721102750; cv=none; b=tQhEUhinIYID1C7zCooPw5BmSkNuFcewlMc5d0xLF55UIXE2RuXQL0o6gn1JuHTVuGoP1P9ikZ15u9+MAJaFKdHAoBHBdLwVq/75BvuIAsHz+WKGMeWJRG7HiRFUnihgg5ffnGHh/z/827fTJLnrkhNO6pI8MfGqwlVjaJGNOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721102750; c=relaxed/simple;
	bh=VS6EfNK47CI9CCIESYrotd9kMA1ov2RmVpon6OM+jKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HT8auX9B6ECtsJfmRpALLEKt9jYftl860OhztSRfaLPLEDrdWQkRe2gGU6CV+Yb0UhFCXH/5CaCW9NCRLez02XwCVbTswq/Zhzz3czWAP8ULVWwogkTrIcAHCM+JzZY6FYJ8bXEC5uO8YR0DvSJ6uWgx4grI5LsTxFlxA4819KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E3hPXilY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fb3cf78fa6so30887165ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 21:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721102746; x=1721707546; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rA6xNk3KrlizNp5+s2A1cTpaTQXoSxtZU7FnGPFRjJg=;
        b=E3hPXilYXZrfCIqkDBNR94Z5WxTCIItYno6cCzFzpsfoA/hGN8U/05eZenZlSmv1ci
         m6RHhlrNV9c1awnxOFAnDqpJagNnIRH4dKjOv6QTS9h8d36oSM0LH385iZrE8vws2kIR
         7dNKlml5eX3YZgjo3cbNYNqSW/IOxqCWrn+0QCd6PmylTQY3zF1bby+DbgYXhomU1Uct
         nH1JV6hq/4Rki2N3U1KclW3gVgLVdM8rf6wSK/jU4DoUb6a7FmvrdWxCwKw3IacfPd8E
         RTe+jxDiSU06+8sLpOIxEmwNI3zfPILYGqPO0gGgqokgjpPiGXIQ75BFF2nIDueDaAnq
         QMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721102746; x=1721707546;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rA6xNk3KrlizNp5+s2A1cTpaTQXoSxtZU7FnGPFRjJg=;
        b=AunZMyIzwurG8mswHhp7n/dYIh8R/NvMu44xKgj33JgatqSc3l1pcH8u0GyrJbFrlg
         83mzkQphyJ9k6yqLWh9f5ToZ3qg5tA49q6MrlR5sEXeCWx8yjN7V42MMXz5pGQ8TFVQM
         ft/YiLLfcvtyXnyWKyQFir7SU/KRUu5gk1Ne+A3Na42IwjWxzUz5ubMSF289rdyzTEVq
         Axk73z+TozaE3KofnS6SE/sB0WFArgf3EPA7gPx31MqkM8w/1gAD0IV5esJeEgc0uCfF
         O/rUkKYzYnITMcx3RPjXt0ewFQ8Gs7BXNJAyByCk2YNBdYpAAJehGUgMju4tF98aAeQe
         lPXw==
X-Forwarded-Encrypted: i=1; AJvYcCUAWP53NrJh9ro2UYMXUMb3oQl99apy7xP9to7BxDzkg0qgz2BTg9iOCZaJNsufZ0T3/rqTWOxefxLtUGIRreS/EMOqkEV8gMyfxTyS
X-Gm-Message-State: AOJu0YzBUMEKJnxjRfhDBpwZwdXMORAYa+9UhzfIfl3t9zQMW8Pfd4LJ
	9WJ6J6o31TH4AGclu1722dyuxfqm0kR7f5JjzgNDvATIqZSo3ApPgrqeY9IFhA==
X-Google-Smtp-Source: AGHT+IEEp12N7H9rdwF7a6ALoUF5nLk0VlGH0DjnjAF23n1gqZqPTmDQQlr65ikW50Oczrb310hp7A==
X-Received: by 2002:a17:902:f54f:b0:1fb:29e1:7635 with SMTP id d9443c01a7336-1fc3d9144cdmr7484105ad.13.1721102746522;
        Mon, 15 Jul 2024 21:05:46 -0700 (PDT)
Received: from thinkpad ([220.158.156.207])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc38a81sm48592855ad.220.2024.07.15.21.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 21:05:46 -0700 (PDT)
Date: Tue, 16 Jul 2024 09:35:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 04/14] dt-bindings: PCI: pci-ep: Document
 'linux,pci-domain' property
Message-ID: <20240716040540.GB3446@thinkpad>
References: <20240715-pci-qcom-hotplug-v1-0-5f3765cc873a@linaro.org>
 <20240715-pci-qcom-hotplug-v1-4-5f3765cc873a@linaro.org>
 <0690964e-fe50-428b-aa84-be298cd6dfa0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0690964e-fe50-428b-aa84-be298cd6dfa0@linaro.org>

On Mon, Jul 15, 2024 at 09:59:12PM +0200, Konrad Dybcio wrote:
> On 15.07.2024 7:33 PM, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > 'linux,pci-domain' property provides the PCI domain number for the PCI
> > endpoint controllers in a SoC. If this property is not present, then an
> > unstable (across boots) unique number will be assigned.
> > 
> > Devicetrees can specify the domain number based on the actual hardware
> > instance of the PCI endpoint controllers in the SoC.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> 
> Hm, perhaps pci-controller-common.yaml could make sense here?
> 

For RC, this property is defined in 'pci-host-bridge.yaml' which is hosted in
dtschema repo. And the description of this property varies between host and
endpoint, so we cannot use a common one. TBH, endpoint doesn't really need
_this_ property as there is no PCIe domain here. But I used this one since it
already exist and does the job pretty well.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

