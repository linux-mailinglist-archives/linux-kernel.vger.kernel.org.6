Return-Path: <linux-kernel+bounces-435882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2689E7E38
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 05:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B348286725
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 04:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D2070807;
	Sat,  7 Dec 2024 04:37:56 +0000 (UTC)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D82E822
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 04:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733546276; cv=none; b=br2ivOF3IR5kO0/xhmCs52Kubq14Z9I01EGCPngJNCyhBkyWEYdA6F7WjXjL8csZtS2KC2xCAg0/TSdoXL4zkwsaa67q3sIeRNf5KSaTwRgF8yzNmEIg05oFxVgtiH6Iyv9Plh71XST/ZOt76QjW20ISo/hyPDWLSGKTEwI788U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733546276; c=relaxed/simple;
	bh=5tx9odchEPm5ne4e7eFD1f+A17x0N/EMBC/RKj8dhpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pnJuvHyvAeS/SgqSdK+pAiGu4HW572BCx4t5VlA+HnTDXSVqrdg0JrxUx1v7dqLd/g/DYU/nxVB+GxHLPg6lf9VbeoWyY0MSKazATtdpEZcDy0uMAg7PlEKWYZwyyPkkMAuI9SYHyWCiM434Qfl0DTprZwX+yGbKpOXsio3W/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53df80eeeedso2749705e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 20:37:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733546271; x=1734151071;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tXnXS/rCE/qnEbcJRJ/rJahFd3OfgPUd6Jo8F8eHJvU=;
        b=GRqVA/aXr628p/m+lXFTHP3nyQG/OoWxH4C/ITABp6yUDdrQg/SQsJb06hoaqx0jdE
         +D9OoSWqg2Mha83JgrRnCywyckOJxpwl602uGU28yTtCA0KdxniPlEiZh2XhPf8FZ96C
         Cb3xsORpYR3lKhh7KJ9YYS5tqYYki2OxVDF8v2tyHEwdr7JwgSPcS+JjT5UgGFfrUW5o
         Hn6RWFTEjQi1BaMjGwUsTraDawEVp/+FrTWOHwbndLflk3+XaOQLxG+FzYy+lZVpG17Q
         pnBMMCM2SnEoQQjEu4yXaLQoWVPQ59SELj/ATlQ3I9/c8wu2wMS/vqpb5h2DkTBFNfYh
         gQGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUGQlPk7WDzTwS48k7rGvrL+ulyoDYp2olUJA2AezQRvO7p/BPlt+X92oTzb5z1+iAtIu2uLsV+Nx+hlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwyGeQRslPm3A/1ZShGuPA3jIkNmlxGJJ1X82w9BhdFD5HKwRH
	grXmCfHMGDVLoQO+N99WnLRCoItvcrkoJoBlSCdeo8AIfcFtu7JirMxvbQ==
X-Gm-Gg: ASbGncvFHoZnyEZFiEXKrzJnyKHRzoeQjgj7+AJTwCV3/i5d05Q7x52SPCJNr8XcWvM
	1dB6XBKtlKcuoJGZUapJaKpO1GrSepia5yze0KmQP5AvRwmIAo8ItFtfHircRzitW42qdTvWU6U
	ASGMGmNZBZ1PMLAKmwPLbAhGOWuFvJnpaPNCN/OYrg5Jz+bihRMEyV74IdcuSWsHBx5/m4V27V7
	r/oZPUjX7z6a/UIqgkeigYMxbwX30dIAs0n7RkisQjp6jTmvscprWr/NYbei3LzCMTovjCUg0KI
	aTgCYbI=
X-Google-Smtp-Source: AGHT+IFU9VDlS5hwr3fcVO2To2BpOE02fs0Lcjf+FOnSPiwuFCDguBcyT2ggnhx5YDSM8q6mzs6A0g==
X-Received: by 2002:a05:6512:1385:b0:53e:2ad3:416 with SMTP id 2adb3069b0e04-53e2c2c25ffmr1333706e87.25.1733546270548;
        Fri, 06 Dec 2024 20:37:50 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53ed898be64sm23678e87.88.2024.12.06.20.37.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 20:37:49 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30039432861so9305461fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 20:37:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXkbAb0Xact6OKrFeTj7RPQVRvXZher2ZDwJrgjyh7v6WHVZrBevjYVxnPfnFt5eMVeYXfVV5uKlO8anCw=@vger.kernel.org
X-Received: by 2002:a2e:bc12:0:b0:2ff:8f67:bc6a with SMTP id
 38308e7fff4ca-3002f0ce2e7mr17871581fa.0.1733546269419; Fri, 06 Dec 2024
 20:37:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241206123751.981977-1-simons.philippe@gmail.com>
In-Reply-To: <20241206123751.981977-1-simons.philippe@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sat, 7 Dec 2024 12:37:36 +0800
X-Gmail-Original-Message-ID: <CAGb2v66rd8AVUsTKG6Eic99fDmFxG95EtRsYrCoXhGrxn9EyFQ@mail.gmail.com>
Message-ID: <CAGb2v66rd8AVUsTKG6Eic99fDmFxG95EtRsYrCoXhGrxn9EyFQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: axp20x: AXP717: set ramp_delay
To: Philippe Simons <simons.philippe@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	"open list:VOLTAGE AND CURRENT REGULATOR FRAMEWORK" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 6, 2024 at 8:38=E2=80=AFPM Philippe Simons
<simons.philippe@gmail.com> wrote:
>
> AXP717 datasheet says that regulator ramp delay is 15.625 us/step,
> which is 10mV in our case.

Thanks! It looks like the reason the delay is needed is because the
voltage ramp control feature is on by default on this chip.

That is not entirely correct. 10mV is the smallest step forDCDC1,
DCDC2, and DCDC3, so it makes sense to calculate the ramp delay
using that.

For DCDC4, the step is 100mV, so the delay would be different.

> Add a AXP_DESC_RANGES_DELAY macro and update AXP_DESC_RANGES macro to
> expand to AXP_DESC_RANGES_DELAY with ramp_delay =3D 0
>
> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>

The ramp rate / delay is actually configurable between 15.625 us/step
and 31.250 us/step. However the setting shared among all DCDCs that
support this function and have it turned on. I'm not sure how that
should be modeled if we want to make it configurable.

Also looking at older AXP PMICs:

- AXP803: ramp rate 2.5mV / us, on by default, has register bit that can
          polled to check for ramp completion
- AXP813: same as AXP803

- AXP805: Similar to AXP717, where rate is given in time / step, the
          options are the same two and step is different for different
          buck regulators; difference is not all buck regulators support
          this feature, and also the rate is individually configurable
          for each one. Off by default.

- AXP223: 1.6mV/us or 0.8mV/us; off by default; only two buck regulators
          support it; individually configurable.

> ---
>  drivers/regulator/axp20x-regulator.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/regulator/axp20x-regulator.c b/drivers/regulator/axp=
20x-regulator.c
> index a8e91d9d0..8f035db13 100644
> --- a/drivers/regulator/axp20x-regulator.c
> +++ b/drivers/regulator/axp20x-regulator.c
> @@ -419,8 +419,8 @@
>                 .ops            =3D &axp20x_ops_fixed                    =
         \
>         }
>
> -#define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_volta=
ges,   \
> -                       _vreg, _vmask, _ereg, _emask)                    =
       \
> +#define AXP_DESC_RANGES_DELAY(_family, _id, _match, _supply, _ranges, _n=
_voltages,     \
> +                       _vreg, _vmask, _ereg, _emask, _ramp_delay)      \
>         [_family##_##_id] =3D {                                          =
         \
>                 .name           =3D (_match),                            =
         \
>                 .supply_name    =3D (_supply),                           =
         \
> @@ -437,8 +437,15 @@
>                 .linear_ranges  =3D (_ranges),                           =
         \
>                 .n_linear_ranges =3D ARRAY_SIZE(_ranges),                =
         \
>                 .ops            =3D &axp20x_ops_range,                   =
         \
> +               .ramp_delay =3D (_ramp_delay),                    \
>         }
>
> +#define AXP_DESC_RANGES(_family, _id, _match, _supply, _ranges, _n_volta=
ges,   \
> +                       _vreg, _vmask, _ereg, _emask)                    =
       \
> +       AXP_DESC_RANGES_DELAY(_family, _id, _match, _supply, _ranges, _n_=
voltages,      \
> +               _vreg, _vmask, _ereg, _emask, 0)
> +
> +
>  static const int axp209_dcdc2_ldo3_slew_rates[] =3D {
>         1600,
>          800,
> @@ -781,18 +788,18 @@ static const struct linear_range axp717_dcdc3_range=
s[] =3D {
>  };
>
>  static const struct regulator_desc axp717_regulators[] =3D {
> -       AXP_DESC_RANGES(AXP717, DCDC1, "dcdc1", "vin1",
> +       AXP_DESC_RANGES_DELAY(AXP717, DCDC1, "dcdc1", "vin1",
>                         axp717_dcdc1_ranges, AXP717_DCDC1_NUM_VOLTAGES,
>                         AXP717_DCDC1_CONTROL, AXP717_DCDC_V_OUT_MASK,
> -                       AXP717_DCDC_OUTPUT_CONTROL, BIT(0)),
> -       AXP_DESC_RANGES(AXP717, DCDC2, "dcdc2", "vin2",
> +                       AXP717_DCDC_OUTPUT_CONTROL, BIT(0), 640),
> +       AXP_DESC_RANGES_DELAY(AXP717, DCDC2, "dcdc2", "vin2",
>                         axp717_dcdc2_ranges, AXP717_DCDC2_NUM_VOLTAGES,
>                         AXP717_DCDC2_CONTROL, AXP717_DCDC_V_OUT_MASK,
> -                       AXP717_DCDC_OUTPUT_CONTROL, BIT(1)),
> -       AXP_DESC_RANGES(AXP717, DCDC3, "dcdc3", "vin3",
> +                       AXP717_DCDC_OUTPUT_CONTROL, BIT(1), 640),
> +       AXP_DESC_RANGES_DELAY(AXP717, DCDC3, "dcdc3", "vin3",
>                         axp717_dcdc3_ranges, AXP717_DCDC3_NUM_VOLTAGES,
>                         AXP717_DCDC3_CONTROL, AXP717_DCDC_V_OUT_MASK,
> -                       AXP717_DCDC_OUTPUT_CONTROL, BIT(2)),
> +                       AXP717_DCDC_OUTPUT_CONTROL, BIT(2), 640),
>         AXP_DESC(AXP717, DCDC4, "dcdc4", "vin4", 1000, 3700, 100,

Can you also add it to DCDC4 for completeness?


Thanks
ChenYu


>                  AXP717_DCDC4_CONTROL, AXP717_DCDC_V_OUT_MASK,
>                  AXP717_DCDC_OUTPUT_CONTROL, BIT(3)),
> --
> 2.47.1
>

