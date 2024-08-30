Return-Path: <linux-kernel+bounces-309577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A085966CFB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 01:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 518101C22083
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 23:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E4A17BB0F;
	Fri, 30 Aug 2024 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHHAI1eQ"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A8517C20F
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725061519; cv=none; b=HImAkLPGFO3vtKzp0offByhVO2iJCFom4MIDH7ch6qIsaECqjk/jb+l2n3RTUDFrvfnmMSoQsOgzNgkXFWYHEGVpcbOs704tuJ0BqZ/ouKmI3US98i77sq3ajQi/SVMvB5/RhQ+E9F7UUZ/azNiCTt1Usiowxq9Q5leS87FnCok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725061519; c=relaxed/simple;
	bh=BJrJHWK2hrRviWc8RTcAUobYhqxsaxKanbop8FqZH3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1NrPMouPHeKh+d3XM7ZV4tHH9WZ1Td+h3py2oGD3/bCm/vWiNZZ4NmaFXpIMLBFz++CEfa93WnRpuO9vC7a29odjsyaw0ndo6pSpcdBQHz4F7XZPyhkpERDWO49N4FUUkC7+ZBAFmg8X8M9Ikd+ZvXFP2+a5paxZytpkClQH94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XHHAI1eQ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6b8d96aa4c3so20148577b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 16:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725061516; x=1725666316; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s6RDRV/2cMLBxQkdzyFPsx7+tarsO2IXXvRThC1aAb4=;
        b=XHHAI1eQL60aX69x6/I7Zm4WA6bX4rxWBSF+lOSPxKd1r1G+V0SVZZ1/B2QE1cfpff
         tt+j6SY/wmRRO7BQWtpWZtC3lJScrIPAvAKDN30rvqARw86rDD1b3x7lmH/1qsVzXN2s
         8LRIvnxRHzSP6Qc/kJwmpHw+spNUmk7uS87VMBOOj3o00/TMQTGRZtC/ggN6GnK8KvdZ
         K4LQ9qFZLT8/+NT1NNcVoGcE/RBZEhIEd1YIVQZLMJSnXqRY0PLFNNlsATMaxQK0xe0Z
         1I0j+X8PRuYoWtirH5dMaDhZ6rE7Hj/1/NGRAmdGbGqBryhrjG2LTwue/WtY/5W4papy
         smQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725061516; x=1725666316;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s6RDRV/2cMLBxQkdzyFPsx7+tarsO2IXXvRThC1aAb4=;
        b=HhLrkw7oH7x6da5jOySLj3WxtBoFRnUJnS0wi/s9qxLyYFn8PisGgjB22uN13tCzuA
         ZN+nkxYfpsambDhX8ruRX838nYsDcrlNTliC43/WOfHv34vJFZ9tlJ2qcweNkxVjMKPP
         CNf7/D39bQUjAMvGl2NthN2Vo+pt8qVWBuGBpvSWGd8MxpseWV7aJNydWGqGtjMpTuFs
         cUdmF00NwiZpVbgWqHorT8VbhhjRClb22I05EHqFYVJcW2hF7O1RjGJJeqtyUp+R9Df0
         jHwMv9Tuh2ogStCr2CzINEyGJBE56xIDgM8obNaBFoToHyRrVei18w7k6DNNrai1JA3E
         SI9A==
X-Forwarded-Encrypted: i=1; AJvYcCXDmhmMCp1T6TlPME5h9YYFpMLlAfHCHIM1FZIh1f0J1GbKHrOBYUzofpV8/C8czSFOVmTDXOti8dcwDKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7E39j4XZbcCrSue0Kqw1nGmQTJt30dntFIpalPh/p0MOh+U3Q
	8JeiJ48FK6wy74AghpTW9WBUhHiwNzXG0VrfetaOG7TSbEdH4ZRFZfRDeKrhh6oIOTmPtejSOUm
	TwO2UYlnrR9lQG7L+ylyaXcGc7INnr7CvvY3LbA==
X-Google-Smtp-Source: AGHT+IHfhSbm43+Kc4Ly206lcH17lzoQ0MsCuKhc2fSpqgnSY7QJASQeQlrIK7n1P7aXyz3Fk75oT++EVgArwU/kRyY=
X-Received: by 2002:a05:690c:660b:b0:6be:28ab:d873 with SMTP id
 00721157ae682-6d40d88b9e1mr47313387b3.2.1725061516161; Fri, 30 Aug 2024
 16:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830-nxp-ptn3222-v2-0-4c6d8535cf6c@linaro.org>
 <20240830-nxp-ptn3222-v2-2-4c6d8535cf6c@linaro.org> <6fcaa893-70a4-44f4-afc0-853799e30774@quicinc.com>
In-Reply-To: <6fcaa893-70a4-44f4-afc0-853799e30774@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 31 Aug 2024 02:45:05 +0300
Message-ID: <CAA8EJpoTb_-HtBPv2=FecHvtHYQD4ipqfq3C98ky=qXEXB=_6Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] phy: add NXP PTN3222 eUSB2 to USB2 redriver
To: Song Xue <quic_songxue@quicinc.com>
Cc: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 31 Aug 2024 at 02:13, Song Xue <quic_songxue@quicinc.com> wrote:
> On 8/30/2024 4:20 PM, Dmitry Baryshkov wrote:
> > The NXP PTN3222 is the single-port eUSB2 to USB2 redriver that performs
> > translation between eUSB2 and USB2 signalling schemes. It supports all
> > three data rates: Low Speed, Full Speed and High Speed.
> >
> > The reset state enables autonegotiation of the PHY role and of the data
> > rate, so no additional programming is required.
> >
> > Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Tested-by: Konrad Dybcio <konradybcio@kernel.org>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > ---
> >   drivers/phy/Kconfig           |  11 ++++
> >   drivers/phy/Makefile          |   1 +
> >   drivers/phy/phy-nxp-ptn3222.c | 123 ++++++++++++++++++++++++++++++++++++++++++
> >   3 files changed, 135 insertions(+)

[trimmed]

> > +
> > +MODULE_DESCRIPTION("NXP PTN3222 eUSB2 Redriver driver");
> > +MODULE_LICENSE("GPL");
> >
> The I2C driver just realizes the function on reset and PWR. What about
> other I2C driver function like I2C interface operations,

I don't quite understand what you mean by this. Could you please clarify?

>  auto-suspend,

I think you mean pm_runtime here. It's a valid case, but granted that
it should stay enabled when USB controller is enabled, the gain should
be pretty limited. I'll consider a followup patch implementing
pm_runtime for the sake of being able to disable I2C host if DWC3
controller disables the PHY.

> remote wakeup,

Not supported by design. PTN3222 doesn't have IRQ pins to report
events to the host.

> memory maps etc.

huh?

>  Who will enable these? I think it is not
> incomplete I2C driver, if on someday, ptn3222 is used as I2C device.

Well, I'm using it as an I2C device.

-- 
With best wishes
Dmitry

