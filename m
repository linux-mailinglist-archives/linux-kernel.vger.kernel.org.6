Return-Path: <linux-kernel+bounces-511407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DC4A32AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 16:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EA0D3A79CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024F7263C65;
	Wed, 12 Feb 2025 15:48:04 +0000 (UTC)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD63261391
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739375283; cv=none; b=OGk3AMxriUtElo1bYqxDbtAWhPv1YnNQdvCUGqXHHYzeUzKdAOsAgr8jqjgWVAnfIyYZ38TAqQWba7Zrji4aUUp0qlAedenflSTgETC/nJO/qfJ2DKZ6K+V4ZhVw3Zyyng5Mgx7nq5mDD3hDpZZ3BcUF5Co9jIUokpgo/n3G7Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739375283; c=relaxed/simple;
	bh=iMwraRPqoGZXPSV/ZIi013g4oSfQKmUsDk4bVEfeeAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ubu1ZtSlSw9p5qMYTNBMP5Mab23w3QrvadeHitRBF7d7QKO0IxLsYfA8S637rvIfyeEA2kB4jSL8XpmKG7H8CU0GZ11Jh789dwA2/cjS1+yUS7r0p7rYJ7VFxxVqyeA8wR6VtmOZxTeF2IDoOkSrIdrwF4jvwck2zq3MuZ9rfBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gompa.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5deb956aa5eso651264a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:48:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739375279; x=1739980079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+uYrRumV9nMSUYKKSpYn+3g5k4eAh93TeT+WqPiVakU=;
        b=YIrchr+FWM9PioNkCt2MEdZfhCyWqx7dPCOJpMfGyHeGf7h7wkFpb5Se0+1fbgRgc8
         zixHzWY9TJz5qU7zoaphcHL3nHLhT2eMsQmvl6o9y0mOAp+LRHu0sZ9p8/f5Fj5oHbES
         hiKEJfTrUlnzRfVCC/q0DgnEc1w+e3/4CKH4dyPZ8yRxElr6+zo1AQCvdQv67h0dC0Ok
         NdBnNKiBgjwzV2u6oVEo2R/sumnNkAnf6QlaVP5md9Sc0vU2LK8t+8wPjCDdfxYmA3fT
         qq+KtNPt7TCPDa+kutig9E5nk0CijgjH7IGmvj3yG1MRPm/H1nYQrA7nKquDQldTMa/o
         BZBw==
X-Forwarded-Encrypted: i=1; AJvYcCU2zV9FTjLUx6vt0wxR6L2vfP8W+FBlEsremap1zN2PAdET1CqB0WyrvAZfWo0ILyJgnNQHvdaEVinmubw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqxAHAiGuWQ2l/xhpBuVc+iXLqwmY2JFmI6H9m05/iNBoCnOmA
	eZX/OamOUmcxeOvTVnHIbt4SfxU7IIgMYulX5nukg+k9s8bl0kELWVwKyjhUFXs=
X-Gm-Gg: ASbGncuEG+/Qm4I+hQe/0YUUIguac4zU0xHzOnGDW9CuldF7fdGvyxgxY5fJ5825h9E
	9Z6OXjbPB1z2AC+RvjSJ3ERGGRvlhFpjM1AhKJkmSewgGsLQtntaUugv/lRbnja7LIyAT8+09kS
	qXAG6ujZd1pRze1BhX6wjnOO57g8bSlIy1OflptGZO+0tz/qYoHdvt/fnQdBFTnDK3vVqhRPhY2
	qubf+h2VBcgCq/g2iz1Tt7aGNkoSTtISTcM8YQ+N/gS62OXXu8HABAAmEpI18kcS2rPuI9bb1gs
	3T+5pCYn8fUhBkJXd4hm/wWE2NhQNcmaDrd2R+4sCf6zOw==
X-Google-Smtp-Source: AGHT+IFmce9tH9dLHP7CWUzbmv5vtbnb++XIvWnNQ8LorV9Zr/rB7MFtIoTaUTNXrBFSD71XPDaB8w==
X-Received: by 2002:a05:6402:a001:b0:5de:b438:1fdb with SMTP id 4fb4d7f45d1cf-5deb43821eamr3515430a12.30.1739375278693;
        Wed, 12 Feb 2025 07:47:58 -0800 (PST)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7891ec1d1sm1172552566b.178.2025.02.12.07.47.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2025 07:47:58 -0800 (PST)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-38de1a5f039so2783031f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 07:47:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX+J4vc4iMo+c5ulQu6stditLCA+uperIxaEccDGUAKsWXlt7YcZz/iVmhH8X8mYkrhh4JKA3OLGhH8GFg=@vger.kernel.org
X-Received: by 2002:a5d:588c:0:b0:38a:2b39:9205 with SMTP id
 ffacd0b85a97d-38dea2878bfmr3997807f8f.33.1739375277843; Wed, 12 Feb 2025
 07:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250211-rtkit-more-logging-v1-1-93334e9c1c77@rosenzweig.io>
In-Reply-To: <20250211-rtkit-more-logging-v1-1-93334e9c1c77@rosenzweig.io>
From: Neal Gompa <neal@gompa.dev>
Date: Wed, 12 Feb 2025 10:47:21 -0500
X-Gmail-Original-Message-ID: <CAEg-Je_XadeDiXBeXckZ=UQ2wYHtGppdM3nPmardyYx7SBgCrg@mail.gmail.com>
X-Gm-Features: AWEUYZloTNjia8wdzYJXwYEgocjhTE4bAY0UXN52FPIm83DaokT5Zoy8sOwb2VQ
Message-ID: <CAEg-Je_XadeDiXBeXckZ=UQ2wYHtGppdM3nPmardyYx7SBgCrg@mail.gmail.com>
Subject: Re: [PATCH] soc: apple: rtkit: Check & log more failures
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc: Sven Peter <sven@svenpeter.dev>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Asahi Lina <lina@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 1:00=E2=80=AFPM Alyssa Rosenzweig <alyssa@rosenzwei=
g.io> wrote:
>
> From: Asahi Lina <lina@asahilina.net>
>
> Check and log the following failures:
>
> * regular messages
> * management messages
> * failed buffer requests
>
> This helps debugging.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> ---
> Originally multiple commits by Asahi Lina, squashed here and
> checkpatch.pl warn fixed.
> ---
>  drivers/soc/apple/rtkit.c | 44 ++++++++++++++++++++++++++++++++++-------=
---
>  1 file changed, 34 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/soc/apple/rtkit.c b/drivers/soc/apple/rtkit.c
> index e6d940292c9fbdfc4cd42020e89aca2662c5cdce..f8077a1ec3a42265eb9565a0e=
a1ca6a4cf7e79dc 100644
> --- a/drivers/soc/apple/rtkit.c
> +++ b/drivers/soc/apple/rtkit.c
> @@ -97,12 +97,19 @@ bool apple_rtkit_is_crashed(struct apple_rtkit *rtk)
>  }
>  EXPORT_SYMBOL_GPL(apple_rtkit_is_crashed);
>
> -static void apple_rtkit_management_send(struct apple_rtkit *rtk, u8 type=
,
> +static int apple_rtkit_management_send(struct apple_rtkit *rtk, u8 type,
>                                         u64 msg)
>  {
> +       int ret;
> +
>         msg &=3D ~APPLE_RTKIT_MGMT_TYPE;
>         msg |=3D FIELD_PREP(APPLE_RTKIT_MGMT_TYPE, type);
> -       apple_rtkit_send_message(rtk, APPLE_RTKIT_EP_MGMT, msg, NULL, fal=
se);
> +       ret =3D apple_rtkit_send_message(rtk, APPLE_RTKIT_EP_MGMT, msg, N=
ULL, false);
> +
> +       if (ret)
> +               dev_err(rtk->dev, "RTKit: Failed to send management messa=
ge: %d\n", ret);
> +
> +       return ret;
>  }
>
>  static void apple_rtkit_management_rx_hello(struct apple_rtkit *rtk, u64=
 msg)
> @@ -295,6 +302,9 @@ static int apple_rtkit_common_rx_get_buffer(struct ap=
ple_rtkit *rtk,
>         return 0;
>
>  error:
> +       dev_err(rtk->dev, "RTKit: failed buffer request for 0x%zx bytes (=
%d)\n",
> +               buffer->size, err);
> +
>         buffer->buffer =3D NULL;
>         buffer->iomem =3D NULL;
>         buffer->iova =3D 0;
> @@ -588,11 +598,18 @@ int apple_rtkit_send_message(struct apple_rtkit *rt=
k, u8 ep, u64 message,
>                 .msg1 =3D ep,
>         };
>
> -       if (rtk->crashed)
> +       if (rtk->crashed) {
> +               dev_warn(rtk->dev,
> +                        "RTKit: Device is crashed, cannot send message\n=
");
>                 return -EINVAL;
> +       }
> +
>         if (ep >=3D APPLE_RTKIT_APP_ENDPOINT_START &&
> -           !apple_rtkit_is_running(rtk))
> +           !apple_rtkit_is_running(rtk)) {
> +               dev_warn(rtk->dev,
> +                        "RTKit: Endpoint 0x%02x is not running, cannot s=
end message\n", ep);
>                 return -EINVAL;
> +       }
>
>         /*
>          * The message will be sent with a MMIO write. We need the barrie=
r
> @@ -742,8 +759,10 @@ static int apple_rtkit_set_ap_power_state(struct app=
le_rtkit *rtk,
>         reinit_completion(&rtk->ap_pwr_ack_completion);
>
>         msg =3D FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, state);
> -       apple_rtkit_management_send(rtk, APPLE_RTKIT_MGMT_SET_AP_PWR_STAT=
E,
> -                                   msg);
> +       ret =3D apple_rtkit_management_send(rtk, APPLE_RTKIT_MGMT_SET_AP_=
PWR_STATE,
> +                                         msg);
> +       if (ret)
> +               return ret;
>
>         ret =3D apple_rtkit_wait_for_completion(&rtk->ap_pwr_ack_completi=
on);
>         if (ret)
> @@ -763,8 +782,10 @@ static int apple_rtkit_set_iop_power_state(struct ap=
ple_rtkit *rtk,
>         reinit_completion(&rtk->iop_pwr_ack_completion);
>
>         msg =3D FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, state);
> -       apple_rtkit_management_send(rtk, APPLE_RTKIT_MGMT_SET_IOP_PWR_STA=
TE,
> -                                   msg);
> +       ret =3D apple_rtkit_management_send(rtk, APPLE_RTKIT_MGMT_SET_IOP=
_PWR_STATE,
> +                                         msg);
> +       if (ret)
> +               return ret;
>
>         ret =3D apple_rtkit_wait_for_completion(&rtk->iop_pwr_ack_complet=
ion);
>         if (ret)
> @@ -865,6 +886,7 @@ EXPORT_SYMBOL_GPL(apple_rtkit_quiesce);
>  int apple_rtkit_wake(struct apple_rtkit *rtk)
>  {
>         u64 msg;
> +       int ret;
>
>         if (apple_rtkit_is_running(rtk))
>                 return -EINVAL;
> @@ -876,8 +898,10 @@ int apple_rtkit_wake(struct apple_rtkit *rtk)
>          * will wait for the completion anyway.
>          */
>         msg =3D FIELD_PREP(APPLE_RTKIT_MGMT_PWR_STATE, APPLE_RTKIT_PWR_ST=
ATE_ON);
> -       apple_rtkit_management_send(rtk, APPLE_RTKIT_MGMT_SET_IOP_PWR_STA=
TE,
> -                                   msg);
> +       ret =3D apple_rtkit_management_send(rtk, APPLE_RTKIT_MGMT_SET_IOP=
_PWR_STATE,
> +                                         msg);
> +       if (ret)
> +               return ret;
>
>         return apple_rtkit_boot(rtk);
>  }
>
> ---
> base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
> change-id: 20250211-rtkit-more-logging-79cbbbe21eee
>
> Best regards,
> --
> Alyssa Rosenzweig <alyssa@rosenzweig.io>
>
>

Looks good to me.

Reviewed-by: Neal Gompa <neal@gompa.dev>


--=20
=E7=9C=9F=E5=AE=9F=E3=81=AF=E3=81=84=E3=81=A4=E3=82=82=E4=B8=80=E3=81=A4=EF=
=BC=81/ Always, there's only one truth!

