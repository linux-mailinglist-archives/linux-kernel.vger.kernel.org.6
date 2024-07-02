Return-Path: <linux-kernel+bounces-238208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 976549246D4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 20:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D831F260E6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 18:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBE51C2310;
	Tue,  2 Jul 2024 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="aY/czv/6"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE5A1C0076
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719943266; cv=none; b=JzmWSoTjA5eZb9lvz5TLq6xhZnq/Y4Iy5/Ag7GOIHUvdHFpqJxJQyi1zSed2LBBieb+dYNmLG37tDGzdcMstHA7kugvCmleCLGWv725QphPBC58ev0hSEebeCAhrv+HXoEPKZc7y22qjQhh9iAfIl4keDn/Gcrb9LkHEag485aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719943266; c=relaxed/simple;
	bh=kkk+18D6HhFB3odNtIldrjiYxcFuE4z8q+l57h14CsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=quKIYM8uzXg/kKpR9Fys98pJpF4lfHZatapFli1KHESHsn9Jrh0fdjNFrrhfz164eEgUpWnmKT8yOfVRhplDw75Rrb1R+qPk8PDZinqTovTEp/Mu+Uen+4J4l4FAzNelItuGzJC0buFf4LcjSZ/EACmiIRRrFDmrnl3fAd07Urc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=aY/czv/6; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52e7ad786dfso3837253e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719943261; x=1720548061; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKnWasz019XWbKpY8JDNjxDoiZJi0JBpRkDvY6AW8TU=;
        b=aY/czv/61EnxXtMlJceXV+wDGDTN1kmhZ+V2IwbsxrqgKHq/C4vOmtoCUKF8buhNNI
         X3yjApMPMFtTaHPylY8cYDjDQVK/Fvt4/D6wjiyoFvQcBHgjPU05i7JzwFJSshDNYAO2
         UgbAVjiTwvAKWqbHpJNIDlebNnTGaMXYsM3pw/Xpdx8bdahFbsnKEJaOw3JCUrez43Nh
         ZSdqs5cNhIJmlbg+TpjXt0o/jdxPS2vLMWaD7G+hUoKTJMSNuGLsjNSOi8MuD2hU6gnd
         1N9f4OYP04L9+LzLryThfv7KQ1EbWBgoepOeoickqbB3Gn90XkCpNUgFjMhbL2yDq0bn
         cO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719943261; x=1720548061;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKnWasz019XWbKpY8JDNjxDoiZJi0JBpRkDvY6AW8TU=;
        b=wULykbZURY2hUKjYQ+WTv0Q8qPO7s8EDZolutv1MSOFarjWo+JHW6PSMt6m0H+v/tr
         GNCL9GivuPsY/qDrXqqwB4jVLV0kM39ZTygkq7nwPIXfrqH9Oo84/6yVXmTT5vw2ZNQ7
         4RqdmLf2RTKHyM0ZLnnnsSF4W5pC5SLzoUjuVDOK4PfC363vOBz5TufHeRonDkfGPSbA
         imqhXr+VgSd2kbiVZ+cbF0l9CKlKBwQm7wA0D1Ll/9gYUz5dIGXcmsOviYshXDpeT5dB
         U6zPvprln4FVGhBwl+1klF3BXB3dtGbg6FaGe0yV1xKZr2CuNVMIkA8eL6Ma7ztKKk/7
         UOXg==
X-Forwarded-Encrypted: i=1; AJvYcCVmCtEJpMBT5VMzqUuJIijrVKurTZdWCRv/h9mfcs3JWJwcClIXDeFrIIkflNcvEl8UVaQsxr44MMNMjlY9uiq60nTCC8JBtgs8Q0e4
X-Gm-Message-State: AOJu0YwY4l9fNusyyidyQInuRfi4EhEtH+7vcJ8zZ5qxghsLZJIl7+Hc
	41kudU1jDmsW5bO1PGKQlrgtFStdR76w1xf4jaPnjQ9FfSSt7yQOvkCK/sj14seG6x8QLVfK80H
	PmuOoDtjbj2io0b6jQ6cot2JMXySh0VFPscLQYA==
X-Google-Smtp-Source: AGHT+IGj6gnbb3k6BOFN8B1zCkyv+bXntzux6J3q7+mN1aD56dPlbThJPM72pIoJryrNFkZyrexSAN/Zmu9KJEVHVTI=
X-Received: by 2002:a05:6512:31c9:b0:52b:faa1:7c74 with SMTP id
 2adb3069b0e04-52e7b8dedb3mr4684885e87.5.1719943260686; Tue, 02 Jul 2024
 11:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702173255.39932-1-superm1@kernel.org>
In-Reply-To: <20240702173255.39932-1-superm1@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 2 Jul 2024 20:00:49 +0200
Message-ID: <CAMRc=MfBJi2BGZxfLHgbu2AgRyZ9Z_smWMCy_hD6HuW3HxrNsw@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctl: Decrease message about child OF nodes to debug
To: superm1@kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Amit Pundir <amit.pundir@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>, Praveenkumar Patil <PraveenKumar.Patil@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 7:33=E2=80=AFPM <superm1@kernel.org> wrote:
>
> From: Mario Limonciello <mario.limonciello@amd.com>
>
> commit 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF
> nodes of the port node") introduced a new error message about populating
> OF nodes. This message isn't relevant on non-OF platforms, so downgrade
> it to debug instead.
>
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: Amit Pundir <amit.pundir@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD, SM8650-QR=
D & SM8650-HDK
> Cc: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T
> Reported-by: Praveenkumar Patil <PraveenKumar.Patil@amd.com>
> Fixes: 8fb18619d910 ("PCI/pwrctl: Create platform devices for child OF no=
des of the port node")
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pci/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index e4735428814d..f21c4ec979b5 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -354,7 +354,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>                 retval =3D of_platform_populate(dev->dev.of_node, NULL, N=
ULL,
>                                               &dev->dev);
>                 if (retval)
> -                       pci_err(dev, "failed to populate child OF nodes (=
%d)\n",
> +                       pci_dbg(dev, "failed to populate child OF nodes (=
%d)\n",
>                                 retval);
>         }
>  }
> --
> 2.43.0
>
>

Ah! I was under the impression that of_platform_populate() would
return 0 with !OF but it returns -ENODEV instead...

Maybe do:

if (retval && retval !=3D -ENODEV) and keep pci_err() here?

Bart

