Return-Path: <linux-kernel+bounces-556616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B026A5CC69
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 18:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BFA189EE86
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 17:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B219262815;
	Tue, 11 Mar 2025 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="SxDAMjvo"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928062620F5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714818; cv=none; b=AW8NKz7arskO55Pu6bXqrHo3eQvR7bLl+g/uRpJb5cPmLxf27wQxTFFTTh5ya1WNo42cl+jCfzl9MOoXaTxPndf5pCapnq0cu4QTqmWdIc34YnhYoeXvhhNiP5F+VZ/qjsexNgvPCQs7ON2eMlzIYRwmYz4ZKVT1KwP2KKW3qF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714818; c=relaxed/simple;
	bh=VbYGUSmTNnixdgEmt/1NNCr6xbr4Z7COQFtJxnzbH9g=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7k3Ey9q3tbBuuLPeg4bTq3YNe9kyBnQowM1D/Wl2PAFbW5eihTaNCWbdhDjuLbj+eFjpwRdKL/ZGED+QbXWhomnPVi7rx0uKzUe0sXpEzbt3cquBJrsMk4PlD4xOpnv5VwAd/IJCsI1D81hA9o2cm10LNT216ej+JKKl9+rYtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=SxDAMjvo; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54998f865b8so3700892e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741714814; x=1742319614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IV4A7FjIIXcGVbxkl8zUvb0+9rn4w3FYp8bGnJNScNA=;
        b=SxDAMjvo3WIKUP4bwAwhZtMcxS+0ltgduzeSHZEu0LMcnc96phgqa5ITcGkC7upfQb
         LX0HqTxB+5z9DGFhXzbxWbilu072H+fGguWAURYQFbErdlVvpYkFttWdkYkNuht8ydoB
         CoFIZfYfv2/iwC48Ah2y2cog6hy4iFv4MSZdHWquV56aglqYZ8BmLCv+Hrb2QuFTcecu
         hgPNkG/8I6L1+8wt7P4j95vZQLShH0VLcsFvfqOC1dn2f4wfx0evmsSrqKn0bxgki80M
         xDU2bJA8Yq05dSDtVdg9TTgmF25FWum8eqgQghDKm6j8nPLEoARVmWmGd/BZnPapxP+i
         N5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741714814; x=1742319614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :mime-version:in-reply-to:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IV4A7FjIIXcGVbxkl8zUvb0+9rn4w3FYp8bGnJNScNA=;
        b=d0BgUdNidGa0bi26iLsi2sPjuvg2/h6hddjYxp6EPPMLz/VZlcnlEcAlbI2P1Jyf8A
         Uacq1NWIgzN/RvOMbQklmqp/YgMLzWzPztg7SLAOiz410qdeegzDca9PHHJD9HXTROSb
         oCbZ2SDqC3q/MvV3zK+Woub0/0v99dygFyJdzN7a/MbCqTcNgqlpTAozYXZ00WkfjW5L
         bPs9RfyenrO33HqFpVUBkf2qixt3AKva0xu5yuBHu1z9xu40gZx43omUinh6d/KORFnx
         7E2KwBaFtydUi2ssD8QQjPte43Qr5xQ0Ni86V5nFQixoTPxq3OUKQqIz2m96uip4mt0R
         uapw==
X-Forwarded-Encrypted: i=1; AJvYcCV6x6wzvp36NygodBcXJnMNUGGtu6vZwdAghQWl36fjgw9qO3CDMBB/ZYWFK9zyCy/A3nw01I7hN60eLlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQ6fiR+FcaZd2eSxMeHqDrjvIm+LgbpTesX7oIqNMmYYDdpiKs
	7/K9sowC5xPhl5EiQHoh+5S4oOedpwFgakQilGmARci7VsKBJtvSrz6+VIty0HY5IZ9GJeqlVXm
	Ci9t77KIYzaO/UwJWu3UP6ecQkxZO8RQD87cD6g==
X-Gm-Gg: ASbGncveHCS+lIFuBc7IQljpE6dLRF+cdzsPilN0tM3QjBywDue/bsZ2urn0KQ5tckX
	lIuA+lRCguoaaohSiBPfMk+HyusCNxvNj9FmZACRkNMX3EDwTaRNURMRr+D1Fh1wU3sSw2qykUW
	u7CW5/xt5IMqvhWsKmhGpq0GOEOyEsosIty8rhAK8dmefXzHXJSewxWJV+
X-Google-Smtp-Source: AGHT+IEuvtQ2Aa8ui5v8Z4Q9x/5NwyFYRVsfRfQLj8JoCxwI4zy1ZLtoE1lE4K+gMizXriyAcSjBDingm7foPZ8Yzks=
X-Received: by 2002:a05:6512:2342:b0:545:1d96:d702 with SMTP id
 2adb3069b0e04-54990ec5d23mr6740859e87.48.1741714814422; Tue, 11 Mar 2025
 10:40:14 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Mar 2025 10:40:13 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 11 Mar 2025 10:40:13 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <1d8bf01be50646bb7b36abfc1ecb25eb997598dd.camel@sapience.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <579283e5c832d77aeed531e8680961c815557613.camel@sapience.com> <1d8bf01be50646bb7b36abfc1ecb25eb997598dd.camel@sapience.com>
Date: Tue, 11 Mar 2025 10:40:13 -0700
X-Gm-Features: AQ5f1JpW6vLa2FpoSUhjiNksic-uLUOCauiwaR_RX--eqjWOKs7E6VFVS8y4a1c
Message-ID: <CAMRc=Mc6Tn9CZJA6EN_a0i=hiiz6jTr9oYLHdJ8iyrtsw+LmZw@mail.gmail.com>
Subject: Re: rc4 and later log message: gpiochip_add_data_with_key:
 get_direction failed
To: Genes Lists <lists@sapience.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 11 Mar 2025 15:03:59 +0100, Genes Lists <lists@sapience.com> said:
> On Sat, 2025-03-08 at 15:45 -0500, Genes Lists wrote:
>> ...
>>
>> there are now 194 lines logged on boot with:
>>
>> =C2=A0gpio gpiochip0: gpiochip_add_data_with_key: get_direction failed: =
-
>> 22
>>
>
>
> For completeness - same log noise with rc5 and through commit
> 4d872d51bc9d7b899c1f61534e3dbde72613f627.
>
>
> --
> Gene
>
>

Hi Gene!

There are two problems here. The issue you're seeing is fixed in next but
not in mainline due to my omission. I will send a patch for that.

On the other hand, the pinctrl driver in question should be fixed too.
Can you try the following change:

diff --git a/drivers/pinctrl/intel/pinctrl-intel.c
b/drivers/pinctrl/intel/pinctrl-intel.c
index d889c7c878e2..0c6925b53d9f 100644
--- a/drivers/pinctrl/intel/pinctrl-intel.c
+++ b/drivers/pinctrl/intel/pinctrl-intel.c
@@ -1068,7 +1068,11 @@ static int intel_gpio_get_direction(struct
gpio_chip *chip, unsigned int offset)

        pin =3D intel_gpio_to_pin(pctrl, offset, NULL, NULL);
        if (pin < 0)
-               return -EINVAL;
+               /*
+                * For pins configured to functions other than GPIO, defaul=
t
+                * to the safe INPUT value.
+                */
+               return GPIO_LINE_DIRECTION_IN;

        reg =3D intel_get_padcfg(pctrl, pin, PADCFG0);
        if (!reg)

?

FYI: This was uncovered by commit 9d846b1aebbe ("gpiolib: check the
return value of gpio_chip::get_direction()").

Bart

