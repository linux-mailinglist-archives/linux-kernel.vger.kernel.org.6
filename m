Return-Path: <linux-kernel+bounces-316010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6643396C9CE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 23:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21F2A2893A0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 21:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E5F1779AB;
	Wed,  4 Sep 2024 21:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C8B4Pu7m"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1B1172760
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 21:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725486697; cv=none; b=e95briYFT0lvi7VdIe8SjSS9cfvWfVbRV4UPTffNH09k17Bd4tqmVzBJfrC55RManr9gbFkh8l3F/Blj98ne0WqDxeAuC9ha65zecXppb4vBMFt9q04hMtJGD4iOM3hD6Uc6vVddpyqOwDlaYeGSRJTsjhNr0S5g+Ba1uDf+wDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725486697; c=relaxed/simple;
	bh=52OavEbDbnnXzGVYj1cdimeK3fNcZ3tbnsTSFU90N5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZ6lA5u41vhSsx190z1A5tNX8N08Hdb6kM+RXOxSkfwOh7X9XNFVtBfBAwCRKeKOmp1G3XjJuiT3krJmj1shf1+yL2X+1mqGfMGuK5/lCWxTz6w2bK1PyxM24LmrnidkOdG6b9g6XBLZdAz1wDkbnKAVdBY8aTKD+Cztoqf6aNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=C8B4Pu7m; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3df1e26de08so29230b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1725486693; x=1726091493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GEVB0OaxtEANZF8G4JgUXQ7IBpjIjKgmyEACvOZxq44=;
        b=C8B4Pu7m+yGIBipLecwld/aykc2j6fT05QvwJUKZtzO/gjHu4lqFiM8aCcNcrr3Ayl
         hTAu+A/hSofKApJOjdK5zRnjzBm/UfVzSeNBHyxXnVlPGuLxJ/tPstfRycF8mo3/gYjF
         Rz+gkJVntXToufnGfBlMIAd9F0iiMKm9BFflo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725486693; x=1726091493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GEVB0OaxtEANZF8G4JgUXQ7IBpjIjKgmyEACvOZxq44=;
        b=pGYZtYpYwuS7PAa9a9sChik0BFotIUNIHdD1LJOV0kQ4rQwHoicEAp78m2j0y0gtJ6
         eLnOZ80m0iY8ifsoMEDp8nXKpluijTQxWe4q89TOX56MQuLQ04YxC8s2nfuw5+4WDtGA
         8zCeDGmLKtTgWp6CIg9Y8ZnCjzKynhI7SEWF3ixcQmJ9lqTW9N0FGOsUP6vBULqgnWSW
         8p46mF60fO8cqBltMR1vjDMJpEvp14J5aj+AgLpIJL2zhg30pyOS1IlB2olMm8t3zLmc
         qU3IEZhbLE6EfjyeCViKZwjNQDFFULYqrJjjGM6NmBdP3Frm1yYNFoIoLUpZ4lfCFpYx
         jrfQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0OHRIT3qXR7JTXno/BNCkfWb3cYhwnJ/DXN0R9+zQh8yrOfW/7cLCWKXXz8MVvg0VIOtP3L7NHLyEWK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXR2HqsD0C/rKB8rUiHi3Kp8djTjp9Uw0DJVqzVfpUcuRYMYX/
	XqLKbi6cY1re3UUPr16SO/9hRceGGbJOLb3d/isckFHVjwnKqCtjKSwvHGaHYH23Q4gXAomny1A
	=
X-Google-Smtp-Source: AGHT+IFQEmE+AabZ1tXzah/3JdY2gVSbiXw13ucxHuWb8GhOmGLGHzqXSFOVjmcjbNyn4HFT4MR5rA==
X-Received: by 2002:a05:6808:1249:b0:3de:223a:8983 with SMTP id 5614622812f47-3df05d64e25mr21683173b6e.11.1725486692958;
        Wed, 04 Sep 2024 14:51:32 -0700 (PDT)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com. [209.85.210.49])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df117c1b56sm2966100b6e.17.2024.09.04.14.51.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 14:51:32 -0700 (PDT)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-70f60d73436so84229a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 14:51:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWK0CFVD0h4W596mh+tDPO6j3TPFzhM5Tk7OUrysL4wvyY4nV6dQtJaAPgGn4Bj0jkb0VoOfJcSpBwWDaU=@vger.kernel.org
X-Received: by 2002:a05:6830:6d08:b0:70a:988a:b5fd with SMTP id
 46e09a7af769-70f5c406907mr29012888a34.24.1725486691455; Wed, 04 Sep 2024
 14:51:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240902152451.862-1-johan+linaro@kernel.org> <20240902152451.862-7-johan+linaro@kernel.org>
In-Reply-To: <20240902152451.862-7-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 4 Sep 2024 14:51:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XnpPnSToWV3f2Z-DWm2-1rdgYmDZeicGGRQD-_YjS2Bw@mail.gmail.com>
Message-ID: <CAD=FV=XnpPnSToWV3f2Z-DWm2-1rdgYmDZeicGGRQD-_YjS2Bw@mail.gmail.com>
Subject: Re: [PATCH 6/8] serial: qcom-geni: fix console corruption
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 2, 2024 at 8:26=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> +static void qcom_geni_serial_drain_fifo(struct uart_port *uport)
> +{
> +       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> +
> +       if (!qcom_geni_serial_main_active(uport))
> +               return;

It seems like all callers already do the check and only ever call you
if the port is active. Do you really need to re-check?


> @@ -308,6 +311,17 @@ static bool qcom_geni_serial_poll_bit(struct uart_po=
rt *uport,
>         return qcom_geni_serial_poll_bitfield(uport, offset, field, set ?=
 field : 0);
>  }
>
> +static void qcom_geni_serial_drain_fifo(struct uart_port *uport)
> +{
> +       struct qcom_geni_serial_port *port =3D to_dev_port(uport);
> +
> +       if (!qcom_geni_serial_main_active(uport))
> +               return;
> +
> +       qcom_geni_serial_poll_bitfield(uport, SE_GENI_M_GP_LENGTH, GP_LEN=
GTH,
> +                       port->tx_queued);

nit: indent "port->tx_queued" to match open parenthesis?

...also: as the kernel test robot reported, w/ certain CONFIGs this is
defined / not used.

Aside from the nit / robot issue, this solution looks reasonable to
me. It's been long enough that I've already paged out much of the past
digging I did into this driver, but this seems like it should work.
Feel free to add my Reviewed-by when the robot issue is fixed.



-Doug

