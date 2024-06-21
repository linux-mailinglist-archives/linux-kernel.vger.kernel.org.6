Return-Path: <linux-kernel+bounces-224751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E37912679
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:14:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 011982888F4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C0F15444C;
	Fri, 21 Jun 2024 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IBCJA1WN"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E4D155380
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975666; cv=none; b=dEeUHhbAGmHVvU2uyYca1vxcw76/mrYDLRICcffAxNjcbOJcuJGDGnSHrM3y8oFkWrX4wiQFd8n3dbCBarISAdw2rXmjbhK2k1WiQDKi8+UncYes61fqrfpTNlS7ENutesip4iyx6TtxWlrC7u8N+ZVN6HOMTvMduxxffvSEDa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975666; c=relaxed/simple;
	bh=lT3/0UqtMDn26n/9FLC4BSIBh/uUYJWYvZjdb5CfcLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lBkKYQ10rUwx+pWfVxm18lWSmcLm0qOAg60hzNPzcGTXyjuy+NYzSB47tiIcKwlKKfEs7vTI8033X+yP5nU5Div3pahmgxI+NB7BpZdEXBpg3UYto8iukEuQxzjLQe52uD/9Hl6LVEVBAR2UX9WM5y85SUQU3DCkT+/5mCjzFU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IBCJA1WN; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dff06b3f413so1916372276.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718975664; x=1719580464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=St4J3uvn8l8JSYyCUFuUaA3lT6tDkhwwUDqJHgH5Ff8=;
        b=IBCJA1WN+2UAECsHaPoXrMbwYXAh4dh927AK12Ir6t7/AxpjvpP8cxiKigm5UKltf3
         utnrzkdAunvrScCGfbwbX3l8xBxqdU1vVhQvV/9B5MeJ7Rh7sasyyd3bZCkaMZRPZZmq
         vU3zwJCPBb45q2PPFtqWq+IQzQi5DDI7BDdbE0Go4Zi1GBJOioWTYs/cZLvo2DYzbnHI
         1l6+nKj8ILVHkq1sqW8EbUPPqY9Icf6k4fwayB73M/App05ZDO4cSDB34jdwTWijZoNY
         4Oxb1+ULTDtmeasIidy+nFSWgxx5zcTDtT11lULNy6Da4dGzd8lKYtZhrFIBbfBCAh6D
         M0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718975664; x=1719580464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=St4J3uvn8l8JSYyCUFuUaA3lT6tDkhwwUDqJHgH5Ff8=;
        b=UzLS1KLP7Gf+/FkqTqkuDhxNJAWknabrdS9k29UaHAexSMYBtOr2OPJaLGJpJesaTt
         tblwpi2HONp6szk+SDB6h/h/zgH3N1oyc+cv+qdNPaj5X5E2lERIBKs6jFUCS820T++H
         klqOf0SMd+i/mit61GmKp0X0+qPl18Zts8dszcgjHx7+k/O7P4qrWB+EUAQo8AobhsQi
         7rO9HDDJ98gNra6eLcdbYQ5eICIWwCWdEpsX3/oN56qBuzg6pglzUZbCQYPpZKlO0u7n
         QhH3GiptmRcWskEYJkCXtl+1Ad+JI8k+INenCYK1F7JdCF7ozOTgCMRVN0lAIkXi1MuD
         X7pg==
X-Forwarded-Encrypted: i=1; AJvYcCUNjfabZl239lD+XeaHg9ujCrO8WMY4ZetanHrOXz/yxZc8JCUlK17ronqemunB25lOQf0WCkDpiiPPynSEYjlCUjbBIVCdlTrFjP8U
X-Gm-Message-State: AOJu0YzM/oKP3vcvagAsNfwFZMSwZ23zm0F2BUc0VwYfP22Bu2laFG2K
	bgQu0XeketZefufy8RhvHjiYz35uSGePoK7/1UOk3RmtRSKfueoUOQAZT64HXQZWvy9LeFO6sLp
	9vyh3Nlp0+O++xEMB0T9u85WUKDjKTVD1GrfYsA==
X-Google-Smtp-Source: AGHT+IF5Kjmxgdie6GcMoOwWvEJr0hx8dV3HK+rzPmDaF3nNfHrnmvu2DU8t6Caag/RxJgO2Tk62vCZRxGA02P6OtL0=
X-Received: by 2002:a25:820d:0:b0:e02:c4fa:2180 with SMTP id
 3f1490d57ef6-e02c4fa246bmr6862131276.14.1718975664432; Fri, 21 Jun 2024
 06:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240619183255.34107-1-brgl@bgdev.pl> <20240619183255.34107-3-brgl@bgdev.pl>
 <henuash23dwkj5fcmub6sabygwo4kam7fgots2pp2j3eu4asuk@cn3o7a62lo74>
In-Reply-To: <henuash23dwkj5fcmub6sabygwo4kam7fgots2pp2j3eu4asuk@cn3o7a62lo74>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Fri, 21 Jun 2024 15:14:13 +0200
Message-ID: <CACMJSes7XcXPZt8NgZm9mQ7h2B6A=+mL13gpZEHY6UnTFqXdOA@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sa8775p-ride-r3: add new board file
To: Andrew Halaney <ahalaney@redhat.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Jun 2024 at 18:04, Andrew Halaney <ahalaney@redhat.com> wrote:
>
> > +
> > +&mdio {
> > +     compatible = "snps,dwmac-mdio";
> > +     #address-cells = <1>;
> > +     #size-cells = <0>;
> > +
> > +     sgmii_phy0: phy@8 {
> > +             compatible = "ethernet-phy-id31c3.1c33";
> > +             reg = <0x8>;
> > +             device_type = "ethernet-phy";
> > +             interrupts-extended = <&tlmm 7 IRQ_TYPE_EDGE_FALLING>;
> > +             reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
> > +             reset-assert-us = <11000>;
> > +             reset-deassert-us = <70000>;
>
> I need to read your other series still wrt "ocsgmii", but any chance you
> have access to docs indicating the reset timing? I've never had docs for
> the specific Marvell phy on the prior board or the Aquantia one on the
> new board...
>

I have but they're not public. :(

> Boot time is something automotive is always concerned over, so I just
> want to make sure that this timing isn't any longer than it needs to be.
> Right now it looks the same as the Marvell phy's in the "v2" boards etc
> and that made me raise my eyebrows.
>

That's a good point but what else can we do? This should typically
execute in its own thread anyway.

Bart

