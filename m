Return-Path: <linux-kernel+bounces-261956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDAF93BE44
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 10:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0DA2B2226F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 08:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9630196D8F;
	Thu, 25 Jul 2024 08:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fp9uUVNr"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830C9196D80
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721897865; cv=none; b=bis5gp06LpV4TszUPwQmwh6hpjZ1yAuGG07IXfogZ8TGvYPpRp64Y/O3klcBP8ZviLcvS6O82tVUwgWhhp4XELDfAuDLJxU80V2xZOE9kwLAwYPGHl2wkFfpvBB1HGXBEflaUVDyLEtZhmrWmJRpYj9/9v21RXNlu6BP6I1TxYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721897865; c=relaxed/simple;
	bh=E2N4yFbp+8KZPhXKJxPvSIIpVuXW1rJ4/UrT861ZObA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xh2x1aaKDZ7wXmWOoPWD2tzQRrE91i/7JU0K/hxxP7PenUXWr8+RbXfRl9i2Cx0grEZ1Kkwzc+OAAbyKMWSVnPQJZ920A8sA0MIBIxRM/IdqsFzMotWKsPdDZTLCOWACCpmpfG1oJcBFxSNexZVMuPAsM1ygyMO/mzji4pbnkXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fp9uUVNr; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2fccca2cso8359591fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 01:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721897862; x=1722502662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I8NxyUuzsjejruT7irITjyyuzjJo/q4Q+2rql62w/gw=;
        b=fp9uUVNrHZJS76YjNUBQRpVdMxX50c1G4/vneqc7GXqg+2+kVodrH0EoVERXq6sXYq
         6LZFBn1V+n6oc+oHGPvr7i+iBRAxJphTz6Pu+P9dQ9t+xmKZxSbvXa0CYBybcqWtBc60
         T3gfCcy/sM/vOb7PZeZAQgAClw920t9c3avrBPozscaJZupfUejlihqOgVT1+CFTU5Cy
         3DLwQiHZQsYqCnBSQJPOUpb1WnMPrqHETd4I8Ja5r1Ltup/N8CfkmH+CCJDhvCxutMT0
         tuA2EXOl3JmmQSOr8y3ByDEEBHzv7HFACuemlW7UwxSU4wGcXf4gOjpdSH7Ax5FfFqp+
         /IBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721897862; x=1722502662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8NxyUuzsjejruT7irITjyyuzjJo/q4Q+2rql62w/gw=;
        b=ARDYk7hfYF/GDpwddIWLd9ty37sMbeBXnODAfFNy+ue3GMCXQEgFYBKOq3IvjKEqIz
         Nf9izM9wet740e7jaZ/meX9AGhJaYALnWzszAtNr2MBRSgjUkqbzniGr9FCpWlKjTZnW
         BUbPvg9R2NwJH1Pu809KRJ/kVq6JSjXurFBf6pKFokrYFGkm9xzSZav5LRPifQ1l13WU
         gmXaahUg3qmkYw6Z2OXQZoTaZBDT5TdUPI7D9HRvihMu3NYqVSLmOkmGrIw3+3miJjjF
         /FeKwRKBkcqhNAEREq8vZSxyBa53N0Up3AVKsxnTvEs648jAlaXEntWH885EPgC8kb3b
         z4RA==
X-Forwarded-Encrypted: i=1; AJvYcCVaYKxfsqNY9HpydgQVPye9APpBGCyig378vnlOGwkFlVjgwtIxbpNwmBQhHA977bYXxcdVgolE0L3EziF2LyB/KKxXvhV0G6jPDOrX
X-Gm-Message-State: AOJu0YzK7WhKtzFLWMfhWPO6Ckc5Zxb1zB5U/+1Zfhzja38L8fqddQVQ
	79F9k5AKpounomOwaYwuB8bCbqw8oILr10xJ04lEvail28EotHCPU0qSPzLkYQc=
X-Google-Smtp-Source: AGHT+IGr5oLThTee0qw7lkqmpiDTtsYrdLV73qS+/r23EtxU+L5YZDFR7Olu2ywE54dzOWxHz5kA+Q==
X-Received: by 2002:a2e:9cce:0:b0:2ee:8720:b4c3 with SMTP id 38308e7fff4ca-2f039ddd47dmr14851391fa.43.1721897861566;
        Thu, 25 Jul 2024 01:57:41 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f03d075489sm1351371fa.115.2024.07.25.01.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 01:57:41 -0700 (PDT)
Date: Thu, 25 Jul 2024 11:57:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom: Allow 'vddpe-3v3-supply' again
Message-ID: <y6ctin3zp55gzbvzamj2dxm4rdk2h5odmyprlnt4m4j44pnkvu@bfhmhu6djvz2>
References: <20240723151328.684-1-johan+linaro@kernel.org>
 <nanfhmds3yha3g52kcou2flgn3sltjkzhr4aop75iudhvg2rui@fsp3ecz4vgkb>
 <ZqHuE2MqfGuLDGDr@hovoldconsulting.com>
 <CAA8EJppZ5V8dFC5z1ZG0u0ed9HwGgJRzGTYL-7k2oGO9FB+Weg@mail.gmail.com>
 <ZqIJE5MSFFQ4iv-R@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqIJE5MSFFQ4iv-R@hovoldconsulting.com>

On Thu, Jul 25, 2024 at 10:13:07AM GMT, Johan Hovold wrote:
> On Thu, Jul 25, 2024 at 10:49:41AM +0300, Dmitry Baryshkov wrote:
> > On Thu, 25 Jul 2024 at 09:17, Johan Hovold <johan@kernel.org> wrote:
> > > On Wed, Jul 24, 2024 at 08:22:54PM +0300, Dmitry Baryshkov wrote:
> > > > On Tue, Jul 23, 2024 at 05:13:28PM GMT, Johan Hovold wrote:
> 
> > > > > Note that this property has been part of the Qualcomm PCIe bindings
> > > > > since 2018 and would need to be deprecated rather than simply removed if
> > > > > there is a desire to replace it with 'vpcie3v3' which is used for some
> > > > > non-Qualcomm controllers.
> > > >
> > > > I think Rob Herring suggested [1] adding the property to the root port
> > > > node rather than the host. If that suggestion still applies it might be
> > > > better to enable the deprecated propertly only for the hosts, which
> > > > already used it, and to define a new property at the root port.
> > >
> > > You seem to miss the point that this is just restoring status quo (and
> > > that the property has not yet been deprecated).
> > 
> > You are restoring it for all platforms.
> 
> It is already part of the bindings for all platforms.

It is not, it is enabled only for sc7280 and sc8280xp. It has been,
before the mentioned patch. I propopse to enable the property for the
platforms which are using it now (that is +x1e80100, msm8996 and
sdm845), clearly document it as deprecated and start shifting to the
pwrseq and having the power supplies being a part of the root port or
wcn device, depending on the use case.

-- 
With best wishes
Dmitry

