Return-Path: <linux-kernel+bounces-249502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FEE92EC81
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E75B2846C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 16:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554D16CD12;
	Thu, 11 Jul 2024 16:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mbEW4lbV"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0AC16C87F
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 16:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720714794; cv=none; b=MGKVzvy0tf4da2NTxS+7//zsWEvMWfw00tXXNkRy8FhtrY8iLBrNjdu/5Xo1i3cDRH/75VNu4a1Bk9/X7rzMYv9RvWFx0ElSZ0W3lUAe2ulYLJWsDX8n8F+cXU2oezs56AgJD979iOdzYusKGWNwS4qIa7RyLeCpbxlT7MXfpaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720714794; c=relaxed/simple;
	bh=j572HuMq147T8C8MRpPHgT+aMLgJgejQdQMvLVHwt30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZsZBeSbiniVbPWm3K3R0XBaUVZ9Zx3nbAZ3U+J3I/+MFzgcwCT9FRMD1yXTIzRZPeR8gQ6VCNBAXOpJL+KXmmGY1rpnxyDuANVksYQL37Iy5i9hYdmiRu6M0jae8pBdpGulc2hRng81lithmGZmnuhxIYRWeA2QsboXSYeG8fRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mbEW4lbV; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c8517aab46so922493a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 09:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720714792; x=1721319592; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1AGMClvB41s+iwsgH79Eua1IbGQFm18N5jS+AOAWcdM=;
        b=mbEW4lbVtIkxl5llZ2lOKVpc1mehq1jyr/UyFUp22Q+D/DvXKFDmgwknpZ8KciJRyO
         gc2UnugiaMvPziAE7lHvFKQN/KFcE5XgGEjeFQKN4eQftGnW07NC1FSu8s+RebDD+Jft
         WVFGtAq7ISg8wh5p+MCkAXSoH9SOQJTEbpeFyYha60dW9TIxFR4MLrGhkAIhfqcCuNQl
         GcfxVz5vPd5Tsa99/+iU5yLIsmluQ4Ihz55r6v/Y5mxMBASZwBSsFpm+39yx6F1vR2vP
         c86xPmu6RhjBl+GN0wvrJRq9XLI2f7O2AAR+yVTekeckM17Re9YOpSZGLnwOIMSKD1LB
         LF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720714792; x=1721319592;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1AGMClvB41s+iwsgH79Eua1IbGQFm18N5jS+AOAWcdM=;
        b=RaXnewe+BjkN4DJUM0TkMO6ZxHw52klgGtirIaULvnP1/ZmkcTrF+Mhq4NTbHjtotI
         yidU4i39DKKRjmYr2kPr0sw063lv87y3LnbsHE1aFnFlT/oSVYVc9YytVVw4Jr74FYZ7
         8ZYihGs2iQ3HF5kUXz+gn9Wm6bA+qUn0dE0OQN1EbisxM4w767W9aPAav64q2LhiW9Iy
         IgSfi7pl1lfGF/l7koT6hSRR14CwsMY4povwKuhnZf1Vd1QKWQOHVYjnwbqRhOIGpw3+
         s9E9UfoZ/GA9+gG99496oA/8IOB7cYILV7tIk3/9qz36EMAGCgGbVom+v0+OQzXMg+V2
         UpEg==
X-Forwarded-Encrypted: i=1; AJvYcCUeE0w8PkCbAtfmA7sywdQam6LMrlN0T9Pc3pAsnE4SP+0Ljb2SWvbKt2mWVenK2D7uhL4gGVJJJixrX9w0obpAnZL5K2mm/U1EZK2F
X-Gm-Message-State: AOJu0YzkH6jrf3iDMPQN9xqyEloLrVrYyoJmEalA3Dt+qs3urZZNliWo
	kUoqulIQ0ylaCS5f//4pLZendWygkSY83GXnMtAc7wHQYcsObLExhqneeUd8Lw==
X-Google-Smtp-Source: AGHT+IGahlfHHkRsDhkkhgFzdLCYpTrk09/0DiL56RDxZm+D8+vubukWJs0Zk4n8L1sX5nNqOnWxew==
X-Received: by 2002:a17:90b:612:b0:2c4:af69:5c39 with SMTP id 98e67ed59e1d1-2ca35c2946bmr7256786a91.13.1720714792174;
        Thu, 11 Jul 2024 09:19:52 -0700 (PDT)
Received: from thinkpad ([120.56.197.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ca34e6e9c3sm5914081a91.20.2024.07.11.09.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 09:19:51 -0700 (PDT)
Date: Thu, 11 Jul 2024 21:49:47 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: x1e80100: enable GICv3 ITS for PCIe
Message-ID: <20240711161947.GA4434@thinkpad>
References: <20240711090250.20827-1-johan+linaro@kernel.org>
 <f7e74a6f-0548-4caa-a8fc-8180c619c9aa@linaro.org>
 <Zo-ssBBDbHRLtAwG@hovoldconsulting.com>
 <Zo_zu-RmbZyKijVQ@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zo_zu-RmbZyKijVQ@hovoldconsulting.com>

On Thu, Jul 11, 2024 at 05:01:15PM +0200, Johan Hovold wrote:
> [ +CC: Mani ]
> 
> On Thu, Jul 11, 2024 at 11:58:08AM +0200, Johan Hovold wrote:
> > On Thu, Jul 11, 2024 at 11:54:15AM +0200, Konrad Dybcio wrote:
> > > On 11.07.2024 11:02 AM, Johan Hovold wrote:
> > > > The DWC PCIe controller can be used with its internal MSI controller or
> > > > with an external one such as the GICv3 Interrupt Translation Service
> > > > (ITS).
> > > > 
> > > > Add the msi-map properties needed to use the GIC ITS. This will also
> > > > make Linux switch to the ITS implementation, which allows for assigning
> > > > affinity to individual MSIs.
> 
> > > X1E CRD throws tons of correctable errors with this on PCIe6a:
> 
> > What branch are you using? Abel reported seeing this with his branch
> > which has a few work-in-progress patches that try to enable 4-lane PCIe.
> > 
> > There are no errors with my wip branch based on rc7, and I have the same
> > drive as Abel.
> 
> For some reason I don't get these errors on my machine, but this has now
> been confirmed by two other people running my rc branch (including Abel)
> so something is broken here, for example, with the PHY settings.
> 

I saw AER errors on Abel's machine during probe with 4-lane PHY settings. And
that might be the indication why the link width got downgraded to x2. This is
still not yet resolved.

> I saw five correctable errors once, when running linux-next, but it took
> several minutes and they were still minutes apart.
> 
> > Also note that the errors happen also without this patch applied, they
> > are just being reported now.
> 
> I guess we need to track down what is causing these errors before
> enabling ITS (and thereby the error reporting). 
> 
> At least L0s is not involved here, as it was with sc8280xp, as the
> NVMe controllers in question do not support it.
> 
> Perhaps something is off because we're running the link at half width?
> 

My hunch is the PHY settings. But Abel cross checked the PHY settings with
internal documentation and they seem to match. Also, Qcom submitted a series
that is supposed to fix stability issues with Gen4 [1]. With this series, Gen 4
x4 setup is working on SA8775P-RIDE board as reported by Qcom. But Abel
confirmed that it didn't help him with the link downgrade issue.

Perhaps you can give it a try and see if it makes any difference for this issue?

Meantime, I'm checking with Qcom contacts on this.

- Mani

[1] https://lore.kernel.org/linux-pci/20240320071527.13443-1-quic_schintav@quicinc.com/

-- 
மணிவண்ணன் சதாசிவம்

