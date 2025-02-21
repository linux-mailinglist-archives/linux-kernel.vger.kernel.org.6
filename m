Return-Path: <linux-kernel+bounces-526797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D334A4036F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0153317D54E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 23:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC4A20AF85;
	Fri, 21 Feb 2025 23:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UlO13Dvg"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BE620897E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 23:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740180499; cv=none; b=ohFR30Zacb8SNhMBZqBaMjccmefcqHFtWCOrUDaj+FkTwsGzATh/IkPwOg7G08O1K/tPTMeu3lyYS9xRoQQB126Cps8AjPGuUYViTOCm4NB0FjyeWhsiDCtSMy7sR62JfLj5QCQ56hEAIB/o65np6FFdAA/iLKjFBd/JQT/v7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740180499; c=relaxed/simple;
	bh=Vl/c/T93mDlS+SAo6jWpGO0WCFcjOVagGDwU7OjE4CE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dozaTQgBLikF7LU+CxYUySM36T9ObaAkYsqgsE1Q86zxGz0TZlSJSvrKT402qkmF1cCjgpqOA8tl+WkgZqh+3pZ7ftMB904C9DY69qmiqV7+xpXd2irYwcgdeHvVfXHrPrZ/jCJxHo2pAqYTNjzMY+9tk2uCvNNj/ck8Rw7nUOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UlO13Dvg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abb8045c3f3so328353866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1740180494; x=1740785294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dIS2An77/MyudXh45p4DCv6fIS8Vd5P9xJ/byU/bvk=;
        b=UlO13Dvgkdp3eWInrjVm45R9SKAeiI0d1P7QPWVYnV34LtO8ofBc6zbr/4HxKTtwdS
         yImm+SQHJJHeAlRNiRB62xcCd6urwiKuEILqCXO3tOcgHYYggCfkH49FD44lWEigg6l/
         pPM+KlzQIIPR51VeNiJB9n/7nJVMa5RhtzqGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740180494; x=1740785294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+dIS2An77/MyudXh45p4DCv6fIS8Vd5P9xJ/byU/bvk=;
        b=rigeRgE/o19w0Bk8ouU9US2Fng7VTmJGN7hswd1notxA9NqJH54agZmMIpptpmL4pt
         k/75MAi89u0MPP4v3Zjz0b1cdxNaByV/UbexnYYZU1lYOwTRcW7GLnwGiv7RtPv0Pap4
         rLVinR8/SvocVHfgaXsn9u1Av5nZgqJeHtBEe7H+jwA/ctcU1ZeM9/OJPwWIqXiM5lKO
         mo4fVnFfojrgPwVi8I+4iGGQVRyt35ISumgvQhxVCXIjkqRGgp5F1iehAD8ahWQgj4lH
         alfSHn2UScpyO6ZFy/4JR4e2Gv0xOPPjznwnX9tIdkDoH6smajqbuaFe9yWSniXwKVdv
         jSvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXf9Qrd8Z7PC3qcJ/umVFphFLCLFKmzBhNrhl/ffmoN4SkZVHH4HbMDJFVXRigXLZV+VyO8PcEDqBI5rKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym7zM9VpsCI2GTns5DCm3xqIy3BwuOdGUg/Ya4bxLdtqkc8zc6
	TLetZOa7OBg0U+8LS/DewCs91mOmz5kaQf4IKSGnY1nhFydHpuZFxV7jrye9XzSAioopgwsHMKM
	PfPce
X-Gm-Gg: ASbGncsXLOuNvkpFzj0aUwf7k6dBir96KuIoRIDKoXsRPxUA+cMYFGJS5H9Z9UzV89T
	szsv2SyUdTbCsqywTezVQ6ch+bAAYpLAdXdAiq1LppFY7U5xWCi8UAmfORKWfz720LzPnSq373U
	k/lSgNY0wFNCOfosc8N86oxtTWFgpEaPrtHI69TVxx5yaai9Nmmh1zO+L5OFUq9U8Pv3Od36nVm
	vZXziIf6EWL6XiUThOYaEHrgKmnulgcu9l3Dfq9ClM4m7P6V3U+fAAr/RkoOdeuEHGllw2NUKIH
	bVTHBF/+2Pb7q7En4+Y11yQSNwg8WtH5uDuonYiu5TOEtYmaRu7PsKGC16SPNw==
X-Google-Smtp-Source: AGHT+IE8yirWIXPnRLmXoq0VpM7xdywFKYPY0gsb+0hg1P2jXjYcZhM4+x0vsYRKRBeY9STgywvcbw==
X-Received: by 2002:a17:906:3143:b0:aa6:ac9b:6822 with SMTP id a640c23a62f3a-abc099b8059mr454117866b.12.1740180494089;
        Fri, 21 Feb 2025 15:28:14 -0800 (PST)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8a647c7dsm1190821766b.72.2025.02.21.15.28.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 15:28:13 -0800 (PST)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38f406e9f80so2365283f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:28:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWwzCib4ET8ubykl4HJGqx3cbeMd78SW91K0ZhA3Uidu8N/JLOMOwpye/kLYKI+2CXFQn55LZgYJ3CyR0E=@vger.kernel.org
X-Received: by 2002:a5d:648b:0:b0:38f:3139:f57f with SMTP id
 ffacd0b85a97d-38f6e95c31emr5375784f8f.16.1740180492926; Fri, 21 Feb 2025
 15:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2788228.mvXUDI8C0e@rjwysocki.net>
In-Reply-To: <2788228.mvXUDI8C0e@rjwysocki.net>
From: Yu-Che Cheng <giver@chromium.org>
Date: Sat, 22 Feb 2025 07:27:36 +0800
X-Gmail-Original-Message-ID: <CAKchOA1gfsE+URhBZCwbNrMmX8Xw+a4LR4DHuv5o+-6-mUd30w@mail.gmail.com>
X-Gm-Features: AWEUYZnHjbzCzaPcqF2-DvwTXXuS2cUtPqOEKZFJBpzO6CzMWdN5MrAWgJ1Mimg
Message-ID: <CAKchOA1gfsE+URhBZCwbNrMmX8Xw+a4LR4DHuv5o+-6-mUd30w@mail.gmail.com>
Subject: Re: [PATCH v1] thermal/of: Fix cdev lookup in thermal_of_should_bind()
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Lukasz Luba <lukasz.luba@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Yu-Che Cheng <giver@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Yu-Che Cheng <giver@chromium.org>
Tested-by: Yu-Che Cheng <giver@chromium.org>

On Sat, Feb 22, 2025 at 12:57=E2=80=AFAM Rafael J. Wysocki <rjw@rjwysocki.n=
et> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Since thermal_of_should_bind() terminates the loop after processing
> the first child found in cooling-maps, it will never match more than
> one cdev to a given trip point which is incorrect, as there may be
> cooling-maps associating one trip point with multiple cooling devices.
>
> Address this by letting the loop continue until either all
> children have been processed or a matching one has been found.
>
> To avoid adding conditionals or goto statements, put the loop in
> question into a separate function and make that function return
> right away after finding a matching cooling-maps entry.
>
> Fixes: 94c6110b0b13 ("thermal/of: Use the .should_bind() thermal zone cal=
lback")
> Link: https://lore.kernel.org/linux-pm/20250219-fix-thermal-of-v1-1-de36e=
7a590c4@chromium.org/
> Reported-by: Yu-Che Cheng <giver@chromium.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/thermal/thermal_of.c |   50 ++++++++++++++++++++++++------------=
-------
>  1 file changed, 29 insertions(+), 21 deletions(-)
>
> --- a/drivers/thermal/thermal_of.c
> +++ b/drivers/thermal/thermal_of.c
> @@ -274,6 +274,34 @@
>         return true;
>  }
>
> +static bool thermal_of_cm_lookup(struct device_node *cm_np,
> +                                const struct thermal_trip *trip,
> +                                struct thermal_cooling_device *cdev,
> +                                struct cooling_spec *c)
> +{
> +       for_each_child_of_node_scoped(cm_np, child) {
> +               struct device_node *tr_np;
> +               int count, i;
> +
> +               tr_np =3D of_parse_phandle(child, "trip", 0);
> +               if (tr_np !=3D trip->priv)
> +                       continue;
> +
> +               /* The trip has been found, look up the cdev. */
> +               count =3D of_count_phandle_with_args(child, "cooling-devi=
ce",
> +                                                  "#cooling-cells");
> +               if (count <=3D 0)
> +                       pr_err("Add a cooling_device property with at lea=
st one device\n");
> +
> +               for (i =3D 0; i < count; i++) {
> +                       if (thermal_of_get_cooling_spec(child, i, cdev, c=
))
> +                               return true;
> +               }
> +       }
> +
> +       return false;
> +}
> +
>  static bool thermal_of_should_bind(struct thermal_zone_device *tz,
>                                    const struct thermal_trip *trip,
>                                    struct thermal_cooling_device *cdev,
> @@ -293,27 +321,7 @@
>                 goto out;
>
>         /* Look up the trip and the cdev in the cooling maps. */
> -       for_each_child_of_node_scoped(cm_np, child) {
> -               struct device_node *tr_np;
> -               int count, i;
> -
> -               tr_np =3D of_parse_phandle(child, "trip", 0);
> -               if (tr_np !=3D trip->priv)
> -                       continue;
> -
> -               /* The trip has been found, look up the cdev. */
> -               count =3D of_count_phandle_with_args(child, "cooling-devi=
ce", "#cooling-cells");
> -               if (count <=3D 0)
> -                       pr_err("Add a cooling_device property with at lea=
st one device\n");
> -
> -               for (i =3D 0; i < count; i++) {
> -                       result =3D thermal_of_get_cooling_spec(child, i, =
cdev, c);
> -                       if (result)
> -                               break;
> -               }
> -
> -               break;
> -       }
> +       result =3D thermal_of_cm_lookup(cm_np, trip, cdev, c);
>
>         of_node_put(cm_np);
>  out:
>
>
>

