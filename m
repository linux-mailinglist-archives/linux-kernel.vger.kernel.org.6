Return-Path: <linux-kernel+bounces-227889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7ED9157BC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247C428459E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 20:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBD01A0701;
	Mon, 24 Jun 2024 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOWP5kOq"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111624502F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 20:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719260264; cv=none; b=TSks9T0ZuiFlVkTecZFz0OV2col3q3ItGefWZLygO+E3QLrbmh/stUIbOQ2W+sDtx6mn3YAT1vV4Ns4oaDCefJpGBqeRLB6ZAtirhBnwuQkOdasUhKRVsu/J14DW2mdnSo/P3RasiYmjilWqqkInJMO9K9RgWHXFFfyrKAfSVZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719260264; c=relaxed/simple;
	bh=Yc0HYaCiNVMqpQ+E+6XkUsX4wkKct1WvUV3hbKWz77M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QkMsZ50uQ38dlEfLNXrF1eKBXGpc6y6mzRm64Mdb/0YMoFgobDG2VRwcYVflaMbGo/EyLb8CWVGZsWbg6cm2y9iIEQYq75sUeiBroPyPECpwP07Ftj2JEfOi2rI1nNoiXRGY1WrpByumv/p5f9zC4TRro+OS/pVvBwFeCYFIpLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WOWP5kOq; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-63036fa87dbso38386487b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 13:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719260261; x=1719865061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E/G7vqge8/AMhNlJ+tOTijQCXPd5V7TRQ0r6Jxcr8oI=;
        b=WOWP5kOqlWJaGjat7jNIjT5kOF9xp2th2iiD6UvWqsmgONVCUbK8gMKAhB9+olTC9x
         Ng0oLBXjRZODJ2KN+ugbgDQ4Qum5Amsh33dZDhZsFg9E6RE3R4u2RIF3OCYuwNppDOsx
         nZE2Bfyk53qJr0rQ3ATrBrMpUit4LNDw8OhYGBS1AZ8xXp3NuYYkeabDx231vYULPcVZ
         Mkvgwfx9V1/2QqUWj2K+IriLJeUuGSswmgk6+OZ2rHWm0VMoQjjmnn52RjG/xf4QS5pO
         NYXXmVXWEg5E0MYv3DybF/ZSQUJew3f1t0hlcoC6oJ7f7KFL45jg2tL+ipMvJF9OpQSv
         fi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719260261; x=1719865061;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/G7vqge8/AMhNlJ+tOTijQCXPd5V7TRQ0r6Jxcr8oI=;
        b=qQ5YLpntfEpc4RyCdAL/YFbwMFF/Uii8oMJv/WRYrQdkN+jS/TG+hE90CDHBivu/6P
         Sl0zaDbV5sLR2L3g+/HxRbsL+j66Hl/EIbBLCxmy6M32ZyZnrqRub6BkaXMhWYjoyCxI
         6pABEor4EVf7Hi1sxDu3XdqZPNXVnZ5m3fzrF7+Ru0e8JM6qRujjVbS41bwXjXLbVMAN
         u+/4zZlr9UCWlD05TJ1WcHvr/cKTGwBdsp2iQMmcSKid6JZ6GgGeeRHQsH8YGgndgSMu
         Y73362eY2S8mcs+VQdKJN/3CkhVTdnxWjNNYNzsO3sSKieOZn+o6fuudKgykcaR/8gWy
         r+xA==
X-Forwarded-Encrypted: i=1; AJvYcCUmhS/09EQwvkfA3E88+B4GWAwFdx5j2EJIP/ru1ES8mcc0+USX/U3RWi/ogKgoc1wXDEUTzuI1SMQgwEx6eKqXDecknrCAefRADdJQ
X-Gm-Message-State: AOJu0Yx9YNOEAg9b80lVdqvAXFopzYI0h7GQcmEiFBKxgAjp+WFQZRPd
	mas4uaMITRZcF7/9StgJJxeVQ/F8g/utiVwzusLdAt1EiAopPSRVhdQN1sx+iEoimtqsBtm6q4W
	NdSHH4yEvio2yONZVJIHoDFAZno9UNoC4gnDZkNio0KARwDULk8w=
X-Google-Smtp-Source: AGHT+IG60q8kebyIquS1qrxnUyo32rJmM/jOykbnuXCsnoil1c5UFnlPtVw2q6vrSdcKIQkw08GtbNTmSFWTBh9fPvM=
X-Received: by 2002:a81:a7c9:0:b0:62f:60db:326 with SMTP id
 00721157ae682-6424bd69f63mr37708397b3.20.1719260261020; Mon, 24 Jun 2024
 13:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624194518.37458-1-brgl@bgdev.pl>
In-Reply-To: <20240624194518.37458-1-brgl@bgdev.pl>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 24 Jun 2024 23:17:29 +0300
Message-ID: <CAA8EJppMPeYrPH+ssDMnf6UwHRdKQetpY3PotGvR-cc2vE68AQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: don't disable power management for QCA6390
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Jun 2024 at 22:45, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> We unnecessarily fallthrough the case for QCA6390 when initializing the
> device and hit the condition where - due to the lack of the enable-gpio
> - we disable power management despite using the power sequencer. We don't
> need to look for clocks on this model so it makes more sense to just
> register the hci device and break the switch.
>
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Fixes: 4029dba6b6f1 ("Bluetooth: qca: use the power sequencer for QCA6390")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Is this going to break the QCA6390 as present on M.2 / PCIe cards? Or
the older DT which didn't have pwrseq entries?

> ---
>  drivers/bluetooth/hci_qca.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 2b31f3dc33a9..bc6a49ba26f9 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2402,7 +2402,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>                                                            "bluetooth");
>                 if (IS_ERR(qcadev->bt_power->pwrseq))
>                         return PTR_ERR(qcadev->bt_power->pwrseq);
> -               fallthrough;
> +
> +               err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
> +               if (err) {
> +                       BT_ERR("qca6390 serdev registration failed");
> +                       return err;
> +               }
> +               break;
>
>         default:
>                 qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
> --
> 2.43.0
>


-- 
With best wishes
Dmitry

