Return-Path: <linux-kernel+bounces-512474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBFBA339BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 09:12:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD9C616347E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 08:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D7620B7F1;
	Thu, 13 Feb 2025 08:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xS33AjGL"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC81320AF82
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 08:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739434333; cv=none; b=lvzRH0V2xKslxvjXUNDE5yUc+hRwsfGzl/SDmFAeCyzGO+p1GRgLUaKwjgAqfiufASH3VplSqewBGWdJrpcpRSKLwwapZcj5nl+Q0S7OOuZVmM6ytG97V33gc6kPOlvyIsNlHiQr3BtUyfh/HK+GvsEHaIybmNmnFFSbB33vq8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739434333; c=relaxed/simple;
	bh=IzOwURizwaHTDoalnzfQjbPvyao176Lubem61Q1s0Ug=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lamfJcrPxdh3Rv4B44DpiOB6GceE57TAANtiQIvbVi2GzjQk8r659po6Sn1+R/TqEae6FyAHCqJoDn3SYViN0lIW2j6dGFnmFO1h2J4pYrATIwCXFghUdmxFpWsFMEkO4A+YLZuuaLj3n4fqOVx7w152HX55BYL+pLT1gn+ydeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xS33AjGL; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5450475df04so556437e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 00:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739434330; x=1740039130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hAmRq+WjKaY2DybHR+WE6i+UKYwSvJ1ltFGyhiHvH88=;
        b=xS33AjGL371ZbNUAtLXmecvrIQ8UYCgRr+pQjKL/meSBFkyqqdWOGmxJWCw4QA9YhX
         D+GASM9eVzj0swV8JbhWb0gXbUEnQ/r4R48T1BUJY279bocl1HVQqoIksXdyXghhM9mq
         UDblk76ZmF7MfwarWNI1NVbinilwab0tVeh9IrM8Sm0Vfuil4OqMM8WavHycPBahALMb
         DtI3DLySje5dEPisJE7+QVGNbGTT4mn+DYcogOSkD6ivE8BgxwPkwrxRu9IkkBQRjedk
         X1SYSTuAMMYQw3BKhLTu0t+lexsDEOL2//Gi1BI+wOQXb7hKa/HtxKZSeWQfTnk1gUpw
         IiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739434330; x=1740039130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hAmRq+WjKaY2DybHR+WE6i+UKYwSvJ1ltFGyhiHvH88=;
        b=u5RejgQUtQtcOz6kuIAUfV+NiOoAWsQTbTXMOCbqquqQpc+qcJalOkwONBPcuQ37Ch
         GWL9j9WqgsAcfMdpIxckef98TTSNtuGCqToZ4mq+Vj2peYMVs9EKne/RiGGBNiaUZNc4
         xktYoax6sE3YogRa2Ys8Zefzqiso/qZFYUXASifxSO4CI0mi0tzyq6aRnFkwekE+Cp0w
         mhMYuP4kGCI/0Onz92G3bNZApJVHzXJCtHiRZXI8Joj97IGm1MEt97ug7peGZlmxevhy
         CbBXWSd00agvmRV5IuFOGKt+O7Za6/g6d3Z6XtS2AW1r5XIprB2kGBw2lTjkxeJ3wqHc
         sbAQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4jrFHiKcgCKFEpumNwmrWueFizsk4dfaZurAS6LsvVtAop9TZwzQOr5+MJpQFajUdvQ1FoeH1BR0J/nM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrIy/s9MZ8CkEH11Tf3YHk/hxYWxEj77+5strYfHkAMB3RwvCg
	faKIsgqO+d5ADU0yCOwus555B/22ilLtDIflGVr2dWzBe5d9NGkpc/Vv5nZW+8liwgo6rPoh/lU
	SvT2FqhD7A4cTChbgC1dgv6iEIy7xm81wPX9m
X-Gm-Gg: ASbGnctyrssfazhaOdATpXy/AyuDCs8bJokHLKfly6gDTg9peC/qjAdp6rD7JRZPp+k
	BsMulFAHB/cU12gDD6IoaFSHW/QgoCgY/GbziXnQo0RkDXU0Fa5HMpewpcXF6aFgyrWKAl6U=
X-Google-Smtp-Source: AGHT+IEscH2FEFUFOcZFm0o8VPYBKOy+ANhRTEsybzie/6+J6vO32taNrSDzYzJGwFo2o+KdPpcpAniXA9CwJIr+7Ss=
X-Received: by 2002:a05:6512:3da8:b0:545:8a1:536e with SMTP id
 2adb3069b0e04-545180ea980mr2094867e87.6.1739434329510; Thu, 13 Feb 2025
 00:12:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212-fix__fw_devlink_relax_cycles_missing_device_put-v1-1-41818c7d7722@bootlin.com>
In-Reply-To: <20250212-fix__fw_devlink_relax_cycles_missing_device_put-v1-1-41818c7d7722@bootlin.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 13 Feb 2025 00:11:31 -0800
X-Gm-Features: AWEUYZlcr5F-3NCRpr8erggDlzKx-JHrICcz3LQ60PjpTGkdt6u7F1inVt65iiM
Message-ID: <CAGETcx_WWxeovfDdX+oN8BreknNnQ5CBKNoxB5X9z2VQsOxd7A@mail.gmail.com>
Subject: Re: [PATCH] drivers: core: fix device leak in __fw_devlink_relax_cycles()
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	=?UTF-8?Q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 2:31=E2=80=AFAM Luca Ceresoli <luca.ceresoli@bootli=
n.com> wrote:
>
> Commit bac3b10b78e5 ("driver core: fw_devlink: Stop trying to optimize
> cycle detection logic") introduced a new struct device *con_dev and a
> get_dev_from_fwnode() call to get it, but without adding a corresponding
> put_device().

Thanks for debugging this and fixing it! Glad to see more people
fixing fw_devlink code :)

> Link: https://lore.kernel.org/all/20241204124826.2e055091@booty/
Use the Closes: tag for this link. That tag is used to point to the
bug report that this patch is fixing.

> Fixes: bac3b10b78e5 ("driver core: fw_devlink: Stop trying to optimize cy=
cle detection logic")
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/base/core.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 5a1f051981149dc5b5eee4fb69c0ab748a85956d..2fde698430dff98b5e30f7be7=
d43d310289c4217 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2079,6 +2079,7 @@ static bool __fw_devlink_relax_cycles(struct fwnode=
_handle *con_handle,
>  out:
>         sup_handle->flags &=3D ~FWNODE_FLAG_VISITED;
>         put_device(sup_dev);
> +       put_device(con_dev);
>         put_device(par_dev);
>         return ret;
>  }

Reviewed-by: Saravana Kannan <saravanak@google.com>

Thanks,
Saravana

>
> ---
> base-commit: 09fbf3d502050282bf47ab3babe1d4ed54dd1fd8
> change-id: 20250212-fix__fw_devlink_relax_cycles_missing_device_put-37cae=
5f4aac0
>
> Best regards,
> --
> Luca Ceresoli <luca.ceresoli@bootlin.com>
>

