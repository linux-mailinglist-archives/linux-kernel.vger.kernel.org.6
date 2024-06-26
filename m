Return-Path: <linux-kernel+bounces-230902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C05DD918398
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F288282AA0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF05184125;
	Wed, 26 Jun 2024 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kWKi6AnJ"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8F41836F7
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719410629; cv=none; b=rJ+FGcMKVPLtyNzPeFqv384Tsh7IUrFIEXk51BJ8u2ieAi8Li/QRq5/cAfFo2OTjCOkOg0sWEGX37S74XKobFhhb1S0+AYS/hZ22hob6zwTZpOZ+7QdMQXoUuOm9pgS1DK7QZhFnXDJigKXBjCObw84lY7RbFaSzis9WPWRHCUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719410629; c=relaxed/simple;
	bh=xs4LLYsfrRzMfpfjWbXCA0eI8gA2aN/e8u81yI8Lugs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgRYYeFC13ALNWQArbIb763aAYt8U7sbR1LjlB8ZwZYfhAy+aCBTCncaQPla0ANa3zfH7XNRF+QSEQlrFHNFgKgA4SszbvRaTZ6WEBYMpBcSc8uStD0iq1teNdju7Fkmw14NovyeHGNeDAfKIeKdrLWX4raksZd/I6FzC1ZhCm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kWKi6AnJ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-24c9f892aeaso3500286fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719410627; x=1720015427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJUHJEXAc+QcqYtg3JPqiGV21t0n+2d3pWybHwk5YPo=;
        b=kWKi6AnJO/LltRyE7J7bOJ1PXfEyCr3HIOM4rmwLES9EyO0OAcgb6sI9nGmcpLof+d
         IV6ClEcRl7/EZePuSJ7sUCu5LyYEiyO/DiGMqBo3vTjcsHXdiz7PL1IesYS2IHSc+n6m
         7MbHrTCAZLPPclrXQLWozIRJpg651KKy6uUx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719410627; x=1720015427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lJUHJEXAc+QcqYtg3JPqiGV21t0n+2d3pWybHwk5YPo=;
        b=uYCmtFUTToiTqw7kn5RJCikzzAEdx0tb3mbEJsFYY96jwWqPpkHZ8ecXSxTW7PAvp4
         AWrkLOzgRYTX7Z9y+j+bBFX0NiB/UXCdBa/s0VQJMyIfxfSSZv67i0SgSrE+BlvsqaB/
         rbfbpTn8t3fYrT1N0XTBEnh8D39xzV0+fdaYzib2qFDpzG8PU6SP2CFpEevyRIFrOuvh
         MnHND9rPg9DpwOaTlRVHw3YKAGV17w+p+JzJeKS949GEXDOF8hit3tMGibuckpB/80lZ
         e5QwBmKr5XdfjGuoE+UT00shuuedbJy2oQlAli7+PCE8f164fRra6iv5s/uc8M0II3bs
         M2Mg==
X-Gm-Message-State: AOJu0YxkM4b9fa4o2AbX4awfVs2VNnI/mUimGld7qx2HmZ+mTk8aDV1a
	IwhushHIKah/FvPSHdSzpHdVavD4k/akEoTTB4WBOg9P9X1m0WpuSRlI4QSi0fr/VhRwM9vI1zF
	t58IU
X-Google-Smtp-Source: AGHT+IHTbCE+YKc9MzWwhqODr0evzKCzAR1tyWfa8iYDy/LP8S5A1aEI6+SD2nSere7H/2ofyynwWA==
X-Received: by 2002:a05:6870:90c1:b0:258:42c1:2523 with SMTP id 586e51a60fabf-25d06c30dcamr7612967fac.18.1719410627095;
        Wed, 26 Jun 2024 07:03:47 -0700 (PDT)
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com. [209.85.160.42])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25cd49d9a2bsm2998952fac.33.2024.06.26.07.03.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 07:03:46 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25957dfd971so3428841fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:03:46 -0700 (PDT)
X-Received: by 2002:a05:6871:58c:b0:254:de02:4c65 with SMTP id
 586e51a60fabf-25d06bc819dmr11469477fac.6.1719410625090; Wed, 26 Jun 2024
 07:03:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610132513.1.I6434acf426183b4077ba3e8af4eccaa5921c6c2f@changeid>
In-Reply-To: <20240610132513.1.I6434acf426183b4077ba3e8af4eccaa5921c6c2f@changeid>
From: Jett Rink <jettrink@chromium.org>
Date: Wed, 26 Jun 2024 08:03:34 -0600
X-Gmail-Original-Message-ID: <CAK+PMK4Vbka3XhbXJHmWJRHD4WVe_k9yvRMw71r+n28Jp5cyvA@mail.gmail.com>
Message-ID: <CAK+PMK4Vbka3XhbXJHmWJRHD4WVe_k9yvRMw71r+n28Jp5cyvA@mail.gmail.com>
Subject: Re: [PATCH] tpm: Add new device/vendor ID 0x50666666
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>, 
	linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I wanted to check the status of this review. Is there something I did
incorrectly?

-Jett

On Mon, Jun 10, 2024 at 1:25=E2=80=AFPM Jett Rink <jettrink@chromium.org> w=
rote:
>
> Accept another DID:VID for the next generation Google TPM. This TPM
> has the same Ti50 firmware and fulfills the same interface.
>
> Signed-off-by: Jett Rink <jettrink@chromium.org>
> ---
>
>  drivers/char/tpm/tpm_tis_i2c_cr50.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm_tis_i2c_cr50.c b/drivers/char/tpm/tpm_t=
is_i2c_cr50.c
> index 86c9a1a43adb..d9b6abdcda5f 100644
> --- a/drivers/char/tpm/tpm_tis_i2c_cr50.c
> +++ b/drivers/char/tpm/tpm_tis_i2c_cr50.c
> @@ -32,7 +32,8 @@
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
> @@ -781,13 +782,17 @@ static int tpm_cr50_i2c_probe(struct i2c_client *cl=
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
> 2.45.2.505.gda0bf45e8d-goog
>

