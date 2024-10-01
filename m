Return-Path: <linux-kernel+bounces-345993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F12E98BDF8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 15:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0CE21C217AE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C7F1C4622;
	Tue,  1 Oct 2024 13:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="dOX5FxJO"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D6F1EA87
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 13:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727789834; cv=none; b=ox+Lkw3Pc9srO9/fNJjTaL242fYO+t6u2EdoctqIhuLlISNEEUjFU4Y7G45LgWOvZ7GTK38s8kSo797qT7C80FMcxI+JDedOpc/39ybKZZ587Fp2mB093+cBInzU0I7EYwilUp1ADjLdprqCDAC9YahyBWVTLfw0iN5MIip5dKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727789834; c=relaxed/simple;
	bh=l5Wzld97pvTNqpuXXv77vHPpekFjUq/zFH05krcoJrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1hHeZyZcYWU0tfSFq9zdDs0tq35rzCPmSW89m5SQ9JDPescGwhTzPoMem1o4KT4fWkG7UTQlkh0SX5NmV6GEqkWN3Yv6YloDAmnwASt2l4P2NJrO9fcH0/WJY58uKp7rapwodXOHCAsg/j+Cc3MhLV1/rN0Fz6meI94HoauBV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=dOX5FxJO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5398b589032so4872350e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 06:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727789829; x=1728394629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BxySFYjgMYSgGj7gZxM0J6yslTcBL+xxt/8bGUkQxc=;
        b=dOX5FxJOnCOn4nCC/bKaZrwyU0qIsJRnJuNlySfTC1t6Xdq4icBRJkVK0JrtpHSjMt
         /WH23JaKVzS0cIBj1lG1hf1ovKU9nFLDwWH4m/j9vfI9rvDj2dP0zo+BbhOhCMw9vYkW
         rOgTRvpveUSDMUjV3VjZJBfG2IQIBPjaKhllScKc4+M72n3nCmglvOgugxeD7kNO1Hsx
         8VhxQgSLtsHALAuaKe4C0re7uYYN9OMUqTdWQIF2vC1BRHmhJbc0Tfu6v1S3Fw4RYtfB
         Ta4NwODnK5I7qxEFmMir7e9UG6Y60ZeP64nWj+s8teC+iB8QTTmVzmG38vRWZ0yCQQMV
         /iCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727789829; x=1728394629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2BxySFYjgMYSgGj7gZxM0J6yslTcBL+xxt/8bGUkQxc=;
        b=HtZ0RHLcqn9cw1u5VnIzBMj8RqYtxLh/HxXoow9/ZfrILiBPVKHqawu/J9k+uqlTs9
         +ijaqIT1Ep2Wt57+rrYPqxTIwB0Qr+EuqJRlqxKd5k1K7lQZEk3uE+ehb0Pd7cQJ+VRt
         Ws8NzymcoMdXAIFJOgNWjX1l1+V0CfqDzxhirC5pAtRbHEf/iwJcJbNcT2gdr+G896cE
         euelrPJGJCO+YNWbMt+EUB0gVdS0PdjQNkjTO4oqpOy2Ym18MvpljwzBNH0HiQ9SgbAN
         Nf+tuLUmZahNrEGikj9HCWsyD5PMdwsOldk6arZSfh87Q6YG0da/IwkEA982pmvBNVe1
         6cyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmywJTRiBJauxrBk4CurG0vK8NrKOc/o0jJBssCkfcSg3ZgQ89hA3apMeD174Gvxr79U17CyessV6Bdwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbfqL4+0iMs9MF3gvvXmPAZfyTRWMNbiASJfLMPAd39dwBw/Su
	1gW50bVAePREuAbhyf7e2JP5x+2twdyQcOCkBxTRyZX4BAnIILKG1KwV5mY6tl3pdADG/86sAGT
	DHbT94U5U6eOTIY5w0dKMIh1wkZ9fFd1hFTVxgA==
X-Google-Smtp-Source: AGHT+IG4QsZVp3c0GwViYHKYsqg+Yr9QOSGNd6d8be6G5dnaCzY4j5yVeg2oaXaLBwwed7H3SV9IsGiP8nhynNtnFfU=
X-Received: by 2002:a05:6512:39c6:b0:539:94f5:bf with SMTP id
 2adb3069b0e04-53994f50221mr6566227e87.59.1727789829000; Tue, 01 Oct 2024
 06:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001125033.10625-1-johan+linaro@kernel.org> <20241001125033.10625-3-johan+linaro@kernel.org>
In-Reply-To: <20241001125033.10625-3-johan+linaro@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 1 Oct 2024 15:36:57 +0200
Message-ID: <CAMRc=MeYSsh+MOrOHSabiHuyGOrZK330WuNXcGDtg-siJFya=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] serial: qcom-geni: fix shutdown race
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 2:51=E2=80=AFPM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> A commit adding back the stopping of tx on port shutdown failed to add
> back the locking which had also been removed by commit e83766334f96
> ("tty: serial: qcom_geni_serial: No need to stop tx/rx on UART
> shutdown").
>
> Holding the port lock is needed to serialise against the console code,
> which may update the interrupt enable register and access the port
> state.
>
> Fixes: d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in p=
rogress at shutdown")
> Fixes: 947cc4ecc06c ("serial: qcom-geni: fix soft lockup on sw flow contr=
ol and suspend")
> Cc: stable@vger.kernel.org      # 6.3
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/q=
com_geni_serial.c
> index 9ea6bd09e665..b6a8729cee6d 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -1096,10 +1096,12 @@ static void qcom_geni_serial_shutdown(struct uart=
_port *uport)
>  {
>         disable_irq(uport->irq);
>
> +       uart_port_lock_irq(uport);
>         qcom_geni_serial_stop_tx(uport);
>         qcom_geni_serial_stop_rx(uport);
>
>         qcom_geni_serial_cancel_tx_cmd(uport);
> +       uart_port_unlock_irq(uport);
>  }
>
>  static void qcom_geni_serial_flush_buffer(struct uart_port *uport)
> --
> 2.45.2
>
>

I already reviewed this[1]. I suggest using b4 for automated tag pickup.

Bart

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[1] https://lore.kernel.org/all/CAMRc=3DMd-B3MCdjBA6Z03Tn09Qdq_O=3D2Gij=3D0=
kr8HiLtpp11kVg@mail.gmail.com/#t

