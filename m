Return-Path: <linux-kernel+bounces-215239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4645A90902A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41132872D2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E6B178CE2;
	Fri, 14 Jun 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="VyFdOtOu"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2321316F0D1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718382305; cv=none; b=bb53i4mJB4D8/HoNfbG90csxhw7TKun9UJisduP0PTXKSIPeJpttHLCe3DWmZx9pG0vLaVj9Z1n7qXoPAt0OlAjrj+atSopeHy19RdDFr8mhnfu9s0+PLBDR0a6jCngeScXwVe0rPYyusekHlucJck+JoRTyOElxCSCDt0VjUs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718382305; c=relaxed/simple;
	bh=QCq79d13E0tz2njJOcLY9mxviKHMKKd7mCV9RIVP2Sg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAcMtApCB3AAn6rw5aYRCby2+QqbSKCLhKdqeSoDpBQ1k38Bn091WTXikdeH2aHGAuuMfEzej8dvbWXtfD1jQJROraLV+mTI5jIEdXFB4b5Zd69J5LnpMJhmBgLtb8V7FXEJbIeBtAvsuuNrcWWyr9MC61x88q9WRy46d9k5j9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=VyFdOtOu; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b08857f3b8so12075576d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718382302; x=1718987102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ9BKcjtQxEX9HY4AyHldVS/pYAF0bNjL6ygRqtnenQ=;
        b=VyFdOtOu7HA7/xZDSbmFbiLFOlmquoiVqCS3U2oG70jkZS43lJ1l+iq66js25wNcBo
         xX62Y5m+KNFNhILXK2xh0hmANUtaoEdRnMFvEsYEkhlvWFBXdZKTyYRKep79xo8V2hNX
         cNFDwsBOHFlTm8yFjZrzdu7+IM511w3KIqWi3Ef0+pxJ6i5Iv+ZD6fb2TJzfXbFSK3aF
         g9XlUeIsVMRGgN0RhumBCZyu+801SL5gj73Kj5n0nyTET/l3hMjuVgT5nfkNePPr1hrs
         tEU1jXCW2wpzzgnX3wJmZSDgnde2eY5IB/mSOrTzZhIAzkrQH2FIHCOfrm62lV+T5RZ6
         qhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718382302; x=1718987102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AJ9BKcjtQxEX9HY4AyHldVS/pYAF0bNjL6ygRqtnenQ=;
        b=W5jcd2eSUSg2YUx4Devjct1OB7zyj9VlOgtrRW8qvlJJMOQoYjbWgR9CeeHUB6iTFN
         FU8k8bK7UxSw2PO0eKxTTLmV9xqZDNdZtpxU4Pr7tNF8EmftHqYNcqEr2HGttb837qFb
         l7iNijbgSif0wnkV3KLFbjcIVe33yY7fv8sVn2E8iUzrL/Lbddflfs1Oh8ihDBp0yFch
         Ne6tVz+9EU8BfAE2E9ogBP8Qdj0dRYuxDRhzOm8Bp3CwF6feUWRUY0lxVxaWortwtWru
         bs8licFOaGbAdd/K704ZwuH90RNlC/Y6DBV3JPefHIy6km/SW2J3NiR7gKPiyJ9eBAga
         ROSA==
X-Forwarded-Encrypted: i=1; AJvYcCUwWgzHRmtYOp4NIjy7ShMeU6fiS2fOrrdXtWL1HjqjLXF/yUWQpyZOAr1CJTETxDzepvaUC9sSo+iZ/7y4TUUOa0NbotzgV7KChc9e
X-Gm-Message-State: AOJu0Yx503xmyrrAlAjUHlVZfqjYl2NiriNAl2vti2sxAZ7YCjmwrDDP
	KxkCbOCHIwSimsuNBsWXRHDG6SH01gFcboKVYXj8iaKh46O9t1a+A9qEqZ78VX0a7C/Qg5MHxGY
	8jcrFjzHNdUdCeRVPfah3uaKlfmTO6NfWpA6SWQ==
X-Google-Smtp-Source: AGHT+IFxjsSmHmfjxcdx9LWJjlcnDzbmg6MTEjpCpU1mp7pLjF7m25ZdRpimxrXWgRWc3HiQ8GE0JCG3qf8CO/aq5Sg=
X-Received: by 2002:ad4:448e:0:b0:6b0:820c:2d50 with SMTP id
 6a1803df08f44-6b2afc722c8mr36483566d6.1.1718382302054; Fri, 14 Jun 2024
 09:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611094810.27475-1-piotr.wojtaszczyk@timesys.com> <Zmgor8accyAiUkUO@finisterre.sirena.org.uk>
In-Reply-To: <Zmgor8accyAiUkUO@finisterre.sirena.org.uk>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Fri, 14 Jun 2024 18:24:50 +0200
Message-ID: <CAG+cZ06B+AexqvwZtNP5FX50AmghAFLa=1ebxmKLvMoyVJ529w@mail.gmail.com>
Subject: Re: [Patch v2 1/2] ASoC: fsl: Add i2s and pcm drivers for LPC32xx CPUs
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vladimir Zapolskiy <vz@mleia.com>, Russell King <linux@armlinux.org.uk>, Jaroslav Kysela <perex@perex.cz>, 
	Takashi Iwai <tiwai@suse.com>, Chancel Liu <chancel.liu@nxp.com>, Arnd Bergmann <arnd@arndb.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org, 
	linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 12:36=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:
> > +config SND_SOC_FSL_LPC3XXX
> > +     tristate "SoC Audio for NXP LPC32XX CPUs"
> > +     depends on ARCH_LPC32XX && SND_SOC
>
> On a quick scan I can't see any architecture dependency for build,
> please add an || COMPILE_TEST for improved coverage.  As for all the
> other things enabled in this Kconfig file there is no need to explicitly
> depend on SND_SOC.
Ok. Later I will add a sound card driver to phytec3250 board which uses
arch/arm/configs/lpc32xx_defconfig config file so that the COMPILE_TEST
won't be needed.

--
Piotr Wojtaszczyk
Timesys

