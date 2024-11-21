Return-Path: <linux-kernel+bounces-416829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5071F9D4AD2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 11:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038DD1F22E18
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 10:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192AE1D12F9;
	Thu, 21 Nov 2024 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bIPv1WXe"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D991D14E4
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 10:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184619; cv=none; b=t8kIltXc385qdrEMPDlYrOh+BkG73B3EBBZTIItmL0OGXsMr7cH1/Uj5fArKfOMsduO7mxwuejgvy7yiqYtsMkjBdZUcb2j19JoGZC5bjXRIz48ut8kCvN6AvioYKjW0qlBBbdWJUHghuMbEjAmGoMLxW26T6u4CZNNlYL5gBG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184619; c=relaxed/simple;
	bh=JZjwYDJBKRJFO4lziy8AxBRujWgY5Rv6/bIbS/FMRLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Selj+36MQvG50yS2DStt6zSW1cvIkjZj4rlegiosvm/XxJlLSpTFLPtBUFXfm5n6UI5dJctnwz6Emmw8fEzfGRGeuYn6Ibqoy4yLhQVQbJXyNLo7lptzIAbDhAfeUAEV0ZyHnJUmwA65ba0TUo2brINx08OVM3chqqGNj3m21o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bIPv1WXe; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e4b7409fso800116e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1732184615; x=1732789415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuF4C8Vo7Q33KMyUZQtbI45R0OnxEaRQl389TpBxvMI=;
        b=bIPv1WXe4lzU2LuS2TbON6iuTUJk3cmirWdzrteoIihsNGA6n+f4HPSh6ckj1+IEZk
         0qacH6w6ulAkZo4QIuqxcJEpSrMvRAhBLrb8teQwXt/GjDC6uZT/Rxr6K94wkT/EmS+L
         TXWKTsMJBH4sGMRLM4maujeaxdxhIcS0lB1jeMFJGnaI9nzPmxEZzoaDuMU/obgssv8t
         EyAqehkXoXUJa/vMlY4STiVMj5/umn8hNQSjhpYKn4lYKmBP2FQ+w896/5V7gn8KW6qD
         Lv6PLeEjqKB/sv/NaVPpGefGnjvm7433CJ8jaUhf5ZZOkUi+PjA2G6V3662ARn4VuZCG
         Uasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184615; x=1732789415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cuF4C8Vo7Q33KMyUZQtbI45R0OnxEaRQl389TpBxvMI=;
        b=ehW8AuMBPA1eOTuqx1Q+PXe8Te+v7VunlypFbazAQpK7cZ8nIL854wwyqwb1JJIJ0y
         9EuXIZE2I45xaFsPTWujFpVhztb9+5yvj30dPeZzG9txV2g8IQdgr9b34I4d9juhi0qE
         DT7hJmYvauooVBHj74DFAIgoP1Bmz/ouLq1nt/QXiLiU0RAA7zgXpRWJSOM132gEMq/U
         +iVSIAIZUtgz07hsXrKfm4/4cvn+ioiwqEt6KpGtFgbAMkuXYgjK+Lu/pPVBHPPmu9x2
         TQkG2mMfaWrkRS9TZk1x2+4DqGcwQ15HsMRTQPkSEJyN86RBsZrgnrVtZxNGoWfyySDR
         yL8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXAu3oJHgdLsa68TQ/7nHpDJd0/YgLPOwypedNObk7Ke/YAnTvBXaaCjw9J1OQ2ccHpFbSfySCG5S8jQgA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxuic5i67AueI3GE8PMjYEyG1+pIr49XX7S3Wlurs0fp1qRRdPr
	19XmBkXPsPIsrj5yKWIO3YBe/f7WUNprbXezGYI7BfdCj59ZBeLCmb0yICdwFZOLZTfv/X7KSwm
	U6bBSyaGoOA5yE0gfZhKVhJso+GAFj5b37e34IA==
X-Google-Smtp-Source: AGHT+IEQvezapR2N0wMd2aMBPNYkKlAkfP5XVFTsWYRITTRYRYjkBM/237wZCENc/kIbdM6i2py+NT+iT9yg92jUiqQ=
X-Received: by 2002:a05:6512:536:b0:53d:a245:2936 with SMTP id
 2adb3069b0e04-53dc615bc6bmr662188e87.12.1732184615264; Thu, 21 Nov 2024
 02:23:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121094020.3679787-1-wenst@chromium.org>
In-Reply-To: <20241121094020.3679787-1-wenst@chromium.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 21 Nov 2024 11:23:24 +0100
Message-ID: <CAMRc=Mfn1VP_Qvu3gOZ-E4k7ZXt3N5Renb80wmm2=N=xFc6-BQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: Do not assume device node presence
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Klara Modin <klarasmodin@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable+noautosel@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 10:40=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> A PCI device normally does not have a device node, since the bus is
> fully enumerable. Assuming that a device node is presence is likely

s/presence/present/

> bad.
>
> The newly added pwrctl code assumes such and crashes with a NULL
> pointer dereference. Besides that, of_find_device_by_node(NULL)
> is likely going to return some random device.
>
> Reported-by: Klara Modin <klarasmodin@gmail.com>
> Closes: https://lore.kernel.org/linux-pci/a7b8f84d-efa6-490c-8594-84c1de9=
a7031@gmail.com/
> Fixes: cc70852b0962 ("PCI/pwrctl: Ensure that pwrctl drivers are probed b=
efore PCI client drivers")
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Krzysztof Wilczy=C5=84ski <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: stable+noautosel@kernel.org         # Depends on power supply check
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> ---
>  drivers/pci/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 98910bc0fcc4..eca72e0c3b6c 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -405,7 +405,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>          * before PCI client drivers.
>          */
>         pdev =3D of_find_device_by_node(dn);
> -       if (pdev && of_pci_supply_present(dn)) {
> +       if (dn && pdev && of_pci_supply_present(dn)) {
>                 if (!device_link_add(&dev->dev, &pdev->dev,
>                                      DL_FLAG_AUTOREMOVE_CONSUMER))
>                         pci_err(dev, "failed to add device link to power =
control device %s\n",
> --
> 2.47.0.338.g60cca15819-goog
>
>

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

