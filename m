Return-Path: <linux-kernel+bounces-303663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D206B96133B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E09F283AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03F51C9DF7;
	Tue, 27 Aug 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MdltamPQ"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098011C93AF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724773736; cv=none; b=TbMG6pTzMkBM/CbYR9l1ibX1XIINrbF2aq1b0SLXLcTNjvx4F63RR5+VyukhbSBVE96d2rH2lnoXDPFx/7Zh0USVdOBPo/jIfzLqT1xVOqMzu8ZM6S8ibiew9nGmG1xjIaEpjYduM6MQUNCdxCOSvKLNLZEHSjXfbX5kyvdzeL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724773736; c=relaxed/simple;
	bh=yMIqIqsHc58PbYXTEzoWmcGe7WxkG66Dfoev7TszcS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGnTlHlfuYFQrG+rRKijLSn8Ro+DF4Wavz8c7uFP4xo8pDedgLWrdWrK7LnpZ23MTbFruy9oFEybY7NWNDpczZEsx8ogD+Bj2baS4xmebaph0nZ2OL0CN2a7AXsT+HA3NL94X8e5TGaRDcUL/x+mRK58tu5yiDAjQaMHMREeERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MdltamPQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fee6435a34so38309515ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1724773733; x=1725378533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MyZU/kJprJK+uVidaloko4y85cSY8MDsjFf1FeduaFk=;
        b=MdltamPQciG6RU3dSTnCanxGx2xuSZDcHIE0JQ7fNxJnrpJm5983BtfBWiO0MzihhN
         QxOXlUtBIbKr0ixV43oQmZW5+a8qSLYCpSh5mkObweiE4nyKGhHsy/0G+/eLpAIQbA0D
         F8pjxsgKEI26w0vtowJxpM+g1vS9bfzDLUsf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724773733; x=1725378533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MyZU/kJprJK+uVidaloko4y85cSY8MDsjFf1FeduaFk=;
        b=Fc4fZOUuaio0l16mKbc6VK1xeDK+y5WlM6EVe9t9OKndjIpgywBkkVxJDuMbOq871o
         InQMtmvxwK5BpuumfK3TY2sj7khXzhfis3fVxasGiLh5k0NiuwKwB+GN8hYAQ/5sHRvM
         HEcrUv4+8MCvkDD+kob3y2r757PD00ObIQaqivThMJ1w54AuaQugL7MHtvtVRHX5LPOq
         9u9p9gvDhheVzvIQR7nkkm15b05QBJ+mt1igXQOPXVbRuHZGl5hJa1Y9YXANFQF7x7Ue
         Gu/djz77Kp4d2RyrqQQTyA81mwbivkfoF7WHiMzCvsCS458KX4T5A6RMdwnI58Xzgg9e
         e2xQ==
X-Gm-Message-State: AOJu0Yw7iavLpf+hYeMRwskSWWGmVjOZhuFYghiSJXhtS3+n1iBbFYSt
	8d7pmJENkuOdbSXM+WBXU+gVYLmaJUfZGkoPskPC4fmzLgACW38jTPJIgY5i7+2gIjSs8ude4ok
	VwAnv
X-Google-Smtp-Source: AGHT+IEowDVn9UfpJrS5riFpKSry0Lg8he7yHpNb8advzJXVsGpNhqwfY47efL7GpaM78HGcpeMeUA==
X-Received: by 2002:a17:903:22d1:b0:203:a13a:c49e with SMTP id d9443c01a7336-203a13ac67cmr107560675ad.1.1724773732857;
        Tue, 27 Aug 2024 08:48:52 -0700 (PDT)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com. [209.85.214.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2038557e759sm84384875ad.67.2024.08.27.08.48.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 08:48:52 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20260346ca1so246055ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:48:52 -0700 (PDT)
X-Received: by 2002:a17:902:d4c6:b0:1fa:fe30:8fce with SMTP id
 d9443c01a7336-204e50afb1emr3053325ad.23.1724773730828; Tue, 27 Aug 2024
 08:48:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806165134.1692428-1-jettrink@chromium.org>
In-Reply-To: <20240806165134.1692428-1-jettrink@chromium.org>
From: Jett Rink <jettrink@chromium.org>
Date: Tue, 27 Aug 2024 09:48:39 -0600
X-Gmail-Original-Message-ID: <CAK+PMK62crXQurf1R3vQ=4mtC3pLCKUjA3Vw-qZggcK2ucdrBQ@mail.gmail.com>
Message-ID: <CAK+PMK62crXQurf1R3vQ=4mtC3pLCKUjA3Vw-qZggcK2ucdrBQ@mail.gmail.com>
Subject: Re: [PATCH v5] tpm: Add new device/vendor ID 0x50666666
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-security-module@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I just wanted to follow up to ensure this patch got accepted. Is there
anything else I need to do?

-Jett

On Tue, Aug 6, 2024 at 10:51=E2=80=AFAM Jett Rink <jettrink@chromium.org> w=
rote:
>
> Accept another DID:VID for the next generation Google TPM. This TPM
> has the same Ti50 firmware and fulfills the same interface.
>
> Suggested-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Jett Rink <jettrink@chromium.org>
> ---
>
> Changes in v5:
> Correct Suggested-by tag form.
>
> Changes in v4:
> Add Suggested-by tag. Sorry that I forget.
>
> Changes in v3:
> Refactor ternary operators into helper method.
>
> Changes in v2:
> Patchset 2 applies cleanly
>
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 30 ++++++++++++++++++++++++++---
>  1 file changed, 27 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_t=
is_i2c_cr50.c
> index adf22992138e..1f83cfe2724c 100644
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
> @@ -668,6 +669,27 @@ static const struct of_device_id of_cr50_i2c_match[]=
 =3D {
>  MODULE_DEVICE_TABLE(of, of_cr50_i2c_match);
>  #endif
>
> +/**
> + * tpm_cr50_vid_to_name() - Maps VID to name.
> + * @vendor:    Vendor identifier to map to name
> + *
> + * Return:
> + *     A valid string for the vendor or empty string
> + */
> +static const char *tpm_cr50_vid_to_name(u32 vendor)
> +{
> +       switch (vendor) {
> +       case TPM_CR50_I2C_DID_VID:
> +               return "cr50";
> +       case TPM_TI50_DT_I2C_DID_VID:
> +               return "ti50 DT";
> +       case TPM_TI50_OT_I2C_DID_VID:
> +               return "ti50 OT";
> +       default:
> +               return "";
> +       }
> +}
> +
>  /**
>   * tpm_cr50_i2c_probe() - Driver probe function.
>   * @client:    I2C client information.
> @@ -741,14 +763,16 @@ static int tpm_cr50_i2c_probe(struct i2c_client *cl=
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
> +                tpm_cr50_vid_to_name(vendor),
>                  client->addr, client->irq, vendor >> 16);
>         return tpm_chip_register(chip);
>  }
> --
> 2.46.0.rc2.264.g509ed76dc8-goog
>

