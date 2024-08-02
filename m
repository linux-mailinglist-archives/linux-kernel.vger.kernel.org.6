Return-Path: <linux-kernel+bounces-272720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9698B94603A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABB628678E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D4F15C158;
	Fri,  2 Aug 2024 15:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BKvudFLM"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C93F13632B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611975; cv=none; b=PPK5xh7YJ3AJC2BXaLYU/FEqLcLhtjWZzVdV+CIiyQPX/dqBaildiyAKVc8tafWazjenIyh1aLUg50VkXWXEBruhiZqCmwKNgtYy+pRYqJAPPYe1Vuov/w2a4omV3YKfBHYsI8bwL6N1tY7XriGSbuf1z9rJqIS1yctVzyo07SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611975; c=relaxed/simple;
	bh=yf3/DcLNflmZVVdGmRQQ3m5ZTvXvQqIBueCI1PWXdwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKctSB3CsaGD1rxSxUVKxyWgsDRY1uhHQjoySr0MZxXLsXX2/WDnlsJt2qoXrYpRx7ZhejrQYW+HQUaRcC9KB8D8an7y2ylgUza2H/l+15usJZIFjVNUTgptDM5nJyCXpWeNImmmVVbcohiAZIddfAW9hHxND2t6rPMvjzlx2uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BKvudFLM; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5d5e97b8a22so3475581eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722611970; x=1723216770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hVQxTJ6XiBlo2K6vivKGyjwtwzsISazu9ikSPPmJl/k=;
        b=BKvudFLMgRl2q3rvuTbFgJvNchsosRZK4tIukjujKRw1dEr89Jz2GO8z9IurlGrvcP
         Wjh5ti/uV11DwSPsTUIGYK5qVo/QekWR6Xhk9lcbuWearkuOEX6HWZgDHlTSIrsdYDah
         xjdBbMymQPfOrplba70BKcxbvLeHMSmEFbKGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722611970; x=1723216770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVQxTJ6XiBlo2K6vivKGyjwtwzsISazu9ikSPPmJl/k=;
        b=Bdf1YzuVgDLl6B3yT8+n5F68NrwoXXxnQaFLov7Ft67ONCd36hrM3P968KXWUeFxVn
         EvJOctIgxvqPukOfTj314lU3DNdwDO1qVbdbgWIgeyRnu/3rtyNIzem02ukiJOBl8JBN
         12ou/HlWz+ktZ/MohNR+GOzw+LUxdZgFCXJVmABfb7xeTvov3ykK/MHvrLvNpYvVyrH1
         Z2fMSYkeP46FEJuWzcdwoHv4D1WtGUIVsES1Ha5y+ZPNc4UTg3KkG9RRMVVNn1/ZwLp3
         oxqcdBJ/jCaTrNNd2Y8fgELCiMIZ+Zjpw4zDrepRFlkeIjN6OcH4OIwZoAfArUltce4r
         T+wQ==
X-Gm-Message-State: AOJu0YzEDXls8wK5dYNXzxtXsqQcs9lF87r5QaYUGD9TQV4qtrzuVnjI
	YsNgSWCD1LgMQOFEf9MN+jTMDNCsCuStZgnaPMTkWqbmoBDBFXzorX4PgsMtawjg5VrY3Kr8B8/
	M9w==
X-Google-Smtp-Source: AGHT+IHL2jlAsEbqYwMwQT8HgaprL9DHe1pQxJYIDyHX7GZR7qpuoWR3yygsSSRnO6x8I0mGVKIDqA==
X-Received: by 2002:a05:6820:1acb:b0:5d5:dca7:b6d5 with SMTP id 006d021491bc7-5d67145aa1cmr4822800eaf.8.1722611970383;
        Fri, 02 Aug 2024 08:19:30 -0700 (PDT)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com. [209.85.160.44])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5d757178a65sm363736eaf.10.2024.08.02.08.19.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Aug 2024 08:19:30 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-260f057aa9bso5250830fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:19:29 -0700 (PDT)
X-Received: by 2002:a05:6870:b025:b0:25e:24b:e65b with SMTP id
 586e51a60fabf-26891f23fc9mr4898926fac.42.1722611968742; Fri, 02 Aug 2024
 08:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718202359.127482-1-jettrink@chromium.org>
In-Reply-To: <20240718202359.127482-1-jettrink@chromium.org>
From: Jett Rink <jettrink@chromium.org>
Date: Fri, 2 Aug 2024 09:19:17 -0600
X-Gmail-Original-Message-ID: <CAK+PMK4yBkqpfJdcQ5M93DKB1-7Wn4zJmx6VmqNghogJJhDa6A@mail.gmail.com>
Message-ID: <CAK+PMK4yBkqpfJdcQ5M93DKB1-7Wn4zJmx6VmqNghogJJhDa6A@mail.gmail.com>
Subject: Re: [PATCH v2] tpm: Add new device/vendor ID 0x50666666
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-security-module@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Could I get some feedback on this patch please? Is there something I
am not doing correctly?

-Jett

On Thu, Jul 18, 2024 at 2:24=E2=80=AFPM Jett Rink <jettrink@chromium.org> w=
rote:
>
> Accept another DID:VID for the next generation Google TPM. This TPM
> has the same Ti50 firmware and fulfills the same interface.
>
> Signed-off-by: Jett Rink <jettrink@chromium.org>
> ---
>
> Changes in v2:
> Patchset 2 applies cleanly
>
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_t=
is_i2c_cr50.c
> index adf22992138e..b50005ccfc5e 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -31,7 +31,8 @@
>  #define TPM_CR50_TIMEOUT_SHORT_MS      2               /* Short timeout =
during transactions */
>  #define TPM_CR50_TIMEOUT_NOIRQ_MS      20              /* Timeout for TP=
M ready without IRQ */
>  #define TPM_CR50_I2C_DID_VID           0x00281ae0L     /* Device and ven=
dor ID reg value */
> -#define TPM_TI50_I2C_DID_VID           0x504a6666L     /* Device and ven=
dor ID reg value */
> +#define TPM_TI50_DT_I2C_DID_VID                0x504a6666L     /* Device=
 and vendor ID reg value */
> +#define TPM_TI50_OT_I2C_DID_VID                0x50666666L     /* Device=
 and vendor ID reg value */
>  #define TPM_CR50_I2C_MAX_RETRIES       3               /* Max retries du=
e to I2C errors */
>  #define TPM_CR50_I2C_RETRY_DELAY_LO    55              /* Min usecs betw=
een retries on I2C */
>  #define TPM_CR50_I2C_RETRY_DELAY_HI    65              /* Max usecs betw=
een retries on I2C */
> @@ -741,14 +742,18 @@ static int tpm_cr50_i2c_probe(struct i2c_client *cl=
ient)
>         }
>
>         vendor =3D le32_to_cpup((__le32 *)buf);
> -       if (vendor !=3D TPM_CR50_I2C_DID_VID && vendor !=3D TPM_TI50_I2C_=
DID_VID) {
> +       if (vendor !=3D TPM_CR50_I2C_DID_VID &&
> +           vendor !=3D TPM_TI50_DT_I2C_DID_VID &&
> +           vendor !=3D TPM_TI50_OT_I2C_DID_VID) {
>                 dev_err(dev, "Vendor ID did not match! ID was %08x\n", ve=
ndor);
>                 tpm_cr50_release_locality(chip, true);
>                 return -ENODEV;
>         }
>
>         dev_info(dev, "%s TPM 2.0 (i2c 0x%02x irq %d id 0x%x)\n",
> -                vendor =3D=3D TPM_TI50_I2C_DID_VID ? "ti50" : "cr50",
> +                vendor =3D=3D TPM_CR50_I2C_DID_VID    ? "cr50" :
> +                vendor =3D=3D TPM_TI50_DT_I2C_DID_VID ? "ti50 DT" :
> +                                                    "ti50 OT",
>                  client->addr, client->irq, vendor >> 16);
>         return tpm_chip_register(chip);
>  }
> --
> 2.45.2.1089.g2a221341d9-goog
>

