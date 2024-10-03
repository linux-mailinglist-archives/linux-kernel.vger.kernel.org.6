Return-Path: <linux-kernel+bounces-349529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6EE98F7E0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EC1283CDB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410761AC438;
	Thu,  3 Oct 2024 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WRFy0XIh"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD0C17BA3
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727986025; cv=none; b=WT8Ca32Cz99CX2ceiZdlkYMF6jHLOC9wdNEPT624sx4Gf9U9y9grFgszbyXpQyQjNPNBIVlN74BZAKy1MFf+akEEPvwChiTA/1+cbFxSKNlKnYqWBDyz6Jy/DA21JGiSOvrVLn16ZoeG0cH/Xd21RKUW4OY2kpskuS5HIT2Qqr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727986025; c=relaxed/simple;
	bh=TnhcYpa/NRBNowU8LjRQnpY1dIEz8TtqcanEbYw8s+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FYGhGkoOK4HJKGGTM5fNtB5n6r2Xaw5ivfL7SOHRW/1oGYSQMg087WxFjTmZwyt7VXVYJcbLD++BTenvZG8YHFMKqIETOQoU+UWAyCcJA8SeEOV9WEXKOYMx0whVI4NZyrrON0ypNENr56NCvkTDZqDk6G/UTv1R4GLFy3ZYWjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WRFy0XIh; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5398b589032so2278707e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 13:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1727986021; x=1728590821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKF05LoiruBsD6AHIRVSBunf1dIpsE0purL42isX/Q4=;
        b=WRFy0XIhIZWYM/HRcMdHhZ+w47m12HgWZI9vSOAPyvGHOGuwOFg/LTB14t4+EAJ2PL
         Y1nXHrz7vNGtbExaa3/pT/llj5DyYxPrkTIh6Rl5KIlvo4m8eLgSu+G+CW1bCaTHOZLX
         6ru7GoenElM5cPfQm57jlghm0jQ87VFLHhmSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727986021; x=1728590821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKF05LoiruBsD6AHIRVSBunf1dIpsE0purL42isX/Q4=;
        b=bBdj9GGqAr05KdAujH5B21q3no4Yp06yG7Nae2oITFCMh8YKdY/07OkdplPUQJHcrj
         tWCmIqWOgW7p1ApF7pmY549WnJvqPxXaCha5hCmx7Ft54WfFiWiieQky3mAduDfHIRaZ
         nNIowF5HHIYkIwySI/ho82m9OFRJcdD4JNAKAAoX8NsZBzBw8TcuCFLPJNXTeu6zIL16
         LlBOcgR3Q73SdovK9QeES97xsrERbbwMboXXS7yKoH8zCSHI2xgSFTsoar2vtvgpKuUa
         d5KZP5QzrLHjtrt5snNRFXre8do848ldtu7Hse9FOMMN6DAPVViB1TQxK6SZV5g5TbDe
         4HQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlgMiu3DUwgdRnyjQSEDCCKD+VAsqKjmojqbGxMQG/J7jS7KluV8l9aWEAuVmHH8Rv+4yzCjRM1TeIGs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6ofn7QFJBOQOkupBFRDw7NwHaDYuNj/tj5j0yN6eTEYc3h1hR
	tpO2Ri7spEECafwB4thPXVV9sxe3EVc1CjS11/fFlqCW/0GADKSCgqf2AKolbW2egerINwjjKQT
	4HG8/
X-Google-Smtp-Source: AGHT+IFjW//t8jX62xppcyN1idq27zzmJn26geuNtzwoOUetu6JOXGp0BgeRwBVxSUhGRS1SafQSmg==
X-Received: by 2002:a05:6512:33ce:b0:533:c9d:a01f with SMTP id 2adb3069b0e04-539ab84e56amr425755e87.4.1727986020415;
        Thu, 03 Oct 2024 13:07:00 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539a829796esm251986e87.170.2024.10.03.13.06.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 13:06:59 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2fad100dd9fso22302671fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 13:06:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVT+iiOnQTB/YjC5jXtFivDlrPux8whtycDt6g3uSRuRmKWx5H1fQWhSCU3dAyqMU+fhCJTPBRujl9Fv70=@vger.kernel.org
X-Received: by 2002:a05:6512:3d07:b0:52e:fa5f:b6a7 with SMTP id
 2adb3069b0e04-539ab8659c5mr452850e87.13.1727986019089; Thu, 03 Oct 2024
 13:06:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org> <20241001125033.10625-7-johan+linaro@kernel.org>
In-Reply-To: <20241001125033.10625-7-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 3 Oct 2024 13:06:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W9fEQ-g_LWK18SfZq4ZmFN_QbrBCwKRx3BTc0i-UXEcA@mail.gmail.com>
Message-ID: <CAD=FV=W9fEQ-g_LWK18SfZq4ZmFN_QbrBCwKRx3BTc0i-UXEcA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] serial: qcom-geni: drop flip buffer WARN()
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 1, 2024 at 5:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Drop the unnecessary WARN() in case the TTY buffers are ever full in
> favour of a rate limited dev_err() which doesn't kill the machine when
> panic_on_warn is set.
>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 5b6c5388efee..8bc4b240bf59 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -570,9 +570,8 @@ static void handle_rx_uart(struct uart_port *uport, u=
32 bytes, bool drop)
>
>         ret =3D tty_insert_flip_string(tport, port->rx_buf, bytes);
>         if (ret !=3D bytes) {
> -               dev_err(uport->dev, "%s:Unable to push data ret %d_bytes =
%d\n",
> -                               __func__, ret, bytes);
> -               WARN_ON_ONCE(1);
> +               dev_err_ratelimited(uport->dev, "failed to push data (%d =
< %u)\n",
> +                               ret, bytes);

Not that it really matters, but since you're fixing the type of
"bytes" to %u you probably should fix "ret" to %u too, which means
changing the type of it? Officially tty_insert_flip_string returns the
(unsigned) size_t.

As a nit, I'd also say that your error message shouldn't assert "<"
unless you change your "if" test to "<". It seems safer to use !=3D so
IMO the printout should also say "!=3D".

I'd hope you're not hitting this error a lot because it means you're
dropping bytes, but getting rid of the WARN_ON and changing to
ratelimited makes sense to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

