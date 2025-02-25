Return-Path: <linux-kernel+bounces-532535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF69A44EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA613ADAEF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289D820E711;
	Tue, 25 Feb 2025 21:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FusTekW9"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C255320E31F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 21:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740519379; cv=none; b=bofsrfLIaDN9qOaMJg/+iFRJDpURFajw/578FA3tZvnrm6aPu+qXqm3eS19oQK2KbDBWTp5A6c+sz8+aFDAt0gukt/wdIHhsGxkjTWuZ5wlLXQQH3WdGJck94SFWWfQ+2Y+jBizw4NbBg2Xdec886byy1NbQmD5NrDkyf5KDDMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740519379; c=relaxed/simple;
	bh=jsgR1CcpkfBKgCwcL7kNHyDvZ8Ph78Owzp8FKLFEBPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4oJrDVtQ4xXDHjLZaP5OBKRUeLDnrjftaHCQGQzAK6l0rbxtLHmtxftXTfYR0Mz4oqcimaGFnLykpESxsK/VzChxGyKzQtWgqbeA2V6dnEp+jpqmdLkV17MMvJQamsVNY08FdQA+WEIpGhdIcMTAuzK07fFCNuq7QkQL/4UN3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FusTekW9; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-30a2cdb2b98so61583751fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 13:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740519375; x=1741124175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgsKhYzK0ccEnXiVc5xNUD/gNvmfefBesZ2KsZO47bU=;
        b=FusTekW9a8FDaxU2TI2hXZBMD/94OtjS1tqtZZRDZoGZSACh7E7E4OVq9ZIk2CBr18
         Pwb9NKuAOLqeiTHiOCveVeygOr07j/vtyCT6pe0IumUOpuLLS0UiHOtAutK4nTBNd0m1
         /5yY9W9VH5yn4sqG9zgQIcaOtTwhqmo74SxSQqNAA2s+4lWBT8lS3dzDAsxAd9OTDKLs
         tRd/DvfVQ0NNQ4Av7cnRQPh1Ib47yO0oAinSJc7xa/xbgvDl4N+1ULsartSlFDpmw5f2
         5he2mAFY6eS7JX3PlEO/jpBAbbQ4Bl5h2rOsc1tM2X6fs+xo0xzgOdkmKYBVfXu0GZSg
         sM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740519375; x=1741124175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgsKhYzK0ccEnXiVc5xNUD/gNvmfefBesZ2KsZO47bU=;
        b=TL/5zzOMWRnJMJWJhgCsYptcOSoWd7vIR0Rf1O/7YjRqhxEH0UfGtmmspJBthpxLol
         8YqrhoeT0q4J7kk2lmoFiTY17t+9daV7Z9cD2t+2sMzqUl+gebwdAXgbeGzXj7noSyGc
         /3W0qhZ/HhSgvS6xM2zLbbqM6td2u0IVqgS/xvfnoDpoPjIMxsx68BHJfXmJMzKuoU5K
         96Nj0JhKJK+oq0s4gL7zjOM+BYJ91zFgrye1iHPONkILNEqDCtRAv7OKE/uHbjvJVmem
         rRRXnyTU7cFsAyOHDfI4OQwqS+eNnPcuBM5PfaMkWi6Qi/wlxM45A5EvOoYutKecTpRf
         q9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVlRHgB7K75IZMc0gtyeVj6pbFAcCOsd8LO4/G1zfxnIObwBEkaFVebgeCyaRtHdml4Ko0zzbyXWmWSoWo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1UsF9udPJQhrZ11+qKiptzaU8wExOFT9EPClOfbS/N0fh7ju
	IIJvYAvyMaBtHVar6xCYM5m8WhUGhE2nHmWj/G6jLmS1uQSGO8wboDbTj0QmjB/NfCdWMWSycmu
	FszLhpN8M+bGTHDwYmgGu8V++x4VLN7FJqTqQ6u6+TM/F/wlsUxw=
X-Gm-Gg: ASbGncshzKP86udrRpJHqqj/3KkMID4bCmi8BGC1UbpugqyEgeku22WAKoW0jbUDreh
	gQnVr8pch1jXaiyphtvcXsKT++s1Rgv9/u1w8TRujGWTYT740HLqegsnKL6NkFgRFBWlQhvNMv1
	Waz8Rzdq4=
X-Google-Smtp-Source: AGHT+IHtK0GrikirtfWiHMcu4twRuE4bwiVH2TqDeFM1nOp8IzyFh/GRwHs9tMlflIxoYxAaZLfP6DCmyG0toUUaOvE=
X-Received: by 2002:a2e:900e:0:b0:300:3778:4dbb with SMTP id
 38308e7fff4ca-30a5b171675mr69335381fa.1.1740519374778; Tue, 25 Feb 2025
 13:36:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z71qphikHPGB0Yuv@mva-rohm>
In-Reply-To: <Z71qphikHPGB0Yuv@mva-rohm>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 25 Feb 2025 22:36:03 +0100
X-Gm-Features: AWEUYZm9IB8uZx5il-FUDE7JKvkQMqjNNI8CBvjDggXboSfqsX5Hba7CBEVyDck
Message-ID: <CACRpkdYOGeDaDUuQQUGwvFNNk7ZuFjkXSMPXL3BJ=4jGEGPkoQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: Document the 'valid_mask' being internal
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:01=E2=80=AFAM Matti Vaittinen
<mazziesaccount@gmail.com> wrote:

> The valid_mask member of the struct gpio_chip is unconditionally written
> by the GPIO core at driver registration. Current documentation does not
> mention this but just says the valid_mask is used if it's not NULL. This
> lured me to try populating it directly in the GPIO driver probe instead
> of using the init_valid_mask() callback. It took some retries with
> different bitmaps and eventually a bit of code-reading to understand why
> the valid_mask was not obeyed. I could've avoided this trial and error if
> it was mentioned in the documentation.
>
> Help the next developer who decides to directly populate the valid_mask
> in struct gpio_chip by documenting the valid_mask as internal to the
> GPIO core.
>
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>

Ah typical.

>          * If not %NULL, holds bitmask of GPIOs which are valid to be use=
d
> -        * from the chip.
> +        * from the chip. Internal to GPIO core. Chip drivers should popu=
late
> +        * init_valid_mask instead.
>          */
>         unsigned long *valid_mask;

Actually if we want to protect this struct member from being manipulated
outside of gpiolib, we can maybe move it to struct gpio_device in
drivers/gpio/gpiolib.h?

This struct exist for every gpio_chip but is entirely gpiolib-internal.

Then it becomes impossible to do it wrong...

Yours,
Linus Walleij

