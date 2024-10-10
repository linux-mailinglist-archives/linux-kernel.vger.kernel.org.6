Return-Path: <linux-kernel+bounces-360161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AEDEB99954C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D09B71C21870
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400891E8851;
	Thu, 10 Oct 2024 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CrC4/ZJK"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1F71E572F
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 22:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599819; cv=none; b=Qdu9EJOMCVJ9O7c87xKYLpbNZxQ+Qnyl5uxufJmmlJgovMoRx2J3DegkxRJj957/Vp4gPaEJa3j/pAgz7EfMFEG2ohLfHaItR6sJ0CwB0hnzWU5sjn5SCV/wwFcDhbDmp7iji8nhaJ5z2o0OGJh1mpUwfCAHusjdlVVms31TS20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599819; c=relaxed/simple;
	bh=Oxl2smtTASJ6MycM3FoVyfEsgbMMCGZ1Gfzk4oNcX8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFBY8+CVrPxOhxRMmWbFoWdeA7WIo+51Db6CcuLegs9bzD+j6dqX/tNTu36AT5zxWKSL2aHetz6GM5cN1dCM0UuU8VxgGS5CbT9tZDFYV4pvb54MigEXKvSerjJEi5KODbMLof08qTZlQPIY1hc8lm8HXchS8yFzC3rYJO92o8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CrC4/ZJK; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2facf40737eso15816761fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728599814; x=1729204614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjeDbIjsUK09P9siScyxEtPwzKzblEFE3ZJjqNhSVcQ=;
        b=CrC4/ZJK/XRWlvSVjGUOjlnjIiNfYEIiBTWSO0nUFsTA92R/R38QoZ+lQp8yc9RWhU
         mNwNemzpfbJsUER9ohdpJyFvdyS3aZcXYgRtlN4dfNg4AXN1IEQGkBO2qATTgfUKFXPJ
         LHoe/ghN9kxHqBvpxDB4cS2e8c6hcCXphzfhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728599814; x=1729204614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VjeDbIjsUK09P9siScyxEtPwzKzblEFE3ZJjqNhSVcQ=;
        b=YEQRMkbEMkzKJFFXZ2+SNZEhLbY4PakhGVj25jIgrdQrMQqkPI+gWkNegV6b6ZeyJU
         YEJ9U0oqEB9P8gYss5Y87whElqNeYl6jaEBV4Sg6kvrIwzVe1zYi+XPSAsTCqic0Bl8h
         b5j0DkIaz77WL67YNHjqhZaxLEWHqY1BZO6VltpB06c7OewC+8Gg3C036kDhAVhhqNAP
         nL1mANUoPAtDM7iQ8caErbibu0HuRSqwQc9yHyM4cTrQCbYRShr2TLGcSuBk5eXS1tsJ
         kuvT7ZByqKU3XSpPC7+4CxGATTJ8xkq/dZPc4L7oNRPhIquqQPeVnC9bs81+aD/sqr5c
         gwXw==
X-Forwarded-Encrypted: i=1; AJvYcCXn8AVi3jb6BLjgSCL001LDFIlFqFLWiDcqvcJIUWlF6VBydqhyfwU3S3xWSgS7h6Y5UcaeM2jChuLX1J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUEpPGqUrnuy0yALHX7wn0lUODjDrcXQMIMDiStVwObA1UwOvf
	5vnuBOxAAPvLo9eibew6uZSqz0E1wNVs4mugT1WTM0LkSobajBmw8Xn899Vt3ycSzjbhCAG7BSc
	PTi40
X-Google-Smtp-Source: AGHT+IFdxuIEGS+d3/KOCCY6WrfdVcTa5fQgVB6I7O/81pS8AtKoFV++UAVdvGhRVGt53mOSXSkBdQ==
X-Received: by 2002:a05:651c:554:b0:2fa:d4ef:f222 with SMTP id 38308e7fff4ca-2fb329e7a91mr1587041fa.38.1728599814045;
        Thu, 10 Oct 2024 15:36:54 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2fb24706440sm3386361fa.82.2024.10.10.15.36.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:36:50 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2facf40737eso15815961fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:36:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXdpLPzKmiqNwtj7y8EzfjqdUu/nFbyg7s6OAeWPSd/av2+jx8YtMsd2Mc9C3wta7OpsroLCQbqqC7Jy2k=@vger.kernel.org
X-Received: by 2002:a05:6512:ad4:b0:539:8bc6:694a with SMTP id
 2adb3069b0e04-539da55f2c2mr163074e87.43.1728599809960; Thu, 10 Oct 2024
 15:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009145110.16847-1-johan+linaro@kernel.org> <20241009145110.16847-6-johan+linaro@kernel.org>
In-Reply-To: <20241009145110.16847-6-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 10 Oct 2024 15:36:35 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ue8MRvb4h5f0ijRRNORXCrypSbpaNWZdv5S3C2kmYp3g@mail.gmail.com>
Message-ID: <CAD=FV=Ue8MRvb4h5f0ijRRNORXCrypSbpaNWZdv5S3C2kmYp3g@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] serial: qcom-geni: fix receiver enable
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 9, 2024 at 7:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> The receiver is supposed to be enabled in the startup() callback and not
> in set_termios() which is called also during console setup.
>
> This specifically avoids accepting input before the port has been opened
> (and interrupts enabled), something which can also break the GENI
> firmware (cancel fails and after abort, the "stale" counter handling
> appears to be broken so that later input is not processed until twelve
> chars have been received).
>
> There also does not appear to be any need to keep the receiver disabled
> while updating the port settings.
>
> Since commit 6f3c3cafb115 ("serial: qcom-geni: disable interrupts during
> console writes") the calls to manipulate the secondary interrupts, which
> were done without holding the port lock, can also lead to the receiver
> being left disabled when set_termios() races with the console code (e.g.
> when init opens the tty during boot). This can manifest itself as a
> serial getty not accepting input.
>
> The calls to stop and start rx in set_termios() can similarly race with
> DMA completion and, for example, cause the DMA buffer to be unmapped
> twice or the mapping to be leaked.
>
> Fix this by only enabling the receiver during startup and while holding
> the port lock to avoid racing with the console code.
>
> Fixes: 6f3c3cafb115 ("serial: qcom-geni: disable interrupts during consol=
e writes")
> Fixes: 2aaa43c70778 ("tty: serial: qcom-geni-serial: add support for seri=
al engine DMA")
> Fixes: c4f528795d1a ("tty: serial: msm_geni_serial: Add serial driver sup=
port for GENI based QUP")
> Cc: stable@vger.kernel.org      # 6.3
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

