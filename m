Return-Path: <linux-kernel+bounces-306633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CE296418C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34211F21084
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69612191F89;
	Thu, 29 Aug 2024 10:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uk+IUGBj"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6031ABECB
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 10:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724926770; cv=none; b=dzG+mmu4U9qvDE5Y6go/LlyPaznpA9Yj06YTu7ZQS0MLvLUtDZgOjPmVLYpW87cMpGSgReFBP6/0onFPWHlg9/ncFntJEhW1N6iiWaQ67oIr+dBGU2bAw5jNMzV+Adh3f1IOyKWt5zUqHp0nxej+Okx6VWKnLhbWjc9KRPlGKaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724926770; c=relaxed/simple;
	bh=JiZQWXIRJ3HjYCLl7hFrsgGpcmSL/PwTn6gBZKW5NnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4GA/YYNvPbOYrI4pRBsQW4In6GnWPoGxsCsnyq+7mEAJrN33pbrwDmgRnU0WR1oC1xFrRboV3fR5p5TqmQD/IeF0SySyreUsY+aZslKAYqjEQgrWhmA6AU1zLWm7h/JMAxJAsx9Eo+Q1lHHDJ44lmlKj5DyusMVb6keNPMlj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uk+IUGBj; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-533521cd1c3so561161e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 03:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724926767; x=1725531567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dsgEl12pS5/oK+D6m4jiXUFGwYqDk87JRvruFRHJCvw=;
        b=uk+IUGBj5vZH3cUlq2z+8waWEcJdBbudsV6P5FOXvr7So1vE7L2e7qHSw1N5JsuKCQ
         QlW0/hRw8G4d/Sa3gISoaOm5JS9YG5HQInI8cnMdPtR1GEPrn7g4ial+4H9w6Wx3KtVD
         433zVeHCx6YnUt9yCdFwxG7RvrxCsC0tm1JQoFLC5lSMpF04b17ngzA+T8tKoUH42SEE
         IuaBWpMZFwbDgUoAqhfXCniT/ZIRZWcaVPKLPRUoY3TAsc75Q4VvNvxCZoU5rEYPhXx9
         rprx8+ECE+/26gBj0bkBrX8diJyx57P0yEOaWTC88DssIYeTx81ErBOqc6DzTfwL9pkd
         jd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724926767; x=1725531567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dsgEl12pS5/oK+D6m4jiXUFGwYqDk87JRvruFRHJCvw=;
        b=GCE857SuL/wAtE5FYSsDcdI7AAgI+aF+QfSXtlaCE8AOlfxWiDrJDnZVkdL7BfjbKf
         /ki/o0Ns/BehGPAFeGiI6keK17HfvbRBh/Rc991HaFx087CTTzCtd5nof7kuAGKma6PV
         3eDMoyOZHfhZBB/I9qce3K6+g8cA8TWprOMcruiB9Xbv9eHJ3ngbB39ZZ2I4TR94tL6y
         ybxSaRA2s5mvkrY+0EDWrJnj129FSgUH1aTg32tS6zoxJp1gR33YLFpxEL1Kcw/A7oaG
         c098uOb0Z5gG+YqiGWN31R9DsYNPqw18v9XawZsgdoyjtsYvsAbvqYSWlm12g0ZZJjMb
         K6Zw==
X-Forwarded-Encrypted: i=1; AJvYcCW5QXH7LEzlrw5r+zKTt7e8DPLDPPNcCTukEYQ3oVw0J6d1qL4aZcGYpUqxnKhkQRAP7XqEaNxZaeKT1Bw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybzg3Oobn0gvGpLClyq0wySla7ofUV6wGr39oLM7RJ9/Lp2/GJ
	t8/oLBB56SIQW8iIRjCiPsD3a8N6HmkYNsFX0NOIQX1cY+ov3fcakYcaUvOxL4U=
X-Google-Smtp-Source: AGHT+IFI/J4pmYQEU4+SHn18VCyisudN4k2godV3tyoAlPi2LbLETrSD6LA/Lou8PXucHxARCjq3Jg==
X-Received: by 2002:a05:6512:234b:b0:530:b773:b4ce with SMTP id 2adb3069b0e04-5353e575f40mr2138577e87.33.1724926766646;
        Thu, 29 Aug 2024 03:19:26 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53540827af9sm116406e87.170.2024.08.29.03.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 03:19:26 -0700 (PDT)
Date: Thu, 29 Aug 2024 13:19:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: neil.armstrong@linaro.org
Cc: Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] phy: add NXP PTN3222 eUSB2 to USB2 redriver
Message-ID: <izr7linltwo4kbpp4dtls7bahvk4a2hwtqaz3fyuktjuiudqly@ivulir54ktxk>
References: <20240829-nxp-ptn3222-v1-0-46906bc4747a@linaro.org>
 <20240829-nxp-ptn3222-v1-2-46906bc4747a@linaro.org>
 <79a643de-9808-4866-9e41-8bd5ab55ffed@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79a643de-9808-4866-9e41-8bd5ab55ffed@linaro.org>

On Thu, Aug 29, 2024 at 10:30:49AM GMT, neil.armstrong@linaro.org wrote:
> On 29/08/2024 10:21, Dmitry Baryshkov wrote:
> > The NXP PTN3222 is the single-port eUSB2 to USB2 redriver that performs
> > translation between eUSB2 and USB2 signalling schemes. It supports all
> > three data rates: Low Speed, Full Speed and High Speed.
> > 
> > The reset state enables autonegotiation of the PHY role and of the data
> > rate, so no additional programming is required.
> > 
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/phy/Kconfig           |  11 ++++
> >   drivers/phy/Makefile          |   1 +
> >   drivers/phy/phy-nxp-ptn3222.c | 119 ++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 131 insertions(+)

> > +
> > +	ptn3222->supplies[0].supply = "vdd3v3";
> > +	ptn3222->supplies[0].init_load_uA = 11000;
> > +	ptn3222->supplies[1].supply = "vdd1v8";
> > +	ptn3222->supplies[1].init_load_uA = 55000;
> > +
> > +	ret = devm_regulator_bulk_get(dev,
> > +				      NUM_SUPPLIES,
> > +				      ptn3222->supplies);
> 
> Suggestion only, you could switch to devm_regulator_bulk_get_const()

Good idea, I'll take a look.

> 
> > +	if (ret)
> > +		return ret;
> > +

-- 
With best wishes
Dmitry

