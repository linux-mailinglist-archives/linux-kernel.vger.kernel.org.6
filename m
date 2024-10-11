Return-Path: <linux-kernel+bounces-361762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF3799ACB0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1233283735
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753621CFEC4;
	Fri, 11 Oct 2024 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AxvyLP1d"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCA61CF5E1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675176; cv=none; b=AyA3EWURm/jZx6dYKkNt/vPbm+JEmjIYU/Gq+gp6p198IyZGsF4giI4ZsqOOSaLWGJrqRRnIi1e1GbTFg9GAj1obXLTBsumU4ywOYk1uuFRXWF0l0LiGBJHE42cQcQPy98U3+RqscYPkB4TSGGSlNsVHS9qmxNDp2NYJLcy8b7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675176; c=relaxed/simple;
	bh=0Dvgv+UgiYebQDKZ9IfxJrDvYXdsPQ2XdRWiVY3gix0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pukrUnTwdDfRTyYaPFqnnps/Z7sjAkW8g+HpQejG60m9tuUFdSFACtksB9hRHjkbZzxxAQeEKZhjv6hsR5yQfGW897BMXjFknFuoDk50RPF/UKCEZI34qpLUKE/TCNnulyOL8TbdOvhJivsdS/oPFyEI5BF39UfTinIBZ45/ZIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AxvyLP1d; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2facf40737eso25868361fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728675173; x=1729279973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Dvgv+UgiYebQDKZ9IfxJrDvYXdsPQ2XdRWiVY3gix0=;
        b=AxvyLP1dr2CjTV9qlGs220KSe8RR8jJB5cpH508RjL1Zf64AuJPbAj6DRWwuKGYWmS
         j640gTkaJ6+VCx80eV+8fIPan9emI1nyFXZXSVsEC7ZSwKdrnF2eYAqeI2lRbQ3fJvHU
         uGuTXniznSgzwlcn77FDsmM1NI2enuG1rqLczSg+3x6vfWexk1F4YjE2x9u6nfH8XuOs
         SZNOhqu1kFGPRNK+w8Q3S4rAFMidDW0pJkJr3jn2eBnsHFO5nBtgUmTUqgvbUQRdd8cC
         GXOAsXU4WtycSHkIeouNSsY4uovBEw5yDetwD/kfEH/NyfWCc11ztYNfVvq9JGtM7RoZ
         3DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675173; x=1729279973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Dvgv+UgiYebQDKZ9IfxJrDvYXdsPQ2XdRWiVY3gix0=;
        b=TvSKGeg2GB2mcba2jr/mcSK/yftRSzezys3Aw52zbWcSMatuuHT3v3inbeWpK9UI2Y
         wkW830HtwXrzp3IfgsrMZ7H5l5FLZblsdI49zCmJ0CTLXg9MhPIcDuSKeLgSO6kSMvsE
         FLN0sBpJ21wl8XYqAZvh8/jtIaJcie+i4YQWMUNddUBFnAKgPlAE+DJuExyHmLN3M/j6
         EMLNkoWEzg5UKzm4G+gLmlqqb+wZXIEGz4u5oWVKvaRTedD8xBJ9IP6TPN5D/FdIDCOa
         cFnscQjf5AsY/70wDL/+mXyKCBvthLsbFe8zXP7ZS7VWtF47YaGXcHbw1+WcNXGATvap
         gVog==
X-Forwarded-Encrypted: i=1; AJvYcCUMU6i9Br5hOaduJ6mMp99qq09S2GNkRWadAWF+ru3TeAf4jyCWDswmDYlw3SOM/8g6ZaSct+3/yj5AqZU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjen7CCN2RTTl0VZAt3bPNeZ5m7oFxuINUgFNxDdkWVd8gsaem
	MCyBWyPzpcDGWrbAuaZweVKJtuQMgDyOjv9WHBNJHg1KV3Lry0P4XMOFcuZO6wt+qxPp2hFMZ4v
	EaYFr5tUUkPYOV25caPml6tmpCT3FXzFDnZnT9Q==
X-Google-Smtp-Source: AGHT+IEP2zyu041nsuIcpzinC9oG0tJP8iuNQ7N2TDCvU/twlwCAJ/xj98WK87KIp+0/IUZyL7/1wJ8FZ0iSBshfx+0=
X-Received: by 2002:a2e:802:0:b0:2fb:3bef:6233 with SMTP id
 38308e7fff4ca-2fb3f2d1bbbmr2917751fa.33.1728675173182; Fri, 11 Oct 2024
 12:32:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005085117.438715-1-cvam0000@gmail.com>
In-Reply-To: <20241005085117.438715-1-cvam0000@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 21:32:42 +0200
Message-ID: <CACRpkdZF2UiaOxifOua=JP2Jjx-GcZyQ-yDd1DEm=KOqMciniw@mail.gmail.com>
Subject: Re: [PATCH] Fix typo in versatile.c
To: Shivam Chaudhary <cvam0000@gmail.com>
Cc: liviu.dudau@arm.com, sudeep.holla@arm.com, lpieralisi@kernel.org, 
	linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 10:51=E2=80=AFAM Shivam Chaudhary <cvam0000@gmail.co=
m> wrote:

> Corrected minor typo in versatile.c
> - Fixed "documentaton" to "documentation"
>
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>

I applied the patch to a branch with Versatile stuff, that I will
send upstream whenever we have some more stuff to queue.

Yours,
Linus Walleij

