Return-Path: <linux-kernel+bounces-169390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BBA8BC7F8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D5D1F22176
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 058705464A;
	Mon,  6 May 2024 07:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQ/oiTyU"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF68481B1
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979046; cv=none; b=NH5cmUgMZlUwEG4OHjme5XioGoMpNdpjiMxWLoEIZEo1MILWcn7caP3k6QzQFu0BXvfvyjOECEPPjET6/CQt+aWnjVZsn3UoNR2o+Lxqjk3wCjdyjbVUKXjZtC3rg37JqVjQZme3yMNhw+JLvZ0I1EPriqKMrgwaTotlIGfTv+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979046; c=relaxed/simple;
	bh=jznohTa5ug8sLejwDzqLsWt2v21AlWpPddDxegOk97Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQaiTWwRtUNwCw0V/F0sm5aEi4COJRc8WTWoLQp3q21t6TEVbP5nLzQjIxiqP/QvOofaoZhdoc+1paPON+MsbUQ439ObAT7HuVRW1aOtEUjEejWSu89MFS1GWe7ypK3fXauBdTGBdpfK02C05Cks1EzSjYDwX5ofng/2P8H83R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dQ/oiTyU; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-de8b66d1726so2872485276.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 00:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714979043; x=1715583843; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jznohTa5ug8sLejwDzqLsWt2v21AlWpPddDxegOk97Q=;
        b=dQ/oiTyU2fN9RIagzSYRg6qWB25L4lFR0Srj2AKyC1Iprq1lTa7yPKzcn5RWfv+9sv
         8132CpWaujpyiH0LkMKQ0xWR9Ss+ylO/2FIC7CC86IKD0+qER3zhpXEg/qcqF0ltluzK
         YE6x6414+4a0WCoaLoxgaA9xSQky4kOLxhlsaZ7WW0cgBrJVAo2qHZ/3ztFGeIs3ASve
         pyHqw33Lu6VbjGZGplC89LC15H3QpqU7zgnlcMsHI4nSu1JWMlSOgHQNSQ0oMnn54Q1f
         /X0dzDP0ySr1lIApKy0e4GrNOWzzuzTm0gZuVmWpZl1Xg6JThcJTCSvaYyVRdiuJFsd0
         u2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714979043; x=1715583843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jznohTa5ug8sLejwDzqLsWt2v21AlWpPddDxegOk97Q=;
        b=vco/jiQjI8ViQB7IKS51mLib2uEzq0PA4VDyocnT7SL6uDQAOM4dsPVPxeOgQi4MHq
         hD0uxxSKUFhUMPn/u+uXapYrKuoVM6PQFN+6u0HcHW1oSX0zxEWylR6x3PJ8XFzU5eWS
         rX4kOqQlacVr6Z5MT6YWTWsO1H8MSqwS+Ct3JyIk0t8jHlelr3ci31NpW5T0LCQAJPkZ
         QDy3KfBxcquPWelt6LLwru7Bct4poGqVInW8bd32EuTWaO/DFM+tMnXAq5bEQqJTEYzf
         /vyw7aiZFew6JZ6iOOQDGK97460ZWankFhVvnBAhb3OpZUKPrw3vcf08HDz7dyKIqiTn
         OPmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYus6/nJjabMBFwt8IKszLDmAnqGjgzDWYHCNvjBFEo7gq4V1TjxkzGkvN5YVzDAHg6ChdcWFFhGBR7pr1JEzj4gHYoOVyGdJWhML7
X-Gm-Message-State: AOJu0YzXvG51ZK9fzarwsBUa3N+XIyOSie2yvHtYcIRioOvsK9MOajHM
	O349AROOtEmpf/BPIfSiPvltjL7Gz8zwxE+7m7070rCy4QdFqXHHBwhCVkABR6XqrCyYPJ/FSQ7
	uySlqWHlJEBQymkvVThVXc02cFhwkW/hwwvzp6A==
X-Google-Smtp-Source: AGHT+IG3yDOoLnUXRBMI8lrR2H5UzsYULy1K6My67I/jXLuqtZrm2OCq24OfQNt4/HKDtqbemqh1jHXtsBeCD2VzXyY=
X-Received: by 2002:a05:6902:250e:b0:ddd:7ab7:2320 with SMTP id
 dt14-20020a056902250e00b00ddd7ab72320mr9354716ybb.27.1714979043648; Mon, 06
 May 2024 00:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424185039.1707812-1-opendmb@gmail.com> <20240424185039.1707812-3-opendmb@gmail.com>
 <CACRpkda4v6Nu8V3MVamDpfs4qnc89e8Vd8fSyaNsqJQ40GQqZg@mail.gmail.com>
 <45b7742c-9cde-4238-9c2c-c75dfbe9d8f3@gmail.com> <CAMRc=MfEVCDf8sn7C-cO_Y1xa4RehQj1tvRSRtC5aj0dF6uJWA@mail.gmail.com>
In-Reply-To: <CAMRc=MfEVCDf8sn7C-cO_Y1xa4RehQj1tvRSRtC5aj0dF6uJWA@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 May 2024 09:03:52 +0200
Message-ID: <CACRpkdawMaQN1QrPXwdKBdkhrNAewe-Oe+FNXzks_O4mdg0Otw@mail.gmail.com>
Subject: Re: [PATCH 2/3] gpio: of: support gpio-ranges for multiple gpiochip devices
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Doug Berger <opendmb@gmail.com>, Phil Elwell <phil@raspberrypi.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	bcm-kernel-feedback-list@broadcom.com, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 2:25=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> Please let me know if this is still a NAK, if so, I'll drop this
> series from my tree at least for this release.

No I was just wrong, I had missed Sergio's addition of local
offset for several-gpiochip-per-device handling completely
and confused .offset with .base...

Yours,
Linus Walleij

