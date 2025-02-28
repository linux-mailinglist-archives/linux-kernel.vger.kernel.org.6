Return-Path: <linux-kernel+bounces-537943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD5FA492C3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43FB616BA3F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1391D61BC;
	Fri, 28 Feb 2025 08:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E54REf0d"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8383A1CEAC2
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729775; cv=none; b=O8WfX73hfcoHRXJkIHH7tj5HspWfcrRnNJVdrCeALYV/b+eY1A7V68MP47TtS3LWQyigm5ueGAjK4GPjB5KSImQEJZVcNxNnXcruPyFBiB/PmB49EBgoklU1rB2FWxBuyD1QlRoQaVGdtgblc1N1cOFhI46ET8kg/83bXhlSS7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729775; c=relaxed/simple;
	bh=dzID++3XktGDEzV2iNVFJihvJ3tFvaCLWgWAWJvqJCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufu8FwKVCNyhkYTKOmTu5YTGjJqXIPejl7EfmNQBfSyA2KiFj/a/xuonsuowfXkrUxF5pP5CSyC3pBTBoT0OjEHSUtFHrVAvHKdc16if4hzEYiFys+IZOdVU1MdRKodKMIDjxo4+qDOIKJXjbwmfl/ciUyY1LpJDioYLIBq/AE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E54REf0d; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30615661f98so18306651fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 00:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740729771; x=1741334571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qbr0JlJIE4FS91eTAO4EKTfkc1unVkIhWKA7fZvGtG4=;
        b=E54REf0dpvCieS5sjf7Z1vEZFzoxRDS9S6wEzUuPC3V+MimzfR0VcpOYppz5FOz70D
         tO9VElGDi2qnyerfZazPIOLLvVq/d7hgLjPVTHOa68u0nn6YKSqNJGIZ4xhhi2bPNWya
         sLVHQCqU0rQa8puDMwGpMWin6T/QEeFRJhzS9dUkSEcc6OkbrYwwmgzfQxElnpE1SE1V
         Mo8t5hKSCZIO+DErwvs2JUp+gJeUnLl0MhkpM0p8REJHaOLXQO511emp+qDjCVckApOt
         YqLh4dF0nXiqchvAuE5AQDMaiVgHufBoORhTlyyBpX06KH3q+alDQIFo6SFEkr8BnGhJ
         HSzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740729771; x=1741334571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qbr0JlJIE4FS91eTAO4EKTfkc1unVkIhWKA7fZvGtG4=;
        b=lkQ2nvtLxiXk32P65YarCJWmgxIgyMWaBPdGD6w5WcwUQH7WLah51NW9sgJKc3aYx5
         WozILRCIIx7QvM2oGpcDfz/kI/C1dh6B6/LcZznE/ELV/d/I2jhGZvEW+usVn/fghTYu
         +cg4Li4Me41OTYVV40sMKnopuBnE/ZwA5+UJy2N3ZyW1wiPAgbGk9/FH161T0AIF6obq
         GbblVLRtR6kX9r2/VDK/MES4FHAGbQcqlMfmb56HgHeOaefpW/s+c98UezGtcbBnfQ5I
         t1YjVGzOXm2Z4fGOYM9+YXi7WHPAL+xkUQ+ElImzftMKjOmn26JDp6fk92Dqw7RqLQlU
         uYSg==
X-Forwarded-Encrypted: i=1; AJvYcCVLFtiP6Q7Y3piI8jVnjSMIxh9JnVqm1QkSKhWSnvH8j0j4g8BWAPoBiQiwXNRnqhA1bF5PEmmJOUwETMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw90LiEgw9Ec297I9/rtG6qm9wiXhXN/+IHWfvvt9MYsRjt7wVw
	fR2ZxUkZ+5MR0rwQn74n0SQ+K9g8OMbiZ1/SfaSSNTvfDNoa/ArY+IhOvdxv2mlxTMs9/Rw7yuD
	vvDf3Cmo2rBB4ljCoWSuDN/A1A/9O593WbYTA66snfmq6/YVpEr4=
X-Gm-Gg: ASbGnctwKoE/tmeIYJrgkSSIZi0dIZopZAcuXK7GlcRUO12rYFTQPiJ+8ICFy5VLen9
	r6Q1Ju/956/+H9hWTvz+7wYGzjE99L1F3bg23x3D3js6J+UM8kQ43xaywK1wQ5PZCoiLcxVYIZZ
	SY4zELQbM=
X-Google-Smtp-Source: AGHT+IFWOcXiVWcdOW41WFhd6agTYR3FpZBByYOSPhq67IJiAnEdPrPDXHVSJmb/dCVk0/uCVFRJDHBQkVe5M5ZJHDM=
X-Received: by 2002:a05:6512:a8b:b0:545:49d:547a with SMTP id
 2adb3069b0e04-5494c122e84mr972716e87.18.1740729771493; Fri, 28 Feb 2025
 00:02:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224045918.3321394-1-guan.wang.jy@renesas.com> <20250224045918.3321394-2-guan.wang.jy@renesas.com>
In-Reply-To: <20250224045918.3321394-2-guan.wang.jy@renesas.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 28 Feb 2025 09:02:39 +0100
X-Gm-Features: AQ5f1Jqy5qQny_DDgRtOCONi0twJXO_7cwKyXPro4kcz-2ed8U00XvOfzktKY60
Message-ID: <CACRpkdbbXxpOx_uVX6WTWfbqBbXwt2ssvpQDMrmvYSydNaiY8w@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: add reset workaround for partition switch failures
To: Guan Wang <guan.wang.jy@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Avri Altman <avri.altman@wdc.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jens Axboe <axboe@kernel.dk>, guan.wang.jy@renesas.com, 
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:00=E2=80=AFAM Guan Wang <guan.wang.jy@gmail.com> =
wrote:

> Some eMMC devices (e.g., BGSD4R and AIM20F) may enter an unresponsive sta=
te
> after encountering CRC errors during RPMB writes (CMD25). This prevents t=
he
> device from switching back to the main partition via CMD6, blocking furth=
er
> I/O operations.
>
> The root cause is suspected to be a firmware/hardware issue in specific
> eMMC models. A workaround is to perform a hardware reset via mmc_hw_reset=
()
> when the partition switch fails, followed by a retry.
>
> Add a workaround that:
> 1. If initial partition switch fails after rpmb access
> 2. Performs mmc card reset using mmc_hw_reset()
> 3. Retries switching to main partition
> This helps resolve cases where the device becomes unresponsive after
> RPMB operations.
>
> Signed-off-by: Guan Wang <guan.wang.jy@renesas.com>

This looks like a reasonable recovery to me.

However not all hosts support HW reset. You currently have to do
something this:

if ((host->caps & MMC_CAP_HW_RESET) &&
  host->ops->card_hw_reset)
   mmc_hw_reset(card);

Perhaps we should first just move this check into
mmc_hw_reset() so that function can be called unconditionally?

Yours,
Linus Walleij

