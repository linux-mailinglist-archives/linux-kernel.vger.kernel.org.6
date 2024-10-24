Return-Path: <linux-kernel+bounces-379656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F74C9AE1A7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29B872827F2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4FA1B85C4;
	Thu, 24 Oct 2024 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="g66JGdtj"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8E61B6CE2
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729763831; cv=none; b=FormbGe1wPRbSaxd2JsjMuPDMD9dKY7OgiO+Cv8sQfncArpACjGKMBQdKscmjhn1I5bd0Qic0Dd3iVPeD4En8lzxctvOH38L8DGi/TvP5WqojEs/TzedVBfyaq1PPZPZF3cH+C11L/L3I0erVhadNGx9mk2IIv0mE67IybXGVbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729763831; c=relaxed/simple;
	bh=znDkWqPkzPWX86pps9EtYEJC9sfP/BFUo+PDz5AleDs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3w9UJ/n2UNkitIzmTJom56UsPOJ7TrctF6/KjTk9QaGFr3dLkCh7kUGpLgkTOr+X4/m0qMKQrfnx2mjq3Kuy140APRg3XphN9Zjn2dfkdKW1qf/gQc2pG4Jni9axJDxUrEStxSOFEmlLCGOLjc7F5P9ACnu87JreEm9L6qiouU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=g66JGdtj; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539e8607c2aso791323e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 02:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1729763826; x=1730368626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwrSiNuF3MmwoZvZq0oH9sht1o+yzvBlURRSwfcy8GU=;
        b=g66JGdtj1CON4kOzg8ln7x1xHqVGIx2JmXtj3AeNIeFH5HPI2x0D2g1KEAJTf9gBPs
         eYXSqRZ5XURrAJ8Htfae/H8ZHA3FHaNT6Gd1PwYMhQ8n/XM63PIWWrHCyRJGCkO9NOe9
         /Pbvg3GxxsIEo7zPrif8M7rArB7vrXpi0A+as=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729763826; x=1730368626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwrSiNuF3MmwoZvZq0oH9sht1o+yzvBlURRSwfcy8GU=;
        b=n+xuJhAzd/7DNaDupg0dcLMr/ZCM5+bjGFBwjLti7UInNUix3Ff4AglCWYaSdqOlL8
         jObydkFX05cOMN8FAVXNXbydCFvyRB/1H3kRWM7VNNbsQzLE9Bgk+dREYRNuBRKy//at
         6Pzp1J2S82cV6ynpJzZiSVPL6rtkQP/uUq+wU4PfJZwP7m4BJVONWbToI+xgxE0X3OqM
         GpSX9wfkUF9S3zdCzYPivDJ4uRaN7ibB3AZXGLaNqiT8XU0OvJYh0/jLFoFCrUrm44W1
         MShFfbrW/F7MXQT4wnU/bNobB2c7lRHb9bP5rXjoQp5c8b5LlXvQvam0w8BoFvxk9Wpf
         qBJw==
X-Forwarded-Encrypted: i=1; AJvYcCW2yV3YyRKjDFkI6CZJ4uKqHdPON7I/lTQikyiuf48H0GXAh6sbu1gL6Quofj1Xqoyr7fKu+g1yMayUQAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxszcrpZIAc+Cwx6J9blMGyI2LI/Hlgc8It9w2U3N2wwQjjoPuM
	yNN1665jFvE1x3oF0PNKMW3RK6FL7cPOQV6DROo4a0noaTLsL8VG5ETvR46hAGM1kClcJAcseDM
	yKQVbudk6LPvwFlqT2JPfuB/2IL0FcNPkDe0q
X-Google-Smtp-Source: AGHT+IFt48rpRLYA5HussW5JakseDSLyUy/htwuwG7FhR+J65RPloGFGfLBvtboJpAXEd1tkRwDPgfxR7KUH2LnzgvY=
X-Received: by 2002:a05:6512:33c8:b0:539:d05c:f553 with SMTP id
 2adb3069b0e04-53b23dfa2c6mr798115e87.21.1729763826215; Thu, 24 Oct 2024
 02:57:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016-auxadc_thermal-v12-1-c0433e9f61af@chromium.org>
In-Reply-To: <20241016-auxadc_thermal-v12-1-c0433e9f61af@chromium.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 24 Oct 2024 17:56:54 +0800
Message-ID: <CAGXv+5GfGg_gh0+7MKXCRHd97yoE-BWfnCU9Q5d1cxp6Ep4Epg@mail.gmail.com>
Subject: Re: [PATCH RESEND v12] thermal/drivers/mediatek: add another get_temp
 ops for thermal sensors
To: Hsin-Te Yuan <yuanhsinte@chromium.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, James Lo <james.lo@mediatek.com>, 
	Michael Kao <michael.kao@mediatek.com>, Hsin-Yi Wang <hsinyi@chromium.org>, 
	Ben Tseng <ben.tseng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

The subject could be better worded, like "expose all thermal sensors".

On Wed, Oct 16, 2024 at 1:47=E2=80=AFPM Hsin-Te Yuan <yuanhsinte@chromium.o=
rg> wrote:
>
> From: James Lo <james.lo@mediatek.com>
>
> Previously, the driver only supported reading the temperature from all
> sensors and returning the maximum value. This updatea adds another

                                                      ^ typo

> get_temp ops to support reading the temperature from each sensor
> separately.

You should mention why you want to expose all the thermal sensors.
Just making them available to userspace is a good enough reason.
You could also mention that some other drivers needs access to
some of the individual sensor readings.

You probably don't need to go into specific details about adding
a new get_temp ops.

> This feature provides the ability to read all thermal sensor values in
> the SoC through the node /sys/class/thermal.

This paragraph is redundant. It is implied by the subject.

> Signed-off-by: Michael Kao <michael.kao@mediatek.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Signed-off-by: Ben Tseng <ben.tseng@mediatek.com>
> Signed-off-by: James Lo <james.lo@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> Signed-off-by: Hsin-Te Yuan <yuanhsinte@chromium.org>
> ---
> Changes in v12:
> - Remove unnecessary check and unused variable assignment in mtk_read_sen=
sor_temp.
> - Add more about what this patch achieves in the commit message.
> - Link to v11: https://lore.kernel.org/r/20240809-auxadc_thermal-v11-1-af=
36cc74f3a3@chromium.org
>
> Changes in V11:
>     - Rebase on kernel v6.11-rc2
>     - Use mtk_thermal_temp_is_valid in mtk_read_sensor_temp just like
>       mtk_thermal_bank_temperature
>     - Change the error handling of devm_thermal_of_zone_register return
>       value
>     - link to V10: https://lore.kernel.org/lkml/20220519101044.16765-1-ja=
mes.lo@mediatek.com/
>
> Changes in V10:
>     - Rebase to kernel-v5.18-rc7
>     - Resend
>
> Changes in V9:
>     - Rebase to kernel-v5.14-rc1
>     - Bind raw_to_mcelsius_v1 or raw_to_mcelsius_v2 to compatible
>       data of struct mtk_thermal_data
>     - Remove duplicate struct 'mtk_thermal_bank'
>     - Remove unnecessary if condition check
>     - Return error if any thermal zone fail to register
>
> Changes in V8:
>     - Rebase to kernel-v5.13-rc1
>     - Resend
>
> Changes in v7:
>     - Fix build error in v6.
>
> Changes in v6:
>     - Rebase to kernel-5.11-rc1.
>     - [1/3]
>         - add interrupts property.
>     - [2/3]
>         - add the Tested-by in the commit message.
>     - [3/3]
>         - use the mt->conf->msr[id] instead of conf->msr[id] in the
>           _get_sensor_temp and mtk_thermal_bank_temperature.
>         - remove the redundant space in _get_sensor_temp and
>           mtk_read_sensor_temp.
>         - change kmalloc to dev_kmalloc in mtk_thermal_probe.
>
> Changes in v5:
>     - Rebase to kernel-5.9-rc1.
>     - Revise the title of cover letter.
>     - Drop "[v4,7/7] thermal: mediatek: use spinlock to protect PTPCORESE=
L"
>     - [2/2]
>         -  Add the judgement to the version of raw_to_mcelsius.
>
> Changes in v4:
>     - Rebase to kernel-5.6-rc1.
>     - [1/7]
>         - Squash thermal zone settings in the dtsi from [v3,5/8]
>           arm64: dts: mt8183: Increase polling frequency for CPU thermal =
zone.
>         - Remove the property of interrupts and mediatek,hw-reset-temp.
>     - [2/7]
>         - Correct commit message.
>     - [4/7]
>         - Change the target temperature to the 80C and change the commit =
message.
>     - [6/7]
>         - Adjust newline alignment.
>         - Fix the judgement on the return value of registering thermal zo=
ne.
>
> Changes in v3:
>     - Rebase to kernel-5.5-rc1.
>     - [1/8]
>         - Update sustainable power of cpu, tzts1~5 and tztsABB.
>     - [7/8]
>         - Bypass the failure that non cpu_thermal sensor is not find in t=
hermal-zones
>           in dts, which is normal for mt8173, so prompt a warning here in=
stead of
>           failing.
>
>     Return -EAGAIN instead of -EACCESS on the first read of sensor that
>         often are bogus values. This can avoid following warning on boot:
>
>           thermal thermal_zone6: failed to read out thermal zone (-13)
>
> Changes in v2:
>     - [1/8]
>         - Add the sustainable-power,trips,cooling-maps to the tzts1~tztsA=
BB.
>     - [4/8]
>         - Add the min opp of cpu throttle.
> ---
>
> ---
>  drivers/thermal/mediatek/auxadc_thermal.c | 70 +++++++++++++++++++++++++=
++----
>  1 file changed, 62 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/thermal/mediatek/auxadc_thermal.c b/drivers/thermal/=
mediatek/auxadc_thermal.c
> index 9ee2e7283435acfcbb1a956303b6122a08affecc..10938be2e5545fba2fff7d5cc=
5a0269d42e5d44d 100644
> --- a/drivers/thermal/mediatek/auxadc_thermal.c
> +++ b/drivers/thermal/mediatek/auxadc_thermal.c
> @@ -847,7 +847,8 @@ static int mtk_thermal_bank_temperature(struct mtk_th=
ermal_bank *bank)
>
>  static int mtk_read_temp(struct thermal_zone_device *tz, int *temperatur=
e)
>  {
> -       struct mtk_thermal *mt =3D thermal_zone_device_priv(tz);
> +       struct mtk_thermal_bank *bank =3D thermal_zone_device_priv(tz);
> +       struct mtk_thermal *mt =3D bank->mt;
>         int i;
>         int tempmax =3D INT_MIN;
>
> @@ -866,10 +867,41 @@ static int mtk_read_temp(struct thermal_zone_device=
 *tz, int *temperature)
>         return 0;
>  }
>
> +static int mtk_read_sensor_temp(struct thermal_zone_device *tz, int *tem=
perature)
> +{
> +       struct mtk_thermal_bank *bank =3D thermal_zone_device_priv(tz);
> +       struct mtk_thermal *mt =3D bank->mt;
> +       const struct mtk_thermal_data *conf =3D mt->conf;
> +       int id =3D bank->id - 1;
> +       int temp =3D INT_MIN;
> +       u32 raw;
> +
> +       raw =3D readl(mt->thermal_base + conf->msr[id]);
> +
> +       temp =3D mt->raw_to_mcelsius(mt, id, raw);
> +
> +       /*
> +        * The first read of a sensor often contains very high bogus
> +        * temperature value. Filter these out so that the system does
> +        * not immediately shut down.
> +        */
> +
> +       if (unlikely(!mtk_thermal_temp_is_valid(temp)))
> +               return -EAGAIN;
> +
> +       *temperature =3D temp;
> +
> +       return 0;
> +}
> +
>  static const struct thermal_zone_device_ops mtk_thermal_ops =3D {
>         .get_temp =3D mtk_read_temp,
>  };
>
> +static const struct thermal_zone_device_ops mtk_thermal_sensor_ops =3D {
> +       .get_temp =3D mtk_read_sensor_temp,
> +};
> +
>  static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
>                                   u32 apmixed_phys_base, u32 auxadc_phys_=
base,
>                                   int ctrl_id)
> @@ -1199,6 +1231,7 @@ static int mtk_thermal_probe(struct platform_device=
 *pdev)
>         u64 auxadc_phys_base, apmixed_phys_base;
>         struct thermal_zone_device *tzdev;
>         void __iomem *apmixed_base, *auxadc_base;
> +       struct mtk_thermal_bank *tz;
>
>         mt =3D devm_kzalloc(&pdev->dev, sizeof(*mt), GFP_KERNEL);
>         if (!mt)
> @@ -1285,14 +1318,35 @@ static int mtk_thermal_probe(struct platform_devi=
ce *pdev)
>                         mtk_thermal_init_bank(mt, i, apmixed_phys_base,
>                                               auxadc_phys_base, ctrl_id);
>
> -       tzdev =3D devm_thermal_of_zone_register(&pdev->dev, 0, mt,
> -                                             &mtk_thermal_ops);
> -       if (IS_ERR(tzdev))
> -               return PTR_ERR(tzdev);
> +       for (i =3D 0; i <=3D mt->conf->num_sensors; i++) {
> +               tz =3D devm_kmalloc(&pdev->dev, sizeof(*tz), GFP_KERNEL);
> +               if (!tz)
> +                       return -ENOMEM;
> +
> +               tz->mt =3D mt;
> +               tz->id =3D i;
> +
> +               tzdev =3D devm_thermal_of_zone_register(&pdev->dev, i,
> +                                                     tz, (i =3D=3D 0) ?
> +                                                     &mtk_thermal_ops
> +                                                     : &mtk_thermal_sens=
or_ops);
> +
> +               if (IS_ERR(tzdev)) {
> +                       ret =3D PTR_ERR(tzdev);
> +                       if (ret =3D=3D -ENODEV) {
> +                               dev_warn(&pdev->dev, "can't find thermal =
sensor %d\n", i);

"Can't find thermal zone for sensor %d; sensor skipped.\n".

Based on the core code, the failure is not being able to find a matching
thermal zone node.

Also, make it known to the user what happened.

> +                               continue;
> +                       }
> +                       dev_err(&pdev->dev,
> +                               "Error: Failed to register thermal zone %=
d, ret =3D %d\n",
> +                               i, ret);
> +                       return ret;

return dev_err_probe(&pdev->dev, ret, "Failed to register thermal zone
%d.\n", i);

> +               }
>
> -       ret =3D devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
> -       if (ret)
> -               dev_warn(&pdev->dev, "error in thermal_add_hwmon_sysfs");
> +               ret =3D devm_thermal_add_hwmon_sysfs(&pdev->dev, tzdev);
> +               if (ret)
> +                       dev_warn(&pdev->dev, "error in thermal_add_hwmon_=
sysfs: %d\n", ret);

Mention which sensor ID this failed for.

ChenYu

> +       }
>
>         return 0;
>  }
>
> ---
> base-commit: b589839414be04b2b37e4bf6f84af576c99faf64
> change-id: 20240809-auxadc_thermal-9be338ec8b1c
>
> Best regards,
> --
> Hsin-Te Yuan <yuanhsinte@chromium.org>
>
>

