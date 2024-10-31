Return-Path: <linux-kernel+bounces-391055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA34A9B81F8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0CF282872
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0611C4612;
	Thu, 31 Oct 2024 17:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZA/UIs0C"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3797C1C2443
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397510; cv=none; b=ZXEfbryXAt02rPtG0XY1/lRd7Wz2W3QGO0mUckxBqeQ4k81dRzLdi0zLnEpdlzmijBX51UiWEGynqGEwECK+kUJzMTULWmd76BD/3LAsQ4T4s6HnIvoe7b3GHT4nBaT7aqPv81LwMv9xw96PUWRH4bsEFwfvbQDLIXr4BlYxAsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397510; c=relaxed/simple;
	bh=GprtLr3+fDuoA1kbr5iV1i1OWpC+hVzEb/dgPxI6zjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u0n+ZwEfU4J7n7zSAluGKaz4C1eecZPABtmUmtqq+ZbbWcTKSfVjOAIq5aJEQIp82vgFGekpM4bnCiNrX555B5npx04neM36lr/8dGojxYy8Z0GXtkp46lWIz23yrNZ0LKnoZQ+s/VQbC8pLMY11IV1s7CW0CZwie80BekoEprk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZA/UIs0C; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f58c68c5so2310066e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730397505; x=1731002305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lp+SkhbwfifV7k5hA8ZYEm0WPfNORR7rjsrxe7EFMug=;
        b=ZA/UIs0CJ75GwI1qVdNbiHQ+SlbD9/yNHnMSJS/l2Z3nuQH4xalqfFnWIlcbUHaTjL
         89Stwcu86JTvV7WwbIGapdgs/p2gnekFFZcZsGvxSPwiKyf6NWMVR76s0ZV7k6oslNhI
         hnxLddHxIW2HKsJtI3bPAMPc8q5A5CALWnX+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730397505; x=1731002305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lp+SkhbwfifV7k5hA8ZYEm0WPfNORR7rjsrxe7EFMug=;
        b=Auc9u9bLWyjfrAIjvaSIJZEIhrT2H0ja4g2aAnuIwogiEE5lWm2OOk0Y8hvincW+oK
         4VzQtXaZWf58OiU8nZtsBLDHmyMDk0z506q9drZtWUMVUO7dcuDDEYpOe1V7x98H7wgU
         RjHxbxaFwpXKf4sWOfJ+PWVP3XBXVEd243dKJkkULZ8LbvKxQXHi26grdkrIUn0dH41x
         YdDEBv0Sza6wTRIej/q3JPgBWIgRjND+ttf5gRlqikSKD3gAkjkY96kWpH68slCW/SF9
         3IajKqoXgy2Im2oBxgmnMJb7NRyqrDh9blkfE5NOKz9bJzrBZXg0cS/sXJjIzFklnBkL
         0a4g==
X-Forwarded-Encrypted: i=1; AJvYcCXtZjmTmhHv1NxQwjFKYmYjKDii1vdn+y6I4bxqINETfagWWxLpt9jB1PfAQBjDidJ5TsmFghIriIkVDFM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/QZI3VTC6G6/lKPFsp3vyHNolJLzuiFGHuZH5qainSvPnIqP4
	Zp3I0+NPxyLfI99ltGq+k+0CHOuNo8AFdPwaKHe+6r5Z+CRx5wgBJ9EUzfYARY7S3JWREyyGcgv
	h1ezn
X-Google-Smtp-Source: AGHT+IEogQf8+4y2iCWGOgXY1/v5lyEdS7oQ+ZStkqigGBzN8KXzivIHMGhENM7aRXBDDJQGCCDzOQ==
X-Received: by 2002:a05:6512:12d6:b0:536:a7a4:c3d4 with SMTP id 2adb3069b0e04-53d65e0a8c9mr915180e87.39.1730397504907;
        Thu, 31 Oct 2024 10:58:24 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bc957aasm281537e87.42.2024.10.31.10.58.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 10:58:23 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-539fb49c64aso1820272e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 10:58:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV9/dJ4WsKcTMZkJcvWX6gAGMEEM5BQLlKPNS369oGYRxV1raOqjUuAbZVFc1cVpsbtZHLKqRWm20GMfYo=@vger.kernel.org
X-Received: by 2002:a05:6512:605:b0:53b:1508:468d with SMTP id
 2adb3069b0e04-53d65e1686bmr748585e87.54.1730397503175; Thu, 31 Oct 2024
 10:58:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025114642.40793-2-charles.goodix@gmail.com>
 <3ypn62dsgarvmxkmdglugcinxmvpmhdqub2zvkygaonn54odf6@amfgijfcd3l3> <ZyLtYdwoJWx9FsdS@ux-UP-WHL01>
In-Reply-To: <ZyLtYdwoJWx9FsdS@ux-UP-WHL01>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 31 Oct 2024 10:58:07 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UNKECLn=3VrjsJfA+HTNa9Gag1qw5jOcBvw7=ZtkZEnw@mail.gmail.com>
Message-ID: <CAD=FV=UNKECLn=3VrjsJfA+HTNa9Gag1qw5jOcBvw7=ZtkZEnw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: input: Goodix SPI HID Touchscreen
To: Charles Wang <charles.goodix@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, dmitry.torokhov@gmail.com, hbarnor@chromium.org, 
	conor.dooley@microchip.com, jikos@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 30, 2024 at 7:37=E2=80=AFPM Charles Wang <charles.goodix@gmail.=
com> wrote:
>
> > > +  goodix,hid-report-addr:
> >
> > I do not see this patch addressing previous review. Sending something
> > like this as v1 after long discussions also does not help.
> >
> > No, you keep sending the same and the same, without improvements.
> >
>
> I apologize for overlooking the discussions regarding this issue.
>
> I would like to clarify that while the current boards use the same addres=
s,
> but newly designed boards in the future may require different addresses.
>
> Retaining this property would likely offer more flexibility.

I don't feel very strongly about it, but maybe Krzysztof does?
Possibly the path of least resistance would be:

1. You drop the property from the bindings.

2. You hardcode it in the driver to be the normal value.

3. If/when someone actually needs a different value then we can add it
as an optional property in the bindings and fall back to the default
value if the property isn't present.

What do you think? If you feel strongly about keeping the
"hid-report-addr" then you can certainly keep making your case.
However, it's probably best to wait to get agreement from Krzysztof
(or one of the other DT maintainers) before sending your next version
unless you're going to take the "path of least resistance" that I talk
about above.

-Doug

