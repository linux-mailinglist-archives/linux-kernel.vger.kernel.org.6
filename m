Return-Path: <linux-kernel+bounces-219979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2074890DB14
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27B30B23C97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B6414D435;
	Tue, 18 Jun 2024 17:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SwuENrJq"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB024145B37
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733073; cv=none; b=PUWym1eMLi+0qJeE2iTmqGqwAxeURUqxRP27CVbwbnGGhHmHbAqTher6Yq1DlFERm8dqeIrQjxnc69MGrummWRc61ADsQMyGe5tA/KzbmMxMGOOnBLcdVgV/CWXP9zhLKL4aJbPzXCsUUIDBr8RXGhOfgaGG7Dv1GRHSTm4w5UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733073; c=relaxed/simple;
	bh=+i7LdplVSBgpsqHCuk3Ek+mDHHKs0qtFfimb7c5uK0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PJ4g8reIDvFaxnGJYXmwyQOVK8x6Ndxglog8xKWw9oc/Hsi00ZG4X+qyg5E4qJRK9FRmdHKSOs4kL9kRhVYZET+Pn691HGXTlZGdiCJ8Oe3M4asLadjlBBMevYwqEcM1LHmhZ3AMp9KJLROO88dbYqQldHVb8Xrs0KMiqyyB39U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SwuENrJq; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-632bcf111ffso42032197b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718733070; x=1719337870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tyXvq+2kNSq2yY1cpCgzqGKNpoe28AhGuqUANf/m0KY=;
        b=SwuENrJqza9uruPAfYte9lWutWNeHoUNvDpJph0igA+J46q0F3uAt9McddA17J6owN
         Tvk55tmEjsmEMFOVN0TOSeroegrgPvWUVZE8G6CFefV7pteLOiXRjkuxn5ir8WEen2ft
         GFMybhQvJ37TpWJuvt6JUMuz1Zm9A9I0tXtfpgJqR0cGOUxZq2JyILum4jAGUG7oTHNq
         MM15YyHYxtPpbHf2Q5xQvyKi0CJHuaW5QtQSnVc68aoHVLnWQoEx7TWiWCnXnAAAJxgt
         MALNi3TpGZahMxePWtqyrZ+y3btpv+fL3yDMY1IGJ691E1UgyvjzmBVrZcJfiRKgRst/
         edmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718733070; x=1719337870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tyXvq+2kNSq2yY1cpCgzqGKNpoe28AhGuqUANf/m0KY=;
        b=LN3UoztI5u28TMMqepeLXqbFWpTllXykUbcLhUY0PuX13atr4625dKIu266CQiNbnq
         aD5ocCigKiGsJDczX6ZdrpCi8W7rFP4edazPIc7AV7sg/IHi3pbuNJyv6YgPWnDna6IR
         YrZPKCAgJY+o5TF8OaLhiOyWgmxie8fPIsH6yBCLrx6p/8LSTNm0m8qvekCtndp8CMIm
         s3QHUQXW5X9hr8NyikvbECd0EGpARRua2EUTMLr3BwM/A+COfAm9XttER5AdQDuLD71v
         LJta8oET7V7/sz005HJtx7iEr9jIwLQJVZIKrVMboB2Sif9hv5eEmZSoM1NJY7I17nUx
         YIrA==
X-Forwarded-Encrypted: i=1; AJvYcCX8hXxcYoTmz+1AwtJz12y/4UfGVQ3A/XIOaM2j6g4/TlYRLawXV6Pytu4uOoashT9cVATChQ+9zaIlD93Ga2wQWKuz12XazXGSxMFS
X-Gm-Message-State: AOJu0Yzg65BXDfiVv35cVpEFgAe3VWE1mdGeWG3jSGx+QSivaiuWxLPk
	VV5XpzPU1Wz6Jg8zn3Hj2/OxmK+OlfAyFf5L78Kv65gyEan3SojDHDj5y8rw4DX29/QF8nGqbcA
	ImlZJu8HdDpk7YAEIo5MgojFbJMpuWUsRJ0h9uA==
X-Google-Smtp-Source: AGHT+IGX0rSKvmM9LtFbl2y0uuFDIWZVXyutPg9+1l/SGSIE4/dOh7rq6j1hE7fYLB7yhECyYlIakQysuwd2NawkPxQ=
X-Received: by 2002:a81:a190:0:b0:62c:b66b:c7a7 with SMTP id
 00721157ae682-63a8dd02cc5mr4803717b3.17.1718733070618; Tue, 18 Jun 2024
 10:51:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614140421.3172674-1-peter.griffin@linaro.org> <20240614140421.3172674-2-peter.griffin@linaro.org>
In-Reply-To: <20240614140421.3172674-2-peter.griffin@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 18 Jun 2024 12:50:59 -0500
Message-ID: <CAPLW+4my8dw7BmF242vbsp9iaPGjgP47Tc5Bz6U2kL5bBHRpwg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mfd: syscon: add of_syscon_register_regmap() API
To: Peter Griffin <peter.griffin@linaro.org>
Cc: lee@kernel.org, arnd@arndb.de, krzk@kernel.org, alim.akhtar@samsung.com, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tudor.ambarus@linaro.org, 
	andre.draszik@linaro.org, saravanak@google.com, willmcvicker@google.com, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 9:04=E2=80=AFAM Peter Griffin <peter.griffin@linaro=
.org> wrote:
>
> The of_syscon_register_regmap() API allows an externally created regmap
> to be registered with syscon. This regmap can then be returned to client
> drivers using the syscon_regmap_lookup_by_phandle() APIs.
>
> The API is used by platforms where mmio access to the syscon registers is
> not possible, and a underlying soc driver like exynos-pmu provides a SoC
> specific regmap that can issue a SMC or hypervisor call to write the
> register.
>
> This approach keeps the SoC complexities out of syscon, but allows common
> drivers such as  syscon-poweroff, syscon-reboot and friends that are used
> by many SoCs already to be re-used.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/mfd/syscon.c       | 48 ++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/syscon.h |  8 +++++++
>  2 files changed, 56 insertions(+)
>
> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 7d0e91164cba..44991da3ea23 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -192,6 +192,54 @@ static struct regmap *device_node_get_regmap(struct =
device_node *np,
>         return syscon->regmap;
>  }
>
> +/**
> + * of_syscon_register_regmap() - Register regmap for specified device no=
de
> + * @np: Device tree node
> + * @regmap: Pointer to regmap object
> + *
> + * Register an externally created regmap object with syscon for the spec=
ified
> + * device tree node. This regmap can then be returned to client drivers =
using
> + * the syscon_regmap_lookup_by_phandle() API.
> + *
> + * Return: 0 on success, negative error code on failure.
> + */
> +int of_syscon_register_regmap(struct device_node *np, struct regmap *reg=
map)
> +{
> +       struct syscon  *entry, *syscon =3D NULL;
> +
> +       if (!np || !regmap)
> +               return -EINVAL;
> +
> +       /* check if syscon entry already exists */
> +       spin_lock(&syscon_list_slock);
> +
> +       list_for_each_entry(entry, &syscon_list, list)
> +               if (entry->np =3D=3D np) {
> +                       syscon =3D entry;
> +                       break;
> +               }
> +
> +       spin_unlock(&syscon_list_slock);
> +
> +       if (syscon)
> +               return -EEXIST;
> +
> +       syscon =3D kzalloc(sizeof(*syscon), GFP_KERNEL);
> +       if (!syscon)
> +               return -ENOMEM;
> +
> +       syscon->regmap =3D regmap;
> +       syscon->np =3D np;
> +
> +       /* register the regmap in syscon list */
> +       spin_lock(&syscon_list_slock);
> +       list_add_tail(&syscon->list, &syscon_list);
> +       spin_unlock(&syscon_list_slock);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(of_syscon_register_regmap);
> +
>  struct regmap *device_node_to_regmap(struct device_node *np)
>  {
>         return device_node_get_regmap(np, false);
> diff --git a/include/linux/mfd/syscon.h b/include/linux/mfd/syscon.h
> index c315903f6dab..aad9c6b50463 100644
> --- a/include/linux/mfd/syscon.h
> +++ b/include/linux/mfd/syscon.h
> @@ -28,6 +28,8 @@ struct regmap *syscon_regmap_lookup_by_phandle_args(str=
uct device_node *np,
>                                                     unsigned int *out_arg=
s);
>  struct regmap *syscon_regmap_lookup_by_phandle_optional(struct device_no=
de *np,
>                                                         const char *prope=
rty);
> +int of_syscon_register_regmap(struct device_node *np,
> +                             struct regmap *regmap);
>  #else
>  static inline struct regmap *device_node_to_regmap(struct device_node *n=
p)
>  {
> @@ -67,6 +69,12 @@ static inline struct regmap *syscon_regmap_lookup_by_p=
handle_optional(
>         return NULL;
>  }
>
> +static inline int of_syscon_register_regmap(struct device_node *np,
> +                                       struct regmap *regmap)
> +{
> +       return -EOPNOTSUPP;
> +}
> +
>  #endif
>
>  #endif /* __LINUX_MFD_SYSCON_H__ */
> --
> 2.45.2.627.g7a2c4fd464-goog
>

