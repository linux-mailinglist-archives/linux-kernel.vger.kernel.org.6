Return-Path: <linux-kernel+bounces-367446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39A39A027F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 864861F267FD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1402C1B85CA;
	Wed, 16 Oct 2024 07:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ye6U6Q02"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745991B393A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 07:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729063568; cv=none; b=LmSQACS4cfdTA6Fglg/BPTY0zmo0s35CgLc50u5tkZ7yPxLhUXbZjmSXMs9QOac+jwOfhIeJWKfC//U/lMtnzBvSLY66t8wQQcFm/Nw8AXc06altP2SQkvk7Sqf3pMKc7zmDT5zmBSbakVqR1w6VmY7qbEz0Ft6MbHWgrYjRmoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729063568; c=relaxed/simple;
	bh=EkUGl4udaRvqskMWNNCBeol4kDoR1IFd16zVZQo0SO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFMZJ6bUzUy+5VMdOm1VkIJXCxjpmmveSdA8tBwD8DQZGcCkjyImXO51mkLtisOnUQ4bXCnrMU03VwLkcG2RIzixlJpsjv8jD3tx71u3oyehD+rg8QBUz47VsNGkJo8Jw59joZNGfvIzRBXhptp++H4NkNklY//aNMXkcFBImy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ye6U6Q02; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f2b95775so3986116e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 00:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729063564; x=1729668364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhK9aEfPG1w4C02v66++bUX1W5vp3z5jqPVGAhJIjSA=;
        b=ye6U6Q02TGaXRbjaxpQce1Z8iCLpNC25xvxpejBnHoKgyI3hIYMfptIZ02ry3KL3nK
         YCjpsHM78gB0B7PIGGPIdIt+kW5sgKWhANXgwujdyONwsQ/lfTTi1TPfkjsDEHQCciHk
         +hP0kU7StnpQ6WhIvtLxNeGaowSRFk/JziarOFKrpqAdXLqo5So1jozsN3JII7EGWxfE
         E5iuEyup0gHabwwhQMhGc1kJrywQQhyBzDPEFJDF8luLJGqx7Dw6DQMKOKWt5Mkljx19
         dkIVkcZyBai+ZW8t43zXgqlWZXrz3KjaZ10yL3q/MjOXMZ3YpAo+7ce1VRJRhbXailIl
         ZB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729063564; x=1729668364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RhK9aEfPG1w4C02v66++bUX1W5vp3z5jqPVGAhJIjSA=;
        b=PDvt3EfcOEb5U3HSFo8UfYdyBCxzr3GjLL8AOmgz+S/9ppAuOJXFZfLiTb5gzH1PVO
         lIU0Kv37wFm64Vk8wSsjTCTzKx8YEl5g117FUQtoXl1VMIjFsSm6V3cL/bridG5oulnc
         2fAn3KEND2vu3sTJWVq1zc5QotnuWPDfwzzGkjzlDN8oyLC7MTUDC/B0ViclFuCeOTTb
         P6JvBfBTF/O3zPPzmkHSih3Wzd/eZWf5w/hsAX9HEBuRry/LJb71QNL5WGGgPYmwTzxc
         OmEPNdETKQ33e4NBa9BgM9TVTyHhD6o7B5Jj4fhG9FXczezImoH3hz0G2X//1xR0ULyH
         rYaw==
X-Forwarded-Encrypted: i=1; AJvYcCV+CJZwu00AGEF21n5Kp543ZTk1ag6EMQWomwFJaP6624iAHpHkbxKJKjItBMgtv1cZie4P6ADFO4yQoXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj28u/Ri7aBM8Nq2mhd47UWyWrsmwvq/bu6NuaAJqdLoceysoQ
	Kna/MFTimxbc8FEBEAGv8/zwyXb86hpy4RYC94/nX8RF3nWIYW/xpL48Q8ZNi+dLL//gXiDn+3M
	IuWGrsmgoBPHso2L+YhVgbM/zpGEsxUSptdZv7Q==
X-Google-Smtp-Source: AGHT+IGeB3nfnjYOLwENvDZsj3kps6wkLWnU7XfsrF9QM9GfJpD8KbnECT8aOYo1TBp4gpcs9DRuudnglEn75xmeocU=
X-Received: by 2002:a05:6512:350e:b0:53a:423:6ec9 with SMTP id
 2adb3069b0e04-53a042370c9mr1782511e87.54.1729063564225; Wed, 16 Oct 2024
 00:26:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com>
 <20241015-scoreless-carwash-9ac6047092fe@spud>
In-Reply-To: <20241015-scoreless-carwash-9ac6047092fe@spud>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 16 Oct 2024 09:25:53 +0200
Message-ID: <CAEHHSvZ+j2DyikVQ1XYzk-Zg14FVKP1YHOm-rOimjHydxaGPaA@mail.gmail.com>
Subject: Re: [PATCH RFC 0/4] ad7380: add adaq4370-4 and adaq4380-4 support
To: Conor Dooley <conor@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 15 oct. 2024 =C3=A0 18:43, Conor Dooley <conor@kernel.org> a =C3=A9=
crit :
>
> On Tue, Oct 15, 2024 at 11:09:05AM +0200, Julien Stephan wrote:
> > Hello,
> >
> > This series add support for adaq4370-4 (2MSPS) and adaq4380-4 (4MSPS)
> > which are quad-channel precision data acquisition signal chain =CE=BCMo=
dule
> > solutions compatible with the ad738x family, with the following differe=
nces:
> >
> > - configurable gain in front of each 4 adc
> > - internal reference is 3V derived from refin-supply (5V)
> > - additional supplies
> >
> > This series depends on [1] which fix several supplies issues
> >
> > [1]: https://lore.kernel.org/all/20241007-ad7380-fix-supplies-v1-0-badc=
f813c9b9@baylibre.com/
>
> What exactly makes this series RFC rather than v1?

Hi Conor,
I am sorry I forgot to add some context here... There is an ongoing
discussion on the dependent series about power supplies and Jonathan
asked me to send this series to see how to properly handle the supply
fix...
See  https://lore.kernel.org/all/20241014193701.40e3785a@jic23-huawei/

Cheers,
Julien

