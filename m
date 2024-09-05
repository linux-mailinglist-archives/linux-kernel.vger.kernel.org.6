Return-Path: <linux-kernel+bounces-317146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF4896D9F4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3D01C23CD4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23F819CD1B;
	Thu,  5 Sep 2024 13:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nBlaSm6k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BA5189518;
	Thu,  5 Sep 2024 13:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725542155; cv=none; b=mhtiuORjIvGJFXGqlOWViLluivFrSMzUK1STIZKa5O0guxfwLN8Fu0MwWhLSzSinvUcRXE6YsED/JGpXcAZt8ThCe3bFKfR6MA1gyqtuhmfckBjIiGqykkg1vI/Muc8L9gSMZw39ScEpMtYCi9QVvp6AWMSQi/Nmm4HsZ8CORVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725542155; c=relaxed/simple;
	bh=Lf2xQW1ofXEMIE9aLfyIWBIYBuE6JOqUklSS1JNkfRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isoG2HN0WWsf38odM+WciJu9z5F/BG08xYCsm1pp89hke/XSdKWqwG5ellcWefvzR9muPQn2NwimKGqNnfIYIf+kyju6dhIhjNXD2FvzidTk4FNZElRzmLM+Si0dmJWhEcX1wK425SG9gMIqaVi0qJ1nVFy2YvkG2Bh+hlvlvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nBlaSm6k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8B3C4CEC3;
	Thu,  5 Sep 2024 13:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725542154;
	bh=Lf2xQW1ofXEMIE9aLfyIWBIYBuE6JOqUklSS1JNkfRc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nBlaSm6kpDzLUDxCZ71M6xQhbnx76/gsUW2GfJcOST0V1Iga4wCMOfuoQ73srgmuP
	 L6vphRtnHgPwGiSeNPY+9CvpMwGw2FX/2Okbd15Eqj6TysW7ssIhM/syMMigVSiG3N
	 ogXUeLYIEBtDToSzdvm06Yos9aZgT742UKn7xcv+L+H23Aw74A7zir/1wmPno145GT
	 Qn4F8sE2XD3o5TkJt6hyBluyuLIO+bO3g9tOEYcC2MTt4X21wUSIviHCNStBOg2Yv7
	 O+yR97gmEtDm81qxx9nGZprRM8IPE5CUy+wQcOoQzL5AHIo5ka7y5Nkh6U0gV06i+7
	 1/JalMq/MU9+A==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-533461323cdso864887e87.2;
        Thu, 05 Sep 2024 06:15:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWHz3jMQ05/nQ/Kqe57a23apjbMITNtSzypFqDal4hXYnFHufUPrDPvtddEbVL1oi5nSekgXOjVycTE@vger.kernel.org, AJvYcCWlD68tGXzk7nNxK2qrKpuN3RL3ImNWQ8/9An86dX+Ain8/i5entphbm9qspzwTt56GrN0Ih2GgGEAgZISL@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9JtJLzyevgaWe2MJeFWarGUNr+BVV3jGIOxVfUnsXqOvmqAjc
	QjRnRbnF2WurVrCvVlatKGHBLUDl2GncgbIWamuIPvuy2G7jRT2LrT/xo/XHyoysd4xIKnmntaH
	pKOYC4o59ct4snkuhIuVkcIKYPQ==
X-Google-Smtp-Source: AGHT+IGU5DPvcNbP2W6NzPukJioHxIAJmFJkA9MqD/JGq2c/Acyj73ET0Fu5aoBNoss4Zsr+y1VT8eBngeqeqV4+vH4=
X-Received: by 2002:ac2:4e07:0:b0:530:d088:233f with SMTP id
 2adb3069b0e04-53546b69383mr13680962e87.40.1725542153018; Thu, 05 Sep 2024
 06:15:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905-of-resource-overflow-v1-1-0cd8bb92cc1f@linutronix.de>
In-Reply-To: <20240905-of-resource-overflow-v1-1-0cd8bb92cc1f@linutronix.de>
From: Rob Herring <robh@kernel.org>
Date: Thu, 5 Sep 2024 08:15:40 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ=7kX6DL_HBJMrWuhjZEmPUL++BvJ9tg3BDD9-e+b6Xw@mail.gmail.com>
Message-ID: <CAL_JsqJ=7kX6DL_HBJMrWuhjZEmPUL++BvJ9tg3BDD9-e+b6Xw@mail.gmail.com>
Subject: Re: [PATCH] of: address: Report error on resource bounds overflow
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 2:46=E2=80=AFAM Thomas Wei=C3=9Fschuh
<thomas.weissschuh@linutronix.de> wrote:
>
> The members "start" and "end" of struct resource are of type
> "resource_size_t" which can be 32bit wide.
> Values read from OF however are always 64bit wide.
> Avoid silently truncating the value and instead return an error value.
>
> This can happen on real systems when the DT was created for a
> PAE-enabled kernel and a non-PAE kernel is actually running.
> For example with an arm defconfig and "qemu-system-arm -M virt".

A nice follow-up would be to make of_pci_range_to_resource() use
overflows_type() as well instead of open coding it.

> Link: https://bugs.launchpad.net/qemu/+bug/1790975
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> Tested-by: Nam Cao <namcao@linutronix.de>
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> ---
>  drivers/of/address.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index d669ce25b5f9..7e59283a4472 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -8,6 +8,7 @@
>  #include <linux/logic_pio.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> +#include <linux/overflow.h>
>  #include <linux/pci.h>
>  #include <linux/pci_regs.h>
>  #include <linux/sizes.h>
> @@ -1061,7 +1062,11 @@ static int __of_address_to_resource(struct device_=
node *dev, int index, int bar_
>         if (of_mmio_is_nonposted(dev))
>                 flags |=3D IORESOURCE_MEM_NONPOSTED;
>
> +       if (overflows_type(taddr, r->start))
> +               return -EOVERFLOW;
>         r->start =3D taddr;

It looks odd that "r->start" is used before it is set, but I guess
overflows_type isn't using the value and the compiler would warn
otherwise.

Applied, thanks.

Rob

