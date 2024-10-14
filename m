Return-Path: <linux-kernel+bounces-364643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE03D99D752
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 21:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E54A283F8B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7161CBE8F;
	Mon, 14 Oct 2024 19:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iSUxXAwi"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177B37F7FC
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728933966; cv=none; b=te80+p/qYbDv2lRK5hGJUwitPFsr2RfogpZ49W1ycoVLSHXsYnUTYBzWtSRqYDbRzlww11L6wGnjIwdvzsVLAWC5+wrf28ebHA+LURan500ptXdxR7qDYmLnH0zLOiCMC6Dk3lfhOfsngWYsYvcmBBBf7p/ffbvR3mY6L0BXpYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728933966; c=relaxed/simple;
	bh=wgw2OAlJK7DqhjidmbliVOj9gQrHL8j/AKhNMHV1EAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EkdHYhKWB+dbLIO9tFqUgFCmw4seEk887wVJ4vW8CZW7sgVDwrfh5ULau0FRM81XPS7Ah1ElXt2jU4LxoCXtyXa9Qdbe/a1uv/adnXSmczcUQXWZp0q93oYxoK8rETgChOIyrTDpoLt/4jbpoV1MI4AdSRFezhw02f7v2P0kD4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iSUxXAwi; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4305413aec9so44595645e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728933962; x=1729538762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OQFel9daBpAI8WojLFq466cXumXh/MVmFONQmu9MWy8=;
        b=iSUxXAwijifzwNeyafUVgBPtThlmDQKieX1AIJlUdxCSkN3HCeHOyiA8A8fSlMo0q9
         tbFZCCJMQJwxDRHq9ls3aWbJNIIesjLBycWraOSAlEYvSvpLC6Dg7fXSmtNKcwTSFAGl
         a9Pi1DI1DH84M0Fdws4vpQyg/7ZplvzpaMi+GxecP/jQoYTqFiPLxJUSFxie6LLvX0Db
         37uxuRXKpLrwhlPQ58AE5JgxrQo8wJ4DafT+6URkOEDtXy+tNGCuf/8uQAP/N6Xg8rdv
         d5WG7C/aGc17g0hKBtMLet1VK+Bu+HuByWi69KBLysqn813lYJyzkghURkBHxmB3Tltg
         quIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728933962; x=1729538762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OQFel9daBpAI8WojLFq466cXumXh/MVmFONQmu9MWy8=;
        b=Ut8inOwWUavbNeNyt6IXgftBSjI6YEiKwtQMpdcfLw7dK8NvfSpBkLDd7zRnURJQf8
         zNlsfiqqfH2yuJwTNoklz5k8ALEoT/BxHaP1+uBbuhnGqdcQvXDPBBH1r5JDtVcq+mW4
         qlfluNf9PmoQn4pPhSa6weiDOWtuJnISIao9PvEYOWl2xirecRDJ6+pNA80MWPvdGAjm
         FzTZPZ6M3Cv/M9UlHkjp3k4upWje0i+VgiYl7F3/5lFMpXTNp8CPyobtdsgEBzHP/UWL
         YiTOYWo4GqlAPtPxKdbF90yyPoyoKC+O4DegTD1kiGJ+9cJqEdOEqTo/fSYyrjvW8OZu
         Vl3g==
X-Forwarded-Encrypted: i=1; AJvYcCWVeqpEvPELp1RyWL02SG7QZb67Uh4C3L6uBQTFhhZtnAuthLE2YX5HgubI1yPwCcyvuyMewwJO/HgSY3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQT1PMJDnMJkYCx1rBeZCDN2wnNxdR1GyPXiH/J3BIn4dm+pJw
	WIdYdupyJn0PMRjQcnqY/KXW2HCmTVnyJpr9ju4SfJOEFOUUQqSWBp1Mn6QsOKR4lUq5kQKb+iU
	b
X-Google-Smtp-Source: AGHT+IFtTfS2MqMy7w7oJkFD5tNAiEp1UeXze3wU6Ex0A/U2U9ZMVwxrjNvixtUDNrFKoMP3T/B+Sg==
X-Received: by 2002:a5d:564d:0:b0:37d:5405:817b with SMTP id ffacd0b85a97d-37d5518e69fmr7766570f8f.7.1728933962209;
        Mon, 14 Oct 2024 12:26:02 -0700 (PDT)
Received: from dfj (host-79-45-239-138.retail.telecomitalia.it. [79.45.239.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b9190f7sm12115554f8f.114.2024.10.14.12.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 12:26:01 -0700 (PDT)
Date: Mon, 14 Oct 2024 21:24:34 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Conor Dooley <conor+dt@kernel.org>, 
	Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dlechner@baylibre.com, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH v6 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
Message-ID: <hcf5nrotmvvoknehnf2nvje4stnoodam34wgmhnddbavcyybj6@ogq33ss66pnx>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
 <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-2-eeef0c1e0e56@baylibre.com>
 <172890486251.793259.16216468875581353928.robh@kernel.org>
 <20241014133823.GA1018400-robh@kernel.org>
 <r2gmorclmtcrykws4sd7l3hkjzg6f72vbh7ulh3ml2jsnev35z@on2stvxr36qm>
 <20241014202000.0654a1bd@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014202000.0654a1bd@jic23-huawei>

On 14.10.2024 20:20, Jonathan Cameron wrote:
> On Mon, 14 Oct 2024 16:04:35 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
> > Hi Rob,
> > 
> > On 14.10.2024 08:38, Rob Herring wrote:
> > > On Mon, Oct 14, 2024 at 06:21:02AM -0500, Rob Herring (Arm) wrote:  
> > > > 
> > > > On Mon, 14 Oct 2024 12:08:08 +0200, Angelo Dureghello wrote:  
> > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > 
> > > > > Add a new compatible and related bindigns for the fpga-based
> > > > > "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> > > > > 
> > > > > The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> > > > > generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> > > > > mainly to reach high speed transfer rates using a QSPI DDR
> > > > > (dobule-data-rate) interface.
> > > > > 
> > > > > The ad3552r device is defined as a child of the AXI DAC, that in
> > > > > this case is acting as an SPI controller.
> > > > > 
> > > > > Note, #io-backend is present because it is possible (in theory anyway)
> > > > > to use a separate controller for the control path than that used
> > > > > for the datapath.
> > > > > 
> > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > ---
> > > > >  .../devicetree/bindings/iio/dac/adi,axi-dac.yaml   | 56 ++++++++++++++++++++--
> > > > >  1 file changed, 53 insertions(+), 3 deletions(-)
> > > > >   
> > > > 
> > > > My bot found errors running 'make dt_binding_check' on your patch:
> > > > 
> > > > yamllint warnings/errors:
> > > > 
> > > > dtschema/dtc warnings/errors:
> > > > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.example.dtb: dac@0: spi-max-frequency: 66000000 is greater than the maximum of 30000000
> > > > 	from schema $id: http://devicetree.org/schemas/iio/dac/adi,ad3552r.yaml#  
> > > 
> > > This is at least the third time this issue has been reported. Don't send 
> > > more versions until you fix it.
> > >   
> > 
> > as stated in the patch message, this patch applies to linux-iio testing,
> > where there are no errors, from my tests.
> > 
> > Error is due to the spi-max-frequency fix already applied in iio testing,
> > but still not where your bot is testing, proably in mainline.
> 
> Whilst it's a fix, given the fix broadens the accepted range and doesn't matter
> until this patch (which will behind it) I currently have no intention
> of sending that fix until next merge window.
> 
> Cynic in me says just change the example to a value under the old limit
> and bot will be happy. Example is just that, so doesn't have to reflect
> the maximum possible or even what people commonly run.
> 
> Or include that patch again in this series with a note to say it's
> just here to ensure the base is correct for the bots.
> 
> Jonathan

ack, if a next version is necessry, will do that.

Regards,
angelo

> 
> > 
> > Regards,
> > angelo
> > 
> > > Rob  
> 

